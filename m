Return-Path: <linux-erofs+bounces-1545-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B75CD7D0C
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 03:09:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZz2x6khqz2yFb;
	Tue, 23 Dec 2025 13:09:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766455753;
	cv=none; b=C/vwwAAA/KSXMiMMGUeLw4ixQ7DQMuIzdOphax/HQBIJF7407WTBXjCOfB9usRkzaYFiaFkHNzTV/LS4B8Drc/C3DczjiY3U0UTLr0A4htC0+UIgTNzoZ9EPqn6b/nwuC6tXScuKJEIhzs0CZ0lD5AR3so3rEznEo7ntXumknyfDjQeud2/EsQdhIE4awPTj7BiC7HcH1CZpkxoMETRK4WyWRvRnU+HR8y/AfH2cj8VBp1ug1u6HDE4qJVBG4TJAheCiUwbuPzUdAxjbEmqiNoPDycDOWjuQ5EKcwP/hiFKe1jzVayLKmpwqVglM++kIxh0Y2NcKsTYtqusW2mSjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766455753; c=relaxed/relaxed;
	bh=KIkxZJisraf0XLj1WNBBomkRNSvtdHwPTU4aOF//dhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fej4o2wHiDyaGUcYq3AQ4E4jn6uHr8WIG9/ztog9IxOHMai9C/6gzgmtR+/GZVP+DRFPZHS+L4L4RKxbThaLTIE+IomlRZjFIqxUCn4MTpe5xKm+qhsjea3FAqznRQn7Yo5gObJ5UBsW+PD8o3AD8E3HIZutmyg2eN93LiL4QCNR8l7fG+2TjceoQZbkuSbX5sItMzbETAY80dfCozItV1cgAl7YOj+DtwidqD4GNtNeISl0AdXnuUGztGE1Rr3fvz03zNiXy59uVuqd+X3ieB0Qni8LezsRtwPMLmrVhFVQj4TfsR5BHHgIQuFmZS9xnTLq6/9AzT6JCOrEk/THYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PLcUeJn1; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=PLcUeJn1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZz2w6lqTz2yFg
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 13:09:12 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KIkxZJisraf0XLj1WNBBomkRNSvtdHwPTU4aOF//dhI=;
	b=PLcUeJn1N1G3QBjNuvD0TMwwxKjxM2xaTY25CKVsHfF4gz4omLNNogXVNV0XHLUx/0uXFs8DI
	B0DqT0w2BNOX9Ax5BH7YNF01He5RbXk83JMHK8eF4nSqZVNC8uSLJCiOKNX7PeXdZEH8ESOXCqj
	WC/SfzFd5kgubH4sQjd4ERI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZyzH2BDvzKm5B;
	Tue, 23 Dec 2025 10:06:03 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DE1C40086;
	Tue, 23 Dec 2025 10:09:10 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 10:09:09 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v10 08/10] erofs: support unencoded inodes for page cache share
Date: Tue, 23 Dec 2025 01:56:17 +0000
Message-ID: <20251223015618.485626-9-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251223015618.485626-1-lihongbo22@huawei.com>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
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

Co-developed-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c     | 30 +++++++++++++++++++++++-------
 fs/erofs/inode.c    |  4 ++++
 fs/erofs/internal.h | 17 +++++++++++++++++
 fs/erofs/ishare.c   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 71e23d91123d..862df0c7ceb7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -269,6 +269,7 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 struct erofs_iomap_iter_ctx {
 	struct page *page;
 	void *base;
+	struct inode *realinode;
 };
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
@@ -276,14 +277,15 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 {
 	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
 	struct erofs_iomap_iter_ctx *ctx = iter->private;
-	struct super_block *sb = inode->i_sb;
+	struct inode *realinode = ctx ? ctx->realinode : inode;
+	struct super_block *sb = realinode->i_sb;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
 	int ret;
 
 	map.m_la = offset;
 	map.m_llen = length;
-	ret = erofs_map_blocks(inode, &map);
+	ret = erofs_map_blocks(realinode, &map);
 	if (ret < 0)
 		return ret;
 
@@ -296,7 +298,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
-	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(inode)) {
+	if (!(map.m_flags & EROFS_MAP_META) || !erofs_inode_in_metabox(realinode)) {
 		mdev = (struct erofs_map_dev) {
 			.m_deviceid = map.m_deviceid,
 			.m_pa = map.m_pa,
@@ -322,7 +324,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			void *ptr;
 
 			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
-						 erofs_inode_in_metabox(inode));
+						 erofs_inode_in_metabox(realinode));
 			if (IS_ERR(ptr))
 				return PTR_ERR(ptr);
 			iomap->inline_data = ptr;
@@ -379,30 +381,42 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct inode *inode = folio_inode(folio);
 	struct iomap_read_folio_ctx read_ctx = {
 		.ops		= &iomap_bio_read_ops,
 		.cur_folio	= folio,
 	};
-	struct erofs_iomap_iter_ctx iter_ctx = {};
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode	= erofs_ishare_iget(inode),
+	};
 
+	if (!iter_ctx.realinode)
+		return -EIO;
 	trace_erofs_read_folio(folio, true);
 
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	erofs_ishare_iput(iter_ctx.realinode);
 	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	struct inode *inode = rac->mapping->host;
 	struct iomap_read_folio_ctx read_ctx = {
 		.ops		= &iomap_bio_read_ops,
 		.rac		= rac,
 	};
-	struct erofs_iomap_iter_ctx iter_ctx = {};
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode	= erofs_ishare_iget(inode),
+	};
 
+	if (!iter_ctx.realinode)
+		return;
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	erofs_ishare_iput(iter_ctx.realinode);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -423,7 +437,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
 	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
-		struct erofs_iomap_iter_ctx iter_ctx = {};
+		struct erofs_iomap_iter_ctx iter_ctx = {
+			.realinode = inode,
+		};
 
 		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
 				    NULL, 0, &iter_ctx, 0);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bce98c845a18..8116738fe432 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -215,6 +215,10 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
 		inode->i_fop = &erofs_file_fops;
+#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
+		if (erofs_ishare_fill_inode(inode))
+			inode->i_fop = &erofs_ishare_fops;
+#endif
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ae9560434324..c35e6857d563 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -197,6 +197,19 @@ static inline bool erofs_is_fscache_mode(struct super_block *sb)
 			!erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bdev;
 }
 
+#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	/* we have assumed FS_ONDEMAND is excluded with FS_INODE_SHARE feature */
+	return inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+#else
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	return false;
+}
+#endif
+
 enum {
 	EROFS_ZIP_CACHE_DISABLED,
 	EROFS_ZIP_CACHE_READAHEAD,
@@ -563,11 +576,15 @@ int __init erofs_init_ishare(void);
 void erofs_exit_ishare(void);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
+struct inode *erofs_ishare_iget(struct inode *inode);
+void erofs_ishare_iput(struct inode *realinode);
 #else
 static inline int erofs_init_ishare(void) { return 0; }
 static inline void erofs_exit_ishare(void) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
+static inline struct inode *erofs_ishare_iget(struct inode *inode) { return inode; }
+static inline void erofs_ishare_iput(struct inode *realinode) {}
 #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 4b46016bcd03..269b53b3ed79 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -197,6 +197,37 @@ const struct file_operations erofs_ishare_fops = {
 	.splice_read	= filemap_splice_read,
 };
 
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
+
 int __init erofs_init_ishare(void)
 {
 	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
-- 
2.22.0


