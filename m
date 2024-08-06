Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C5948D92
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 13:22:28 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VZd4zgea;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdW9t1yMVz3cW7
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 21:22:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VZd4zgea;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdW9k4hxBz30T3
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 21:22:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722943332; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WOJsl5d16hB4z/FHaK4q8Q1Y8rTOZLkXiP+T1sEI0QQ=;
	b=VZd4zgeaZmnKkOS+UdwFLMNciVzS/tdu/5eiUDpbE25l19aPAdMUca2AR55RMZy6Jf3wMqP3Ppb4o+7EUff4rkmZFRQiF6lHpHcLOVxEqCxrCVPl5oYRMAShEO8KjVHhY3zT4i4PpSBVotEC/5pwEcCCMDBiZWDnKQgHRB1vrUk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WCFH63g_1722943329;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WCFH63g_1722943329)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 19:22:10 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: get rid of check_layout_compatibility()
Date: Tue,  6 Aug 2024 19:22:08 +0800
Message-ID: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Simple enough to just open-code it.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fs/erofs/super.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 32ce5b35e1df..6cb5c8916174 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -108,22 +108,6 @@ static void erofs_free_inode(struct inode *inode)
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
-static bool check_layout_compatibility(struct super_block *sb,
-				       struct erofs_super_block *dsb)
-{
-	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
-
-	EROFS_SB(sb)->feature_incompat = feature;
-
-	/* check if current kernel meets all mandatory requirements */
-	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
-		erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
-			   feature & ~EROFS_ALL_FEATURE_INCOMPAT);
-		return false;
-	}
-	return true;
-}
-
 /* read variable-sized metadata, offset will be aligned by 4-byte */
 void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 			  erofs_off_t *offset, int *lengthp)
@@ -279,7 +263,7 @@ static int erofs_scan_devices(struct super_block *sb,
 
 static int erofs_read_superblock(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
 	void *data;
@@ -291,9 +275,7 @@ static int erofs_read_superblock(struct super_block *sb)
 		return PTR_ERR(data);
 	}
 
-	sbi = EROFS_SB(sb);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
-
 	ret = -EINVAL;
 	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
 		erofs_err(sb, "cannot find valid erofs superblock");
@@ -318,8 +300,12 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	ret = -EINVAL;
-	if (!check_layout_compatibility(sb, dsb))
+	sbi->feature_incompat = le32_to_cpu(dsb->feature_incompat);
+	if (sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT) {
+		erofs_err(sb, "unidentified incompatible feature %x, please upgrade kernel",
+			  sbi->feature_incompat & ~EROFS_ALL_FEATURE_INCOMPAT);
 		goto out;
+	}
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
 	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
-- 
2.43.5

