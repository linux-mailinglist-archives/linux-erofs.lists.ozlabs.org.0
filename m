Return-Path: <linux-erofs+bounces-1665-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D143CEBA55
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Dec 2025 10:14:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dh45b4gN7z2yPR;
	Wed, 31 Dec 2025 20:14:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767172451;
	cv=none; b=dvz/2gmMvgu6aTxNbvqXKxLGkRANHc9zfed1GUdlu3s2MLyoFlQnZMABfn3mRjE+ngqcfbpNLPyDF6P94oeKCNKq06wh1urBzX/7a+mbCBBwLd4u+EKJ0572tv4+k0G5LNtPQR+bkrnwCrcdy7tnLHbJH5N5Z/PLJRqdtZZvGdlE0QjYNJcMYkhjVtiAE3QSTlgkqQi55sEuelsMKTURfqYVZSVQVHD/VBDAmce8DtktwaCGmVb8oSbs7LH22/gFtsPoHco1HADEwEStSyb4Zj5BQ2sXUucEqZCyXfvXxskAY/LwL1EfysmExWSfUGizJfWPPG2xX19RZ4/JgfSZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767172451; c=relaxed/relaxed;
	bh=NTdhokYX3kI07kKshOUNPjp2sz5Cl0rGRESoWXdC/s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQnqrtYU7gDV1TOLhX+vURya95I8K6ZaFy1C4xNjdxjmoDPix+SyYFSgh9SYmzmFjx9PTPvVcMsy19F6I2emGd66D1o12EYx9D5V2qJCT3RS6joQOeL/BT6oVJaJ4URQsuTzIsGSJdY0GSBC46aH+ORtYzrHvrXDsqwXIEMvAwjPU8c2t0kdgVuAU6lQzm1u1+3KO1/qfI2xMB3zEpBzbkCzo6Yq7L1cB8a0rceoXtphp7jnIY5XR+e8mkXbbCRt8r0KgCl8mJhedmqEmvrB98pTo8JZYzgpGsyotcbtpNmqTxMNEIh/sIg7H1ysI46IPjZbK4DFEjWbu0LWHp1hsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Lr6wWqp9; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Lr6wWqp9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dh45W0NyGz2yRm
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 Dec 2025 20:14:06 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NTdhokYX3kI07kKshOUNPjp2sz5Cl0rGRESoWXdC/s8=;
	b=Lr6wWqp9bpNPnS+wDXjw2P7VdC7omvQxMxE0x7eBdXMprgWXOFhzZLXykT28pHIIv/3WwPjbI
	N3WGGdkh+znXVXgDYMgYGBR0JnfzjpNsbmgLLRJbKRaBJDGyDfBJYBxBYm+UkCXPLW7P0IXC1z7
	D2hptI7JmQbi3TlXW1KZkQ4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dh41p4l7Cz12LDq;
	Wed, 31 Dec 2025 17:10:54 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 004684056A;
	Wed, 31 Dec 2025 17:14:03 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Dec
 2025 17:14:02 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 10/10] erofs: implement .fadvise for page cache share
Date: Wed, 31 Dec 2025 09:01:18 +0000
Message-ID: <20251231090118.541061-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251231090118.541061-1-lihongbo22@huawei.com>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
index b91f0ce412c0..2b7660d7e9d4 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -152,6 +152,13 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -160,6 +167,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
-- 
2.22.0


