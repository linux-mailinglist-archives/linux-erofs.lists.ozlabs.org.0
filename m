Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE3214B2F
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jul 2020 10:34:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B026g0qSpzDqd9
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jul 2020 18:34:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1593938043;
	bh=ui3LPshqk2lz+aUuuWjF1HXGKCwjnhZ24z/eKV83hQE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=B3ZJnKbvlZgmTvPTvzWuk25qVE8aLNYRpiKR12vPTPdzzBAtaWLNEPdc8/UUPbfcB
	 4+8s+FBdfqeXxJQRVi6/H+63zb5AM43bvX5lzUSxZy/gqG9a48xX6om1WlApCrevQq
	 93BasAjN2j2iLvpz1CMWGv4ZWWmngvLd9EtNPxrCZxlwKU0SAn3/lMk6yMEHVLquDm
	 ZCsb8kRU0sa8MiZ4ccbfVHtKfg5R8FUJxzqDDRQBrBoObxyRTDJ4kBm1STEGM+DXJA
	 uNHvjIlXUmHHPh3mI5BCl0GiSaHSJPT/kMC74yEAagaQBkb6atneYPgLzXMUPFwSnO
	 oaMob+W5JEsyg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.26;
 helo=out30-26.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=p8bKPSbK; dkim-atps=neutral
Received: from out30-26.freemail.mail.aliyun.com
 (out30-26.freemail.mail.aliyun.com [115.124.30.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B026W1MXlzDqNN
 for <linux-erofs@lists.ozlabs.org>; Sun,  5 Jul 2020 18:33:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1593938025; h=From:To:Subject:Date:Message-Id;
 bh=9Qd88Nqeo3mopScz+DloPw/zCwLTDM/bxRFDkPHOtUE=;
 b=p8bKPSbKpFNF78+svouIGEFeHfEO/7nnJFKUEwWVmIvQh0RJKINbHlIqPbq86X1XcEyBn5SqpRklCPzLqtmNF2/tW1rfcjO1bS+L3XgKsW0z6NpcWTL8Sjs7aZRm+61KdF5g/1VayFAfOcCkwiPRcFjG9HrZQrXUZYw4WD1KHJs=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0020056-8.76702e-05-0.997907;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e07425; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U1irIlZ_1593938023; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U1irIlZ_1593938023) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 05 Jul 2020 16:33:43 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v11] erofs-utils: introduce segment compression
Date: Sun,  5 Jul 2020 16:32:30 +0800
Message-Id: <20200705083230.5027-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630172758.6533-1-bluce.lee@aliyun.com>
References: <20200630172758.6533-1-bluce.lee@aliyun.com>
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
Changes from v10
- chang variable uncomprofs to clusterofs which only used
  when write uncompress block

 include/erofs/config.h |  1 +
 lib/compress.c         | 30 ++++++++++++++++++++++++------
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  4 ++++
 mkfs/main.c            | 16 +++++++++++++++-
 5 files changed, 45 insertions(+), 7 deletions(-)

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
index 6cc68ed..a2a278c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	u64 segavail;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -116,7 +117,7 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 }
 
 static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
+				    unsigned int *len, unsigned int *clusterofs,
 				    char *dst)
 {
 	int ret;
@@ -125,14 +126,19 @@ static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() &&
 	    ctx->head >= ctx->clusterofs) {
+		*clusterofs = ctx->clusterofs;
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
 		ctx->clusterofs = 0;
+		count = min(EROFS_BLKSIZ, *len);
+	} else {
+		*clusterofs = 0;
+		count = min_t(u64, ctx->segavail, *len);
+		if (count > EROFS_BLKSIZ)
+			count = EROFS_BLKSIZ;
 	}
 
 	/* write uncompressed data */
-	count = min(EROFS_BLKSIZ, *len);
-
 	memcpy(dst, ctx->queue + ctx->head, count);
 	memset(dst + count, 0, EROFS_BLKSIZ - count);
 
@@ -157,14 +163,21 @@ static int vle_compress_one(struct erofs_inode *inode,
 
 	while (len) {
 		bool raw;
+		unsigned int clusterofs;
+
+		if (ctx->segavail <= EROFS_BLKSIZ) {
+			if (len < ctx->segavail && !final)
+				break;
+
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
@@ -175,11 +188,12 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			ret = write_uncompressed_block(ctx, &len, &clusterofs, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
 			raw = true;
+			ctx->segavail -= count - clusterofs;
 		} else {
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to block %u",
@@ -194,6 +208,7 @@ nocompression:
 			if (ret)
 				return ret;
 			raw = false;
+			ctx->segavail -= count;
 		}
 
 		ctx->head += count;
@@ -202,6 +217,8 @@ nocompression:
 
 		++ctx->blkaddr;
 		len -= count;
+		if (!ctx->segavail)
+			ctx->segavail = cfg.c_compr_seg_size;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
@@ -422,6 +439,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
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
index 891c5a8..2a4ef71 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,10 @@ Forcely generate extended inodes (64-byte inodes) to output.
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
 .TP
+.BI "\-S " #
+Set max input stream size for each individual segment (disabled if 0).
+The default value is 0. It has be aligned with blocksize.
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple `--exclude-path' options.
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6..cded973 100644
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
@@ -188,6 +189,19 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 'S':
+			i = strtoll(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid compress segment size %s",
+					  optarg);
+				return -EINVAL;
+			}
+			if (!i) {
+				cfg.c_compr_seg_size = -1;
+			} else {
+				cfg.c_compr_seg_size = i * EROFS_BLKSIZ;
+			}
+			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.17.1

