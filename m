Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD0A4AC69
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Mar 2025 15:50:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4p0T3zslz3cDh
	for <lists+linux-erofs@lfdr.de>; Sun,  2 Mar 2025 01:50:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740840626;
	cv=none; b=KBfsmWIHHyhl3J5C9dxNQEV700ywQwVMVLKK+rV/3ykPRDLBGWDbEhl76pZLe/UDLgtPDGNZ4XFvxqMlSHCyCY1PUhHQIhK8FiLHAD/8fXPVtpzoyMBs29fGhuFnPgAvLdhv+DDq7fk5BSTVU0xFruashPv2CdSdQdJHNr/x08j9ieV+OmUA9JjXVnw+9qZv9QSmwMg8Ly+QdCOqKzXJCgUZbcFAlHzkmXsCFlS4AA2tAvC74jO2Gjqg/w5KgnVwhm2bZYF0ZHFkutNcAugFNb1R4JIdCqTGhsQ/kbYwPbUdN3ZGeiCVCIleowTl4/BcqiDRwMjLuec2H0LBmqE93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740840626; c=relaxed/relaxed;
	bh=cEQ88iz4dOmNw4DeKVvc23lhQVA1B+Iv1dIwRL42kpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acndKF1HSFPpGt1L0vNdIwIG+rmPgoRcg5WDTWaCGCvNRa77BAERdA9nOUWJUlcMSMpGZ+BTuZkziz9JbIIH/p+j7CVlj5kbQPXPZ/LU4hczaEldO+buxi/MpnbDSIz5oU1Hby6kPsX8/x+pd4jldWRt4qSXcj06vwFwzW0yu4lFkL+izuI5nZ0at3nuTpG5fRQkZbyAK4en9pFsvnDUdRbkjViYa66V/7trho20F2Ae1iX4VbITsrFg4dnGwJO1p9LtpQVHT3xxzR+A26i6h5y6OLEBJNhi6ArLpUJugd9XOYooqBkCz5YXjVEx/HkOAARLqOavQKJVU5RSqLenCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dBwZWNLz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dBwZWNLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4p0G06Xmz2xDD
	for <linux-erofs@lists.ozlabs.org>; Sun,  2 Mar 2025 01:50:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740840617; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cEQ88iz4dOmNw4DeKVvc23lhQVA1B+Iv1dIwRL42kpM=;
	b=dBwZWNLzFjxOzux7d7yHh23P6buBwCeQ0bQXIqoLxFBIY3QMpq70dv0kfC4raPoI/LkwM6yhNzad+hYT2aJqEdGNNjFTrx6dDxzDbySOuCzZUU1iYtb0OOen1jyzs+Uh/BmHLdW25q0mvqkSJ3N1zmn6dxg3WRV9lcz30jBj7NM=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WQSgWRM_1740840616 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:50:16 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v6 5/7] erofs: support unencoded inodes for page cache share
Date: Sat,  1 Mar 2025 22:49:42 +0800
Message-ID: <20250301145002.2420830-6-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

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
---
 fs/erofs/data.c     | 82 ++++++++++++++++++++++++++++++++++++++++----
 fs/erofs/inode.c    |  5 +++
 fs/erofs/internal.h |  4 +++
 fs/erofs/ishare.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/ishare.h   | 27 +++++++++++++++
 fs/erofs/super.c    | 11 ++++++
 6 files changed, 205 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..b7d7e67832eb 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include "ishare.h"
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
@@ -267,18 +268,44 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
 	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
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
 
@@ -297,7 +324,11 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->bdev = mdev.m_bdev;
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
-	iomap->private = NULL;
+
+	if (is_ishare)
+		erofs_iomap->base = NULL;
+	else
+		iomap->private = NULL;
 
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
@@ -316,7 +347,10 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
 		iomap->addr = mdev.m_pa;
@@ -329,7 +363,17 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
@@ -342,6 +386,13 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	} else {
 		DBG_BUGON(iomap->type == IOMAP_INLINE);
 	}
+
+	if (is_ishare) {
+		erofs_ishare_iput(erofs_iomap->realinode);
+		kfree(erofs_iomap);
+		iomap->private = NULL;
+	}
+
 	return written;
 }
 
@@ -370,12 +421,29 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	struct erofs_read_ctx rdctx = {
+		.file = file,
+		.inode = folio_inode(folio),
+	};
+	int ret;
+
+	erofs_read_begin(&rdctx);
+	ret = iomap_read_folio(folio, &erofs_iomap_ops);
+	erofs_read_end(&rdctx);
+
+	return ret;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	struct erofs_read_ctx rdctx = {
+		.file = rac->file,
+		.inode = rac->mapping->host,
+	};
+
+	erofs_read_begin(&rdctx);
+	iomap_readahead(rac, &erofs_iomap_ops);
+	erofs_read_end(&rdctx);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d4b89407822a..77893761d773 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
+#include "ishare.h"
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
@@ -216,6 +217,10 @@ static int erofs_fill_inode(struct inode *inode)
 			inode->i_fop = &generic_ro_fops;
 		else
 			inode->i_fop = &erofs_file_fops;
+#ifdef CONFIG_EROFS_FS_INODE_SHARE
+		if (erofs_ishare_fill_inode(inode))
+			inode->i_fop = &erofs_ishare_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 49613b257a6a..d736e4b57701 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -294,11 +294,15 @@ struct erofs_inode {
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
index 77786ec6834e..e68bb1a6cf4b 100644
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
@@ -236,3 +239,83 @@ const struct file_operations erofs_ishare_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
+
+void erofs_read_begin(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi_real, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi_real = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (!list_empty(&vi_real->processing_link)) {
+		atomic_inc(&vi_real->processing_count);
+	} else {
+		list_add(&vi_real->processing_link,
+			 &vi_dedup->processing_head);
+		atomic_set(&vi_real->processing_count, 1);
+	}
+	spin_unlock(&vi_dedup->lock);
+}
+
+void erofs_read_end(struct erofs_read_ctx *rdctx)
+{
+	struct erofs_inode *vi_real, *vi_dedup;
+
+	if (!rdctx->file || !erofs_is_ishare_inode(rdctx->inode))
+		return;
+
+	vi_real = rdctx->file->private_data;
+	vi_dedup = EROFS_I(file_inode(rdctx->file));
+
+	spin_lock(&vi_dedup->lock);
+	if (atomic_dec_and_test(&vi_real->processing_count))
+		list_del_init(&vi_real->processing_link);
+	spin_unlock(&vi_dedup->lock);
+}
+
+/*
+ * erofs_ishare_iget - find the backing inode.
+ */
+struct inode *erofs_ishare_iget(struct inode *inode)
+{
+	struct erofs_inode *vi_real, *vi_dedup;
+	struct inode *realinode;
+
+	if (!erofs_is_ishare_inode(inode))
+		return igrab(inode);
+
+	vi_dedup = EROFS_I(inode);
+	spin_lock(&vi_dedup->lock);
+	/* try processing inodes first */
+	if (!list_empty(&vi_dedup->processing_head)) {
+		list_for_each_entry(vi_real, &vi_dedup->processing_head,
+				    processing_link) {
+			realinode = igrab(&vi_real->vfs_inode);
+			if (realinode) {
+				spin_unlock(&vi_dedup->lock);
+				return realinode;
+			}
+		}
+	}
+
+	/* fall back to all backing inodes */
+	DBG_BUGON(list_empty(&vi_dedup->backing_head));
+	list_for_each_entry(vi_real, &vi_dedup->backing_head, backing_link) {
+		realinode = igrab(&vi_real->vfs_inode);
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
index 54f2251c8179..a0ff9403511b 100644
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
@@ -16,6 +21,20 @@ void erofs_ishare_exit(struct super_block *sb);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
 
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+
+	return !erofs_is_fscache_mode(inode->i_sb) &&
+	       inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+
+/* read/readahead */
+void erofs_read_begin(struct erofs_read_ctx *rdctx);
+void erofs_read_end(struct erofs_read_ctx *rdctx);
+
+struct inode *erofs_ishare_iget(struct inode *inode);
+void erofs_ishare_iput(struct inode *realinode);
+
 #else
 
 static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
@@ -23,6 +42,14 @@ static inline void erofs_ishare_exit(struct super_block *sb) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
 
+static inline bool erofs_is_ishare_inode(struct inode *inode) { return false; }
+
+static inline void erofs_read_begin(struct erofs_read_ctx *rdctx) {}
+static inline void erofs_read_end(struct erofs_read_ctx *rdctx) {}
+
+static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
+static inline void erofs_ishare_iput(struct inode *realinode) {}
+
 #endif // CONFIG_EROFS_FS_INODE_SHARE
 
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 98d8b58afe5e..64ef5c78fedd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -82,6 +82,7 @@ static void erofs_free_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 
+	erofs_ishare_free_inode(inode);
 	if (inode->i_op == &erofs_fast_symlink_iops)
 		kfree(inode->i_link);
 	kfree(vi->xattr_shared_xattrs);
@@ -688,6 +689,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	if (sbi->ishare_key) {
+		err = erofs_ishare_init(sb);
+		if (err)
+			return err;
+	}
+
 	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
@@ -823,6 +830,10 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
+
+	if (sbi->ishare_key)
+		erofs_ishare_exit(sb);
+
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	erofs_sb_free(sbi);
-- 
2.43.5

