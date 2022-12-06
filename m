Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEF643CF9
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 07:04:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NR8xk2clzz3bWq
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Dec 2022 17:04:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uEVXx1qS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uEVXx1qS;
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NR8xg17wTz2xGH
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Dec 2022 17:04:07 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id BF467CE168E;
	Tue,  6 Dec 2022 06:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A2FC433C1;
	Tue,  6 Dec 2022 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670306640;
	bh=a2DXxzn2tCMHvMeAX4+C+K/btZTLZZOQGTh6c8Fnjn0=;
	h=From:To:Cc:Subject:Date:From;
	b=uEVXx1qSx6SIB5uOnJZGJ71z0f97sOlkVleCJS5JphJVp6nSU77fnzTFVUGe8IYHn
	 7svbYWpi6P3MnX1Glr3LTC5+xhfr3S348ZcpCtlQPOU9YAn43Ygo64jB6whsfyyjni
	 H6/0Mf3b/A2UeOrDYhqyjAIlYaWh6y72Hs3z/fkDN33/6Ndrac3DT68MVSInHM19+M
	 wAFrE67i2S05y04kbqZxPURgbvPo+DjNAibW2ymkTyfnoE78m/QiMs0765nMDChEGq
	 aBW2jefgTZDVCeQYog/Ayx/nk9WAeuAsI1IFbmix68HGFwxtZPFmcwWFG4BIHj3Or7
	 P8px9rwoXv5nA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: clean up cached I/O strategies
Date: Tue,  6 Dec 2022 14:03:52 +0800
Message-Id: <20221206060352.152830-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

After commit 4c7e42552b3a ("erofs: remove useless cache strategy of
DELAYEDALLOC"), only one cached I/O allocation strategy is supported:

  When cached I/O is preferred, page allocation is applied without
  direct reclaim.  If allocation fails, fall back to inplace I/O.

Let's get rid of z_erofs_cache_alloctype.  No logical changes.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - fold in Yue Hu's fix:
   https://lore.kernel.org/r/20221206053633.4251-1-zbestahu@gmail.com

 fs/erofs/zdata.c | 77 +++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b792d424d774..b66c16473273 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -175,16 +175,6 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
 	DBG_BUGON(1);
 }
 
-/* how to allocate cached pages for a pcluster */
-enum z_erofs_cache_alloctype {
-	DONTALLOC,	/* don't allocate any cached pages */
-	/*
-	 * try to use cached I/O if page allocation succeeds or fallback
-	 * to in-place I/O instead to avoid any direct reclaim.
-	 */
-	TRYALLOC,
-};
-
 /*
  * tagged pointer with 1-bit tag for all compressed pages
  * tag 0 - the page is just found with an extra page reference
@@ -292,12 +282,29 @@ struct z_erofs_decompress_frontend {
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
 	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
 
+static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
+{
+	unsigned int cachestrategy = EROFS_I_SB(fe->inode)->opt.cache_strategy;
+
+	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
+		return false;
+
+	if (fe->backmost)
+		return true;
+
+	if (cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
+	    fe->map.m_la < fe->headoffset)
+		return true;
+
+	return false;
+}
+
 static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
-			       enum z_erofs_cache_alloctype type,
 			       struct page **pagepool)
 {
 	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
 	struct z_erofs_pcluster *pcl = fe->pcl;
+	bool shouldalloc = z_erofs_should_alloc_cache(fe);
 	bool standalone = true;
 	/*
 	 * optimistic allocation without direct reclaim since inplace I/O
@@ -326,18 +333,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
 		} else {
 			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			switch (type) {
-			case TRYALLOC:
-				newpage = erofs_allocpage(pagepool, gfp);
-				if (!newpage)
-					continue;
-				set_page_private(newpage,
-						 Z_EROFS_PREALLOCATED_PAGE);
-				t = tag_compressed_page_justfound(newpage);
-				break;
-			default:        /* DONTALLOC */
+			if (!shouldalloc)
 				continue;
-			}
+
+			/*
+			 * try to use cached I/O if page allocation
+			 * succeeds or fallback to in-place I/O instead
+			 * to avoid any direct reclaim.
+			 */
+			newpage = erofs_allocpage(pagepool, gfp);
+			if (!newpage)
+				continue;
+			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
+			t = tag_compressed_page_justfound(newpage);
 		}
 
 		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
@@ -637,20 +645,6 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
 	return true;
 }
 
-static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
-				       unsigned int cachestrategy,
-				       erofs_off_t la)
-{
-	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
-		return false;
-
-	if (fe->backmost)
-		return true;
-
-	return cachestrategy >= EROFS_ZIP_CACHE_READAROUND &&
-		la < fe->headoffset;
-}
-
 static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
 				 struct page *page, unsigned int pageofs,
 				 unsigned int len)
@@ -687,12 +681,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 				struct page *page, struct page **pagepool)
 {
 	struct inode *const inode = fe->inode;
-	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
 	bool tight = true, exclusive;
-
-	enum z_erofs_cache_alloctype cache_strategy;
 	unsigned int cur, end, spiltted;
 	int err = 0;
 
@@ -746,13 +737,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	} else {
 		/* bind cache first when cached decompression is preferred */
-		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
-					       map->m_la))
-			cache_strategy = TRYALLOC;
-		else
-			cache_strategy = DONTALLOC;
-
-		z_erofs_bind_cache(fe, cache_strategy, pagepool);
+		z_erofs_bind_cache(fe, pagepool);
 	}
 hitted:
 	/*
-- 
2.30.2

