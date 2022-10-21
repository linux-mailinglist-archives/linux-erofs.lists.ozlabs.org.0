Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C85606DA2
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpD43zYSz3dqW
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666318996;
	bh=tVer8AZTrK9nyCudHIpk3LZZ7sbS0elDElqNKzjcfkQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aLg/+4asW5AKs3vX1K8LWejwxIZzW95KWtfokvuHFrW3q79Yjb9YbNNd1JKvN9mzr
	 eZXaiDoCzvucepkLTajAqDtMi/iVMPnA50iFGE/DCXeRGyXUKPudj6mp26pw4q5xde
	 3vVsn7gw+ytkDHj1u41yIiC5RxmFb/HV/8ji1Vl3JgqJE8W3c3hin7fp6oYzR6sAEX
	 TWdgKnXEPgPXz2YhjAA2MAi7uqofO9p/P7AmbNV/xsUVz3tIi10o5t58rRFWmC1wfO
	 iHVc0dgfIegN98fJ69KE5qpt/mmbTKM5lAQv4alzd9nNBTh5Na16YIR5sIebOnZcDy
	 UumBJeKeX0nUw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpCc4nY9z2yxd
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:22:52 +1100 (AEDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpCM5YgKzHv3Y;
	Fri, 21 Oct 2022 10:22:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:39 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] kobject: fix possible memory leak in kset_create_and_add()
Date: Fri, 21 Oct 2022 10:20:55 +0800
Message-ID: <20221021022102.2231464-5-yangyingliang@huawei.com>
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

Inject fault while loading module (e.g. qemu_fw_cfg.ko), kset_register()
may fail in kset_create_and_add(), if it fails, but the refcount of kobject
is not decreased to 0, the name allocated in kset_create() is leaked. To fix
this by calling kset_put(), so that name can be freed in callback function
kobject_cleanup() and kset can be freed in kset_release().

unreferenced object 0xffff888103cc8c08 (size 8):
  comm "modprobe", pid 508, jiffies 4294915182 (age 120.020s)
  hex dump (first 8 bytes):
    62 79 5f 6e 61 6d 65 00                          by_name.
  backtrace:
    [<00000000572f97f9>] __kmalloc_track_caller+0x1ae/0x320
    [<00000000a167a5cc>] kstrdup+0x3a/0x70
    [<000000001cd0d05e>] kstrdup_const+0x68/0x80
    [<00000000b9101e6d>] kvasprintf_const+0x10b/0x190
    [<0000000088f2b8df>] kobject_set_name_vargs+0x56/0x150
    [<000000003f8aca68>] kobject_set_name+0xab/0xe0
    [<00000000249f7816>] kset_create_and_add+0x72/0x200

Fixes: b727c702896f ("kset: add kset_create_and_add function")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/kobject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 6da04353d974..e77f37200876 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -985,7 +985,7 @@ struct kset *kset_create_and_add(const char *name,
 		return NULL;
 	error = kset_register(kset);
 	if (error) {
-		kfree(kset);
+		kset_put(kset);
 		return NULL;
 	}
 	return kset;
-- 
2.25.1

