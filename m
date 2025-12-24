Return-Path: <linux-erofs+bounces-1579-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99729CDB4F0
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:22:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbdyL2m9bz2x99;
	Wed, 24 Dec 2025 15:22:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766550154;
	cv=none; b=VaZW/pFBsu1lBJJd0Rzjj0ao1vMQmkMgGtkErTAl+FRqko3zOsBDvoTUpfCvCor9zdxq/54MxiQ3Lfb/tGL5uTRWxVK/0CuRf39/DFdrtId9EBnk1sksuJa5Fue/gqSfHpG5IGE0tYxfD1bCJlC+bMMwrZUB8HdZE9qU3HNOiZbSMNIzgVgKW8XO2tOGHekTWnCgJjIitpeSbzDMU9YTSSQKR4/ReqCx/15QBJVDjQ9N+1z6+bpcL9Sn1ZpTz1auKwzVpm0lhP778B4aEnZOkjtpApc2XnugniqJpsv4rcalsRC/EVmTIMzsYtZUYMkLRY2uTFsBzx6Ri4QJJn2iRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766550154; c=relaxed/relaxed;
	bh=DQe8eNEa0xEcHdVIeP4Udf9vnaiB64w0bSZE/GZXsGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyfF3bgLPOSYYAs8M7puj9bW0eZrccGnlgSRVOyTrUzmytLw5bI6A8ZjHyrbkIvwSEIUgApEy+O2S5N1+4RDq1x20SnxPllXiMspXFNRXL8WLuBfV0aPzNDjrdgM6wFMdLbAIzAUibcBHxTSWuwc2lqyOFL1yK0qo5xCq4syqHdLPECqni5AOT4561xxdaQ2vnsh3lBL7Z7FO4HFpICfJNxIPwiLHvH/npLaGl2ekX6HAgswhVCqzLNXLR3HE5/N8X6RznsRQ4oTmaiIccwTPHLYqbnYXWJLNA11DykbnW4fNWdH4K1PE6u6rVCt0v94IUcxlc6eB2DTInYsMyEMDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E56tzBF2; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=E56tzBF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbdyK17pFz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:22:33 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DQe8eNEa0xEcHdVIeP4Udf9vnaiB64w0bSZE/GZXsGo=;
	b=E56tzBF2TLeqVEZleh2b8wMoDktWdkrpayVT4QCzuO6RlUqiZWz99wMS1PnDjVGr71Alyqppv
	tfWC4NbFiIIcW3U9o8HAT+DetPgrxqWKXA0mgUwPvnM22atKTpT43QX/lOwzi6p83LYcW+IxSfw
	zOu08iG2gyUIuPhS6ewAfNY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtf5xZszKm5B;
	Wed, 24 Dec 2025 12:19:22 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 50A2440563;
	Wed, 24 Dec 2025 12:22:30 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:29 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 08/10] erofs: support unencoded inodes for page cache share
Date: Wed, 24 Dec 2025 04:09:30 +0000
Message-ID: <20251224040932.496478-9-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20251224040932.496478-1-lihongbo22@huawei.com>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
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
 fs/erofs/data.c     | 32 +++++++++++++++++++++++++-------
 fs/erofs/inode.c    |  4 ++++
 fs/erofs/internal.h |  2 ++
 fs/erofs/ishare.c   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 71e23d91123d..cbe7ac194b09 100644
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
@@ -379,30 +381,44 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
+	struct inode *inode = folio_inode(folio);
 	struct iomap_read_folio_ctx read_ctx = {
 		.ops		= &iomap_bio_read_ops,
 		.cur_folio	= folio,
 	};
-	struct erofs_iomap_iter_ctx iter_ctx = {};
+	bool need_iput = false;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode	= erofs_real_inode(inode, &need_iput),
+	};
 
+	DBG_BUGON(!iter_ctx.realinode);
 	trace_erofs_read_folio(folio, true);
 
 	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	if (need_iput)
+		iput(iter_ctx.realinode);
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
+	bool need_iput = false;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode	= erofs_real_inode(inode, &need_iput),
+	};
 
+	DBG_BUGON(!iter_ctx.realinode);
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
 	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
+	if (need_iput)
+		iput(iter_ctx.realinode);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
@@ -423,7 +439,9 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
index a2b2434ee3c8..6930cce8f1fb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -565,11 +565,13 @@ int __init erofs_init_ishare(void);
 void erofs_exit_ishare(void);
 bool erofs_ishare_fill_inode(struct inode *inode);
 void erofs_ishare_free_inode(struct inode *inode);
+struct inode *erofs_real_inode(struct inode *inode, bool *need_iput);
 #else
 static inline int erofs_init_ishare(void) { return 0; }
 static inline void erofs_exit_ishare(void) {}
 static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
 static inline void erofs_ishare_free_inode(struct inode *inode) {}
+static inline struct inode *erofs_real_inode(struct inode *inode, bool *need_iput) { return inode; }
 #endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
 
 long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index 09ea456f2eab..634b7ea63738 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -11,6 +11,12 @@
 
 static struct vfsmount *erofs_ishare_mnt;
 
+static inline bool erofs_is_ishare_inode(struct inode *inode)
+{
+	/* assumed FS_ONDEMAND is excluded with FS_PAGE_CACHE_SHARE feature */
+	return inode->i_sb->s_type == &erofs_anon_fs_type;
+}
+
 static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
 {
 	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
@@ -157,6 +163,31 @@ const struct file_operations erofs_ishare_fops = {
 	.splice_read	= filemap_splice_read,
 };
 
+struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
+{
+	struct erofs_inode *vi, *vi_dedup;
+	struct inode *realinode;
+
+	if (!erofs_is_ishare_inode(inode))
+		return inode;
+
+	vi_dedup = EROFS_I(inode);
+	spin_lock(&vi_dedup->ishare_lock);
+	/* fetch any one as real inode */
+	DBG_BUGON(list_empty(&vi_dedup->ishare_list));
+	list_for_each_entry(vi, &vi_dedup->ishare_list, ishare_list) {
+		realinode = igrab(&vi->vfs_inode);
+		if (realinode) {
+			*need_iput = true;
+			break;
+		}
+	}
+	spin_unlock(&vi_dedup->ishare_lock);
+
+	DBG_BUGON(!realinode);
+	return realinode;
+}
+
 int __init erofs_init_ishare(void)
 {
 	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
-- 
2.22.0


