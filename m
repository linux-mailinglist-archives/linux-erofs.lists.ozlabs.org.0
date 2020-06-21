Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697C202A27
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2020 12:53:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qTsx33Y8zDqfr
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Jun 2020 20:53:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592736805;
	bh=ZNFNy6BPpFdAvNtJbuMMUNfXxiO+KxNLrJngSHVvmZg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=a4xM7DT6fP0Do2Yb/RMJHjwUVGpwFz1hb2cArBRjJlU2dfosm9GHRevLoz82dOSGh
	 cd1aqGMn4zInlh4poRvMghT26/ylPAJ4CdtYN9e4M57gN/sXYAnVLDH/P4VlZzHX7f
	 En4dV+IKW0TPmfTu/ACo/OUjquGZhDqaB757ihkt2uXlCXSJDITSIYw6SY86ypagaD
	 n8tb2VTQeSJJQfwwFzcNIAm3fdATfjtmIUy29McTlaDWR6DOmH+OpWf1pAHsiIbXuR
	 YtNJLVirtPK29y/hZhYxEjtQggkoSI8u2EzBaNi7Uknd8o5qKVgGHIkP2VT639oCRN
	 vvXowOILC/UVg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.40;
 helo=out30-40.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=qxfmViWH; dkim-atps=neutral
Received: from out30-40.freemail.mail.aliyun.com
 (out30-40.freemail.mail.aliyun.com [115.124.30.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qTrQ0ZFYzDqfL
 for <linux-erofs@lists.ozlabs.org>; Sun, 21 Jun 2020 20:52:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1592736710; h=From:To:Subject:Date:Message-Id;
 bh=ilEaK9w9NX79irUAWoT/P+lvTtV6Gzzsfhi7/XBKmXo=;
 b=qxfmViWHxFBmHK+SdKrV1z+0MAvbLIQQT3uhqk78WN3/8VYAi2Coko0HHA/G9uaWyAQVSEUtDK2UHk47KE9zvIpwdBQkVsoP1JK/swZsfi8z3qv26EE2ed8YF9/gRU7aC4+bGmWg3BBHR1nMmUON7B0wpJYgSW08Lbl4ElBTnc0=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00205081-0.000123433-0.997826;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01355; MF=bluce.lee@aliyun.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---0U0DcaiD_1592736708; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0U0DcaiD_1592736708) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 21 Jun 2020 18:51:49 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6] erofs-utils: introduce segment limits compression
Date: Sun, 21 Jun 2020 18:51:47 +0800
Message-Id: <20200621105147.21422-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619175133.6919-1-bluce.lee@aliyun.com>
References: <20200619175133.6919-1-bluce.lee@aliyun.com>
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
 - add a limits varialbe to give the limits size in the write_uncompress_block
 - Set comments more readable

 include/erofs/config.h |  1 +
 lib/compress.c         | 29 +++++++++++++++++++++--------
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  4 ++++
 mkfs/main.c            | 18 +++++++++++++++++-
 5 files changed, 44 insertions(+), 9 deletions(-)

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
index 6cc68ed..8a79895 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	u64 segavail;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -116,23 +117,21 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
 }
 
 static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
-				    unsigned int *len,
+				    unsigned int *len, unsigned int limits,
 				    char *dst)
 {
 	int ret;
-	unsigned int count;
+	unsigned int count = min(limits, *len); /* write uncompressed data */
 
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() &&
 	    ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
+		count += ctx->clusterofs;
 		ctx->clusterofs = 0;
 	}
 
-	/* write uncompressed data */
-	count = min(EROFS_BLKSIZ, *len);
-
 	memcpy(dst, ctx->queue + ctx->head, count);
 	memset(dst + count, 0, EROFS_BLKSIZ - count);
 
@@ -157,14 +156,22 @@ static int vle_compress_one(struct erofs_inode *inode,
 
 	while (len) {
 		bool raw;
+		unsigned int limits = EROFS_BLKSIZ;
+
+		if (ctx->segavail <= EROFS_BLKSIZ) {
+			if (len < ctx->segavail && !final)
+				break;
+
+			limits = ctx->segavail;
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
@@ -175,7 +182,7 @@ static int vle_compress_one(struct erofs_inode *inode,
 					  erofs_strerror(ret));
 			}
 nocompression:
-			ret = write_uncompressed_block(ctx, &len, dst);
+			ret = write_uncompressed_block(ctx, &len, limits, dst);
 			if (ret < 0)
 				return ret;
 			count = ret;
@@ -203,6 +210,11 @@ nocompression:
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
@@ -422,6 +434,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
 	remaining = inode->i_size;
+	ctx.segavail = cfg.c_compr_seg_size;
 
 	while (remaining) {
 		const u64 readcount = min_t(u64, remaining,
diff --git a/lib/config.c b/lib/config.c
index da0c260..fbb2914 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_seg_size = -1UL;
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
index 94bf1e6..0e26f4f 100644
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
+				cfg.c_compr_seg_size = -1UL;
+			} else if (cfg.c_compr_seg_size % EROFS_BLKSIZ) {
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

