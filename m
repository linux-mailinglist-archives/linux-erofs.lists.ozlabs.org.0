Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9068FE04
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 04:35:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC2ZN618Nz3chB
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 14:35:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC2ZJ18F6z3bVJ
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 14:35:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VbENOuR_1675913725;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VbENOuR_1675913725)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:35:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: don't skip `lost+found`
Date: Thu,  9 Feb 2023 11:35:24 +0800
Message-Id: <20230209033524.38234-1-hsiangkao@linux.alibaba.com>
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

It's somewhat strange to skip the `lost+found` directory.

Fixes: a17497f0844a ("erofs-utils: introduce inode operations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 87613c6..6fd28a2 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1082,8 +1082,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		if (!dp)
 			break;
 
-		if (is_dot_dotdot(dp->d_name) ||
-		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
+		if (is_dot_dotdot(dp->d_name))
 			continue;
 
 		/* skip if it's a exclude file */
-- 
2.24.4

