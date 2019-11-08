Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A000F3E72
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2019 04:35:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 478Qrl3hPpzF6jb
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2019 14:35:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 478Qrb1RlyzF6SJ
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Nov 2019 14:35:08 +1100 (AEDT)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6C0308C89273512EAF29;
 Fri,  8 Nov 2019 11:35:04 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 8 Nov 2019
 11:34:57 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2] erofs: drop all vle annotations for runtime names
Date: Fri, 8 Nov 2019 11:37:33 +0800
Message-ID: <20191108033733.63919-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191108032526.40762-1-gaoxiang25@huawei.com>
References: <20191108032526.40762-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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
Cc: Gao Xiang <xiang@kernel.org>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

VLE was an old informal name of fixed-sized output
compression came from released ATC'19 paper [1].

Drop those old annotations since erofs can handle
all encoded clusters in block-aligned basis, which
is wider than fixed-sized output compression after
larger clustersize feature is fully implemented.

Unaligned encoded data won't be considered in EROFS
since it's not friendly to inplace I/O and decompression
inplace.

a) Fixed-sized output compression with 16KB pcluster:
  ___________________________________
 |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|
 |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks

b) Block-aligned fixed-sized input compression with
   16KB pcluster:
  ___________________________________
 |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxx00000|
 |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks

c) Block-unaligned fixed-sized input compression with
   16KB compression unit:
  ____________________________________________
 |..xxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|x.......|
 |___ 0___|___ 1___|___ 2___|___ 3___|___ 4___| physical blocks

Refine better names for those as well.

[1] https://www.usenix.org/conference/atc19/presentation/gao

Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changes since v1:
 - fix description in commit message;
 - fix a wrong rename "z_erofs_decompress_all" -> "z_erofs_decompress_queue".

 fs/erofs/internal.h |  4 +--
 fs/erofs/zdata.c    | 62 +++++++++++++++++++++------------------------
 fs/erofs/zmap.c     | 28 ++++++++++----------
 3 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 96d97eab88e3..437020b0de2c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -279,9 +279,7 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
-#ifdef CONFIG_EROFS_FS_ZIP
-extern const struct address_space_operations z_erofs_vle_normalaccess_aops;
-#endif
+extern const struct address_space_operations z_erofs_aops;
 
 /*
  * Logical to physical block mapping, used by erofs_map_blocks()
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index be3c79421dba..ec842cb6515a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -711,7 +711,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 		queue_work(z_erofs_workqueue, &io->u.work);
 }
 
-static void z_erofs_vle_read_endio(struct bio *bio)
+static void z_erofs_decompressqueue_endio(struct bio *bio)
 {
 	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
 	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
@@ -939,8 +939,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	return err;
 }
 
-static void z_erofs_vle_unzip_all(const struct z_erofs_decompressqueue *io,
-				  struct list_head *pagepool)
+static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
+				     struct list_head *pagepool)
 {
 	z_erofs_next_pcluster_t owned = io->head;
 
@@ -960,14 +960,14 @@ static void z_erofs_vle_unzip_all(const struct z_erofs_decompressqueue *io,
 	}
 }
 
-static void z_erofs_vle_unzip_wq(struct work_struct *work)
+static void z_erofs_decompressqueue_work(struct work_struct *work)
 {
 	struct z_erofs_decompressqueue *bgq =
 		container_of(work, struct z_erofs_decompressqueue, u.work);
 	LIST_HEAD(pagepool);
 
 	DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
-	z_erofs_vle_unzip_all(bgq, &pagepool);
+	z_erofs_decompress_queue(bgq, &pagepool);
 
 	put_pages_list(&pagepool);
 	kvfree(bgq);
@@ -1091,7 +1091,7 @@ jobqueue_init(struct super_block *sb,
 			*fg = true;
 			goto fg_out;
 		}
-		INIT_WORK(&q->u.work, z_erofs_vle_unzip_wq);
+		INIT_WORK(&q->u.work, z_erofs_decompressqueue_work);
 	} else {
 fg_out:
 		q = fgq;
@@ -1157,11 +1157,11 @@ static bool postsubmit_is_all_bypassed(struct z_erofs_decompressqueue *q[],
 	return true;
 }
 
-static bool z_erofs_vle_submit_all(struct super_block *sb,
-				   z_erofs_next_pcluster_t owned_head,
-				   struct list_head *pagepool,
-				   struct z_erofs_decompressqueue *fgq,
-				   bool *force_fg)
+static bool z_erofs_submit_queue(struct super_block *sb,
+				 z_erofs_next_pcluster_t owned_head,
+				 struct list_head *pagepool,
+				 struct z_erofs_decompressqueue *fgq,
+				 bool *force_fg)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
@@ -1228,7 +1228,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		if (!bio) {
 			bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 
-			bio->bi_end_io = z_erofs_vle_read_endio;
+			bio->bi_end_io = z_erofs_decompressqueue_endio;
 			bio_set_dev(bio, sb->s_bdev);
 			bio->bi_iter.bi_sector = (sector_t)(first_index + i) <<
 				LOG_SECTORS_PER_BLOCK;
@@ -1264,19 +1264,18 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	return true;
 }
 
-static void z_erofs_submit_and_unzip(struct super_block *sb,
-				     struct z_erofs_collector *clt,
-				     struct list_head *pagepool,
-				     bool force_fg)
+static void z_erofs_runqueue(struct super_block *sb,
+			     struct z_erofs_collector *clt,
+			     struct list_head *pagepool, bool force_fg)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
-	if (!z_erofs_vle_submit_all(sb, clt->owned_head,
-				    pagepool, io, &force_fg))
+	if (!z_erofs_submit_queue(sb, clt->owned_head,
+				  pagepool, io, &force_fg))
 		return;
 
-	/* decompress no I/O pclusters immediately */
-	z_erofs_vle_unzip_all(&io[JQ_BYPASS], pagepool);
+	/* handle bypass queue (no i/o pclusters) immediately */
+	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
 
 	if (!force_fg)
 		return;
@@ -1285,12 +1284,11 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 	io_wait_event(io[JQ_SUBMIT].u.wait,
 		      !atomic_read(&io[JQ_SUBMIT].pending_bios));
 
-	/* let's synchronous decompression */
-	z_erofs_vle_unzip_all(&io[JQ_SUBMIT], pagepool);
+	/* handle synchronous decompress queue in the caller context */
+	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
 }
 
-static int z_erofs_vle_normalaccess_readpage(struct file *file,
-					     struct page *page)
+static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
@@ -1305,7 +1303,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, true);
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1324,10 +1322,8 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->max_sync_decompress_pages;
 }
 
-static int z_erofs_vle_normalaccess_readpages(struct file *filp,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned int nr_pages)
+static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
+			     struct list_head *pages, unsigned int nr_pages)
 {
 	struct inode *const inode = mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
@@ -1382,7 +1378,7 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_submit_and_unzip(inode->i_sb, &f.clt, &pagepool, sync);
+	z_erofs_runqueue(inode->i_sb, &f.clt, &pagepool, sync);
 
 	if (f.map.mpage)
 		put_page(f.map.mpage);
@@ -1392,8 +1388,8 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
 	return 0;
 }
 
-const struct address_space_operations z_erofs_vle_normalaccess_aops = {
-	.readpage = z_erofs_vle_normalaccess_readpage,
-	.readpages = z_erofs_vle_normalaccess_readpages,
+const struct address_space_operations z_erofs_aops = {
+	.readpage = z_erofs_readpage,
+	.readpages = z_erofs_readpages,
 };
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 6a26c293ae2d..736db3a4cdef 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -22,11 +22,11 @@ int z_erofs_fill_inode(struct inode *inode)
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
 
-	inode->i_mapping->a_ops = &z_erofs_vle_normalaccess_aops;
+	inode->i_mapping->a_ops = &z_erofs_aops;
 	return 0;
 }
 
-static int fill_inode_lazy(struct inode *inode)
+static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
@@ -138,8 +138,8 @@ static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
-static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-					     unsigned long lcn)
+static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					 unsigned long lcn)
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -311,13 +311,13 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
 }
 
-static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
-				      unsigned int lcn)
+static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					  unsigned int lcn)
 {
 	const unsigned int datamode = EROFS_I(m->inode)->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
-		return vle_legacy_load_cluster_from_disk(m, lcn);
+		return legacy_load_cluster_from_disk(m, lcn);
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
 		return compacted_load_cluster_from_disk(m, lcn);
@@ -325,8 +325,8 @@ static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	return -EINVAL;
 }
 
-static int vle_extent_lookback(struct z_erofs_maprecorder *m,
-			       unsigned int lookback_distance)
+static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
+				   unsigned int lookback_distance)
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	struct erofs_map_blocks *const map = m->map;
@@ -343,7 +343,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 
 	/* load extent head logical cluster if needed */
 	lcn -= lookback_distance;
-	err = vle_load_cluster_from_disk(m, lcn);
+	err = z_erofs_load_cluster_from_disk(m, lcn);
 	if (err)
 		return err;
 
@@ -356,7 +356,7 @@ static int vle_extent_lookback(struct z_erofs_maprecorder *m,
 			DBG_BUGON(1);
 			return -EFSCORRUPTED;
 		}
-		return vle_extent_lookback(m, m->delta[0]);
+		return z_erofs_extent_lookback(m, m->delta[0]);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		map->m_flags &= ~EROFS_MAP_ZIPPED;
 		/* fallthrough */
@@ -396,7 +396,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		goto out;
 	}
 
-	err = fill_inode_lazy(inode);
+	err = z_erofs_fill_inode_lazy(inode);
 	if (err)
 		goto out;
 
@@ -405,7 +405,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	m.lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = vle_load_cluster_from_disk(&m, m.lcn);
+	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
 	if (err)
 		goto unmap_out;
 
@@ -436,7 +436,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
-		err = vle_extent_lookback(&m, m.delta[0]);
+		err = z_erofs_extent_lookback(&m, m.delta[0]);
 		if (err)
 			goto unmap_out;
 		break;
-- 
2.17.1

