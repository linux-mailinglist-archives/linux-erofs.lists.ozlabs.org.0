Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14701444826
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Nov 2021 19:20:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hkw6y6XwFz2y0C
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 05:20:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ryP3DtXt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ryP3DtXt; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hkw6v5yc6z2xBf
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Nov 2021 05:20:23 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF3F61058;
 Wed,  3 Nov 2021 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635963621;
 bh=FFi00w/SCD/3fQFpsM7+rPKbDql1iCHDgUj+gyZBz6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ryP3DtXtXowf0J0FOPp8+cOTD4gihzfI3gzomyvNG4Ji0RnlY/rFbQJXodadnWiiD
 bZgNFCx0J8jlsUqsRZHr7tr4YbM2TQMoCVmGWg4RivKM2faAiQqRRDaP2kWewUzji/
 zMsY/CVq5GlaOenCZsas8kUB2vOUqObHUcxXtMfDcfqqDaS/Yes/GKVeRDiAEagzUe
 Ghg/spxriWY6lSMgjaUAiIyGmdTL//Gmqy8xnJuGZTtH2qJ2q+LowWfZhij3VlsMVa
 LmNINM7rmPktnhby1zYGvMquIODdyoNa5NPsSxnQdHe528fW1nzKFMHD7tUObqjogD
 ZtTNkLFGBg5Hg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] erofs: fix unsafe pagevec reuse of hooked pclusters
Date: Thu,  4 Nov 2021 02:20:06 +0800
Message-Id: <20211103182006.4040-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211103174953.3209-1-xiang@kernel.org>
References: <20211103174953.3209-1-xiang@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

There are pclusters in runtime marked with Z_EROFS_PCLUSTER_TAIL
before actual I/O submission. Thus, the decompression chain can be
extended if the following pcluster chain hooks such tail pcluster.

As the related comment mentioned, if some page is made of a hooked
pcluster and another followed pcluster, it can be reused for in-place
I/O (since I/O should be submitted anyway):
 _______________________________________________________________
|  tail (partial) page |          head (partial) page           |
|_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|

However, it's by no means safe to reuse as pagevec since if such
PRIMARY_HOOKED pclusters finally move into bypass chain without I/O
submission. It's somewhat hard to reproduce with LZ4 and I just found
it (general protection fault) by ro_fsstressing a LZMA image for long
time.

I'm going to actively clean up related code together with multi-page
folio adaption in the next few months. Let's address it directly for
easier backporting for now.

Call trace for reference:
  z_erofs_decompress_pcluster+0x10a/0x8a0 [erofs]
  z_erofs_decompress_queue.isra.36+0x3c/0x60 [erofs]
  z_erofs_runqueue+0x5f3/0x840 [erofs]
  z_erofs_readahead+0x1e8/0x320 [erofs]
  read_pages+0x91/0x270
  page_cache_ra_unbounded+0x18b/0x240
  filemap_get_pages+0x10a/0x5f0
  filemap_read+0xa9/0x330
  new_sync_read+0x11b/0x1a0
  vfs_read+0xf1/0x190

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
changes since v1:
 - fix typos in commit message.

 fs/erofs/zdata.c | 13 +++++++------
 fs/erofs/zpvec.h | 13 ++++++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 11c7a1aaebad..eb51df4a9f77 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -373,8 +373,8 @@ static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
 
 /* callers must be with collection lock held */
 static int z_erofs_attach_page(struct z_erofs_collector *clt,
-			       struct page *page,
-			       enum z_erofs_page_type type)
+			       struct page *page, enum z_erofs_page_type type,
+			       bool pvec_safereuse)
 {
 	int ret;
 
@@ -384,9 +384,9 @@ static int z_erofs_attach_page(struct z_erofs_collector *clt,
 	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
-	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
+	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type,
+				      pvec_safereuse);
 	clt->cl->vcnt += (unsigned int)ret;
-
 	return ret ? 0 : -EAGAIN;
 }
 
@@ -729,7 +729,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
 
 retry:
-	err = z_erofs_attach_page(clt, page, page_type);
+	err = z_erofs_attach_page(clt, page, page_type,
+				  clt->mode >= COLLECT_PRIMARY_FOLLOWED);
 	/* should allocate an additional short-lived page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
@@ -737,7 +738,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 
 		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
 		err = z_erofs_attach_page(clt, newpage,
-					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+					  Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
 		if (!err)
 			goto retry;
 	}
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
index dfd7fe0503bb..b05464f4a808 100644
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -106,11 +106,18 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
 
 static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 					   struct page *page,
-					   enum z_erofs_page_type type)
+					   enum z_erofs_page_type type,
+					   bool pvec_safereuse)
 {
-	if (!ctor->next && type)
-		if (ctor->index + 1 == ctor->nr)
+	if (!ctor->next) {
+		/* some pages cannot be reused as pvec safely without I/O */
+		if (type == Z_EROFS_PAGE_TYPE_EXCLUSIVE && !pvec_safereuse)
+			type = Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED;
+
+		if (type != Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
+		    ctor->index + 1 == ctor->nr)
 			return false;
+	}
 
 	if (ctor->index >= ctor->nr)
 		z_erofs_pagevec_ctor_pagedown(ctor, false);
-- 
2.20.1

