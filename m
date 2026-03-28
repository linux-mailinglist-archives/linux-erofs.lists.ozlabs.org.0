Return-Path: <linux-erofs+bounces-3065-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMS3GscdyGkShAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3065-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:28:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E934F957
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:28:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjmGq51xMz2yfS;
	Sun, 29 Mar 2026 05:28:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.255.12.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774722499;
	cv=none; b=C95J3flugQh+BsTcda3Z6MHzdQNIJS25gCkIO914IUo7wV1LYjiXtbHWZo9fiSmrqfWuAt/R7UK1TzviFsEDpMRX3ZDP23xAUrA0a+R3zibT3oKyKhKDEeHddqGEkSf/IJMxcn9OukQkxv5cfRLBL6DKpFFsBm9s6Xlsk5ls0LzVGZCRgEtZMjt8/+4SdEbjPaQsehWumzE2dr8RGafdk6QOuUx1nwDZEUaGt6BPtJ6hCoaAB3xxae/B1YnVUKR3RPEOegijF0tWap8ffgOfzBP+Y8mKVf72sgj2wOilvVWz1Sl2lQYoPdWJiFd/+4DEcD3qKCCnntDzL24NrOGBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774722499; c=relaxed/relaxed;
	bh=reVttJ4xFR0WcZPDlyXMurvNf6WDPPLRFPlRnwcnixk=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=aiBsAmIMxiDdOvazURTwZmvzK+VO21FjiOMNC3U/Eu5X972l1cZ+ttrPC/sehlpMekMXWI6gF4Cvt0ZhXv3DcEp2ENTvS34o0OV3NOyOzzw5dpTqnkaOV4Xa574srN+CCPN2r6kpf5Alb2EeXY24v1Rwkpvk+BwjQ1OI0qAnZTeQCukfsqwHB+EhaEWvUMziLtrZlkrO8MtXUrsxRFs9oDh6v//nmLo8QddtpvsKb+wPq15wpjGxdqgavPECtGWi2qRYOzdAM5PgTPKtsGURvXXaU2njBSu1zpo68BCw1JCdxEB9is041kwKtx+UR2H2dbELNaX0r2wklwjoWgh4ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=sqT5cKpt; dkim-atps=neutral; spf=pass (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org) smtp.mailfrom=manguebit.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=sqT5cKpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.org (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org)
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjmGq0jj2z2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 05:28:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=reVttJ4xFR0WcZPDlyXMurvNf6WDPPLRFPlRnwcnixk=; b=sqT5cKpt/tMHM/kACWo4Il0ZHF
	IUn796fZuwnC+Wyu5QTqvpyb9bJ6qK8ZoJAGB4agtzpORv3z2VlKCzgEkPc4syqvJNIBWy7OEoOkn
	c9gCghMvJCWFLiYP4XakWG1pNiMyLAhVENhn9MIXdrLgexLNZu9R6oej67AMc7IyHkkHeY9CNPowv
	Cxg83PHujJQVOiNsgjiK2ughsIWXPfBn5VbD7eKMYxgTBWCsr+i8d5wQwaZz1X76zNVZGxvyF16Bs
	tZl4exrAbAMoRFSuzdMDCmT07ly8JceXPTMH0KuLk1ohGPE/60mwdmWtufn4QiD7Q57hCJWEo9U/A
	zvcmaNUw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YGz-00000001nf0-3jFV;
	Sat, 28 Mar 2026 15:20:37 -0300
Message-ID: <9677d7ab513928a8677a1ce99f18d189@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Leon
 Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne
 <marc.dionne@auristor.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov
 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com, Deepanshu Kartikey
 <Kartikey406@gmail.com>
Subject: Re: [PATCH 01/26] netfs: Fix NULL pointer dereference in
 netfs_unbuffered_write() on retry
In-Reply-To: <20260326104544.509518-2-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-2-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:20:37 -0300
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
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3065-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kartikey406@gmail.com,m:syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com,m:Kartikey406@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,7227db0fbac9f348dba0];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,manguebit.org:dkim,manguebit.org:email,manguebit.org:mid]
X-Rspamd-Queue-Id: C41E934F957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
> in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
> without checking if it is NULL.
>
> Filesystems such as 9P do not set the prepare_write operation, so
> stream->prepare_write remains NULL. When get_user_pages() fails with
> -EFAULT and the subrequest is flagged for retry, this results in a NULL
> pointer dereference at fs/netfs/direct_write.c:189.
>
> Fix this by mirroring the pattern already used in write_retry.c: if
> stream->prepare_write is NULL, skip renegotiation and directly reissue
> the subrequest via netfs_reissue_write(), which handles iterator reset,
> IN_PROGRESS flag, stats update and reissue internally.
>
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/direct_write.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

