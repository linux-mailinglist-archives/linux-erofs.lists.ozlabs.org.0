Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4AB57649E
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:42:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkwbt0Frtz3cjC
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jul 2022 01:42:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkwbd74rHz3cD7
	for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jul 2022 01:42:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJPnC8L_1657899746;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJPnC8L_1657899746)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 23:42:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 13/16] erofs: try to leave (de)compressed_pages on stack if possible
Date: Fri, 15 Jul 2022 23:42:00 +0800
Message-Id: <20220715154203.48093-14-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
References: <20220715154203.48093-1-hsiangkao@linux.alibaba.com>
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

For the most cases, small pclusters can be decompressed with page
arrays on stack.

Try to leave both (de)compressed_pages on stack if possible as before.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 1cf377ed1452..d93ba0adcf9e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -858,6 +858,7 @@ struct z_erofs_decompress_backend {
 	struct page **compressed_pages;
 
 	struct page **pagepool;
+	unsigned int onstack_used;
 };
 
 static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
@@ -904,14 +905,9 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	struct page **compressed_pages;
 	int i, err = 0;
 
-	/* XXX: will have a better approach in the following commits */
-	compressed_pages = kmalloc_array(pclusterpages, sizeof(struct page *),
-					 GFP_KERNEL | __GFP_NOFAIL);
 	*overlapped = false;
-
 	for (i = 0; i < pclusterpages; ++i) {
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
@@ -922,7 +918,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 			DBG_BUGON(1);
 			continue;
 		}
-		compressed_pages[i] = page;
+		be->compressed_pages[i] = page;
 
 		if (z_erofs_is_inline_pcluster(pcl)) {
 			if (!PageUptodate(page))
@@ -953,11 +949,8 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 		}
 	}
 
-	if (err) {
-		kfree(compressed_pages);
+	if (err)
 		return err;
-	}
-	be->compressed_pages = compressed_pages;
 	return 0;
 }
 
@@ -976,15 +969,28 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	mutex_lock(&pcl->lock);
 	nr_pages = pcl->nr_pages;
 
+	/* allocate (de)compressed page arrays if cannot be kept on stack */
+	be->decompressed_pages = NULL;
+	be->compressed_pages = NULL;
+	be->onstack_used = 0;
 	if (nr_pages <= Z_EROFS_ONSTACK_PAGES) {
 		be->decompressed_pages = be->onstack_pages;
+		be->onstack_used = nr_pages;
 		memset(be->decompressed_pages, 0,
 		       sizeof(struct page *) * nr_pages);
-	} else {
+	}
+
+	if (pclusterpages + be->onstack_used <= Z_EROFS_ONSTACK_PAGES)
+		be->compressed_pages = be->onstack_pages + be->onstack_used;
+
+	if (!be->decompressed_pages)
 		be->decompressed_pages =
 			kvcalloc(nr_pages, sizeof(struct page *),
 				 GFP_KERNEL | __GFP_NOFAIL);
-	}
+	if (!be->compressed_pages)
+		be->compressed_pages =
+			kvcalloc(pclusterpages, sizeof(struct page *),
+				 GFP_KERNEL | __GFP_NOFAIL);
 
 	err2 = z_erofs_parse_out_bvecs(be);
 	if (err2)
@@ -1041,7 +1047,9 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
 	}
-	kfree(be->compressed_pages);
+	if (be->compressed_pages < be->onstack_pages ||
+	    be->compressed_pages >= be->onstack_pages + Z_EROFS_ONSTACK_PAGES)
+		kvfree(be->compressed_pages);
 
 	for (i = 0; i < nr_pages; ++i) {
 		page = be->decompressed_pages[i];
-- 
2.24.4

