Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B0792051
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 06:39:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rft7S4wqCz30f9
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 14:39:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rft7M3f4pz2xdg
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 14:38:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrOAXQm_1693888722;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrOAXQm_1693888722)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 12:38:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: don't warn dedupe and fragments features anymore
Date: Tue,  5 Sep 2023 12:38:40 +0800
Message-Id: <20230905043840.61616-1-hsiangkao@linux.alibaba.com>
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

Keep in sync with kernel commit 5ec693ca70dd ("erofs: don't warn
dedupe and fragments features anymore").

Except that erofs.mkfs is still single-threaded as a limitation for
backup use cases.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4352e62..607c883 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -843,10 +843,7 @@ int main(int argc, char **argv)
 			erofs_err("failed to initialize fragments");
 			return 1;
 		}
-		erofs_warn("EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
 	}
-	if (cfg.c_dedupe)
-		erofs_warn("EXPERIMENTAL data deduplication feature in use. Use at your own risk!");
 
 #ifndef NDEBUG
 	if (cfg.c_random_pclusterblks)
-- 
2.24.4

