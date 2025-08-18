Return-Path: <linux-erofs+bounces-820-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CAB2976D
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 05:47:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c4zF10flrz30T9;
	Mon, 18 Aug 2025 13:47:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755488853;
	cv=none; b=aaJZqhuT0pJpjajFYlDbjcDGtLzH/3ULetHRyVfxeh5+N0f+QsBvkM4yi3T1RWteqAfjC94ZAWcTeoBFoJv4eIPEQIX8bDl7pSg03ekc1rVHwgLPugya2OdXE56kcphtgMf//C0MwyM1lZa7tJiYCJjbMmU6lxlaID353ZYJqUpghf9OXAy50qLVE2fYIjP/Ef5WoPrVCdKtRoZ9XvJuSD+VotbbueggVblWp7MroGySvz1pXIWRSFJ4uFog7huLw1q2KHvUAKUCaa76/1v1CrckHHLB+ALTY16Yf/ZAe9zGCom8qNlVubXKeuRLizmRIYGLgu8KDZM8B9gIFGK8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755488853; c=relaxed/relaxed;
	bh=FFgkjCfJf3DfPSGCOr8i0bvkCS1JRT/QblC8bJvZOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtQbdsh4OZrBolX5jyFsO9LirDv/45VGJ+O9gEtxTijjmkGBQnEAQVNGLRyW+LEatiHgj7R5bZ9+YVgW43VYcfI3lkfS/7wPliRuJ13sHcG0B1fYOn2roLt4v/EdtapPPjndw7fFX8GEJ7mkNvYMC4/VWw6poPWoXwF+sY4BV7kZX1hAMwYplbGCOSaGrfxP2vDtRm/FmC4V8gMFuzvxRZN74G9qMaF+gZeewfVKDwYD1OLAPhPRySPPT59DaKcaRk2eMIMIZkrhIAb4ESg/Jlume9AV6BBPGgQML7yyl4AgNleOl1dZQxq3/+mWS3qITYEpo0vaN527Z+F+DWvZsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UNE/09Ye; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UNE/09Ye;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c4zDy3M88z301n
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Aug 2025 13:47:29 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755488844; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FFgkjCfJf3DfPSGCOr8i0bvkCS1JRT/QblC8bJvZOeg=;
	b=UNE/09YeiBEzlPQX2jRDv8CZdAwFg1mZxhyyqoVog56+Snzjf6RUs+PjFe/7/DK3zr7bltd08WX3LBNE8jo1rHwxHKLVe+0TREd1azSBFf4OBcXbmfWw6FtnM9MorcmwARn63POhK2NVlMKH6XFKX4yi1v9l/P1a3mbeoeQTmp4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlvCLHG_1755488838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 11:47:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: prefer using OpenSSL for SHA256
Date: Mon, 18 Aug 2025 11:47:18 +0800
Message-ID: <20250818034718.1719625-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Since OpenSSL supports hardware or SIMD acceleration on some platforms.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac     |  1 +
 dump/Makefile.am |  2 +-
 fsck/Makefile.am |  4 ++--
 lib/sha256.c     | 27 +++++++++++++++++++++++++++
 lib/sha256.h     |  8 ++++++++
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7769ac9..afd01a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -641,6 +641,7 @@ AS_IF([test "x$with_openssl" != "xno"], [
 #include <openssl/hmac.h>
       ]])
     ])
+    AC_CHECK_HEADERS([openssl/sha.h],[],[])
     LIBS="${saved_LIBS}"
     CPPFLAGS="${saved_CPPFLAGS}"], [
     AS_IF([test "x$with_openssl" = "xyes"], [
diff --git a/dump/Makefile.am b/dump/Makefile.am
index 2cf7fe8..c56e19f 100644
--- a/dump/Makefile.am
+++ b/dump/Makefile.am
@@ -8,4 +8,4 @@ dump_erofs_SOURCES = main.c
 dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 3b7b591..a1b4623 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -8,7 +8,7 @@ fsck_erofs_SOURCES = main.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
 
 if ENABLE_FUZZING
 noinst_PROGRAMS   = fuzz_erofsfsck
@@ -17,5 +17,5 @@ fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
 fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
 fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
-	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS}
+	${libzstd_LIBS} ${libqpl_LIBS} ${libxxhash_LIBS} ${openssl_LIBS}
 endif
diff --git a/lib/sha256.c b/lib/sha256.c
index 9bb7fbb..a7ba067 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -7,6 +7,32 @@
 #include "sha256.h"
 #include <string.h>
 
+#ifdef __USE_OPENSSL_SHA256
+void erofs_sha256_init(struct sha256_state *md)
+{
+	int ret;
+
+	ret = SHA256_Init(&md->ctx);
+	DBG_BUGON(ret != 1);
+}
+
+int erofs_sha256_process(struct sha256_state *md,
+		const unsigned char *in, unsigned long inlen)
+{
+	int ret;
+
+	ret = SHA256_Update(&md->ctx, in, inlen);
+	return (ret == 1) - 1;
+}
+
+int erofs_sha256_done(struct sha256_state *md, unsigned char *out)
+{
+	int ret;
+
+	ret = SHA256_Final(out, &md->ctx);
+	return (ret == 1) - 1;
+}
+#else
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
  * public domain by Tom St Denis. */
 /* the K array */
@@ -186,6 +212,7 @@ int erofs_sha256_done(struct sha256_state *md, unsigned char *out)
 		STORE32H(md->state[i], out + (4 * i));
 	return 0;
 }
+#endif
 
 void erofs_sha256(const unsigned char *in, unsigned long in_size,
 		  unsigned char out[32])
diff --git a/lib/sha256.h b/lib/sha256.h
index dd39970..45e49cd 100644
--- a/lib/sha256.h
+++ b/lib/sha256.h
@@ -4,11 +4,19 @@
 
 #include "erofs/defs.h"
 
+#if defined(HAVE_OPENSSL) && defined(HAVE_OPENSSL_SHA_H)
+#include <openssl/sha.h>
+struct sha256_state {
+	SHA256_CTX ctx;
+};
+#define __USE_OPENSSL_SHA256
+#else
 struct sha256_state {
 	u64 length;
 	u32 state[8], curlen;
 	u8 buf[64];
 };
+#endif
 
 void erofs_sha256_init(struct sha256_state *md);
 int erofs_sha256_process(struct sha256_state *md,
-- 
2.43.5


