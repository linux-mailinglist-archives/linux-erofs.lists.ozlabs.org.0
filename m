Return-Path: <linux-erofs+bounces-722-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007AB15AF8
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 10:55:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsQz31Z0Wz30Vs;
	Wed, 30 Jul 2025 18:55:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753865727;
	cv=none; b=aJh3imKJ8mvOASF+vb/BGXgTdxZTd+yNQ1zVLVsgpIHqP6aDXtYZPs6GE4omyOvIdXFRJ71+uuBQyhmFy0CcMULY6yMpgrB9tTFWv+9UFVpkGQVgDMHbHdLQ4AYfbHyCi8++l0sY21l1bFnus/VsRgvR59E2PrVHr9rM3KbMMDrWXlanon+wazNkc/wmslOQc8+b3qClAVyLivEkozemzK7Sznn5+C+n2VBuHg7s52O68bDBOWNEtj1bJTtfkBALlFlBtX6LeMx0iOpZWcMoOBB0bHcrOMJyKuGyFSVpCk62xaD6QIHZ66XAgBB8RUk7YgJ5knbQZ9ShsyQbc60rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753865727; c=relaxed/relaxed;
	bh=WQ5u8CEf+cNbVTyJqdU9f63jP0YQsRj3RzRIbLkJTIY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=VLNaOHtpb99AOp/zWY+Tl7lovYWcnHy2kPflDeJvYHNgpPTbQe7AYs1BLU2RF3UmAD+KFXzOTx6EL3FvNuQ9+uTSo4UcbghdpDNS4AUrqh1fW0JVDdDt+rWybkPo9Z+h8Z5OOjz4EdvK4Xqpkkg8uVzNTd/l0HuwM+dOjdgri4UJuIqKX6Pq3oaGaWm9tmUb11l1UMbfzJKVjxJyZEveSFUI7sS9+oqAuySzuWLLNZwsvf5+AKdhA2JBg0ynno833BaG5nHokRPVW636PoTJBbubyzZLnMWcENxyPNlzpznUXRLVdwScrWWLWp9On5UixyzqUo1VxK9JOAz0Wux5Eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Sz7hVqMg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Sz7hVqMg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsQz23WMjz2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 18:55:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 52DE443B8E;
	Wed, 30 Jul 2025 08:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1727C4CEE7;
	Wed, 30 Jul 2025 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865724;
	bh=J1doeMuSeOf4KmB8xXFWtidISTrN/9rRSwEXK2rc9eE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Sz7hVqMg+wf6UzTE9MGl3RxzMbvNnwiF1A3qn+NckI1rynVk/mP0LPqgAkACMcxV9
	 lC2RvLCGGtUVusRwTMB8RQOrohjx0ccIqBEC+6OoyuLKr7jeARKHfv/blVg8NaupP3
	 5jlt+o/LTXeCqaFFB3yehD6TGLjALgLVFYkfZjVU=
Subject: Patch "erofs: drop z_erofs_page_mark_eio()" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jan.kiszka@siemens.com,linux-erofs@lists.ozlabs.org,s.kerkmann@pengutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 10:55:13 +0200
In-Reply-To: <20250722100029.3052177-4-hsiangkao@linux.alibaba.com>
Message-ID: <2025073013-repressed-magnetism-a49b@gregkh>
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
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    erofs: drop z_erofs_page_mark_eio()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-drop-z_erofs_page_mark_eio.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Jul 22 12:00:46 2025
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 22 Jul 2025 18:00:27 +0800
Subject: erofs: drop z_erofs_page_mark_eio()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Chao Yu <chao@kernel.org>
Message-ID: <20250722100029.3052177-4-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 9a05c6a8bc26138d34e87b39e6a815603bc2a66c upstream.

It can be folded into z_erofs_onlinepage_endio() to simplify the code.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230817082813.81180-5-hsiangkao@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |   29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -144,22 +144,17 @@ static inline void z_erofs_onlinepage_sp
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
@@ -930,9 +925,7 @@ next_part:
 		goto repeat;
 
 out:
-	if (err)
-		z_erofs_page_mark_eio(page);
-	z_erofs_onlinepage_endio(page);
+	z_erofs_onlinepage_endio(page, err);
 	return err;
 }
 
@@ -1035,9 +1028,7 @@ static void z_erofs_fill_other_copies(st
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
@@ -1205,9 +1196,7 @@ out:
 		/* recycle all individual short-lived pages */
 		if (z_erofs_put_shortlivedpage(be->pagepool, page))
 			continue;
-		if (err)
-			z_erofs_page_mark_eio(page);
-		z_erofs_onlinepage_endio(page);
+		z_erofs_onlinepage_endio(page, err);
 	}
 
 	if (be->decompressed_pages != be->onstack_pages)


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-sunset-erofs_dbg.patch
queue-6.1/erofs-simplify-z_erofs_transform_plain.patch
queue-6.1/erofs-get-rid-of-debug_one_dentry.patch
queue-6.1/erofs-drop-z_erofs_page_mark_eio.patch
queue-6.1/erofs-address-d-cache-aliasing.patch

