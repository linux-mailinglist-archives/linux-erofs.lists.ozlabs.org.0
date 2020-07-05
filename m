Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA10214E74
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Jul 2020 20:21:31 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0H8T0KQLzDqW9
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jul 2020 04:21:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1593973289;
	bh=XGvw/tQkNiSiaOZobLZlDRtuDXNii3o5i1EGvfgn/pE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=m2jW8HqlM0p+0hC9+GcmHd53lMuso8DRquFDKbQeAvbYJS0SNnrN5sDckSxtGMnn2
	 Eq+WYVik1LfrS0C54d/6AhJDfd0+7pXUCuY+niAyBKAYRRmj7Ks95/tCPE2rREkh3L
	 xoT9Ct201mDzDgC06KFbPUbzOheVLxWe0uhiKA+GDU4dcI43HWlS52J/DdGLozkwD6
	 2Toobe1kEF220Fj62F8n+VkjLX4qWWUqg4VKuF05jworxSuqqMBwVpoIvtyR69E6ik
	 3mhmp+rNQvTtn42H21j7E/Df6drDSbS8WEg0fSa00YCOdCjb2pEDl+WvNYwkYMjdtn
	 j+FO3sqDCOgcw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.148; helo=sonic302-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic302-22.consmr.mail.gq1.yahoo.com
 (sonic302-22.consmr.mail.gq1.yahoo.com [98.137.68.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0H881LbkzDqWk
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jul 2020 04:21:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1593973263; bh=CJibHhcXCyPH6ifE1GSFPOXwe4cI7r7Sx1f9mhunkyA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Fus7YqUYVumZJKdD6oqF0/+NUvLu99pFzidv3K5Vt2jWdC9+5UG8J9ToARhcwlIytxlSWi9t0yf5jsjmFDJgSz81aRsi0TJpkYma9d8o6MCOlBo0QlHcY3/2dzvOk7bxq2eNVmlE3UEj9ObrxEKFqCXfGIP3mAIzQY8M89nTMRZ7uaG7QPqfAIRF/k4p+s68cZhuyrgbM1h2A/ExMf7+AkuYyey2rI4dJtjzBb1o/8Yppac9+R8XTKrlk3McdqkROlzzgVCTuHRIgZCbzL+SxMhCpFBASCoKse98Z1vrTu9dF5vwSEQPGQOv7ryKFDHv5Bn9V/SFR8r958kWPSQHyQ==
X-YMail-OSG: MDLZh8EVM1lsR2HnJ0EGWTd.20Em1dOPruL9AlOXqDtCTZDRLpJUL0TCCjMMW6l
 gFzlwPPpUEPz71ZJVIzBdSkX3dqyBAj6And4v3A9hOagIocUn7eIULNNm6VFs6Uw2ORwbrIJwyXB
 9fMY.hFXBcajc2c2.Gy8ahNGabRaTrmxs84xebXt.4RVI2h6SMk8.UkOroJkkAePAg6IuiYI88kj
 ZUdin2RqBxN10T8uA0799FhrtOMLlZaFeL2kcacy6OzC6mpY2cSDWaDXO7bgu8iAfIxHLGd6ZNew
 OsFDrVKZM3JOisTwgHtH1f2xcqGd_KBAC5QXg8BQdq8TMUBiymWxFm3_7EOHovZ.teJqCRYbcKdK
 IbBb5rVqP1ZgnFlaMLCerXweT0xMAei1_ONJ7Brge6vrBYWwEIUugQUUxfjbxgxhWDTqdKp_QlPf
 aFn0lpVHywoahJ7Y0hYfMU4dWsaRpDgqJ9I.bvb8pc4YEZCInBLTOH3n92jEERKzwPeyoJSu2LMc
 L3vscvmfdtAW8HlvMJmdodh5xUDww5HLCzYGQx9J2zK4k2L_uFCOnGeVFqANe9ZwtYKu5dIJ8xed
 _GDflctNoXJywg9EHSWkaYsDi4Rr3fTnDscZm9uw6DGDlo3E5IuYmAW4bHMASo.WfxoUbizYymK1
 pnBzmdOiNTYZyhOKRFKri01yl9g0fkq_ijmcbEmEXLfPoysqH45MtQySlJNA9OPRpEIu_VxsISLc
 GpsvdAW.CsfWkrnvSb_DsDaNKi1tykoHQHodSinehKC81WD7jj7cbUd7_HEJM8wl.DwEy3Y5Qd7l
 MTDLz3VgvLtP8IzMvbQutIePZB7FpyUIhgnXhv8zuu7yvd.o2EGFBfHs3wikxtyF2vnT7QNInZaq
 0ZAeDchMxxH248vLzahqofNG7wV1O2ZU_BwgaO_mDof9lkYwJnTioWq_xScAIGoHfuEAt_pwrhN4
 4vxekgMnw1AG5dJ.ee2ET5htLHhH8rK_tQ1M8GdrLRY5PON4U4yFk3nvOKLREYO6G2ztx9DFTuG7
 qAqXCcUnVDfUqBe7m28nLNxulhp7EGDtV6S.g3R2poGIA8o8olrqNDoO85pYHJpc0H4e4TkeaT.h
 8yUayfN.u.brsnaS.w1USWewLe46.TFPTExjYwGLdlGrN.qyXfDlHIrYsS082.PoaztBLewvI0FO
 .bAvnt9eQXADhrrT3Qvbbpc5tbaRtLFO0lkILz75G5ROOIhPYo2gLld1tedEM_H.Xkat1ETj_diT
 uCOQNCMvH0zSk_UaTaz3FgvbbKwHfOcly.VSgru8eqBcw1zeBvszs78m.F0wLz7R8uu6gxmETEA8
 2HCQU7E_gBsvWmt4HGXSDBZaX0ZNPXeGCWMfOHDdqbXTE8gByrHM409zqH9FAr01Ug7Ea17gAYDa
 R9shozBdiNQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 5 Jul 2020 18:21:03 +0000
Received: by smtp430.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9dc4de561bfda037a0124cc5061fbe91; 
 Sun, 05 Jul 2020 18:20:58 +0000 (UTC)
Date: Mon, 6 Jul 2020 02:20:50 +0800
To: Li Guifu <bluce.lee@aliyun.com>, Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [PATCH v11] erofs-utils: introduce segment compression
Message-ID: <20200705182049.GA20632@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200630172758.6533-1-bluce.lee@aliyun.com>
 <20200705083230.5027-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705083230.5027-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16197 hermes_aol Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sun, Jul 05, 2020 at 04:32:30PM +0800, Li Guifu via Linux-erofs wrote:
> Support segment compression which seperates files in several logic
> units (segments) and each segment is compressed independently.
> 
> Advantages:
>  - more friendly for data differencing;
>  - it can also be used for parallel compression in the same file later.
> 
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
> Changes from v10
> - chang variable uncomprofs to clusterofs which only used
>   when write uncompress block

Could you please test the following patch if you're available?
Does it work?

From 0436ed04717853351e13d68db6f170f60e25fc12 Mon Sep 17 00:00:00 2001
From: Li Guifu <bluce.lee@aliyun.com>
Date: Sun, 5 Jul 2020 16:32:30 +0800
Subject: [PATCH v12] erofs-utils: introduce segment compression

Support segment compression which seperates files in several logic
units (segments) and each segment is compressed independently.

Advantages:
 - more friendly for data differencing;
 - it can also be used for parallel compression in the same file later.

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 include/erofs/config.h |  2 ++
 lib/compress.c         | 38 ++++++++++++++++++++++++++++++--------
 lib/config.c           |  1 +
 man/mkfs.erofs.1       |  4 ++++
 mkfs/main.c            | 12 +++++++++++-
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f09749..b149633 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -35,6 +35,8 @@ struct erofs_configure {
 	char *c_img_path;
 	char *c_src_path;
 	char *c_compr_alg_master;
+	u64 c_compr_segsize;
+
 	int c_compr_level_master;
 	int c_force_inodeversion;
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
diff --git a/lib/compress.c b/lib/compress.c
index 6cc68ed..4216fa7 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -32,6 +32,7 @@ struct z_erofs_vle_compress_ctx {
 
 	erofs_blk_t blkaddr;	/* pointing to the next blkaddr */
 	u16 clusterofs;
+	u64 segavail;
 };
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	\
@@ -124,24 +125,33 @@ static int write_uncompressed_block(struct z_erofs_vle_compress_ctx *ctx,
 
 	/* reset clusterofs to 0 if permitted */
 	if (!erofs_sb_has_lz4_0padding() &&
-	    ctx->head >= ctx->clusterofs) {
+	    ctx->clusterofs && ctx->head >= ctx->clusterofs) {
 		ctx->head -= ctx->clusterofs;
 		*len += ctx->clusterofs;
+
+		ctx->segavail += ctx->clusterofs;
+		DBG_BUGON(ctx->segavail > cfg.c_compr_segsize);
+
+		DBG_BUGON(ctx->segavail < EROFS_BLKSIZ);
+		/* so only *len will be the candidate instead of segavail */
+		count = *len;
+
 		ctx->clusterofs = 0;
+	} else {
+		count = min_t(u64, ctx->segavail, *len);
 	}
 
-	/* write uncompressed data */
-	count = min(EROFS_BLKSIZ, *len);
+	if (count > EROFS_BLKSIZ)
+		count = EROFS_BLKSIZ;
 
+	/* fill zero if the uncompressed block isn't full */
 	memcpy(dst, ctx->queue + ctx->head, count);
 	memset(dst + count, 0, EROFS_BLKSIZ - count);
 
 	erofs_dbg("Writing %u uncompressed data to block %u",
 		  count, ctx->blkaddr);
 	ret = blk_write(dst, ctx->blkaddr, 1);
-	if (ret)
-		return ret;
-	return count;
+	return ret ? ret : count;
 }
 
 static int vle_compress_one(struct erofs_inode *inode,
@@ -158,13 +168,20 @@ static int vle_compress_one(struct erofs_inode *inode,
 	while (len) {
 		bool raw;
 
+		if (ctx->segavail <= EROFS_BLKSIZ) {
+			if (len < ctx->segavail && !final)
+				break;
+
+			goto nocompression;
+		}
+
 		if (len <= EROFS_BLKSIZ) {
 			if (final)
 				goto nocompression;
 			break;
 		}
 
-		count = len;
+		count = min_t(u64, len, ctx->segavail);
 		ret = erofs_compress_destsize(h, compressionlevel,
 					      ctx->queue + ctx->head,
 					      &count, dst, EROFS_BLKSIZ);
@@ -195,8 +212,12 @@ nocompression:
 				return ret;
 			raw = false;
 		}
-
 		ctx->head += count;
+		DBG_BUGON(ctx->segavail < count);
+		ctx->segavail -= count;
+		if (!ctx->segavail)
+			ctx->segavail = cfg.c_compr_segsize;
+
 		/* write compression indexes for this blkaddr */
 		vle_write_indexes(ctx, count, raw);
 
@@ -421,6 +442,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
 	ctx.clusterofs = 0;
+	ctx.segavail = cfg.c_compr_segsize;
 	remaining = inode->i_size;
 
 	while (remaining) {
diff --git a/lib/config.c b/lib/config.c
index da0c260..9d4bea1 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -23,6 +23,7 @@ void erofs_init_configure(void)
 	cfg.c_force_inodeversion = 0;
 	cfg.c_inline_xattr_tolerance = 2;
 	cfg.c_unix_timestamp = -1;
+	cfg.c_compr_segsize = -1;
 }
 
 void erofs_show_config(void)
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 891c5a8..8d0fc10 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -48,6 +48,10 @@ Forcely generate compact inodes (32-byte inodes) to output.
 Forcely generate extended inodes (64-byte inodes) to output.
 .RE
 .TP
+.BI "\-S " #
+Set maximum blocks for each individual compress segment.
+The default is 0 (disabled).
+.TP
 .BI "\-T " #
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6..0265ae9 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -61,6 +61,7 @@ static void usage(void)
 	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]         X=extended options\n"
 	      " -T#               set a fixed UNIX timestamp # to all files\n"
+	      " -S#               Set maximum blocks for each individual compress segment\n"
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
@@ -188,6 +189,15 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
+		case 'S':
+			i = strtoll(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid blocks per compress segment %s",
+					  optarg);
+				return -EINVAL;
+			}
+			cfg.c_compr_segsize = i ? blknr_to_addr(i) : -1;
+			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.24.0



