Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A55986F3E
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 10:48:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDnM70PvWz2ypP
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 18:48:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727340528;
	cv=none; b=M20PmdcBBEunShCfeEhy7smayl+aOXmBXznIcNzWgGg4J+6HfdtY7Sl43G3490bfXDVf1hLCUulzItv+ZgSpdzh0dNb+gwPs6Vlweq3TMX1mHbA3apqNepA6BGOpa0uwH2wIpBOHf63lIz/pdOFb9qAQx8RqVfxJvMI1kNfjuY9tTB4Q/h03I6ffXqESHGmHnXwT2yYh/KiHMlDE35eQwkHYCR2dxSy3654Ce6S0UoZDJ4lM+shRRsocmoGMEwqGMvGhvU2/j8Wa8pFOxrZW3LdBRSyqkg/Opgsk+/1a23L2Q2CBj4uIYB3o4BJL9Z4MCLWpB2NsRQ8BURzg8n4/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727340528; c=relaxed/relaxed;
	bh=vql8xWm4ugnb2a4wcV5wGjvZCN0btIoVoInfiJaEEYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1sCOxxnzbjSrmBP7lU8yeWzQZpnUZZxO7gmQQ8o7XKnUf4pJnJbUB+sWg+F5LtO4byfEd/NH4oSEOfB4s84cYT53pzbDeBntpeoXk3W/eTrfLTyFNPxG4bybW6w4Deu+25yaFEiI02hOw6XkWl12HB+tdCvk2kn2egj+ZUNDH7xkMYLgQbw+lR+rlw/9LOuHmI0KSOCldI5Vh13dJV8ryLJmpl4dRtoyX0xYahx/Yag87WpgPkg4Vp6EyvDu6gsIvlvHDQHhv4Uz5TJPcYE949dv2FdkpqB92xtborwNAfeE+iXNZLsoaNjUDfIxgzZTeKP/v3m9EI1JBV7YeR83w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vHPIi/v1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vHPIi/v1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDnM30VZRz2yFJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 18:48:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727340516; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vql8xWm4ugnb2a4wcV5wGjvZCN0btIoVoInfiJaEEYI=;
	b=vHPIi/v1fAJX+fRvuqucuw0BGnyOp8n77cbxersp/WObTzYPhVXIe9Xtrq/HRzlM9Fm2T6oZI/xAY6C8u4hZ/XwzXMvw2XiVxFSdg3M3Kwm4ZttvV+CM9lL4OWpsPFhgBYqiJvtRn5oMgTyRukEsiah3ylPnZTGXzcMA9LBTp5s=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFmi89h_1727340514)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:48:35 +0800
Message-ID: <4c4e92bf-663f-4acf-a812-782536bf34d4@linux.alibaba.com>
Date: Thu, 26 Sep 2024 16:48:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
References: <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
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



On 2024/9/26 16:10, Ariel Miculas via Linux-erofs wrote:
> On 24/09/26 09:04, Gao Xiang wrote:
>>
>>
>> On 2024/9/26 08:40, Gao Xiang wrote:
>>>
>>>
>>> On 2024/9/26 05:45, Ariel Miculas wrote:
>>
>> ...
>>
>>>>
>>>> I honestly don't see how it would look good if they're not using the
>>>> existing filesystem abstractions. And I'm not convinced that Rust in the
>>>> kernel would be useful in any way without the many subsystem
>>>> abstractions which were implemented by the Rust for Linux team for the
>>>> past few years.
>>>
>>> So let's see the next version.
>>
>> Some more words, regardless of in-tree "fs/xfs/libxfs",
>> you also claimed "Another goal is to share the same code between user
>> space and kernel space in order to provide one secure implementation."
>> for example in [1].
>>
>> I wonder Rust kernel VFS abstraction is forcely used in your userspace
>> implementation, or (somewhat) your argument is still broken here.
> 
> Of course the implementations cannot be identical, but there is a lot of
> shared code between the user space and kernel space PuzzleFS
> implementations. The user space implementation uses the fuser [1] crate
If you know what you're doing, you may know what Yiyang is doing
here, he will just form a Rust EROFS core logic and upstream later.

Thanks,
Gao Xiang

