Return-Path: <linux-erofs+bounces-3225-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAsjBp9Y1mlJEAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3225-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 15:31:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5953BCF1E
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 15:31:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frP8q65vhz2yd7;
	Wed, 08 Apr 2026 23:31:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775655067;
	cv=none; b=h1h4qhycLACHY7njg7lvDDGIHSbKKs5moiBiMLHMH+NggAaeBXSnP7OzdaERoXV+PLl7cqCHPzNeCV1XQ4g6NWekLcN4HtiV2iKjgXcgGYeeH17rBkJ4m7gdjVYcWT9uTxmcd+R9NB7yQ8g55vC+L/7CKIEhrDZcysfTY9wYKWy1vym00D0RPt9x2OoJ4jvhxizcdN6uVvmnWIBqGD35ecW6o6aUiioB0Tz/cTHgqf1LZgOx++FI8NbDrh9oPeXkTJgZd7Ejq6moRKP2alFOR0FqeFAXJbbKXWqw6LRFBsrLK/6JE5lZfJjTLdL8Wxl30bm7QUkBaKCpxWdYIqlW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775655067; c=relaxed/relaxed;
	bh=VUynKF9q4Zf5v3Yr0PnOeVT6PkxYuXbR87Bo2F7Yc2E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=YCYTSlWhirH55/gxQP/cI/XSipjSoy5sVRplTZzIXH7bgc5J/TAD/WV/WUI9vYvPfN2BFZ6347DUh2UxgbrEgh7F7NHiBzxYK32a4S1L0NE8+Qeqm3K7laBPi6f7+xMqZgwZ+CthfPTAvxex5CEvoNHfiU42dyef43/OfrccE6e+A82xUwoGJgxXqjJggNUDH781zReYp/2IK90GuoolPSAe5IhOQNVAlkYa7k0aIntOl4DA97jUgpi7uDsanyVozLB42PcoFYy68Cmz7mTP8qNRGh2nuMRxf/jXr0wXkARgl7fi9Ba+2BUTDlvm3F7oLEkWYce9d+rBSW/GelMxJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GQX6r5Vi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GQX6r5Vi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frP8p50z2z2xc8
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 23:31:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8AA2C60123;
	Wed,  8 Apr 2026 13:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8645C19421;
	Wed,  8 Apr 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655064;
	bh=WiXL4KzMwZmSPBEu9jgKF9uJZ8zBTo726mJKbSWWiUo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=GQX6r5VireMG/5NaRHiiJPS81HtQJfpwM5AR2vu7c88E45/vh6Xi4nGiWLLX+p3U8
	 YIE3oHWX+icfc9YsqB+jT6d6y/I7YiXnZffsB7ta0aLjOMhAL+78t1Z755hN6EFLle
	 iY+93ApNxM7fGdvPeaW/CKkXyE4Xed7K/zx7IMjY=
Subject: Patch "erofs: Fix the slab-out-of-bounds in drop_buffers()" has been added to the 6.1-stable tree
To: arefev@swemel.ru,chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org,lvc-project@linuxtesting.org,syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com,xiang@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:30:51 +0200
In-Reply-To: <20260323135936.15070-1-arefev@swemel.ru>
Message-ID: <2026040851-sassy-unglue-dc06@gregkh>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3225-lists,linux-erofs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:arefev@swemel.ru,m:chao@kernel.org,m:gregkh@linuxfoundation.org,m:hsiangkao@linux.alibaba.com,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:lvc-project@linuxtesting.org,m:syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com,m:xiang@kernel.org,m:stable-commits@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,5b886a2e03529dbcef81];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,syzkaller.appspot.com:url,ozlabs.org:email,alibaba.com:email,appspotmail.com:email,linuxtesting.org:email]
X-Rspamd-Queue-Id: 4F5953BCF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    erofs: Fix the slab-out-of-bounds in drop_buffers()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-fix-the-slab-out-of-bounds-in-drop_buffers.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From arefev@swemel.ru Mon Mar 23 14:59:38 2026
From: Denis Arefev <arefev@swemel.ru>
Date: Mon, 23 Mar 2026 16:59:35 +0300
Subject: erofs: Fix the slab-out-of-bounds in drop_buffers()
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Jeffle Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
Message-ID: <20260323135936.15070-1-arefev@swemel.ru>

From: Denis Arefev <arefev@swemel.ru>

commit ce529cc25b184e93397b94a8a322128fc0095cbb upstream.

This was accidentally fixed in commit ce529cc25b18, but it's not possible
to accept all the changes, due to the lack of large folios support for 
Linux 6.1 kernels, so this is only the actual bug fix that's needed.

[Background]

Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in
the drop_buffers() function [1].

The root cause is that erofs_raw_access_aops does not define .release_folio
and .invalidate_folio. When using iomap-based operations, folio->private
may contain iomap-specific data rather than buffer_heads. Without special
handlers, the kernel may fall back to generic functions (such as 
drop_buffers), which incorrectly treat folio->private as a list of
buffer_head structures, leading to incorrect memory interpretation and
out-of-bounds access.

Fix this by explicitly setting .release_folio and .invalidate_folio to the
values of iomap_release_folio and iomap_invalidate_folio, respectively.

[1] https://syzkaller.appspot.com/x/report.txt?x=12e5a142580000 

Fixes: 7479c505b4ab ("fs: Convert iomap_readpage to iomap_read_folio")
Reported-by: syzbot+5b886a2e03529dbcef81@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/data.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -406,6 +406,8 @@ const struct address_space_operations er
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
+	.release_folio = iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 };
 
 #ifdef CONFIG_FS_DAX


Patches currently in stable-queue which might be from arefev@swemel.ru are

queue-6.1/erofs-fix-the-slab-out-of-bounds-in-drop_buffers.patch

