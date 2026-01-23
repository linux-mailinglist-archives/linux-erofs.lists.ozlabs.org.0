Return-Path: <linux-erofs+bounces-2205-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKgfDwYOc2ntrwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2205-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 06:58:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85D70A51
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 06:58:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy6g619RRz2xHt;
	Fri, 23 Jan 2026 16:58:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769147906;
	cv=none; b=KSWpkg/curZ3F9QMaWwkn2NS5R0SgpI1ff5ofqezib/fbUWCUySWFqTk+opTOSUAiqt0i7o91blwTsVYBD6LSjkbADklsu0fd4iu3REOu+O91TM4j/XDP/KDZx9BpB5qkHf0v5CG/L1XA+NucAyaMLMmgNzWTm9ewAb70yag9Xfwabk+bkKNvD5GPtOODalk1qZ1DgOYJJ0QURLD3MvlP+E5IjuBYLSkBb1IcvLJUt4jWIdMLym0B31JZSljFh1pDStZ9zxMc6sQ4KQrfM8T0j7c2QKcqZSbjUfPbCw1+cEfG5NaKWZ18LQsOQUikAfM6fjgYy81QqToM6LobBQAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769147906; c=relaxed/relaxed;
	bh=qgiEgvnwbNmHMoJ9+JISig9U0fmQoZ1zNWWDsz5ZOb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSMWcMKM2hC+U4bSFtf3Nfaw4pKrr2T1We8QlEmw5p3l1wh85joS0HKAGWmUUGcCDcT+j9KFx3W6YKWtE2pxUjr7axh9ZTRKWj+LuJaDy3qZmwH2HUOYn4bEGZBTFiqvJtBJzOQDigLgiP47v1UnU8KykIcWHkljag+OfcbRncY3iA1av9WJhXj8xABd2UojJPmm7/fI81qt+Pv/ALj2pJY6Ufm3+m4EqyWfHfz9nfinA4Qm9epB1PiA6aH0pvMqlUttF3103pknW2w//yYmpUYRLX4GH2DEIKVqYBn6B4U2VNTTi9Km9n+hGAvyoSzvP9v3GsU/kXhitANhLKhIUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HLI9Gd2S; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HLI9Gd2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy6g22CBPz2x9M
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 16:58:19 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769147893; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qgiEgvnwbNmHMoJ9+JISig9U0fmQoZ1zNWWDsz5ZOb4=;
	b=HLI9Gd2SVtOOz7EQCQwve9FXfpm+98VEIAv5E7yB7ltfRrRtOu9fNllRFzd9Z8qC5BXjgpQHUSMhGb9WVxR/+qCR2o8bBSs48/1zYk+FkR2GcFZ9YRl5WcphB75TYeoxQlYW6XNxcJFHpbnHguZROYPAp/sG4HbOZbDEw+Bc3AE=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxehcdl_1769147891 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 13:58:12 +0800
Message-ID: <aa71c034-abf1-4861-8440-e327e535ed7e@linux.alibaba.com>
Date: Fri, 23 Jan 2026 13:58:11 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, oliver.yang@linux.alibaba.com
References: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
 <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
 <20260122083310.GA27928@lst.de>
 <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
 <20260123053936.GA24828@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260123053936.GA24828@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2205-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:lihongbo22@huawei.com,m:chao@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.619];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CC85D70A51
X-Rspamd-Action: no action



On 2026/1/23 13:39, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 04:40:56PM +0800, Gao Xiang wrote:
>>> Having multiple folios for the same piece of memory can't work,
>>> at we'd have unsynchronized state.
>>
>> Why not just left unsynchronized state in a unique way,
>> but just left mapping + indexing seperated.
> 
> That would not just require allocating the folios dynamically, but most
> importantly splitting it up.  We'd then also need to find a way to chain
> the folio_link structures from the main folio.  I'm not going to see this
> might not happen, but it feels very far out there and might have all
> kinds of issues.

I can see the way, but at least I don't have any resource,
and I'm even not sure it will happen in the foresee future,
so that is why we will not wait for per-folio sharing
anymore (memory is already becoming $$$$$$..).

> 
>>>>> I think the concept of using a backing file of some sort for the shared
>>>>> pagecache (which I have no problem with at all), vs the imprecise
>>>>
>>>> In that way (actually Jingbo worked that approach in 2023),
>>>> we have to keep the shared data physically contiguous and
>>>> even uncompressed, which cannot work for most cases.
>>>
>>> Why does that matter?
>>
>> Sorry then, I think I don't get the point, but we really
>> need this for the complete page cache sharing on the
>> single physical machine.
> 
> Why do you need physically contigous space to share it that way?

Yes, it won't be necessary, but the main goal is to share
various different filesystem images with consensus per-inode
content-addressable IDs, either secure hashs or per-inode UUIDs.

I still think it's very useful considering finer-grain page
cache sharing can only exist in our heads so I will go on use
this way for everyone to save memory (considering AI needs
too much memory and memory becomes more expensive.)

> 
>>>
>>>> On the other side, I do think `fingerprint` from design
>>>> is much like persistent NFS file handles in some aspect
>>>> (but I don't want to equal to that concept, but very
>>>> similar) for a single trusted domain, we should have to
>>>> deal with multiple filesystem sources and mark in a
>>>> unique way in a domain.
>>>
>>> I don't really thing they are similar in any way.
>>
>> Why they are not similiar, you still need persistent IDs
>> in inodes for multiple fses, if there are a
>> content-addressable immutable filesystems working in
>> inodes, they could just use inode hashs as file handles
>> instead of inode numbers + generations.
> 
> Sure, if they are well defined, cryptographically secure hashes.  But

EROFS is a golden image filesystem generated purely in
userspace, vendors will use secure hashs or
per-vendor-generated per-inode UUID.

> that's different from file handles, which don't address content at all,
> but are just a handle to given file that bypasses the path lookup.

I agree, so I once said _somewhat_ similar.  Considering
content-addressable filesystems, of course they could use
simplifed secure hashs as file handles in some form.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>> Gao Xiang
> ---end quoted text---


