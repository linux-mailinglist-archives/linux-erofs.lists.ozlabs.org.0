Return-Path: <linux-erofs+bounces-2204-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDxLBqMJc2mWrwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2204-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 06:39:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D2707BC
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 06:39:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy6FW6pVKz2x9M;
	Fri, 23 Jan 2026 16:39:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769146783;
	cv=none; b=hW+wGpY9ToXcnaELvQqbMq8LSqQNlGma6ahEWivH3i+wp/b5BaJubgRYtMfvOSQgZmu8NCdSktlynQ2ABwEIxzjC4/iiVvBg6pMfLGGnKnrD5DukwPC1fUopKZ+FLOHhi9L69ntrEXSt/czC9Y/80aJu1vwvwd5zY5+HARN/fod2EkxRrbnNGdxW1DZlGG+5zlx6GwG63wgCkTlYPcLSmcknW79i4cyM8S+maaVx2jCdkONQh5cSgOdpTZ+o/8g2Qp+k897tXhNGOyfbcew55Nb2tQY8hR/hCcFybBdUAKe+Mup0+DoTvW53U7V7o7R+P4bG9eSNEl4MU49jhVrAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769146783; c=relaxed/relaxed;
	bh=ne3zOY+gQEsSuwnxJ0zRWhIXzX36bKOow4t6rWOK9As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwHvRFba4Nc6EqNdCToI8XTuYAnuI29WqVAZeeXUeZys6mXUzY8uom2dsYfx4vdEUZugVMI6XFGg9R5PKrPDPy6k2n7qV0W3Yl4OktKQdP6dhAQj+C294Pqix5oOt8kjd0eCvhxK12mr6CuqUHKcAOpAqlzSfvFMGc/0YOo52iqlZpe5plLUDJghYUTyTJuqpt4HOI4QmldpO2dxX6xNjjRPEzcVd+f/UrLnaIgMeflmFYZi1EP9mcq5gF45xveZ+rWIhI43Pi8kR1fSpvjP7drMDMFKwkClqvnV6M28bPgVZxJ29ACHye8NuBkC8kwMctFM9sC1iay2/wvvfcGcbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy6FW0hXlz2xJ5
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 16:39:42 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02EAE227AAE; Fri, 23 Jan 2026 06:39:36 +0100 (CET)
Date: Fri, 23 Jan 2026 06:39:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260123053936.GA24828@lst.de>
References: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com> <20260120065242.GA3436@lst.de> <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com> <20260122083310.GA27928@lst.de> <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2204-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lst.de,huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@lst.de,m:lihongbo22@huawei.com,m:chao@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.063];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 377D2707BC
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:40:56PM +0800, Gao Xiang wrote:
>> Having multiple folios for the same piece of memory can't work,
>> at we'd have unsynchronized state.
>
> Why not just left unsynchronized state in a unique way,
> but just left mapping + indexing seperated.

That would not just require allocating the folios dynamically, but most
importantly splitting it up.  We'd then also need to find a way to chain
the folio_link structures from the main folio.  I'm not going to see this
might not happen, but it feels very far out there and might have all
kinds of issues.

>>>> I think the concept of using a backing file of some sort for the shared
>>>> pagecache (which I have no problem with at all), vs the imprecise
>>>
>>> In that way (actually Jingbo worked that approach in 2023),
>>> we have to keep the shared data physically contiguous and
>>> even uncompressed, which cannot work for most cases.
>>
>> Why does that matter?
>
> Sorry then, I think I don't get the point, but we really
> need this for the complete page cache sharing on the
> single physical machine.

Why do you need physically contigous space to share it that way?

>>
>>> On the other side, I do think `fingerprint` from design
>>> is much like persistent NFS file handles in some aspect
>>> (but I don't want to equal to that concept, but very
>>> similar) for a single trusted domain, we should have to
>>> deal with multiple filesystem sources and mark in a
>>> unique way in a domain.
>>
>> I don't really thing they are similar in any way.
>
> Why they are not similiar, you still need persistent IDs
> in inodes for multiple fses, if there are a
> content-addressable immutable filesystems working in
> inodes, they could just use inode hashs as file handles
> instead of inode numbers + generations.

Sure, if they are well defined, cryptographically secure hashes.  But
that's different from file handles, which don't address content at all,
but are just a handle to given file that bypasses the path lookup.

>
> Thanks,
> Gao Xiang
---end quoted text---

