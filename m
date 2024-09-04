Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D806F96B9DC
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 13:14:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzKcx46mCz2yhZ
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2024 21:14:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725448446;
	cv=none; b=SMG3/BKihGSXfwqiEmbkE/dyZSoccKbPota97xSHeL3vnoMnPnjxznoFVvvdPmrCF/LQsDyOUQnnYoobR5avYY1TP59JlBRQjXYe0Z2PH1wpKdGIVmEuqCBeGRgiRyUsQZBHndTiyGnnXcGYZfrP9EES/OfNyM+uoOYPxNUVQfKObCEakA00ESORvYXidrERjGGQagan4S/TOQ+hdRisBV7GN7gJkIZC9cSKAyvb8a4pK4TzparEhBR0hmy5JNRDMeDs9x03Nm/WDmuHYrRBsZaFpRFvqzcuFmsQZWsjAJSoAcfY1eqZSE3FfcUrSSJ1bKS/XyDlN6DNxBJCPTwe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725448446; c=relaxed/relaxed;
	bh=1Wpx06Mx9JHuiExsk7qakCiyNk5ZorpNX57U9/Sy8hc=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=KDcPaxhlrWE7siS5BhdemtRuaQYivQzcLxaeaeUq2Ez3Kh5VQ1BUuhjJpOchwsir0RouVLk2ObV3VfanF/YzFXfpuLOpLdxV7QhfxA0LadgurU9N/1KX6XA3KdofSiITt4w/0Xr8QT0IsQ8GO2YML4l7ZlBzXrsVTzjhuQvp2LFVVVnhoixI5SMy52pUt6/UyZRleoVz9N8TckfHafwgaCHwyf0MquuNuFwllourZwXkz6TcDY81KfakwQoczAYQU0+MiirhG9CCv7bws9mH9Me2tz/y3//1hyJ8A9e2xYAp0jdB6cl8txZXO9XiuqotFSRT/iULbaY6wVc7KFnLZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pg2pfoxA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Pg2pfoxA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzKcs0Qc0z2yNJ
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2024 21:14:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725448437; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1Wpx06Mx9JHuiExsk7qakCiyNk5ZorpNX57U9/Sy8hc=;
	b=Pg2pfoxA5q5cXJFnhevrfw49qwCz5qg0fwe8jlKTCKmJrF6X2zUX4GBORoSX/Apzy0CJnqYqVEhtE56KkQvJu35bok4dwVc+1R9H4ZNeEJXnPItP4ti0M8BLVeOHCoQIJx/vtLQYpoT8j3BH99mLCYK2w3rc2V3fweCIMOG34M0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEHSWbl_1725448416)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 19:13:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: handle overlapped pclusters out of crafted images properly
Date: Wed,  4 Sep 2024 19:13:34 +0800
Message-ID: <20240904111334.995920-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

syzbot reported a task hang issue due to a deadlock case where it is
waiting for the folio lock of a cached folio that will be used for
cache I/Os.

After looking into the crafted fuzzed image, I found it's formed with
several overlapped big pclusters as below:

 Ext:   logical offset   |  length :     physical offset    |  length
   0:        0..   16384 |   16384 :     151552..    167936 |   16384
   1:    16384..   32768 |   16384 :     155648..    172032 |   16384
   2:    32768..   49152 |   16384 :  537223168.. 537239552 |   16384
...

Here, extent 0/1 are physically overlapped although it's entirely
_impossible_ for normal filesystem images generated by mkfs.

First, managed folios containing compressed data will be marked as
up-to-date and then unlocked immediately (unlike in-place folios) when
compressed I/Os are complete.  If physical blocks are not submitted in
the incremental order, there should be separate BIOs to avoid dependency
issues.  However, the current code mis-arranges z_erofs_fill_bio_vec()
and BIO submission which causes unexpected BIO waits.

Second, managed folios will be connected to their own pclusters for
efficient inter-queries.  However, this is somewhat hard to implement
easily if overlapped big pclusters exist.  Again, these only appear in
fuzzed images so let's simply fall back to temporary short-lived pages
for correctness.

Additionally, it justifies that referenced managed folios cannot be
truncated for now and reverts part of commit 2080ca1ed3e4 ("erofs: tidy
up `struct z_erofs_bvec`") for simplicity although it shouldn't be any
difference.

Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 56 +++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..382e2e4e60e5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1428,6 +1428,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
 	struct folio *folio;
+	struct page *page;
 	int bs = i_blocksize(f->inode);
 
 	/* Except for inplace folios, the entire folio can be used for I/Os */
@@ -1450,7 +1451,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * file-backed folios will be used instead.
 	 */
 	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
-		folio->private = 0;
 		tocache = true;
 		goto out_tocache;
 	}
@@ -1468,7 +1468,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	}
 
 	folio_lock(folio);
-	if (folio->mapping == mc) {
+	if (likely(folio->mapping == mc)) {
 		/*
 		 * The cached folio is still in managed cache but without
 		 * a valid `->private` pcluster hint.  Let's reconnect them.
@@ -1478,41 +1478,44 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 			/* compressed_bvecs[] already takes a ref before */
 			folio_put(folio);
 		}
-
-		/* no need to submit if it is already up-to-date */
-		if (folio_test_uptodate(folio)) {
-			folio_unlock(folio);
-			bvec->bv_page = NULL;
+		if (likely(folio->private == pcl))  {
+			/* don't submit cache I/Os again if already uptodate */
+			if (folio_test_uptodate(folio)) {
+				folio_unlock(folio);
+				bvec->bv_page = NULL;
+			}
+			return;
 		}
-		return;
+		/*
+		 * Already linked with another pcluster, which only appears in
+		 * crafted images by fuzzers for now.  But handle this anyway.
+		 */
+		tocache = false;	/* use temporary short-lived pages */
+	} else {
+		DBG_BUGON(1); /* referenced managed folios can't be truncated */
+		tocache = true;
 	}
-
-	/*
-	 * It has been truncated, so it's unsafe to reuse this one. Let's
-	 * allocate a new page for compressed data.
-	 */
-	DBG_BUGON(folio->mapping);
-	tocache = true;
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
-	if (pcl->compressed_bvecs[nr].page) {
-		erofs_pagepool_add(&f->pagepool, zbv.page);
+	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
+		erofs_pagepool_add(&f->pagepool, page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	bvec->bv_page = pcl->compressed_bvecs[nr].page = zbv.page;
-	folio = page_folio(zbv.page);
-	/* first mark it as a temporary shortlived folio (now 1 ref) */
-	folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
+	bvec->bv_page = pcl->compressed_bvecs[nr].page = page;
+	folio = page_folio(page);
 	spin_unlock(&pcl->obj.lockref.lock);
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
-	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp))
+	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
+		/* turn into a temporary shortlived folio (1 ref) */
+		folio->private = (void *)Z_EROFS_SHORTLIVED_PAGE;
 		return;
+	}
 	folio_attach_private(folio, pcl);
 	/* drop a refcount added by allocpage (then 2 refs in total here) */
 	folio_put(folio);
@@ -1647,10 +1650,6 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		cur = mdev.m_pa;
 		end = cur + pcl->pclustersize;
 		do {
-			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
-			if (!bvec.bv_page)
-				continue;
-
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
 io_retry:
@@ -1665,6 +1664,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				}
 				bio = NULL;
 			}
+			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
+			if (!bvec.bv_page)
+				continue;
 
 			if (unlikely(PageWorkingset(bvec.bv_page)) &&
 			    !memstall) {
-- 
2.43.5

