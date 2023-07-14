Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D1753263
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 08:59:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2Mlj29zKz3c2k
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 16:59:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2MlW5rTLz3bv2
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 16:59:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnKotCL_1689317931;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnKotCL_1689317931)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 14:58:52 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 REBASED] erofs-utils: introduce tarerofs
Date: Fri, 14 Jul 2023 14:58:51 +0800
Message-Id: <20230714065851.70583-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Let's try to add a new mode "tarerofs" for mkfs.erofs.

It mainly aims at two use cases:
 - Convert a tarball (or later tarballs with a merged view) into
   a full EROFS image [--tar=f];

 - Generate an EROFS manifest image to reuse tar data [--tar=i],
   which also enables EROFS 512-byte blocks.

The second use case is mainly prepared for OCI direct mount without
OCI blob unpacking.  This also adds another `--aufs` option to
transform aufs special files into overlayfs metadata.

[ Note that `--tar=f` generates lots of temporary files for now which
  can impact performance since the original tar stream(s) may be
  non-seekable. ]

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes:
- rebase to origin/dev branch
- remove commented code lines in tarerofs_parse_tar()
---
 configure.ac              |   1 +
 include/erofs/blobchunk.h |   4 +-
 include/erofs/inode.h     |  12 +
 include/erofs/internal.h  |   7 +-
 include/erofs/tar.h       |  29 ++
 include/erofs/xattr.h     |   4 +
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |  47 ++-
 lib/inode.c               | 194 ++++++---
 lib/tar.c                 | 807 ++++++++++++++++++++++++++++++++++++++
 lib/xattr.c               |  46 ++-
 mkfs/main.c               | 134 +++++--
 12 files changed, 1182 insertions(+), 106 deletions(-)
 create mode 100644 include/erofs/tar.h
 create mode 100644 lib/tar.c

diff --git a/configure.ac b/configure.ac
index 54608fb..886d403 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,6 +167,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	fcntl.h
 	getopt.h
 	inttypes.h
+	linux/aufs_type.h
 	linux/falloc.h
 	linux/fs.h
 	linux/types.h
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index 49cb7bf..4269d82 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -14,8 +14,10 @@ extern "C"
 
 #include "erofs/internal.h"
 
+struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
+			unsigned int device_id, erofs_blk_t blkaddr);
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
-int erofs_blob_write_chunked_file(struct erofs_inode *inode);
+int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd);
 int erofs_blob_remap(void);
 void erofs_blob_exit(void);
 int erofs_blob_init(const char *blobfile_path);
diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 058a235..e8a5670 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -15,11 +15,23 @@ extern "C"
 
 #include "erofs/internal.h"
 
+static inline struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
+{
+	++inode->i_count;
+	return inode;
+}
+
+u32 erofs_new_encode_dev(dev_t dev);
 unsigned char erofs_mode_to_ftype(umode_t mode);
 unsigned char erofs_ftype_to_dtype(unsigned int filetype);
 void erofs_inode_manager_init(void);
 unsigned int erofs_iput(struct erofs_inode *inode);
 erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
+struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
+				   const char *name);
+int tarerofs_dump_tree(struct erofs_inode *dir);
+int erofs_init_empty_dir(struct erofs_inode *dir);
+struct erofs_inode *erofs_new_inode(void);
 struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path);
 struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index aad2115..46690f5 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -20,6 +20,7 @@ typedef unsigned short umode_t;
 #include "erofs_fs.h"
 #include <fcntl.h>
 #include <sys/types.h> /* for off_t definition */
+#include <stdio.h>
 
 #ifndef PATH_MAX
 #define PATH_MAX        4096    /* # chars in a path name including nul */
@@ -170,13 +171,17 @@ struct erofs_inode {
 	} u;
 
 	char *i_srcpath;
-
+	union {
+		char *i_link;
+		FILE *i_tmpfile;
+	};
 	unsigned char datalayout;
 	unsigned char inode_isize;
 	/* inline tail-end packing size */
 	unsigned short idata_size;
 	bool compressed_idata;
 	bool lazy_tailblock;
+	bool with_tmpfile;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
new file mode 100644
index 0000000..268c57b
--- /dev/null
+++ b/include/erofs/tar.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_TAR_H
+#define __EROFS_TAR_H
+
+#include <sys/stat.h>
+
+struct erofs_pax_header {
+	struct stat st;
+	bool use_mtime;
+	bool use_size;
+	bool use_uid;
+	bool use_gid;
+	char *path, *link;
+};
+
+struct erofs_tarfile {
+	struct erofs_pax_header global;
+
+	int fd;
+	u64 offset;
+	bool index_mode, aufs;
+};
+
+int tarerofs_init_empty_dir(struct erofs_inode *inode);
+int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
+int tarerofs_reserve_devtable(unsigned int devices);
+int tarerofs_write_devtable(struct erofs_tarfile *tar);
+
+#endif
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 14fc081..27e14bf 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -72,6 +72,7 @@ static inline unsigned int xattrblock_offset(unsigned int xattr_id)
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
 
+int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
@@ -80,6 +81,9 @@ int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_write_name_prefixes(FILE *f);
 
+int erofs_setxattr(struct erofs_inode *inode, char *key,
+		   const void *value, size_t size);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index e243c1c..249862d 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -19,6 +19,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/io.h \
       $(top_srcdir)/include/erofs/list.h \
       $(top_srcdir)/include/erofs/print.h \
+      $(top_srcdir)/include/erofs/tar.h \
       $(top_srcdir)/include/erofs/trace.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
@@ -29,7 +30,7 @@ noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
-		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c
+		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 6fbc15b..1d91a67 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -14,7 +14,10 @@
 #include <unistd.h>
 
 struct erofs_blobchunk {
-	struct hashmap_entry ent;
+	union {
+		struct hashmap_entry ent;
+		struct list_head list;
+	};
 	char		sha256[32];
 	unsigned int	device_id;
 	erofs_off_t	chunksize;
@@ -29,6 +32,23 @@ static struct erofs_buffer_head *bh_devt;
 struct erofs_blobchunk erofs_holechunk = {
 	.blkaddr = EROFS_NULL_ADDR,
 };
+static LIST_HEAD(unhashed_blobchunks);
+
+struct erofs_blobchunk *erofs_get_unhashed_chunk(erofs_off_t chunksize,
+		unsigned int device_id, erofs_blk_t blkaddr)
+{
+	struct erofs_blobchunk *chunk;
+
+	chunk = calloc(1, sizeof(struct erofs_blobchunk));
+	if (!chunk)
+		return ERR_PTR(-ENOMEM);
+
+	chunk->chunksize = chunksize;
+	chunk->device_id = device_id;
+	chunk->blkaddr = blkaddr;
+	list_add_tail(&chunk->list, &unhashed_blobchunks);
+	return chunk;
+}
 
 static struct erofs_blobchunk *erofs_blob_getchunk(int fd,
 		erofs_off_t chunksize)
@@ -165,17 +185,14 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	return dev_write(inode->chunkindexes, off, inode->extent_isize);
 }
 
-int erofs_blob_write_chunked_file(struct erofs_inode *inode)
+int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 {
 	unsigned int chunkbits = cfg.c_chunkbits;
 	unsigned int count, unit;
 	struct erofs_inode_chunk_index *idx;
 	erofs_off_t pos, len, chunksize;
-	int fd, ret;
+	int ret;
 
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0)
-		return -errno;
 #ifdef SEEK_DATA
 	/* if the file is fully sparsed, use one big chunk instead */
 	if (lseek(fd, 0, SEEK_DATA) < 0 && errno == ENXIO) {
@@ -199,10 +216,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 
 	inode->extent_isize = count * unit;
 	idx = malloc(count * max(sizeof(*idx), sizeof(void *)));
-	if (!idx) {
-		close(fd);
+	if (!idx)
 		return -ENOMEM;
-	}
 	inode->chunkindexes = idx;
 
 	for (pos = 0; pos < inode->i_size; pos += len) {
@@ -241,10 +256,8 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode)
 		*(void **)idx++ = chunk;
 	}
 	inode->datalayout = EROFS_INODE_CHUNK_BASED;
-	close(fd);
 	return 0;
 err:
-	close(fd);
 	free(inode->chunkindexes);
 	inode->chunkindexes = NULL;
 	return ret;
@@ -296,19 +309,23 @@ void erofs_blob_exit(void)
 {
 	struct hashmap_iter iter;
 	struct hashmap_entry *e;
+	struct erofs_blobchunk *bc, *n;
 
 	if (blobfile)
 		fclose(blobfile);
 
 	while ((e = hashmap_iter_first(&blob_hashmap, &iter))) {
-		struct erofs_blobchunk *bc =
-			container_of((struct hashmap_entry *)e,
-				     struct erofs_blobchunk, ent);
-
+		bc = container_of((struct hashmap_entry *)e,
+				  struct erofs_blobchunk, ent);
 		DBG_BUGON(hashmap_remove(&blob_hashmap, e) != e);
 		free(bc);
 	}
 	DBG_BUGON(hashmap_free(&blob_hashmap));
+
+	list_for_each_entry_safe(bc, n, &unhashed_blobchunks, list) {
+		list_del(&bc->list);
+		free(bc);
+	}
 }
 
 int erofs_blob_init(const char *blobfile_path)
diff --git a/lib/inode.c b/lib/inode.c
index f1401d0..0d14441 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -75,12 +75,6 @@ void erofs_inode_manager_init(void)
 		init_list_head(&inode_hashtable[i]);
 }
 
-static struct erofs_inode *erofs_igrab(struct erofs_inode *inode)
-{
-	++inode->i_count;
-	return inode;
-}
-
 /* get the inode from the (source) inode # */
 struct erofs_inode *erofs_iget(dev_t dev, ino_t ino)
 {
@@ -121,6 +115,10 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	list_del(&inode->i_hash);
 	if (inode->i_srcpath)
 		free(inode->i_srcpath);
+	if (inode->with_tmpfile)
+		fclose(inode->i_tmpfile);
+	else if (inode->i_link)
+		free(inode->i_link);
 	free(inode);
 	return 0;
 }
@@ -180,27 +178,13 @@ static int comp_subdir(const void *a, const void *b)
 	return strcmp(da->name, db->name);
 }
 
-int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
+static int erofs_prepare_dir_layout(struct erofs_inode *dir,
+				    unsigned int nr_subdirs)
 {
 	struct erofs_dentry *d, *n, **sorted_d;
-	unsigned int d_size, i;
-
-	/* dot is pointed to the current dir inode */
-	d = erofs_d_alloc(dir, ".");
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	d->inode = erofs_igrab(dir);
-	d->type = EROFS_FT_DIR;
-
-	/* dotdot is pointed to the parent dir */
-	d = erofs_d_alloc(dir, "..");
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	d->inode = erofs_igrab(dir->i_parent);
-	d->type = EROFS_FT_DIR;
+	unsigned int i;
+	unsigned int d_size = 0;
 
-	/* sort subdirs */
-	nr_subdirs += 2;
 	sorted_d = malloc(nr_subdirs * sizeof(d));
 	if (!sorted_d)
 		return -ENOMEM;
@@ -216,7 +200,6 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 	free(sorted_d);
 
 	/* let's calculate dir size */
-	d_size = 0;
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
 		int len = strlen(d->name) + sizeof(struct erofs_dirent);
 
@@ -234,6 +217,39 @@ int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
 	return 0;
 }
 
+int erofs_init_empty_dir(struct erofs_inode *dir)
+{
+	struct erofs_dentry *d;
+
+	/* dot is pointed to the current dir inode */
+	d = erofs_d_alloc(dir, ".");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	d->inode = erofs_igrab(dir);
+	d->type = EROFS_FT_DIR;
+
+	/* dotdot is pointed to the parent dir */
+	d = erofs_d_alloc(dir, "..");
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+	d->inode = erofs_igrab(dir->i_parent);
+	d->type = EROFS_FT_DIR;
+	return 0;
+}
+
+int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
+{
+	int ret;
+
+	ret = erofs_init_empty_dir(dir);
+	if (ret)
+		return ret;
+
+	/* sort subdirs */
+	nr_subdirs += 2;
+	return erofs_prepare_dir_layout(dir, nr_subdirs);
+}
+
 static void fill_dirblock(char *buf, unsigned int size, unsigned int q,
 			  struct erofs_dentry *head, struct erofs_dentry *end)
 {
@@ -347,7 +363,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	return 0;
 }
 
-static int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
+int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 {
 	const unsigned int nblocks = erofs_blknr(inode->i_size);
 	int ret;
@@ -424,14 +440,12 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-static int erofs_write_file(struct erofs_inode *inode)
+int erofs_write_file(struct erofs_inode *inode, int fd)
 {
-	int ret, fd;
+	int ret;
 
-	if (!inode->i_size) {
-		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+	if (!inode->i_size)
 		return 0;
-	}
 
 	if (cfg.c_chunkbits) {
 		inode->u.chunkbits = cfg.c_chunkbits;
@@ -439,28 +453,21 @@ static int erofs_write_file(struct erofs_inode *inode)
 		inode->u.chunkformat = 0;
 		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-		return erofs_blob_write_chunked_file(inode);
+		return erofs_blob_write_chunked_file(inode, fd);
 	}
 
 	if (cfg.c_compr_alg[0] && erofs_file_is_compressible(inode)) {
-		fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-		if (fd < 0)
-			return -errno;
 		ret = erofs_write_compressed_file(inode, fd);
-		close(fd);
-
 		if (!ret || ret != -ENOSPC)
 			return ret;
+
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret < 0)
+			return -errno;
 	}
 
 	/* fallback to all data uncompressed */
-	fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
-	if (fd < 0)
-		return -errno;
-
-	ret = write_uncompressed_file_from_fd(inode, fd);
-	close(fd);
-	return ret;
+	return write_uncompressed_file_from_fd(inode, fd);
 }
 
 static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
@@ -821,7 +828,7 @@ static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
 	return false;
 }
 
-static u32 erofs_new_encode_dev(dev_t dev)
+u32 erofs_new_encode_dev(dev_t dev)
 {
 	const unsigned int major = major(dev);
 	const unsigned int minor = minor(dev);
@@ -963,7 +970,7 @@ static int erofs_fill_inode(struct erofs_inode *inode, struct stat *st,
 	return 0;
 }
 
-static struct erofs_inode *erofs_new_inode(void)
+struct erofs_inode *erofs_new_inode(void)
 {
 	struct erofs_inode *inode;
 
@@ -973,7 +980,9 @@ static struct erofs_inode *erofs_new_inode(void)
 
 	inode->i_ino[0] = sbi.inos++;	/* inode serial number */
 	inode->i_count = 1;
+	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 
+	init_list_head(&inode->i_hash);
 	init_list_head(&inode->i_subdirs);
 	init_list_head(&inode->i_xattrs);
 	return inode;
@@ -1043,6 +1052,10 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 	struct erofs_dentry *d;
 	unsigned int nr_subdirs, i_nlink;
 
+	ret = erofs_scan_file_xattrs(dir);
+	if (ret < 0)
+		return ret;
+
 	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
 		return ret;
@@ -1060,8 +1073,15 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 			}
 			ret = erofs_write_file_from_buffer(dir, symlink);
 			free(symlink);
+		} else if (dir->i_size) {
+			int fd = open(dir->i_srcpath, O_RDONLY | O_BINARY);
+			if (fd < 0)
+				return -errno;
+
+			ret = erofs_write_file(dir, fd);
+			close(fd);
 		} else {
-			ret = erofs_write_file(dir);
+			ret = 0;
 		}
 		if (ret)
 			return ret;
@@ -1284,3 +1304,83 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	erofs_write_tail_end(inode);
 	return inode;
 }
+
+int tarerofs_dump_tree(struct erofs_inode *dir)
+{
+	struct erofs_dentry *d;
+	unsigned int nr_subdirs;
+	int ret;
+
+	if (erofs_should_use_inode_extended(dir)) {
+		if (cfg.c_force_inodeversion == FORCE_INODE_COMPACT) {
+			erofs_err("file %s cannot be in compact form",
+				  dir->i_srcpath);
+			return -EINVAL;
+		}
+		dir->inode_isize = sizeof(struct erofs_inode_extended);
+	} else {
+		dir->inode_isize = sizeof(struct erofs_inode_compact);
+	}
+
+	ret = erofs_prepare_xattr_ibody(dir);
+	if (ret < 0)
+		return ret;
+
+	if (!S_ISDIR(dir->i_mode)) {
+		if (dir->bh)
+			return 0;
+		if (S_ISLNK(dir->i_mode)) {
+			ret = erofs_write_file_from_buffer(dir, dir->i_link);
+			free(dir->i_link);
+			dir->i_link = NULL;
+		} else if (dir->i_tmpfile) {
+			ret = erofs_write_file(dir, fileno(dir->i_tmpfile));
+			fclose(dir->i_tmpfile);
+			dir->i_tmpfile = NULL;
+			dir->with_tmpfile = false;
+		} else {
+			ret = 0;
+		}
+		if (ret)
+			return ret;
+		ret = erofs_prepare_inode_buffer(dir);
+		if (ret)
+			return ret;
+		erofs_write_tail_end(dir);
+		return 0;
+	}
+
+	nr_subdirs = 0;
+	list_for_each_entry(d, &dir->i_subdirs, d_child)
+		++nr_subdirs;
+
+	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
+	if (ret)
+		return ret;
+
+	ret = erofs_prepare_inode_buffer(dir);
+	if (ret)
+		return ret;
+	dir->bh->op = &erofs_skip_write_bhops;
+
+	if (IS_ROOT(dir))
+		erofs_fixup_meta_blkaddr(dir);
+
+	list_for_each_entry(d, &dir->i_subdirs, d_child) {
+		struct erofs_inode *inode;
+
+		if (is_dot_dotdot(d->name))
+			continue;
+
+		inode = erofs_igrab(d->inode);
+		ret = tarerofs_dump_tree(inode);
+		dir->i_nlink += (erofs_mode_to_ftype(inode->i_mode) == EROFS_FT_DIR);
+		erofs_iput(inode);
+		if (ret)
+			return ret;
+	}
+	erofs_write_dir_file(dir);
+	erofs_write_tail_end(dir);
+	dir->bh->op = &erofs_write_inode_bhops;
+	return 0;
+}
diff --git a/lib/tar.c b/lib/tar.c
new file mode 100644
index 0000000..ef45183
--- /dev/null
+++ b/lib/tar.c
@@ -0,0 +1,807 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#ifdef HAVE_LINUX_AUFS_TYPE_H
+#include <linux/aufs_type.h>
+#else
+#define AUFS_WH_PFX		".wh."
+#define AUFS_DIROPQ_NAME	AUFS_WH_PFX ".opq"
+#define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
+#endif
+#include "erofs/print.h"
+#include "erofs/cache.h"
+#include "erofs/inode.h"
+#include "erofs/list.h"
+#include "erofs/tar.h"
+#include "erofs/io.h"
+#include "erofs/xattr.h"
+#include "erofs/blobchunk.h"
+
+#define OVL_XATTR_NAMESPACE "overlay."
+#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
+#define OVL_XATTR_OPAQUE_POSTFIX "opaque"
+#define OVL_XATTR_OPAQUE OVL_XATTR_TRUSTED_PREFIX OVL_XATTR_OPAQUE_POSTFIX
+
+#define EROFS_WHITEOUT_DEV	0
+
+static char erofs_libbuf[16384];
+
+struct tar_header {
+	char name[100];		/*   0-99 */
+	char mode[8];		/* 100-107 */
+	char uid[8];		/* 108-115 */
+	char gid[8];		/* 116-123 */
+	char size[12];		/* 124-135 */
+	char mtime[12];		/* 136-147 */
+	char chksum[8];		/* 148-155 */
+	char typeflag;		/* 156-156 */
+	char linkname[100];	/* 157-256 */
+	char magic[6];		/* 257-262 */
+	char version[2];	/* 263-264 */
+	char uname[32];		/* 265-296 */
+	char gname[32];		/* 297-328 */
+	char devmajor[8];	/* 329-336 */
+	char devminor[8];	/* 337-344 */
+	char prefix[155];	/* 345-499 */
+	char padding[12];	/* 500-512 (pad to exactly the 512 byte) */
+};
+
+s64 erofs_read_from_fd(int fd, void *buf, u64 bytes)
+{
+	s64 i = 0;
+
+	while (bytes) {
+		int len = bytes > INT_MAX ? INT_MAX : bytes;
+		int ret;
+
+		ret = read(fd, buf + i, len);
+		if (ret < 1) {
+			if (ret == 0) {
+				break;
+			} else if (errno != EINTR) {
+				erofs_err("failed to read : %s\n",
+					  strerror(errno));
+				return -errno;
+			}
+		}
+		bytes -= ret;
+		i += ret;
+        }
+        return i;
+}
+
+/*
+ * skip this many bytes of input. Return 0 for success, >0 means this much
+ * left after input skipped.
+ */
+u64 erofs_lskip(int fd, u64 sz)
+{
+	s64 cur = lseek(fd, 0, SEEK_CUR);
+
+	if (cur >= 0) {
+		s64 end = lseek(fd, 0, SEEK_END) - cur;
+
+		if (end > 0 && end < sz)
+			return sz - end;
+
+		end = cur + sz;
+		if (end == lseek(fd, end, SEEK_SET))
+			return 0;
+	}
+
+	while (sz) {
+		int try = min_t(u64, sz, sizeof(erofs_libbuf));
+		int or;
+
+		or = read(fd, erofs_libbuf, try);
+		if (or <= 0)
+			break;
+		else
+			sz -= or;
+	}
+	return sz;
+}
+
+static long long tarerofs_otoi(const char *ptr, int len)
+{
+	char inp[32];
+	char *endp = inp;
+	long long val;
+
+	memcpy(inp, ptr, len);
+	inp[len] = '\0';
+
+	errno = 0;
+	val = strtol(ptr, &endp, 8);
+	if ((!val && endp == inp) |
+	     (*endp && *endp != ' '))
+		errno = -EINVAL;
+	return val;
+}
+
+static long long tarerofs_parsenum(const char *ptr, int len)
+{
+	/*
+	 * For fields containing numbers or timestamps that are out of range
+	 * for the basic format, the GNU format uses a base-256 representation
+	 * instead of an ASCII octal number.
+	 */
+	if (*(char *)ptr == '\200') {
+		long long res = 0;
+
+		while (--len)
+			res = (res << 8) + (u8)*(++ptr);
+		return res;
+	}
+	return tarerofs_otoi(ptr, len);
+}
+
+int tarerofs_init_empty_dir(struct erofs_inode *inode)
+{
+	int ret = erofs_init_empty_dir(inode);
+
+	if (ret)
+		return ret;
+	inode->i_nlink = 2;
+	return 0;
+}
+
+static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *s)
+{
+	struct erofs_inode *inode;
+	struct erofs_dentry *d;
+
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	inode->i_mode = S_IFDIR | 0755;
+	inode->i_parent = dir;
+	inode->i_uid = getuid();
+	inode->i_gid = getgid();
+	inode->i_mtime = sbi.build_time;
+	inode->i_mtime_nsec = sbi.build_time_nsec;
+	tarerofs_init_empty_dir(inode);
+
+	d = erofs_d_alloc(dir, s);
+	if (!IS_ERR(d)) {
+		d->type = EROFS_FT_DIR;
+		d->inode = inode;
+	}
+	return d;
+}
+
+static struct erofs_dentry *tarerofs_get_dentry(struct erofs_inode *pwd, char *path,
+					        bool aufs, bool *whout, bool *opq)
+{
+	struct erofs_dentry *d = NULL;
+	unsigned int len = strlen(path);
+	char *s = path;
+
+	*whout = false;
+	*opq = false;
+
+	while (s < path + len) {
+		char *slash = memchr(s, '/', path + len - s);
+		if (slash) {
+			if (s == slash) {
+				while (*++s == '/');	/* skip '//...' */
+				continue;
+			}
+			*slash = '\0';
+		}
+
+		if (!memcmp(s, ".", 2)) {
+			/* null */
+		} else if (!memcmp(s, "..", 3)) {
+			pwd = pwd->i_parent;
+		} else {
+			struct erofs_inode *inode = NULL;
+
+			if (aufs && !slash) {
+				if (!memcmp(s, AUFS_WH_DIROPQ, sizeof(AUFS_WH_DIROPQ))) {
+					*opq = true;
+					break;
+				}
+				if (!memcmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
+					s += sizeof(AUFS_WH_PFX) - 1;
+					*whout = true;
+				}
+			}
+
+			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
+				if (!strcmp(d->name, s)) {
+					if (d->type != EROFS_FT_DIR && slash)
+						return ERR_PTR(-EIO);
+					inode = d->inode;
+					break;
+				}
+			}
+
+			if (inode) {
+				pwd = inode;
+			} else if (!slash) {
+				d = erofs_d_alloc(pwd, s);
+				if (IS_ERR(d))
+					return d;
+				d->type = EROFS_FT_UNKNOWN;
+				d->inode = pwd;
+			} else {
+				d = tarerofs_mkdir(pwd, s);
+				if (IS_ERR(d))
+					return d;
+				pwd = d->inode;
+			}
+		}
+		if (slash) {
+			*slash = '/';
+			s = slash + 1;
+		} else {
+			break;
+		}
+	}
+	return d;
+}
+
+int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
+{
+	char *buf, *p;
+	int ret;
+
+	buf = malloc(size);
+	if (!buf)
+		return -ENOMEM;
+	p = buf;
+
+	ret = erofs_read_from_fd(fd, buf, size);
+	if (ret != size)
+		goto out;
+
+	while (p < buf + size) {
+		char *kv, *value;
+		int len, n;
+		/* extended records are of the format: "LEN NAME=VALUE\n" */
+		ret = sscanf(p, "%d %n", &len, &n);
+		if (ret < 1 || len <= n || len > buf + size - p) {
+			ret = -EIO;
+			goto out;
+		}
+		kv = p + n;
+		p += len;
+
+		if (p[-1] != '\n') {
+			ret = -EIO;
+			goto out;
+		}
+		p[-1] = '\0';
+
+		value = memchr(kv, '=', p - kv);
+		if (!value) {
+			ret = -EIO;
+			goto out;
+		} else {
+			long long lln;
+
+			value++;
+
+			if (!strncmp(kv, "path=", sizeof("path=") - 1)) {
+				int j = p - 1 - value;
+				free(eh->path);
+				eh->path = strdup(value);
+				while (eh->path[j - 1] == '/')
+					eh->path[--j] = '\0';
+			} else if (!strncmp(kv, "linkpath=",
+					sizeof("linkpath=") - 1)) {
+				free(eh->link);
+				eh->link = strdup(value);
+			} else if (!strncmp(kv, "mtime=",
+					sizeof("mtime=") - 1)) {
+				ret = sscanf(value, "%lld %n", &lln, &n);
+				if(ret < 1) {
+					ret = -EIO;
+					goto out;
+				}
+				eh->st.st_mtime = lln;
+				if (value[n] == '.') {
+					ret = sscanf(value + n + 1, "%d", &n);
+					if (ret < 1) {
+						ret = -EIO;
+						goto out;
+					}
+#if ST_MTIM_NSEC
+					ST_MTIM_NSEC(&eh->st) = n;
+#endif
+				}
+				eh->use_mtime = true;
+			} else if (!strncmp(kv, "size=",
+					sizeof("size=") - 1)) {
+				ret = sscanf(value, "%lld %n", &lln, &n);
+				if(ret < 1 || value[n] != '\0') {
+					ret = -EIO;
+					goto out;
+				}
+				eh->st.st_size = lln;
+				eh->use_size = true;
+			} else if (!strncmp(kv, "uid=", sizeof("uid=") - 1)) {
+				ret = sscanf(value, "%lld %n", &lln, &n);
+				if(ret < 1 || value[n] != '\0') {
+					ret = -EIO;
+					goto out;
+				}
+				eh->st.st_uid = lln;
+				eh->use_uid = true;
+			} else if (!strncmp(kv, "gid=", sizeof("gid=") - 1)) {
+				ret = sscanf(value, "%lld %n", &lln, &n);
+				if(ret < 1 || value[n] != '\0') {
+					ret = -EIO;
+					goto out;
+				}
+				eh->st.st_gid = lln;
+				eh->use_gid = true;
+			} else {
+				erofs_info("unrecognized pax keyword \"%s\", ignoring", kv);
+			}
+		}
+	}
+	ret = 0;
+out:
+	free(buf);
+	return ret;
+}
+
+int tarerofs_write_chunk_indexes(struct erofs_inode *inode, erofs_blk_t blkaddr)
+{
+	unsigned int chunkbits = ilog2(inode->i_size - 1) + 1;
+	unsigned int count, unit;
+	erofs_off_t chunksize, len, pos;
+	struct erofs_inode_chunk_index *idx;
+
+	if (chunkbits < sbi.blkszbits)
+		chunkbits = sbi.blkszbits;
+	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
+	inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
+	chunksize = 1ULL << chunkbits;
+	count = DIV_ROUND_UP(inode->i_size, chunksize);
+
+	unit = sizeof(struct erofs_inode_chunk_index);
+	inode->extent_isize = count * unit;
+	idx = calloc(count, max(sizeof(*idx), sizeof(void *)));
+	if (!idx)
+		return -ENOMEM;
+	inode->chunkindexes = idx;
+
+	for (pos = 0; pos < inode->i_size; pos += len) {
+		struct erofs_blobchunk *chunk;
+
+		len = min_t(erofs_off_t, inode->i_size - pos, chunksize);
+
+		chunk = erofs_get_unhashed_chunk(chunksize, 1, blkaddr);
+		if (IS_ERR(chunk))
+			return PTR_ERR(chunk);
+
+		*(void **)idx++ = chunk;
+		blkaddr += erofs_blknr(len);
+	}
+	inode->datalayout = EROFS_INODE_CHUNK_BASED;
+	return 0;
+}
+
+void tarerofs_remove_inode(struct erofs_inode *inode)
+{
+	struct erofs_dentry *d;
+
+	--inode->i_nlink;
+	if (!S_ISDIR(inode->i_mode))
+		return;
+
+	/* remove all subdirss */
+	list_for_each_entry(d, &inode->i_subdirs, d_child) {
+		if (!is_dot_dotdot(d->name))
+			tarerofs_remove_inode(d->inode);
+		erofs_iput(d->inode);
+		d->inode = NULL;
+	}
+	--inode->i_parent->i_nlink;
+}
+
+int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar)
+{
+	char path[PATH_MAX];
+	struct erofs_pax_header eh = tar->global;
+	bool e, whout, opq;
+	struct stat st;
+	erofs_off_t tar_offset, data_offset;
+
+	struct tar_header th;
+	struct erofs_dentry *d;
+	struct erofs_inode *inode;
+	unsigned int j, csum, cksum;
+	int ckksum, ret, rem;
+
+	if (eh.path)
+		eh.path = strdup(eh.path);
+	if (eh.link)
+		eh.link = strdup(eh.link);
+
+restart:
+	rem = tar->offset & 511;
+	if (rem) {
+		if (erofs_lskip(tar->fd, 512 - rem)) {
+			ret = -EIO;
+			goto out;
+		}
+		tar->offset += 512 - rem;
+	}
+
+	tar_offset = tar->offset;
+	ret = erofs_read_from_fd(tar->fd, &th, sizeof(th));
+	if (ret != sizeof(th))
+		goto out;
+	tar->offset += sizeof(th);
+	if (*th.name == '\0') {
+		if (e) {	/* end of tar 2 empty blocks */
+			ret = 1;
+			goto out;
+		}
+		e = true;	/* empty jump to next block */
+		goto restart;
+	}
+
+	if (strncmp(th.magic, "ustar", 5)) {
+		erofs_err("invalid tar magic @ %llu", tar_offset);
+		ret = -EIO;
+		goto out;
+	}
+
+	/* chksum field itself treated as ' ' */
+	csum = tarerofs_otoi(th.chksum, sizeof(th.chksum));
+	if (errno) {
+		erofs_err("invalid chksum @ %llu", tar_offset);
+		ret = -EBADMSG;
+		goto out;
+	}
+	cksum = 0;
+	for (j = 0; j < 8; ++j)
+		cksum += (unsigned int)' ';
+	ckksum = cksum;
+	for (j = 0; j < 148; ++j) {
+		cksum += (unsigned int)((u8*)&th)[j];
+		ckksum += (int)((char*)&th)[j];
+	}
+	for (j = 156; j < 500; ++j) {
+		cksum += (unsigned int)((u8*)&th)[j];
+		ckksum += (int)((char*)&th)[j];
+	}
+	if (csum != cksum && csum != ckksum) {
+		erofs_err("chksum mismatch @ %llu", tar_offset);
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	st.st_mode = tarerofs_otoi(th.mode, sizeof(th.mode));
+	if (errno)
+		goto invalid_tar;
+
+	if (eh.use_uid) {
+		st.st_uid = eh.st.st_uid;
+	} else {
+		st.st_uid = tarerofs_parsenum(th.uid, sizeof(th.uid));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (eh.use_gid) {
+		st.st_gid = eh.st.st_gid;
+	} else {
+		st.st_gid = tarerofs_parsenum(th.gid, sizeof(th.gid));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (eh.use_size) {
+		st.st_size = eh.st.st_size;
+	} else {
+		st.st_size = tarerofs_parsenum(th.size, sizeof(th.size));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (eh.use_mtime) {
+		st.st_mtime = eh.st.st_mtime;
+#if ST_MTIM_NSEC
+		ST_MTIM_NSEC(&st) = ST_MTIM_NSEC(&eh.st);
+#endif
+	} else {
+		st.st_mtime = tarerofs_parsenum(th.mtime, sizeof(th.mtime));
+		if (errno)
+			goto invalid_tar;
+	}
+
+	if (th.typeflag <= '7' && !eh.path) {
+		eh.path = path;
+		j = 0;
+		if (*th.prefix) {
+			memcpy(path, th.prefix, sizeof(th.prefix));
+			path[sizeof(th.prefix)] = '\0';
+			j = strlen(path);
+			if (path[j - 1] != '/') {
+				path[j] = '/';
+				path[++j] = '\0';
+			}
+		}
+		memcpy(path + j, th.name, sizeof(th.name));
+		path[j + sizeof(th.name)] = '\0';
+		j = strlen(path);
+		while (path[j - 1] == '/')
+			path[--j] = '\0';
+	}
+
+	data_offset = tar->offset;
+	tar->offset += st.st_size;
+	if (th.typeflag == '0' || th.typeflag == '7' || th.typeflag == '1') {
+		st.st_mode |= S_IFREG;
+	} else if (th.typeflag == '2') {
+		st.st_mode |= S_IFLNK;
+	} else if (th.typeflag == '3') {
+		st.st_mode |= S_IFCHR;
+	} else if (th.typeflag == '4') {
+		st.st_mode |= S_IFBLK;
+	} else if (th.typeflag == '5') {
+		st.st_mode |= S_IFDIR;
+	} else if (th.typeflag == '6') {
+		st.st_mode |= S_IFIFO;
+	} else if (th.typeflag == 'g') {
+		ret = tarerofs_parse_pax_header(tar->fd, &tar->global, st.st_size);
+		if (ret)
+			goto out;
+		if (tar->global.path) {
+			free(eh.path);
+			eh.path = strdup(tar->global.path);
+		}
+		if (tar->global.link) {
+			free(eh.link);
+			eh.link = strdup(tar->global.link);
+		}
+		goto restart;
+	} else if (th.typeflag == 'x') {
+		ret = tarerofs_parse_pax_header(tar->fd, &eh, st.st_size);
+		if (ret)
+			goto out;
+		goto restart;
+	} else if (th.typeflag == 'K') {
+		free(eh.link);
+		eh.link = malloc(st.st_size + 1);
+		if (st.st_size > PATH_MAX || st.st_size !=
+		    erofs_read_from_fd(tar->fd, eh.link, st.st_size))
+			goto invalid_tar;
+		eh.link[st.st_size] = '\0';
+		goto restart;
+	} else {
+		erofs_info("unrecognized typeflag %xh @ %llu - ignoring",
+			   th.typeflag, tar_offset);
+		ret = 0;
+		goto out;
+	}
+
+	if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
+		int major, minor;
+
+		major = tarerofs_parsenum(th.devmajor, sizeof(th.devmajor));
+		if (errno) {
+			erofs_err("invalid device major @ %llu", tar_offset);
+			goto out;
+		}
+
+		minor = tarerofs_parsenum(th.devminor, sizeof(th.devminor));
+		if (errno) {
+			erofs_err("invalid device minor @ %llu", tar_offset);
+			goto out;
+		}
+		st.st_rdev = (major << 8) | (minor & 0xff) | ((minor & ~0xff) << 12);
+
+	} else if (th.typeflag == '1' || th.typeflag == '2') {
+		if (!eh.link)
+			eh.link = strndup(th.linkname, sizeof(th.linkname));
+	}
+
+	if (tar->index_mode && erofs_blkoff(tar_offset + sizeof(th))) {
+		erofs_err("invalid tar data alignment @ %llu", tar_offset);
+		ret = -EIO;
+		goto out;
+	}
+
+	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
+
+	d = tarerofs_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
+	if (IS_ERR(d)) {
+		ret = PTR_ERR(d);
+		goto out;
+	}
+
+	if (!d) {
+		/* some tarballs include '.' which indicates the root directory */
+		if (!S_ISDIR(st.st_mode)) {
+			ret = -ENOTDIR;
+			goto out;
+		}
+		inode = root;
+	} else if (opq) {
+		DBG_BUGON(d->type == EROFS_FT_UNKNOWN);
+		DBG_BUGON(!d->inode);
+		ret = erofs_setxattr(d->inode, OVL_XATTR_OPAQUE, "y", 1);
+		goto out;
+	} else if (th.typeflag == '1') {	/* hard link cases */
+		struct erofs_dentry *d2;
+		bool dumb;
+
+		if (S_ISDIR(st.st_mode)) {
+			ret = -EISDIR;
+			goto out;
+		}
+
+		if (d->type != EROFS_FT_UNKNOWN) {
+			tarerofs_remove_inode(d->inode);
+			erofs_iput(d->inode);
+		}
+		d->inode = NULL;
+
+		d2 = tarerofs_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
+		if (IS_ERR(d2)) {
+			ret = PTR_ERR(d2);
+			goto out;
+		}
+		if (d2->type == EROFS_FT_UNKNOWN) {
+			ret = -ENOENT;
+			goto out;
+		}
+		if (S_ISDIR(d2->inode->i_mode)) {
+			ret = -EISDIR;
+			goto out;
+		}
+		inode = erofs_igrab(d2->inode);
+		d->inode = inode;
+		d->type = d2->type;
+		++inode->i_nlink;
+		ret = 0;
+		goto out;
+	} else if (d->type != EROFS_FT_UNKNOWN) {
+		if (d->type != EROFS_FT_DIR || !S_ISDIR(st.st_mode)) {
+			struct erofs_inode *parent = d->inode->i_parent;
+
+			tarerofs_remove_inode(d->inode);
+			erofs_iput(d->inode);
+			d->inode = parent;
+			goto new_inode;
+		}
+		inode = d->inode;
+	} else {
+new_inode:
+		inode = erofs_new_inode();
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			goto out;
+		}
+		inode->i_parent = d->inode;
+		d->inode = inode;
+		d->type = erofs_mode_to_ftype(st.st_mode);
+	}
+
+	if (whout) {
+		inode->i_mode = (inode->i_mode & ~S_IFMT) | S_IFCHR;
+		inode->u.i_rdev = EROFS_WHITEOUT_DEV;
+	} else {
+		inode->i_mode = st.st_mode;
+		if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode))
+			inode->u.i_rdev = erofs_new_encode_dev(st.st_rdev);
+	}
+	inode->i_srcpath = strdup(eh.path);
+	inode->i_uid = st.st_uid;
+	inode->i_gid = st.st_gid;
+	inode->i_size = st.st_size;
+	inode->i_mtime = st.st_mtime;
+
+	if (!S_ISDIR(inode->i_mode)) {
+		if (S_ISLNK(inode->i_mode)) {
+			inode->i_size = strlen(eh.link);
+			inode->i_link = malloc(inode->i_size + 1);
+			memcpy(inode->i_link, eh.link, inode->i_size + 1);
+		} else if (tar->index_mode) {
+			ret = tarerofs_write_chunk_indexes(inode,
+					erofs_blknr(data_offset));
+			if (ret)
+				goto out;
+			if (erofs_lskip(tar->fd, inode->i_size)) {
+				erofs_iput(inode);
+				ret = -EIO;
+				goto out;
+			}
+		} else {
+			char buf[65536];
+
+			if (!inode->i_tmpfile) {
+				inode->i_tmpfile = tmpfile();
+
+				if (!inode->i_tmpfile) {
+					erofs_iput(inode);
+					ret = -ENOSPC;
+					goto out;
+				}
+			}
+
+			for (j = inode->i_size; j; ) {
+				rem = min_t(int, sizeof(buf), j);
+
+				if (erofs_read_from_fd(tar->fd, buf, rem) != rem ||
+				    fwrite(buf, rem, 1, inode->i_tmpfile) != 1) {
+					erofs_iput(inode);
+					ret = -EIO;
+					goto out;
+				}
+				j -= rem;
+			}
+			fseek(inode->i_tmpfile, 0, SEEK_SET);
+			inode->with_tmpfile = true;
+		}
+		inode->i_nlink++;
+		ret = 0;
+	} else if (!inode->i_nlink)
+		ret = tarerofs_init_empty_dir(inode);
+	else
+		ret = 0;
+out:
+	if (eh.path != path)
+		free(eh.path);
+	free(eh.link);
+	return ret;
+
+invalid_tar:
+	erofs_err("invalid tar @ %llu", tar_offset);
+	ret = -EIO;
+	goto out;
+}
+
+static struct erofs_buffer_head *bh_devt;
+
+int tarerofs_reserve_devtable(unsigned int devices)
+{
+	if (!devices)
+		return 0;
+
+	bh_devt = erofs_balloc(DEVT,
+		sizeof(struct erofs_deviceslot) * devices, 0, 0);
+	if (IS_ERR(bh_devt))
+		return PTR_ERR(bh_devt);
+
+	erofs_mapbh(bh_devt->block);
+	bh_devt->op = &erofs_skip_write_bhops;
+	sbi.devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi.extra_devices = devices;
+	erofs_sb_set_device_table();
+	return 0;
+}
+
+int tarerofs_write_devtable(struct erofs_tarfile *tar)
+{
+	erofs_off_t pos_out;
+	unsigned int i;
+
+	if (!sbi.extra_devices)
+		return 0;
+	pos_out = erofs_btell(bh_devt, false);
+	for (i = 0; i < sbi.extra_devices; ++i) {
+		struct erofs_deviceslot dis = {
+			.blocks = erofs_blknr(tar->offset),
+		};
+		int ret;
+
+		ret = dev_write(&dis, pos_out, sizeof(dis));
+		if (ret)
+			return ret;
+		pos_out += sizeof(dis);
+	}
+	bh_devt->op = &erofs_drop_directly_bhops;
+	erofs_bdrop(bh_devt, false);
+	return 0;
+}
diff --git a/lib/xattr.c b/lib/xattr.c
index 7d7dc54..87a95c7 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -403,6 +403,38 @@ err:
 	return ret;
 }
 
+int erofs_setxattr(struct erofs_inode *inode, char *key,
+		   const void *value, size_t size)
+{
+	char *kvbuf;
+	unsigned int len[2];
+	struct xattr_item *item;
+	u8 prefix;
+	u16 prefixlen;
+
+	if (!match_prefix(key, &prefix, &prefixlen))
+		return -ENODATA;
+
+	len[1] = size;
+	/* allocate key-value buffer */
+	len[0] = strlen(key) - prefixlen;
+
+	kvbuf = malloc(len[0] + len[1]);
+	if (!kvbuf)
+		return -ENOMEM;
+
+	memcpy(kvbuf, key + prefixlen, len[0]);
+	memcpy(kvbuf + len[0], value, size);
+
+	item = get_xattritem(prefix, kvbuf, len);
+	if (IS_ERR(item))
+		return PTR_ERR(item);
+	if (!item)
+		return 0;
+
+	return erofs_xattr_add(&inode->i_xattrs, item);
+}
+
 #ifdef WITH_ANDROID
 static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
@@ -445,10 +477,9 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 }
 #endif
 
-int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
+int erofs_scan_file_xattrs(struct erofs_inode *inode)
 {
 	int ret;
-	struct inode_xattr_node *node;
 	struct list_head *ixattrs = &inode->i_xattrs;
 
 	/* check if xattr is disabled */
@@ -459,9 +490,14 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	if (ret < 0)
 		return ret;
 
-	ret = erofs_droid_xattr_set_caps(inode);
-	if (ret < 0)
-		return ret;
+	return erofs_droid_xattr_set_caps(inode);
+}
+
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
+{
+	int ret;
+	struct inode_xattr_node *node;
+	struct list_head *ixattrs = &inode->i_xattrs;
 
 	if (list_empty(ixattrs))
 		return 0;
diff --git a/mkfs/main.c b/mkfs/main.c
index 438bab8..7369b90 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -16,6 +16,7 @@
 #include "erofs/print.h"
 #include "erofs/cache.h"
 #include "erofs/inode.h"
+#include "erofs/tar.h"
 #include "erofs/io.h"
 #include "erofs/compress.h"
 #include "erofs/dedupe.h"
@@ -53,6 +54,8 @@ static struct option long_options[] = {
 	{"preserve-mtime", no_argument, NULL, 15},
 	{"uid-offset", required_argument, NULL, 16},
 	{"gid-offset", required_argument, NULL, 17},
+	{"tar", optional_argument, NULL, 20},
+	{"aufs", no_argument, NULL, 21},
 	{"mount-point", required_argument, NULL, 512},
 	{"xattr-prefix", required_argument, NULL, 19},
 #ifdef WITH_ANDROID
@@ -107,6 +110,8 @@ static void usage(void)
 	      " --ignore-mtime        use build time instead of strict per-file modification time\n"
 	      " --max-extent-bytes=#  set maximum decompressed extent size # in bytes\n"
 	      " --preserve-mtime      keep per-file modification time strictly\n"
+	      " --aufs                replace aufs special files with overlayfs metadata\n"
+	      " --tar=[fi]            generate an image from tarball(s)\n"
 	      " --quiet               quiet execution (do not write anything to standard output.)\n"
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
@@ -125,6 +130,8 @@ static void usage(void)
 }
 
 static unsigned int pclustersize_packed, pclustersize_max;
+static struct erofs_tarfile erofstar;
+static bool tar_mode;
 
 static int parse_extended_opts(const char *opts)
 {
@@ -475,6 +482,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_extra_ea_name_prefixes = true;
 			break;
+		case 20:
+			if (optarg && (!strcmp(optarg, "i") ||
+					!strcmp(optarg, "0")))
+				erofstar.index_mode = true;
+			tar_mode = true;
+			break;
+		case 21:
+			erofstar.aufs = true;
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -506,20 +522,24 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		return -ENOMEM;
 
 	if (optind >= argc) {
-		erofs_err("missing argument: DIRECTORY");
-		return -EINVAL;
-	}
-
-	cfg.c_src_path = realpath(argv[optind++], NULL);
-	if (!cfg.c_src_path) {
-		erofs_err("failed to parse source directory: %s",
-			  erofs_strerror(-errno));
-		return -ENOENT;
-	}
+		if (!tar_mode) {
+			erofs_err("missing argument: DIRECTORY");
+			return -EINVAL;
+		} else {
+			erofstar.fd = STDIN_FILENO;
+		}
+	}else {
+		cfg.c_src_path = realpath(argv[optind++], NULL);
+		if (!cfg.c_src_path) {
+			erofs_err("failed to parse source directory: %s",
+				  erofs_strerror(-errno));
+			return -ENOENT;
+		}
 
-	if (optind < argc) {
-		erofs_err("unexpected argument: %s\n", argv[optind]);
-		return -EINVAL;
+		if (optind < argc) {
+			erofs_err("unexpected argument: %s\n", argv[optind]);
+			return -EINVAL;
+		}
 	}
 	if (quiet) {
 		cfg.c_dbg_lvl = EROFS_ERR;
@@ -734,14 +754,24 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	err = lstat(cfg.c_src_path, &st);
-	if (err)
-		return 1;
-	if (!S_ISDIR(st.st_mode)) {
-		erofs_err("root of the filesystem is not a directory - %s",
-			  cfg.c_src_path);
-		usage();
-		return 1;
+	if (!tar_mode) {
+		err = lstat(cfg.c_src_path, &st);
+		if (err)
+			return 1;
+		if (!S_ISDIR(st.st_mode)) {
+			erofs_err("root of the filesystem is not a directory - %s",
+				  cfg.c_src_path);
+			usage();
+			return 1;
+		}
+		erofs_set_fs_root(cfg.c_src_path);
+	} else if (cfg.c_src_path) {
+		erofstar.fd = open(cfg.c_src_path, O_RDONLY);
+		if (erofstar.fd < 0) {
+			erofs_err("failed to open file: %s", cfg.c_src_path);
+			usage();
+			return 1;
+		}
 	}
 
 	if (cfg.c_unix_timestamp != -1) {
@@ -792,11 +822,13 @@ int main(int argc, char **argv)
 	}
 	if (cfg.c_dedupe)
 		erofs_warn("EXPERIMENTAL data deduplication feature in use. Use at your own risk!");
-	erofs_set_fs_root(cfg.c_src_path);
+
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
 		srand(time(NULL));
 #endif
+	if (tar_mode && erofstar.index_mode)
+		sbi.blkszbits = 9;
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
 		err = PTR_ERR(sb_bh);
@@ -852,7 +884,10 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	err = erofs_generate_devtable();
+	if (tar_mode && erofstar.index_mode)
+		err = tarerofs_reserve_devtable(1);
+	else
+		err = erofs_generate_devtable();
 	if (err) {
 		erofs_err("failed to generate device table: %s",
 			  erofs_strerror(err));
@@ -863,25 +898,52 @@ int main(int argc, char **argv)
 
 	erofs_inode_manager_init();
 
-	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
-	if (err) {
-		erofs_err("failed to build shared xattrs: %s",
-			  erofs_strerror(err));
-		goto exit;
-	}
-
-	root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
-	if (IS_ERR(root_inode)) {
-		err = PTR_ERR(root_inode);
-		goto exit;
-	}
-
 	if (cfg.c_extra_ea_name_prefixes)
 		erofs_xattr_write_name_prefixes(packedfile);
 
+	if (!tar_mode) {
+		err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
+		if (err) {
+			erofs_err("failed to build shared xattrs: %s",
+				  erofs_strerror(err));
+			goto exit;
+		}
+
+		if (cfg.c_extra_ea_name_prefixes)
+			erofs_xattr_write_name_prefixes(packedfile);
+
+		root_inode = erofs_mkfs_build_tree_from_path(cfg.c_src_path);
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
+	} else {
+		root_inode = erofs_new_inode();
+		if (IS_ERR(root_inode)) {
+			err = PTR_ERR(root_inode);
+			goto exit;
+		}
+		root_inode->i_srcpath = strdup("/");
+		root_inode->i_mode = S_IFDIR | 0777;
+		root_inode->i_parent = root_inode;
+		root_inode->i_mtime = sbi.build_time;
+		root_inode->i_mtime_nsec = sbi.build_time_nsec;
+		tarerofs_init_empty_dir(root_inode);
+
+		while (!(err = tarerofs_parse_tar(root_inode, &erofstar)));
+
+		if (err < 0)
+			goto exit;
+
+		err = tarerofs_dump_tree(root_inode);
+		if (err < 0)
+			goto exit;
+	}
 	root_nid = erofs_lookupnid(root_inode);
 	erofs_iput(root_inode);
 
+	if (tar_mode)
+		tarerofs_write_devtable(&erofstar);
 	if (cfg.c_chunkbits) {
 		erofs_info("total metadata: %u blocks", erofs_mapbh(NULL));
 		err = erofs_blob_remap();
-- 
2.19.1.6.gb485710b

