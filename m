Return-Path: <linux-erofs+bounces-1393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE3C64645
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 14:37:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d981g4H0fz2yx7;
	Tue, 18 Nov 2025 00:37:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763386647;
	cv=none; b=B5bnEA9wMhjEx3/bSWMund4q2dJEijsMFaNF0xutzGvyO6pqozvupiQWnl5x7GZE2/xb8hO8L22TswXZYUTk5DfH7qmXvw4oMdlB9boqIL8t8S7tgFMdnRWU0s1Gx/uv3I1HPDJ5h8ah+7YothzkmPpB6Yrdzas5pl5K2+aiB9GTJTfjhN4U4RMF45+aBujKRGTrONckAW/MoTGw+x3+Y1e6NsIEv71YWVBI9WxQ9uV8BDiExMiLLiMlDIgznSTMOXY7O12gyJ4g9XD1a1tPFFxmgQMJrVEJRh53MwxSZBAaw7zmhkpZn2HiPlk67pRwbuSz+1+XqQ/6oYsA7zZ7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763386647; c=relaxed/relaxed;
	bh=hG3ZwBWx+b/D3O7O0d3ZAoE45/BCf1dWrd35luw2P74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoRZEs4jpK0/YzlONkpmYlIX+Fn+O7HzMVVsdCJL4ZzKwJow4XNnNSDImVe/toufD3XY121jknc03ZfZ7lG6g1NisvjxETsThl0wgr53yx3079ry391B94Q8wp1IMOXV69oYMMmVmhBz8lSddnK2Sok74lpGCIy+8bjzy2bWvzenH2CknctWIMwi7FNeqgIsEvLqobX+DEAmSZbmiGzrYbV+oDuG4JdcB7oRoJ/F088m/0hhjFhiY0o5FLJYG+f92coBO8r+hZURwyVkrEc67rMC7LcmN5T3+ARYZJmrAc615mim8KZHinWlPrii74qBsNN+j0JJEk08C6pHZd4vtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OCntdh3j; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OCntdh3j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d981b4qFBz2yv9
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 00:37:22 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hG3ZwBWx+b/D3O7O0d3ZAoE45/BCf1dWrd35luw2P74=;
	b=OCntdh3jC0bnPvI7d0q2CKgk/zRS/vJxiLDn+0yuHC+At3yxP7gwTtdC1XqJpiuyBQQQkVIu5
	8YhfxkOskIJwjtO0GdIn98gxVZbjtagsZmBBtzV63N90tZEQJtA1sp35hbQDBSSuG9gvf5s24+k
	Zpn69A6cbhKg4D0OyqcVRq0=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d97zn5b8yznTW3;
	Mon, 17 Nov 2025 21:35:49 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B0AA1A0188;
	Mon, 17 Nov 2025 21:37:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:17 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 06/10] erofs: support domain-specific page cache share
Date: Mon, 17 Nov 2025 13:25:33 +0000
Message-ID: <20251117132537.227116-7-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251117132537.227116-1-lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
index 80f032cb2cc3..9a5e3f9dcd0d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -517,6 +517,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		if (!sbi->fsid)
 			return -ENOMEM;
 		break;
+#endif
+#if defined(CONFIG_EROFS_FS_ONDEMAND) || defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
 	case Opt_domain_id:
 		kfree(sbi->domain_id);
 		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
@@ -617,7 +619,7 @@ static void erofs_set_sysfs_name(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	if (sbi->domain_id)
+	if (sbi->domain_id && !erofs_sb_has_ishare_key(sbi))
 		super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
 					     sbi->fsid);
 	else if (sbi->fsid)
@@ -1034,6 +1036,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
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


