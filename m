Return-Path: <linux-erofs+bounces-1943-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C3D2F476
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 11:08:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dswYF2TQbz2xSN;
	Fri, 16 Jan 2026 21:08:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768558129;
	cv=none; b=FmNNcstg0RLUA6tJDKKSGMbiXUU/F1pj+sR1NR1Hi7iMa7OhvH9238LfiJaD9xdnTA93hf0VWJu+V3hds+8OdYA51vGYJ6BVVaZVGXSZOC61g2P3kGz2bNQws5R7g4fQ2zJNY+UeWDcHgXQ26nZ3NJUjAEwxd/1D98CXLGRBYmQ6TEK90xlrC5XZVdoHdSXwFBjJkouNQ2TaxZLOqQFXH7NRhYI3jK+GC1ml2DWX5SPa8LlGCafh4a8XD/6tGQPx5prjCf6CtblTBYZbxvW2thsv9IXgCxryeR3nef2FR9+6BmrCgz86WLpeP6DRGxmJv8T73KX5rWbZxezSLlPoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768558129; c=relaxed/relaxed;
	bh=XzmAs2VpZLSxoIrsGbEfPR013qwffyPmOWZWIOJmd7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1UPbmT+vOn+Ve+0xmwCq7R/HqV9b+TQsut3sA4/sKhz5jWO/7IDy4wsfq2xRMogm2VsISJXZ4NchC0rn0mQO0ENZoBbxmdT6a61DUxOLNZq5gmhpn5jWKwPRaX3xWxO31WcO257znWgq2REDAN38M5x9l8cwm8yZ0xTt+f7hkBBn520VKQnd93KUuL00+SYdKw3PozS4iT3oZJIGOLgec+Tc+tVsx+Y0w98fL7FkVbKqptlJ2lnzoMn3a3ksaxexcnjxfhFhrOJih6JaGSzZWQge1HTdN3WVq1R88mEDxXi2VNIKC9qQ76PJN2HOe8AbyNKPDuHwa2XYZV7bYTIWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ET4nQgDE; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ET4nQgDE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dswYC33wnz30Lw
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 21:08:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XzmAs2VpZLSxoIrsGbEfPR013qwffyPmOWZWIOJmd7w=;
	b=ET4nQgDEN5fYb3hoQ8vIAzZBtp6wiXUMv1NRArCFLuT2+7LbB0ZtiaUJbe4KeP8OBrpaOTNYo
	IOgLN5fMC0HizzauOwIRsnpx/LjDgNUINCiH08vX29OH1T+GnUoIzDWysuevgBd0crGEm8GAn+k
	KCC9YTjfCMoJWlJMien4q0A=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dswTF1c2Cz1prKt;
	Fri, 16 Jan 2026 18:05:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EEEB240538;
	Fri, 16 Jan 2026 18:08:43 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 18:08:43 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Date: Fri, 16 Jan 2026 09:55:50 +0000
Message-ID: <20260116095550.627082-10-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260116095550.627082-1-lihongbo22@huawei.com>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index 96679286da95..78242f9d8dde 100644
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


