Return-Path: <linux-erofs+bounces-3070-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIvoIIIgyGmKhAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3070-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:40:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C362F34FA7E
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 19:40:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjmXG3SyBz2ySc;
	Sun, 29 Mar 2026 05:39:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=143.255.12.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774723198;
	cv=none; b=GPx8ODKStLSeK5Dh2/UsIUbQ4UHr5KANIIUMYCRHmpR1TqdhOrOPpCRj8gzjOITFUVZit5hji3AFf/RBGNCKm+0ZHMHqRxxVNL5ZM8B4Rqkmou3mKcV4aNa3bPVoUShQ4F0rMNpSAaVpzdPLzcZIQlpRC3mLjK3134dulzrM6N8XzGoWf0o945E31AUsKViGHVZJQZ11P1ZR0OLmVZVtpb0322+SP8c5cvAhh5cS8vZxrwo5cpUUi78aiq8c7/Pxlp8JE68EZNTz/N3cQjedhLM26djpEPID8iOGpB/GtVagbCtc1fwD5mKWmSu+yRUJ0PJCBA8NtH6VpCjF7SUHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774723198; c=relaxed/relaxed;
	bh=TCGm0nfvvy8Bnnpu5UWLIv7a/i53kn4C96IdqEjuOQc=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=BGxfXz3josFEpBtYyrkDmdTggEz335lAYWnMlBDlKeB7kmRxJxoFMIs6KR/peyxo5QfZ8NZDVYnHVJq4yuslGe3B5SgyO/nBZNTL49rbHSykbff4uOzwFBNYL7AsCa/bez/tNTV2SXcfJVAEp0g9JdVp26lu5Rcpu40jslUS1SDvHQtHUgsfgd9NQeYFc9vY7mfMu7sxwEbimNFh+tAexOgw++Gq17jO+7Pr0FZhfeGPP1iHLWAWYlr1+Qgff/aabP1z5LsSi5e9KzqeCj9KGIqO4xn0FHlVzUPJNdyuydrIOQ8ld1ARJ6MVsH7WcQQnP/OJrLgaoVT2mbHVyNa1Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com; dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=ku2cJz4o; dkim-atps=neutral; spf=pass (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org) smtp.mailfrom=manguebit.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.a=rsa-sha256 header.s=dkim header.b=ku2cJz4o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.org (client-ip=143.255.12.172; helo=mx1.manguebit.org; envelope-from=pc@manguebit.org; receiver=lists.ozlabs.org)
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjmXF5JKLz2ySY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 05:39:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Sender:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=TCGm0nfvvy8Bnnpu5UWLIv7a/i53kn4C96IdqEjuOQc=; b=ku2cJz4o03JZhzhabC4ZS5XbZC
	8fH607SCqVF/YqtrusQ/G5FiG6gH1ajZx6cWgIFhW28kni4tJQct4RMgQn8dGRVZ1RN5Jse7vYmZf
	5d/os5vwEEuzHvfwVrVTc1ieO8ke+ivEj4m7QlAcf7wpkzbK1Jaz14/FR5wwoZKBGcKBiJpKNxIBA
	rwboQIKnYYfrjgvzfIj6gnW9K4GURLcYJODzbaH3GEGOIgChMG037qjdVMrGf+pdJHSj0knj3XJCj
	krzS92CQw5XYUHB4MVUnLZjm1yudidhzLUXsJXW52+cN57wlHUxvXKOdG/xxQS1kHTOJegmhMePBP
	FnrnG4EQ==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YZf-00000001nrA-1k06;
	Sat, 28 Mar 2026 15:39:55 -0300
Message-ID: <5ada775e751c32368a012f1d17c5323a@manguebit.com>
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
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 12/26] iov_iter: Add a segmented queue of bio_vec[]
In-Reply-To: <20260326104544.509518-13-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-13-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:39:55 -0300
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3070-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pc@manguebit.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,infradead.org:email,manguebit.org:dkim,manguebit.org:email,manguebit.com:mid,linux.dev:email,kernel.dk:email]
X-Rspamd-Queue-Id: C362F34FA7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> Add the concept of a segmented queue of bio_vec[] arrays.  This allows an
> indefinite quantity of elements to be handled and allows things like
> network filesystems and crypto drivers to glue bits on the ends without
> having to reallocate the array.
>
> The bvecq struct that defines each segment also carries capacity/usage
> information along with flags indicating whether the constituent memory
> regions need freeing or unpinning and the file position of the first
> element in a segment.  The bvecq structs are refcounted to allow a queue to
> be extracted in batches and split between a number of subrequests.
>
> The bvecq can have the bio_vec[] it manages allocated in with it, but this
> is not required.  A flag is provided for if this is the case as comparing
> ->bv to ->__bv is not sufficient to detect this case.
>
> Add an iterator type ITER_BVECQ for it.  This is intended to replace
> ITER_FOLIOQ (and ITER_XARRAY).
>
> Note that the prev pointer is only really needed for iov_iter_revert() and
> could be dispensed with if struct iov_iter contained the head information
> as well as the current point.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/bvecq.h      |  46 ++++++
>  include/linux/iov_iter.h   |  63 +++++++-
>  include/linux/uio.h        |  11 ++
>  lib/iov_iter.c             | 288 ++++++++++++++++++++++++++++++++++++-
>  lib/scatterlist.c          |  66 +++++++++
>  lib/tests/kunit_iov_iter.c | 180 +++++++++++++++++++++++
>  6 files changed, 649 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/bvecq.h

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

