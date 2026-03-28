Return-Path: <linux-erofs+bounces-3062-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPBSOhEdyGkShAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3062-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:25:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0951E34F8AB
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:25:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjmCK4RKdz2ySc;
	Sun, 29 Mar 2026 05:25:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.255.12.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774722317;
	cv=none; b=d8FbXEu6hFkVRCQznZGlhzqZN/dqz7W4OJUbvzBiFMvTv3SKHDbkIV8Tzao8/0Qz6vdqOZ9TKfIDaFz5Ws9WdtbEdUbTYdeqQsQG4lKmxreZ+H9PuPdk9jMh+//fIQ+SBDTfecyVF4L1JVHNWWhJxvlKZHo6ycdPq9PHI79k700azf5KhfCYgpSgwm+xuz63khfYI3Iph4MUXbdoFjt6WuI5dFuxRYzCbFk/P516Xhv6ux+70M8Ruxl+pUln0+NO4DmxR4VflYQDT/AxNCReJBmHB7ksKg4ryx0J5UQxjb4WPdDLtNl1+LC5Mv0etfu55t+Aprn7B1YjbYMwfqhtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774722317; c=relaxed/relaxed;
	bh=Z69I1zT1OmIlOxzc4+bvhIZk7bvq6mzxmN8fD3QRepI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=ggWr74sgQxwPWwP0CbfXAwNf3ruxg882aVcHdIlYUHoadiGccbqQdKyXA3yn4A9+4Tkf71TDnQVFVz7wIOvyn2TAe7Oh6cEM6cAfYCBYYTe0EYmUg04vrYMCD1D5KsTs0Yw+Hnm4KrZyTkMKLt9WcVhsj9/xM1bv20/fwc8Sz3pys95tZGV6DC3z37WCnpQ2Vq59FVN6DY2jzjLZOutME79mYw22YHlbPfgwZjhQ7SWFo+zC6U2JFt1LQBmvaVuO7vQSLU27yNujanoCZ4ZVFvTsdQj28yQLosVqhkMLMRyl4iNDL+UKrKxo63OTCblN7pRLf5h+KedxHXX8JLX6ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=TMb9A7G/; dkim-atps=neutral; spf=pass (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org) smtp.mailfrom=manguebit.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=TMb9A7G/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.org (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org)
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjmCJ6G90z2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 05:25:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z69I1zT1OmIlOxzc4+bvhIZk7bvq6mzxmN8fD3QRepI=; b=TMb9A7G/pcnhz10NHFrg51PrVr
	3wlDJUa9zCWpkzSuigzyubHdRaeadFWW5bNIQfibjOzJ36gZsqXjoEz2im+IrkaFsOMQi+703Ihf9
	V7cCTXht/7WmOhky3lKQ6qotzFfoDoJMprWEz4wD4ipBzN5t5VXUZKnbjWZ2zROFgvAghvudMEd8i
	z9rG34/EoZdtH4RtujdOR1Esk9o79ocIv83FbWbNMlzWKBVeG7jxKZ3SXAy+Boo03lDODOKmgkGq5
	PHcLbA7CrwToSA+EgZdrKMzTURZWJ1Yw9pn2KYFPlsCDrC7DFEr+0uWauT/U2dcFXrLN75pImJJ5x
	n2Iw4NyQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YLS-00000001ni6-2udw;
	Sat, 28 Mar 2026 15:25:14 -0300
Message-ID: <1776cecc9268b81b426c041fdceae5f8@manguebit.org>
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/26] netfs: Fix read abandonment during retry
In-Reply-To: <20260326104544.509518-6-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-6-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:25:14 -0300
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3062-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	FORGED_SENDER(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,manguebit.org:dkim,manguebit.org:email,manguebit.org:mid]
X-Rspamd-Queue-Id: 0951E34F8AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> Under certain circumstances, all the remaining subrequests from a read
> request will get abandoned during retry.  The abandonment process expects
> the 'subreq' variable to be set to the place to start abandonment from, but
> it doesn't always have a useful value (it will be uninitialised on the
> first pass through the loop and it may point to a deleted subrequest on
> later passes).
>
> Fix the first jump to "abandon:" to set subreq to the start of the first
> subrequest expected to need retry (which, in this abandonment case, turned
> out unexpectedly to no longer have NEED_RETRY set).
>
> Also clear the subreq pointer after discarding superfluous retryable
> subrequests to cause an oops if we do try to access it.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> ---
>  fs/netfs/read_retry.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

