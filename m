Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1D986A5A
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 03:04:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDb3H4nSfz2yVX
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 11:04:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727312665;
	cv=none; b=WCXLUTQMsb1oJi/LKejZYfi/eLTmsZfmpIUfuxQ1rL4RUp6rw1eKtzmrfBmYw0WJORW14uo/0SSTKEDB30+taIze96Frr2dQp4qKVkthEGCMCekhvdxUuQ6IB1AwFGk7yqFRrs7/R681rytcy7UYn5ayOgSZhLJOjpeaDUm65ezJO2gWFI3CyyjemMHqJnihbocZmy4MH5rHQFVW0lgCMvHDzUF8miOnm4Yf/5cIo1V/Fs+7ug1Wx4rVgd3Atvv/ZCc0qY0hvN0eJyQRdA1lvZQSKSYsAjDVfXARqzumUQ26r9VBojijAo8nAN0eB6cuNAcnTBHo+h2/U5T65UvY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727312665; c=relaxed/relaxed;
	bh=Fwd7Ybo+H+LowOXsq8VU7uRzWXWrPpIwnjgLH/1cB08=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o0eUjFqb+F9VwrJuBEa64n9GJ/UuCFnyqmiqovBlZUUOJBykEmPBUqrrfcYTo5tegrLvNUixComzCUlkwmBk94tafDGFr2f0KW9SUgs+A+zpdCjFNSjjiADapfx3F0XUTVHAQ03hf3RAg9A1Bumxz3vSleMXICtwzmuiLwX3C68WcZC+pCOW6funLy2j77m1zLiKOVza3YbvWEBPWJ4JLQOGzSny438v+1dwT1omuYHT9dHLoov90f0Fqf5qabf45sgIRaLz4yTYfykxMKaV4YIYlVyLM03h5fmQXluegzE8G5fbhC2Oz8LcLNQpUStBG0mN4wDom/iI6Q/sblZoSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjZejoKC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UjZejoKC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDb3C4ZTZz2xkr
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 11:04:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727312653; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Fwd7Ybo+H+LowOXsq8VU7uRzWXWrPpIwnjgLH/1cB08=;
	b=UjZejoKCB0DGk1D6Kb2BON+NvvvxmnC+IFLoLiGCzvl6mQK8SWBvMJXlCxSWXyFqssHyNnaP+Due/zgx0pvJ/TRg79bvX+s76Seq1FC/e2SKRJWzqnzJ0C4N5amq+8L+XLACIjoUIWeb8ce497fnbFNhMzp5myKrgLwmOkJdsg8=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFlPsQC_1727312650)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 09:04:12 +0800
Message-ID: <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
Date: Thu, 26 Sep 2024 09:04:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ariel Miculas <amiculas@cisco.com>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
In-Reply-To: <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
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



On 2024/9/26 08:40, Gao Xiang wrote:
> 
> 
> On 2024/9/26 05:45, Ariel Miculas wrote:

...

>>
>> I honestly don't see how it would look good if they're not using the
>> existing filesystem abstractions. And I'm not convinced that Rust in the
>> kernel would be useful in any way without the many subsystem
>> abstractions which were implemented by the Rust for Linux team for the
>> past few years.
> 
> So let's see the next version.

Some more words, regardless of in-tree "fs/xfs/libxfs",
you also claimed "Another goal is to share the same code between user
space and kernel space in order to provide one secure implementation."
for example in [1].

I wonder Rust kernel VFS abstraction is forcely used in your userspace
implementation, or (somewhat) your argument is still broken here.

[1] https://lore.kernel.org/r/20230609-feldversuch-fixieren-fa141a2d9694@brauner

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Cheers,
>> Ariel
>>

