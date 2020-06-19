Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8F2019CE
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 19:54:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49pRJd1FYnzDrTC
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Jun 2020 03:54:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592589265;
	bh=NzHHmImtirsFn7MS4bqJbAeFhYxDsrIVVAg4nbYPA8A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cvpGCkJZ2k2SSDEpQhgJFisbrtBj5Hd3y3QNnVZDwH/hSY2BHa5zIjuj2VAB6RDzx
	 Ne1ZS2HiYgChiUAA2cQ3NEs2is6mVwuYPPEBOR5Ul/kWx0beizslz/NsJApvqHAOtZ
	 2tUvrBIaTz/vYcQKFWR0byDfhe3UNalN9QH290fFFNScqS58UlWI7mwNwbRvDZ8xVn
	 uq4PtW7Kw0Czw66JAxnUzyEX4hzEXRxMDYhAvGQNsAyo6qJjU9nUvHLyjBNyXAuBRJ
	 pUe84Mvz5PraIvlev+sVdkDTJ+xvKyomtVIPIl1fyFcP9gatzaON2Q6XizLu9+Xfqh
	 USzHjbFI4NKtw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.50;
 helo=out30-50.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=lJGLmXSA; dkim-atps=neutral
Received: from out30-50.freemail.mail.aliyun.com
 (out30-50.freemail.mail.aliyun.com [115.124.30.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49pRFX08S1zDrTN
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jun 2020 03:51:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1592589096; h=From:To:Subject:Date:Message-Id;
 bh=parc3BuFm0bc2Jf3kWw5k2K95nM8ESUOTLBuANuv+tE=;
 b=lJGLmXSAlZa8cJUXE58ImRiUYPyegjuf7B+tdjFG7/j3jo4gMEOkQ8hF/vUem17AkPsEyuatUB09wpgpaN+77RT6nT09eBkWqPw9YQioaTaHR5gzqsoSFqoaELHMyGG8XhteJrhnIlM/L1hTIzUbBiBVXSuUi2DEnBeYpZWS+tI=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00216093-9.38573e-05-0.997745;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U04RQkL_1592589095; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U04RQkL_1592589095) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 20 Jun 2020 01:51:35 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v5] erofs-utils: introduce segment compression
Date: Sat, 20 Jun 2020 01:51:33 +0800
Message-Id: <20200619175133.6919-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618162657.3136-1-bluce.lee@aliyun.com>
References: <20200618162657.3136-1-bluce.lee@aliyun.com>
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
 lib/compress.c         | 16 ++++++++++++++--
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  4 ++++
 mkfs/main.c            | 16 +++++++++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f09749..995664d 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -36,6 +36,7 @@ struct erofs_configure {
 	char *c_src_path;
 	char *c_compr_alg_master;
 	int c_compr_level_master;
+	u64 c_compr_seg_size;
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
diff --git a/lib/compress.c b/lib/compress.c
index 6cc68ed..383ee00 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	u64 segavail;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -158,13 +159,19 @@ static int vle_compress_one(struct erofs_inode *inode,
 	while (len) {
 		bool raw;
 
+		count = min_t(u64, len, ctx->segavail);
+		if (ctx->segavail <= EROFS_BLKSIZ) {
+			if (len < ctx->segavail && !final)
+				break;
+			goto nocompression;
+		}
+
 		if (len <= EROFS_BLKSIZ) {
 			if (final)
 				goto nocompression;
 			break;
 		}
 
-		count = len;
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
@@ -174,8 +181,9 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  inode->i_srcpath,
 					  erofs_strerror(ret));
 			}
+			count = len;
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			ret = write_uncompressed_block(ctx, &count, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
@@ -202,6 +210,9 @@ nocompression:
 
 		++ctx->blkaddr;
 		len -= count;
+		ctx->segavail -= count;
+		if (!ctx->segavail)
+			ctx->segavail = cfg.c_compr_seg_size;
 
 		if (!final && ctx->head >= EROFS_CONFIG_COMPR_MAX_SZ) {
 			const unsigned int qh_aligned =
@@ -422,6 +433,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
+	ctx.segavail = cfg.c_compr_seg_size;
 
 	while (remaining) {
 		const u64 readcount = min_t(u64, remaining,
diff --git a/lib/config.c b/lib/config.c
index da0c260..de982e1 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_seg_size = UINT64_MAX;
 }
 
 void erofs_show_config(void)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 891c5a8..b12cb22 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,10 @@ Forcely generate extended inodes (64-byte inodes) to output.
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
 .TP
+.BI "\-S " #
+Set the max input stream size at one compression. The default is unsigned 64bit MAX.
+It must be algin to EROFS block size(4096).
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple `--exclude-path' options.
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6..96cc053 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,6 +61,7 @@ static void usage(void)
 	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]         X=extended options\n"
 	      " -T#               set a fixed UNIX timestamp # to all files\n"
+	      " -S#               set the max input stream size # at one compression\n"
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
+			cfg.c_compr_seg_size = strtoll(optarg, &endptr, 0);
+			if (*endptr != '\0' || !cfg.c_compr_seg_size) {
+				erofs_err("invalid compress segment size %s",
+					  optarg);
+				return -EINVAL;
+			}
+			if (cfg.c_compr_seg_size % EROFS_BLKSIZ) {
+				erofs_err("segment size:%"PRIu64" should be align to %u",
+					  cfg.c_compr_seg_size, EROFS_BLKSIZ);
+				return -EINVAL;
+			}
+			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.17.1

