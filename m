Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113B751F96
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 13:11:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1sNs6LL0z3c3f
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 21:11:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1sNl2DFDz3c2x
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 21:11:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VnHQ8Cp_1689246646;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnHQ8Cp_1689246646)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 19:10:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: add github issue/pull-request templates
Date: Thu, 13 Jul 2023 19:10:46 +0800
Message-Id: <20230713111046.62793-1-hsiangkao@linux.alibaba.com>
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

EROFS Development is currently on the mailing list _only_.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 .github/ISSUE_TEMPLATE.txt        | 9 +++++++++
 .github/PULL_REQUEST_TEMPLATE.txt | 9 +++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 .github/ISSUE_TEMPLATE.txt
 create mode 100644 .github/PULL_REQUEST_TEMPLATE.txt

diff --git a/.github/ISSUE_TEMPLATE.txt b/.github/ISSUE_TEMPLATE.txt
new file mode 100644
index 0000000..0e736fb
--- /dev/null
+++ b/.github/ISSUE_TEMPLATE.txt
@@ -0,0 +1,9 @@
+Please **do not** send pull-requests or open new issues on Github.
+
+Besides, the current erofs-utils repo is:
+git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+Github is not _the place_ for EROFS development, and some mirrors
+are actually unofficial and not frequently monitored.
+
+* Send bug reports and/or feedback to: linux-erofs@lists.ozlabs.org
diff --git a/.github/PULL_REQUEST_TEMPLATE.txt b/.github/PULL_REQUEST_TEMPLATE.txt
new file mode 100644
index 0000000..0e736fb
--- /dev/null
+++ b/.github/PULL_REQUEST_TEMPLATE.txt
@@ -0,0 +1,9 @@
+Please **do not** send pull-requests or open new issues on Github.
+
+Besides, the current erofs-utils repo is:
+git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+Github is not _the place_ for EROFS development, and some mirrors
+are actually unofficial and not frequently monitored.
+
+* Send bug reports and/or feedback to: linux-erofs@lists.ozlabs.org
-- 
2.24.4

