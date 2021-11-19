Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4A74570B8
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Nov 2021 15:34:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HwfM324lGz30Pj
	for <lists+linux-erofs@lfdr.de>; Sat, 20 Nov 2021 01:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WsqzMlZ7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=WsqzMlZ7; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HwfM03s1Vz2xr8
 for <linux-erofs@lists.ozlabs.org>; Sat, 20 Nov 2021 01:34:36 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0856661549;
 Fri, 19 Nov 2021 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1637332474;
 bh=m8ACP05DweRITiTY8V8yAvHfQEemDjUI0/pB+3VLwiA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=WsqzMlZ7Xb16Cw8VR8cxV+8hLc3oA3ix5MiODzTKJCrp7tyjvLxpfZrrA9w7krWyH
 Qet22eTmabJ/pB9WyUf+sWT0DjCUh8FASQbawC6USQC0xAdQ89Six82URUBw5VRyMi
 ScsEBO/a92+Cpf79BL+9B4RlkbKNrkwngc0v2WUg=
Subject: Patch "erofs: remove the occupied parameter from
 z_erofs_pagevec_enqueue()" has been added to the 4.19-stable tree
To: gregkh@linuxfoundation.org, hsiangkao@linux.alibaba.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, xiang@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Nov 2021 15:34:24 +0100
In-Reply-To: <20211116024153.245131-1-hsiangkao@linux.alibaba.com>
Message-ID: <163733246422242@kroah.com>
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

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-remove-the-occupied-parameter-from-z_erofs_pagevec_enqueue.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Nov 19 03:26:51 PM CET 2021
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 16 Nov 2021 10:41:52 +0800
Subject: erofs: remove the occupied parameter from z_erofs_pagevec_enqueue()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@yulong.com>, Gao Xiang <xiang@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
Message-ID: <20211116024153.245131-1-hsiangkao@linux.alibaba.com>

From: Yue Hu <huyue2@yulong.com>

commit 7dea3de7d384f4c8156e8bd93112ba6db1eb276c upstream.

No any behavior to variable occupied in z_erofs_attach_page() which
is only caller to z_erofs_pagevec_enqueue().

Link: https://lore.kernel.org/r/20210419102623.2015-1-zbestahu@gmail.com
Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ Gao Xiang: handle 4.19 codebase conflicts manually. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/erofs/unzip_pagevec.h |    5 +----
 drivers/staging/erofs/unzip_vle.c     |    4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -117,10 +117,8 @@ static inline void z_erofs_pagevec_ctor_
 static inline bool
 z_erofs_pagevec_ctor_enqueue(struct z_erofs_pagevec_ctor *ctor,
 			     struct page *page,
-			     enum z_erofs_page_type type,
-			     bool *occupied)
+			     enum z_erofs_page_type type)
 {
-	*occupied = false;
 	if (unlikely(ctor->next == NULL && type))
 		if (ctor->index + 1 == ctor->nr)
 			return false;
@@ -135,7 +133,6 @@ z_erofs_pagevec_ctor_enqueue(struct z_er
 	/* should remind that collector->next never equal to 1, 2 */
 	if (type == (uintptr_t)ctor->next) {
 		ctor->next = page;
-		*occupied = true;
 	}
 
 	ctor->pages[ctor->index++] =
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -234,7 +234,6 @@ static int z_erofs_vle_work_add_page(
 	enum z_erofs_page_type type)
 {
 	int ret;
-	bool occupied;
 
 	/* give priority for the compressed data storage */
 	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY &&
@@ -242,8 +241,7 @@ static int z_erofs_vle_work_add_page(
 		try_to_reuse_as_compressed_page(builder, page))
 		return 0;
 
-	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector,
-		page, type, &occupied);
+	ret = z_erofs_pagevec_ctor_enqueue(&builder->vector, page, type);
 	builder->work->vcnt += (unsigned)ret;
 
 	return ret ? 0 : -EAGAIN;


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-4.19/lib-xz-validate-the-value-before-assigning-it-to-an-.patch
queue-4.19/erofs-fix-unsafe-pagevec-reuse-of-hooked-pclusters.patch
queue-4.19/lib-xz-avoid-overlapping-memcpy-with-invalid-input-w.patch
queue-4.19/erofs-remove-the-occupied-parameter-from-z_erofs_pagevec_enqueue.patch
