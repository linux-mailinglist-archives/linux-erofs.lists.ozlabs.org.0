Return-Path: <linux-erofs+bounces-632-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81779B06CDB
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 06:55:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhkJQ518kz30T0;
	Wed, 16 Jul 2025 14:55:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752641718;
	cv=none; b=Xb2XMVqHVMhKxHGCs/maKlmWR6UkjXj8qRd4gNT/iK1o3ZkpvC//hfHgGryOXSeTP5fQkgLJjcnG02oVYBn/Ic7qVT3P+AT4ecF2mi9gaDrNBuDnFfkChr+BNydJKip9T+hsVYkdQb99wFCu2IiFRlIbtPhmBzEAJU8XW6Rov0uxlckS+baOOVycAkCcKeaATYWqcNkdicYFKifxsMgDh2CMBjcyebOBwVHNkV0Zla+9Pc8ARgtoQSTJx0cEyaTlQJDFn2kRJrq42UmE9jCO3IFKQ6+3UILwP6FGWMAPR5RCVUiNJU20RYppVW2hz5CdBarkmgFjSOaXM5jQ6RBAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752641718; c=relaxed/relaxed;
	bh=KUlf376OMv1XrkJW2oCmSZAdKifpL8InJUYTeCpUwoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I1w5lVLsfSIA9xRKChYF7ODkxdkZs53/8CBHNoAUhQDeJ/yJX/9OT0Oah8lgKyUnPjDPFLTtc3+5B0NJwkyVmAbA/LTAyC6JG9qsNN3fJ1/oY8zLYQvpKipIWHf/Spa0o/37JtiKv14ruC04NtWD4vRStXNVXAB7Is1CPHV2dd5CZnjH7Dqw2lwfYiX/yPhpZSRtfkmrL0niuBArI0Gx7kvX9hR8vzH7MWBgaHaZajRYATF3sCSjK2mCO6hftB47KP8jSz6lX0gTM2FZjH/uBvW3NSDtyPOwOB54gGnsU9RiTBgaoR5K92pY/CcaOIK2fOzJt/CoI1Gs7gYkcR7/VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DXsXyNuM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DXsXyNuM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhkJN3yKxz2ySY
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 14:55:15 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3a54700a46eso3850568f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752641710; x=1753246510; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUlf376OMv1XrkJW2oCmSZAdKifpL8InJUYTeCpUwoM=;
        b=DXsXyNuMESIjftvgqRw5m+ej76QJFeqxi1uwvacP3gDEKVc1Psy220gjmIbHr7scY9
         tDOcK4q7QrSvco3yWdCmtLzi36ityh/XKElJU9ErbMbOSNwNTdInzjUIoa9zCQcB4gP2
         5EStV7JTn7w7fCxDxF7CpD1Mhzg9c+U//hNnq/Nupu/yIggOR0nkV/i/SkUH4aNOelYr
         7FISTUKiuOkqRYS52xjM3VIiYi3SdtRgZcgyoWAJYkPo6UUJfaQ6CrTPTb/xMu61N2Ml
         y3SgaaXr1qBhRqHT58JuMStrYpo/yUf1MOUs49v7OgtBNpjiDKq6ypWpl+Lsdn3OZhMw
         scTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641710; x=1753246510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUlf376OMv1XrkJW2oCmSZAdKifpL8InJUYTeCpUwoM=;
        b=Bk+9KVkcfOFO+wGN8KGgK0cK/ighQ10RtFdOib466tCaminfHPZHZQK3fbmWFntpgn
         s5Vouz79qsBAN8tRpApsOfEv4B7Hsw9aaMXWi+8GI/avtH5l0Ksi1dcx+0/KTGsx8JVJ
         9UDJMXnZILin6XhpmVcIn/PdHo9YB1h4SQXc7pFV8E+JWrO2r+p8hxffqv54wzFQQt6g
         4MvIpS1S+wYwNxEdAI9OLmLIF92Q6UyeGtVboOe4Tk0zWeCq71ZOlf7IOCufZbdc372i
         23GeYwl+orOvluPkLZhSRmkmKOzxlqTq5Rfn1pZTXmfv/gRYjMHPNcUHzRjFAb5D1BRT
         Ky8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuhE/hntVVh6bEJRFE32mynXNO3K5bEZhY9pGH5Ar0sEKpf3pU5SZCWvJp1QKMny7SZt8IrDakJQH42w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFlEN6jDe9w6l3raeBoBBxQ6pqnI1nn4KWW3Orx9Qxl6l91HDx
	H8LDCaaBaMVipyZqZgEMspgHesHJ1Unm7+e/HMu+UR3o3C4GU31lSs1laPwYLFZW+fQ=
X-Gm-Gg: ASbGncsHO7wMrWoUJHyc5uAwibxTeL5R2xWSmSoUFK0oKQa8uHa2DQA830N/9anVFeS
	eZnp0bYXQqVbPY08BGaQTastHLMQl/3Cu40EYGWMUkMamxBNV8lrHXE9AdwwhBClyRspDwBxm8F
	CxtCYNfQCgv7dj3sW79hgDZpZEIdJOljzl7feAhvJTuJ7qA6yWCQXp9RvPB0LEkRwTrdObbtK2+
	aIh0dgklcimrdMPPn4GPDe8yzTxiPGKsAPmResE2FDK50q4GBvICQVAuLDXeNl3uaDN2buWVRnV
	IpOk1B75zYIgcwKcXeIviAfJO4KnQ/mAlcCTssHdqEZYa+JkK2AdW6OJ7qoGMKW9jFS6WsCN9U5
	FbxBIkNEcnZnRIJQM+RJx2Z5FxbwDNmnI7LlQTlgTNgypi0q7qA==
X-Google-Smtp-Source: AGHT+IGQoacjNokIlv9kK4wCibwhRBT2cyuhZxnrQDEDj6ZSWUyIJyb34LpzcuPXzslTfEZGpbv7Yw==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr1041332f8f.18.1752641709469;
        Tue, 15 Jul 2025 21:55:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ec6b4cda5sm11051963b3a.108.2025.07.15.21.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 21:55:08 -0700 (PDT)
Message-ID: <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
Date: Wed, 16 Jul 2025 14:24:58 +0930
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
 <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



在 2025/7/16 10:46, Gao Xiang 写道:
> ...
> 
>>
>>>
>>> There's some discrepancy between filesystems whether you need scratch
>>> space for decompression.  Some filesystems read the compressed data into
>>> the pagecache and decompress in-place, while other filesystems read the
>>> compressed data into scratch pages and decompress into the page cache.
>>
>> Btrfs goes the scratch pages way. Decompression in-place looks a 
>> little tricky to me. E.g. what if there is only one compressed page, 
>> and it decompressed to 4 pages.
> 
> Decompression in-place mainly optimizes full decompression (so that CPU
> cache line won't be polluted by temporary buffers either), in fact,
> EROFS supports the hybird way.
> 
>>
>> Won't the plaintext over-write the compressed data halfway?
> 
> Personally I'm very familiar with LZ4, LZMA, and DEFLATE
> algorithm internals, and I also have experience to build LZMA,
> DEFLATE compressors.
> 
> It's totally workable for LZ4, in short it will read the compressed
> data at the end of the decompressed buffers, and the proper margin
> can make this almost always succeed.

I guess that's why btrfs can not go that way.

Due to data COW, we're totally possible to hit a case that we only want 
to read out one single plaintext block from a compressed data extent 
(the compressed size can even be larger than one block).

In that case such in-place decompression will definitely not work.

[...]

>> All the decompression/compression routines all support swapping input/ 
>> output buffer when one of them is full.
>> So kmap_local() is completely feasible.
> 
> I think one of the btrfs supported algorithm LZO is not,

It is, the tricky part is btrfs is implementing its own TLV structure 
for LZO compression.

And btrfs does extra padding to ensure no TLV (compressed data + header) 
structure will cross block boundary.

So btrfs LZO compression is still able to swap out input/output halfway, 
mostly due to the btrfs' specific design.

Thanks,
Qu

> because the
> fastest LZ77-family algorithms like LZ4, LZO just operates on virtual
> consecutive buffers and treat the decompressed buffer as LZ77 sliding
> window.
> 
> So that either you need to allocate another temporary consecutive
> buffer (I believe that is what btrfs does) or use vmap() approach,
> EROFS is interested in the vmap() one.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> So, my proposal is that filesystems tell the page cache that their 
>>> minimum
>>> folio size is the compression block size.  That seems to be around 64k,
>>> so not an unreasonable minimum allocation size.  That removes all the
>>> extra code in filesystems to allocate extra memory in the page cache.
>>> It means we don't attempt to track dirtiness at a sub-folio granularity
>>> (there's no point, we have to write back the entire compressed bock
>>> at once).  We also get a single virtually contiguous block ... if you're
>>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>>> vmap_file() which would give us a virtually contiguous chunk of memory
>>> (and could be trivially turned into a noop for the case of trying to
>>> vmap a single large folio).
>>>
>>>
> 


