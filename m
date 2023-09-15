Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A63EC7A225E
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Sep 2023 17:29:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RnJ5b4WwCz3cKc
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Sep 2023 01:29:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RnJ5R655cz3c60
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Sep 2023 01:29:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vs7c0Ai_1694791754;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vs7c0Ai_1694791754)
          by smtp.aliyun-inc.com;
          Fri, 15 Sep 2023 23:29:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: introduce diskbuf
Date: Fri, 15 Sep 2023 23:29:13 +0800
Message-Id: <20230915152913.4124712-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Previously, each tar data file will be kept as a temporary file before
landing to the target image since the input stream may be non-seekable.

It's somewhat ineffective.  Let's introduce a new diskbuf approach to
manage those buffers.  Laterly, each stream can be redirected to blob
files for external reference.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/diskbuf.h  |  30 ++++++++
 include/erofs/internal.h |   8 ++-
 lib/Makefile.am          |   3 +-
 lib/diskbuf.c            | 147 +++++++++++++++++++++++++++++++++++++++
 lib/inode.c              |  33 +++++----
 lib/io.c                 |   1 +
 lib/tar.c                |  21 ++++--
 mkfs/main.c              |  10 +++
 8 files changed, 230 insertions(+), 23 deletions(-)
 create mode 100644 include/erofs/diskbuf.h
 create mode 100644 lib/diskbuf.c

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
index 19b912b..a3c6fcd 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -107,7 +107,7 @@ struct erofs_sb_info {
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
 
-	int devfd;
+	int devfd, devblksz;
 	u64 devsz;
 	dev_t dev;
 	unsigned int nblobs;
@@ -150,6 +150,8 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_EA_INITED	(1 << 0)
 #define EROFS_I_Z_INITED	(1 << 1)
 
+struct erofs_diskbuf;
+
 struct erofs_inode {
 	struct list_head i_hash, i_subdirs, i_xattrs;
 
@@ -189,7 +191,7 @@ struct erofs_inode {
 	char *i_srcpath;
 	union {
 		char *i_link;
-		FILE *i_tmpfile;
+		struct erofs_diskbuf *i_diskbuf;
 	};
 	unsigned char datalayout;
 	unsigned char inode_isize;
@@ -197,7 +199,7 @@ struct erofs_inode {
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
diff --git a/lib/diskbuf.c b/lib/diskbuf.c
new file mode 100644
index 0000000..004b1c0
--- /dev/null
+++ b/lib/diskbuf.c
@@ -0,0 +1,147 @@
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
+	if (*off)
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
+		++strm;
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
index 37aa79e..4dc8260 100644
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
index 4fa2d92..83cd9e6 100644
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
@@ -919,6 +920,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	if (tar_mode) {
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
@@ -1152,6 +1161,7 @@ exit:
 	erofs_packedfile_exit();
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
+	erofs_diskbuf_exit();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.39.3

