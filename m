Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C26143743
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2020 07:49:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481zfm2cDyzDqV5
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2020 17:49:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481zfg25YCzDqCh
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2020 17:49:28 +1100 (AEDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B3E0436CD764D1ECFCC3;
 Tue, 21 Jan 2020 14:49:23 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 Jan
 2020 14:49:15 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH v2 2/2] erofs: clean up z_erofs_submit_queue()
Date: Tue, 21 Jan 2020 14:48:19 +0800
Message-ID: <20200121064819.139469-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121064747.138987-1-gaoxiang25@huawei.com>
References: <20200121064747.138987-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

A label and extra variables will be eliminated,
which is more cleaner.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
rebased on v2 1/2.

 fs/erofs/zdata.c | 95 ++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f63a893fe886..80e47f07d946 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1148,7 +1148,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool z_erofs_submit_queue(struct super_block *sb,
+static void z_erofs_submit_queue(struct super_block *sb,
 				 z_erofs_next_pcluster_t owned_head,
 				 struct list_head *pagepool,
 				 struct z_erofs_decompressqueue *fgq,
@@ -1157,19 +1157,12 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
-	struct bio *bio;
 	void *bi_private;
 	/* since bio will be NULL, no need to initialize last_index */
 	pgoff_t uninitialized_var(last_index);
-	bool force_submit = false;
-	unsigned int nr_bios;
+	unsigned int nr_bios = 0;
+	struct bio *bio = NULL;
 
-	if (owned_head == Z_EROFS_PCLUSTER_TAIL)
-		return false;
-
-	force_submit = false;
-	bio = NULL;
-	nr_bios = 0;
 	bi_private = jobqueueset_init(sb, q, fgq, force_fg);
 	qtail[JQ_BYPASS] = &q[JQ_BYPASS]->head;
 	qtail[JQ_SUBMIT] = &q[JQ_SUBMIT]->head;
@@ -1179,11 +1172,9 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 
 	do {
 		struct z_erofs_pcluster *pcl;
-		unsigned int clusterpages;
-		pgoff_t first_index;
-		struct page *page;
-		unsigned int i = 0, bypass = 0;
-		int err;
+		pgoff_t cur, end;
+		unsigned int i = 0;
+		bool bypass = true;
 
 		/* no possible 'owned_head' equals the following */
 		DBG_BUGON(owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
@@ -1191,55 +1182,50 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 
 		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
 
-		clusterpages = BIT(pcl->clusterbits);
+		cur = pcl->obj.index;
+		end = cur + BIT(pcl->clusterbits);
 
 		/* close the main owned chain at first */
 		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
 				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
 
-		first_index = pcl->obj.index;
-		force_submit |= (first_index != last_index + 1);
+		do {
+			struct page *page;
+			int err;
 
-repeat:
-		page = pickup_page_for_submission(pcl, i, pagepool,
-						  MNGD_MAPPING(sbi),
-						  GFP_NOFS);
-		if (!page) {
-			force_submit = true;
-			++bypass;
-			goto skippage;
-		}
+			page = pickup_page_for_submission(pcl, i++, pagepool,
+							  MNGD_MAPPING(sbi),
+							  GFP_NOFS);
+			if (!page)
+				continue;
 
-		if (bio && force_submit) {
+			if (bio && cur != last_index + 1) {
 submit_bio_retry:
-			submit_bio(bio);
-			bio = NULL;
-		}
-
-		if (!bio) {
-			bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+				submit_bio(bio);
+				bio = NULL;
+			}
 
-			bio->bi_end_io = z_erofs_decompressqueue_endio;
-			bio_set_dev(bio, sb->s_bdev);
-			bio->bi_iter.bi_sector = (sector_t)(first_index + i) <<
-				LOG_SECTORS_PER_BLOCK;
-			bio->bi_private = bi_private;
-			bio->bi_opf = REQ_OP_READ;
+			if (!bio) {
+				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 
-			++nr_bios;
-		}
+				bio->bi_end_io = z_erofs_decompressqueue_endio;
+				bio_set_dev(bio, sb->s_bdev);
+				bio->bi_iter.bi_sector = (sector_t)cur <<
+					LOG_SECTORS_PER_BLOCK;
+				bio->bi_private = bi_private;
+				bio->bi_opf = REQ_OP_READ;
+				++nr_bios;
+			}
 
-		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (err < PAGE_SIZE)
-			goto submit_bio_retry;
+			err = bio_add_page(bio, page, PAGE_SIZE, 0);
+			if (err < PAGE_SIZE)
+				goto submit_bio_retry;
 
-		force_submit = false;
-		last_index = first_index + i;
-skippage:
-		if (++i < clusterpages)
-			goto repeat;
+			last_index = cur;
+			bypass = false;
+		} while (++cur < end);
 
-		if (bypass < clusterpages)
+		if (!bypass)
 			qtail[JQ_SUBMIT] = &pcl->next;
 		else
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
@@ -1254,10 +1240,9 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	 */
 	if (!*force_fg && !nr_bios) {
 		kvfree(q[JQ_SUBMIT]);
-		return true;
+		return;
 	}
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
-	return true;
 }
 
 static void z_erofs_runqueue(struct super_block *sb,
@@ -1266,9 +1251,9 @@ static void z_erofs_runqueue(struct super_block *sb,
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
 
-	if (!z_erofs_submit_queue(sb, clt->owned_head,
-				  pagepool, io, &force_fg))
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
 		return;
+	z_erofs_submit_queue(sb, clt->owned_head, pagepool, io, &force_fg);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
 	z_erofs_decompress_queue(&io[JQ_BYPASS], pagepool);
-- 
2.17.1

