Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660D77F21B
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 10:28:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRJ7N1VV8z3bx0
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Aug 2023 18:28:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRJ740LB8z2ytV
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Aug 2023 18:28:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vpz9R1O_1692260905;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vpz9R1O_1692260905)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 16:28:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/8] erofs: drop z_erofs_page_mark_eio()
Date: Thu, 17 Aug 2023 16:28:10 +0800
Message-Id: <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
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

It can be folded into z_erofs_onlinepage_endio() to simplify the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a200e99f7d4f..4009283944ca 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -143,22 +143,17 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static inline void z_erofs_page_mark_eio(struct page *page)
+static void z_erofs_onlinepage_endio(struct page *page, int err)
 {
-	int orig;
+	int orig, v;
+
+	DBG_BUGON(!PagePrivate(page));
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-	} while (atomic_cmpxchg((atomic_t *)&page->private, orig,
-				orig | Z_EROFS_PAGE_EIO) != orig);
-}
-
-static inline void z_erofs_onlinepage_endio(struct page *page)
-{
-	unsigned int v;
+		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	DBG_BUGON(!PagePrivate(page));
-	v = atomic_dec_return((atomic_t *)&page->private);
 	if (!(v & ~Z_EROFS_PAGE_EIO)) {
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
@@ -1066,9 +1061,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	if (err)
-		z_erofs_page_mark_eio(page);
-	z_erofs_onlinepage_endio(page);
+	z_erofs_onlinepage_endio(page, err);
 	return err;
 }
 
@@ -1171,9 +1164,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		if (err)
-			z_erofs_page_mark_eio(bvi->bvec.page);
-		z_erofs_onlinepage_endio(bvi->bvec.page);
+		z_erofs_onlinepage_endio(bvi->bvec.page, err);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1344,9 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		if (err)
-			z_erofs_page_mark_eio(page);
-		z_erofs_onlinepage_endio(page);
+		z_erofs_onlinepage_endio(page, err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.24.4

