Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4566F606DA4
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 04:23:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtpDC0Rppz3dqr
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 13:23:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666319003;
	bh=dyGVpi/cxfdKsPC0auDFM0qgMAIU47NidVfdyPK5ykE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=O1wV1uT2ZhKwSXXRFMDRTTIAjteZiZrp40/6S7sOiWf3TSn7lE0Oo2s1y32Eq4Run
	 mGGu8ogl4rY6aZcUDLl9+BWCbvgFqRnpelk1GZfWrbIW3JtQAJhzj9Wu1A81l09ImB
	 lnOSlEobIb2NLbh4Lv3HMrPp1VnhKH9KlEj4jzDQVzFHjcWk/IL/d/ScMuVn53l4ho
	 29UeOTt93GiWS5PutkW708ggUUA9l1pMC+lz6AWhfZwkzZIEt9STb+ONyyVMC+AzJe
	 gy1foiztiKiOmuRI+YC2sLoxXiWk/gZ/CG7bPvOuOQnSpQa9pWW32PwwdnSE5bnVRj
	 5KjNeOo0eTvPw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtpCc5LnMz3c7V
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 13:22:52 +1100 (AEDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtpCN0WmtzHvCB;
	Fri, 21 Oct 2022 10:22:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:22:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:22:36 +0800
To: <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-erofs@lists.ozlabs.org>,
	<ocfs2-devel@oss.oracle.com>, <linux-mtd@lists.infradead.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] kset: fix documentation for kset_register()
Date: Fri, 21 Oct 2022 10:20:52 +0800
Message-ID: <20221021022102.2231464-2-yangyingliang@huawei.com>
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

kset_register() is currently used in some places without calling
kset_put() in error path, because the callers think it should be
kset internal thing to do, but the driver core can not know what
caller doing with that memory at times. The memory could be freed
both in kset_put() and error path of caller, if it is called in
kset_register().

So make the function documentation more explicit about calling
kset_put() in the error path of caller.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 lib/kobject.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index a0b2dbfcfa23..6da04353d974 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
 /**
  * kset_register() - Initialize and add a kset.
  * @k: kset.
+ *
+ * If this function returns an error, kset_put() must be called to
+ * properly clean up the memory associated with the object.
  */
 int kset_register(struct kset *k)
 {
-- 
2.25.1

