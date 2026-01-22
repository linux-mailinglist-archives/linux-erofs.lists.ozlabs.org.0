Return-Path: <linux-erofs+bounces-2133-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K1dA9PgcWk+MgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2133-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 09:33:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBC26321D
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 09:33:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZ8H0sJrz2yFm;
	Thu, 22 Jan 2026 19:33:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769070799;
	cv=none; b=TVWWhBfaLcRewccXrix7uIPkMf9JwNQ/1lwFNhyXrBgJ5bP6sfg14cDF2VBX7lkKxvtakLka6NCroAssKSKWPYYS6/Bb7JgyCHGfPk9qtwOwwWkXtcKamuL02AJwAZgtc33ppCJfUGmn78UUD0mO+NTkQ4jwxt2DbjB5sqrR+2TLVHYFNSqJD40R6mTlaeGbfEKaUfrfaopeo7fTrl6zT5PbSunh0F4yWzqDvgq4nwP/Ax8StMLMzeMjREDadV4ASZvgFWT8goJNRHX7CxFOfT5kU4Y1e7HfApwqv5fO67hynQY/oeKgsuY4QOA0lK0zSpJHTgQJz8EDOPrQl2dnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769070799; c=relaxed/relaxed;
	bh=cUoCZ/yPHd1Cmv2T8GhVS6WPmxJlXtwAz38Ylt51ijY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az/8j2Aaecg8EMmnP8qXtUBTN/qeYUiZDhOKcqVH8Q7HZvGIuJ+5yE3Rv4JVb41QzLhaBwG1P/vtmgu8ooRyxOFvt913hmvmzveMi0xcKkCiJlvikAqn6L8/NcNBjK5WMHPy0cY0nF8+lb8IkKP2KG2/eMW3IskAplUnqwoqtn9RTqSR2ZtqDLseu2mbGmof6NgRTArw6avNgB3d9Z9IRxFRDjeSH/3m06I9sm0HtVK9NLwxgR93OpZwzRwLrd5OB3nAr28KKWv2oLIqPOtlf44/xAbvkIdYj9QJ+wsJFeEa8j/WR+nwIsacYx9kdqY666fjGFjKP8wYXcdqhr1BEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZ8F6BtJz2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 19:33:16 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2E6B227AB6; Thu, 22 Jan 2026 09:33:10 +0100 (CET)
Date: Thu, 22 Jan 2026 09:33:10 +0100
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
Message-ID: <20260122083310.GA27928@lst.de>
References: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com> <20260120065242.GA3436@lst.de> <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
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
In-Reply-To: <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@lst.de,m:lihongbo22@huawei.com,m:chao@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2133-lists,linux-erofs=lfdr.de];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lst.de,huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 8EBC26321D
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:19:21PM +0800, Gao Xiang wrote:
>> It will be very hard to change unless we move to physical indexing of
>> the page cache, which has all kinds of downside.s
>
> I'm not sure if it's really needed: I think the final
> folio adaption plan is that folio can be dynamic
> allocated? then why not keep multiple folios for a
> physical memory, since folios are not order-0 anymore.

Having multiple folios for the same piece of memory can't work,
at we'd have unsynchronized state.

> Using physical indexing sounds really inflexible on my
> side, and it can be even regarded as a regression for me.

I'm absolutely not arguing for that..

>>> So that let's face the reality: this feature introduces
>>> on-disk xattrs called "fingerprints." --- Since they're
>>> just xattrs, the EROFS on-disk format remains unchanged.
>>
>> I think the concept of using a backing file of some sort for the shared
>> pagecache (which I have no problem with at all), vs the imprecise
>
> In that way (actually Jingbo worked that approach in 2023),
> we have to keep the shared data physically contiguous and
> even uncompressed, which cannot work for most cases.

Why does that matter?

> On the other side, I do think `fingerprint` from design
> is much like persistent NFS file handles in some aspect
> (but I don't want to equal to that concept, but very
> similar) for a single trusted domain, we should have to
> deal with multiple filesystem sources and mark in a
> unique way in a domain.

I don't really thing they are similar in any way.


