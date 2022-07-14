Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56658574EF9
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 15:21:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkFWZ1j09z3cgN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Jul 2022 23:21:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkFWM55XNz3c7K
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Jul 2022 23:21:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPQf_1657804878;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPQf_1657804878)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 14/16] erofs: introduce z_erofs_do_decompressed_bvec()
Date: Thu, 14 Jul 2022 21:20:49 +0800
Message-Id: <20220714132051.46012-15-hsiangkao@linux.alibaba.com>
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

Both out_bvecs and in_bvecs share the common logic for decompressed
buffers. So let's make a helper for this.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 49 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4093d8a4ce93..391755dafecd 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -861,6 +861,26 @@ struct z_erofs_decompress_backend {
 	unsigned int onstack_used;
 };
 
+static int z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
+					struct z_erofs_bvec *bvec)
+{
+	unsigned int pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
+	struct page *oldpage;
+
+	DBG_BUGON(pgnr >= be->pcl->nr_pages);
+	oldpage = be->decompressed_pages[pgnr];
+	be->decompressed_pages[pgnr] = bvec->page;
+
+	/* error out if one pcluster is refenenced multiple times. */
+	if (oldpage) {
+		DBG_BUGON(1);
+		z_erofs_page_mark_eio(oldpage);
+		z_erofs_onlinepage_endio(oldpage);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
+
 static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 {
 	struct z_erofs_pcluster *pcl = be->pcl;
@@ -871,27 +891,14 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_decompress_backend *be)
 	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
 		struct z_erofs_bvec bvec;
-		unsigned int pgnr;
 
 		z_erofs_bvec_dequeue(&biter, &bvec, &old_bvpage);
 
 		if (old_bvpage)
 			z_erofs_put_shortlivedpage(be->pagepool, old_bvpage);
 
-		pgnr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pgnr >= pcl->nr_pages);
 		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
-		/*
-		 * currently EROFS doesn't support multiref(dedup),
-		 * so here erroring out one multiref page.
-		 */
-		if (be->decompressed_pages[pgnr]) {
-			DBG_BUGON(1);
-			z_erofs_page_mark_eio(be->decompressed_pages[pgnr]);
-			z_erofs_onlinepage_endio(be->decompressed_pages[pgnr]);
-			err = -EFSCORRUPTED;
-		}
-		be->decompressed_pages[pgnr] = bvec.page;
+		err = z_erofs_do_decompressed_bvec(be, &bvec);
 	}
 
 	old_bvpage = z_erofs_bvec_iter_end(&biter);
@@ -911,7 +918,6 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 	for (i = 0; i < pclusterpages; ++i) {
 		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
 		struct page *page = bvec->page;
-		unsigned int pgnr;
 
 		/* compressed pages ought to be present before decompressing */
 		if (!page) {
@@ -933,18 +939,7 @@ static int z_erofs_parse_in_bvecs(struct z_erofs_decompress_backend *be,
 					err = -EIO;
 				continue;
 			}
-
-			pgnr = (bvec->offset + pcl->pageofs_out) >> PAGE_SHIFT;
-			DBG_BUGON(pgnr >= pcl->nr_pages);
-			if (be->decompressed_pages[pgnr]) {
-				DBG_BUGON(1);
-				z_erofs_page_mark_eio(
-						be->decompressed_pages[pgnr]);
-				z_erofs_onlinepage_endio(
-						be->decompressed_pages[pgnr]);
-				err = -EFSCORRUPTED;
-			}
-			be->decompressed_pages[pgnr] = page;
+			err = z_erofs_do_decompressed_bvec(be, bvec);
 			*overlapped = true;
 		}
 	}
-- 
2.24.4

