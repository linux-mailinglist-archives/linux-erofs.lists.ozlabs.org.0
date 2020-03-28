Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE1E196388
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2020 05:18:26 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48q57M6pLbzDrFr
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2020 15:18:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48q57B4XJRzDqNN
 for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2020 15:18:10 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7127A9B55272DCE6073D;
 Sat, 28 Mar 2020 12:02:43 +0800 (CST)
Received: from localhost.localdomain (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 28 Mar
 2020 12:02:36 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] MAINTAINERS: erofs: update my email address
Date: Sat, 28 Mar 2020 12:00:36 +0800
Message-ID: <20200328040036.117974-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This email address will not be available in a few days.
Update my own email address to xiang@kernel.org, which
should be available all the time.

Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..f82cc2a36fb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6249,7 +6249,7 @@ F:	drivers/video/fbdev/s1d13xxxfb.c
 F:	include/video/s1d13xxxfb.h
 
 EROFS FILE SYSTEM
-M:	Gao Xiang <gaoxiang25@huawei.com>
+M:	Gao Xiang <xiang@kernel.org>
 M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
-- 
2.17.1

