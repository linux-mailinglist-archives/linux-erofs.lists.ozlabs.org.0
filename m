Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D69871EB
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 12:46:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDqzM6FmFz2yq4
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 20:46:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727347612;
	cv=none; b=fEW0oj5wAgHBNtV/a68YblbcPqmvULpes4h331tFovnfwA+U3brESfPTqdzGobs/8m3qMHRh87PiM+AiRUboehyCbdmoV2BaZQ//8FpZSCIML2vaHORRxi3ryfNyohBjO77Y4+ft9YopNmsRnTcGXTbrkmGF0s8p1IXXn1Wt1euXBUdYBO13Ml6uknwECQWOT3oHmoLKukB5i88XI/WZRLn80UkDwPOXOjNdBBbqrzT3KN1GnlC0NilBRwwRv5+lLUbGitnuyaCZkrxK0myV8LsxDaEc7tjYhXhaXcD00Nw+yFlFZQS6zS85QV4QjYK8GzrMiYExiqVKi8yLt73wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727347612; c=relaxed/relaxed;
	bh=HAfK9a+C2cwA67W9H+QW9yoB06NuG9+8CGbAb5+/yLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRYvJT3TofA+SdaxKkgOlH8E6Lt9a1rU69s76pX9USAxDkuUavHYTvTjUz5xueZLBCCn421JKiX/kFuUQUDBMo862hfWX6W+860tpYYggOvK1FdquVT1XKOsFA52vxFve9imi341lmatesJXqGkf6qzna6OioIc//z6AgLFZlVoX3MT3G9FRc+x2iuRLgR5kVeckJdhYNYODRdVKVVhzgxreqFsddYWMIO0PGJN4DUqggKuKpLHSCmHQV7MLl2oqvALlpzpQMhMVp5sRqPLeIObhC5BCyhq44Nxvqh+WLiDuNn9JwAxe1gFrk0R+QCa8A0q+PyNgld597xHZe3IelQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tlqPhKmt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tlqPhKmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDqzH0ZF5z2yGL
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 20:46:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727347598; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HAfK9a+C2cwA67W9H+QW9yoB06NuG9+8CGbAb5+/yLQ=;
	b=tlqPhKmteAwVC+E9QsiMOthg/PAM0kRf+9Kczd0oqp8Wh5qf0WBgREyglZUyrgc0V8jDrV3e85+Hqk0VYoQCrlOwoIeHX+SCdgkMpllEPooM6JcQMKJeuOeYYP/rMf4PkTPe+MriP4m+gxJiL8e2EgItzUubuz93BDK/QDN096g=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFn33Oz_1727347595)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 18:46:36 +0800
Message-ID: <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
Date: Thu, 26 Sep 2024 18:46:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
References: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 2024/9/26 17:51, Ariel Miculas wrote:
> On 24/09/26 04:25, Gao Xiang wrote:
>>
>>
>> On 2024/9/26 16:10, Ariel Miculas wrote:
>>> On 24/09/26 09:04, Gao Xiang wrote:
>>>>
>>
>>
>> ...
>>
>>>
>>> And here [4] you can see the space savings achieved by PuzzleFS. In
>>> short, if you take 10 versions of Ubuntu Jammy from dockerhub, they take
>>> up 282 MB. Convert them to PuzzleFS and they only take up 130 MB (this
>>> is before applying any compression, the space savings are only due to
>>> the chunking algorithm). If we enable compression (PuzzleFS uses Zstd
>>> seekable compression), which is a fairer comparison (considering that
>>> the OCI image uses gzip compression), then we get down to 53 MB for
>>> storing all 10 Ubuntu Jammy versions using PuzzleFS.
>>>
>>> Here's a summary:
>>> # Steps
>>>
>>> * I’ve downloaded 10 versions of Jammy from hub.docker.com
>>> * These images only have one layer which is in tar.gz format
>>> * I’ve built 10 equivalent puzzlefs images
>>> * Compute the tarball_total_size by summing the sizes of every Jammy
>>>     tarball (uncompressed) => 766 MB (use this as baseline)
>>> * Sum the sizes of every oci/puzzlefs image => total_size
>>> * Compute the total size as if all the versions were stored in a single
>>>     oci/puzzlefs repository => total_unified_size
>>> * Saved space = tarball_total_size - total_unified_size
>>>
>>> # Results
>>> (See [5] if you prefer the video format)
>>>
>>> | Type | Total size (MB) | Average layer size (MB) | Unified size (MB) | Saved (MB) / 766 MB |
>>> | --- | --- | --- | --- | --- |
>>> | Oci (uncompressed) | 766 | 77 | 766 | 0 (0%) |
>>> | PuzzleFS uncompressed | 748 | 74 | 130 | 635 (83%) |
>>> | Oci (compressed) | 282 | 28 | 282 | 484 (63%) |
>>> | PuzzleFS (compressed) | 298 | 30 | 53 | 713 (93%) |
>>>
>>> Here's the script I used to download the Ubuntu Jammy versions and
>>> generate the PuzzleFS images [6] to get an idea about how I got to these
>>> results.
>>>
>>> Can we achieve these results with the current erofs features?  I'm
>>> referring specifically to this comment: "EROFS already supports
>>> variable-sized chunks + CDC" [7].
>>
>> Please see
>> https://erofs.docs.kernel.org/en/latest/comparsion/dedupe.html
> 
> Great, I see you've used the same example as I did. Though I must admit
> I'm a little surprised there's no mention of PuzzleFS in your document.

Why I need to mention and even try PuzzleFS here (there are too many
attempts why I need to try them all)?  It just compares to the EROFS
prior work.

> 
>>
>> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
>> Compressed OCI (tar.gz)	282.5	28.3	63%
>> Uncompressed OCI (tar)	766.1	76.6	0%
>> Uncomprssed EROFS	109.5	11.0	86%
>> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
>> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
>>
>> I don't know which compression algorithm are you using (maybe Zstd?),
>> but from the result is
>>    EROFS (LZ4HC,12,64k)  54.2
>>    PuzzleFS compressed   53?
>>    EROFS (DEFLATE,9,32k) 46.4
>>
>> I could reran with EROFS + Zstd, but it should be smaller. This feature
>> has been supported since Linux 6.1, thanks.
> 
> The average layer size is very impressive for EROFS, great work.
> However, if we multiply the average layer size by 10, we get the total
> size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
> the average layer size is 30 MIB (for the compressed case), the unified
> size is only 53 MiB. So this tells me there's blob sharing between the
> different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
> with EROFS (what I'm talking about is deduplication across the multiple
> versions of Ubuntu Jammy and not within one single version).

Don't make me wrong, I don't think you got the point.

First, what you asked was `I'm referring specifically to this
comment: "EROFS already supports variable-sized chunks + CDC"`,
so I clearly answered with the result of compressed data global
deduplication with CDC.

Here both EROFS and Squashfs compresses 10 Ubuntu images into
one image for fair comparsion to show the benefit of CDC, so
I believe they basically equal to your `Unified size`s, so
the result is

			Your unified size
	EROFS (LZ4HC,12,64k)  54.2
	PuzzleFS compressed   53?
	EROFS (DEFLATE,9,32k) 46.4

That is why I used your 53 unified size to show EROFS is much
smaller than PuzzleFS.

The reason why EROFS and SquashFS doesn't have the `Total Size`s
is just because we cannot store every individual chunk into some
seperate file.

Currently, I have seen no reason to open arbitary kernel files
(maybe hundreds due to large folio feature at once) in the page
fault context.  If I modified `mkfs.erofs` tool, I could give
some similar numbers, but I don't want to waste time now due
to `open arbitary kernel files in the page fault context`.

As I said, if PuzzleFS finally upstream some work to open kernel
files in page fault context, I will definitely work out the same
feature for EROFS soon, but currently I don't do that just
because it's very controversal and no in-tree kernel filesystem
does that.

Thanks,
Gao Xiang
