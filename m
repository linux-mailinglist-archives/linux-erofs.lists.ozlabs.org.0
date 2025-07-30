Return-Path: <linux-erofs+bounces-724-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC89B15AFA
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jul 2025 10:55:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsQz91WbPz3blF;
	Wed, 30 Jul 2025 18:55:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753865733;
	cv=none; b=gTSQOFWf9zktmSlWiU1baZKdH7yCLZ+0yEWYm4oLbe0v+eaC/GkvDPq/audJLYZWKIPucZswQM+Eh2I/mAq7HNd/aVDBvg7wMO4h7cVfxqMOB0D0LP20zH0bUZQmjHlq4ZITqX8igsyeKbt3w7umv1uJEHC0unOI1KJl4bKYJO2DAq9v2M11o6uGq0ucaRqAMnAf6Ix5KseDK5Pl6GLAPdcw2djPs7ppRH+2GZUyIpmcuNqgFy/CKwPaQ+w0ABY/f80pSreWnuGY3gdUiM+nn5DqzIE5srgGKCfmVijQHfmFxCFeafRpEiWZJKr312O29uxKklDvGiKwNs8fnYcuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753865733; c=relaxed/relaxed;
	bh=pyv+uVe2xSZblNN12qgM2X2mojWO6Wet9EMuowF2p7o=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=IDaip39M6Zjaf3JKX4aERvKzQOrrBk40qwah7X8gQjWL7C7toW7f7k5R7zkMWLMH7Wa0OJIR4uwoLzWjmHHy+3fM2kzJUHApFyBe+Tey1eoP9Ep1leV1AAx/86D/oE+0dm1uuCjJtPJYMiO3CEyhnls06WvugifovikJvtfqlpiV86S1IUhVwcXlpB6kE1xgxWNmew/vTnHGVGy13vQYB19Od3TRE9mC8OPo91+Oi5ZYOfRj+gB6fNrUuRRke3p57ESgEAp1jooTv7cottTCeTR7WzIwurt0ya3H5NJsYF9R0fhpTbLuSKlom2plnXr2nn/yO7gkKcPsAsTZK83TIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Lc4PZgzL; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Lc4PZgzL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsQz83CdVz2yGf
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Jul 2025 18:55:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AC165C48A9;
	Wed, 30 Jul 2025 08:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958FEC4CEF5;
	Wed, 30 Jul 2025 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753865730;
	bh=W9VzuvIhcsWBHY97iqUaQSl3iZJgOaKqkWDCRL4G044=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Lc4PZgzLCIyBsMffn/udNAqUemnW+H8nWcfPrQX30LXp8EYz4ZNDcxCaIt1KK6QnI
	 jsoMTQxsGYSs9HmH9NGAWqQ3GJznL3Pa10TkWen24mrM0yp5S2oWFy4feFzq4hZjtF
	 biaBB7Bd9Sm/AWVyBaCyh/dYdmxYPqmIw5phjlus=
Subject: Patch "erofs: simplify z_erofs_transform_plain()" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jan.kiszka@siemens.com,linux-erofs@lists.ozlabs.org,s.kerkmann@pengutronix.de
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 10:55:13 +0200
In-Reply-To: <20250722100029.3052177-5-hsiangkao@linux.alibaba.com>
Message-ID: <2025073013-boogeyman-deluge-56c0@gregkh>
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
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


This is a note to let you know that I've just added the patch titled

    erofs: simplify z_erofs_transform_plain()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-simplify-z_erofs_transform_plain.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-163684-greg=kroah.com@vger.kernel.org Tue Jul 22 12:04:46 2025
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 22 Jul 2025 18:00:28 +0800
Subject: erofs: simplify z_erofs_transform_plain()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kiszka <jan.kiszka@siemens.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <huyue2@coolpad.com>, Chao Yu <chao@kernel.org>
Message-ID: <20250722100029.3052177-5-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit c5539762f32e97c5e16215fa1336e32095b8b0fd upstream.

Use memcpy_to_page() instead of open-coding them.

In addition, add a missing flush_dcache_page() even though almost all
modern architectures clear `PG_dcache_clean` flag for new file cache
pages so that it doesn't change anything in practice.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230627161240.331-2-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/decompressor.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,7 @@ static int z_erofs_transform_plain(struc
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	const unsigned int interlaced_offset =
 		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	unsigned char *src, *dst;
+	u8 *src;
 
 	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
@@ -336,22 +336,19 @@ static int z_erofs_transform_plain(struc
 	}
 
 	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_local_page(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
-		       righthalf);
-		kunmap_local(dst);
-	}
+	if (rq->out[0])
+		memcpy_to_page(rq->out[0], rq->pageofs_out,
+			       src + interlaced_offset, righthalf);
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
 		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
-			dst = kmap_local_page(rq->out[outpages - 1]);
-			memcpy(dst, interlaced_offset ? src :
-					(src + righthalf), lefthalf);
-			kunmap_local(dst);
+			memcpy_to_page(rq->out[outpages - 1], 0, src +
+					(interlaced_offset ? 0 : righthalf),
+				       lefthalf);
 		} else if (!interlaced_offset) {
 			memmove(src, src + righthalf, lefthalf);
+			flush_dcache_page(rq->in[inpages - 1]);
 		}
 	}
 	kunmap_local(src);


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-sunset-erofs_dbg.patch
queue-6.1/erofs-simplify-z_erofs_transform_plain.patch
queue-6.1/erofs-get-rid-of-debug_one_dentry.patch
queue-6.1/erofs-drop-z_erofs_page_mark_eio.patch
queue-6.1/erofs-address-d-cache-aliasing.patch

