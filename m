Return-Path: <linux-erofs+bounces-1273-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BBBF5ED8
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 12:59:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crTp93zyRz304H;
	Tue, 21 Oct 2025 21:59:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761044385;
	cv=none; b=Bar1stpVTYjSuMB1oHDxAVWbT5FNt4PCjPWKR3CQiRXlQqMrjMBLKJMY3MkYnoU17wTmeGF9kozp82hWNh2TuzO9Oxcg7Ptt3NgRhrWzXcRTdLKD0Wgj9DTiYmVEdwdgpyY3H8GKF+nW6JFn/ONu8fLPMyY+CXEuU0LYPnxKlDJgQUWwg/odf7xTjpSddlHSXLSC6gW532R5KZM4kqGymt5cbB32hkKRi17ucfrkW7i5SlgylXiru/aIcdFRhAuh88ruVmcxnusgPvp6JEQpBORh/KgWCCdFddOq29ftDpC2SrXt1IO5MhNsq5H4NHKOIAff3v1mvpJIbubK3/TA1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761044385; c=relaxed/relaxed;
	bh=LY07TegupRGvSH/9+tapmPTo/3N1TCD/ljyoNiLW+uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJeHepuYf6o1dfwC/8dPAe1DAGYbLkiT7qk3KdYvzF5iRwW0Ft2ANfZa1TRnACeMhitF8S7pteF/XudCkYezcAOWfuZTntnUsPM5Kwv7JM0a/GGs7s3JYxHUcQzM0RVl1WdlLAyQWa5hpJKJVaq4tIyZGZgxynXggAFx7RpCKiP69QPLhFuKGlyvkgM92DyIK+Bh7DSA00KWeJV5CBbVbOgsugMMieciec0ukbRULK6pGJT58fhsXoZ70s14SojX3lmWpifX1xxdkEokivQPf9j5jdCmq77PTXwssqsJHbAk4jEH0FSOEU3j01JMkdl4QgM7W1TTfXUCPPPZQM8usA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1dRJFm92; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1dRJFm92;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crTp407y1z3069
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:59:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LY07TegupRGvSH/9+tapmPTo/3N1TCD/ljyoNiLW+uE=;
	b=1dRJFm92O/Ob7s4AZR8cRATGWCbuqsGQ5t0VTKsGnL8F6JKz80VYYpQExCGGoORilrLZCwWpS
	fvQET1psEIgqMO0tKVnui7dMEHL7YjMpyKaA6CGcfn8w3HYmf+ij1rJtgbosF/3wTJnwdobe46L
	xjUdRqksDRBtpL4AWl2PEPc=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4crTnV6LdmzKm5G;
	Tue, 21 Oct 2025 18:59:10 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id BA3A018001B;
	Tue, 21 Oct 2025 18:59:34 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:34 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 5/7] erofs: support unencoded inodes for page cache share
Date: Tue, 21 Oct 2025 10:48:13 +0000
Message-ID: <20251021104815.70662-6-lihongbo22@huawei.com>
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

This patch adds inode page cache sharing functionality for unencoded
files.

I conducted experiments in the container environment. Below is the
memory usage for reading all files in two different minor versions
of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  2.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
[hongbo: forward port, minor fixes and cleanup]
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c     | 81 ++++++++++++++++++++++++++++++++++++++-----
 fs/erofs/inode.c    |  5 +++
 fs/erofs/internal.h |  4 +++
 fs/erofs/ishare.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/ishare.h   | 18 ++++++++++
 fs/erofs/super.c    |  7 ++++
 6 files changed, 190 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8ca29962a3dd..438d43c959aa 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include "ishare.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
@@ -266,25 +267,55 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
+struct erofs_iomap {
+	void *base;
+	struct inode *realinode;
+};
+
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	int ret;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
+	struct inode *realinode = inode;
+	struct erofs_iomap *erofs_iomap;
+	bool is_ishare = erofs_is_ishare_inode(inode);
+
+	if (is_ishare) {
+		if (!iomap->private) {
+			erofs_iomap = kzalloc(sizeof(*erofs_iomap),
+					      GFP_KERNEL);
+			if (!erofs_iomap)
+				return -ENOMEM;
+			erofs_iomap->realinode = erofs_ishare_iget(inode);
+			if (!erofs_iomap->realinode) {
+				kfree(erofs_iomap);
+				return -EINVAL;
+			}
+			iomap->private = erofs_iomap;
+		}
+		erofs_iomap = iomap->private;
+		realinode = erofs_iomap->realinode;
+	}
 
+	sb = realinode->i_sb;
 	map.m_la = offset;
 	map.m_llen = length;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(realinode, &map);
 	if (ret < 0)
 		return ret;
 
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
-	iomap->private = NULL;
 	iomap->addr = IOMAP_NULL_ADDR;
+
+	if (is_ishare)
+		erofs_iomap->base = NULL;
+	else
+		iomap->private = NULL;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
 		return 0;
@@ -318,7 +349,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (IS_ERR(ptr))
 			return PTR_ERR(ptr);
 		iomap->inline_data = ptr;
-		iomap->private = buf.base;
+		if (is_ishare)
+			erofs_iomap->base = buf.base;
+		else
+			iomap->private = buf.base;
 	} else {
 		iomap->type = IOMAP_MAPPED;
 	}
@@ -328,7 +362,17 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned int flags, struct iomap *iomap)
 {
-	void *ptr = iomap->private;
+	struct erofs_iomap *erofs_iomap;
+	bool is_ishare;
+	void *ptr;
+
+	is_ishare = erofs_is_ishare_inode(inode);
+	if (is_ishare) {
+		erofs_iomap = iomap->private;
+		ptr = erofs_iomap->base;
+	} else {
+		ptr = iomap->private;
+	}
 
 	if (ptr) {
 		struct erofs_buf buf = {
@@ -341,6 +385,12 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	} else {
 		DBG_BUGON(iomap->type == IOMAP_INLINE);
 	}
+
+	if (is_ishare) {
+		erofs_ishare_iput(erofs_iomap->realinode);
+		kfree(erofs_iomap);
+		iomap->private = NULL;
+	}
 	return written;
 }
 
@@ -369,17 +419,32 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct erofs_read_ctx rdctx = {
+		.file = file,
+		.inode = folio_inode(folio),
+	};
+	int ret;
+
+	erofs_read_begin(&rdctx);
+	ret = iomap_read_folio(folio, &erofs_iomap_ops);
+	erofs_read_end(&rdctx);
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return ret;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct erofs_read_ctx rdctx = {
+		.file = rac->file,
+		.inode = rac->mapping->host,
+	};
+
+	erofs_read_begin(&rdctx);
+	iomap_readahead(rac, &erofs_iomap_ops);
+	erofs_read_end(&rdctx);
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
-
-	return iomap_readahead(rac, &erofs_iomap_ops);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index cb780c095d28..fe45e6c18f8e 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "ishare.h"
 #include <linux/compat.h>
 #include <trace/events/erofs.h>
 
@@ -215,6 +216,10 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		inode->i_fop = &erofs_file_fops;
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+		if (erofs_ishare_fill_inode(inode))
+			inode->i_fop = &erofs_ishare_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 158bda6ba784..9ce6e5753978 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -322,11 +322,15 @@ struct erofs_inode {
 			spinlock_t lock;
 			/* all backing inodes */
 			struct list_head backing_head;
+			/* processing list */
+			struct list_head processing_head;
 		};
 
 		struct {
 			struct inode *ishare;
 			struct list_head backing_link;
+			struct list_head processing_link;
+			atomic_t processing_count;
 		};
 	};
 #endif
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 910b732bf8e7..73432b13bf75 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -72,6 +72,7 @@ static int erofs_ishare_iget5_set(struct inode *inode, void *data)
 
 	vi->fingerprint = data;
 	INIT_LIST_HEAD(&vi->backing_head);
+	INIT_LIST_HEAD(&vi->processing_head);
 	spin_lock_init(&vi->lock);
 	return 0;
 }
@@ -124,7 +125,9 @@ bool erofs_ishare_fill_inode(struct inode *inode)
 	}
 
 	INIT_LIST_HEAD(&vi->backing_link);
+	INIT_LIST_HEAD(&vi->processing_link);
 	vi->ishare = idedup;
+
 	spin_lock(&EROFS_I(idedup)->lock);
 	list_add(&vi->backing_link, &EROFS_I(idedup)->backing_head);
 	spin_unlock(&EROFS_I(idedup)->lock);
@@ -234,3 +237,83 @@ const struct file_operations erofs_ishare_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
+
+void erofs_read_begin(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (!list_empty(&vi->processing_link)) {
+		atomic_inc(&vi->processing_count);
+	} else {
+		list_add(&vi->processing_link,
+			 &vi_dedup->processing_head);
+		atomic_set(&vi->processing_count, 1);
+	}
+	spin_unlock(&vi_dedup->lock);
+}
+
+void erofs_read_end(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (atomic_dec_and_test(&vi->processing_count))
+		list_del_init(&vi->processing_link);
+	spin_unlock(&vi_dedup->lock);
+}
+
+/*
+ * erofs_ishare_iget - find the backing inode.
+ */
+struct inode *erofs_ishare_iget(struct inode *inode)
+{
+	struct erofs_inode *vi, *vi_dedup;
+	struct inode *realinode;
+
+	if (!erofs_is_ishare_inode(inode))
+		return igrab(inode);
+
+	vi_dedup = EROFS_I(inode);
+	spin_lock(&vi_dedup->lock);
+	/* try processing inodes first */
+	if (!list_empty(&vi_dedup->processing_head)) {
+		list_for_each_entry(vi, &vi_dedup->processing_head,
+				    processing_link) {
+			realinode = igrab(&vi->vfs_inode);
+			if (realinode) {
+				spin_unlock(&vi_dedup->lock);
+				return realinode;
+			}
+		}
+	}
+
+	/* fall back to all backing inodes */
+	DBG_BUGON(list_empty(&vi_dedup->backing_head));
+	list_for_each_entry(vi, &vi_dedup->backing_head, backing_link) {
+		realinode = igrab(&vi->vfs_inode);
+		if (realinode)
+			break;
+	}
+	spin_unlock(&vi_dedup->lock);
+
+	DBG_BUGON(!realinode);
+	return realinode;
+}
+
+void erofs_ishare_iput(struct inode *realinode)
+{
+	iput(realinode);
+}
diff --git a/fs/erofs/ishare.h b/fs/erofs/ishare.h
index 54f2251c8179..b85fa240507b 100644
--- a/fs/erofs/ishare.h
+++ b/fs/erofs/ishare.h
@@ -9,6 +9,11 @@
 #include <linux/spinlock.h>
 #include "internal.h"
 
+struct erofs_read_ctx {
+	struct file *file; /* may be NULL */
+	struct inode *inode;
+};
+
 #ifdef CONFIG_EROFS_FS_INODE_SHARE
 
 int erofs_ishare_init(struct super_block *sb);
@@ -16,6 +21,13 @@ void erofs_ishare_exit(struct super_block *sb);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
 
+/* read/readahead */
+void erofs_read_begin(struct erofs_read_ctx *rdctx);
+void erofs_read_end(struct erofs_read_ctx *rdctx);
+
+struct inode *erofs_ishare_iget(struct inode *inode);
+void erofs_ishare_iput(struct inode *realinode);
+
 #else
 
 static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
@@ -23,6 +35,12 @@ static inline void erofs_ishare_exit(struct super_block *sb) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
 
+static inline void erofs_read_begin(struct erofs_read_ctx *rdctx) {}
+static inline void erofs_read_end(struct erofs_read_ctx *rdctx) {}
+
+static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
+static inline void erofs_ishare_iput(struct inode *realinode) {}
+
 #endif // CONFIG_EROFS_FS_INODE_SHARE
 
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f067633c0072..cba3da383558 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -97,6 +97,7 @@ static void erofs_free_inode(struct inode *inode)
 		erofs_free_dedup_inode(vi);
 		return;
 	}
+	erofs_ishare_free_inode(inode);
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -762,6 +763,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_ishare_init(sb);
+	if (err)
+		return err;
+
 	sbi->dir_ra_bytes = EROFS_DIR_RA_BYTES;
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
@@ -911,6 +916,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+
 	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
@@ -922,6 +928,7 @@ static void erofs_put_super(struct super_block *sb)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
+	erofs_ishare_exit(sb);
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
-- 
2.22.0


