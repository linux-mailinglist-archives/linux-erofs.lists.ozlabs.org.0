Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D73FCBD6
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Aug 2021 18:51:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzYB70pmsz2yPb
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Sep 2021 02:51:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=blfhSadu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=blfhSadu; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzY9y4tLlz2yLg
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Sep 2021 02:51:34 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id j2so11009349pll.1
 for <linux-erofs@lists.ozlabs.org>; Tue, 31 Aug 2021 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O8/5ikK1RAqPxHjrp7YYWY0YozD8WhWsjBYf37x4vAw=;
 b=blfhSaduZwMde86+HCtnWlGltMFS1WDGAxjAE3qtPeIy3X89bQumlaVpo8X0bop8GQ
 mjMpAElzWppPmF8M7dbS0gFKeEk/mqgsYri2nLLg7ITgKl0Xl62Z5gI13z3zMMycbfUo
 sz1UM6ApPW/RCY78OpBsDumQrfH12O0cVuiJmUIp0D0B/+Q0g6pgiYv9+SmxffAg6mYV
 S+fbIvGfMOSFD382mlfDxMD2qWY34XYv9VbQTReeftdXbMgFnCqGx+q/cauE2w88IAhP
 SlVCe6B5IEhHCs6emuP4t/Dr4k12WdAjPib2Vsl2SdAyAvSY40iHVeTLvqwr+zVy/Bl0
 Qj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O8/5ikK1RAqPxHjrp7YYWY0YozD8WhWsjBYf37x4vAw=;
 b=FuCL9Z/bYZlBjCZvbUCwHPuI+iPKfVh6ZfKcgwxVUBXK3nMGl1AoVsXRvZUlVpzv9I
 1Gn0EeWmXEreN4ckUc3YwJ/WjiZTZi+iW6eeQ9dszGM5hb3vCprNc+mXyIkYBMI1VJf8
 nOp4aF5UBn5D91Q70MVuZlkq2lKGcDuqJIS9TLqkiIhi3z0KtMGPqAm2kECV6TtM0dAJ
 zeEjM+Mw2a9ggXE1YWaWvCNdDgPF7nh+skDFqH43+99y3OLIGVDb+b87M99C7NRI1GUK
 0A7L+QVTdIY0F+D3V/PnCyPEbZyxmUfooOotfhXqBxOKLIgK/fM/asNiwkp2qNrWxPVz
 182A==
X-Gm-Message-State: AOAM532/nCmNmUO6UjjHyzBDOKlJrqm45Z9rqLg9F2/vZvHXHaoUm7kx
 ptz1ABttEwoR7AROTO0CwMaLbjhFwOCo4w==
X-Google-Smtp-Source: ABdhPJyeHu0ExS0B/b9lF2WRV1k+PlQbvQL8e2JMuYoJTwCGDox/WUKine5STws3yrGXxlsiUwOJNw==
X-Received: by 2002:a17:902:b594:b0:132:479d:2108 with SMTP id
 a20-20020a170902b59400b00132479d2108mr5586279pls.10.1630428691775; 
 Tue, 31 Aug 2021 09:51:31 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id u6sm20697487pgr.3.2021.08.31.09.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 09:51:31 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/5] erofs-utils: fix general style problem
Date: Wed,  1 Sep 2021 00:51:14 +0800
Message-Id: <20210831165116.16575-4-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831165116.16575-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
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

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fuse/main.c                | 5 +----
 include/erofs/block_list.h | 4 ++--
 lib/block_list.c           | 5 +----
 lib/compress.c             | 9 ++++-----
 lib/compressor.c           | 2 +-
 lib/namei.c                | 3 ++-
 lib/xattr.c                | 2 +-
 mkfs/main.c                | 2 +-
 8 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 34a9b7a..197943a 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -109,16 +109,13 @@ static struct options {
 	bool odebug;
 } fusecfg;
 
-#define OPTION(t, p)                           \
-    { t, offsetof(struct options, p), 1 }
+#define OPTION(t, p) { t, offsetof(struct options, p), 1 }
 static const struct fuse_opt option_spec[] = {
 	OPTION("--dbglevel=%u", debug_lvl),
 	OPTION("--help", show_help),
 	FUSE_OPT_END
 };
 
-#define OPTION(t, p)    { t, offsetof(struct options, p), 1 }
-
 static void usage(void)
 {
 	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index fca476a..dcc0e50 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -18,8 +18,8 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 #else
 static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
-static inline
-void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
+static inline void
+erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 					  erofs_blk_t blkaddr) {}
 #endif
 #endif
diff --git a/lib/block_list.c b/lib/block_list.c
index 73c1bde..15bb5cf 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -11,13 +11,10 @@
 #define pr_fmt(fmt) "EROFS block_list: " FUNC_LINE_FMT fmt "\n"
 #include "erofs/print.h"
 
-static FILE *block_list_fp = NULL;
+static FILE *block_list_fp;
 
 int erofs_droid_blocklist_fopen(void)
 {
-	if (block_list_fp)
-		return 0;
-
 	block_list_fp = fopen(cfg.block_list_file, "w");
 
 	if (!block_list_fp)
diff --git a/lib/compress.c b/lib/compress.c
index 2b12d67..0530765 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -292,13 +292,12 @@ static void *write_compacted_indexes(u8 *out,
 	bool update_blkaddr;
 	erofs_blk_t blkaddr;
 
-	if (destsize == 4) {
+	if (destsize == 4)
 		vcnt = 2;
-	} else if (destsize == 2 && logical_clusterbits == 12) {
+	else if (destsize == 2 && logical_clusterbits == 12)
 		vcnt = 16;
-	} else {
+	else
 		return ERR_PTR(-EINVAL);
-	}
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
 	update_blkaddr = erofs_sb_has_big_pcluster();
@@ -467,8 +466,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret, fd;
-
 	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
+
 	if (!compressmeta)
 		return -ENOMEM;
 
diff --git a/lib/compressor.c b/lib/compressor.c
index 846a836..6bc5c4c 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -26,7 +26,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *dst,
 			    unsigned int dstsize)
 {
-	unsigned uncompressed_size;
+	unsigned int uncompressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
diff --git a/lib/namei.c b/lib/namei.c
index f4094a1..54c368a 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -243,7 +243,8 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 		name = p;
 		/* Skip until no more slashes. */
-		for (name = p; *name == '/'; ++name);
+		for (name = p; *name == '/'; ++name)
+			;
 	}
 	return 0;
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index 39d4a96..821e6c9 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -215,7 +215,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 				       erofs_fspath(srcpath));
 		else
 #endif
-		ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
+			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
 		if (ret <= 0)
 			return ERR_PTR(-ENOMEM);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index debb754..40ca94f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -174,7 +174,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:C:",
+	while ((opt = getopt_long(argc, argv, "d:x:z:E:T:U:C:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
-- 
2.25.1

