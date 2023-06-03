Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B195E721031
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Jun 2023 15:32:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QYLPq2fxYz3f0v
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Jun 2023 23:31:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QYLPg11jRz3drW
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Jun 2023 23:31:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VkDiWkg_1685799091;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkDiWkg_1685799091)
          by smtp.aliyun-inc.com;
          Sat, 03 Jun 2023 21:31:40 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: refuse block sizes larger than EROFS_MAX_BLOCK_SIZE
Date: Sat,  3 Jun 2023 21:31:29 +0800
Message-Id: <20230603133130.34364-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The maximum supported block size is EROFS_MAX_BLOCK_SIZE.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index 17f849e..5f70686 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -88,15 +88,14 @@ int erofs_read_superblock(void)
 	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
 
 	sbi.blkszbits = dsb->blkszbits;
-	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (sbi.blkszbits < 9) {
+	if (sbi.blkszbits < 9 ||
+	    (1 << sbi.blkszbits) > EROFS_MAX_BLOCK_SIZE) {
 		erofs_err("blksize %d isn't supported on this platform",
 			  erofs_blksiz());
 		return ret;
-	}
-
-	if (!check_layout_compatibility(&sbi, dsb))
+	} else if (!check_layout_compatibility(&sbi, dsb)) {
 		return ret;
+	}
 
 	sbi.primarydevice_blocks = le32_to_cpu(dsb->blocks);
 	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
-- 
2.24.4

