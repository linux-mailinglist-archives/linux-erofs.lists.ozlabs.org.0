Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664F782428
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 09:09:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTk9t0cNhz30M1
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 17:09:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RTk9l6lBzz2yDS
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Aug 2023 17:09:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqC3Pih_1692601742;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqC3Pih_1692601742)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 15:09:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: sbi->devs should be cleared after freed
Date: Mon, 21 Aug 2023 15:09:01 +0800
Message-Id: <20230821070901.121008-1-hsiangkao@linux.alibaba.com>
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

Otherwise, it could cause double-free if sbi reuses
when fuzzing [1].

[1] https://github.com/erofs/erofsnightly/actions/runs/5921003885/job/16053013007
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index 58e2574..6c5b073 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -123,14 +123,18 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		return ret;
 
 	ret = erofs_xattr_prefixes_init(sbi);
-	if (ret)
+	if (ret) {
 		free(sbi->devs);
+		sbi->devs = NULL;
+	}
 	return ret;
 }
 
 void erofs_put_super(struct erofs_sb_info *sbi)
 {
-	if (sbi->devs)
+	if (sbi->devs) {
 		free(sbi->devs);
+		sbi->devs = NULL;
+	}
 	erofs_xattr_prefixes_cleanup(sbi);
 }
-- 
2.24.4

