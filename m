Return-Path: <linux-erofs+bounces-1788-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BBD08A35
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 11:41:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dndcZ6VWVz2xc8;
	Fri, 09 Jan 2026 21:41:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767955310;
	cv=none; b=ieFfpkRwDbMNiZwZqzMVtTH2Qi0Lexxyi4bDPZPxXseo/7LrTHmwksz65KNFWA/ocJXb9+qX1vXVB4srNXvKp80AOa1kqwSn6DKtE+ZU69y9Y5jTTB/WZ9wCGNsmR+Yz2aeKdt1M8hh98u8MWNhucl6ULWIxTPD1PevklMatHT6jJAFp1FwZ420XAt3gUyQEBiFdonFc93//PBPBgy+6ttaDE576PpuEeywocn4h3BJczG0pfAy4BShrz2hxg2hxFmuDcE9sr5S77mg8d6YSH+uf8rFiifJggy+oixVtdg9RA/b9GG7bYHUitGM2aqy2J/joJnSwMVQ9cC7Mr+CBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767955310; c=relaxed/relaxed;
	bh=Prkh09N5bY6Pyt+qiNdP7r6JDJbv/0vdTFS2y1gv9ss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMfIDSSLU9GRnConWlr1D3JB32SrdghYhlsfFwH2TK8HMa1PdhErACbJ6u5l7J62wuGudRoyw6emiER1Ou3ZgcjAKZiRLunZwFLnF8rAZXf9UXsk7DXo36F8UJuCZ/Dvl6UC8/jByUrFHunKkpZzSEXP0TYcxuytRlJqaush9dj9WMYHxeoMOY4h82JILtGzaKKbFDUKWEvKXMbYm/Zs4G2PoVnaa50inrP/yNefiiZtR2o9lCQgKdZXBMpLUZgfLesSL+HJ0FEHP2d1NhUHsQCgNGpFd9Td/7FTO/ivRH/lCtkyg/BDK/KSN2eySLOQr4iJXWQwasDgmBukIMYHSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XTt90r0W; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XTt90r0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dndcX25jMz2yFw
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 21:41:48 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Prkh09N5bY6Pyt+qiNdP7r6JDJbv/0vdTFS2y1gv9ss=;
	b=XTt90r0WLlDDbIGT19XniWLvF12SMqSxjxjUBxv58gwmoIMdR+3gNTPZQ+93jx2QFTQ5oRyWk
	aftb3rp0pqhqRiD2A7nsHd9FUSJIaA5nCqDBXqXLI4Rox+KyHeKRiJPqrZ70Kx+mMtZYwDiKqYF
	TlyOBfPmVKtSTql0j67mUAI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dndXg3Dx6zRhQg;
	Fri,  9 Jan 2026 18:38:27 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 59BC04056A;
	Fri,  9 Jan 2026 18:41:44 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 18:41:43 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v14 10/10] erofs: implement .fadvise for page cache share
Date: Fri, 9 Jan 2026 10:28:56 +0000
Message-ID: <20260109102856.598531-11-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260109102856.598531-1-lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
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
index 366f0d79e008..2258682b76cf 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -149,6 +149,13 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -157,6 +164,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
-- 
2.22.0


