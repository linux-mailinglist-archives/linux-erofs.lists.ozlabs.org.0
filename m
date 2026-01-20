Return-Path: <linux-erofs+bounces-2072-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF546D3C048
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 08:25:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwJkW1xV0z2xSN;
	Tue, 20 Jan 2026 18:25:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768893907;
	cv=none; b=Bj5BeEehJaXLttLzD8EGmAD/EHV22fpHFy4BxO2Xstqn4vHBW9NWjsnfJ6xE0DLq7Nog8IBmdpwFr+8jlPIxWKYTap6h7uthVayy4ZvskcAd3kvnCpjQRKYKsTd5fxAAmEs2QCd3G1BC1JSFbUsNFSTK9tvyqhMN6WUiEDLOUfqwW7662oaMQ6cXWrOcIV5KwGrM99KAYaStiO2lFuIItTEIfV5RnGRPyh+7uZeJFl1U4cykQGcwhGuLeYgv+cpmAdIjtgTcNS3xSpx5bJHcfCtEqt6uh/sdxbZWyQbD3zsbJr1eLhgi48c3YuZXC/844zQXJ1KwQXscHVLNukwh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768893907; c=relaxed/relaxed;
	bh=IgKaAzP8aAUp7Q4dUR0XSmPEfcD1EN7TQ/AQjpmO9tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgxzirNXotV2qU2x7C76euL9H8H6SCd2zs0qiov02OZHwLK0PJbruOPXtzqcKU9REj/1M5R0YRPzqbiWwUCMkhy8z9a2NMMJ+VEjaQU/U3MXS0yhiQt2r7f2cAVYDzDyHXpeTOgJapcFaUVmR0QdwAL8aJOpdTqjO3SYXZ30cNcAr2smVOlps4Ao+axI5AAKyHyN+8ORAqY4tc+byL0b0FvGooXYzyk/W+H2IlyJPqSGZkutHxYolZ0IwsKaVhqjyAAIAL93/Xj2nqVa8t4a8iEYys+spqvwrUjLkQtiHcG1YFU3v+GR8utlUJ89uOjPVMc/ghcWp5PhIe09ucxBUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uwpsqsRh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uwpsqsRh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwJkQ53lyz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 18:25:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768893888; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IgKaAzP8aAUp7Q4dUR0XSmPEfcD1EN7TQ/AQjpmO9tw=;
	b=uwpsqsRhMncZZ9hkMJLFHV+1x8Go/Q+OwDNggiZlbA6y/iXOU+t+trlH7iD2ByhR5CLxc4kr8wFfxpJW3PDGHQkjdNgFZeX+7XClMF+TB8aQSN9xojmqzEbo6QEOa6HhgGti4NxVbsPJ+KY3+YgcQKUjXReurF1OhqNvltXaGXw=
Received: from 30.221.131.31(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxTW.ah_1768893562 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Jan 2026 15:19:23 +0800
Message-ID: <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com>
Date: Tue, 20 Jan 2026 15:19:21 +0800
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
References: <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
 <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
 <20260119092220.GA9140@lst.de>
 <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com>
 <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
 <20260120065242.GA3436@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260120065242.GA3436@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

Thanks for the reply.

On 2026/1/20 14:52, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
>>
>> Hi Christoph,
>>
>> Sorry I didn't phrase things clearly earlier, but I'd still
>> like to explain the whole idea, as this feature is clearly
>> useful for containerization. I hope we can reach agreement
>> on the page cache sharing feature: Christian agreed on this
>> feature (and I hope still):
>>
>> https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner
> 
> He has to ultimatively decide.  I do have an uneasy feeling about this.
> It's not super informed as I can keep up, and I'm not the one in charge,
> but I hope it is helpful to share my perspective.
> 
>> First, let's separate this feature from mounting in user
>> namespaces (i.e., unprivileged mounts), because this feature
>> is designed specifically for privileged mounts.
> 
> Ok.
> 
>> The EROFS page cache sharing feature stems from a current
>> limitation in the page cache: a file-based folio cannot be
>> shared across different inode mappings (or the different
>> page index within the same mapping; If this limitation
>> were resolved, we could implement a finer-grained page
>> cache sharing mechanism at the folio level). As you may
>> know, this patchset dates back to 2023,
> 
> I didn't..
> 
>> and as of 2026; I
>> still see no indication that the page cache infra will
>> change.
> 
> It will be very hard to change unless we move to physical indexing of
> the page cache, which has all kinds of downside.s

I'm not sure if it's really needed: I think the final
folio adaption plan is that folio can be dynamic
allocated? then why not keep multiple folios for a
physical memory, since folios are not order-0 anymore.

Using physical indexing sounds really inflexible on my
side, and it can be even regarded as a regression for me.

> 
>> So that let's face the reality: this feature introduces
>> on-disk xattrs called "fingerprints." --- Since they're
>> just xattrs, the EROFS on-disk format remains unchanged.
> 
> I think the concept of using a backing file of some sort for the shared
> pagecache (which I have no problem with at all), vs the imprecise

In that way (actually Jingbo worked that approach in 2023),
we have to keep the shared data physically contiguous and
even uncompressed, which cannot work for most cases.

On the other side, I do think `fingerprint` from design
is much like persistent NFS file handles in some aspect
(but I don't want to equal to that concept, but very
similar) for a single trusted domain, we should have to
deal with multiple filesystem sources and mark in a
unique way in a domain.

> selection through a free form fingerprint are quite different aspects,
> that could be easily separated.  I.e. one could easily imagine using
> the data path approach based purely on exact file system metadata.
> But that would of course not work with multiple images, which I think
> is a key feature here if I'm reading between the lines correctly.

EROFS works as golden immutable images, so especially,
remote filesystem images can and will only be used without
any modification.

So we have to deal with multiple filesystems on the same
machine, otherwise, _hardlinks_ in a single filesystem can
resolve most issues for page cache sharing, but that is not
our intention.

> 
>>   - Let's not focusing entirely on the random human bugs,
>>     because I think every practical subsystem should have bugs,
>>     the whole threat model focuses on the system design, and
>>     less code doesn't mean anything (buggy or even has system
>>     design flaw)
> 
> Yes, threats through malicious actors are much more intereating
> here.

Yes, otherwise we fail into endless meaningless rust and
code line comparsion without any useful real system
design part.

> 
>>   - EROFS only accesses the (meta)data from the source blobs
>>     specified at mount time, even with multi-device support:
>>
>>      mount -t erofs -odevice=[blob],device=[blob],... [source]
> 
> That is an important part that wasn't fully clear to me.

Okay,

Thanks,
Gao Xiang



