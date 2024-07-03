Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA0925F7F
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 14:01:23 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uWAivGpt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDdfS5DF4z2xPc
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 22:01:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uWAivGpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDdf85WYwz3cYB
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 22:01:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720008058; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Mh46ks6775Y0MdbnW5K/y+3bA++N8lJEpXTZKZh0gJI=;
	b=uWAivGpt51/BdKGt+RRPl1jtX9T3dqosJvCsNox3f3kcrAknlecMul4dh1umk2wGEz1a8gL5N90CKdSt1HoooGr7DNtfiDyKhuBxpHpVwUjrVdCnuaRGg+4a43gU8vR1DM42kfCMZRss+AZShW99JHaxsDD83dR4wT67IMSv3+Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9mSOKS_1720008052;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9mSOKS_1720008052)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 20:00:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs: convert z_erofs_pcluster_readmore() to folios
Date: Wed,  3 Jul 2024 20:00:48 +0800
Message-ID: <20240703120051.3653452-1-hsiangkao@linux.alibaba.com>
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

Unlike `pagecache_get_page()`, `__filemap_get_folio()` returns error
pointers instead of NULL, thus switching to `IS_ERR_OR_NULL`.

Apart from that, it's just a straightforward conversion.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 14 +++++---------
 fs/erofs/zdata.c    | 15 +++++++--------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0c1b44ac9524..9a72fcbc0b30 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -312,17 +312,13 @@ static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 	return (ifmt >> EROFS_I_DATALAYOUT_BIT) & EROFS_I_DATALAYOUT_MASK;
 }
 
-/*
- * Different from grab_cache_page_nowait(), reclaiming is never triggered
- * when allocating new pages.
- */
-static inline
-struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
-					  pgoff_t index)
+/* reclaiming is never triggered when allocating new folios. */
+static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
+						    pgoff_t index)
 {
-	return pagecache_get_page(mapping, index,
+	return __filemap_get_folio(as, index,
 			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
-			readahead_gfp_mask(mapping) & ~__GFP_RECLAIM);
+			readahead_gfp_mask(as) & ~__GFP_RECLAIM);
 }
 
 /* Has a disk mapping */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d6fe002a4a71..14cf96fcefe4 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1767,7 +1767,6 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 		end = round_up(end, PAGE_SIZE);
 	} else {
 		end = round_up(map->m_la, PAGE_SIZE);
-
 		if (!map->m_llen)
 			return;
 	}
@@ -1775,15 +1774,15 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	cur = map->m_la + map->m_llen - 1;
 	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
-		struct page *page;
+		struct folio *folio;
 
-		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
-		if (page) {
-			if (PageUptodate(page))
-				unlock_page(page);
+		folio = erofs_grab_folio_nowait(inode->i_mapping, index);
+		if (!IS_ERR_OR_NULL(folio)) {
+			if (folio_test_uptodate(folio))
+				folio_unlock(folio);
 			else
-				z_erofs_scan_folio(f, page_folio(page), !!rac);
-			put_page(page);
+				z_erofs_scan_folio(f, folio, !!rac);
+			folio_put(folio);
 		}
 
 		if (cur < PAGE_SIZE)
-- 
2.43.5

