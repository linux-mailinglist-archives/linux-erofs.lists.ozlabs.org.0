Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1894570BC
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 15:35:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwfMf6TmFz3bXj
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Nov 2021 01:35:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aF5jKuDu;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=aF5jKuDu; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwfMb0MwRz3054
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 01:35:07 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C484261544;
 Fri, 19 Nov 2021 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1637332505;
 bh=Zs8ojHOvUyupkzVZor19pPn1zCFVJGXGj8wKEL8A9gI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=aF5jKuDuJgOEOqg2soSEW2bD/VcLngZUD52hXWPjzbHcxgKIPA2mwkfApvgA+s4P2
 2Yoq0rY/9b7IekAUsNkCao9FYoO+v4iFLHzcVBAzLIQ72F35rL7KbkTbt78yINtyK9
 AC9nfFh7kOcr3YW2VjJQRZGadF4DP9y4WJt0n5No=
Subject: Patch "erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org, hsiangkao@linux.alibaba.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, xiang@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Nov 2021 15:34:54 +0100
In-Reply-To: <20211116010819.122905-1-hsiangkao@linux.alibaba.com>
Message-ID: <163733249415942@kroah.com>
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

    erofs: remove the occupied parameter from z_erofs_pagevec_enqueue()

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-remove-the-occupied-parameter-from-z_erofs_pagevec_enqueue.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Nov 19 03:21:54 PM CET 2021
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 16 Nov 2021 09:08:18 +0800
Subject: erofs: remove the occupied parameter from z_erofs_pagevec_enqueue()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>, Gao Xiang <xiang@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Message-ID: <20211116010819.122905-1-hsiangkao@linux.alibaba.com>

From: Yue Hu <huyue2@yulong.com>

commit 7dea3de7d384f4c8156e8bd93112ba6db1eb276c upstream.

No any behavior to variable occupied in z_erofs_attach_page() which
is only caller to z_erofs_pagevec_enqueue().

Link: https://lore.kernel.org/r/20210419102623.2015-1-zbestahu@gmail.com
Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |    4 +---
 fs/erofs/zpvec.h |    5 +----
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -282,7 +282,6 @@ static int z_erofs_attach_page(struct z_
 			       enum z_erofs_page_type type)
 {
 	int ret;
-	bool occupied;
 
 	/* give priority for inplaceio */
 	if (clt->mode >= COLLECT_PRIMARY &&
@@ -290,8 +289,7 @@ static int z_erofs_attach_page(struct z_
 	    z_erofs_try_inplace_io(clt, page))
 		return 0;
 
-	ret = z_erofs_pagevec_enqueue(&clt->vector,
-				      page, type, &occupied);
+	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type);
 	clt->cl->vcnt += (unsigned int)ret;
 
 	return ret ? 0 : -EAGAIN;
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -107,10 +107,8 @@ static inline void z_erofs_pagevec_ctor_
 
 static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
 					   struct page *page,
-					   enum z_erofs_page_type type,
-					   bool *occupied)
+					   enum z_erofs_page_type type)
 {
-	*occupied = false;
 	if (!ctor->next && type)
 		if (ctor->index + 1 == ctor->nr)
 			return false;
@@ -125,7 +123,6 @@ static inline bool z_erofs_pagevec_enque
 	/* should remind that collector->next never equal to 1, 2 */
 	if (type == (uintptr_t)ctor->next) {
 		ctor->next = page;
-		*occupied = true;
 	}
 	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
 	return true;


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-5.10/erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
queue-5.10/erofs-remove-the-occupied-parameter-from-z_erofs_pagevec_enqueue.patch
