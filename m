Return-Path: <linux-erofs+bounces-697-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F79B0D63A
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 11:45:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXRz4Rk8z2yb9;
	Tue, 22 Jul 2025 19:45:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753177503;
	cv=none; b=S0vzlPz5t/4pq21VuDrex7QlqpD8lZOvrxyVHyxyMFqemAFFpYJXPmhgEsWlpW+sLBB20xVeS2M7z181lDAArbJkqZuwKsqjb3VR5Z9yZXXyH5MocDsAByJMZrRgiORQg08hv0Bgz4OLjcteN3+cj6ZZA0pfCxR5C0nwWt63osbk5AJLUYR7TzxiNVzlKcQgOv42l1Wxyx8H7Nmu6OaZB1cnNDok4FHiKWk9vCI79Jis6WLB3y+SW5hslMXH7+cXygKXTTCd4wyL0A6cRE1xVddpx0O+veVTfAoXHzKqfCkQznQBHy6+3lafDtNMBBra6jVXu7531rUvzQ4Rno9JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753177503; c=relaxed/relaxed;
	bh=1cXlaQuqCs1uV+qE0zIs8uhrxULjZFWlQ9DRk2BEc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfpelCsGyGh7ZGL00JftYWXgRVrCt2rVoHQvo3xytkfrks0rtULdnGcI5wyDzB233MaOeHRa4rYAUeI4R7TabeOeWEczRTtrkLYWZYi1oEuINFAvpYsQmU1odyPqi4byqRBouLx66Cd5QbVoD6f5e1QwNjORgdFkHFeKxa1b8xOhFuNlKsKfFMDj09YmKceUYskqFcN0OiKcAjHkaHQ0Chy1rmz5qwc9WsnzIt7+cKYjxg2chNGAZdxiLik7bSr39Y3R0R6F6UjW2lYsUC2lzxgqYppLAuavWDCiCbuqL/tasvuILwVG2/nXv4m1ShhNlUG+ihw/2y/uqgA5dTxuDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=byqSxL+D; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=byqSxL+D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXRx4JCsz2yF0
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 19:44:59 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753177495; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1cXlaQuqCs1uV+qE0zIs8uhrxULjZFWlQ9DRk2BEc2k=;
	b=byqSxL+DaYIQoh/sCGrwk2vHWobYSiuUMLzIkQykAPAJ0wO/9KEAmTNRAv315eNb4x2hhfnSAb6dPTi5tXMbWs3Va+sR1xg0MBDEmxVOoz4E5IP85v/dnCfpktjsM5Cb2sJz7OVDHoxZMFQkaNr/Uqwu1dGK/SfrYR5cRsMul8s=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVoKhE_1753177490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 17:44:54 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.6.y] erofs: address D-cache aliasing
Date: Tue, 22 Jul 2025 17:44:49 +0800
Message-ID: <20250722094449.2950654-1-hsiangkao@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

commit 27917e8194f91dffd8b4825350c63cb68e98ce58 upstream.

Flush the D-cache before unlocking folios for compressed inodes, as
they are dirtied during decompression.

Avoid calling flush_dcache_folio() on every CPU write, since it's more
like playing whack-a-mole without real benefit.

It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
for new page cache folios.  However, certain ARM boards are affected,
as reported.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Link: https://lore.kernel.org/r/20250709034614.2780117-2-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Jan & Stefan,
Please help confirm this 6.6 fix backport if possible.

Thanks,
Gao Xiang

 fs/erofs/decompressor.c |  6 ++----
 fs/erofs/zdata.c        | 32 +++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index aa59788a61e6..86e088fd386e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -342,14 +342,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
-		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
+		if (rq->out[outpages - 1] != rq->in[inpages - 1])
 			memcpy_to_page(rq->out[outpages - 1], 0, src +
 					(interlaced_offset ? 0 : righthalf),
 				       lefthalf);
-		} else if (!interlaced_offset) {
+		else if (!interlaced_offset)
 			memmove(src, src + righthalf, lefthalf);
-			flush_dcache_page(rq->in[inpages - 1]);
-		}
 	}
 	kunmap_local(src);
 	return 0;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 496e4c7c52a4..d852b43ac43e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -122,9 +122,11 @@ static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
 
 /*
  * bit 30: I/O error occurred on this page
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
  * bit 0 - 29: remaining parts to complete this page
  */
-#define Z_EROFS_PAGE_EIO			(1 << 30)
+#define Z_EROFS_ONLINEPAGE_EIO		30
+#define Z_EROFS_ONLINEPAGE_DIRTY	29
 
 static inline void z_erofs_onlinepage_init(struct page *page)
 {
@@ -143,7 +145,7 @@ static inline void z_erofs_onlinepage_split(struct page *page)
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static void z_erofs_onlinepage_endio(struct page *page, int err)
+static void z_erofs_onlinepage_end(struct page *page, int err, bool dirty)
 {
 	int orig, v;
 
@@ -151,16 +153,20 @@ static void z_erofs_onlinepage_endio(struct page *page, int err)
 
 	do {
 		orig = atomic_read((atomic_t *)&page->private);
-		v = (orig - 1) | (err ? Z_EROFS_PAGE_EIO : 0);
+		DBG_BUGON(orig <= 0);
+		v = dirty << Z_EROFS_ONLINEPAGE_DIRTY;
+		v |= (orig - 1) | (!!err << Z_EROFS_ONLINEPAGE_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&page->private, orig, v) != orig);
 
-	if (!(v & ~Z_EROFS_PAGE_EIO)) {
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		if (!(v & Z_EROFS_PAGE_EIO))
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
+	if (v & (BIT(Z_EROFS_ONLINEPAGE_DIRTY) - 1))
+		return;
+	set_page_private(page, 0);
+	ClearPagePrivate(page);
+	if (v & BIT(Z_EROFS_ONLINEPAGE_DIRTY))
+		flush_dcache_page(page);
+	if (!(v & BIT(Z_EROFS_ONLINEPAGE_EIO)))
+		SetPageUptodate(page);
+	unlock_page(page);
 }
 
 #define Z_EROFS_ONSTACK_PAGES		32
@@ -1060,7 +1066,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 		goto repeat;
 
 out:
-	z_erofs_onlinepage_endio(page, err);
+	z_erofs_onlinepage_end(page, err, false);
 	return err;
 }
 
@@ -1163,7 +1169,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinepage_endio(bvi->bvec.page, err);
+		z_erofs_onlinepage_end(bvi->bvec.page, err, true);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1333,7 +1339,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		z_erofs_onlinepage_endio(page, err);
+		z_erofs_onlinepage_end(page, err, true);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)
-- 
2.43.5


