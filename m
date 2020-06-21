Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 49044202A6F
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2020 14:28:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qWzF2ynjzDqfK
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2020 22:28:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592742489;
	bh=RraHpbEIMxRMp/dbvtrZK7qoMqEYo3G7bKyQJ57lKsc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=okGlBMvNKeirIlVe/ywiy1Q3+U19otzi7t09/EcG9EhEBhy52BCuqJykKkp4/bKaw
	 GgX4P1yJ2QCkGInzuniihk6ruaQNYEvYrn4rbKTIXQ8y0sIDZASufTOcmhHYXtx1P1
	 Jg25qwPHbFmvP9NzLyFkszQDjFhrb0uW7ZbOlfnXxruQO3xkAk7oNuPSemU/70gbA5
	 +4ZYXWNKtncQZDmWfzZUF4BLdHdO13mURHaVn3SBo6UJcfsQ2TTZenwAu0Db19b68W
	 hvjJkBH8GKGBA9fVqhz+m326Qj3uWa7/W0go7UY6WJCK8tlBNhlHug89RBdqiGpyk7
	 AUZ7xAfB2Mpag==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.39;
 helo=out30-39.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=cbn8cCPr; dkim-atps=neutral
Received: from out30-39.freemail.mail.aliyun.com
 (out30-39.freemail.mail.aliyun.com [115.124.30.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qWz22lZRzDqZm
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jun 2020 22:27:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1592742468; h=From:To:Subject:Date:Message-Id;
 bh=NSQCb1n+JUB8n/T4dXA3+kK1ul9VVYrS7IKSVJ6zXzI=;
 b=cbn8cCPrN1UD9bXKxo/uvechdUpr84KdB6OM4qZPku6ZTkzxpHn9UuSx40nA5Vb8N4iwLucZIAmEupCNTyWsTc1i9gKSv9YDm86XWlA2WlX2DqFTAlXbF5M8zwp8b68nlBc1XkfmTYWrkci44AT/FIG4NiW9pppv5kMGfuHJQsM=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00197085-9.95932e-05-0.99793;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04394; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U0EiZKV_1592742466; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U0EiZKV_1592742466) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 21 Jun 2020 20:27:47 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v8] erofs-utils: introduce segment compression
Date: Sun, 21 Jun 2020 20:27:45 +0800
Message-Id: <20200621122745.26996-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621105147.21422-1-bluce.lee@aliyun.com>
References: <20200621105147.21422-1-bluce.lee@aliyun.com>
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Cc: Li Guifu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Support segment compression which seperates files in several logic
units (segments) and each segment is compressed independently.

Advantages:
 - more friendly for data differencing;
 - it can also be used for parallel compression in the same file later.

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
---
 include/erofs/config.h |  1 +
 lib/compress.c         | 47 ++++++++++++++++++++++++++----------------
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  4 ++++
 mkfs/main.c            | 18 +++++++++++++++-
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f09749..e5f1bfb 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -35,6 +35,7 @@ struct erofs_configure {
 	char *c_img_path;
 	char *c_src_path;
 	char *c_compr_alg_master;
+	u64 c_compr_seg_size;
 	int c_compr_level_master;
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
diff --git a/lib/compress.c b/lib/compress.c
index 6cc68ed..6c0708d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	u64 segavail;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -116,23 +117,11 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 }
 
 static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
-				    char *dst)
+				    unsigned int count, char *dst)
 {
 	int ret;
-	unsigned int count;
-
-	/* reset clusterofs to 0 if permitted */
-	if (!erofs_sb_has_lz4_0padding() &&
-	    ctx->head >= ctx->clusterofs) {
-		ctx->head -= ctx->clusterofs;
-		*len += ctx->clusterofs;
-		ctx->clusterofs = 0;
-	}
-
-	/* write uncompressed data */
-	count = min(EROFS_BLKSIZ, *len);
 
+	DBG_BUGON(count > EROFS_BLKSIZ);
 	memcpy(dst, ctx->queue + ctx->head, count);
 	memset(dst + count, 0, EROFS_BLKSIZ - count);
 
@@ -157,14 +146,22 @@ static int vle_compress_one(struct erofs_inode *inode,
 
 	while (len) {
 		bool raw;
+		unsigned int limit = EROFS_BLKSIZ;
+
+		if (ctx->segavail <= EROFS_BLKSIZ) {
+			if (len < ctx->segavail && !final)
+				break;
+
+			limit = ctx->segavail;
+			goto nocompression;
+		}
 
 		if (len <= EROFS_BLKSIZ) {
 			if (final)
 				goto nocompression;
 			break;
 		}
-
-		count = len;
+		count = min_t(u64, len, ctx->segavail);
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
@@ -175,10 +172,18 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			/* reset clusterofs to 0 if permitted */
+			if (!erofs_sb_has_lz4_0padding() &&
+			    ctx->head >= ctx->clusterofs) {
+				ctx->head -= ctx->clusterofs;
+				len += ctx->clusterofs;
+				limit += ctx->clusterofs;
+				ctx->clusterofs = 0;
+			}
+			count = min(limit, len);
+			ret = write_uncompressed_block(ctx, count, dst);
 			if (ret < 0)
 				return ret;
-			count = ret;
 			raw = true;
 		} else {
 			/* write compressed data */
@@ -203,6 +208,11 @@ nocompression:
 		++ctx->blkaddr;
 		len -= count;
 
+		if (count >= ctx->segavail)
+			ctx->segavail = cfg.c_compr_seg_size;
+		else
+			ctx->segavail -= count;
+
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
 				round_down(ctx->head, EROFS_BLKSIZ);
@@ -422,6 +432,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
+	ctx.segavail = cfg.c_compr_seg_size;
 
 	while (remaining) {
 		const u64 readcount = min_t(u64, remaining,
diff --git a/lib/config.c b/lib/config.c
index da0c260..721ff61 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_seg_size = -1;
 }
 
 void erofs_show_config(void)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 891c5a8..0b613e4 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,10 @@ Forcely generate extended inodes (64-byte inodes) to output.
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
 .TP
+.BI "\-S " #
+Set max input stream size for each individual segment (disabled if 0).
+The default value is 0. It should be aligned with blocksize.
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple `--exclude-path' options.
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6..dcb01cc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,6 +61,7 @@ static void usage(void)
 	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]         X=extended options\n"
 	      " -T#               set a fixed UNIX timestamp # to all files\n"
+	      " -S#               Set max input stream size # for each individual segment\n"
 	      " --exclude-path=X  avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
@@ -138,7 +139,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
+	while((opt = getopt_long(argc, argv, "d:x:z:E:T:S:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -188,6 +189,21 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 'S':
+			cfg.c_compr_seg_size = strtoll(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid compress segment size %s",
+					  optarg);
+				return -EINVAL;
+			}
+			if (!cfg.c_compr_seg_size) {
+				cfg.c_compr_seg_size = -1;
+			} else if (cfg.c_compr_seg_size % EROFS_BLKSIZ) {
+				erofs_err("segment size:%"PRIu64" should be align with %u",
+					  cfg.c_compr_seg_size, EROFS_BLKSIZ);
+				return -EINVAL;
+			}
+			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.17.1

