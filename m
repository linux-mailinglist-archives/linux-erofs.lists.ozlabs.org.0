Return-Path: <linux-erofs+bounces-1543-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E219CD7D06
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:09:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz2t6h6yz2yFd;
	Tue, 23 Dec 2025 13:09:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455750;
	cv=none; b=dGUSEoCHLJO5B2e98ZdxMrrUn+yj+sm8i/otnOX2f0s9e+WzkBLLe79BDYOUCRTKLLvkHsesL4vU7ZWUwCXvAPQ5l+3PwOtKCXKu97CwWQqkSJxo5M+DEqSEp0d17NkPsk3nei5fBxuYttsroPr7mHyFJ3bpUAzINp2GdfPIl0zwkjokjrVEpfK+m9h6kI3FZeT4W1u0lcV74owZ9g0Zoctehu1hWOzIQsNGqUhv5RZY9VqpDEi1Gh/fluznX5weoCMvUsH+XEQ3dS91BhAs1PwB1uX/FTWe5bGJw3SMdBu+TofIV8AJ8mqi46VFtwAvUA0BsYXc2hXgjAljB46eBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455750; c=relaxed/relaxed;
	bh=7GO752QgqNofic+dM/tFheakeNIh11LqgEgNouQKnuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt64fGuXi2KE+9cLadcgFCzzyagh+1jy9TBhiL0iPluR29lSttDgSMYP6W16LpsWn25oxzZcuGg7KMxXKkFgliffDfADwWVMY2C0LbOYCkHMlVN2TXjA2c722V1+r1YROx+X07Z6XTexpa0/bQZ0gO33Kt/2/FO3XLE6+7mjwrzJWg70h4O+ZaSxZgd0oFVqaXt0kB0kesYyohsBQ65tOlNHs8FYif7mIU+JGIP7UqWG+Y+XcY0WdMwiw+ubcLLd4mXcoSKm2nHgS38IxNdRPMnWO/poMwtC78LrMEQpmUuQZdb+AYVF43EuOtENF6l9D21UIoRoGzqatvzo+vaT+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2QIEhkCL; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=2QIEhkCL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz2t1Byvz2yFb
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:09:10 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7GO752QgqNofic+dM/tFheakeNIh11LqgEgNouQKnuw=;
	b=2QIEhkCLlgSD2nBJ9Eh1sYxAbXN0ttW1vPcRYNz949RKjAbZpBse+GGZt+yQtOk4LXfKd7wzZ
	CW1dtrEs0ICTg4cnbgxhQEjg2D8cN3/NHgCXZv4+gPWd81YTdHmuJJystpDPmzcqPyxEeOG63TM
	rW7rfhm6zU+Nl+M7/8bptF8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dZyzF22R8zLlTC;
	Tue, 23 Dec 2025 10:06:01 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id BB50C40565;
	Tue, 23 Dec 2025 10:09:06 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:06 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 06/10] erofs: support domain-specific page cache share
Date: Tue, 23 Dec 2025 01:56:15 +0000
Message-ID: <20251223015618.485626-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

Only files in the same domain will share the page cache. Also modify
the sysfs related content in preparation for the upcoming page cache
share feature.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 68480f10e69d..be9f96252c6c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -518,6 +518,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -618,7 +620,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !erofs_sb_has_ishare_xattrs(sbi))
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1052,6 +1054,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
-- 
2.22.0


