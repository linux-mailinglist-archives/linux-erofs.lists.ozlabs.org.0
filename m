Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB819872BD
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 13:23:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDrnn47tTz2ykX
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 21:23:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727349818;
	cv=none; b=JlWdLdYkvT0Gl3r4jTvoMXykBzOZlabPqPt3QuxicWG8X16cbIaW6xvpJeYZDYYHquHWi/YdS493ywEoKJ8OscBpi9Inf3VxlNWf+oJC4zk9Kur6EQvZnC5m2nuE9R392PfFLvX8qLGmQq/kN9SIZAXZX5xqg+jQt70d9Htvf35scqOJscCtG4gEPQuTj6asgzPmsYpV9zbOgIPwHyev/N1EckhU5TKZjefMb6iusQS5vtn0f7mHfVIf3dqMNq4E/gkp4rHtbudXFykCTrVsgo34Typ29hmqrl1zvfOJTDLYIHlODske7HbVjWtc92A8Q5QIu1nM6KyGLy2dllu6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727349818; c=relaxed/relaxed;
	bh=52Hd22cyMQE0xicpF+br1DfVt8GaUc6LS4cJaudJCdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/2erw5DqEC1xMpg+iAJy5bjnvV5hMZ/1FoOBaUlG3Sn7pDMAGXZOZUAb1OobbWKilJ4ROKEOf91LvsZgEm74UHk2Kq14Y9I0vv8/+vUl3DFq22SXnsWPZWhLlnXPkZEzt8AN6TvufJt62WupCAVUAbCBoa1GSMuhYwx2XwGi6V+jmG0A9ZswijwZCX7ZtIQkBqv7DI0IbcMYxc45I+ZcCkZCWtzUsB9EmwxdKps7dOmFAtmYil4YKlb+H6vDhE4VNl26SlLJDv719hYqKM6EANwl3xXwDFARqQfKTgo0w3dNKdZ6RgjWEGtZD8Dhku3J2oS8TX5c1brScBhC/elTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S8YB934G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=S8YB934G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDrnh2rC3z2xGs
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 21:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727349808; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=52Hd22cyMQE0xicpF+br1DfVt8GaUc6LS4cJaudJCdk=;
	b=S8YB934GS2UYCT3i1ugXs6Wx2zPU0p9cYvaWhYOoFPGHVz4TApPr/mxtBNy5cXvfvGr1is1GyWQP/Wq1hpNLr0XYNxpqxCPzV2DK/21AauFiqxua+rEHbM+2YvWc4xDJ6g2rn0bgnwgmpbEiXJR1bS9TsbMwsWbDvQY5KVQKQuI=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFnG64q_1727349806)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 19:23:27 +0800
Message-ID: <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
Date: Thu, 26 Sep 2024 19:23:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
References: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Benno Lossin <benno.lossin@proton.me>, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/26 19:01, Ariel Miculas via Linux-erofs wrote:
> On 24/09/26 06:46, Gao Xiang wrote:

...

>>
>>>
>>>>
>>>> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
>>>> Compressed OCI (tar.gz)	282.5	28.3	63%
>>>> Uncompressed OCI (tar)	766.1	76.6	0%
>>>> Uncomprssed EROFS	109.5	11.0	86%
>>>> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
>>>> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
>>>>
>>>> I don't know which compression algorithm are you using (maybe Zstd?),
>>>> but from the result is
>>>>     EROFS (LZ4HC,12,64k)  54.2
>>>>     PuzzleFS compressed   53?
>>>>     EROFS (DEFLATE,9,32k) 46.4
>>>>
>>>> I could reran with EROFS + Zstd, but it should be smaller. This feature
>>>> has been supported since Linux 6.1, thanks.
>>>
>>> The average layer size is very impressive for EROFS, great work.
>>> However, if we multiply the average layer size by 10, we get the total
>>> size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
>>> the average layer size is 30 MIB (for the compressed case), the unified
>>> size is only 53 MiB. So this tells me there's blob sharing between the
>>> different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
>>> with EROFS (what I'm talking about is deduplication across the multiple
>>> versions of Ubuntu Jammy and not within one single version).
>>
>> Don't make me wrong, I don't think you got the point.
>>
>> First, what you asked was `I'm referring specifically to this
>> comment: "EROFS already supports variable-sized chunks + CDC"`,
>> so I clearly answered with the result of compressed data global
>> deduplication with CDC.
>>
>> Here both EROFS and Squashfs compresses 10 Ubuntu images into
>> one image for fair comparsion to show the benefit of CDC, so
> 
> It might be a fair comparison, but that's not how container images are
> distributed. You're trying to argue that I should just use EROFS and I'm

First, OCI layer is just distributed like what I said.

For example, I could introduce some common blobs to keep
chunks as chunk dictionary.   And then the each image
will be just some index, and all data will be
deduplicated.  That is also what Nydus works.

> showing you that EROFS doesn't currently support the functionality
> provided by PuzzleFS: the deduplication across multiple images.

No, EROFS supports external devices/blobs to keep a lot of
chunks too (as dictionary to share data among images), but
clearly it has the upper limit.

But PuzzleFS just treat each individual chunk as a seperate
file, that will cause unavoidable "open arbitary number of
files on reading, even in page fault context".

> 
>> I believe they basically equal to your `Unified size`s, so
>> the result is
>>
>> 			Your unified size
>> 	EROFS (LZ4HC,12,64k)  54.2
>> 	PuzzleFS compressed   53?
>> 	EROFS (DEFLATE,9,32k) 46.4
>>
>> That is why I used your 53 unified size to show EROFS is much
>> smaller than PuzzleFS.
>>
>> The reason why EROFS and SquashFS doesn't have the `Total Size`s
>> is just because we cannot store every individual chunk into some
>> seperate file.
> 
> Well storing individual chunks into separate files is the entire point
> of PuzzleFS.
> 
>>
>> Currently, I have seen no reason to open arbitary kernel files
>> (maybe hundreds due to large folio feature at once) in the page
>> fault context.  If I modified `mkfs.erofs` tool, I could give
>> some similar numbers, but I don't want to waste time now due
>> to `open arbitary kernel files in the page fault context`.
>>
>> As I said, if PuzzleFS finally upstream some work to open kernel
>> files in page fault context, I will definitely work out the same
>> feature for EROFS soon, but currently I don't do that just
>> because it's very controversal and no in-tree kernel filesystem
>> does that.
> 
> The PuzzleFS kernel filesystem driver is still in an early POC stage, so
> there's still a lot more work to be done.

I suggest that you could just ask FS/MM folks about this ("open
kernel files when reading in the page fault") first.

If they say "no", I suggest please don't waste on this anymore.

Thanks,
Gao Xiang
