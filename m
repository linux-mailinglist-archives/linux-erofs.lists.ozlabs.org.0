Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C174C77D
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Jul 2023 20:51:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzbpP08NFz3dS9
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 04:51:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qzbg95txVz3cbR
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 04:45:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vmvrycq_1688928326;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmvrycq_1688928326)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 02:45:36 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs-utils: fuse: add DEFLATE algorithm support
Date: Mon, 10 Jul 2023 02:45:24 +0800
Message-Id: <20230709184525.120677-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
References: <20230709182511.96954-1-hsiangkao@linux.alibaba.com>
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

This patch adds DEFLATE compression algorithm support to erofsfuse
by using zlib (by default) and libdeflate.  libdeflate will be used
instead of zlib if libdeflate is enabled.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 move a misplaced logic from [4/4] to [3/4].

 configure.ac       |  45 ++++++++++++++
 dump/Makefile.am   |   3 +-
 fsck/Makefile.am   |   6 +-
 fuse/Makefile.am   |   2 +-
 include/erofs_fs.h |   7 +++
 lib/decompress.c   | 147 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 206 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index cd6be4a..b393064 100644
--- a/configure.ac
+++ b/configure.ac
@@ -122,6 +122,15 @@ AC_ARG_ENABLE(lzma,
    [AS_HELP_STRING([--enable-lzma], [enable LZMA compression support @<:@default=no@:>@])],
    [enable_lzma="$enableval"], [enable_lzma="no"])
 
+AC_ARG_WITH(zlib,
+   [AS_HELP_STRING([--without-zlib],
+      [Ignore presence of zlib inflate support @<:@default=enabled@:>@])])
+
+AC_ARG_WITH(libdeflate,
+   [AS_HELP_STRING([--with-libdeflate],
+      [Enable and build with libdeflate inflate support @<:@default=disabled@:>@])], [],
+      [with_libdeflate="no"])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -394,6 +403,34 @@ if test "x$enable_lzma" = "xyes"; then
   CPPFLAGS="${saved_CPPFLAGS}"
 fi
 
+# Configure zlib
+AS_IF([test "x$with_zlib" != "xno"], [
+  PKG_CHECK_MODULES([zlib], [zlib])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${zlib_CFLAGS} ${CPPFLAGS}"
+  LIBS="${zlib_LIBS} $LIBS"
+  AC_CHECK_LIB(z, inflate, [
+    have_zlib="yes" ], [
+    AC_MSG_ERROR([zlib doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_zlib="no"])
+
+# Configure libdeflate
+AS_IF([test "x$with_libdeflate" != "xno"], [
+  PKG_CHECK_MODULES([libdeflate], [libdeflate])
+  # Paranoia: don't trust the result reported by pkgconfig before trying out
+  saved_LIBS="$LIBS"
+  saved_CPPFLAGS=${CPPFLAGS}
+  CPPFLAGS="${libdeflate_CFLAGS} ${CPPFLAGS}"
+  LIBS="${libdeflate_LIBS} $LIBS"
+  AC_CHECK_LIB(deflate, libdeflate_deflate_decompress, [
+    have_libdeflate="yes" ], [
+    AC_MSG_ERROR([libdeflate doesn't work properly])])
+  LIBS="${saved_LIBS}"
+  CPPFLAGS="${saved_CPPFLAGS}"], [have_libdeflate="no"])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -449,6 +486,14 @@ if test "x${have_liblzma}" = "xyes"; then
   AC_SUBST([liblzma_CFLAGS])
 fi
 
+if test "x$have_zlib" = "xyes"; then
+  AC_DEFINE([HAVE_ZLIB], 1, [Define to 1 if zlib is found])
+fi
+
+if test "x$have_libdeflate" = "xyes"; then
+  AC_DEFINE([HAVE_LIBDEFLATE], 1, [Define to 1 if libdeflate is found])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index c2bef6d..63f301e 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -7,4 +7,5 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 9366a9d..ffdd0be 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -7,7 +7,8 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
 fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS}
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
@@ -15,5 +16,6 @@ fuzz_erofsfsck_SOURCES = main.c
 fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
 fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS}
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 3179a2b..50be783 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -7,4 +7,4 @@ erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
-	${libselinux_LIBS} ${liblzma_LIBS}
+	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 3697882..6b7b34f 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -297,6 +297,7 @@ enum {
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
+	Z_EROFS_COMPRESSION_DEFLATE	= 1,
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
@@ -317,6 +318,12 @@ struct z_erofs_lzma_cfgs {
 
 #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 
+/* 6 bytes (+ length field = 8 bytes) */
+struct z_erofs_deflate_cfgs {
+	u8 windowbits;			/* 8..15 for DEFLATE */
+	u8 reserved[5];
+} __packed;
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/lib/decompress.c b/lib/decompress.c
index 59a9ca0..04bd24e 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -9,6 +9,149 @@
 #include "erofs/err.h"
 #include "erofs/print.h"
 
+#ifdef HAVE_LIBDEFLATE
+/* if libdeflate is available, use libdeflate instead. */
+#include <libdeflate.h>
+
+static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
+{
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	size_t actual_out;
+	unsigned int inputmargin = 0;
+	struct libdeflate_decompressor *inf;
+	enum libdeflate_result ret;
+
+	while (!src[inputmargin & (erofs_blksiz() - 1)])
+		if (!(++inputmargin & (erofs_blksiz() - 1)))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	inf = libdeflate_alloc_decompressor();
+	if (!inf)
+		return -ENOMEM;
+
+	if (rq->partial_decoding) {
+		ret = libdeflate_deflate_decompress(inf, src + inputmargin,
+				rq->inputsize - inputmargin, dest,
+				rq->decodedlength, &actual_out);
+		if (ret && ret != LIBDEFLATE_INSUFFICIENT_SPACE) {
+			ret = -EIO;
+			goto out_inflate_end;
+		}
+
+		if (actual_out != rq->decodedlength) {
+			ret = -EIO;
+			goto out_inflate_end;
+		}
+	} else {
+		ret = libdeflate_deflate_decompress(inf, src + inputmargin,
+				rq->inputsize - inputmargin, dest,
+				rq->decodedlength, NULL);
+		if (ret) {
+			ret = -EIO;
+			goto out_inflate_end;
+		}
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out_inflate_end:
+	libdeflate_free_decompressor(inf);
+	if (buff)
+		free(buff);
+	return ret;
+}
+#elif defined(HAVE_ZLIB)
+#include <zlib.h>
+
+/* report a zlib or i/o error */
+static int zerr(int ret)
+{
+	switch (ret) {
+	case Z_STREAM_ERROR:
+		return -EINVAL;
+	case Z_DATA_ERROR:
+		return -EIO;
+	case Z_MEM_ERROR:
+		return -ENOMEM;
+	case Z_ERRNO:
+	case Z_VERSION_ERROR:
+	default:
+		return -EFAULT;
+	}
+}
+
+static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	u8 *dest = (u8 *)rq->out;
+	u8 *src = (u8 *)rq->in;
+	u8 *buff = NULL;
+	unsigned int inputmargin = 0;
+	z_stream strm;
+
+	while (!src[inputmargin & (erofs_blksiz() - 1)])
+		if (!(++inputmargin & (erofs_blksiz() - 1)))
+			break;
+
+	if (inputmargin >= rq->inputsize)
+		return -EFSCORRUPTED;
+
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	/* allocate inflate state */
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	ret = inflateInit2(&strm, -15);
+	if (ret != Z_OK)
+		return zerr(ret);
+
+	strm.next_in = src + inputmargin;
+	strm.avail_in = rq->inputsize - inputmargin;
+	strm.next_out = dest;
+	strm.avail_out = rq->decodedlength;
+
+	ret = inflate(&strm, rq->partial_decoding ? Z_SYNC_FLUSH : Z_FINISH);
+	if (ret != Z_STREAM_END || strm.total_out != rq->decodedlength) {
+		if (ret != Z_OK || !rq->partial_decoding) {
+			ret = zerr(ret);
+			goto out_inflate_end;
+		}
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+
+out_inflate_end:
+	inflateEnd(&strm);
+	if (buff)
+		free(buff);
+	return ret;
+}
+#endif
+
 #ifdef HAVE_LIBLZMA
 #include <lzma.h>
 
@@ -167,6 +310,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 #ifdef HAVE_LIBLZMA
 	if (rq->alg == Z_EROFS_COMPRESSION_LZMA)
 		return z_erofs_decompress_lzma(rq);
+#endif
+#ifdef HAVE_ZLIB
+	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
+		return z_erofs_decompress_deflate(rq);
 #endif
 	return -EOPNOTSUPP;
 }
-- 
2.24.4

