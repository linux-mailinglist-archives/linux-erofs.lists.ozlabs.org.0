Return-Path: <linux-erofs+bounces-1548-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAECD7D5E
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:12:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz6h5sHbz2xlP;
	Tue, 23 Dec 2025 13:12:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455948;
	cv=none; b=NFDc3nx1SxLAHwR+lxjQ1Eh8ywl3yevjJVpKSjkzlqhOBe7+yNRK4K5BHMU7DnxAfodYk3meFqETFr2yhrAM3+RmbaHHsUGnbaZRZ1O/OnfvoXyaESHpc0xLXjN29KjeF181AzK8ArGHNH8inpTdZZlc87GEFpWTfQjrlsCc+MBaWwKohd1sQr1jrdzuzPHQuf6JmG4mFcKkg5cBGAgk6liQhOs7HGtRkOo6gkDZko3rmMNxw+hKl+76UxCK7egp3qF28aCPzXdHQBkDGkGwN54pXDsmsqHrXl9x0NuMtbD3JxW+gywI1DXbbRolr8caROrZUw6bOw7IDkZ1a2eRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455948; c=relaxed/relaxed;
	bh=fllzjWjA0QiMVaQE0XGLTZEqit8wTV6yyXHSdawZCLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FaOSPT8b7dtGmhDc4GAAvUNjYXOMXQql7Ssn307rpIkbG8B+X0NH12TeOA8bV4OPHDxHIA3PSjN2r959qNsoBz0Et6YT0VveG7GMRpPlqyGJ9QevYLzwnEof/DZg97F9Cu0nMtTiXpeSsF08c4Zd4I1uSDfjgNCXqzx+Rd3KkMzDKY7XMJgwwMeX+e0S4aTLrEhRYwfV1GB+0mCgJ+uqnjqPOlfn39uL87HvD7Wae2QSiZlfCYWhlJcteSj/6c8/DIGucTGZPWKNwH2UtfW/49/Pnze68UuyawqD/LLZ3Xwaa1Z6YY8yWH/a3gDgJP3l7saCrWcakFL1haiPXExfUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Riocl+6g; dkim-atps=neutral; spf=pass (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Riocl+6g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.216; helo=canpmsgout01.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz6h0YbVz2xdY
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:12:28 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fllzjWjA0QiMVaQE0XGLTZEqit8wTV6yyXHSdawZCLo=;
	b=Riocl+6gGjn7j8nlAw+G83OCczVcxw7rBgXeLX5XHrKkHz6yIpKamFLQgTKOfr8TYORqKULs+
	ausLYXYNYRTV/VCh+4oMccVftTQmsJx8RSuzIWm0VtXm3Zdr4LgpmxLEGYRK4hTYNbc/fBcNkdh
	P8uIN+eCEn1EaccVTV5YvKE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dZz3w5B6Jz1T4GK;
	Tue, 23 Dec 2025 10:10:04 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id D9303201E8;
	Tue, 23 Dec 2025 10:12:24 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:12:24 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 10/10] erofs: implement .fadvise for page cache share
Date: Tue, 23 Dec 2025 02:00:08 +0000
Message-ID: <20251223020008.485685-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/ishare.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 269b53b3ed79..d7231953cba2 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -187,6 +187,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_readonly_mmap(file, vma);
 }
 
+static int erofs_ishare_fadvise(struct file *file, loff_t offset,
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
@@ -195,6 +205,7 @@ const struct file_operations erofs_ishare_fops = {
 	.release	= erofs_ishare_file_release,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
+	.fadvise	= erofs_ishare_fadvise,
 };
 
 /*
-- 
2.22.0


