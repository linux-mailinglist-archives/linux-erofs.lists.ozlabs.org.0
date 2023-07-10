Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0174D423
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 13:03:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R01MG3Fb6z3bmv
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 21:03:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R01Lz4vxcz304g
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 21:03:07 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vn2HVzp_1688986981;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn2HVzp_1688986981)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 19:03:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 4/4] erofs-utils: mkfs: add libdeflate compressor support
Date: Mon, 10 Jul 2023 19:02:51 +0800
Message-Id: <20230710110251.89464-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230710110251.89464-1-hsiangkao@linux.alibaba.com>
References: <20230710110251.89464-1-hsiangkao@linux.alibaba.com>
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

Eric suggests a "binary search + heuristics" way by using the
current libdeflate APIs to generate fixed-sized output DEFLATE streams.

Compared to the previous built-in one, it will generate smaller images
(which is expected since the built-in one is roughly just the original
zlib replacement), yet the total compression time might be amplified a
lot especially if some larger pclusters are used by users compared to
the built-in one.

For example:
$ time mkfs.erofs -zdeflate,9 -C65536 enwik8.z enwik8
real    0m9.559s
user    0m9.453s
sys     0m0.069s

$ time mkfs.erofs -zlibdeflate,9 -C65536 enwik8.libdeflate.9.z enwik8
real    0m50.184s
user    0m50.082s
sys     0m0.074s

$ mkfs/mkfs.erofs -zlibdeflate,6 -C65536 enwik8.libdeflate.6.z enwik8
real    0m23.428s
user    0m23.329s
sys     0m0.067s

37175296	enwik8.libdeflate.6.z
37142528	enwik8.z
36835328	enwik8.libdeflate.9.z

Anyway, let's use the current APIs for users who needs smaller image
sizes for now.  Besides, EROFS also supports multiple per-file
algorithms in one image, so it can be used for specific files as well.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac                |   1 +
 lib/Makefile.am             |   3 +
 lib/compress.c              |   2 +-
 lib/compressor.c            |   3 +
 lib/compressor.h            |   1 +
 lib/compressor_libdeflate.c | 114 ++++++++++++++++++++++++++++++++++++
 mkfs/Makefile.am            |   2 +-
 7 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 lib/compressor_libdeflate.c

diff --git a/configure.ac b/configure.ac
index d6dc7af..ac0b0ed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -450,6 +450,7 @@ AM_CONDITIONAL([ENABLE_LZ4], [test "x${have_lz4}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
 AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
+AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
   AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
diff --git a/lib/Makefile.am b/lib/Makefile.am
index ae19b74..694888e 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -45,3 +45,6 @@ liberofs_la_SOURCES += compressor_liblzma.c
 endif
 
 liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
+if ENABLE_LIBDEFLATE
+liberofs_la_SOURCES += compressor_libdeflate.c
+endif
diff --git a/lib/compress.c b/lib/compress.c
index 318b8de..6fb63cb 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1026,7 +1026,7 @@ static int erofs_get_compress_algorithm_id(const char *name)
 		return Z_EROFS_COMPRESSION_LZ4;
 	if (!strcmp(name, "lzma"))
 		return Z_EROFS_COMPRESSION_LZMA;
-	if (!strcmp(name, "deflate"))
+	if (!strcmp(name, "deflate") || !strcmp(name, "libdeflate"))
 		return Z_EROFS_COMPRESSION_DEFLATE;
 	return -ENOTSUP;
 }
diff --git a/lib/compressor.c b/lib/compressor.c
index ca4d364..f81db5b 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -21,6 +21,9 @@ static const struct erofs_compressor *compressors[] = {
 		&erofs_compressor_lzma,
 #endif
 		&erofs_compressor_deflate,
+#if HAVE_LIBDEFLATE
+		&erofs_compressor_libdeflate,
+#endif
 };
 
 int erofs_compress_destsize(const struct erofs_compress *c,
diff --git a/lib/compressor.h b/lib/compressor.h
index c1eee20..f699fe7 100644
--- a/lib/compressor.h
+++ b/lib/compressor.h
@@ -45,6 +45,7 @@ extern const struct erofs_compressor erofs_compressor_lz4;
 extern const struct erofs_compressor erofs_compressor_lz4hc;
 extern const struct erofs_compressor erofs_compressor_lzma;
 extern const struct erofs_compressor erofs_compressor_deflate;
+extern const struct erofs_compressor erofs_compressor_libdeflate;
 
 int erofs_compress_destsize(const struct erofs_compress *c,
 			    const void *src, unsigned int *srcsize,
diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
new file mode 100644
index 0000000..15c90a4
--- /dev/null
+++ b/lib/compressor_libdeflate.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/internal.h"
+#include "erofs/print.h"
+#include "erofs/config.h"
+#include <libdeflate.h>
+#include "compressor.h"
+
+static int libdeflate_compress_destsize(const struct erofs_compress *c,
+				        const void *src, unsigned int *srcsize,
+				        void *dst, unsigned int dstsize)
+{
+	static size_t last_uncompressed_size = 0;
+	size_t l = 0; /* largest input that fits so far */
+	size_t l_csize = 0;
+	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
+	size_t m;
+	u8 tmpbuf[dstsize + 9];
+
+	if (last_uncompressed_size)
+		m = last_uncompressed_size * 15 / 16;
+	else
+		m = dstsize * 4;
+	for (;;) {
+		size_t csize;
+
+		m = max(m, l + 1);
+		m = min(m, r - 1);
+
+		csize = libdeflate_deflate_compress(c->private_data, src, m,
+						    tmpbuf, dstsize + 9);
+		/*printf("Tried %zu => %zu\n", m, csize);*/
+		if (csize > 0 && csize <= dstsize) {
+			/* Fits */
+			memcpy(dst, tmpbuf, csize);
+			l = m;
+			l_csize = csize;
+			if (r <= l + 1 || csize +
+				(22 - 2*(int)c->compression_level) >= dstsize)
+				break;
+			/*
+			 * Estimate needed input prefix size based on current
+			 * compression ratio.
+			 */
+			m = (dstsize * m) / csize;
+		} else {
+			/* Doesn't fit */
+			r = m;
+			if (r <= l + 1)
+				break;
+			m = (l + r) / 2;
+		}
+	}
+
+	/*
+	 * Since generic EROFS on-disk compressed data will be filled with
+	 * leading 0s (but no more than one block, 4KB for example, even the
+	 * whole pcluster is 128KB) if not filled, it will be used to identify
+	 * the actual compressed length as well without taking more reserved
+	 * compressed bytes or some extra metadata to record this.
+	 *
+	 * DEFLATE streams can also be used in this way, if it starts from a
+	 * non-last stored block, flag an unused bit instead to avoid the zero
+	 * byte. It's still a valid one according to the DEFLATE specification.
+	 */
+	if (!((u8 *)dst)[0])
+	       ((u8 *)dst)[0] = 1 << (2 + 1);
+
+	/*printf("Choosing %zu => %zu\n", l, l_csize);*/
+	*srcsize = l;
+	last_uncompressed_size = l;
+	return l_csize;
+}
+
+static int compressor_libdeflate_exit(struct erofs_compress *c)
+{
+	if (!c->private_data)
+		return -EINVAL;
+
+	libdeflate_free_compressor(c->private_data);
+	return 0;
+}
+
+static int compressor_libdeflate_init(struct erofs_compress *c)
+{
+	c->alg = &erofs_compressor_libdeflate;
+	c->private_data = NULL;
+
+	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
+	return 0;
+}
+
+static int erofs_compressor_libdeflate_setlevel(struct erofs_compress *c,
+						int compression_level)
+{
+	if (compression_level < 0)
+		compression_level = erofs_compressor_deflate.default_level;
+
+	libdeflate_free_compressor(c->private_data);
+	c->private_data = libdeflate_alloc_compressor(compression_level);
+	if (!c->private_data)
+		return -ENOMEM;
+	c->compression_level = compression_level;
+	return 0;
+}
+
+const struct erofs_compressor erofs_compressor_libdeflate = {
+	.name = "libdeflate",
+	.default_level = 1,
+	.best_level = 12,
+	.init = compressor_libdeflate_init,
+	.exit = compressor_libdeflate_exit,
+	.setlevel = erofs_compressor_libdeflate_setlevel,
+	.compress_destsize = libdeflate_compress_destsize,
+};
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index a08dc53..603c2f3 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -6,4 +6,4 @@ AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${libdeflate_LIBS}
-- 
2.24.4

