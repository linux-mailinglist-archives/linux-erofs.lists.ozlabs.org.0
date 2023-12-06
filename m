Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BB806A6A
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 10:11:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlWqR0Zp8z3ck3
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 20:11:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlWqD07rnz3cWD
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 20:11:18 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxxSRPy_1701853871;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VxxSRPy_1701853871)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 17:11:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs: support I/O submission for sub-page compressed blocks
Date: Wed,  6 Dec 2023 17:10:53 +0800
Message-Id: <20231206091057.87027-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
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

Add a basic I/O submission path first to support sub-page blocks:

 - Temporary short-lived pages will be used entirely;

 - In-place I/O pages can be used partially, but compressed pages need
   to be able to be mapped in contiguous virtual memory.

As a start, currently cache decompression is explicitly disabled for
sub-page blocks, which will be supported in the future.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 156 ++++++++++++++++++++++-------------------------
 1 file changed, 74 insertions(+), 82 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a33cd6757f98..421c0a88a0ca 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1435,86 +1435,85 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	z_erofs_decompressqueue_work(&io->u.work);
 }
 
-static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
-					       unsigned int nr,
-					       struct page **pagepool,
-					       struct address_space *mc)
+static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
+				 struct z_erofs_decompress_frontend *f,
+				 struct z_erofs_pcluster *pcl,
+				 unsigned int nr,
+				 struct address_space *mc)
 {
-	const pgoff_t index = pcl->obj.index;
 	gfp_t gfp = mapping_gfp_mask(mc);
 	bool tocache = false;
-
+	struct z_erofs_bvec *zbv = pcl->compressed_bvecs + nr;
 	struct address_space *mapping;
-	struct page *oldpage, *page;
-	int justfound;
+	struct page *page, *oldpage;
+	int justfound, bs = i_blocksize(f->inode);
 
+	/* Except for inplace pages, the entire page can be used for I/Os */
+	bvec->bv_offset = 0;
+	bvec->bv_len = PAGE_SIZE;
 repeat:
-	page = READ_ONCE(pcl->compressed_bvecs[nr].page);
-	oldpage = page;
-
-	if (!page)
+	oldpage = READ_ONCE(zbv->page);
+	if (!oldpage)
 		goto out_allocpage;
 
-	justfound = (unsigned long)page & 1UL;
-	page = (struct page *)((unsigned long)page & ~1UL);
+	justfound = (unsigned long)oldpage & 1UL;
+	page = (struct page *)((unsigned long)oldpage & ~1UL);
+	bvec->bv_page = page;
 
+	DBG_BUGON(z_erofs_is_shortlived_page(page));
 	/*
-	 * preallocated cached pages, which is used to avoid direct reclaim
-	 * otherwise, it will go inplace I/O path instead.
+	 * Handle preallocated cached pages.  We tried to allocate such pages
+	 * without triggering direct reclaim.  If allocation failed, inplace
+	 * file-backed pages will be used instead.
 	 */
 	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
-		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
 		set_page_private(page, 0);
+		WRITE_ONCE(zbv->page, page);
 		tocache = true;
 		goto out_tocache;
 	}
-	mapping = READ_ONCE(page->mapping);
 
+	mapping = READ_ONCE(page->mapping);
 	/*
-	 * file-backed online pages in plcuster are all locked steady,
-	 * therefore it is impossible for `mapping' to be NULL.
+	 * File-backed pages for inplace I/Os are all locked steady,
+	 * therefore it is impossible for `mapping` to be NULL.
 	 */
-	if (mapping && mapping != mc)
-		/* ought to be unmanaged pages */
-		goto out;
-
-	/* directly return for shortlived page as well */
-	if (z_erofs_is_shortlived_page(page))
-		goto out;
+	if (mapping && mapping != mc) {
+		if (zbv->offset < 0)
+			bvec->bv_offset = round_up(-zbv->offset, bs);
+		bvec->bv_len = round_up(zbv->end, bs) - bvec->bv_offset;
+		return;
+	}
 
 	lock_page(page);
-
 	/* only true if page reclaim goes wrong, should never happen */
 	DBG_BUGON(justfound && PagePrivate(page));
 
-	/* the page is still in manage cache */
+	/* the cached page is still in managed cache */
 	if (page->mapping == mc) {
-		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
-
+		WRITE_ONCE(zbv->page, page);
+		/*
+		 * The cached page is still available but without a valid
+		 * `->private` pcluster hint.  Let's reconnect them.
+		 */
 		if (!PagePrivate(page)) {
-			/*
-			 * impossible to be !PagePrivate(page) for
-			 * the current restriction as well if
-			 * the page is already in compressed_bvecs[].
-			 */
 			DBG_BUGON(!justfound);
-
-			justfound = 0;
-			set_page_private(page, (unsigned long)pcl);
-			SetPagePrivate(page);
+			/* compressed_bvecs[] already takes a ref */
+			attach_page_private(page, pcl);
+			put_page(page);
 		}
 
-		/* no need to submit io if it is already up-to-date */
+		/* no need to submit if it is already up-to-date */
 		if (PageUptodate(page)) {
 			unlock_page(page);
-			page = NULL;
+			bvec->bv_page = NULL;
 		}
-		goto out;
+		return;
 	}
 
 	/*
-	 * the managed page has been truncated, it's unsafe to
-	 * reuse this one, let's allocate a new cache-managed page.
+	 * It has been truncated, so it's unsafe to reuse this one. Let's
+	 * allocate a new page for compressed data.
 	 */
 	DBG_BUGON(page->mapping);
 	DBG_BUGON(!justfound);
@@ -1523,25 +1522,23 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	unlock_page(page);
 	put_page(page);
 out_allocpage:
-	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
-	if (oldpage != cmpxchg(&pcl->compressed_bvecs[nr].page,
-			       oldpage, page)) {
-		erofs_pagepool_add(pagepool, page);
+	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	if (oldpage != cmpxchg(&zbv->page, oldpage, page)) {
+		erofs_pagepool_add(&f->pagepool, page);
 		cond_resched();
 		goto repeat;
 	}
+	bvec->bv_page = page;
 out_tocache:
-	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
-		/* turn into temporary page if fails (1 ref) */
+	if (!tocache || bs != PAGE_SIZE ||
+	    add_to_page_cache_lru(page, mc, pcl->obj.index + nr, gfp)) {
+		/* turn into a temporary shortlived page (1 ref) */
 		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
-		goto out;
+		return;
 	}
 	attach_page_private(page, pcl);
-	/* drop a refcount added by allocpage (then we have 2 refs here) */
+	/* drop a refcount added by allocpage (then 2 refs in total here) */
 	put_page(page);
-
-out:	/* the only exit (for tracing and debugging) */
-	return page;
 }
 
 static struct z_erofs_decompressqueue *jobqueue_init(struct super_block *sb,
@@ -1596,7 +1593,7 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static void z_erofs_decompressqueue_endio(struct bio *bio)
+static void z_erofs_submissionqueue_endio(struct bio *bio)
 {
 	struct z_erofs_decompressqueue *q = bio->bi_private;
 	blk_status_t err = bio->bi_status;
@@ -1608,7 +1605,6 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
 
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
-
 		if (erofs_page_is_managed(EROFS_SB(q->sb), page)) {
 			if (!err)
 				SetPageUptodate(page);
@@ -1631,17 +1627,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	z_erofs_next_pcluster_t owned_head = f->owned_head;
 	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
-	pgoff_t last_index;
+	erofs_off_t last_pa;
 	struct block_device *last_bdev;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
 	unsigned long pflags;
 	int memstall = 0;
 
-	/*
-	 * if managed cache is enabled, bypass jobqueue is needed,
-	 * no need to read from device for all pclusters in this queue.
-	 */
+	/* No need to read from device for pclusters in the bypass queue. */
 	q[JQ_BYPASS] = jobqueue_init(sb, fgq + JQ_BYPASS, NULL);
 	q[JQ_SUBMIT] = jobqueue_init(sb, fgq + JQ_SUBMIT, force_fg);
 
@@ -1654,7 +1647,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	do {
 		struct erofs_map_dev mdev;
 		struct z_erofs_pcluster *pcl;
-		pgoff_t cur, end;
+		erofs_off_t cur, end;
+		struct bio_vec bvec;
 		unsigned int i = 0;
 		bool bypass = true;
 
@@ -1673,18 +1667,14 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		};
 		(void)erofs_map_dev(sb, &mdev);
 
-		cur = erofs_blknr(sb, mdev.m_pa);
-		end = cur + pcl->pclusterpages;
-
+		cur = mdev.m_pa;
+		end = cur + pcl->pclusterpages << PAGE_SHIFT;
 		do {
-			struct page *page;
-
-			page = pickup_page_for_submission(pcl, i++,
-					&f->pagepool, mc);
-			if (!page)
+			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
+			if (!bvec.bv_page)
 				continue;
 
-			if (bio && (cur != last_index + 1 ||
+			if (bio && (cur != last_pa ||
 				    last_bdev != mdev.m_bdev)) {
 submit_bio_retry:
 				submit_bio(bio);
@@ -1695,7 +1685,8 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
-			if (unlikely(PageWorkingset(page)) && !memstall) {
+			if (unlikely(PageWorkingset(bvec.bv_page)) &&
+			    !memstall) {
 				psi_memstall_enter(&pflags);
 				memstall = 1;
 			}
@@ -1703,23 +1694,24 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			if (!bio) {
 				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
 						REQ_OP_READ, GFP_NOIO);
-				bio->bi_end_io = z_erofs_decompressqueue_endio;
-
-				last_bdev = mdev.m_bdev;
-				bio->bi_iter.bi_sector = (sector_t)cur <<
-					(sb->s_blocksize_bits - 9);
+				bio->bi_end_io = z_erofs_submissionqueue_endio;
+				bio->bi_iter.bi_sector = cur >> 9;
 				bio->bi_private = q[JQ_SUBMIT];
 				if (readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
+				last_bdev = mdev.m_bdev;
 			}
 
-			if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE)
+			if (cur + bvec.bv_len > end)
+				bvec.bv_len = end - cur;
+			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
+					  bvec.bv_offset))
 				goto submit_bio_retry;
 
-			last_index = cur;
+			last_pa = cur + bvec.bv_len;
 			bypass = false;
-		} while (++cur < end);
+		} while ((cur += bvec.bv_len) < end);
 
 		if (!bypass)
 			qtail[JQ_SUBMIT] = &pcl->next;
-- 
2.39.3

