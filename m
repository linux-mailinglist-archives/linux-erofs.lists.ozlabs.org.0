Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7A98724D
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 13:05:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDrNW2wfZz2ynL
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 21:05:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727348711;
	cv=none; b=VPgkNfRrml+CVAatJehEC5aNvWKqP6gOQUKXaTIiyC5eIKVat1iqYZrTUb4jS9AEXi8VDrBhPNVNqtt8/f4lhXsBaaYxE+bJxKP76ljp1Fm5TE64rHY5B5FZLzWBmo/RmxytItQ3Lqmm681lUKfhimPXq9db+KAaYlqZvvwYp+0OiE/4e8nyTq6J9Mv7WLg4KSHGqZNdMxObnIeMLsimOnFBQHFmPszHe1DelDFR/KgBuZ+3zVgLQU0GhdwkaaKylD2auS5JE8e+nTd+g3314wDsrhlN/8f3d7UrtKYGfEYaGeqWJgMQmVe/YoFNB3GSiYyygENKS+QVXJ/zlMdAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727348711; c=relaxed/relaxed;
	bh=aHeUnsZb95rwTMK+/+jFnDz4f7VKp5e98rBcltas9nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNxMhpZnOsQJhFMiivW4k9rvoZLwzpyEdo7MaiMuvrTQ0HHuhSGlzFJQx0FqTvaYCwLeDofTwAJtyMS5m7Q8a1E0y+NxvTtL+g6cxCsf9s6jw1SJlfwtOCDmsQnA1sBKWkdMaXv9GHwjpVAUHRPYZWU+D8prQGIQZNQ04mvmzGdB7gAbQx5pgXLhIZSLk9VqZgCBEo0QuafIzkg3Z7YBgzTZGwdQdQg8ODojZD029YUuwcZcwW+n1GIdbcNsEF+VGBU7bLNMwvlsKDBzxLLCZYyT1umezFZjdeAXmSM9ijZ5K6mCB8C4pwSXTUVo7WtkQBPLD1PENxYQY3y8+r+Q9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vQxp1KPk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vQxp1KPk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDrNQ2xRQz2y8Z
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 21:05:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727348705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aHeUnsZb95rwTMK+/+jFnDz4f7VKp5e98rBcltas9nc=;
	b=vQxp1KPkAF2QsmIxsdgb4/IW5jiRNpDKcrxtaDEYOn44dmAHKcMrM/BrlhV3mKBbdup3PcoC530bLmu5kG2OZMsByt/1U/auyfkbQzcCmt2A3EVviig85MF0XK4lraZRjzYSYkgk3koIjKyZG7Cskds6Yf//ia6ymT/fI8PVIVA=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFnDrBz_1727348703)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 19:05:03 +0800
Message-ID: <b89eec22-e79e-41a1-af0c-7d1251a5f0c3@linux.alibaba.com>
Date: Thu, 26 Sep 2024 19:05:02 +0800
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
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/26 19:01, Ariel Miculas wrote:

..

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
kernel files when reading in the page fault")  first.

If they say "no", I suggest please don't waste on this anymore.

Thanks,
Gao Xiang

> 
> Regards,
> Ariel
> 
>>
>> Thanks,
>> Gao Xiang

