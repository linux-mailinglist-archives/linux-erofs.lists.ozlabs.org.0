Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0398C1217
	for <lists+linux-erofs@lfdr.de>; Thu,  9 May 2024 17:39:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lmEA6ngR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZx5g38DKz3cTG
	for <lists+linux-erofs@lfdr.de>; Fri, 10 May 2024 01:39:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lmEA6ngR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZx5Y3Dwnz30Vj
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 May 2024 01:39:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715269162; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JPvcHnKn8NHaPkJ7TXH4dp4k4adgkkGVx7N4xLiIIlw=;
	b=lmEA6ngRyLhXMfTCRup/R9wCZ5Bhhh+UlDsnB/zzd2v9KAINZsX0u+aK8M3YE3OkMGIAJn5DSRessUgGp1DRyNoMXfNfdaEbx2N1Otv4UMU0L/ZCIZ19IHJsQSPRwg/4/IobU1yNqsFkgWJ4u3JCh1b0boljl9ZSRrqcviqO9s8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W67a58C_1715269153;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W67a58C_1715269153)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 23:39:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: add preliminary zstd support [x]
Date: Thu,  9 May 2024 23:39:12 +0800
Message-Id: <20240509153912.617125-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240509055045.49474-1-hsiangkao@linux.alibaba.com>
References: <20240509055045.49474-1-hsiangkao@linux.alibaba.com>
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

This patch just adds a preliminary Zstandard support to erofs-utils
since currently Zstandard doesn't support fixed-sized output compression
officially.  Mkfs could take more time to finish but it works at least.

The built-in zstd compressor for erofs-utils is slowly WIP, therefore
apparently it will take more efforts.

[ TODO: Later I tend to add another way to generate fixed-sized input
        pclusters temporarily for relatively large pcluster sizes as
        an option since it will have minor impacts to the results. ]

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
 - Fix incorrect assumption of sub-block compression.

 configure.ac             |  35 +++++++++++
 dump/Makefile.am         |   3 +-
 fsck/Makefile.am         |   6 +-
 fuse/Makefile.am         |   2 +-
 include/erofs_fs.h       |  10 +++
 lib/Makefile.am          |   3 +
 lib/compress.c           |  24 ++++++++
 lib/compressor.c         |   8 +++
 lib/compressor.h         |   1 +
 lib/compressor_libzstd.c | 128 +++++++++++++++++++++++++++++++++++++++
 lib/decompress.c         |  67 ++++++++++++++++++++
 mkfs/Makefile.am         |   2 +-
 12 files changed, 284 insertions(+), 5 deletions(-)
 create mode 100644 lib/compressor_libzstd.c

diff --git a/configure.ac b/configure.ac
index 4a940a8..1560f84 100644
--- a/configure.ac
+++ b/configure.ac
@@ -139,6 +139,10 @@ AC_ARG_WITH(libdeflate,
       [Enable and build with libdeflate inflate support @<:@default=disabled@:>@])], [],
       [with_libdeflate="no"])
 
+AC_ARG_WITH(libzstd,
+   [AS_HELP_STRING([--with-libzstd],
+      [Enable and build with of libzstd support @<:@default=auto@:>@])])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -474,6 +478,32 @@ AS_IF([test "x$with_libdeflate" != "xno"], [
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_libdeflate="no"])
 
+# Configure libzstd
+have_libzstd="no"
+AS_IF([test "x$with_libzstd" != "xno"], [
+  PKG_CHECK_MODULES([libzstd], [libzstd >= 1.4.0], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libzstd_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libzstd_LIBS} $LIBS"
+    AC_CHECK_HEADERS([zstd.h],[
+      AC_CHECK_LIB(zstd, ZSTD_decompressDCtx, [], [
+        AC_MSG_ERROR([libzstd doesn't work properly])])
+      AC_CHECK_DECL(ZSTD_decompressDCtx, [have_libzstd="yes"],
+        [AC_MSG_ERROR([libzstd doesn't work properly])], [[
+#include <zstd.h>
+      ]])
+      AC_CHECK_FUNCS([ZSTD_getFrameContentSize])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_libzstd" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libzstd])
+    ])
+  ])
+])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -494,6 +524,7 @@ AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
@@ -539,6 +570,10 @@ if test "x$have_libdeflate" = "xyes"; then
   AC_DEFINE([HAVE_LIBDEFLATE], 1, [Define to 1 if libdeflate is found])
 fi
 
+if test "x$have_libzstd" = "xyes"; then
+  AC_DEFINE([HAVE_LIBZSTD], 1, [Define to 1 if libzstd is found])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index aed20c2..09c483e 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -7,4 +7,5 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index d024405..70eacc0 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -7,7 +7,8 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS}
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
@@ -15,5 +16,6 @@ fuzz_erofsfsck_SOURCES = main.c
 fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
 fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
+	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
+	${libzstd_LIBS}
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index c63efcd..7eae5f6 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -7,4 +7,4 @@ erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index eba6c26..907f3d8 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -304,6 +304,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_DEFLATE	= 2,
+	Z_EROFS_COMPRESSION_ZSTD	= 3,
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
@@ -330,6 +331,15 @@ struct z_erofs_deflate_cfgs {
 	u8 reserved[5];
 } __packed;
 
+/* 6 bytes (+ length field = 8 bytes) */
+struct z_erofs_zstd_cfgs {
+	u8 format;
+	u8 windowlog;		/* windowLog - ZSTD_WINDOWLOG_ABSOLUTEMIN(10) */
+	u8 reserved[4];
+} __packed;
+
+#define Z_EROFS_ZSTD_MAX_DICT_SIZE	Z_EROFS_PCLUSTER_MAX_SIZE
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b3bea74..2cb4cab 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -53,6 +53,9 @@ liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
 if ENABLE_LIBDEFLATE
 liberofs_la_SOURCES += compressor_libdeflate.c
 endif
+if ENABLE_LIBZSTD
+liberofs_la_SOURCES += compressor_libzstd.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/compress.c b/lib/compress.c
index e3e4c21..f783236 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1655,6 +1655,30 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 				sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
+#ifdef HAVE_LIBZSTD
+	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_ZSTD)) {
+		struct {
+			__le16 size;
+			struct z_erofs_zstd_cfgs z;
+		} __packed zalg = {
+			.size = cpu_to_le16(sizeof(struct z_erofs_zstd_cfgs)),
+			.z = {
+				.windowlog =
+					ilog2(max_dict_size[Z_EROFS_COMPRESSION_ZSTD]) - 10,
+			}
+		};
+
+		bh = erofs_battach(bh, META, sizeof(zalg));
+		if (IS_ERR(bh)) {
+			DBG_BUGON(1);
+			return PTR_ERR(bh);
+		}
+		erofs_mapbh(bh->block);
+		ret = dev_write(sbi, &zalg, erofs_btell(bh, false),
+				sizeof(zalg));
+		bh->op = &erofs_drop_directly_bhops;
+	}
+#endif
 	return ret;
 }
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 175259e..24c99ac 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -37,6 +37,14 @@ static const struct erofs_algorithm erofs_algs[] = {
 	{ "libdeflate", &erofs_compressor_libdeflate,
 	  Z_EROFS_COMPRESSION_DEFLATE, true },
 #endif
+
+	{ "zstd",
+#ifdef HAVE_LIBZSTD
+		&erofs_compressor_libzstd,
+#else
+		NULL,
+#endif
+	  Z_EROFS_COMPRESSION_ZSTD, false },
 };
 
 int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c)
diff --git a/lib/compressor.h b/lib/compressor.h
index 96f2d21..59d525d 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -53,6 +53,7 @@ extern const struct erofs_compressor erofs_compressor_lz4hc;
 extern const struct erofs_compressor erofs_compressor_lzma;
 extern const struct erofs_compressor erofs_compressor_deflate;
 extern const struct erofs_compressor erofs_compressor_libdeflate;
+extern const struct erofs_compressor erofs_compressor_libzstd;
 
 int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c);
 int erofs_compress_destsize(const struct erofs_compress *c,
diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
new file mode 100644
index 0000000..ff2465e
--- /dev/null
+++ b/lib/compressor_libzstd.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "erofs/config.h"
+#include <zstd.h>
+#include <zstd_errors.h>
+#include <alloca.h>
+#include "compressor.h"
+#include "erofs/atomic.h"
+
+static int libzstd_compress_destsize(const struct erofs_compress *c,
+				       const void *src, unsigned int *srcsize,
+				       void *dst, unsigned int dstsize)
+{
+	ZSTD_CCtx *cctx = c->private_data;
+	size_t l = 0;		/* largest input that fits so far */
+	size_t l_csize = 0;
+	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
+	size_t m;
+	u8 *fitblk_buffer = alloca(dstsize + 32);
+
+	m = dstsize * 4;
+	for (;;) {
+		size_t csize;
+
+		m = max(m, l + 1);
+		m = min(m, r - 1);
+
+		ZSTD_CCtx_setParameter(cctx, ZSTD_c_windowLog, ilog2(c->dict_size));
+		csize = ZSTD_compressCCtx(cctx, fitblk_buffer,
+				     dstsize + 32, src, m, c->compression_level);
+		if (ZSTD_isError(csize)) {
+			if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
+				goto doesnt_fit;
+			return -EFAULT;
+		}
+
+		if (csize > 0 && csize <= dstsize) {
+			/* Fits */
+			memcpy(dst, fitblk_buffer, csize);
+			l = m;
+			l_csize = csize;
+			if (r <= l + 1 || csize + 1 >= dstsize)
+				break;
+			/*
+			 * Estimate needed input prefix size based on current
+			 * compression ratio.
+			 */
+			m = (dstsize * m) / csize;
+		} else {
+doesnt_fit:
+			/* Doesn't fit */
+			r = m;
+			if (r <= l + 1)
+				break;
+			m = (l + r) / 2;
+		}
+	}
+	*srcsize = l;
+	return l_csize;
+}
+
+static int compressor_libzstd_exit(struct erofs_compress *c)
+{
+	if (!c->private_data)
+		return -EINVAL;
+	ZSTD_freeCCtx(c->private_data);
+	return 0;
+}
+
+static int erofs_compressor_libzstd_setlevel(struct erofs_compress *c,
+					     int compression_level)
+{
+	if (compression_level > erofs_compressor_libzstd.best_level) {
+		erofs_err("invalid compression level %d", compression_level);
+		return -EINVAL;
+	}
+	c->compression_level = compression_level;
+	return 0;
+}
+
+static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
+						u32 dict_size)
+{
+	if (!dict_size) {
+		if (erofs_compressor_libzstd.default_dictsize) {
+			dict_size = erofs_compressor_libzstd.default_dictsize;
+		} else {
+			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
+					  cfg.c_mkfs_pclustersize_max << 3);
+			dict_size = 1 << ilog2(dict_size);
+		}
+	}
+	if (dict_size != 1 << ilog2(dict_size) ||
+	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
+		erofs_err("invalid dictionary size %u", dict_size);
+		return -EINVAL;
+	}
+	c->dict_size = dict_size;
+	return 0;
+}
+
+static int compressor_libzstd_init(struct erofs_compress *c)
+{
+	static erofs_atomic_bool_t __warnonce;
+
+	ZSTD_freeCCtx(c->private_data);
+	c->private_data = ZSTD_createCCtx();
+	if (!c->private_data)
+		return -ENOMEM;
+
+	if (!erofs_atomic_test_and_set(&__warnonce)) {
+		erofs_warn("EXPERIMENTAL libzstd compressor in use. Note that `fitblk` isn't supported by upstream zstd for now.");
+		erofs_warn("Therefore it will takes more time in order to get the optimal result.");
+		erofs_info("You could clarify further needs in zstd repository <https://github.com/facebook/zstd/issues> for reference too.");
+	}
+	return 0;
+}
+
+const struct erofs_compressor erofs_compressor_libzstd = {
+	.default_level = ZSTD_CLEVEL_DEFAULT,
+	.best_level = 22,
+	.init = compressor_libzstd_init,
+	.exit = compressor_libzstd_exit,
+	.setlevel = erofs_compressor_libzstd_setlevel,
+	.setdictsize = erofs_compressor_libzstd_setdictsize,
+	.compress_destsize = libzstd_compress_destsize,
+};
diff --git a/lib/decompress.c b/lib/decompress.c
index fe8a40c..58ce7e5 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,6 +9,69 @@
 #include "erofs/err.h"
 #include "erofs/print.h"
 
+#ifdef HAVE_LIBZSTD
+#include <zstd.h>
+#include <zstd_errors.h>
+
+/* also a very preliminary userspace version */
+static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
+{
+	struct erofs_sb_info *sbi = rq->sbi;
+	int ret = 0;
+	char *dest = rq->out;
+	char *src = rq->in;
+	char *buff = NULL;
+	unsigned int inputmargin = 0;
+	unsigned long long total;
+
+	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
+		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+#ifdef HAVE_ZSTD_GETFRAMECONTENTSIZE
+	total = ZSTD_getFrameContentSize(src + inputmargin,
+					 rq->inputsize - inputmargin);
+	if (total == ZSTD_CONTENTSIZE_UNKNOWN ||
+	    total == ZSTD_CONTENTSIZE_ERROR)
+		return -EFSCORRUPTED;
+#else
+	total = ZSTD_getDecompressedSize(src + inputmargin,
+					 rq->inputsize - inputmargin);
+#endif
+	if (rq->decodedskip || total != rq->decodedlength) {
+		buff = malloc(total);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	ret = ZSTD_decompress(dest, total,
+			      src + inputmargin, rq->inputsize - inputmargin);
+	if (ZSTD_isError(ret)) {
+		erofs_err("ZSTD decompress failed %d: %s", ZSTD_getErrorCode(ret),
+			  ZSTD_getErrorName(ret));
+		ret = -EIO;
+		goto out;
+	}
+
+	if (ret != (int)total) {
+		erofs_err("ZSTD decompress length mismatch %d, expected %d",
+			  ret, total);
+		goto out;
+	}
+	if (rq->decodedskip || total != rq->decodedlength)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+out:
+	if (buff)
+		free(buff);
+	return ret;
+}
+#endif
+
 #ifdef HAVE_LIBDEFLATE
 /* if libdeflate is available, use libdeflate instead. */
 #include <libdeflate.h>
@@ -322,6 +385,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #if defined(HAVE_ZLIB) || defined(HAVE_LIBDEFLATE)
 	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
 		return z_erofs_decompress_deflate(rq);
+#endif
+#ifdef HAVE_LIBZSTD
+	if (rq->alg == Z_EROFS_COMPRESSION_ZSTD)
+		return z_erofs_decompress_zstd(rq);
 #endif
 	return -EOPNOTSUPP;
 }
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index dd75485..af97e39 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -7,4 +7,4 @@ mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
-	${libdeflate_LIBS}
+	${libdeflate_LIBS} ${libzstd_LIBS}
-- 
2.39.3

