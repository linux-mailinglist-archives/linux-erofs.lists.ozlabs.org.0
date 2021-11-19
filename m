Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE54570B9
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 15:34:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwfMB5PjZz30RS
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Nov 2021 01:34:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FztTCBwC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=FztTCBwC; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwfM728bTz2xr8
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 01:34:43 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03166615E2;
 Fri, 19 Nov 2021 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1637332481;
 bh=NIYM2gxCHsAlIRUsO5XiiOvbWO+Y8f79DAHzx/UZtfY=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=FztTCBwC9bJjAYPWrsZX1+JpNUWhSbtfHpZXDI0MisVivh1hlLd3PLedL58MiIwmS
 Kib6MlOa/kHHCXssC2kt8n9WbBqKe6XwxUpbawEBl6uzRAVNxGDzRQRUIPcElx/cgP
 bGPYZkgYNvBnqzl1hCq3hvE0NrbrrorRRmWqL6nM=
Subject: Patch "erofs: fix unsafe pagevec reuse of hooked pclusters" has been
 added to the 5.4-stable tree
To: chao@kernel.org, gregkh@linuxfoundation.org, hsiangkao@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Nov 2021 15:34:39 +0100
In-Reply-To: <20211116011035.124503-2-hsiangkao@linux.alibaba.com>
Message-ID: <1637332479187230@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    erofs: fix unsafe pagevec reuse of hooked pclusters

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Nov 19 03:25:57 PM CET 2021
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 16 Nov 2021 09:10:35 +0800
Subject: erofs: fix unsafe pagevec reuse of hooked pclusters
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>
Message-ID: <20211116011035.124503-2-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |   13 +++++++------
 fs/erofs/zpvec.h |   13 ++++++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -288,8 +288,8 @@ static inline bool z_erofs_try_inplace_i
 
 /* callers must be with collection lock held */
 static int z_erofs_attach_page(struct z_erofs_collector *clt,
-			       struct page *page,
-			       enum z_erofs_page_type type)
+			       struct page *page, enum z_erofs_page_type type,
+			       bool pvec_safereuse)
 {
 	int ret;
 
@@ -299,9 +299,9 @@ static int z_erofs_attach_page(struct z_
 	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
-	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
+	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type,
+				      pvec_safereuse);
 	clt->cl->vcnt += (unsigned int)ret;
-
 	return ret ? 0 : -EAGAIN;
 }
 
@@ -652,14 +652,15 @@ hitted:
 		tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
 
 retry:
-	err = z_erofs_attach_page(clt, page, page_type);
+	err = z_erofs_attach_page(clt, page, page_type,
+				  clt->mode >= COLLECT_PRIMARY_FOLLOWED);
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
 			__stagingpage_alloc(pagepool, GFP_NOFS);
 
 		err = z_erofs_attach_page(clt, newpage,
-					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
+					  Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
 		if (!err)
 			goto retry;
 	}
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -107,11 +107,18 @@ static inline void z_erofs_pagevec_ctor_
 
 static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 					   struct page *page,
-					   enum z_erofs_page_type type)
+					   enum z_erofs_page_type type,
+					   bool pvec_safereuse)
 {
-	if (!ctor->next && type)
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
 
 	if (ctor->index >= ctor->nr)
 		z_erofs_pagevec_ctor_pagedown(ctor, false);


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-5.4/erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
queue-5.4/erofs-remove-the-occupied-parameter-from-z_erofs_pagevec_enqueue.patch
