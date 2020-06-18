Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4070D1FF936
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 18:27:37 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nnQt3LjLzDqRj
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 02:27:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592497654;
	bh=k+2p2TZ1URyT4x0BkoJoP2LR13SruCUbCV1p4pNLtEI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=guplDckPgaRHrQ2LFpfm74puCPdCPm6rWa8l7Y55AQa3aCOX1W30uGV5xjMvSP4pf
	 SnzOljtpXjbVx8P88/JPo2+QrSbZwQxqFn9M3VDSn/6koaX7fR4HicCv18tVcwLKiM
	 wLyAH186rF5IJTEFi/rvjR2rqVRcXsHGtBMqcU2P3sntM1Zo+zXUSTSJBgHTiyup8X
	 9oTSZHFtIWq/1UEHlywi4RJES5LCwDnWsqnwTaQQwdpGpXRIxC96uoe+Ydnxa1awjf
	 4MW5/9WWkHxoI0ONgudU0R6PWEFn4fYHKz15cvta1zbu4ae93XD631YJoDGzvOqNKU
	 D64sOCB5gH8/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.28;
 helo=out30-28.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=QXQtUygZ; dkim-atps=neutral
Received: from out30-28.freemail.mail.aliyun.com
 (out30-28.freemail.mail.aliyun.com [115.124.30.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nnQb02gtzDqPb
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 02:27:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1592497622; h=From:To:Subject:Date:Message-Id;
 bh=Kt5Frv0jOzZbpbK4FNke2dgzy9cQ8TkUI/CgC1ujoGI=;
 b=QXQtUygZP7Ix0WHhtAr0l/hKrDckkpVOZsuAqwgNKtbZ282xjNsBRElikaR+L/2Ul0yi7dayfIPEq6Seh8og4fYsrBpHxWDl9P3C9WAFjcH21osxW2ij/y79Ji+2IijsQ8/QS+hfaYajwt00GC6O8P5rjohBpWvKiSTZhYc/2v4=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06357799|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00214097-9.87176e-05-0.99776;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01355; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U.zYEUO_1592497620; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U.zYEUO_1592497620) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 19 Jun 2020 00:27:00 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: introduce segment compression
Date: Fri, 19 Jun 2020 00:26:57 +0800
Message-Id: <20200618162657.3136-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
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
Changes since v3 suggest by Gao Xiang<hsiangkao@gmx.com>:
 - add 'S#' parameter to custome compression segment size
 - move limit logic to size decrease

 include/erofs/config.h |  1 +
 lib/compress.c         |  8 ++++++--
 lib/config.c           |  1 +
 mkfs/main.c            | 16 +++++++++++++++-
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f09749..9125c1e 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -36,6 +36,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
+	unsigned int c_compr_seg_size;	/* max segment compress size */
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
diff --git a/lib/compress.c b/lib/compress.c
index 6cc68ed..eb024aa 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	unsigned int comprlimits;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -163,8 +164,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 				goto nocompression;
 			break;
 		}
-
-		count = len;
+		count = min(len, ctx->comprlimits);
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
@@ -202,6 +202,9 @@ nocompression:
 
 		++ctx->blkaddr;
 		len -= count;
+		ctx->comprlimits -= count;
+		if (!ctx->comprlimits)
+			ctx->comprlimits = cfg.c_compr_seg_size;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
@@ -422,6 +425,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
+	ctx.comprlimits = cfg.c_compr_seg_size;
 
 	while (remaining) {
 		const u64 readcount = min_t(u64, remaining,
diff --git a/lib/config.c b/lib/config.c
index da0c260..1c39403 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_seg_size = 1024U * EROFS_BLKSIZ;
 }
 
 void erofs_show_config(void)
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6..036d818 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,6 +61,7 @@ static void usage(void)
 	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]         X=extended options\n"
 	      " -T#               set a fixed UNIX timestamp # to all files\n"
+	      " -S#               set the max input stream size # to one compress\n"
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
+			cfg.c_compr_seg_size = strtol(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid compress segment size %s",
+					  optarg);
+				return -EINVAL;
+			}
+			if (cfg.c_compr_seg_size % EROFS_BLKSIZ != 0) {
+				erofs_err("segment size:%u should be align to %u",
+					  cfg.c_compr_seg_size, EROFS_BLKSIZ);
+				return -EINVAL;
+			}
+			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.17.1

