Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE951606DAC
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpDh4WV6z3cfv
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666319028;
	bh=Le9tPcdohqK3UOrnanVaHtQhl6eTkZN7tCulrd3hy6g=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=niHB4PaQWfSSx5BWOaxUhR83T7ROGcZMK7rzix2AFy1fjSwAorIQeS74uBOX+EdRy
	 c3Iu1C7NAI+LlDkTXW4fKFICkU343nLiWIKZK9jFlbOoi0om7Cz6VT49GqggAsN5N4
	 +BEd4Aq3xtAYAwx1LfKxmm6qfdQaHUS8dMXjDF9/fBeySm/gO0sJhdN98BRV7K072T
	 1RXBsUQQCPT++9xw+YhreppzC6JRhPuaAElvcVz1nPPr4U1AOxaRFO/6Ds+cRZITl0
	 tLoe+bTGo7IZkaBf8yVPCf0BhFRby+pta69A72xMARWFrFZC3LBzZksu6pe4TR27fv
	 26EIC1Qjw1KHw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpD82wq2z3drV
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:23:20 +1100 (AEDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtp605R63zmVCd;
	Fri, 21 Oct 2022 10:18:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:46 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:46 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] ubifs: Fix memory leak in ubifs_sysfs_init()
Date: Fri, 21 Oct 2022 10:21:02 +0800
Message-ID: <20221021022102.2231464-12-yangyingliang@huawei.com>
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

From: Liu Shixin <liushixin2@huawei.com>

When insmod ubifs.ko, a kmemleak reported as below:

 unreferenced object 0xffff88817fb1a780 (size 8):
   comm "insmod", pid 25265, jiffies 4295239702 (age 100.130s)
   hex dump (first 8 bytes):
     75 62 69 66 73 00 ff ff                          ubifs...
   backtrace:
     [<ffffffff81b3fc4c>] slab_post_alloc_hook+0x9c/0x3c0
     [<ffffffff81b44bf3>] __kmalloc_track_caller+0x183/0x410
     [<ffffffff8198d3da>] kstrdup+0x3a/0x80
     [<ffffffff8198d486>] kstrdup_const+0x66/0x80
     [<ffffffff83989325>] kvasprintf_const+0x155/0x190
     [<ffffffff83bf55bb>] kobject_set_name_vargs+0x5b/0x150
     [<ffffffff83bf576b>] kobject_set_name+0xbb/0xf0
     [<ffffffff8100204c>] do_one_initcall+0x14c/0x5a0
     [<ffffffff8157e380>] do_init_module+0x1f0/0x660
     [<ffffffff815857be>] load_module+0x6d7e/0x7590
     [<ffffffff8158644f>] __do_sys_finit_module+0x19f/0x230
     [<ffffffff815866b3>] __x64_sys_finit_module+0x73/0xb0
     [<ffffffff88c98e85>] do_syscall_64+0x35/0x80
     [<ffffffff88e00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

When kset_register() failed, we should call kset_put to cleanup it.

Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/ubifs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 06ad8fa1fcfb..54270ad36321 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -144,6 +144,8 @@ int __init ubifs_sysfs_init(void)
 	kobject_set_name(&ubifs_kset.kobj, "ubifs");
 	ubifs_kset.kobj.parent = fs_kobj;
 	ret = kset_register(&ubifs_kset);
+	if (ret)
+		kset_put(&ubifs_kset);
 
 	return ret;
 }
-- 
2.25.1

