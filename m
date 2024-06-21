Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F6911BCF
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 08:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1718951508;
	bh=MqfSMqccXAm/XJp99RXb4t5BLqEZBGtjSrOSJi32K08=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=GxM5rcXYye1XJmhYxVUNIcZXi1GTrNUW+w5AYDfMS6n/qb5CPrn40tpvdZv9Ta+ys
	 umv0tAixGWaLk205V8IioJDaXMF4IlGmYqJmQF2RcUmkXkNZQYLUNymB3YLd+GfFXx
	 e/Pcf1B4yVFsiQgooeHeDlNd+4O4oSoKOHO9vazNiJvO5rsiQRdOdro3KNlTYGvsry
	 NEoDJcYV1h4EHD/v7TlzVsJdV4R/dC/D3LxnqUrCJSLBoEEm1UwObD9Y978hkOyYLp
	 a1LRw4Zd+SSHRQ0eeE5EURhOWfzV36CRM2K9lTbRLGSD7Ne/7xSD3qO3LcFBAhpauu
	 Gv3LvvmTvRzhA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W56vm4Y31z3cTl
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 16:31:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 967 seconds by postgrey-1.37 at boromir; Fri, 21 Jun 2024 16:31:41 AEST
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W56vd3MNFz30Vb
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 16:31:40 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W56Sn5hhgzPpbC;
	Fri, 21 Jun 2024 14:11:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AA7F1400C8;
	Fri, 21 Jun 2024 14:15:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 14:15:28 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
Subject: [PATCH 1/2] erofs: support query erofs ondemand feature by sysfs interface
Date: Fri, 21 Jun 2024 14:18:07 +0800
Message-ID: <20240621061808.1585253-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621061808.1585253-1-lihongbo22@huawei.com>
References: <20240621061808.1585253-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, lihongbo22@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Erofs over fscache depands on the config CONFIG_EROFS_FS_ONDEMAND
in erofs. There is no way to check whether this feature is supported
or not in userspace. We introduce sysfs file `erofs_ondemand` for
user checking current features. Here is the example:

[Before]
$ cat /sys/fs/erofs/features/erofs_ondemand
cat: /sys/fs/erofs/features/erofs_ondemand: No such file or directory

[After]
$ cat /sys/fs/erofs/features/erofs_ondemand
supported

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..1b3d77583f76 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -78,6 +78,9 @@ EROFS_ATTR_FEATURE(sb_chksum);
 EROFS_ATTR_FEATURE(ztailpacking);
 EROFS_ATTR_FEATURE(fragments);
 EROFS_ATTR_FEATURE(dedupe);
+#if IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)
+EROFS_ATTR_FEATURE(erofs_ondemand);
+#endif
 
 static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(zero_padding),
@@ -90,6 +93,9 @@ static struct attribute *erofs_feat_attrs[] = {
 	ATTR_LIST(ztailpacking),
 	ATTR_LIST(fragments),
 	ATTR_LIST(dedupe),
+#if IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)
+	ATTR_LIST(erofs_ondemand),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs_feat);
-- 
2.34.1

