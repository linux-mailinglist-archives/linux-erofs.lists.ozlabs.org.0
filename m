Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DC4000AC
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 15:41:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Jpq4WyTz2xYQ
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 23:41:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lPptf7ae;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=lPptf7ae; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1Jpc00FVz2xYQ
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 23:40:55 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id
 j10-20020a17090a94ca00b00181f17b7ef7so3831899pjw.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 03 Sep 2021 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xXRU6Q2+Y48QNCsaTGX+AyppV0B12iMxuNmMOVl/I/I=;
 b=lPptf7aeWMkxY0ypX4a6a0z2VHkiLHwFc81+Fo2w07Q59ZjJziplMzM3vDfdUO930x
 4IdX30+NTafwPSJDOKGL1KQqi7r5eewUWdkK4UrLwEDPGYsF+Zvkv+lsOV584QIum06k
 i+QfAs//nEtaRWqfMymdy7XauSDeFVSbqw5mhseGhvNQbGqQzkHQejdhOjNVH902dnx8
 jPTbA2Qi5h27Hk515rZlCSberbYSSI0VcrDldRSnIy04Q0EW+ElORta10Q+TxskI1Ulo
 e7gl09RdIKxWOCeSpcwiS8fDdiKGVltzYrc5erPuA+/ghwKFDP4XY0eeXKCi/RId8+YS
 0IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xXRU6Q2+Y48QNCsaTGX+AyppV0B12iMxuNmMOVl/I/I=;
 b=kpZtJcAplOiVTtjpy2SMoKizhmVQNQKGxyqoStRiAV6d79rdok+Zcnw6CrPV5r7yVL
 KAECEEJzLBJ9SlxDxcs534W0gWEsls5E4ePu+FxbYcQjfapUhscwKRCJ8KBmb7kT3LBS
 U7biuOcE++APx1bGDHrEXUcGrag/GiSTD8mrp9YOWTVPfuQvFMvuKLVZsGn+G7R+6DWF
 GNIXAeo+HGhlKAhu3OZdaJ8GlTAt6prGjEvp5zjQdJ+T5cKb/yI3p+nlE/ZFPuurr7tv
 5rVdlQwJub9ALYmFUDnc5VN9lBPYv/5cFpKEAZKf2Fl97/bIV1fwYQjjdkhEzJdiVoTP
 c2og==
X-Gm-Message-State: AOAM5311Xx1bFPU9XnZUp5EZyC6DWiXwdE1OGKDfecwVf1ghsSy4SJWD
 enxLsnSzO/SlRYWATBrI17kUa0JysXxDXYoV
X-Google-Smtp-Source: ABdhPJyYbB2IK/ncCm/ZlHbWD45zzUteMPWDFegqnufMGFucHYxo9Jf1nIiNJ+cG0ynsiPdAwIFX0w==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr9850527pjs.48.1630676453355; 
 Fri, 03 Sep 2021 06:40:53 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id o1sm5590948pjk.1.2021.09.03.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 06:40:52 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V2 3/6] erofs-utils: fix general style problem
Date: Fri,  3 Sep 2021 21:40:32 +0800
Message-Id: <20210903134035.12507-4-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903134035.12507-1-jnhuang95@gmail.com>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210903134035.12507-1-jnhuang95@gmail.com>
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
 include/erofs/block_list.h | 4 ++--
 lib/block_list.c           | 5 +----
 lib/compress.c             | 9 ++++-----
 lib/compressor.c           | 2 +-
 lib/namei.c                | 3 ++-
 lib/xattr.c                | 2 +-
 mkfs/main.c                | 2 +-
 7 files changed, 12 insertions(+), 15 deletions(-)

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
index 5ac9427..6df30ea 100644
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
index c14fc05..1f1a33d 100644
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
index 755a5ad..f96e400 100644
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
index ffc5f7a..196133a 100644
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

