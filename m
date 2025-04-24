Return-Path: <linux-erofs+bounces-229-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C7A9ACBB
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 14:02:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zjvj644sMz3bpS;
	Thu, 24 Apr 2025 22:02:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745496122;
	cv=none; b=epkwy3Wz54kZ2jrzDjUwKBbC2Nxwq6Cmc0+loH/cJr/0W9EvFLEf213d3j1eB9e10N7ZcMtvFMTnI/uzp8gjybhsU8WZqSFEvFPwo1ruZV6bvUNhDqiLjMPBu6PZBZ2kOBjgKCaah/3TIBV4Su9s0TXEK+nNaWhB3U+2f7E2ZPfVCCXhkOorFU1R3LW1vRNvAucDhpDaqpmR1UsbUoaVr/M+Vp/jBUDeVr6gtkC570Oqym65NyDXiqCIxiyrRdxHKZgc+HWtAsEG9p47kJ4EQU2BlWuNFF2+1cqLa+GM67xKb+GPFJnU7Xr1UGRQOSVS7yv6Hslnm6mNizAvWR1ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745496122; c=relaxed/relaxed;
	bh=jEWEujvBUseKWtPgyTikCBEDnCiDZZvgtDeXnqe3SCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5nkxrvHs5Z2qW2zO7Abgxie4gwBoqu7ANNnIk3ZrN90CHVojTZ2fPfgPc1xxRfuGK25gfhTQvrJAwmVEc48EoOZa0rMNRkIJX7IFveEp7QdJnhYIdz7Vij8yTIBZvCPWsTVQpDT1+xvXXz3PJ7ew5jCHtpakNkvRe7JxpNesGvEu5Nq+uPxnfjtyAvWAeJFsfZzfSiUqE6G8hNKI4yg5c9pWduG4NadIRHZTIFRHicw1+FTZ9KDWEI63CW5EXHrONRW42fCSiTKiRnM+9iodcelms33HORp7FXNAJVSH+2Q7OOVa1E40SvKXYTD4ZZ2Iszr7rYx/sm85XaWkHJLLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YXA/CUJz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YXA/CUJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zjvj44Wnsz3bnL
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 22:01:59 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745496115; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jEWEujvBUseKWtPgyTikCBEDnCiDZZvgtDeXnqe3SCY=;
	b=YXA/CUJzrdeiiOZjRjGmv0wTXUCpNMt9UtyJWCPnS/Megmh+LDtvIXYLDbvtAYXBXNYIiqDsmF+2gnKKjZK9lzas8Q5IsH0TV98U7XHdQdDekGJjS3m6mAgcniipnkqHLVGA2aTmxTt1gJ96jZvExrDV5FX8gqUbhcYvU6cYxIM=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXzJhjX_1745496113 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 20:01:53 +0800
Message-ID: <001afbdc-27a7-4adf-abd7-21d1053ee399@linux.alibaba.com>
Date: Thu, 24 Apr 2025 20:01:53 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [question] Status of dictionary preload compression?
To: Simon Hosie <sh1efs@xn--tkuka-m3a3v.nz>
Cc: Linux Erofs <linux-erofs@lists.ozlabs.org>
References: <OOZ5vdV--F-9@xn--tkuka-m3a3v.nz>
 <8beeddff-816d-40ad-ae8b-a7c40748a59c@linux.alibaba.com>
 <OOaCwCu--F-9@xn--tkuka-m3a3v.nz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <OOaCwCu--F-9@xn--tkuka-m3a3v.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/24 13:14, Simon Hosie wrote:
> 23 Apr 2025, 17:27 by hsiangkao@linux.alibaba.com:
> 
>> Hi Simon,
>>
>> On 2025/4/24 03:24, Simon Hosie wrote:
>>
>>> I've struggled to determine if this is already a feature or in development or not (possibly because of overloading of the term "dictionary"), so I apologise in advance if the following brief is redundant:
>>>
>>> Compressors like LZ4, zstd, and even gzip talk about "dictionary compression" meaning to pre-load the history window of the compressor and decompressor, before the file is processed, with pre-arranged patterns; so that back references can be made for text the first time it appears in the file, rather than having to build up that window from an empty set at the beginning of the file by encoding everything as literals.
>>>
>>> This can lead to an improvement in compression ratio.
>>>
>>> It's generally only useful for small files because in a larger file the back-reference widow is established early and remains full of reference material for the rest of the file; but this should also benefit block-based compression which faces a loss of history at every entry point.
>>>
>>> So that's what I'm talking about; and my question, simply, is is this is a feature (or a planned feature) of erofs?  Something involving storing a set of uncompressed dictionary preload chunks within the filesystem which are then used as the starting dictionary when compressing and decompressing the small chunks of each file?
>>>
>>> In my imagination such a filesystem might provide a palette of uncompressed, and page-aligned, dictionaries and each file (or each cluster?) would give an index to the entry which it will use.  Typically that choice might be implied by the file type, but sometimes files can have different dispositions as you seek through them, or a .txt file may contain English or Chinese or ASCII art, each demanding different dictionaries.  Making the right choice is an external optimisation problem.
>>>
>>
>> Thanks for your interest.
>>
>> I know the dictionary compression (and the benefit for small
>> compression units as you said 4KiB compression) and it's on
>> our TODO list for years.
>>
>> Actually I made an erofs-utils dictionary compresion demo 4
>> years ago (but EROFS doesn't implement compression deduplication
>> at that time):
>> https://github.com/erofs/erofs-utils/tree/experimental-dictdemo
>>
>> The discussion part of this topic is the dictionary granularity:
>>   1) per-filesystem ?  I think it's almost useless, but it
>>   has least extra dictionary I/O.
>>   2) per-inode?
>>   3) per-(sub)inode?
>>
>> Since EROFS also supports compressed data deduplication (which
>> means a pcluster can be used for different parts of an inode or
>> different inodes), it makes the design for dictionary generation
>> (since some uncompressed data can be deduplicated) and selection
>> harder.
>>
>> If you have more ideas about the dictionary granularity and
>> the whole process, I'm very interested in hearing more.
>>
>> Thanks,
>> Gao Xiang
>>
> Ok, well the model I had in mind was to allocate maybe a few hundred kB of the filesystem image to various dictionaries optimised for different file types.  Some plain text dictionaries, a generic JSON dictionary, a generic XML dictionary, a shared object dictionary, etc..., and you enumerate those so that each file can choose the right dictionary using just a one-byte index into the table.
> 
> Hopefully an app will only work intensively with a couple of file types at a time so only a couple of dictionaries need be paged in at a time.
> My intuition tells me that diminishing returns will have set in well before 256 different dictionaries, and that having more than that would be mostly harmful; but I guess that's a thing which needs testing.
> I understand right now every file can specify a compression method for itself, so in that same data structure it makes sense to also specify the index number of the dictionary for the compression if the chosen compression method uses a dictionary.
> 
> By default mkfs would probably just look at the input files and a directory full of pre-cooked dictionaries, and based on the extension of the file and the availability of a matching dictionary it would put that dictionary in the next slot and mark all matching files as being compressed against that dictionary number.
> 
> Then the user can look at which sets of file types missed out on a dictionary and how much space they're using, and they can decide if they want to make another dictionary for those files as well, or just make them share a dictionary with another file type. Or maybe they want to split a group of files because they'll benefit from having different versions of a dictionary.  Or maybe they'll write their own optimiser to decide the optimal file groups by grinding on the problem with hundreds of GPUs for weeks on end.
> 
> If one file is particularly large it might warrant a dedicated dictionary, but I wouldn't plan for that as the general case.
> 
> Once those decisions have been finalised the dictionaries can be re-optimised against the actual files to get the best compression.
> 
> There's also the question of whether a file would want to select two or three small dictionaries to concatenate.  Like, for an XML file containing English tags and Chinese text, or something like that.  Or it might want to switch dictionaries halfway through the file.  That's probably over-engineering, though.
> 
> I think that's more or less all the things I've thought about the problem so far.

Ok, I know your idea on this. My overall thought is to get the
numbers and demo first, and then think more how to land this.
If you're interested in developping this, that's awesome!

BTW, one part I'm not sure if you noticed is that small files
(or even the whole files) can be moved to the virtual fragment
inode and compression together by using `-Efragments` (or even
`-Eall-fragments`) option.

So I think we have to develop sub-file dictionary support,
otherwise it will be conflict with fragment compression feature.

Thanks,
Gao Xiang

