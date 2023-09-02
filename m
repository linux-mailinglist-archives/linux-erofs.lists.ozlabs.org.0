Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E179062C
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Sep 2023 10:28:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=odcbh3of;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rd7Mx4kf7z3bVS
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Sep 2023 18:28:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=odcbh3of;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rd7Mg27ZZz2ykV
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Sep 2023 18:28:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AA637B82763;
	Sat,  2 Sep 2023 08:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DC5C433CB;
	Sat,  2 Sep 2023 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693642817;
	bh=Chj98CpmtJrN2V6EJanAIGcAz0EFWdfkfIznXt7K1Lk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=odcbh3ofgt6hZ4/P2CK5vQR05F2LIHUQmVXxj8mmoCiTw5RKUa9jLUq3C/sXk97vp
	 9raBLsgISeKu/cOTosdaWpV5uFXS2diVbFNlNzbl2OvBwiJtbD98JtgX7onpt6tHGd
	 5wenwQCgQc+Uz6jBmMTmQhefMv5kysTxmOjuu+1Y=
Subject: Patch "erofs: ensure that the post-EOF tails are all zeroed" has been added to the 5.15-stable tree
To: 3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,keltar.gw@gmail.com,linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Sep 2023 10:20:06 +0200
In-Reply-To: <20230831112959.99884-6-hsiangkao@linux.alibaba.com>
Message-ID: <2023090206-lure-affecting-8532@gregkh>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    erofs: ensure that the post-EOF tails are all zeroed

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-ensure-that-the-post-eof-tails-are-all-zeroed.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com  Sat Sep  2 09:30:52 2023
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Thu, 31 Aug 2023 19:29:58 +0800
Subject: erofs: ensure that the post-EOF tails are all zeroed
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>, keltargw <keltar.gw@gmail.com>
Message-ID: <20230831112959.99884-6-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.

This was accidentally fixed up in commit e4c1cf523d82 but we can't
take the full change due to other dependancy issues, so here is just
the actual bugfix that is needed.

[Background]

keltargw reported an issue [1] that with mmaped I/Os, sometimes the
tail of the last page (after file ends) is not filled with zeroes.

The root cause is that such tail page could be wrongly selected for
inplace I/Os so the zeroed part will then be filled with compressed
data instead of zeroes.

A simple fix is to avoid doing inplace I/Os for such tail parts,
actually that was already fixed upstream in commit e4c1cf523d82
("erofs: tidy up z_erofs_do_read_page()") by accident.

[1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com

Reported-by: keltargw <keltar.gw@gmail.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -716,6 +716,8 @@ hitted:
 	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-5.15/erofs-ensure-that-the-post-eof-tails-are-all-zeroed.patch
