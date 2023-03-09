Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A666B1AC8
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 06:32:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXHqp3lVjz3cK6
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 16:32:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXHqh3TZ1z3bgn
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 16:31:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VdS7uEN_1678339908;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdS7uEN_1678339908)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 13:31:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: Revert "erofs: fix kvcalloc() misuse with __GFP_NOFAIL"
Date: Thu,  9 Mar 2023 13:31:47 +0800
Message-Id: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Let's revert commit 12724ba38992 ("erofs: fix kvcalloc() misuse with
__GFP_NOFAIL") since kvmalloc() already supports __GFP_NOFAIL in commit
a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc").  So
the original fix was wrong.

Actually there was some issue as [1] discussed, so before that mm fix
is landed, the warn could still happen but applying this commit first
will cause less.

[1] https://lore.kernel.org/r/20230305053035.1911-1-hsiangkao@linux.alibaba.com
Fixes: 12724ba38992 ("erofs: fix kvcalloc() misuse with __GFP_NOFAIL")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3247d2422bea..f1708c77a991 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1312,12 +1312,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 	if (!be->decompressed_pages)
 		be->decompressed_pages =
-			kcalloc(be->nr_pages, sizeof(struct page *),
-				GFP_KERNEL | __GFP_NOFAIL);
+			kvcalloc(be->nr_pages, sizeof(struct page *),
+				 GFP_KERNEL | __GFP_NOFAIL);
 	if (!be->compressed_pages)
 		be->compressed_pages =
-			kcalloc(pclusterpages, sizeof(struct page *),
-				GFP_KERNEL | __GFP_NOFAIL);
+			kvcalloc(pclusterpages, sizeof(struct page *),
+				 GFP_KERNEL | __GFP_NOFAIL);
 
 	z_erofs_parse_out_bvecs(be);
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
@@ -1365,7 +1365,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	}
 	if (be->compressed_pages < be->onstack_pages ||
 	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
-		kfree(be->compressed_pages);
+		kvfree(be->compressed_pages);
 	z_erofs_fill_other_copies(be, err);
 
 	for (i = 0; i < be->nr_pages; ++i) {
@@ -1384,7 +1384,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-		kfree(be->decompressed_pages);
+		kvfree(be->decompressed_pages);
 
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.24.4

