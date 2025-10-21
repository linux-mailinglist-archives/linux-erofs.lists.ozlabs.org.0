Return-Path: <linux-erofs+bounces-1270-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFDBF5ED1
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 12:59:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crTp85HFhz30D3;
	Tue, 21 Oct 2025 21:59:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761044384;
	cv=none; b=EPPPfCt/cehs93f07xQo+8K7lUdSXLuOAFgBTjZB+zltUzZi8+JowP7azPMd95Kt9yVidl0ORdSA7vJzEIHv1joalhdvKYOYaVuv4c9gbW/6dls7ZTV+lWvaPWsXxf8bUPkNdPmPmsgioWM5+0rpiKVl+c8uawP30sb9/I8NIUGbILcKdjv4orWVfK9RCogHZldupg/FOMtkVQo1+liKnVFWzdDM1j4KpV8GnQpwiFlWN++8lhQMAFvBrRbj16LpVGYcghRpUcuOlxqzzJn0b2/XB9THTV9JgjFX4h/PlZXxwPC8jC3D/xtnupSCGu6rO5SJxVO6ZNcj61AX6F65Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761044384; c=relaxed/relaxed;
	bh=7tLzL1Hn+o30kT4oezlP37EIN8PptJGJl2YdtDGMiFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMFNa98jvyCyczOLTBVV/FelNqTolVZawt693gG2w4DB9Kw9ysDuqCTMLba1b1qOdtUoEaSyNLOAkYZrLpbL+sn6xXBd+qiKUjRb+4jIXF8PRxNeH3zL0yVTc9RlvPVkFTEtpzUfiO+hcVepJpSfBxF0Kdn3A26rMzd3AA4NKU3Z6v/LbX+RA1juROPdGciuS5aSolgvPP9fDGeVKrX/0czRDzgq8L+klM3wgzMiKSpwSt01qTGCUYs0yyFlVuPduiHKl3evLf5re2mtBuhZnYsBB6u0IuRk1q2YffpIIZQnJtuy8Eh33hRBuGPTv6iEtIYf99MvwxJzH9p9214Odw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OL51/MT6; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OL51/MT6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crTp40SnWz306d
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:59:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7tLzL1Hn+o30kT4oezlP37EIN8PptJGJl2YdtDGMiFg=;
	b=OL51/MT6lH4JzPxeE4Ja31IrCJ1JqVY7JIg139eAaBwpCxvYSSs5h1rpm/ITf+iojHnGCp4eB
	rPFLyv/Y6nbRPZUQ6Qqd78D5H8hV+J3b4DYlmlr7Ss1xFjDSAdzsuL+B5mCkUXBcpXW/2j/xtWr
	FoGSwycp4DtguNH2SPFgiVs=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4crTnW36VmzLlVc;
	Tue, 21 Oct 2025 18:59:11 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DDE0140155;
	Tue, 21 Oct 2025 18:59:35 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:34 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 7/7] erofs: implement .fadvise for page cache share
Date: Tue, 21 Oct 2025 10:48:15 +0000
Message-ID: <20251021104815.70662-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251021104815.70662-1-lihongbo22@huawei.com>
References: <20251021104815.70662-1-lihongbo22@huawei.com>
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
[hongbo: forward port, minor cleanup]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 73432b13bf75..b067f0e02d6c 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -228,6 +228,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvice(struct file *file, loff_t offset,
+				      loff_t len, int advice)
+{
+	struct file *realfile = file->private_data;
+
+	if (!realfile)
+		return -EINVAL;
+	return vfs_fadvise(realfile, offset, len, advice);
+}
+
 const struct file_operations erofs_ishare_fops = {
 	.open		= erofs_ishare_file_open,
 	.llseek		= generic_file_llseek,
@@ -236,6 +246,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvice,
 };
 
 void erofs_read_begin(struct erofs_read_ctx *rdctx)
-- 
2.22.0


