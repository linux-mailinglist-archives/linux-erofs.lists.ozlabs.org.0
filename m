Return-Path: <linux-erofs+bounces-821-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F82B29B58
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Aug 2025 09:55:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c54ks1Sjnz30LS;
	Mon, 18 Aug 2025 17:55:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755503717;
	cv=none; b=C3+iT7fH7Et5s2Sb1gy5KKN5+cgEBXu2gvKLLjtlpJLiYeWiY+2Qzj1kKMHeVnIWSk0sIaQ5nI+waGrmsj2LBkhxdDdERHejfdxkYkthnMjKOCKJRhSti2Tfrr3vcjtpZu1QjMcfqC1mUiP0GlLj3xoq7MO8suCzMqooIVZFyt1dxVBZOUegSayIPA5JQTmf7AYL6bw1v07F2yFoSfrcyPc8EjI8KYDlER9BowckYd8FKDx4IAbQWYPjI22clxnbzkHO18vn+/rNBpeJPNlpKlw08yIErf9yPmtlo5jA61q/pUqm/tR2qbEpF8NNgt821Yyv6ewv504zR+dWCUtoow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755503717; c=relaxed/relaxed;
	bh=fSomr8QzAXkUzj8CgP6EOgbm0bpOV5H3nMCkCGl7qsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNikr9jkBZPXSvIUvYDFrs1pFWsNdTt9imee3zEJ+iO13fPj9mtYd14BnX1HF20ol4v84Z2CKQmNNhrbk7dNkJOV3M0YQ1Cq2Zl9NMk7oV8juLAVz020UbEo7DzcpTLQ1JjVHH6csqNS1WZ2RUMx8NGGMa7TxOpv1UtQTSvy0gWw47LnGfiem+FbgDKM8q3krUkcLPhdwJQUSGn9/Qvlhng5AO7LySOu7Rds5zJPBTHm7+yQ9PE5XP7YVL8X6PdLrbwFdysGrvOD+SU+mGgTwvjNSjpbDmDUb6/GviWz1u292DlSWN8XNt5tW02DqfGPs5aNY9zm7CJAbcRTEOsDPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ax/yJKY9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ax/yJKY9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c54kp2Bl8z2xCd
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Aug 2025 17:55:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755503708; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fSomr8QzAXkUzj8CgP6EOgbm0bpOV5H3nMCkCGl7qsI=;
	b=ax/yJKY9XvxBx1rVFJyVLunaIyL3OxYopYZLPnULjeAGZ4B1KdcY3GQs0IZCvare/mDHkAy1Bg6bw4p1pkGD+mM4KS29lluFEVB4JiK8Qg9aDqGXv5wCvPyAnzyKicyDS6KY7RCZxpFcjGK8N9VwHiDr9ULum4PXCawQ1tW5tC4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wly5ka-_1755503701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Aug 2025 15:55:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs-utils: prefer using OpenSSL for SHA256
Date: Mon, 18 Aug 2025 15:55:00 +0800
Message-ID: <20250818075500.2051023-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250818034718.1719625-1-hsiangkao@linux.alibaba.com>
References: <20250818034718.1719625-1-hsiangkao@linux.alibaba.com>
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

Since some architectures support hardware or SIMD acceleration.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - avoid deprecated `SHA256_{Init,Update,Final}` (OpenSSL 3.0+).

 configure.ac     |  1 +
 dump/Makefile.am |  2 +-
 fsck/Makefile.am |  4 ++--
 lib/sha256.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 lib/sha256.h     |  8 ++++++++
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7769ac9..6f2421d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -641,6 +641,7 @@ AS_IF([test "x$with_openssl" != "xno"], [
 #include <openssl/hmac.h>
       ]])
     ])
+    AC_CHECK_HEADERS([openssl/evp.h],[],[])
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
index 9bb7fbb..1ae5a15 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -7,6 +7,43 @@
 #include "sha256.h"
 #include <string.h>
 
+#ifdef __USE_OPENSSL_SHA256
+void erofs_sha256_init(struct sha256_state *md)
+{
+	int ret;
+
+	md->ctx = EVP_MD_CTX_new();
+	if (!md->ctx)
+		return;
+	ret = EVP_DigestInit(md->ctx, EVP_sha256());
+	DBG_BUGON(ret != 1);
+}
+
+int erofs_sha256_process(struct sha256_state *md,
+		const unsigned char *in, unsigned long inlen)
+{
+	int ret;
+
+	if (!md->ctx)
+		return -1;
+	ret = EVP_DigestUpdate(md->ctx, in, inlen);
+	return (ret == 1) - 1;
+}
+
+int erofs_sha256_done(struct sha256_state *md, unsigned char *out)
+{
+	int ret;
+	unsigned int mdsize;
+
+	if (!md->ctx)
+		return -1;
+	ret = EVP_DigestFinal_ex(md->ctx, out, &mdsize);
+	if (ret != 1)
+		return -1;
+	EVP_MD_CTX_free(md->ctx);
+	return 0;
+}
+#else
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
  * public domain by Tom St Denis. */
 /* the K array */
@@ -186,6 +223,7 @@ int erofs_sha256_done(struct sha256_state *md, unsigned char *out)
 		STORE32H(md->state[i], out + (4 * i));
 	return 0;
 }
+#endif
 
 void erofs_sha256(const unsigned char *in, unsigned long in_size,
 		  unsigned char out[32])
@@ -193,6 +231,9 @@ void erofs_sha256(const unsigned char *in, unsigned long in_size,
 	struct sha256_state md;
 
 	erofs_sha256_init(&md);
+#ifdef __USE_OPENSSL_SHA256
+	EVP_MD_CTX_set_flags(md.ctx, EVP_MD_CTX_FLAG_ONESHOT);
+#endif
 	erofs_sha256_process(&md, in, in_size);
 	erofs_sha256_done(&md, out);
 }
diff --git a/lib/sha256.h b/lib/sha256.h
index dd39970..851b80c 100644
--- a/lib/sha256.h
+++ b/lib/sha256.h
@@ -4,11 +4,19 @@
 
 #include "erofs/defs.h"
 
+#if defined(HAVE_OPENSSL) && defined(HAVE_OPENSSL_EVP_H)
+#include <openssl/evp.h>
+struct sha256_state {
+	EVP_MD_CTX *ctx;
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


