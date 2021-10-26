Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8D43AAC8
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 05:40:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HdczF5V5yz2y8P
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Oct 2021 14:40:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hdcz61tfDz2xYM
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 Oct 2021 14:40:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UtjbVS1_1635219591; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtjbVS1_1635219591) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 26 Oct 2021 11:39:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: sort out contact information
Date: Tue, 26 Oct 2021 11:39:49 +0800
Message-Id: <20211026033949.100020-1-hsiangkao@linux.alibaba.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, Yue Hu <huyue2@yulong.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs-utils was a project once initially developed by our
filesystem team.

As far as I know, Chao Yu and Li Guifu has left from HUAWEI,
so update the correct email addresses.

I'm not sure if other people on the list still have free slots
working on this project, ping them here.

Code review and new reviewer are always welcome for everyone if
you have time.

Cc: Miao Xie <miaoxie@huawei.com>
Cc: Fang Wei <fangwei1@huawei.com>
Cc: Yue Hu <huyue2@yulong.com>
Cc: Huang Jianan <huangjianan@oppo.com>
Cc: Daeho Jeong <daehojeong@google.com>
Cc: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 AUTHORS | 10 +++++-----
 README  | 11 +----------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/AUTHORS b/AUTHORS
index dacbddaf694a..812042a0c1f1 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -1,8 +1,8 @@
 EROFS USERSPACE UTILITIES
-M: Li Guifu <bluce.liguifu@huawei.com>
-M: Miao Xie <miaoxie@huawei.com>
-M: Fang Wei <fangwei1@huawei.com>
-R: Gao Xiang <xiang@kernel.org>
-R: Chao Yu <yuchao0@huawei.com>
+M: Li Guifu <bluce.lee@aliyun.com>
+M: Gao Xiang <xiang@kernel.org>
+R: Chao Yu <chao@kernel.org>
+R: Miao Xie <miaoxie@huawei.com>
+R: Fang Wei <fangwei1@huawei.com>
 S: Maintained
 L: linux-erofs@lists.ozlabs.org
diff --git a/README b/README
index 7b641f7076d3..3f8301006ccc 100644
--- a/README
+++ b/README
@@ -165,17 +165,8 @@ Contribution
 ------------
 
 erofs-utils is under GPLv2+ as a part of EROFS filesystem project,
-feel free to send patches or feedback to us.
-
-To:
+feel free to send patches or feedback to:
   linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
-  Li Guifu                   <bluce.liguifu@huawei.com>
-  Miao Xie                   <miaoxie@huawei.com>
-  Fang Wei                   <fangwei1@huawei.com>
-
-Cc:
-  Gao Xiang                  <xiang@kernel.org>
-  Chao Yu                    <yuchao0@huawei.com>
 
 Comments
 --------
-- 
2.24.4

