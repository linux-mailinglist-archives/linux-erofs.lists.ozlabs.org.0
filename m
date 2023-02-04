Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B668A92D
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 10:31:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P86hf2J0Qz3f7G
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Feb 2023 20:30:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P86hY5bW2z3c4B
	for <linux-erofs@lists.ozlabs.org>; Sat,  4 Feb 2023 20:30:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VarVFJk_1675503047;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VarVFJk_1675503047)
          by smtp.aliyun-inc.com;
          Sat, 04 Feb 2023 17:30:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH 2/6] erofs: avoid tagged pointers to mark sync decompression
Date: Sat,  4 Feb 2023 17:30:36 +0800
Message-Id: <20230204093040.97967-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We could just use a boolean in z_erofs_decompressqueue for sync
decompression to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 42 ++++++++++++++++--------------------------
 fs/erofs/zdata.h |  2 +-
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5200bb86e264..f015a90839f6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1157,12 +1157,12 @@ static void z_erofs_decompressqueue_work(struct work_struct *work)
 }
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
-				       bool sync, int bios)
+				       int bios)
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
 
 	/* wake up the caller thread for sync decompression */
-	if (sync) {
+	if (io->sync) {
 		if (!atomic_add_return(bios, &io->pending_bios))
 			complete(&io->u.done);
 		return;
@@ -1294,9 +1294,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	return page;
 }
 
-static struct z_erofs_decompressqueue *
-jobqueue_init(struct super_block *sb,
-	      struct z_erofs_decompressqueue *fgq, bool *fg)
+static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
+			      struct z_erofs_decompressqueue *fgq, bool *fg)
 {
 	struct z_erofs_decompressqueue *q;
 
@@ -1313,6 +1312,7 @@ jobqueue_init(struct super_block *sb,
 		init_completion(&fgq->u.done);
 		atomic_set(&fgq->pending_bios, 0);
 		q->eio = false;
+		q->sync = true;
 	}
 	q->sb = sb;
 	q->head = Z_EROFS_PCLUSTER_TAIL_CLOSED;
@@ -1326,20 +1326,6 @@ enum {
 	NR_JOBQUEUES,
 };
 
-static void *jobqueueset_init(struct super_block *sb,
-			      struct z_erofs_decompressqueue *q[],
-			      struct z_erofs_decompressqueue *fgq, bool *fg)
-{
-	/*
-	 * if managed cache is enabled, bypass jobqueue is needed,
-	 * no need to read from device for all pclusters in this queue.
-	 */
-	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
-	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, fg);
-
-	return tagptr_cast_ptr(tagptr_fold(tagptr1_t, q[JQ_SUBMIT], *fg));
-}
-
 static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 				    z_erofs_next_pcluster_t qtail[],
 				    z_erofs_next_pcluster_t owned_head)
@@ -1361,8 +1347,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 
 static void z_erofs_decompressqueue_endio(struct bio *bio)
 {
-	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
-	struct z_erofs_decompressqueue *q = tagptr_unfold_ptr(t);
+	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -1381,7 +1366,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 	}
 	if (err)
 		q->eio = true;
-	z_erofs_decompress_kickoff(q, tagptr_unfold_tags(t), -1);
+	z_erofs_decompress_kickoff(q, -1);
 	bio_put(bio);
 }
 
@@ -1394,7 +1379,6 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	struct address_space *mc = MNGD_MAPPING(EROFS_SB(sb));
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	void *bi_private;
 	z_erofs_next_pcluster_t owned_head = f->owned_head;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
 	pgoff_t last_index;
@@ -1404,7 +1388,13 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	unsigned long pflags;
 	int memstall = 0;
 
-	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
+	/*
+	 * if managed cache is enabled, bypass jobqueue is needed,
+	 * no need to read from device for all pclusters in this queue.
+	 */
+	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
+	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, force_fg);
+
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
 
@@ -1473,7 +1463,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				last_bdev = mdev.m_bdev;
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					LOG_SECTORS_PER_BLOCK;
-				bio->bi_private = bi_private;
+				bio->bi_private = q[JQ_SUBMIT];
 				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
@@ -1506,7 +1496,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		kvfree(q[JQ_SUBMIT]);
 		return;
 	}
-	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
+	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
 static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c95212985..b139de5473a9 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -110,7 +110,7 @@ struct z_erofs_decompressqueue {
 		struct work_struct work;
 	} u;
 
-	bool eio;
+	bool eio, sync;
 };
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
-- 
2.24.4

