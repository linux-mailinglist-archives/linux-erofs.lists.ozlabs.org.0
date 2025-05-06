Return-Path: <linux-erofs+bounces-278-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5121AAC12E
	for <lists+linux-erofs@lfdr.de>; Tue,  6 May 2025 12:19:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsDrn2BsVz2y06;
	Tue,  6 May 2025 20:19:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746526745;
	cv=none; b=Vj+tDPW+4rsjfgG0GJAEoeGJcDoNgAeUnHJFx2SjUG5A+4oBk2Vt+LQzJsQFX0++Hhdtx1zawDR7Mer9J0tWtQ73PZ1VhF3S7TCLZ4NgaRz1luXV6VSKUBJEnxDiJVw5WIjwaAwBl7Jq9JSKN2SvbmZbp+sTLxcgDa5RxwgBgF/lJtMO8q4+y806AtE2mBb0YulmGqkI7KmssxzW48e5BBr9h46tUu/5zXy1EYGiXhPHSIpgF/PKFBMyn90zlYLM8fmnCb+8vZII40DyFQD+/lCCgpvLd2tr/JVPFhZkeZMk+ZWBYDc984Vp68zc4Xx0EHAGUijQnikBv2PFchmLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746526745; c=relaxed/relaxed;
	bh=6hlGv60zt643L8hENoGWYQs5XN30zIHiFR6c1sWi65I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOaI83270PWJ7rUn0VLB0TSgBVJU141UmnC6QRWCVd/O0jbywdPY+zM5KVC38J05XnkkHkNXvvrYfw2lrFD1n9FsjfF9WzzvKZjvI3qRnsn6c76wX2ef24FxYixbDDpqgRbiU5Oup18M5QqRS9KQx7G23oHSil9AJ1f65GX/f8b0uJE82S9zXEFsMru+z2UMzLULzCv+miq/rxIqv9bqTgTJ+MLYZxBIQyh0Pu1Usm29tNP2sZAVHy3cINkNUK3cF51otMrJuM+awLhbNWArGhPjx0ixNNAzqYZDT6qPDMtjrxu0jJwjCVlSHWrfmjksJ7m+5kC14hLlHbeaSHCzTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NWAO8PhA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NWAO8PhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsDrl1bnPz2xVq
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 May 2025 20:19:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746526737; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6hlGv60zt643L8hENoGWYQs5XN30zIHiFR6c1sWi65I=;
	b=NWAO8PhA4eUiay0Ymp9lxFBmwZ23v/9p8aiB4vimfB0sBCACZAm79mNCSEPWajV0k8iWJMhKLr4fBF/ijsqXpyRMb7WLgQPx8rF+i/dyLpuLgDiW80pWJQb2uAyxdcRmMF0SQ0IxSk2p3CTbWMA7osr2s/kDan9w+Y1BhZTi684=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WZSt-3o_1746526730 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 May 2025 18:18:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: ensure the extra temporary copy is valid for shortened bvecs
Date: Tue,  6 May 2025 18:18:50 +0800
Message-ID: <20250506101850.191506-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

When compressed data deduplication is enabled, multiple logical extents
may reference the same compressed physical cluster.

The previous commit 94c43de73521 ("erofs: fix wrong primary bvec
selection on deduplicated extents") already avoids using shortened
bvecs.  However, in such cases, the extra temporary buffers also
need to be preserved for later use in z_erofs_fill_other_copies() to
to prevent data corruption.

IOWs, extra temporary buffers have to be retained not only due to
varying start relative offsets (`pageofs_out`, as indicated by
`pcl->multibases`) but also because of shortened bvecs.

android.hardware.graphics.composer@2.1.so : 270696 bytes
   0:        0..  204185 |  204185 :  628019200.. 628084736 |   65536
-> 1:   204185..  225536 |   21351 :  544063488.. 544129024 |   65536
   2:   225536..  270696 |   45160 :          0..         0 |       0

com.android.vndk.v28.apex : 93814897 bytes
...
   364: 53869896..54095257 |  225361 :  543997952.. 544063488 |   65536
-> 365: 54095257..54309344 |  214087 :  544063488.. 544129024 |   65536
   366: 54309344..54514557 |  205213 :  544129024.. 544194560 |   65536
...

Both 204185 and 54095257 have the same start relative offset of 3481,
but the logical page 55 of `android.hardware.graphics.composer@2.1.so`
ranges from 225280 to 229632, forming a shortened bvec [225280, 225536)
that cannot be used for decompressing the range from 54095257 to
54309344 of `com.android.vndk.v28.apex`.

Since `pcl->multibases` is already meaningless, just mark `keepxcpy`
on demand for simplicity.

Again, this issue can only lead to data corruption if `-Ededupe` is on.

Fixes: 94c43de73521 ("erofs: fix wrong primary bvec selection on deduplicated extents")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5c061aaeeb45..b8e6b76c23d5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -79,9 +79,6 @@ struct z_erofs_pcluster {
 	/* L: whether partial decompression or not */
 	bool partial;
 
-	/* L: indicate several pageofs_outs or not */
-	bool multibases;
-
 	/* L: whether extra buffer allocations are best-effort */
 	bool besteffort;
 
@@ -1046,8 +1043,6 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 				break;
 
 			erofs_onlinefolio_split(folio);
-			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
-				f->pcl->multibases = true;
 			if (f->pcl->length < offset + end - map->m_la) {
 				f->pcl->length = offset + end - map->m_la;
 				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
@@ -1093,7 +1088,6 @@ struct z_erofs_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
 	struct z_erofs_pcluster *pcl;
-
 	/* pages with the longest decompressed length for deduplication */
 	struct page **decompressed_pages;
 	/* pages to keep the compressed data */
@@ -1102,6 +1096,8 @@ struct z_erofs_backend {
 	struct list_head decompressed_secondary_bvecs;
 	struct page **pagepool;
 	unsigned int onstack_used, nr_pages;
+	/* indicate if temporary copies should be preserved for later use */
+	bool keepxcpy;
 };
 
 struct z_erofs_bvec_item {
@@ -1112,18 +1108,20 @@ struct z_erofs_bvec_item {
 static void z_erofs_do_decompressed_bvec(struct z_erofs_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
+	int poff = bvec->offset + be->pcl->pageofs_out;
 	struct z_erofs_bvec_item *item;
-	unsigned int pgnr;
-
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
-	    (bvec->end == PAGE_SIZE ||
-	     bvec->offset + bvec->end == be->pcl->length)) {
-		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pgnr >= be->nr_pages);
-		if (!be->decompressed_pages[pgnr]) {
-			be->decompressed_pages[pgnr] = bvec->page;
+	struct page **page;
+
+	if (!(poff & ~PAGE_MASK) && (bvec->end == PAGE_SIZE ||
+			bvec->offset + bvec->end == be->pcl->length)) {
+		DBG_BUGON((poff >> PAGE_SHIFT) >= be->nr_pages);
+		page = be->decompressed_pages + (poff >> PAGE_SHIFT);
+		if (!*page) {
+			*page = bvec->page;
 			return;
 		}
+	} else {
+		be->keepxcpy = true;
 	}
 
 	/* (cold path) one pcluster is requested multiple times */
@@ -1289,7 +1287,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
-					.fillgaps = pcl->multibases,
+					.fillgaps = be->keepxcpy,
 					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
@@ -1346,7 +1344,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 
 	pcl->length = 0;
 	pcl->partial = true;
-	pcl->multibases = false;
 	pcl->besteffort = false;
 	pcl->bvset.nextpage = NULL;
 	pcl->vcnt = 0;
-- 
2.43.5


