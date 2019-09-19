Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB1EB732B
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2019 08:30:12 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Yn5Y3KnZzF4f2
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2019 16:30:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Yn5S3R8zzF0Ql
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2019 16:30:01 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B89A9442E70042431BFE;
 Thu, 19 Sep 2019 14:29:55 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 19 Sep
 2019 14:29:48 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] MAINTAINERS: erofs: complete sub-entries for erofs
Date: Thu, 19 Sep 2019 14:28:38 +0800
Message-ID: <20190919062838.106423-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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

Add a formal git tree and missing files for erofs
after moving out of staging for everyone to blame
in order for better improvement.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b6f10ea1573..a3822e1866d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6088,7 +6088,10 @@ M:	Gao Xiang <gaoxiang25@huawei.com>
 M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
+F:	Documentation/filesystems/erofs.txt
 F:	fs/erofs/
+F:	include/trace/events/erofs.h
 
 ERRSEQ ERROR TRACKING INFRASTRUCTURE
 M:	Jeff Layton <jlayton@kernel.org>
-- 
2.17.1

