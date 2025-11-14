Return-Path: <linux-erofs+bounces-1374-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FDDC5C734
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Nov 2025 11:07:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d7CVP24lHz303B;
	Fri, 14 Nov 2025 21:07:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763114829;
	cv=none; b=Xzi2WeAfuSra4DbeNrvb0OGvM0g2hu8LSKq0Or46mEcaMhr5Xna0EHxuiRn6FymZrUQN4tI66NB3SeoY9bCKrpodEX8AvssvL5AWTUF9PuZCzbXL6dDe3giLEi76VHkmnF2T2/Gx/tstmE0TupYh7W33OVtkTlyxjUF5rBI5tpgKdP4MkrEj0Qh+7tDbntNnqhzc5AkhUxxNEdZvL1fSym4SY1ZM9di7RuXwSWV69iNv7xqEbHO4c5Eo0v2TZdTLXiSBbumMk2DVwI0MIqof08Q7/BAKwipLvCbERta1S62kFLvD6vtjmQkAzXtdpeMLIeFgoWcYx0kEIvv0WH53BA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763114829; c=relaxed/relaxed;
	bh=BCMyMCc7n0nJXxkfnxnWAQQyWIQKmftwqT0fy6ncGbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoIbHEc3xnk3HHLJOIQ4k4rJzDxa0wmq1Z3oPTQENb57zrifVPPJ1ENoH+GHDGhtNHbUd8QdqQP9B+/sVTakTDkJ2K0FkfJ8lheFiq67K91ZJAOgulSVPbWJECE8cVVp2t0b29TiYrd8DS0LS5Wmm1D67ktz5iUPVOVMzMnEYqS2lYzWpY7t0UI2a/CG2Z1H/MB/fIMl6A7fCC/Frsb8zN7rE3Km+0HocdsrmUyNUbp1xtgSGH5ZypR5/nFgZ1bgJvI5m7OZG5N8pHbGoavOQKMbhLHHWQAdI96eK5WjYlzu2vJ/vmrCXGPMzvWPzaru0FNpUboeVNHhhynCeGThRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WVWfC3KE; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=WVWfC3KE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d7CVG0gWPz302b
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Nov 2025 21:07:02 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BCMyMCc7n0nJXxkfnxnWAQQyWIQKmftwqT0fy6ncGbk=;
	b=WVWfC3KEX4PuA9XOjVyZAaI2g+IXsviDtdLkgbyYyZI6oOob1B41G98KeAM5E95fvEhkAsT4x
	Rg+tJUH32VmAMkhqU9bjTFCa/DrJkkt5Dtc2ARBRvGOzoZgR+Thxv50rDCNXSjftWMLzYrnauEN
	TyT33ug2g5rwWACxr56kQpQ=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d7CSY0WNLz1T4g8;
	Fri, 14 Nov 2025 18:05:33 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BE6318048B;
	Fri, 14 Nov 2025 18:06:59 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 14 Nov
 2025 18:06:58 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <joannelkoong@gmail.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 9/9] erofs: implement .fadvise for page cache share
Date: Fri, 14 Nov 2025 09:55:16 +0000
Message-ID: <20251114095516.207555-10-lihongbo22@huawei.com>
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

This patch implements the .fadvise interface for page cache share.
Similar to overlayfs, it drops those clean, unused pages through
vfs_fadvise().

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 14b2690055c5..88c4af3f8993 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -239,6 +239,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -247,6 +257,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvice,
 };
 
 void erofs_read_begin(struct erofs_read_ctx *rdctx)
-- 
2.22.0


