Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530093481E
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 08:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721284399;
	bh=Bi4hjXXavTo3/eQCWSgdZm6Xd7170F9rcPMPGs5d7dE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ba7YPL8i2zkkll8+uY7TYfRzO77MSHDpc3z/PiOJzQi/JRtehxvyDvtnmS4o+h4fy
	 G2Twv46/3l4N2pLF/gLqkyRznFBIurBebrsxezzGzxyOqcP+myxQtB9EZnJuotMX9B
	 aozGX3azShlr+3YmvEDZr/0QVed8uD/Rpo2H+YBYYMc2DH6Ea5m4J3UlSEN+2jqmFB
	 an+1FyDM5NS1IXsmO2d9Rnbc/hPMRyrfk0YwZygqxAMHP6WVUKbt4gGqkD2fHbOBpd
	 JMI8RsOjjAenPei13+pcjFEsCTUZ67mR8WpOmGBkAf0jhQ1JZJtaFHL2OxdLZAXwAv
	 aIuoKOXOrG5cw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPjg32Cztz3dDt
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 16:33:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPjfy5VPLz3bX3
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 16:33:11 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WPjYn2W7Sz2ClL0;
	Thu, 18 Jul 2024 14:28:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E4F1A016C;
	Thu, 18 Jul 2024 14:33:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 14:33:04 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
Subject: [PATCH v2] erofs: support STATX_DIOALIGN
Date: Thu, 18 Jul 2024 14:37:56 +0800
Message-ID: <20240718063756.2982763-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add support for STATX_DIOALIGN to erofs, so that direct I/O
alignment restrictions are exposed to userspace in a generic
way.

[Before]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:0
dio offset align:0
```

[After]
```
./statx_test /mnt/erofs/testfile
statx(/mnt/erofs/testfile) = 0
dio mem align:512
dio offset align:512
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - Removing the non-bdev case for obtaining the bsize.

v1: https://lore.kernel.org/all/afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com/T/
---
 fs/erofs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5f6439a63af7..7c1163e47cb7 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -342,6 +342,23 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_IMMUTABLE);
 
+	/*
+	 * Return the DIO alignment restrictions if requested.
+	 *
+	 * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
+	 * the compressed file, so in these cases we report no DIO support.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		stat->result_mask |= STATX_DIOALIGN;
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+			!erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
+			struct block_device *bdev = inode->i_sb->s_bdev;
+
+			stat->dio_mem_align = bdev_logical_block_size(bdev);
+			stat->dio_offset_align = stat->dio_mem_align;
+		}
+	}
+
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
 }
-- 
2.34.1

