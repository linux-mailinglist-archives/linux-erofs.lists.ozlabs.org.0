Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A44527D0
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 03:42:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HtVhf1Ystz2xtc
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Nov 2021 13:42:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HtVhZ0m2gz2xDC
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Nov 2021 13:42:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uwnk90a_1637030514; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uwnk90a_1637030514) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 16 Nov 2021 10:42:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 4.19.y 2/2] erofs: fix unsafe pagevec reuse of hooked pclusters
Date: Tue, 16 Nov 2021 10:41:53 +0800
Message-Id: <20211116024153.245131-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211116024153.245131-1-hsiangkao@linux.alibaba.com>
References: <1636983460149191@kroah.com>
 <20211116024153.245131-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 86432a6dca9bed79111990851df5756d3eb5f57c upstream.

There are pclusters in runtime marked with Z_EROFS_PCLUSTER_TAIL
before actual I/O submission. Thus, the decompression chain can be
extended if the following pcluster chain hooks such tail pcluster.

As the related comment mentioned, if some page is made of a hooked
pcluster and another followed pcluster, it can be reused for in-place
I/O (since I/O should be submitted anyway):
 _______________________________________________________________
|  tail (partial) page |          head (partial) page           |
|_____PRIMARY_HOOKED___|____________PRIMARY_FOLLOWED____________|

However, it's by no means safe to reuse as pagevec since if such
PRIMARY_HOOKED pclusters finally move into bypass chain without I/O
submission. It's somewhat hard to reproduce with LZ4 and I just found
it (general protection fault) by ro_fsstressing a LZMA image for long
time.

I'm going to actively clean up related code together with multi-page
folio adaption in the next few months. Let's address it directly for
easier backporting for now.

Call trace for reference:
  z_erofs_decompress_pcluster+0x10a/0x8a0 [erofs]
  z_erofs_decompress_queue.isra.36+0x3c/0x60 [erofs]
  z_erofs_runqueue+0x5f3/0x840 [erofs]
  z_erofs_readahead+0x1e8/0x320 [erofs]
  read_pages+0x91/0x270
  page_cache_ra_unbounded+0x18b/0x240
  filemap_get_pages+0x10a/0x5f0
  filemap_read+0xa9/0x330
  new_sync_read+0x11b/0x1a0
  vfs_read+0xf1/0x190

Link: https://lore.kernel.org/r/20211103182006.4040-1-xiang@kernel.org
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 drivers/staging/erofs/unzip_pagevec.h | 13 ++++++++++---
 drivers/staging/erofs/unzip_vle.c     | 17 +++++++++--------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/erofs/unzip_pagevec.h
index 64724dd1e04e..efbf541e11bb 100644
--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -117,11 +117,18 @@ static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
 static inline bool
 z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
 			     struct page *page,
-			     enum z_erofs_page_type type)
+			     enum z_erofs_page_type type,
+			     bool pvec_safereuse)
 {
-	if (unlikely(ctor->next == NULL && type))
-		if (ctor->index + 1 == ctor->nr)
+	if (!ctor->next) {
+		/* some pages cannot be reused as pvec safely without I/O */
+		if (type == Z_EROFS_PAGE_TYPE_EXCLUSIVE && !pvec_safereuse)
+			type = Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED;
+
+		if (type != Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
+		    ctor->index + 1 == ctor->nr)
 			return false;
+	}
 
 	if (unlikely(ctor->index >= ctor->nr))
 		z_erofs_pagevec_ctor_pagedown(ctor, false);
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 48c21a4d5dc8..83e4d9384bd2 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -228,10 +228,10 @@ static inline bool try_to_reuse_as_compressed_page(
 }
 
 /* callers must be with work->lock held */
-static int z_erofs_vle_work_add_page(
-	struct z_erofs_vle_work_builder *builder,
-	struct page *page,
-	enum z_erofs_page_type type)
+static int z_erofs_vle_work_add_page(struct z_erofs_vle_work_builder *builder,
+				     struct page *page,
+				     enum z_erofs_page_type type,
+				     bool pvec_safereuse)
 {
 	int ret;
 
@@ -241,9 +241,9 @@ static int z_erofs_vle_work_add_page(
 		try_to_reuse_as_compressed_page(builder, page))
 		return 0;
 
-	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector, page, type);
+	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector, page, type,
+					   pvec_safereuse);
 	builder->work->vcnt += (unsigned)ret;
-
 	return ret ? 0 : -EAGAIN;
 }
 
@@ -688,14 +688,15 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 		tight &= builder_is_followed(builder);
 
 retry:
-	err = z_erofs_vle_work_add_page(builder, page, page_type);
+	err = z_erofs_vle_work_add_page(builder, page, page_type,
+					builder_is_followed(builder));
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
 			__stagingpage_alloc(page_pool, GFP_NOFS);
 
 		err = z_erofs_vle_work_add_page(builder,
-			newpage, Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+			newpage, Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
 		if (likely(!err))
 			goto retry;
 	}
-- 
2.24.4

