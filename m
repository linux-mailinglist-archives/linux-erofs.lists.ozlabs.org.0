Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12B606DAB
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpDb1wsJz3cfX
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666319023;
	bh=1tpP1hkNdWvN34AYxj6RVP7WehDDZKUj72Nls7FxEGk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WwOX+T7dFa2MeQ+NKExTbR3e6VtfryJZ+8DCk9B+XDdfXdR7bk4GM/0JGAy7+90th
	 5J1Vr+Ikymv+BcELgcWD01n5SbLjyb8IJsWk7Z9rfJfCPJPauvyESxZJBv9K1mk05X
	 9qb7NKO+NnUIYQ+klkMNmyBvLVsfrb5yHxSv/kC1IEemEKrgzbC3UZxtuzlYXMeNjm
	 MtsOeAZHqla/19Y1dJ4bYnUOHDJYKgPhOqbsjilu+zuty44uRQJbM5WEZtDUwFglxG
	 l3UJ5mbOV/YTpeQ77M/+oYk6Oji40pVkRkbHLa2Uluw4exZM1MMDbY8UELg/53wdO1
	 WRn3PP6FZcnAQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpD45tDZz3c7L
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:23:16 +1100 (AEDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtp7b16HRzpVdt;
	Fri, 21 Oct 2022 10:19:23 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:43 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:42 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] f2fs: fix possible memory leak in f2fs_init_sysfs()
Date: Fri, 21 Oct 2022 10:20:58 +0800
Message-ID: <20221021022102.2231464-8-yangyingliang@huawei.com>
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

unreferenced object 0xffff888101b7cc80 (size 8):
  comm "modprobe", pid 252, jiffies 4294691378 (age 31.760s)
  hex dump (first 8 bytes):
    66 32 66 73 00 88 ff ff                          f2fs....
  backtrace:
    [<000000001db5b408>] __kmalloc_node_track_caller+0x44/0x1b0
    [<000000002783a073>] kstrdup+0x3a/0x70
    [<00000000ead2b281>] kstrdup_const+0x63/0x80
    [<000000003e5cf8f7>] kvasprintf_const+0x149/0x180
    [<00000000c4d949ff>] kobject_set_name_vargs+0x56/0x150
    [<0000000044611660>] kobject_set_name+0xab/0xe0

Fixes: bf9e697ecd42 ("f2fs: expose features to sysfs entry")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..2ef7a48967be 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1250,8 +1250,10 @@ int __init f2fs_init_sysfs(void)
 	kobject_set_name(&f2fs_kset.kobj, "f2fs");
 	f2fs_kset.kobj.parent = fs_kobj;
 	ret = kset_register(&f2fs_kset);
-	if (ret)
+	if (ret) {
+		kset_put(&f2fs_kset);
 		return ret;
+	}
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-- 
2.25.1

