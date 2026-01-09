Return-Path: <linux-erofs+bounces-1765-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE34D06F0C
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 04:15:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnRj54gTpz2yFm;
	Fri, 09 Jan 2026 14:15:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767928505;
	cv=none; b=Uf7l3cnGBfecePZvicVIRr2b27jUN4hcLZwRMAXd90awOeY4b19a2vBKr0jczo3bmI6NEOaLoTHyXagR/4WLl+d3JyNcrM/+gArTtpi1NgzPt12XE4EynMM9TgPvT7c3u+tj1V1PAOVbNQQek6P4MvloIyaXuOJmA6AcTuxNOpFZmsppEvGUGIFjyLF6eU6X1K9p1xXCwZmfHcjIgomkmwwn/wjnaIAaBO0TtcaaTgRLsjaGqbMeINxeLgKCQ174aVmoMRNmtq0S9HQjHkZCUHZiqSWAqacuMf7p1pp8P4/Dxufa9ORSiM08IcmPRjqFMS70E7pLBo9RycLqA1T0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767928505; c=relaxed/relaxed;
	bh=Y9iG9ndcqnun6d+cB2jUtN8m3ukc7DAvlqzso25aXTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CE6dzJ3Woh4zkM6JFUKRW3beJbqZRQoGVupyhkLywc3Jd7T4KO7y46hfwV3E3mtAVl+oVZU3obfXc5mT45FQvgntGsH7IrVgDVBemDFB1boPiUeowhRkelqKRlOKEWlGTGb35s7OMa1gr1THAWR2LDt66k/L6bY0hrHvEQfztXhOvOaSbh/mWhyurk0zTgjjqwB5IxFafrv1IVXULFIUljYvRdBzufrsbzGIvzDLLTZmvWoSCGFBKdk3B34mI8RKPrwbgfQ2kdUohRw8YwtpK46SvEJVm+wv8CrxJZJQVAc8jPJhnipJgqWh1WGPDnoPyWrGLN1BCb37cRvRBnPRrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eT8p2xLl; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=eT8p2xLl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnRhz22DTz2yFy
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 14:14:59 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y9iG9ndcqnun6d+cB2jUtN8m3ukc7DAvlqzso25aXTA=;
	b=eT8p2xLl1jlYZCmBpyNNlXYMUHlAwZcLB//uGk3tQhpxbm6Jdc205QkIo8hUUYh0t03+Eo1K7
	BaGPyTTn0lrbA/DKSG2lZpLiVU72CCYfqDMAk1wtIYGkzqo0SSLBezY55zK9McrXncSDcBtoTK9
	2j9CfCdYzQwUqvDACKtTqzo=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dnRcn2rnNzcb3h;
	Fri,  9 Jan 2026 11:11:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 641DC40569;
	Fri,  9 Jan 2026 11:14:56 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 11:14:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v13 10/10] erofs: implement .fadvise for page cache share
Date: Fri, 9 Jan 2026 03:01:40 +0000
Message-ID: <20260109030140.594936-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109030140.594936-1-lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Hongzhen Luo <hongzhen@linux.alibaba.com>

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/ishare.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 85b244ba306a..51170792e365 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -145,6 +145,13 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvise(struct file *file, loff_t offset,
+				      loff_t len, int advice)
+{
+	return vfs_fadvise((struct file *)file->private_data,
+			   offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -153,6 +160,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
-- 
2.22.0


