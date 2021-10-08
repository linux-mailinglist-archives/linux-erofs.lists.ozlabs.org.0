Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824A4271E0
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Oct 2021 22:09:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HQzmZ0ckjz30RN
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Oct 2021 07:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NmgXkcyV;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NmgXkcyV; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HQzmV1kf6z30MC
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Oct 2021 07:09:14 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCB9610E5;
 Fri,  8 Oct 2021 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633723752;
 bh=3EEz07j9Wg5laxUjMiCKDXqTS3+pALCR0ncatip9pvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NmgXkcyVKj/XiN7Xj6Gg45zhI81YxxBCRKtaiCFTpdIjeZE1g83D5AUdr8GqbtX0k
 yLFK6Yalwrfe3YRHaPbbXQztyVkWqA2OfTkhat3nSvyAmMA/RRK2nruBb9OHlPJKjD
 Qk2lEpPeUbsa1zWjfwqv6dp1DZuHRHiPa90+ZqIR5GSiB9uWQQgd2ITcte46e3L3II
 HcwgNQRsPZa/nPx9bVUJBHHobz5ZjU+wUjHP/z5KVVfsugxci/QlVkNxExCiIyeEph
 qsGcLZckzQIzT77R+5Crimx/D16EpN7/uRgh9V/eZnYyovgsHkrzyvHbcLj0zZoxfK
 fHdX3/23w9O6Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/3] erofs: introduce readmore decompression strategy
Date: Sat,  9 Oct 2021 04:08:39 +0800
Message-Id: <20211008200839.24541-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211008200839.24541-1-xiang@kernel.org>
References: <20211008200839.24541-1-xiang@kernel.org>
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Previously, the readahead window was strictly followed by EROFS
decompression strategy in order to minimize extra memory footprint.
However, it could become inefficient if just reading the partial
requested data for much big LZ4 pclusters and the upcoming LZMA
implementation.

Let's try to request the leading data in a pcluster without
triggering memory reclaiming instead for the LZ4 approach first
to boost up 100% randread of large big pclusters, and it has no real
impact on low memory scenarios.

It also introduces a way to expand read lengths in order to decompress
the whole pcluster, which is useful for LZMA since the algorithm
itself is relatively slow and causes CPU bound, but LZ4 is not.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 13 ++++++
 fs/erofs/zdata.c    | 99 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 48bfc6eb2b02..7f96265ccbdb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -307,6 +307,19 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 			      EROFS_I_DATALAYOUT_BITS);
 }
 
+/*
+ * Different from grab_cache_page_nowait(), reclaiming is never triggered
+ * when allocating new pages.
+ */
+static inline
+struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
+					  pgoff_t index)
+{
+	return pagecache_get_page(mapping, index,
+			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
+}
+
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5c34ef66677f..febb018e10a7 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1377,6 +1377,72 @@ static void z_erofs_runqueue(struct super_block *sb,
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
 }
 
+/*
+ * Since partial uptodate is still unimplemented for now, we have to use
+ * approximate readmore strategies as a start.
+ */
+static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
+				      struct readahead_control *rac,
+				      erofs_off_t end,
+				      struct list_head *pagepool,
+				      bool backmost)
+{
+	struct inode *inode = f->inode;
+	struct erofs_map_blocks *map = &f->map;
+	erofs_off_t cur;
+	int err;
+
+	if (backmost) {
+		map->m_la = end;
+		/* TODO: pass in EROFS_GET_BLOCKS_READMORE for LZMA later */
+		err = z_erofs_map_blocks_iter(inode, map, 0);
+		if (err)
+			return;
+
+		/* expend ra for the trailing edge if readahead */
+		if (rac) {
+			loff_t newstart = readahead_pos(rac);
+
+			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
+			readahead_expand(rac, newstart, cur - newstart);
+			return;
+		}
+		end = round_up(end, PAGE_SIZE);
+	} else {
+		end = round_up(map->m_la, PAGE_SIZE);
+
+		if (!map->m_llen)
+			return;
+	}
+
+	cur = map->m_la + map->m_llen - 1;
+	while (cur >= end) {
+		pgoff_t index = cur >> PAGE_SHIFT;
+		struct page *page;
+
+		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
+		if (!page)
+			goto skip;
+
+		if (PageUptodate(page)) {
+			unlock_page(page);
+			put_page(page);
+			goto skip;
+		}
+
+		err = z_erofs_do_read_page(f, page, pagepool);
+		if (err)
+			erofs_err(inode->i_sb,
+				  "readmore error at page %lu @ nid %llu",
+				  index, EROFS_I(inode)->nid);
+		put_page(page);
+skip:
+		if (cur < PAGE_SIZE)
+			break;
+		cur = (index << PAGE_SHIFT) - 1;
+	}
+}
+
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
@@ -1385,10 +1451,13 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	LIST_HEAD(pagepool);
 
 	trace_erofs_readpage(page, false);
-
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
+	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
+				  &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
+	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
@@ -1409,29 +1478,20 @@ static void z_erofs_readahead(struct readahead_control *rac)
 {
 	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
-
-	unsigned int nr_pages = readahead_count(rac);
-	bool sync = (sbi->ctx.readahead_sync_decompress &&
-			nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *page, *head = NULL;
+	unsigned int nr_pages;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
-
 	f.readahead = true;
 	f.headoffset = readahead_pos(rac);
 
-	while ((page = readahead_page(rac))) {
-		prefetchw(&page->flags);
-
-		/*
-		 * A pure asynchronous readahead is indicated if
-		 * a PG_readahead marked page is hitted at first.
-		 * Let's also do asynchronous decompression for this case.
-		 */
-		sync &= !(PageReadahead(page) && !head);
+	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
+				  readahead_length(rac) - 1, &pagepool, true);
+	nr_pages = readahead_count(rac);
+	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
+	while ((page = readahead_page(rac))) {
 		set_page_private(page, (unsigned long)head);
 		head = page;
 	}
@@ -1450,11 +1510,12 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-
+	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
 	(void)z_erofs_collector_end(&f.clt);
 
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, sync);
-
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 sbi->ctx.readahead_sync_decompress &&
+			 nr_pages <= sbi->ctx.max_sync_decompress_pages);
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 
-- 
2.20.1

