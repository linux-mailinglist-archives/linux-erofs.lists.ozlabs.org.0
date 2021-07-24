Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F83D47DE
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 15:32:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GX6ZB1DKXz30Dj
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 23:32:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GX6Z12y4Tz2ym7
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 23:32:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0UgoY-Ek_1627133525; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgoY-Ek_1627133525) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 21:32:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix macOS build & functionality
Date: Sat, 24 Jul 2021 21:32:03 +0800
Message-Id: <20210724133203.178109-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Tested on MacOS Big Sur 11.4.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 autogen.sh               |  3 ++-
 configure.ac             | 17 ++++++++++++++++-
 fuse/dir.c               |  2 +-
 fuse/macosx.h            |  3 +++
 fuse/main.c              |  6 +++---
 include/erofs/defs.h     | 25 +++++++++++++++++++++++++
 include/erofs/internal.h |  6 ++++--
 lib/data.c               | 26 +++++++++++++++++++-------
 lib/inode.c              |  5 ++++-
 lib/io.c                 |  9 ++++++++-
 lib/namei.c              |  5 +++--
 lib/super.c              |  2 --
 lib/xattr.c              | 28 +++++++++++++++++++++++++++-
 13 files changed, 115 insertions(+), 22 deletions(-)
 create mode 100644 fuse/macosx.h

diff --git a/autogen.sh b/autogen.sh
index fdda7e1995a1..6816b1153f97 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -4,6 +4,7 @@
 aclocal && \
 autoheader && \
 autoconf && \
-libtoolize && \
+case `uname` in Darwin*) glibtoolize --copy ;; \
+  *) libtoolize --copy ;; esac && \
 automake -a -c
 
diff --git a/configure.ac b/configure.ac
index 173642ba7487..6f93bcca22e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -128,6 +128,8 @@ AC_TYPE_INT64_T
 AC_TYPE_SIZE_T
 AC_TYPE_SSIZE_T
 AC_CHECK_MEMBERS([struct stat.st_rdev])
+AC_CHECK_MEMBERS([struct stat.st_atim])
+AC_CHECK_MEMBERS([struct stat.st_atimensec])
 AC_TYPE_UINT64_T
 
 #
@@ -154,7 +156,20 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
    #include <unistd.h>])
 
 # Checks for library functions.
-AC_CHECK_FUNCS([backtrace fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
+AC_CHECK_FUNCS(m4_flatten([
+	backtrace
+	fallocate
+	gettimeofday
+	lgetxattr
+	llistxattr
+	memset
+	realpath
+	pread64
+	pwrite64
+	strdup
+	strerror
+	strrchr
+	strtoull]))
 
 # Configure debug mode
 AS_IF([test "x$enable_debug" != "xno"], [], [
diff --git a/fuse/dir.c b/fuse/dir.c
index f8fa0f6616a6..e16fda125270 100644
--- a/fuse/dir.c
+++ b/fuse/dir.c
@@ -6,7 +6,7 @@
  */
 #include <fuse.h>
 #include <fuse_opt.h>
-
+#include "macosx.h"
 #include "erofs/internal.h"
 #include "erofs/print.h"
 
diff --git a/fuse/macosx.h b/fuse/macosx.h
new file mode 100644
index 000000000000..372eba6058d6
--- /dev/null
+++ b/fuse/macosx.h
@@ -0,0 +1,3 @@
+#ifdef __APPLE__
+#undef LIST_HEAD
+#endif
diff --git a/fuse/main.c b/fuse/main.c
index 37119ea8728d..5552480aa4a3 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -10,7 +10,7 @@
 #include <libgen.h>
 #include <fuse.h>
 #include <fuse_opt.h>
-
+#include "macosx.h"
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
@@ -74,10 +74,10 @@ static int erofsfuse_read(const char *path, char *buffer,
 	ret = erofs_pread(&vi, buffer, size, offset);
 	if (ret)
 		return ret;
-	if (offset + size > vi.i_size)
-		return vi.i_size - offset;
 	if (offset >= vi.i_size)
 		return 0;
+	if (offset + size > vi.i_size)
+		return vi.i_size - offset;
 	return size;
 }
 
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 2e40944c1045..54106853602b 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -96,6 +96,7 @@ typedef int64_t         s64;
 #define round_up(x, y)          ((((x)-1) | __round_mask(x, y))+1)
 #define round_down(x, y)        ((x) & ~__round_mask(x, y))
 
+#ifndef roundup
 /* The `const' in roundup() prevents gcc-3.3 from calling __divdi3 */
 #define roundup(x, y) (					\
 {							\
@@ -103,6 +104,7 @@ typedef int64_t         s64;
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )
+#endif
 #define rounddown(x, y) (				\
 {							\
 	typeof(x) __x = (x);				\
@@ -175,5 +177,28 @@ static inline u32 get_unaligned_le32(const u8 *p)
 	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
 }
 
+#ifndef __always_inline
+#define __always_inline	inline
+#endif
+
+#ifdef HAVE_STRUCT_STAT_ST_ATIM
+/* Linux */
+#define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atim.tv_nsec)
+#define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctim.tv_nsec)
+#define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtim.tv_nsec)
+#elif defined(HAVE_STRUCT_STAT_ST_ATIMENSEC)
+/* macOS */
+#define ST_ATIM_NSEC(stbuf) ((stbuf)->st_atimensec)
+#define ST_CTIM_NSEC(stbuf) ((stbuf)->st_ctimensec)
+#define ST_MTIM_NSEC(stbuf) ((stbuf)->st_mtimensec)
+#else
+#define ST_ATIM_NSEC(stbuf) 0
+#define ST_CTIM_NSEC(stbuf) 0
+#define ST_MTIM_NSEC(stbuf) 0
 #endif
 
+#ifdef __APPLE__
+#define stat64		stat
+#define lstat64		lstat
+#endif
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index da7be569d8ee..5583861b766d 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -266,7 +266,9 @@ int z_erofs_fill_inode(struct erofs_inode *vi);
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map);
 
+#ifdef EUCLEAN
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
-
+#else
+#define EFSCORRUPTED	EIO
+#endif
 #endif
-
diff --git a/lib/data.c b/lib/data.c
index 31d81f3c8a2a..42b4904abee6 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Gao Xiang <hsiangkao@aol.com>
  * Compression support by Huang Jianan <huangjianan@oppo.com>
  */
+#include <stdlib.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "erofs/io.h"
@@ -123,22 +124,23 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			     erofs_off_t size, erofs_off_t offset)
 {
-	int ret;
 	erofs_off_t end, length, skip;
 	struct erofs_map_blocks map = {
 		.index = UINT_MAX,
 	};
 	bool partial;
-	unsigned int algorithmformat;
-	char raw[Z_EROFS_PCLUSTER_MAX_SIZE];
+	unsigned int algorithmformat, bufsize;
+	char *raw = NULL;
+	int ret = 0;
 
 	end = offset + size;
+	bufsize = 0;
 	while (end > offset) {
 		map.m_la = end - 1;
 
 		ret = z_erofs_map_blocks_iter(inode, &map);
 		if (ret)
-			return ret;
+			break;
 
 		/*
 		 * trim to the needed size if the returned extent is quite
@@ -167,9 +169,17 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
+		if (map.m_plen > bufsize) {
+			bufsize = map.m_plen;
+			raw = realloc(raw, bufsize);
+			if (!raw) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 		ret = dev_read(raw, map.m_pa, map.m_plen);
 		if (ret < 0)
-			return -EIO;
+			break;
 
 		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
 						Z_EROFS_COMPRESSION_LZ4 :
@@ -185,9 +195,11 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 					.partial_decoding = partial
 					 });
 		if (ret < 0)
-			return ret;
+			break;
 	}
-	return 0;
+	if (raw)
+		free(raw);
+	return ret < 0 ? ret : 0;
 }
 
 int erofs_pread(struct erofs_inode *inode, char *buf,
diff --git a/lib/inode.c b/lib/inode.c
index 787e5b4485a2..ec6bbf358cdc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -12,7 +12,10 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/stat.h>
+#include <config.h>
+#if defined(HAVE_SYS_SYSMACROS_H)
 #include <sys/sysmacros.h>
+#endif
 #include <dirent.h>
 #include "erofs/print.h"
 #include "erofs/inode.h"
@@ -765,7 +768,7 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
 	inode->i_ctime = st->st_ctime;
-	inode->i_ctime_nsec = st->st_ctim.tv_nsec;
+	inode->i_ctime_nsec = ST_CTIM_NSEC(st);
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
diff --git a/lib/io.c b/lib/io.c
index d835f34da50f..6067041fd829 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -148,7 +148,11 @@ int dev_write(const void *buf, u64 offset, size_t len)
 		return -EINVAL;
 	}
 
+#ifdef HAVE_PWRITE64
 	ret = pwrite64(erofs_devfd, buf, len, (off64_t)offset);
+#else
+	ret = pwrite(erofs_devfd, buf, len, (off_t)offset);
+#endif
 	if (ret != (int)len) {
 		if (ret < 0) {
 			erofs_err("Failed to write data into device - %s:[%" PRIu64 ", %zd].",
@@ -245,8 +249,11 @@ int dev_read(void *buf, u64 offset, size_t len)
 			  offset, len, erofs_devsz);
 		return -EINVAL;
 	}
-
+#ifdef HAVE_PREAD64
 	ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
+#else
+	ret = pread(erofs_devfd, buf, len, (off_t)offset);
+#endif
 	if (ret != (int)len) {
 		erofs_err("Failed to read data from device - %s:[%" PRIu64 ", %zd].",
 			  erofs_devname, offset, len);
diff --git a/lib/namei.c b/lib/namei.c
index 4e06ba468dc4..b572d17daeab 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -4,14 +4,15 @@
  *
  * Created by Li Guifu <blucerlee@gmail.com>
  */
-#include <linux/kdev_t.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <config.h>
+#if defined(HAVE_SYS_SYSMACROS_H)
 #include <sys/sysmacros.h>
-
+#endif
 #include "erofs/print.h"
 #include "erofs/io.h"
 
diff --git a/lib/super.c b/lib/super.c
index 025cefee3aac..11405ec014d2 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -6,8 +6,6 @@
  */
 #include <string.h>
 #include <stdlib.h>
-#include <asm-generic/errno-base.h>
-
 #include "erofs/io.h"
 #include "erofs/print.h"
 
diff --git a/lib/xattr.c b/lib/xattr.c
index a7677b94d148..aff3d67f6344 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -159,7 +159,13 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	DBG_BUGON(keylen < prefixlen);
 
 	/* determine length of the value */
+#ifdef HAVE_LGETXATTR
 	ret = lgetxattr(path, key, NULL, 0);
+#elif defined(__APPLE__)
+	ret = getxattr(path, key, NULL, 0, 0, XATTR_NOFOLLOW);
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
 	if (ret < 0)
 		return ERR_PTR(-errno);
 	len[1] = ret;
@@ -173,7 +179,15 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 	memcpy(kvbuf, key + prefixlen, len[0]);
 	if (len[1]) {
 		/* copy value to buffer */
+#ifdef HAVE_LGETXATTR
 		ret = lgetxattr(path, key, kvbuf + len[0], len[1]);
+#elif defined(__APPLE__)
+		ret = getxattr(path, key, kvbuf + len[0], len[1], 0,
+			       XATTR_NOFOLLOW);
+#else
+		free(kvbuf);
+		return ERR_PTR(-EOPNOTSUPP);
+#endif
 		if (ret < 0) {
 			free(kvbuf);
 			return ERR_PTR(-errno);
@@ -292,7 +306,13 @@ static bool erofs_is_skipped_xattr(const char *key)
 static int read_xattrs_from_file(const char *path, mode_t mode,
 				 struct list_head *ixattrs)
 {
+#ifdef HAVE_LLISTXATTR
 	ssize_t kllen = llistxattr(path, NULL, 0);
+#elif defined(__APPLE__)
+	ssize_t kllen = listxattr(path, NULL, 0, XATTR_NOFOLLOW);
+#else
+	ssize_t kllen = 0;
+#endif
 	int ret;
 	char *keylst, *key, *klend;
 	unsigned int keylen;
@@ -313,13 +333,19 @@ static int read_xattrs_from_file(const char *path, mode_t mode,
 		return -ENOMEM;
 
 	/* copy the list of attribute keys to the buffer.*/
+#ifdef HAVE_LLISTXATTR
 	kllen = llistxattr(path, keylst, kllen);
+#elif defined(__APPLE__)
+	kllen = listxattr(path, keylst, kllen, XATTR_NOFOLLOW);
 	if (kllen < 0) {
 		erofs_err("llistxattr to get names for %s failed", path);
 		ret = -errno;
 		goto err;
 	}
-
+#else
+	ret = -EOPNOTSUPP;
+	goto err;
+#endif
 	/*
 	 * loop over the list of zero terminated strings with the
 	 * attribute keys. Use the remaining buffer length to determine
-- 
2.24.4

