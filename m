Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42396D270
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 10:47:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WztKh5gSgz2ytT
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 18:47:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725526070;
	cv=none; b=B+4e8sS/AtI9okev5g/YtcVvlh8tedu4yjKwItkXqyT0zKBx92zLovy5eLm072c2zjoW27/pdSqU1de+XfBxECWkTA5ViHn7xwVPfrUBNsBJIwPN7gywXDxBobOLJSQvCGLcTQ0a9xbEOiMN5YQ/FIFoOpwl6bvlpL3X8j3Yn1jdljR01UHVsC/V7FkhiAlqC5uEQaqQy1H6fl5mmEVeEabqmQtY7SPIqgeoIrJ49MWH3tX0xLRgzto7N2q37WlH6T89ntuEvPCH3mqo2QIMkpaYGI0VdXbj0gFihsIBstGSzj6h6LRqc1Dpi+uvzvP+L5Iccdh4TTmSVjGDFOz3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725526070; c=relaxed/relaxed;
	bh=KBcIhc8Q7kIsMJt6qdxk6IoQjq0pkuleDwCZgpWG3ek=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=hdwhmkzOnIqTTfoDA/LjZXBGjRpt+tWJ039PvcLbz2iSvZuOgUWjBW/ZwoGVtdw8uV7JrsSWH4+aGEW5VbGIqOKwVJH9GGQj2MPoKO18tbOKuL7reThZIR73IzzsR9mw27TijBL4AgJQLXkgYqFUNEWzgyTy++2QGqb1phWRWxUZHR51ucmRAndi4xsdxgTDEEAo2kkMNDJ9SKevgW1+5p8A2tWLYsp7s1ivn0+m09bijgxZXLvTfiNeAwzSISVqZ+2EoXA5dSi/r2x4tZatPZyzOAWuGEQtLHYyUstcvVIy0BNJu2D69yMQrzWawLjEDbmPdFMLaYhWAomWn5oNrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wFKPNrUb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wFKPNrUb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WztKc3kdJz2yRZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 18:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725526062; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KBcIhc8Q7kIsMJt6qdxk6IoQjq0pkuleDwCZgpWG3ek=;
	b=wFKPNrUb3DQzDYs9e6tJ2w/V0+qM8JATf3kCGA8BMmzQfjQDh1e5IgyD1qdpUV6/0bUPLWe1fVXT3Qgmcy8Jk79ZYXp79BsJaeRi+FmkHpmCVdDSVF/73yxm2Q09vD0DQHb8/Gt2yHXYMm+A0Inh/M9gPsySWRohUCzEF7/zCQ8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEKumsr_1725526053)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 16:47:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: sunset unneeded NOFAILs
Date: Thu,  5 Sep 2024 16:47:32 +0800
Message-ID: <20240905084732.2684515-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

With iterative development, our codebase can now deal with compressed
buffer misses properly if both in-place I/O and compressed buffer
allocation fail.

Note that if readahead fails (with non-uptodate folios), the original
request will then fall back to synchronous read, and `.read_folio()`
should return appropriate errnos; otherwise -EIO will be passed to
user space, which is unexpected.

To simplify rarely encountered failure paths, a mimic decompression
will be just used.  Before that, failure reasons are recorded in
compressed_bvecs[] and they also act as placeholders to avoid in-place
pages.  They will be parsed just before decompression and then pass
back to `.read_folio()`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 57 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 785ae6ca77b1..ad0b59b3d23e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1154,9 +1154,10 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
 
-		/* compressed data ought to be valid before decompressing */
-		if (!page) {
-			err = -EIO;
+		/* compressed data ought to be valid when decompressing */
+		if (IS_ERR(page) || !page) {
+			bvec->page = NULL;	/* clear the failure reason */
+			err = page ? PTR_ERR(page) : -EIO;
 			continue;
 		}
 		be->compressed_pages[i] = page;
@@ -1232,8 +1233,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
-					.gfp = pcl->besteffort ?
-						GFP_KERNEL | __GFP_NOFAIL :
+					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 
@@ -1297,8 +1297,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	return err;
 }
 
-static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
-				     struct page **pagepool)
+static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
+				    struct page **pagepool)
 {
 	struct z_erofs_decompress_backend be = {
 		.sb = io->sb,
@@ -1307,6 +1307,7 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 			LIST_HEAD_INIT(be.decompressed_secondary_bvecs),
 	};
 	z_erofs_next_pcluster_t owned = io->head;
+	int err = io->eio ? -EIO : 0;
 
 	while (owned != Z_EROFS_PCLUSTER_TAIL) {
 		DBG_BUGON(owned == Z_EROFS_PCLUSTER_NIL);
@@ -1314,12 +1315,13 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		be.pcl = container_of(owned, struct z_erofs_pcluster, next);
 		owned = READ_ONCE(be.pcl->next);
 
-		z_erofs_decompress_pcluster(&be, io->eio ? -EIO : 0);
+		err = z_erofs_decompress_pcluster(&be, err) ?: err;
 		if (z_erofs_is_inline_pcluster(be.pcl))
 			z_erofs_free_pcluster(be.pcl);
 		else
 			erofs_workgroup_put(&be.pcl->obj);
 	}
+	return err;
 }
 
 static void z_erofs_decompressqueue_work(struct work_struct *work)
@@ -1462,17 +1464,21 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	page = erofs_allocpage(&f->pagepool, gfp);
 	spin_lock(&pcl->obj.lockref.lock);
 	if (unlikely(pcl->compressed_bvecs[nr].page != zbv.page)) {
-		erofs_pagepool_add(&f->pagepool, page);
+		if (page)
+			erofs_pagepool_add(&f->pagepool, page);
 		spin_unlock(&pcl->obj.lockref.lock);
 		cond_resched();
 		goto repeat;
 	}
-	bvec->bv_page = pcl->compressed_bvecs[nr].page = page;
-	folio = page_folio(page);
+	pcl->compressed_bvecs[nr].page = page ? page : ERR_PTR(-ENOMEM);
 	spin_unlock(&pcl->obj.lockref.lock);
+	bvec->bv_page = page;
+	if (!page)
+		return;
+	folio = page_folio(page);
 out_tocache:
 	if (!tocache || bs != PAGE_SIZE ||
 	    filemap_add_folio(mc, folio, pcl->obj.index + nr, gfp)) {
@@ -1695,26 +1701,28 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], nr_bios);
 }
 
-static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
-			     bool force_fg, bool ra)
+static int z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
+			    unsigned int ra_folios)
 {
 	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
+	struct erofs_sb_info *sbi = EROFS_I_SB(f->inode);
+	bool force_fg = z_erofs_is_sync_decompress(sbi, ra_folios);
+	int err;
 
 	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
-		return;
-	z_erofs_submit_queue(f, io, &force_fg, ra);
+		return 0;
+	z_erofs_submit_queue(f, io, &force_fg, !!ra_folios);
 
 	/* handle bypass queue (no i/o pclusters) immediately */
-	z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
-
+	err = z_erofs_decompress_queue(&io[JQ_BYPASS], &f->pagepool);
 	if (!force_fg)
-		return;
+		return err;
 
 	/* wait until all bios are completed */
 	wait_for_completion_io(&io[JQ_SUBMIT].u.done);
 
 	/* handle synchronous decompress queue in the caller context */
-	z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool);
+	return z_erofs_decompress_queue(&io[JQ_SUBMIT], &f->pagepool) ?: err;
 }
 
 /*
@@ -1776,7 +1784,6 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *const inode = folio->mapping->host;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	int err;
 
@@ -1788,9 +1795,8 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	z_erofs_pcluster_readmore(&f, NULL, false);
 	z_erofs_pcluster_end(&f);
 
-	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
-
+	/* if some pclusters are ready, need submit them anyway */
+	err = z_erofs_runqueue(&f, 0) ?: err;
 	if (err && err != -EINTR)
 		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
 			  err, folio->index, EROFS_I(inode)->nid);
@@ -1803,7 +1809,6 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct folio *head = NULL, *folio;
 	unsigned int nr_folios;
@@ -1833,7 +1838,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	z_erofs_pcluster_readmore(&f, rac, false);
 	z_erofs_pcluster_end(&f);
 
-	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, nr_folios), true);
+	(void)z_erofs_runqueue(&f, nr_folios);
 	erofs_put_metabuf(&f.map.buf);
 	erofs_release_pages(&f.pagepool);
 }
-- 
2.43.5

