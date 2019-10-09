Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59638D0C3E
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 12:10:00 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46p91x4KK4zDqMT
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 21:09:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46p91k18rKzDqJW
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2019 21:09:45 +1100 (AEDT)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B179628F7992AE7089D9;
 Wed,  9 Oct 2019 18:09:41 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 18:09:35 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, 
 Chao Yu <yuchao0@huawei.com>
Subject: [PATCH for-4.19 3/4] staging: erofs: add two missing
 erofs_workgroup_put for corrupted images
Date: Wed, 9 Oct 2019 18:12:38 +0800
Message-ID: <20191009101239.195587-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009101239.195587-1-gaoxiang25@huawei.com>
References: <20191009101239.195587-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 138e1a0990e80db486ab9f6c06bd5c01f9a97999 upstream.

As reported by erofs-utils fuzzer, these error handling
path will be entered to handle corrupted images.

Lack of erofs_workgroup_puts will cause unmounting
unsuccessfully.

Fix these return values to EFSCORRUPTED as well.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-4-gaoxiang25@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Gao Xiang: Older kernel versions don't have length validity check
             and EFSCORRUPTED, thus backport pageofs check for now. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index fc44f5ce670b..7bd406f34f8b 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -311,7 +311,11 @@ z_erofs_vle_work_lookup(struct super_block *sb,
 	/* if multiref is disabled, `primary' is always true */
 	primary = true;
 
-	DBG_BUGON(work->pageofs != pageofs);
+	if (work->pageofs != pageofs) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(egrp);
+		return ERR_PTR(-EIO);
+	}
 
 	/*
 	 * lock must be taken first to avoid grp->next == NIL between
-- 
2.17.1

