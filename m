Return-Path: <linux-erofs+bounces-629-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F54B06AF6
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 02:57:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhd1w6k9vz30T9;
	Wed, 16 Jul 2025 10:57:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752627444;
	cv=none; b=S6qPrj5pajXE8S11vdkHo49R0+coVbBKx5NWApXN60B4EX1gdUbbBeNb/9cn3xNoCq8b4daztWCT+3jKq6DekovgO4G8x+P3kdl+SsiiCPWs1rLo5zVEC9BNUTWVJNeeicpZsvF20lwhuFt9KQuoC505K6B3RVX/c/YsRlV73ovQtQpEINHnePlI+oRP+mRnzoaYGXnacFJqn8WTXee5ESppr3eyYLciwcsa7TT3sch0Ls3O9iLaXZ0i/oV1G37LwR3edwLeqUvGj6ZbKAWcCDYN8emvtgprLBRBMYbvFDLRMLBAiq+zsOek/ltaT48vwyWIDLfziLjxUzCpgXoAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752627444; c=relaxed/relaxed;
	bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mVF7JLBlxLVi9loUhTZHgREtaBbdQpNX04xbXhisPIbOjHUUHqIdrceiFWyhyxyUZ+6KgTOlYVurpiMbDpELA3obxIO8vccUj/hOLQ4naE2VlDvthJ6ETM+mJKuXNjePiBEg07xJbqKg3qxpRCflOc9ptkRMBD1tyWNuXnVH3UnFKKJxL7gPYStM6Nkrz7joPVq6qNhL1P8ycAqUieXycPyHVPIrK1UBrlPm4VybAf5pVtqRhEdW9un76XbDMGbInMH2GpKcQJcwEbkR2pej7UL90OuzSQoTJzLfyr1n7X4PYFwwRm/9rBqi4Su59jh6+ArfIpTaKoSKVv6xhIlX+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=H4TRf+Ii; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=H4TRf+Ii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=wqu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhd1v0xM6z30T8
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 10:57:21 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3a54690d369so4900289f8f.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752627436; x=1753232236; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=H4TRf+IizoCHvM2j26lGtKUGQLSzWq+uy0KA4PsFfsNgtZKab5+eTBABfuDgf6moqa
         Sy1qGTYl74Jba7K4IKCEjB/7kNq9MXMxznBJ9WaHFTTbh397pYyHBIQwHYnGZZEP++ya
         QZasexYovj9bfUifGxtjKP/cVgv0do0+G4dAjeWs/Bn7kFoTtzr3KveC44U1empHBpVw
         kLLquNlMh//klwJd+sCyRgWSnMTZYLzefy9iF9ouiSs8e35Goq+M3N/kxLTJxKy2oole
         6tqukzOC3ehG78EKdB7fbVj35/h12EZIs+7dqP/sMqiKf4Bp7TmYtOQAV3wr6sKEWv12
         MY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627436; x=1753232236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=oMZKwrA4Qn6q5rfcNng5aiWhjeET4VrEsJ/EkrwVHuvOUrIGgo+aZ8udefLEc2lWyW
         O1LO327pQz3NcWHFNUdBfV9LS43AwY6DbslAPx0hrNp+yZ7zvQpGJDLNhYzV8rYFfx3o
         yBaCDYI0U8sEkRrxaIJeHr57IeF2AONM9eNHnXskeci6Hz2tsBUZC2bhgS2SVXP+Bg6H
         +anRp2Cbb1Yd3pUXA90GE+Zi9FwgFCgUvDJ+OTtWo45YXgAq3wyBq9benJoMeIeIhG9I
         dT8OYYpivfR9G9WWbOiW7scb+ujuwTFL02IISyV6wAQ7EdmxwAkS4TEgVeWokBcS7LYQ
         EdIA==
X-Forwarded-Encrypted: i=1; AJvYcCXA9YFlKsSprI2NQ0R0nSxe5546ZRCGd2GEaD9mdEm0xEL3vWP7X+RXuY9jvEdVBGwrmfcHWNX2gO4EmA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIVU23fMtkcbopvlvFrNhPMMAATOnKBIOlxBnrJrZYhiQlDAgT
	5pRWZaQl7FzoYlB7nlh+FkuPIb1kU+NaRkH22JgRBfEHW1JmELdFs/fc1wteGrC96+E=
X-Gm-Gg: ASbGncvkWxqNYVv33mMKf2SCsIFZ3ebyVxfbB0ChC5NvtXSXMQhYxvBbnllvYBdihAk
	iq4ZeJJx4VqHpjxMIgugUX2BUTYaMBIseZdCV1rdsptu++pSsF5BRxLDxjuq9qfM1RxcE7vkiFL
	42zJhelWpdI/1BnEyGU9Y8S64zH8tsINH4vP+plS3DhfyVmL7Y79D3iCyGhhaMiOSWzjSoOj71M
	NPa4JoHk1iqEiyH6Kt1ds88grw6YeDDn5Ezpn+j96NAnTzPGoxAUjQHJO+lzuJAH+EfUDDtFhmM
	wEF1XKbv5m9Gt05rtcjPpjMd4Vs8F6MpHgyYSi4kOJ/EBQPPhiK0a3UGTOer9I27IHf3kRsVrJ8
	lm7lgyEOmZ2FTeN9Q35hBRYDHTpea50rMcOvl9LmHwqMaO+xLsA==
X-Google-Smtp-Source: AGHT+IGmM0n20dxhtQ6vMPJL8jS+hYaNOO5Rpe4CXLe7RvspyCFw9ZMsMSHoEA6/McxI5CdSoNbUKg==
X-Received: by 2002:a05:6000:3ce:b0:3b6:d6d:dd2 with SMTP id ffacd0b85a97d-3b60e4cb532mr348001f8f.25.1752627436011;
        Tue, 15 Jul 2025 17:57:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332cdcsm114942995ad.145.2025.07.15.17.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 17:57:15 -0700 (PDT)
Message-ID: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
Date: Wed, 16 Jul 2025 10:27:05 +0930
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
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
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
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



在 2025/7/16 06:10, Matthew Wilcox 写道:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

I don't think it's the case for btrfs, unless your "fixed-size" means 
block size, and in that case, a single block won't be compressed at all...

In btrfs, we support compressing the plaintext from 2 blocks to 128KiB 
(the 128KiB limit is an artificial one).

> 
>  From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.

We don't. We just grab dirty pages up to 128KiB, and we can handle 
smaller ranges, as small as two blocks.

> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.

Btrfs goes the scratch pages way. Decompression in-place looks a little 
tricky to me. E.g. what if there is only one compressed page, and it 
decompressed to 4 pages.

Won't the plaintext over-write the compressed data halfway?

> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.

Btrfs is the later case.

All the decompression/compression routines all support swapping 
input/output buffer when one of them is full.
So kmap_local() is completely feasible.

Thanks,
Qu

> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 
> 


