Return-Path: <linux-erofs+bounces-1370-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05426C5C72E
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVN4ljDz2yw7;
	Fri, 14 Nov 2025 21:07:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114828;
	cv=none; b=gpXeW405quHyJIvKe3Gha3wyOtzbxH5V2QoWo4hyo2OsSYcAUGQIRS7VXvVyEVNAbIXDKiOg0c2+6DS2ihsQbsskgViSpC1zvrpWc1I8XR6DcBZG51uHR42292OjnopXQOtuLAi8z/ZTtLv20IOhSZW6sQC3bW948r+zO+9eCf1RLN2z/1jHoBEZrCF3UngdKGiEGK4wGJ96VvFoAQEg8ZtiRpht3wEi4ufSQ6tMZCOKI1M2IcaUdAEPJtDWC4h6Xr8Sdy1UKNsLJ47hMhy4XmVOZrnP1L3X6pSwuxS2rAgaXpK8arlBZTJxRqy2w0C+Dvcf+goUvIEDQa3B2eVVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114828; c=relaxed/relaxed;
	bh=ieQKM8di5soOYofHjv7enQxmHnjBsCzD05Jj+DgINJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE8IOOgLH7L0EWe3oKtW8SKFBed5mrFepJtfaqcshwOosr2X3XOPnn18KqGyAKonj+fDHWQYc8zNRRDLUdgRCcvPSTuh/SsDlEeRIfZ4LCIxEDZiAevZ6cI+rUdsbzsim6jbjfgJEroWhV0iCEqkiw0bDmLVRee5/7y9dA8tWm5yWfJHxQL8GC1EIAcH7viRrFXuhFH0GZZAfqjomxKWwG3uSGcjs77O5O6s1lc/v38GYHQURdfSNxTsEw83A5dGCK1eXyAnN36logHk3OmQzZ62J6laV49kfoRnqrmXrefsvo9wgfsq0n8sWmWJZhl16K0671Yul1ezJL4lvP1tHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=o7D8i3lB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=o7D8i3lB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVF256dz2yxl
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:07:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ieQKM8di5soOYofHjv7enQxmHnjBsCzD05Jj+DgINJ0=;
	b=o7D8i3lBR8INJiBT8X78v+EFIoLPbOOzkHlMak8YD5D5PUzxMYq4JGtgeukgfzkyR8EpDOEz/
	D5IqQ22VOBoM01RJm4p3NKefGgRZ7g6Yei9ibS/12Wc5577fFe+N5ckKW6KkVqWaNb2bhbKKWND
	Duvd2RZrJt/6kruOG/SdNss=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSC64JSz1prQF;
	Fri, 14 Nov 2025 18:05:15 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 36BE41401E0;
	Fri, 14 Nov 2025 18:06:57 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:56 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 5/9] erofs: support domain-specific page cache share
Date: Fri, 14 Nov 2025 09:55:12 +0000
Message-ID: <20251114095516.207555-6-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251114095516.207555-1-lihongbo22@huawei.com>
References: <20251114095516.207555-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index 3561473cb789..ce95454c9ee7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -515,6 +515,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -615,7 +617,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !sbi->ishare_key)
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1036,6 +1038,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_INODE_SHARE)
 	if (sbi->domain_id)
 		seq_printf(seq, ",domain_id=%s", sbi->domain_id);
 #endif
-- 
2.22.0


