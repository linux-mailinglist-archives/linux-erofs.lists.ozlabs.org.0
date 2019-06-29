Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7565A9BC
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jun 2019 10:57:54 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45bSFr1jLnzDqtt
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jun 2019 18:57:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45bSCv1j8NzDqwB
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jun 2019 18:56:09 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id B7DA94CFFB944B0649E6;
 Sat, 29 Jun 2019 16:56:03 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 16:56:03 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 29 Jun 2019 16:56:02 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH 1/2] iomap: introduce IOMAP_TAIL
Date: Sat, 29 Jun 2019 16:55:38 +0800
Message-ID: <20190629085539.29237-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme770-chm.china.huawei.com (10.3.19.116) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Some filesystems like erofs/reiserfs have the ability to pack tail
data into metadata, however iomap framework can only support mapping
inline data with IOMAP_INLINE type, it restricts that:
- inline data should be locating at page #0.
- inline size should equal to .i_size
So we can not use IOMAP_INLINE to handle tail-packing case.

This patch introduces new mapping type IOMAP_TAIL to map tail-packed
data for further use of erofs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/iomap.c            | 22 ++++++++++++++++++++++
 include/linux/iomap.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index 12654c2e78f8..ae7777ce77d0 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
 }
 
+static void
+iomap_read_tail_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
+{
+	size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
+	void *addr;
+
+	if (PageUptodate(page))
+		return;
+
+	addr = kmap_atomic(page);
+	memcpy(addr, iomap->inline_data, size);
+	memset(addr + size, 0, PAGE_SIZE - size);
+	kunmap_atomic(addr);
+	SetPageUptodate(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		return PAGE_SIZE;
 	}
 
+	if (iomap->type == IOMAP_TAIL) {
+		iomap_read_tail_data(inode, page, iomap);
+		return PAGE_SIZE;
+	}
+
 	/* zero post-eof blocks as the page may be mapped */
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2103b94cb1bf..7e1ee48e3db7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -25,6 +25,7 @@ struct vm_fault;
 #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
 #define IOMAP_INLINE	0x05	/* data inline in the inode */
+#define IOMAP_TAIL	0x06	/* tail data packed in metdata */
 
 /*
  * Flags for all iomap mappings:
-- 
2.18.0.rc1

