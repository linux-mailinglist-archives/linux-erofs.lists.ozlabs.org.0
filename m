Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6CCFA81
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 14:54:25 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46nck60WZNzDqKf
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2019 23:54:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ncj85MNVzDqKS
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2019 23:53:32 +1100 (AEDT)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F1FD97FA28D9075F93DE;
 Tue,  8 Oct 2019 20:53:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:15 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH for-next 4/5] erofs: clean up decompress queue stuffs
Date: Tue, 8 Oct 2019 20:56:15 +0800
Message-ID: <20191008125616.183715-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Previously, both z_erofs_unzip_io and z_erofs_unzip_io_sb
record decompress queues for backend to use.

The only difference is that z_erofs_unzip_io is used for
on-stack sync decompression so that it doesn't have a super
block field (since the caller can pass it in its context),
but it increases complexity with only a pointer saving.

Rename z_erofs_unzip_io to z_erofs_decompressqueue with
a fixed super_block member and kill the other entirely,
and it can fallback to sync decompression if memory
allocation failure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 133 +++++++++++++++++++++--------------------------
 fs/erofs/zdata.h |   8 +--
 2 files changed, 60 insertions(+), 81 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e2a89aa921b1..878449f11665 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -693,13 +693,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
-static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
+static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
+				       bool sync, int bios)
 {
-	tagptr1_t t = tagptr_init(tagptr1_t, ptr);
-	struct z_erofs_unzip_io *io = tagptr_unfold_ptr(t);
-	bool background = tagptr_unfold_tags(t);
-
-	if (!background) {
+	/* wake up the caller thread for sync decompression */
+	if (sync) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&io->u.wait.lock, flags);
@@ -713,37 +711,30 @@ static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
 		queue_work(z_erofs_workqueue, &io->u.work);
 }
 
-static inline void z_erofs_vle_read_endio(struct bio *bio)
+static void z_erofs_vle_read_endio(struct bio *bio)
 {
-	struct erofs_sb_info *sbi = NULL;
+	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
+	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
 	blk_status_t err = bio->bi_status;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
-		bool cachemngd = false;
 
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (!sbi && !z_erofs_page_is_staging(page))
-			sbi = EROFS_SB(page->mapping->host->i_sb);
-
-		/* sbi should already be gotten if the page is managed */
-		if (sbi)
-			cachemngd = erofs_page_is_managed(sbi, page);
-
 		if (err)
 			SetPageError(page);
-		else if (cachemngd)
-			SetPageUptodate(page);
 
-		if (cachemngd)
+		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
+			if (!err)
+				SetPageUptodate(page);
 			unlock_page(page);
+		}
 	}
-
-	z_erofs_vle_unzip_kickoff(bio->bi_private, -1);
+	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
 	bio_put(bio);
 }
 
@@ -948,8 +939,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
 	return err;
 }
 
-static void z_erofs_vle_unzip_all(struct super_block *sb,
-				  struct z_erofs_unzip_io *io,
+static void z_erofs_vle_unzip_all(const struct z_erofs_decompressqueue *io,
 				  struct list_head *pagepool)
 {
 	z_erofs_next_pcluster_t owned = io->head;
@@ -966,21 +956,21 @@ static void z_erofs_vle_unzip_all(struct super_block *sb,
 		pcl = container_of(owned, struct z_erofs_pcluster, next);
 		owned = READ_ONCE(pcl->next);
 
-		z_erofs_decompress_pcluster(sb, pcl, pagepool);
+		z_erofs_decompress_pcluster(io->sb, pcl, pagepool);
 	}
 }
 
 static void z_erofs_vle_unzip_wq(struct work_struct *work)
 {
-	struct z_erofs_unzip_io_sb *iosb =
-		container_of(work, struct z_erofs_unzip_io_sb, io.u.work);
+	struct z_erofs_decompressqueue *bgq =
+		container_of(work, struct z_erofs_decompressqueue, u.work);
 	LIST_HEAD(pagepool);
 
-	DBG_BUGON(iosb->io.head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
-	z_erofs_vle_unzip_all(iosb->sb, &iosb->io, &pagepool);
+	DBG_BUGON(bgq->head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
+	z_erofs_vle_unzip_all(bgq, &pagepool);
 
 	put_pages_list(&pagepool);
-	kvfree(iosb);
+	kvfree(bgq);
 }
 
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
@@ -1089,31 +1079,28 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	return page;
 }
 
-static struct z_erofs_unzip_io *jobqueue_init(struct super_block *sb,
-					      struct z_erofs_unzip_io *io,
-					      bool foreground)
+static struct z_erofs_decompressqueue *
+jobqueue_init(struct super_block *sb,
+	      struct z_erofs_decompressqueue *fgq, bool *fg)
 {
-	struct z_erofs_unzip_io_sb *iosb;
+	struct z_erofs_decompressqueue *q;
 
-	if (foreground) {
-		/* waitqueue available for foreground io */
-		DBG_BUGON(!io);
-
-		init_waitqueue_head(&io->u.wait);
-		atomic_set(&io->pending_bios, 0);
-		goto out;
+	if (fg && !*fg) {
+		q = kvzalloc(sizeof(*q), GFP_KERNEL | __GFP_NOWARN);
+		if (!q) {
+			*fg = true;
+			goto fg_out;
+		}
+		INIT_WORK(&q->u.work, z_erofs_vle_unzip_wq);
+	} else {
+fg_out:
+		q = fgq;
+		init_waitqueue_head(&fgq->u.wait);
+		atomic_set(&fgq->pending_bios, 0);
 	}
-
-	iosb = kvzalloc(sizeof(*iosb), GFP_KERNEL | __GFP_NOFAIL);
-	DBG_BUGON(!iosb);
-
-	/* initialize fields in the allocated descriptor */
-	io = &iosb->io;
-	iosb->sb = sb;
-	INIT_WORK(&io->u.work, z_erofs_vle_unzip_wq);
-out:
-	io->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
-	return io;
+	q->sb = sb;
+	q->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
+	return q;
 }
 
 /* define decompression jobqueue types */
@@ -1124,22 +1111,17 @@ enum {
 };
 
 static void *jobqueueset_init(struct super_block *sb,
-			      z_erofs_next_pcluster_t qtail[],
-			      struct z_erofs_unzip_io *q[],
-			      struct z_erofs_unzip_io *fgq,
-			      bool forcefg)
+			      struct z_erofs_decompressqueue *q[],
+			      struct z_erofs_decompressqueue *fgq, bool *fg)
 {
 	/*
 	 * if managed cache is enabled, bypass jobqueue is needed,
 	 * no need to read from device for all pclusters in this queue.
 	 */
-	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, true);
-	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
+	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
+	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, fg);
 
-	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, forcefg);
-	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
-
-	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], !forcefg));
+	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], *fg));
 }
 
 static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
@@ -1161,9 +1143,8 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
-				       unsigned int nr_bios,
-				       bool force_fg)
+static bool postsubmit_is_all_bypassed(struct z_erofs_decompressqueue *q[],
+				       unsigned int nr_bios, bool force_fg)
 {
 	/*
 	 * although background is preferred, no one is pending for submission.
@@ -1172,19 +1153,19 @@ static bool postsubmit_is_all_bypassed(struct z_erofs_unzip_io *q[],
 	if (force_fg || nr_bios)
 		return false;
 
-	kvfree(container_of(q[JQ_SUBMIT], struct z_erofs_unzip_io_sb, io));
+	kvfree(q[JQ_SUBMIT]);
 	return true;
 }
 
 static bool z_erofs_vle_submit_all(struct super_block *sb,
 				   z_erofs_next_pcluster_t owned_head,
 				   struct list_head *pagepool,
-				   struct z_erofs_unzip_io *fgq,
-				   bool force_fg)
+				   struct z_erofs_decompressqueue *fgq,
+				   bool *force_fg)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
-	struct z_erofs_unzip_io *q[NR_JOBQUEUES];
+	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	struct bio *bio;
 	void *bi_private;
 	/* since bio will be NULL, no need to initialize last_index */
@@ -1198,7 +1179,9 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	force_submit = false;
 	bio = NULL;
 	nr_bios = 0;
-	bi_private = jobqueueset_init(sb, qtail, q, fgq, force_fg);
+	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
+	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
+	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
 	/* by default, all need io submission */
 	q[JQ_SUBMIT]->head = owned_head;
@@ -1274,10 +1257,10 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
-	if (postsubmit_is_all_bypassed(q, nr_bios, force_fg))
+	if (postsubmit_is_all_bypassed(q, nr_bios, *force_fg))
 		return true;
 
-	z_erofs_vle_unzip_kickoff(bi_private, nr_bios);
+	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
 	return true;
 }
 
@@ -1286,14 +1269,14 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 				     struct list_head *pagepool,
 				     bool force_fg)
 {
-	struct z_erofs_unzip_io io[NR_JOBQUEUES];
+	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
 	if (!z_erofs_vle_submit_all(sb, clt->owned_head,
-				    pagepool, io, force_fg))
+				    pagepool, io, &force_fg))
 		return;
 
 	/* decompress no I/O pclusters immediately */
-	z_erofs_vle_unzip_all(sb, &io[JQ_BYPASS], pagepool);
+	z_erofs_vle_unzip_all(&io[JQ_BYPASS], pagepool);
 
 	if (!force_fg)
 		return;
@@ -1303,7 +1286,7 @@ static void z_erofs_submit_and_unzip(struct super_block *sb,
 		   !atomic_read(&io[JQ_SUBMIT].pending_bios));
 
 	/* let's synchronous decompression */
-	z_erofs_vle_unzip_all(sb, &io[JQ_SUBMIT], pagepool);
+	z_erofs_vle_unzip_all(&io[JQ_SUBMIT], pagepool);
 }
 
 static int z_erofs_vle_normalaccess_readpage(struct file *file,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index faf950189bd7..7824f5563a55 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -84,7 +84,8 @@ struct z_erofs_pcluster {
 
 #define Z_EROFS_WORKGROUP_SIZE  sizeof(struct z_erofs_pcluster)
 
-struct z_erofs_unzip_io {
+struct z_erofs_decompressqueue {
+	struct super_block *sb;
 	atomic_t pending_bios;
 	z_erofs_next_pcluster_t head;
 
@@ -94,11 +95,6 @@ struct z_erofs_unzip_io {
 	} u;
 };
 
-struct z_erofs_unzip_io_sb {
-	struct z_erofs_unzip_io io;
-	struct super_block *sb;
-};
-
 #define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
 static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 					 struct page *page)
-- 
2.17.1

