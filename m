Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330C9F94AA
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Dec 2024 15:41:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YF99D1S9jz30f8
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Dec 2024 01:41:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734705710;
	cv=none; b=oNaX0wBmK7tuTouz7Duje1xenm1hFpS+wEYHq2dTAmS4Nvpe9cd3/bZNgVZ+NHMxqAUYHoTMG4Y5C/IaF7z5LtNkVgm0l4vy1Yju6if3Kmvsvq5wQ+TUnk7Dt5mcUopL7zVFeaeyuanlVQkpfHc3huILG1vOOARoblt09HQmVF1uda9XNy8GMySK8aDhdAcb9hD3hrTTYzEoI/6AMOtLhN0tMaa1MD2Pb1Rt5wt+u1Wq4p53lEnYii7MoP8YEnTYXjBhRpnNWKLl/plVocCh+lE+OgA/hmbXN00OHi1TFkuXaWs26Aj3jynE4EIgCCWcjda2EcLV9Y2dJVC12hr0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734705710; c=relaxed/relaxed;
	bh=ZYcGH/pmhNOMZXZm99HcEodg8OxLeWSOp2g1VKAVe8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnHv7rc0DPTwUrRRy7N9L/Ged0keDDM8aere3hnRcDRnsCnejV/VpLyNlhlQA3Xhdo3W07Qt5Nw+DQ+uXOKLh1LzeT+yKKwoAl+zOhyEmtW7wuzqXTXdbfQGv6rHoUgvn9vke/Y13KSP8HbYtnLpOd79LbaukMPfmOyVkHm9epS9ykyGXYa7c3lXJCFZopo67MIwL2/t3ax3C4+KdpGkXdHpwj/vJ0G4yVAOqB5bBdMN/tTIkU8jFk4U4BgdqnE41s3UMqxeso6P9eThh5eky6kucGBP6IBlC827RusYBBjJKItfHTbH/bGhNGypI+aAPMCcc4u68K6865JQ4GsndA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lo4wp4+h; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lo4wp4+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YF9985MTCz303K
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Dec 2024 01:41:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734705703; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZYcGH/pmhNOMZXZm99HcEodg8OxLeWSOp2g1VKAVe8s=;
	b=lo4wp4+hayJwZ97x4V6Rp/QmAy+rVDEJrkD/rNoAkWsOOMUW6KGeKSnmYoHZwXMLk7BTjhguEDvZPA3Q7xE9dIOwxksep+ED6PbweB6kyDXz9mZEwej+BxM1VBkO/cYiufTGLnvqojQ6gNVlHgmDKJ/BGi/O+60yA+vH43sLRHc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLu37N9_1734705700 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 22:41:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: use external xxhash library if possible
Date: Fri, 20 Dec 2024 22:41:39 +0800
Message-ID: <20241220144139.648210-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241220065331.70205-1-hsiangkao@linux.alibaba.com>
References: <20241220065331.70205-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

It's expected to be faster than the internal one.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix a wrong comment.

 configure.ac                        | 34 +++++++++++++++++++++++++++++
 dump/Makefile.am                    |  2 +-
 fsck/Makefile.am                    |  4 ++--
 fuse/Makefile.am                    |  2 +-
 lib/Makefile.am                     |  9 ++++++--
 lib/dedupe.c                        |  2 +-
 lib/{xxhash.h => liberofs_xxhash.h} | 15 +++++++++++++
 lib/xattr.c                         |  2 +-
 lib/xxhash.c                        |  2 +-
 mkfs/Makefile.am                    |  2 +-
 10 files changed, 64 insertions(+), 10 deletions(-)
 rename lib/{xxhash.h => liberofs_xxhash.h} (74%)

diff --git a/configure.ac b/configure.ac
index 45a7d33..0a069c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,6 +148,10 @@ AC_ARG_WITH(qpl,
       [Enable and build with Intel QPL support @<:@default=disabled@:>@])], [],
       [with_qpl="no"])
 
+AC_ARG_WITH(xxhash,
+   [AS_HELP_STRING([--with-xxhash],
+      [Enable and build with libxxhash support @<:@default=auto@:>@])])
+
 AC_ARG_ENABLE(fuse,
    [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
    [enable_fuse="$enableval"], [enable_fuse="no"])
@@ -531,6 +535,31 @@ AS_IF([test "x$with_qpl" != "xno"], [
   ])
 ])
 
+# Configure libxxhash
+have_xxhash="no"
+AS_IF([test "x$with_xxhash" != "xno"], [
+  PKG_CHECK_MODULES([libxxhash], [libxxhash], [
+    # Paranoia: don't trust the result reported by pkgconfig before trying out
+    saved_LIBS="$LIBS"
+    saved_CPPFLAGS=${CPPFLAGS}
+    CPPFLAGS="${libxxhash_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libxxhash_LIBS} $LIBS"
+    AC_CHECK_HEADERS([xxhash.h],[
+      AC_CHECK_LIB(xxhash, XXH32, [], [
+        AC_MSG_ERROR([libxxhash doesn't work properly])])
+      AC_CHECK_DECL(XXH32, [have_xxhash="yes"],
+        [AC_MSG_ERROR([libxxhash doesn't work properly])], [[
+#include <xxhash.h>
+      ]])
+    ])
+    LIBS="${saved_LIBS}"
+    CPPFLAGS="${saved_CPPFLAGS}"], [
+    AS_IF([test "x$with_xxhash" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper libxxhash])
+    ])
+  ])
+])
+
 # Enable 64-bit off_t
 CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
 
@@ -553,6 +582,7 @@ AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
 AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
 AM_CONDITIONAL([ENABLE_QPL], [test "x${have_qpl}" = "xyes"])
+AM_CONDITIONAL([ENABLE_XXHASH], [test "x${have_xxhash}" = "xyes"])
 AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
 
 if test "x$have_uuid" = "xyes"; then
@@ -600,6 +630,10 @@ if test "x$have_qpl" = "xyes"; then
   AC_SUBST([libqpl_CFLAGS])
 fi
 
+if test "x$have_xxhash" = "xyes"; then
+  AC_DEFINE([HAVE_XXHASH], 1, [Define to 1 if xxhash is found])
+fi
+
 # Dump maximum block size
 AS_IF([test "x$erofs_cv_max_block_size" = "x"],
       [$erofs_cv_max_block_size = 4096], [])
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 2a4f67a..2cf7fe8 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -8,4 +8,4 @@ dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 5bdee4d..3b7b591 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -8,7 +8,7 @@ fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
@@ -17,5 +17,5 @@ fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
 fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
 endif
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 50186da..55fb61f 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -8,7 +8,7 @@ erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
 erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
 	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS} \
-	${libqpl_LIBS}
+	${libqpl_LIBS} ${libxxhash_LIBS}
 
 if ENABLE_STATIC_FUSE
 lib_LTLIBRARIES = liberofsfuse.la
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 9c0604d..ef98377 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,14 +27,14 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/lib/liberofs_private.h \
-      $(top_srcdir)/lib/xxhash.h
+      $(top_srcdir)/lib/liberofs_xxhash.h
 
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c xxhash.c rebuild.c diskbuf.c
+		      block_list.c rebuild.c diskbuf.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
@@ -58,6 +58,11 @@ if ENABLE_LIBZSTD
 liberofs_la_CFLAGS += ${libzstd_CFLAGS}
 liberofs_la_SOURCES += compressor_libzstd.c
 endif
+if ENABLE_XXHASH
+liberofs_la_CFLAGS += ${libxxhash_CFLAGS}
+else
+liberofs_la_SOURCES += xxhash.c
+endif
 if ENABLE_EROFS_MT
 liberofs_la_LDFLAGS = -lpthread
 liberofs_la_SOURCES += workqueue.c
diff --git a/lib/dedupe.c b/lib/dedupe.c
index 665915a..85ff3c9 100644
--- a/lib/dedupe.c
+++ b/lib/dedupe.c
@@ -6,7 +6,7 @@
 #include "erofs/dedupe.h"
 #include "erofs/print.h"
 #include "rolling_hash.h"
-#include "xxhash.h"
+#include "liberofs_xxhash.h"
 #include "sha256.h"
 
 unsigned long erofs_memcmp2(const u8 *s1, const u8 *s2,
diff --git a/lib/xxhash.h b/lib/liberofs_xxhash.h
similarity index 74%
rename from lib/xxhash.h
rename to lib/liberofs_xxhash.h
index 723c3a5..a0f8367 100644
--- a/lib/xxhash.h
+++ b/lib/liberofs_xxhash.h
@@ -8,7 +8,21 @@ extern "C"
 #endif
 
 #include <stdint.h>
+#ifdef HAVE_XXHASH_H
+#include <xxhash.h>
+#endif
+
+#ifdef HAVE_XXHASH
+static inline uint32_t xxh32(const void *input, size_t length, uint32_t seed)
+{
+	return XXH32(input, length, seed);
+}
 
+static inline uint64_t xxh64(const void *input, const size_t len, const uint64_t seed)
+{
+	return XXH64(input, len, seed);
+}
+#else
 /*
  * xxh32() - calculate the 32-bit hash of the input with a given seed.
  *
@@ -32,6 +46,7 @@ uint32_t xxh32(const void *input, size_t length, uint32_t seed);
  * Return:  The 64-bit hash of the data.
  */
 uint64_t xxh64(const void *input, const size_t len, const uint64_t seed);
+#endif
 
 #ifdef __cplusplus
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index e420775..dc919ab 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -17,7 +17,7 @@
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
 #include "erofs/fragments.h"
-#include "xxhash.h"
+#include "liberofs_xxhash.h"
 #include "liberofs_private.h"
 
 #ifndef XATTR_SYSTEM_PREFIX
diff --git a/lib/xxhash.c b/lib/xxhash.c
index 2768375..ee78ebf 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -44,7 +44,7 @@
  * - xxHash source repository: https://github.com/Cyan4973/xxHash
  */
 #include "erofs/defs.h"
-#include "xxhash.h"
+#include "liberofs_xxhash.h"
 
 /*-*************************************
  * Macros
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 6354712..2499242 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -7,4 +7,4 @@ mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
-	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS}
+	${libdeflate_LIBS} ${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
-- 
2.43.5

