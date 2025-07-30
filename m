Return-Path: <linux-erofs+bounces-721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFBAB15AF7
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 10:55:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsQyy4wVyz30Vq;
	Wed, 30 Jul 2025 18:55:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753865722;
	cv=none; b=ZILAdqbzUHdOwrQeV+8EBiPkyAbg3KMkkUN+CKjnebduOdwDrjF/TKImhoML4560pcMSWluhXRSC0iwMgfAQTtkRM1sAloy0agtniYs4R5RS2S7Xz9wkwjj0uufasxNZvSbyY9L7E6ahfwIbquP8or0DBdWUgDSfNeRucBjhmT8ihaudt1wtRspaHWAFgCDH2/xdjs/feibH95QgASlsssOav9yAbDpRViGAPNk0+3cfrmElEhrHNIystTN+lsQCKSkst5s3vY2XKk7xjVDI4WaedNN3phBYrPPihn/UFLqIdzoocI9isIJU85KbuGbc+OjC8G+wcf1f7cAdzqxeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753865722; c=relaxed/relaxed;
	bh=zLvjfX1S/0NYpgfQLcJZXjZokklhTu7TKvkg+0KOyRk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=keV8uNKlEbPHo0+20EYxYYSYCj/83iZSItxA2JBfkMnbmjYykqcijnBDWTInKn5yxmZlKzsmgvGTK7bPZRwB1Hsjg1MfB7CL3Fu5YrdD+KCAfIUNlkrjgCnXTsdJzl5fLd9YJfVHxtFMTYLSwrMXRwmiYEOK0JTrHDEARh2Me2XvEjliAUpv8z0+IYYBxClqXMP6gUB7GB/xfSLXLfsKR4VJXO+Mm7EiameR0l93+HekyQNNWbwf1yJHWvXwwetv1a5zzt7D34Ch0wqTsW1lti8E6S5WXR3za/UaVyQvjhH7m0iA1vFp1dY20dHS0m6O13kBz2P/cJYe0xKKPAJm8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p+/20L1V; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=p+/20L1V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsQyx1Ly1z2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 18:55:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0838CA55186;
	Wed, 30 Jul 2025 08:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F599C4CEE7;
	Wed, 30 Jul 2025 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865717;
	bh=4jI+jVldqhtLInFLzElSM362IPLjXIV7jmIfJPg1qNI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=p+/20L1ViQ9E2+o+THi1DAIBHPrS9cJFZ/t5SNYFbcho53M1MO5MfPUW94eDo95r4
	 zPzUhi+WRf6HDOQ34Qz8c5kjW/DIgQajZn4SjUA4heDtGHKmnx80EutOgoB0LrqO72
	 WiHM9RK8jouahD/GxPZxK5cCpbtSrZ7zw+ve+ano=
Subject: Patch "erofs: address D-cache aliasing" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,jan.kiszka@siemens.com,linux-erofs@lists.ozlabs.org,s.kerkmann@pengutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 10:55:13 +0200
In-Reply-To: <20250722100029.3052177-6-hsiangkao@linux.alibaba.com>
Message-ID: <2025073013-tried-democrat-cb97@gregkh>
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
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    erofs: address D-cache aliasing

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-address-d-cache-aliasing.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Jul 22 12:00:48 2025
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 22 Jul 2025 18:00:29 +0800
Subject: erofs: address D-cache aliasing
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Message-ID: <20250722100029.3052177-6-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/decompressor.c |    6 ++----
 fs/erofs/zdata.c        |   32 +++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 17 deletions(-)

--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -342,14 +342,12 @@ static int z_erofs_transform_plain(struc
 
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
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -123,9 +123,11 @@ static inline unsigned int z_erofs_pclus
 
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
@@ -144,7 +146,7 @@ static inline void z_erofs_onlinepage_sp
 	atomic_inc((atomic_t *)&page->private);
 }
 
-static void z_erofs_onlinepage_endio(struct page *page, int err)
+static void z_erofs_onlinepage_end(struct page *page, int err, bool dirty)
 {
 	int orig, v;
 
@@ -152,16 +154,20 @@ static void z_erofs_onlinepage_endio(str
 
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
@@ -925,7 +931,7 @@ next_part:
 		goto repeat;
 
 out:
-	z_erofs_onlinepage_endio(page, err);
+	z_erofs_onlinepage_end(page, err, false);
 	return err;
 }
 
@@ -1028,7 +1034,7 @@ static void z_erofs_fill_other_copies(st
 			cur += len;
 		}
 		kunmap_local(dst);
-		z_erofs_onlinepage_endio(bvi->bvec.page, err);
+		z_erofs_onlinepage_end(bvi->bvec.page, err, true);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1196,7 +1202,7 @@ out:
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		z_erofs_onlinepage_endio(page, err);
+		z_erofs_onlinepage_end(page, err, true);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-sunset-erofs_dbg.patch
queue-6.1/erofs-simplify-z_erofs_transform_plain.patch
queue-6.1/erofs-get-rid-of-debug_one_dentry.patch
queue-6.1/erofs-drop-z_erofs_page_mark_eio.patch
queue-6.1/erofs-address-d-cache-aliasing.patch

