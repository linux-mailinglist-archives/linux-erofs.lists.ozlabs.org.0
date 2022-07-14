Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058D574EFE
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 15:21:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkFWh6tnlz3cDF
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 23:21:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkFW90vmlz3c6n
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:23 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPLG_1657804870;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPLG_1657804870)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 09/16] erofs: get rid of `enum z_erofs_page_type'
Date: Thu, 14 Jul 2022 21:20:44 +0800
Message-Id: <20220714132051.46012-10-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
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

Remove it since pagevec[] is no longer used.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9065e160d6a6..cdfb2706e4ae 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -27,17 +27,6 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
 	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
 };
 
-/* page type in pagevec for decompress subsystem */
-enum z_erofs_page_type {
-	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
-	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
-
-	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
-
-	Z_EROFS_VLE_PAGE_TYPE_HEAD,
-	Z_EROFS_VLE_PAGE_TYPE_MAX
-};
-
 struct z_erofs_bvec_iter {
 	struct page *bvpage;
 	struct z_erofs_bvset *bvset;
@@ -429,7 +418,6 @@ int erofs_try_to_free_cached_page(struct page *page)
 	return ret;
 }
 
-/* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
 static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 				   struct z_erofs_bvec *bvec)
 {
@@ -447,13 +435,11 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
 
 /* callers must be with pcluster lock held */
 static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
-			       struct z_erofs_bvec *bvec,
-			       enum z_erofs_page_type type)
+			       struct z_erofs_bvec *bvec, bool exclusive)
 {
 	int ret;
 
-	if (fe->mode >= COLLECT_PRIMARY &&
-	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
+	if (fe->mode >= COLLECT_PRIMARY && exclusive) {
 		/* give priority for inplaceio to use file pages first */
 		if (z_erofs_try_inplace_io(fe, bvec))
 			return 0;
@@ -718,10 +704,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct erofs_map_blocks *const map = &fe->map;
 	const loff_t offset = page_offset(page);
-	bool tight = true;
+	bool tight = true, exclusive;
 
 	enum z_erofs_cache_alloctype cache_strategy;
-	enum z_erofs_page_type page_type;
 	unsigned int cur, end, spiltted, index;
 	int err = 0;
 
@@ -798,12 +783,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto next_part;
 	}
 
-	/* let's derive page type */
-	page_type = cur ? Z_EROFS_VLE_PAGE_TYPE_HEAD :
-		(!spiltted ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
-			(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
-				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
-
+	exclusive = (!cur && (!spiltted || tight));
 	if (cur)
 		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
 
@@ -812,7 +792,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 					.page = page,
 					.offset = offset - map->m_la,
 					.end = end,
-				  }), page_type);
+				  }), exclusive);
 	/* should allocate an additional short-lived page for bvset */
 	if (err == -EAGAIN && !fe->candidate_bvpage) {
 		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
-- 
2.24.4

