Return-Path: <linux-erofs+bounces-1391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80DC6463C
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Nov 2025 14:37:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d981f1fb7z30TM;
	Tue, 18 Nov 2025 00:37:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763386646;
	cv=none; b=Lsc0KtkOY8gvN/V1J/RpmXe4q7KXnPfGqgrgHpcVjR044DbZurklKolMHT8UXqob4SKuyLMn0LMFVW39/CQKsmGRRLSuLNURYBmb1UeOBz9i5t92bxMwgnDoOfZkijwfELCEAj864DxI4ASor02MFIYsh9V22EBQlfvEScAb69F0Q1FkXBEmUO9lXjQQ6/vwEvWoasCIAolrrws3XvR02z284Gvm6rQBFts7xyzWfEWZBxXQkPY04rkxzVpI1Vvm06d43XO2zHo1SL++uB08H6AmdOGMsPsaCdErsouYbz4JHrOM5/vG0k9AnOPdD+yXLwOsdOGNJkL62xOLhagcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763386646; c=relaxed/relaxed;
	bh=FbVkas6xVh0EDYbcJEaJK0b7cxUQjdGPdQbtHmbK7b4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvWDQFauyUUDErMcrQpiU+tlLBMi1sN4kZkSrmeDfL0f+En7cvm492ewifr45N2zpanji9cQluTuxtRj8zh7TOjsZEgubROGViOyphbN+B4YjrK1NlHal/gA66piKLwUHIkD7lnSVLRQmpnDoeKM6qRGoU9dCkNh3V+8S9pPwj1o1abA/EkCwkMxsZnj3vy4rpTgemShomHdc47Po1V9OVFVO75dW7+7RDtMsyyeMybMjf0DOzwfOV1FVnE/xCcQtU0kTCfI73Ut311baql91fSLjJj9RMnlS8I3relsGUZSYDGeho53GFknBBcx8Nowuesf8lhijgFs7Zlcjgm7ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WvVM8WAY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WvVM8WAY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d981b56lhz2yxl
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Nov 2025 00:37:23 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FbVkas6xVh0EDYbcJEaJK0b7cxUQjdGPdQbtHmbK7b4=;
	b=WvVM8WAYbcCPfvxIdH80g3SFtK4G6jWtv6xeMl0W4ZnksajU36D/yxNVcxFylE5k57bFBZGP2
	NoNThwtMbhT9AzGRahB3aI+S7QK7cpok4MncykLqMEnp2g0W3wRbb2dnzefbv4XFS9w4z6cuUxa
	nw57G2pty4rDrYfsgXLVf8k=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d97zm3GCnznTW3;
	Mon, 17 Nov 2025 21:35:48 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EEC4D140276;
	Mon, 17 Nov 2025 21:37:16 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Nov
 2025 21:37:16 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 03/10] fs: Export alloc_empty_backing_file
Date: Mon, 17 Nov 2025 13:25:30 +0000
Message-ID: <20251117132537.227116-4-lihongbo22@huawei.com>
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

There is no need to open nonexistent real files if backing files
couldn't be backed by real files (e.g., EROFS page cache sharing
doesn't need typical real files to open again).

Therefore, we export the alloc_empty_backing_file() helper, allowing
filesystems to dynamically set the backing file without real file
open. This is particularly useful for obtaining the correct @path
and @inode when calling file_user_path() and file_user_inode().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/file_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b223d873e48b..7508f69a1839 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -308,6 +308,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
 	return &ff->file;
 }
+EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
 
 /**
  * file_init_path - initialize a 'struct file' based on path
-- 
2.22.0


