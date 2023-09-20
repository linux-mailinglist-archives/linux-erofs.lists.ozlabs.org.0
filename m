Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B07A711C
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 05:47:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZXxqIcjj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr4Gp5QkZz3c1C
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 13:47:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZXxqIcjj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr4Gg5byxz3bT8
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 13:47:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 688B2CE140D;
	Wed, 20 Sep 2023 03:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132EC433C7;
	Wed, 20 Sep 2023 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695181622;
	bh=nXH3Vcioo/F5OfEllpmWvY+nTXMrMSmjCwYL0kUpOc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXxqIcjjxDjLl7D0U30gnaChpGZ3D/cS2ev4IujjRZF38IdJDIA55A1OrKtsf8OBg
	 guevVOYfbhXtLN08YgdmQioV20m1XYoWWYf1dFpm3zdlnzsz1Yh+vl9Lm8EPGckPVi
	 QQnb8G73rurn9wERSElPwbZpWm+Y9KVW1T8T6n/+CpTv3rGN5KxhSSlk0s46aUaW9O
	 0t0mGJn/WH1zZAXlv6gGuEZ2IcZZ2MqPPpE48mEVHHMfmSpgpdE33PeKqq/NQFc+C1
	 31+GotSwHwwOmygaLXz5uCPGM9BfQ0zK6wb8KOT8//eKKEeNhuH6JOHHfo8VpKe90Z
	 Kr1BkxgVtESKA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: lib: introduce diskbuf
Date: Wed, 20 Sep 2023 11:46:55 +0800
Message-Id: <20230920034655.38381-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915152913.4124712-1-hsiangkao@linux.alibaba.com>
References: <20230915152913.4124712-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, each tar data file will be kept as a temporary file before
landing to the target image since the input stream may be non-seekable.

It's somewhat ineffective.  Let's introduce a new diskbuf approach to
manage those buffers.  Laterly, each stream can be redirected to blob
files for external reference.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fix two issues reported by Jingbo.

 include/erofs/blobchunk.h |   3 +-
 include/erofs/diskbuf.h   |  30 ++++++++
 include/erofs/internal.h  |   8 ++-
 lib/Makefile.am           |   3 +-
 lib/blobchunk.c           |   7 +-
 lib/diskbuf.c             | 146 ++++++++++++++++++++++++++++++++++++++
 lib/inode.c               |  35 +++++----
 lib/io.c                  |   1 +
 lib/tar.c                 |  21 ++++--
 mkfs/main.c               |  10 +++
 10 files changed, 236 insertions(+), 28 deletions(-)
 create mode 100644 include/erofs/diskbuf.h
 create mode 100644 lib/diskbuf.c

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index fb85d8e..89c8048 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -17,7 +17,8 @@ extern "C"
 struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 		erofs_blk_t blkaddr, erofs_off_t sourceoffset);
 int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t off);
-int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd);
+int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
+				  erofs_off_t startoff);
 int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset);
 int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
 void erofs_blob_exit(void);
diff --git a/include/erofs/diskbuf.h b/include/erofs/diskbuf.h
new file mode 100644
index 0000000..29d9fe2
--- /dev/null
+++ b/include/erofs/diskbuf.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_DISKBUF_H
+#define __EROFS_DISKBUF_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "erofs/defs.h"
+
+struct erofs_diskbuf {
+	void *sp;		/* internal stream pointer */
+	u64 offset;		/* internal offset */
+};
+
+int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *off);
+
+int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off);
+void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len);
+void erofs_diskbuf_close(struct erofs_diskbuf *db);
+
+int erofs_diskbuf_init(unsigned int nstrms);
+void erofs_diskbuf_exit(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 616cd3a..d859905 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -108,7 +108,7 @@ struct erofs_sb_info {
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
-	int devfd;
+	int devfd, devblksz;
 	u64 devsz;
 	dev_t dev;
 	unsigned int nblobs;
@@ -151,6 +151,8 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_EA_INITED	(1 << 0)
 #define EROFS_I_Z_INITED	(1 << 1)
 
+struct erofs_diskbuf;
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
@@ -190,7 +192,7 @@ struct erofs_inode {
 	char *i_srcpath;
 	union {
 		char *i_link;
-		FILE *i_tmpfile;
+		struct erofs_diskbuf *i_diskbuf;
 	};
 	unsigned char datalayout;
 	unsigned char inode_isize;
@@ -198,7 +200,7 @@ struct erofs_inode {
 	unsigned short idata_size;
 	bool compressed_idata;
 	bool lazy_tailblock;
-	bool with_tmpfile;
+	bool with_diskbuf;
 	bool opaque;
 	/* OVL: non-merge dir that may contain whiteout entries */
 	bool whiteouts;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 8a45bd6..483d410 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -9,6 +9,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/config.h \
       $(top_srcdir)/include/erofs/decompress.h \
       $(top_srcdir)/include/erofs/defs.h \
+      $(top_srcdir)/include/erofs/diskbuf.h \
       $(top_srcdir)/include/erofs/err.h \
       $(top_srcdir)/include/erofs/exclude.h \
       $(top_srcdir)/include/erofs/flex-array.h \
@@ -33,7 +34,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c xxhash.c rebuild.c
+		      block_list.c xxhash.c rebuild.c diskbuf.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a599f3a..317a279 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -223,7 +223,8 @@ out:
 	return 0;
 }
 
-int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
+int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
+				  erofs_off_t startoff)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int chunkbits = cfg.c_chunkbits;
@@ -237,7 +238,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 
 #ifdef SEEK_DATA
 	/* if the file is fully sparsed, use one big chunk instead */
-	if (lseek(fd, 0, SEEK_DATA) < 0 && errno == ENXIO) {
+	if (lseek(fd, startoff, SEEK_DATA) < 0 && errno == ENXIO) {
 		chunkbits = ilog2(inode->i_size - 1) + 1;
 		if (chunkbits < sbi->blkszbits)
 			chunkbits = sbi->blkszbits;
@@ -269,7 +270,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd)
 
 	lastch = NULL;
 	minextblks = BLK_ROUND_UP(sbi, inode->i_size);
-	for (pos = 0; pos < inode->i_size; pos += len) {
+	for (pos = startoff; pos < startoff + inode->i_size; pos += len) {
 #ifdef SEEK_DATA
 		off_t offset = lseek(fd, pos, SEEK_DATA);
 
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
new file mode 100644
index 0000000..bc14502
--- /dev/null
+++ b/lib/diskbuf.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/diskbuf.h"
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+/* A simple approach to avoid creating too many temporary files */
+static struct erofs_diskbufstrm {
+	u64 count;
+	u64 tailoffset, devpos;
+	int fd;
+	unsigned int alignsize;
+	bool locked;
+} *dbufstrm;
+
+int erofs_diskbuf_getfd(struct erofs_diskbuf *db, u64 *fpos)
+{
+	const struct erofs_diskbufstrm *strm = db->sp;
+	u64 offset;
+
+	if (!strm)
+		return -1;
+	offset = db->offset + strm->devpos;
+	if (lseek(strm->fd, offset, SEEK_SET) != offset)
+		return -E2BIG;
+	if (fpos)
+		*fpos = offset;
+	return strm->fd;
+}
+
+int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
+{
+	struct erofs_diskbufstrm *strm = dbufstrm + sid;
+
+	if (strm->tailoffset & (strm->alignsize - 1)) {
+		strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
+		if (lseek(strm->fd, strm->tailoffset + strm->devpos,
+			  SEEK_SET) != strm->tailoffset + strm->devpos)
+			return -EIO;
+	}
+	if (off)
+		*off = db->offset + strm->devpos;
+	db->offset = strm->tailoffset;
+	db->sp = strm;
+	++strm->count;
+	strm->locked = true;	/* TODO: need a real lock for MT */
+	return strm->fd;
+}
+
+void erofs_diskbuf_commit(struct erofs_diskbuf *db, u64 len)
+{
+	struct erofs_diskbufstrm *strm = db->sp;
+
+	DBG_BUGON(!strm);
+	DBG_BUGON(!strm->locked);
+	DBG_BUGON(strm->tailoffset != db->offset);
+	strm->tailoffset += len;
+}
+
+void erofs_diskbuf_close(struct erofs_diskbuf *db)
+{
+	struct erofs_diskbufstrm *strm = db->sp;
+
+	DBG_BUGON(!strm);
+	DBG_BUGON(strm->count <= 1);
+	--strm->count;
+	db->sp = NULL;
+}
+
+int erofs_tmpfile(void)
+{
+#define	TRAILER		"tmp.XXXXXXXXXX"
+	char buf[PATH_MAX];
+	int fd;
+	umode_t u;
+
+	(void)snprintf(buf, sizeof(buf), "%s/" TRAILER,
+		       getenv("TMPDIR") ?: "/tmp");
+
+	fd = mkstemp(buf);
+	if (fd < 0)
+		return -errno;
+
+	unlink(buf);
+	u = umask(0);
+	(void)umask(u);
+	(void)fchmod(fd, 0666 & ~u);
+	return fd;
+}
+
+int erofs_diskbuf_init(unsigned int nstrms)
+{
+	struct erofs_diskbufstrm *strm;
+
+	strm = calloc(nstrms + 1, sizeof(*strm));
+	if (!strm)
+		return -ENOMEM;
+	strm[nstrms].fd = -1;
+	dbufstrm = strm;
+
+	for (; strm < dbufstrm + nstrms; ++strm) {
+		struct stat st;
+
+		/* try to use the devfd for regfiles on stream 0 */
+		if (strm == dbufstrm && sbi.devsz == INT64_MAX) {
+			strm->devpos = 1ULL << 40;
+			if (!ftruncate(sbi.devfd, strm->devpos << 1)) {
+				strm->fd = dup(sbi.devfd);
+				if (lseek(strm->fd, strm->devpos,
+					  SEEK_SET) != strm->devpos)
+					return -EIO;
+				goto setupone;
+			}
+		}
+		strm->devpos = 0;
+		strm->fd = erofs_tmpfile();
+		if (strm->fd < 0)
+			return -ENOSPC;
+setupone:
+		strm->tailoffset = 0;
+		strm->count = 1;
+		if (fstat(strm->fd, &st))
+			return -errno;
+		strm->alignsize = max_t(u32, st.st_blksize, getpagesize());
+	}
+	return 0;
+}
+
+void erofs_diskbuf_exit(void)
+{
+	struct erofs_diskbufstrm *strm;
+
+	if (!dbufstrm)
+		return;
+
+	for (strm = dbufstrm; strm->fd >= 0; ++strm) {
+		DBG_BUGON(strm->count != 1);
+
+		close(strm->fd);
+		strm->fd = -1;
+	}
+}
diff --git a/lib/inode.c b/lib/inode.c
index 37aa79e..d321602 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -16,6 +16,7 @@
 #endif
 #include <dirent.h>
 #include "erofs/print.h"
+#include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
@@ -121,10 +122,12 @@ unsigned int erofs_iput(struct erofs_inode *inode)
 	list_del(&inode->i_hash);
 	if (inode->i_srcpath)
 		free(inode->i_srcpath);
-	if (inode->with_tmpfile)
-		fclose(inode->i_tmpfile);
-	else if (inode->i_link)
+	if (inode->with_diskbuf) {
+		erofs_diskbuf_close(inode->i_diskbuf);
+		free(inode->i_diskbuf);
+	} else if (inode->i_link) {
 		free(inode->i_link);
+	}
 	free(inode);
 	return 0;
 }
@@ -454,12 +457,11 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode, int fd)
+int erofs_write_file(struct erofs_inode *inode, int fd, u64 fpos)
 {
 	int ret;
 
-	if (!inode->i_size)
-		return 0;
+	DBG_BUGON(!inode->i_size);
 
 	if (cfg.c_chunkbits) {
 		inode->u.chunkbits = cfg.c_chunkbits;
@@ -467,7 +469,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd)
 		inode->u.chunkformat = 0;
 		if (cfg.c_force_chunkformat == FORCE_INODE_CHUNK_INDEXES)
 			inode->u.chunkformat = EROFS_CHUNK_FORMAT_INDEXES;
-		return erofs_blob_write_chunked_file(inode, fd);
+		return erofs_blob_write_chunked_file(inode, fd, fpos);
 	}
 
 	if (cfg.c_compr_alg[0] && erofs_file_is_compressible(inode)) {
@@ -475,7 +477,7 @@ int erofs_write_file(struct erofs_inode *inode, int fd)
 		if (!ret || ret != -ENOSPC)
 			return ret;
 
-		ret = lseek(fd, 0, SEEK_SET);
+		ret = lseek(fd, fpos, SEEK_SET);
 		if (ret < 0)
 			return -errno;
 	}
@@ -1096,7 +1098,7 @@ static int erofs_mkfs_build_tree(struct erofs_inode *dir, struct list_head *dirs
 			if (fd < 0)
 				return -errno;
 
-			ret = erofs_write_file(dir, fd);
+			ret = erofs_write_file(dir, fd, 0);
 			close(fd);
 		} else {
 			ret = 0;
@@ -1358,11 +1360,16 @@ int erofs_rebuild_dump_tree(struct erofs_inode *dir)
 			ret = erofs_write_file_from_buffer(dir, dir->i_link);
 			free(dir->i_link);
 			dir->i_link = NULL;
-		} else if (dir->i_tmpfile) {
-			ret = erofs_write_file(dir, fileno(dir->i_tmpfile));
-			fclose(dir->i_tmpfile);
-			dir->i_tmpfile = NULL;
-			dir->with_tmpfile = false;
+		} else if (dir->with_diskbuf) {
+			u64 fpos;
+
+			ret = erofs_diskbuf_getfd(dir->i_diskbuf, &fpos);
+			if (ret >= 0)
+				ret = erofs_write_file(dir, ret, fpos);
+			erofs_diskbuf_close(dir->i_diskbuf);
+			free(dir->i_diskbuf);
+			dir->i_diskbuf = NULL;
+			dir->with_diskbuf = false;
 		} else {
 			ret = 0;
 		}
diff --git a/lib/io.c b/lib/io.c
index 602ac68..c92f16c 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -119,6 +119,7 @@ repeat:
 		}
 		/* INT64_MAX is the limit of kernel vfs */
 		sbi->devsz = INT64_MAX;
+		sbi->devblksz = st.st_blksize;
 		break;
 	default:
 		erofs_err("bad file type (%s, %o).", dev, st.st_mode);
diff --git a/lib/tar.c b/lib/tar.c
index 0f0e7c5..08a140d 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -5,6 +5,7 @@
 #include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/cache.h"
+#include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/list.h"
 #include "erofs/tar.h"
@@ -407,24 +408,32 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 				    struct erofs_tarfile *tar)
 {
 	unsigned int j, rem;
+	int fd;
+	u64 off;
 	char buf[65536];
 
-	if (!inode->i_tmpfile) {
-		inode->i_tmpfile = tmpfile();
-		if (!inode->i_tmpfile)
+	if (!inode->i_diskbuf) {
+		inode->i_diskbuf = calloc(1, sizeof(*inode->i_diskbuf));
+		if (!inode->i_diskbuf)
 			return -ENOSPC;
+	} else {
+		erofs_diskbuf_close(inode->i_diskbuf);
 	}
 
+	fd = erofs_diskbuf_reserve(inode->i_diskbuf, 0, &off);
+	if (fd < 0)
+		return -EBADF;
+
 	for (j = inode->i_size; j; ) {
 		rem = min_t(unsigned int, sizeof(buf), j);
 
 		if (erofs_read_from_fd(tar->fd, buf, rem) != rem ||
-		    fwrite(buf, rem, 1, inode->i_tmpfile) != 1)
+		    write(fd, buf, rem) != rem)
 			return -EIO;
 		j -= rem;
 	}
-	fseek(inode->i_tmpfile, 0, SEEK_SET);
-	inode->with_tmpfile = true;
+	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
+	inode->with_diskbuf = true;
 	return 0;
 }
 
diff --git a/mkfs/main.c b/mkfs/main.c
index a765743..ea868bb 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -15,6 +15,7 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/cache.h"
+#include "erofs/diskbuf.h"
 #include "erofs/inode.h"
 #include "erofs/tar.h"
 #include "erofs/io.h"
@@ -938,6 +939,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (tar_mode && !erofstar.index_mode) {
+		err = erofs_diskbuf_init(1);
+		if (err) {
+			erofs_err("failed to initialize diskbuf: %s",
+				   strerror(-err));
+			goto exit;
+		}
+	}
 #ifdef WITH_ANDROID
 	if (cfg.fs_config_file &&
 	    load_canned_fs_config(cfg.fs_config_file) < 0) {
@@ -1171,6 +1180,7 @@ exit:
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
+	erofs_diskbuf_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.30.2

