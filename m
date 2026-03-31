Return-Path: <linux-erofs+bounces-3141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDXsKTzIy2mnLgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:12:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413936A005
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 15:12:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flT6v6rMjz2ybQ;
	Wed, 01 Apr 2026 00:12:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774962743;
	cv=none; b=HJlF5QjEO+cEp7Lr2X6cx48oz2QRIx4BXW3xwy6F5wJ3SfkWVBT0dKm6nTTatkBATR2gYS2bcGfbCnr8w4fOvbjQuriZCb9+LAz4dTNfdQ/Rf0PFrCtVESwUpmPTBEba4zdoTihWiGAYIivyxdyEKIM4y9KxdbuJXInYL8SKGI35AizFmknlEHMlI5TFg4mTXHBZDEwcZYcSA2uySkD4qCv7bnWG2BTBqQM0Weo9bTt+Ko89lrBMywbaS42VGbSLpAdUIMpmn2qW5meSp4Gc7pJA2rAOoql/82q+HOZ+FISPlBcf5WebfuOgJh4bR1RGz5K851JlDBKcCuSfzXxSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774962743; c=relaxed/relaxed;
	bh=N154C0IbvKe3lYUHIr5PYmJt9/2KA4XOPHlGWLqYPcE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=LU70lJ3neH3jg0xGPgL8WVrQfFpZWujAII86FvMpy7oodaeKFsc4uE6qYzVlPNTdOpVpgGsF8hr5BmrNSBxi+McDOIuyQfRLxhjeU2P6yAGyGohm7xXIuyeNb7eGUo2PZurv9rJZbsIeeIPMw+2rUz3E2mJT4i/zQmt9zzylqTzD9b0osNI8wYBM5NjM4vrvIjgF0I/sk0PEzjjVtFvi1jIieTBWUroyZO5xhFo6p66J9pSjbpzGcGO2ALeH6Aaz19GqwJdk2w2EcrC05+LsZi98vjWaHMKMBD/jGFQUzQgoyqm5Z/uFHJRq1FjIjpPQeluGBP8Uy1sIlP1vUmx3zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I3Mkdvje; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=I3Mkdvje;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flT6s325Dz2xYk
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 00:12:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0BCA741832;
	Tue, 31 Mar 2026 13:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91259C19423;
	Tue, 31 Mar 2026 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774962737;
	bh=Vm+JGExcodg7akIuEpfztcudohQP9LxVsvkgdZP/LrY=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=I3MkdvjeT3bjbAKDxq2jGk7JkldIL4StVhyZnHfLQNIlQZVtnwSqHrDCra32cCwu4
	 KvctSMbZhZSl7hCi+zaVlOyjaifzsjp4VQjXR7itHnwxNRktf5m4AZgML9TODBAeqU
	 9mFYujQU9hZgonFCdC8RjI/wgEYSD2D6S4JBK/wg=
Subject: Patch "erofs: fix "BUG: Bad page state in z_erofs_do_read_page"" has been added to the 6.6-stable tree
To: 69c3b299.a70a0220.234938.004b.GAE@google.com,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org,syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 31 Mar 2026 15:12:15 +0200
In-Reply-To: <20260327041524.1087336-1-hsiangkao@linux.alibaba.com>
Message-ID: <2026033115-author-estimator-a14d@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3141-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:69c3b299.a70a0220.234938.004b.GAE@google.com,m:gregkh@linuxfoundation.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com,m:stable-commits@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-erofs,b6353e35ae2bab997538];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,alibaba.com:email,syzkaller.appspot.com:url,appspotmail.com:email,ozlabs.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D413936A005
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    erofs: fix "BUG: Bad page state in z_erofs_do_read_page"

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-fix-bug-bad-page-state-in-z_erofs_do_read_page.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Fri Mar 27 05:15:33 2026
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Fri, 27 Mar 2026 12:15:24 +0800
Subject: erofs: fix "BUG: Bad page state in z_erofs_do_read_page"
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>, syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Message-ID: <20260327041524.1087336-1-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

It's actually a stable-only issue from backporting 9e2f9d34dd12
("erofs: handle overlapped pclusters out of crafted images properly")

We missed to update `oldpage` after `pcl->compressed_bvecs[nr].page`
is updated, so that the following cmpxchg() will fail; the original
upstream commit doesn't behave like this due to new features and
refactoring.

This backport issue only impacts some specific crafted images and
normal filesystems won't be impacted at all.

Fixes: 1bf7e414cac3 ("erofs: handle overlapped pclusters out of crafted images properly") # 6.6.y
Closes: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
Reported-and-tested-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com [1]
[1] https://lore.kernel.org/r/69c3b299.a70a0220.234938.004b.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1503,6 +1503,7 @@ repeat:
 	lock_page(page);
 	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
 		/*
 		 * The cached folio is still in managed cache but without


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.6/erofs-add-gfp_noio-in-the-bio-completion-if-needed.patch
queue-6.6/erofs-fix-bug-bad-page-state-in-z_erofs_do_read_page.patch

