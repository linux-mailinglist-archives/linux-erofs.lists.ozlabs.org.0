Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F39875DE55
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2019 08:57:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dsPT1wz5zDqMK
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2019 16:57:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dsJ03wB3zDq9k
 for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2019 16:53:04 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3264EADFA2A7DDD59756;
 Wed,  3 Jul 2019 14:53:00 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 14:52:54 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH RESEND] staging: erofs: fix LZ4 limited bounced page mis-reuse
Date: Wed, 3 Jul 2019 14:52:09 +0800
Message-ID: <20190703065209.81580-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Like all lz77-based algrithms, lz4 has a dynamically populated
("sliding window") dictionary and the maximum lookback distance
is 65535. Therefore the number of bounced pages could be limited
by erofs based on this property.

However, just now we observed some lz4 sequences in the extreme
case cannot be decompressed correctly after this feature is enabled,
the root causes after analysis are clear as follows:
1) max bounced pages should be 17 rather than 16 pages;
2) considering the following case, the broken implementation
   could reuse unsafely in advance (in other words, reuse it
   less than a safe distance),
   0 1 2 ... 16 17 18 ... 33 34
   b             p  b         b
   note that the bounce page that we are concerned was allocated
   at 0, and it reused at 18 since page 17 exists, but it mis-reused
   at 34 in advance again, which causes decompress failure.

This patch resolves the issue by introducing a bitmap to mark
whether the page in the same position of last round is a bounced
page or not, and a micro stack data structure to store all
available bounced pages.

Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
No change since I observed that using j will break the logic.
Note that "bit set in the bitmap means whether the page in the same position
           of last round is a bounced page or not".

 drivers/staging/erofs/decompressor.c | 50 ++++++++++++++++------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index 80f1f39719ba..1fb0abb98dff 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -13,7 +13,7 @@
 #define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
 #endif
 
-#define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
+#define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
 #ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
 #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
 #endif
@@ -35,19 +35,28 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	const unsigned int nr =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
-	unsigned long unused[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
-					  BITS_PER_LONG)] = { 0 };
+	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
+					   BITS_PER_LONG)] = { 0 };
 	void *kaddr = NULL;
-	unsigned int i, j, k;
+	unsigned int i, j, top;
 
-	for (i = 0; i < nr; ++i) {
+	top = 0;
+	for (i = j = 0; i < nr; ++i, ++j) {
 		struct page *const page = rq->out[i];
+		struct page *victim;
 
-		j = i & (LZ4_MAX_DISTANCE_PAGES - 1);
-		if (availables[j])
-			__set_bit(j, unused);
+		if (j >= LZ4_MAX_DISTANCE_PAGES)
+			j = 0;
+
+		/* 'valid' bounced can only be tested after a complete round */
+		if (test_bit(j, bounced)) {
+			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
+			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
+			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
+		}
 
 		if (page) {
+			__clear_bit(j, bounced);
 			if (kaddr) {
 				if (kaddr + PAGE_SIZE == page_address(page))
 					kaddr += PAGE_SIZE;
@@ -59,27 +68,24 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			continue;
 		}
 		kaddr = NULL;
+		__set_bit(j, bounced);
 
-		k = find_first_bit(unused, LZ4_MAX_DISTANCE_PAGES);
-		if (k < LZ4_MAX_DISTANCE_PAGES) {
-			j = k;
-			get_page(availables[j]);
+		if (top) {
+			victim = availables[--top];
+			get_page(victim);
 		} else {
-			DBG_BUGON(availables[j]);
-
 			if (!list_empty(pagepool)) {
-				availables[j] = lru_to_page(pagepool);
-				list_del(&availables[j]->lru);
-				DBG_BUGON(page_ref_count(availables[j]) != 1);
+				victim = lru_to_page(pagepool);
+				list_del(&victim->lru);
+				DBG_BUGON(page_ref_count(victim) != 1);
 			} else {
-				availables[j] = alloc_pages(GFP_KERNEL, 0);
-				if (!availables[j])
+				victim = alloc_pages(GFP_KERNEL, 0);
+				if (!victim)
 					return -ENOMEM;
 			}
-			availables[j]->mapping = Z_EROFS_MAPPING_STAGING;
+			victim->mapping = Z_EROFS_MAPPING_STAGING;
 		}
-		rq->out[i] = availables[j];
-		__clear_bit(j, unused);
+		rq->out[i] = victim;
 	}
 	return kaddr ? 1 : 0;
 }
-- 
2.17.1

