Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EDC972A43
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 09:09:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2vvM50z0z2yhg
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 17:09:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725952142;
	cv=none; b=f1erUfijTS2a7AsptpJGTYOIH7D3bLlhR6lQz68ubGDgHlJmb3Oueil9OlMcx9y3u/zTPSgzzefva/Fc7trfUe8KKYopfAhyQaxWmI8Znc+dFAwTr7XSWjhUXISzdmoEGcdQt/Qy18sp8haZbHNu2L3yDvffLVoR/IXl171vEuFZkRw1/s9aBcXwIO+ix8DlDwaBnWBUGkI2jgIsiBeVOLBj+U/b59OBeo0Sr8akEHqL8YMe19A39PE6Sx2ogMOnRyP5O2y4r31d8bzcjIWIcGDkrbX4i1j2NnHrnzfqmuMG2XqcJf8O4dnx0PqclaFNK9DBiswHl9ZI/9d55at7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725952142; c=relaxed/relaxed;
	bh=E2CocgZnZvJRWS5izeSHjTwYb+PIF/HSTj1Q9lZ/QI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me16LKX8GQpRy6ueEj/W4vbI5jbYlgRtKrqJagGS6xdQ1LZCHhLFF5jlmWrNCRPonL3cojIzJkdRYIkGWJm7+v1+zk72FyGkAFR+lf702B2zw7RewidMtLywWOkaG15clklm2CJGXrU6PA2naqO65ALMXjn4bnjNq4zIp1ySKPGHt+aHDbfPbdU9stEiFBI5fc4NWrT+RkPFfEveC2Bmks4R1UTVzPX0PbiJG8NncXuUjYUhQRrwhUYVIrVkrQVV8Ym9verGJJ5429w0sM6hWl/MCAusOPMelJW8uMjcKQfFr24V1r+KWMeLvUVuQETyTJ2GTlzVqOZ3du+LxJnfBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CMIhGqpN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CMIhGqpN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2vvJ3s10z2yS0
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 17:08:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725952134; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=E2CocgZnZvJRWS5izeSHjTwYb+PIF/HSTj1Q9lZ/QI0=;
	b=CMIhGqpNxQIMrYbwK7lZeCgg+zKDHTcMI6W19AsbWl7JUIOXQWCYuUTcOIn/z0DuOrg8V0JAzt+br3a+/lZdDbjw9XRGfcrQcNHYClOWt6Ti2gIoWezZASY8EJkaRLUEsQ2EQ93l1BeeZpdoTsAJEc3PhO7qqLSkzyKYTieWQiY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEjLqPD_1725952127)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 15:08:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: handle overlapped pclusters out of crafted images properly
Date: Tue, 10 Sep 2024 15:08:47 +0800
Message-ID: <20240910070847.3356592-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904111334.995920-1-hsiangkao@linux.alibaba.com>
References: <20240904111334.995920-1-hsiangkao@linux.alibaba.com>
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
Cc: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com, LKML <linux-kernel@vger.kernel.org>, syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
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
Reported-by: syzbot+de04e06b28cfecf2281c@syzkaller.appspotmail.com
Reported-by: syzbot+c8c8238b394be4a1087d@syzkaller.appspotmail.com
Tested-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000002fda01061e334873@google.com
Fixes: 8e6c8fa9f2e9 ("erofs: enable big pcluster feature")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - Avoid re-entering z_erofs_fill_bio_vec() if bio_add_page() fails;

 fs/erofs/zdata.c | 71 ++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2271cb74ae3a..dca11ab0ab75 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1392,6 +1392,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	struct z_erofs_bvec zbv;
 	struct address_space *mapping;
 	struct folio *folio;
+	struct page *page;
 	int bs = i_blocksize(f->inode);
 
 	/* Except for inplace folios, the entire folio can be used for I/Os */
@@ -1414,7 +1415,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	 * file-backed folios will be used instead.
 	 */
 	if (folio->private == (void *)Z_EROFS_PREALLOCATED_PAGE) {
-		folio->private = 0;
 		tocache = true;
 		goto out_tocache;
 	}
@@ -1432,7 +1432,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	}
 
 	folio_lock(folio);
-	if (folio->mapping == mc) {
+	if (likely(folio->mapping == mc)) {
 		/*
 		 * The cached folio is still in managed cache but without
 		 * a valid `->private` pcluster hint.  Let's reconnect them.
@@ -1442,41 +1442,44 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
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
@@ -1611,13 +1614,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 		cur = mdev.m_pa;
 		end = cur + pcl->pclustersize;
 		do {
-			z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
-			if (!bvec.bv_page)
-				continue;
-
+			bvec.bv_page = NULL;
 			if (bio && (cur != last_pa ||
 				    bio->bi_bdev != mdev.m_bdev)) {
-io_retry:
+drain_io:
 				if (erofs_is_fileio_mode(EROFS_SB(sb)))
 					erofs_fileio_submit_bio(bio);
 				else if (erofs_is_fscache_mode(sb))
@@ -1632,6 +1632,15 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				bio = NULL;
 			}
 
+			if (!bvec.bv_page) {
+				z_erofs_fill_bio_vec(&bvec, f, pcl, i++, mc);
+				if (!bvec.bv_page)
+					continue;
+				if (cur + bvec.bv_len > end)
+					bvec.bv_len = end - cur;
+				DBG_BUGON(bvec.bv_len < sb->s_blocksize);
+			}
+
 			if (unlikely(PageWorkingset(bvec.bv_page)) &&
 			    !memstall) {
 				psi_memstall_enter(&pflags);
@@ -1654,13 +1663,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 				++nr_bios;
 			}
 
-			if (cur + bvec.bv_len > end)
-				bvec.bv_len = end - cur;
-			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
 			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
 					  bvec.bv_offset))
-				goto io_retry;
-
+				goto drain_io;
 			last_pa = cur + bvec.bv_len;
 			bypass = false;
 		} while ((cur += bvec.bv_len) < end);
-- 
2.43.5

