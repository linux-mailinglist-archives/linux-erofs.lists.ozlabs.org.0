Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2AE606DAD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpDq1qLMz3cBR
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666319035;
	bh=xzMFxLeFKUbQzHCjgeZFy2Z3JsN/mOjM/Yn4m8OkMjM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LrZdI0iUXcxs3pNZZbbvSQbxo6HHryVH0Rg+oSsBHFLg924MHSAuu9ocjb/K9bVYW
	 H2cceDh2eOZSk9nbLxPmtA0O5ardgrrfmHYVj90moemHJILe4R/uJ+iAjuWyWm1KcL
	 wvLgXEP9u7koc9Eo2VxJZaCBMQRw/jhIpH7Ic1sEB/Y5wCBgY7os/WiT4oSSg6HpbE
	 F2vnkP0cpgV+PGkhcTbgByqk5g4UyidbW9Es3+xGv7oSw4vl0q8KjFSr2ddwfG+jxl
	 KgdiV02uGnHv4x2yQvHOfkwVV6d3QinotKocOy668fKmvnvhB3DiJB7OQigmGerBu3
	 iYm2GbZg3a5pQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpD86jC2z3drV
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:23:20 +1100 (AEDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtp6h64dWzVj27;
	Fri, 21 Oct 2022 10:18:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:44 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] ocfs2: possible memory leak in mlog_sys_init()
Date: Fri, 21 Oct 2022 10:21:00 +0800
Message-ID: <20221021022102.2231464-10-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021022102.2231464-1-yangyingliang@huawei.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
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
From: Yang Yingliang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yang Yingliang <yangyingliang@huawei.com>
Cc: alexander.deucher@amd.com, richard@nod.at, mst@redhat.com, gregkh@linuxfoundation.org, somlo@cmu.edu, huangjianan@oppo.com, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, luben.tuikov@amd.com, jlbec@evilplan.org, hsiangkao@linux.alibaba.com, rafael@kernel.org, jaegeuk@kernel.org, akpm@linux-foundation.org, mark@fasheh.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Inject fault while loading module, kset_register() may fail,
if it fails, but the refcount of kobject is not decreased to
0, the name allocated in kobject_set_name() is leaked. Fix
this by calling kset_put(), so that name can be freed in
callback function kobject_cleanup().

unreferenced object 0xffff888100da9348 (size 8):
  comm "modprobe", pid 257, jiffies 4294701096 (age 33.334s)
  hex dump (first 8 bytes):
    6c 6f 67 6d 61 73 6b 00                          logmask.
  backtrace:
    [<00000000306e441c>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000007c491a9e>] kstrdup+0x3a/0x70
    [<0000000015719a3b>] kstrdup_const+0x63/0x80
    [<0000000084e458ea>] kvasprintf_const+0x149/0x180
    [<0000000091302b42>] kobject_set_name_vargs+0x56/0x150
    [<000000005f48eeac>] kobject_set_name+0xab/0xe0

Fixes: 34980ca8faeb ("Drivers: clean up direct setting of the name of a kset")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/ocfs2/cluster/masklog.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..7f9ba816d955 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -156,6 +156,7 @@ static struct kset mlog_kset = {
 int mlog_sys_init(struct kset *o2cb_kset)
 {
 	int i = 0;
+	int ret;
 
 	while (mlog_attrs[i].attr.mode) {
 		mlog_default_attrs[i] = &mlog_attrs[i].attr;
@@ -165,7 +166,11 @@ int mlog_sys_init(struct kset *o2cb_kset)
 
 	kobject_set_name(&mlog_kset.kobj, "logmask");
 	mlog_kset.kobj.kset = o2cb_kset;
-	return kset_register(&mlog_kset);
+	ret = kset_register(&mlog_kset);
+	if (ret)
+		kset_put(&mlog_kset);
+
+	return ret;
 }
 
 void mlog_sys_shutdown(void)
-- 
2.25.1

