Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90FA47B6
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj7K58ZHzDqsp
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317197;
	bh=LVCVoQG62aIkWWt4A4R8oS16Pd+iGevRYihqZLj8uE4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JmDvdCOnfpNs25yHi5KmB2w4TtVm6UY2ArDqL13gGnGJZN6jW7TtQGVqRV53bgPUl
	 Uq6pxQ/DgT7yiGXPLuh/Y1WweZbb8f1i6gBjMgNE6oE5lsl+GzMHJpNNDRHPEbP+Sr
	 CzzBAOc05sxjl5avOD/4NMuXVEw4CoYMgr/5vfAtIgRriMJmXrbgELLSQKuESTGg0b
	 TOL6W9qrJ4T94BZlosUID3b4Dff0MN8DLQjl932xBQnWk5Fi2Elp30NSJXAyGM0Qek
	 AyRcyEailGOZCVHJsbj1WNJHazVxnVRHtFg0pBZ390ahq3sze3BhOjQhQUy8bicqsU
	 0hS9YUK7L2Gww==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="rl4KOY4l"; 
 dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6p6p6kzDqsL
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317165; bh=bYGgbUkpYatgcwL6URU/dubCdNrEU0TuOnNro854EfY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=rl4KOY4lM7ZrLdBU0izAjz+sU2EuhRICXLFz2E2MLdnwpp7Mn9fIPGus8pvS29wUbe8i+yrIWGD/2oSAK+SCGyFpPIanID+ZZ4Up3jqEOfeYRHFAAcrJPRo4dU/iv7WdTUNo+t4zqzHQ4vjNHnI3J8XbErk8ZzANotbTZoZVZaTHsOqDyx6/1LhLQrSTIzNXoUkCN8D3GCPpsjITgxstvLeZkBiZ5rdNQ8IcYZsILsLc1FAcQo2BFEDkoJsv8OLiu1MvvEIXdYPwlsm5LowCY2HgBdubZRcWxZIyX3DDHWXuy+RX06I+gNGunJmqoVM24hdVUYY69Y5/6VfJSJ9/qg==
X-YMail-OSG: IC0uT7EVM1m1o32FvlT6x3EAXzOIEpnZdF6fgPBQ_5PD54Rxfx9Gim0t7X1W7zI
 NZZF5.8Clla8YAOY9pjaNeKHAwA_wP5INOANqq9FiLntQQfvp.CmKSK2yL_a_qTkO7B5wDrzkRMH
 jY7ykuO5MYjiD7bRnc1DyvN2oXeF.Cy1PBSuJgIZQE3Cfys5yh4lY4gUqUxDVNMNlR_ileIlfbPA
 7y7.hpd0Dhe2fpl7LLbnSH6r2th7zc3fpZu6odRdXVMvsvSbf5NjZoMt80Rd.5pTDuiMknypCkOY
 oWLFMcdzO9IYnJa_nef6SQyJx3qJuTmcBkRt_gwAMMOSU.seCXpfWNIBEFdcr56mKf5wuBRfYeW4
 1zYX1DVNj6rxNHPpQOiDHESjDf9ShaSyKTaUB0C0k.V_rUV92hPrBpausKIJmTzoGU8WwqFEZT96
 7qh_4FPTDybxCb8GR8B7a6RlEgZnyhKOnlyqIT8V5Gwbqo43Lp96n.qEnMMruu1yQ8jxx8uZ4Fb6
 nQFoB06UgxCQSAZGbgOvzjrprFvf.PJ_ZBdVaOx0okWljF5tRfwEoEKNKb8W_.Bt_fVqGdQYd6Uo
 hqiHnAhNpZnhQTe1FRXTal2pgrvN599y4mKfuDO7PSwV4rQ_jl8zwVrGNZuYDz2yez7XHI.VcTNK
 9sx7MKwe9_Y1xxd3x1sP2m_I9u6lLARO8RnXbKcupXJ6usQciWqTu_R3quCEqIr59cZQQG7lFLXo
 7kCcv7RsOoLYoyO.A2EyI_yGbLa3c.LGsfh3qVMcVpcXTPg_xFk6pDcfFr3N4jXotsGAe5kYSboV
 _kEThYWrTZxGrRfzd8i86Wn5zI6sGDivNiQBjiNtmvpn_LJHLOA6CwsLCEgl6I4S.Tc4VpaUBKE9
 NtzAvHx6bvt19ApGdmdbZdxOUzbT9Xlxe2M.NgD1231_D1KjXfNSbizhfNUoryJwGgjCLKxuHKGl
 0RG_CrHnYnI3czEeaPPK4IbJv84bVZtIGlUr1TTSiUaBX6_QGwdwihR2GPJd54U.KHi7aYr7CNlm
 6wHwrKM8Cxyput4UkuRAyUr5un_ovBkib0hHG0gM9j5lA.h_xwqIJS3xsmJP8bOgMqFAjwVtmAIy
 YtwcnV9anlraMRpnb8ehmcEE9Q3dSkWyo9zlUQgJMMcYaHUcWg05arPcuesg0FuBSmEizQIFWup.
 sSJK7YX9860s2C69O2kx6KQ5W0gZAYWOhmtK0F3xDyK2ZO3EgNntVQViD3pk.3.WRDrojkT62zXA
 4pMEVL5rv6IGFG.OUYA1D5ip3ogrR.oV2GBXP.g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:45 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:43 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/21] erofs: use dsb instead of layout for ondisk super_block
Date: Sun,  1 Sep 2019 13:51:20 +0800
Message-Id: <20190901055130.30572-12-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph pointed out [1], "Why is the variable name
for the on-disk subperblock layout? We usually still
calls this something with sb in the name, e.g. dsb.
for disksuper block. " Let's fix it.

[1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8c43af5d5e57..c1a42ea7b72f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -47,9 +47,9 @@ static void free_inode(struct inode *inode)
 }
 
 static bool check_layout_compatibility(struct super_block *sb,
-				       struct erofs_super_block *layout)
+				       struct erofs_super_block *dsb)
 {
-	const unsigned int requirements = le32_to_cpu(layout->requirements);
+	const unsigned int requirements = le32_to_cpu(dsb->requirements);
 
 	EROFS_SB(sb)->requirements = requirements;
 
@@ -66,7 +66,7 @@ static int superblock_read(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
 	struct buffer_head *bh;
-	struct erofs_super_block *layout;
+	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	int ret;
 
@@ -78,16 +78,16 @@ static int superblock_read(struct super_block *sb)
 	}
 
 	sbi = EROFS_SB(sb);
-	layout = (struct erofs_super_block *)((u8 *)bh->b_data
-		 + EROFS_SUPER_OFFSET);
+	dsb = (struct erofs_super_block *)((u8 *)bh->b_data +
+					   EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
-	if (le32_to_cpu(layout->magic) != EROFS_SUPER_MAGIC_V1) {
+	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		errln("cannot find valid erofs superblock");
 		goto out;
 	}
 
-	blkszbits = layout->blkszbits;
+	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
 		errln("blksize %u isn't supported on this platform",
@@ -95,25 +95,25 @@ static int superblock_read(struct super_block *sb)
 		goto out;
 	}
 
-	if (!check_layout_compatibility(sb, layout))
+	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
-	sbi->blocks = le32_to_cpu(layout->blocks);
-	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
+	sbi->blocks = le32_to_cpu(dsb->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
-	sbi->xattr_blkaddr = le32_to_cpu(layout->xattr_blkaddr);
+	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 #endif
 	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
-	sbi->root_nid = le16_to_cpu(layout->root_nid);
-	sbi->inos = le64_to_cpu(layout->inos);
+	sbi->root_nid = le16_to_cpu(dsb->root_nid);
+	sbi->inos = le64_to_cpu(dsb->inos);
 
-	sbi->build_time = le64_to_cpu(layout->build_time);
-	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
+	sbi->build_time = le64_to_cpu(dsb->build_time);
+	sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
 
-	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
+	memcpy(&sb->s_uuid, dsb->uuid, sizeof(dsb->uuid));
 
-	ret = strscpy(sbi->volume_name, layout->volume_name,
-		      sizeof(layout->volume_name));
+	ret = strscpy(sbi->volume_name, dsb->volume_name,
+		      sizeof(dsb->volume_name));
 	if (ret < 0) {	/* -E2BIG */
 		errln("bad volume name without NIL terminator");
 		ret = -EFSCORRUPTED;
-- 
2.17.1

