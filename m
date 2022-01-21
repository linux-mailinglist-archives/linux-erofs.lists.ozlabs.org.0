Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7B495C95
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 10:14:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JgDH06hjQz30RD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jan 2022 20:14:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JgDGv43m3z2xXV
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jan 2022 20:14:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V2Qge0H_1642756454; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V2Qge0H_1642756454) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 21 Jan 2022 17:14:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: avoid unnecessary z_erofs_decompressqueue_work()
 declaration
Date: Fri, 21 Jan 2022 17:14:12 +0800
Message-Id: <20220121091412.86086-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just code rearrange. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 498b7666efe8..423bc1a61da5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -810,68 +810,11 @@ static bool z_erofs_get_sync_decompress_policy(struct erofs_sb_info *sbi,
 	return false;
 }
 
-static void z_erofs_decompressqueue_work(struct work_struct *work);
-static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
-				       bool sync, int bios)
-{
-	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
-
-	/* wake up the caller thread for sync decompression */
-	if (sync) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&io->u.wait.lock, flags);
-		if (!atomic_add_return(bios, &io->pending_bios))
-			wake_up_locked(&io->u.wait);
-		spin_unlock_irqrestore(&io->u.wait.lock, flags);
-		return;
-	}
-
-	if (atomic_add_return(bios, &io->pending_bios))
-		return;
-	/* Use workqueue and sync decompression for atomic contexts only */
-	if (in_atomic() || irqs_disabled()) {
-		queue_work(z_erofs_workqueue, &io->u.work);
-		/* enable sync decompression for readahead */
-		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
-			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
-		return;
-	}
-	z_erofs_decompressqueue_work(&io->u.work);
-}
-
 static bool z_erofs_page_is_invalidated(struct page *page)
 {
 	return !page->mapping && !z_erofs_is_shortlived_page(page);
 }
 
-static void z_erofs_decompressqueue_endio(struct bio *bio)
-{
-	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
-	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
-	blk_status_t err = bio->bi_status;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-
-		DBG_BUGON(PageUptodate(page));
-		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
-		if (err)
-			SetPageError(page);
-
-		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
-			if (!err)
-				SetPageUptodate(page);
-			unlock_page(page);
-		}
-	}
-	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
-	bio_put(bio);
-}
-
 static int z_erofs_decompress_pcluster(struct super_block *sb,
 				       struct z_erofs_pcluster *pcl,
 				       struct page **pagepool)
@@ -1123,6 +1066,35 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 	kvfree(bgq);
 }
 
+static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
+				       bool sync, int bios)
+{
+	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
+
+	/* wake up the caller thread for sync decompression */
+	if (sync) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&io->u.wait.lock, flags);
+		if (!atomic_add_return(bios, &io->pending_bios))
+			wake_up_locked(&io->u.wait);
+		spin_unlock_irqrestore(&io->u.wait.lock, flags);
+		return;
+	}
+
+	if (atomic_add_return(bios, &io->pending_bios))
+		return;
+	/* Use workqueue and sync decompression for atomic contexts only */
+	if (in_atomic() || irqs_disabled()) {
+		queue_work(z_erofs_workqueue, &io->u.work);
+		/* enable sync decompression for readahead */
+		if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+			sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
+		return;
+	}
+	z_erofs_decompressqueue_work(&io->u.work);
+}
+
 static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 					       unsigned int nr,
 					       struct page **pagepool,
@@ -1300,6 +1272,33 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
+static void z_erofs_decompressqueue_endio(struct bio *bio)
+{
+	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
+	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
+	blk_status_t err = bio->bi_status;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct page *page = bvec->bv_page;
+
+		DBG_BUGON(PageUptodate(page));
+		DBG_BUGON(z_erofs_page_is_invalidated(page));
+
+		if (err)
+			SetPageError(page);
+
+		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
+			if (!err)
+				SetPageUptodate(page);
+			unlock_page(page);
+		}
+	}
+	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
+	bio_put(bio);
+}
+
 static void z_erofs_submit_queue(struct super_block *sb,
 				 struct z_erofs_decompress_frontend *f,
 				 struct page **pagepool,
-- 
2.24.4

