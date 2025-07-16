Return-Path: <linux-erofs+bounces-630-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 376CFB06B08
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 03:16:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhdRv0LyCz30T9;
	Wed, 16 Jul 2025 11:16:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752628586;
	cv=none; b=gLN+b0wKiU1geQo9ZVvDoQy+XnnNuZOWOxAMFOpo49120apwbNHO08rd3O9FTewcJvqE+ptx0G52kkTnmd4bfFOgh0Lphft2xUshefLaugGQoGwpWWODAK4j5g95OPiRjv/HZb2zf/QnX69LwQFgU7B0mrXGtKQYIICqq0b53Hop4oUkbuoaOeyjcJY14r5xbECixCaEgKNVhsy3WHIwqM9Qq4m04wm2JPW5dIcV7YdIXjfEaLhuA9aMClTkB9wnvEZbhJfNvA05fxdNjTaU2xkI8gRNxKlsYZoBKnqoFUXmtP8Rjqs8Sz/IZ2Kkm6jLO6lwk31EYCF1VRmsZv3kww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752628586; c=relaxed/relaxed;
	bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=asG1O5m+3Ygw5wJqxqBujvmaRxpg1DdO/y0fS1VCaCfjeFpiCO0a4GslDOb7AJO43ln70nxYyDD87c/dg/VYIJtnc4bnY5k5T89vxgs6niBRb41E1jVAiYoyBlu/BXB54Z4we15Ag0lTm/t7x3qyR+Nq6YUtx4SLoTX/Hv2qXgORzMoVwRwsFMFpbjZE47RyGZsP/BksVR/onT9YLtOL7L9y/2Z4XZwzIC0etLXKJEKaRHiN67km1IcHNbkoYJumZUdJNOqGe04663D1ynbaXCdkfW/inBHZIVT8eqaL6Iin/BipuQ769ywb8XGizL1u2f1AC0ztgEKApy5I3HKavw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TF+gvzGg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TF+gvzGg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhdRr61Jyz30T8
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 11:16:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752628579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=;
	b=TF+gvzGg2d58lKvRZ2S5a+bvKJPJJOAMn0t2htCHO+6EWOmOXU+pWkxr6mqQ4MAG4c9+BG7+x8rV0Hkx6QG8+mlNJisUhHesMKQ1bx1VUN/xuMdMr3I9NErnOjpI2eBbUlLai9hkwyBPAzvCvvELnsXzFTz9wc1RmdAUvaPw1ek=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1sJXu_1752628575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 09:16:17 +0800
Message-ID: <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Date: Wed, 16 Jul 2025 09:16:14 +0800
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
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <wqu@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>,
 netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

...

> 
>>
>> There's some discrepancy between filesystems whether you need scratch
>> space for decompression.  Some filesystems read the compressed data into
>> the pagecache and decompress in-place, while other filesystems read the
>> compressed data into scratch pages and decompress into the page cache.
> 
> Btrfs goes the scratch pages way. Decompression in-place looks a little tricky to me. E.g. what if there is only one compressed page, and it decompressed to 4 pages.

Decompression in-place mainly optimizes full decompression (so that CPU
cache line won't be polluted by temporary buffers either), in fact,
EROFS supports the hybird way.

> 
> Won't the plaintext over-write the compressed data halfway?

Personally I'm very familiar with LZ4, LZMA, and DEFLATE
algorithm internals, and I also have experience to build LZMA,
DEFLATE compressors.

It's totally workable for LZ4, in short it will read the compressed
data at the end of the decompressed buffers, and the proper margin
can make this almost always succeed.  In practice, many Android
devices already use EROFS for almost 7 years and it works very well
to reduce extra memory overhead and help overall runtime performance.

In short, I don't think EROFS will change since it's already
optimal and gaining more and more users.

> 
>>
>> There also seems to be some discrepancy between filesystems whether the
>> decompression involves vmap() of all the memory allocated or whether the
>> decompression routines can handle doing kmap_local() on individual pages.
> 
> Btrfs is the later case.
> 
> All the decompression/compression routines all support swapping input/output buffer when one of them is full.
> So kmap_local() is completely feasible.

I think one of the btrfs supported algorithm LZO is not, because the
fastest LZ77-family algorithms like LZ4, LZO just operates on virtual
consecutive buffers and treat the decompressed buffer as LZ77 sliding
window.

So that either you need to allocate another temporary consecutive
buffer (I believe that is what btrfs does) or use vmap() approach,
EROFS is interested in the vmap() one.

Thanks,
Gao Xiang

> 
> Thanks,
> Qu
> 
>>
>> So, my proposal is that filesystems tell the page cache that their minimum
>> folio size is the compression block size.  That seems to be around 64k,
>> so not an unreasonable minimum allocation size.  That removes all the
>> extra code in filesystems to allocate extra memory in the page cache.
>> It means we don't attempt to track dirtiness at a sub-folio granularity
>> (there's no point, we have to write back the entire compressed bock
>> at once).  We also get a single virtually contiguous block ... if you're
>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>> vmap_file() which would give us a virtually contiguous chunk of memory
>> (and could be trivially turned into a noop for the case of trying to
>> vmap a single large folio).
>>
>>


