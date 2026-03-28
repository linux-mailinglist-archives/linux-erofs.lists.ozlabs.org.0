Return-Path: <linux-erofs+bounces-3063-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bz0GygdyGkShAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3063-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:25:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6C34F8D0
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:25:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjmCn1JDtz2ySc;
	Sun, 29 Mar 2026 05:25:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.255.12.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774722341;
	cv=none; b=TzYELDgm/6Zfr5ENiW4TO7u4wiaYAoH8vgAgiXzec5YKZ+9bs22EnHWq0v/bSLwHpMMwNNZzX0i0RoXYbkt2ZwswYLIZd2QYXZFac3IVrbwz0LIuXRnejGDVtOFMqWC2KOVIPjT07JUHgPbu+nJ4S09ice0noEYjUdKw/GW3UBlTy7Xg4Ow+FxU2Rv6JBtb4G4bHcNgWoRAX+QlyzIofAazTFde1uNuyIYKrwE6mcYY433JsYQDoZTmkamHYKMy/58XmhhBdw/ILuOx1ZgvLFTrUTlIzhLYHdawSl5w0IyAZUq/6mMhjx01YXeES3aPqLGT5zzA6pigt7GFNandwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774722341; c=relaxed/relaxed;
	bh=vtvToygHD/XhQ/RgwXcfB1cu6LKJlBXHH2QlzqxoAkc=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Z7upf1m8QXfXJjeuYrhiCRyLdqwrNclTSoEQ9vzEEgoWeqMms+pBKb4fMBOhU2kzIUqjI/N1lVVp/El7V2qD8tWOk87RMFyXFFufGaqGJ5kZNLkK6kZrFnPK1q6R9rFYOmShoemT08awhM11iSalzyLNX0AnD0PvfVZJ32P6616S6Bm1b2qP/YF64X7SbdglWHWZGC6nvy1JZfuph4czZSaRvg/UdaO/OAjzVk7Jo1i05acpD4mz/EMzUxLF5iTqXnRExi7qLdRw9C9FJ8st8LJjPRta5q3muX3IkCDJMrcbjFCrPp/V+GVlYjHNFv4BFgVfXhyQ38GBne7DaVXnyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com; dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=rTHrKogG; dkim-atps=neutral; spf=pass (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org) smtp.mailfrom=manguebit.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=rTHrKogG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.org (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org)
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjmCl74x1z2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 05:25:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Sender:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=vtvToygHD/XhQ/RgwXcfB1cu6LKJlBXHH2QlzqxoAkc=; b=rTHrKogGPS9SS4H5Xyzci5KbyJ
	XKCEjVCCUGW0MPjqZyKrvkvKJxf0WNl3E46gZ2GJLqoBxj9PZI5sg46wECKkS6vmMz3pg3uWz/iST
	d2AciCtqNPlAP3ARviB3hcA/WCr+iB1dl5GORx18D4DiXUBx2VslCgq3L5g2yQjs430mdesNStHxc
	l/i6xO/XxwNK1pBiWFgd3JEIQOqeTW/5iYWGNXyWaaUlKQ08SunfIbk7xXfm/gUUDS6JoRV8uRT6E
	KYWg4hW9AKFWaanekAYiM56fYDhBikopDjrQUVm6Et5i9/uyg8ClhrcpddsRsrWeVqLS8Nm+qgNl9
	X0nQJvTQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YLp-00000001nin-3OQp;
	Sat, 28 Mar 2026 15:25:37 -0300
Message-ID: <f73f5322e1e964404deefe64cc3e33db@manguebit.com>
From: Paulo Alcantara <pc@manguebit.com>
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/26] netfs: Fix the handling of stream->front by
 removing it
In-Reply-To: <20260326104544.509518-7-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-7-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:25:37 -0300
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
Sender: pc@manguebit.org
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.30 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[manguebit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3063-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pc@manguebit.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,manguebit.org:dkim,manguebit.org:email]
X-Rspamd-Queue-Id: 8BC6C34F8D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> The netfs_io_stream::front member is meant to point to the subrequest
> currently being collected on a stream, but it isn't actually used this way
> by direct write (which mostly ignores it).  However, there's a tracepoint
> which looks at it.  Further, stream->front is actually redundant with
> stream->subrequests.next.
>
> Fix the potential problem in the direct code by just removing the member
> and using stream->subrequests.next instead, thereby also simplifying the
> code.
>
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: Paulo Alcantara <pc@manguebit.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_read.c     | 3 +--
>  fs/netfs/direct_read.c       | 3 +--
>  fs/netfs/direct_write.c      | 1 -
>  fs/netfs/read_collect.c      | 4 ++--
>  fs/netfs/read_single.c       | 1 -
>  fs/netfs/write_collect.c     | 4 ++--
>  fs/netfs/write_issue.c       | 3 +--
>  include/linux/netfs.h        | 1 -
>  include/trace/events/netfs.h | 8 ++++----
>  9 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

