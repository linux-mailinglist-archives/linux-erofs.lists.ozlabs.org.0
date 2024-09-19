Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B197CB72
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 17:14:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8fDm5lY9z2yNB
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2024 01:14:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726758835;
	cv=none; b=gV6VrSDuE2zqypy00FAKnaaMz67H/mN9zCb4y+H6+3hCXRlhywntaV5HoV8uoRVT6ZwjpK9FzILuR+8f79cunWfBtR+8E+dACY3PPx1VB/ufZ5yrtFGF4Wg4cMWN8viNCyuMph8SQin1dlzpt0qZ7xpOJJxhb4tHCKYfQT9O9B9MvM8PMrmWh3apoPE0haVR38dOPk0GAy58ENTozuCQWE4hoyOGzE8czhToW57YIEwcfr/xC1SARLDnvEHdBYbHwEfc4i71jkP6zW42VKwMi0J76MGe1joCM6zM6PVi4maWTa/nxNUVGqrdAQB6H74mnkbZ5slANoPp1FtV011FuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726758835; c=relaxed/relaxed;
	bh=5VCFEuYCnHsfOuo1YYnMThvXIJQAqGa76+hoecHZapM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6pJF+gesoG+tg5r2Wo6zZJuowiFKyryzwOqpbIgRfMvXXHUp6dSScNgFqwGaXdtHZucarotpHJpRgsWIHbgV26Xs1ETkbCEYkTSD0RwlS7AT0TrJvOjnHVx4HQTx0hjK0FwycqWE0nC9LTpA7ROFTBa/dOUas8FNlc5CLCnPNZrMIv3uuJxRz9lIWliazloaPwc7CxrsmY8LdQkU23feS45ik/kzlLHV4+4CrCiMheSGdnhf1Svzjyn98zLD9n59h9RuEKO3pKqapNPNLmd5nJu+2vx3O5ESSkYf+CyEAU07j9YbtKO6s0j9M0ijb9W9GqvpmWvLavDYC1czyidgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z8id9bgc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z8id9bgc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X8fDd1dkqz2yHj
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2024 01:13:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726758825; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5VCFEuYCnHsfOuo1YYnMThvXIJQAqGa76+hoecHZapM=;
	b=Z8id9bgc2av9+LkJKCdUSibNKSqbk6/Qp9Fcft+hzn/ppWkcALE/YOOmYaMAtkxNJX9B4TiKLsGPykFKiKkE8SwKFT3qBAlFpoE+0CQX/y+pdUW1zZA9LTnMh2hssDjU2kpZCLRYBxWTcEhsoQJfMBW5Mi2r1xtLuyhSlaBjRVE=
Received: from 30.27.101.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFI-2kQ_1726758821)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 23:13:43 +0800
Message-ID: <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
Date: Thu, 19 Sep 2024 23:13:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
 Yiyang Wu <toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
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
Cc: rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Benno,

On 2024/9/19 21:45, Benno Lossin wrote:
> Hi,
> 
> Thanks for the patch series. I think it's great that you want to use
> Rust for this filesystem.
> 
> On 17.09.24 01:58, Gao Xiang wrote:
>> On 2024/9/17 04:01, Gary Guo wrote:
>>> Also, it seems that you're building abstractions into EROFS directly
>>> without building a generic abstraction. We have been avoiding that. If
>>> there's an abstraction that you need and missing, please add that
>>> abstraction. In fact, there're a bunch of people trying to add FS
>>
>> No, I'd like to try to replace some EROFS C logic first to Rust (by
>> using EROFS C API interfaces) and try if Rust is really useful for
>> a real in-tree filesystem.  If Rust can improve EROFS security or
>> performance (although I'm sceptical on performance), As an EROFS
>> maintainer, I'm totally fine to accept EROFS Rust logic landed to
>> help the whole filesystem better.
> 
> As Gary already said, we have been using a different approach and it has
> served us well. Your approach of calling directly into C from the driver
> can be used to create a proof of concept, but in our opinion it is not
> something that should be put into mainline. That is because calling C
> from Rust is rather complicated due to the many nuanced features that
> Rust provides (for example the safety requirements of references).
> Therefore moving the dangerous parts into a central location is crucial
> for making use of all of Rust's advantages inside of your code.

I'm not quite sure about your point honestly.  In my opinion, there
is nothing different to use Rust _within a filesystem_ or _within a
driver_ or _within a Linux subsystem_ as long as all negotiated APIs
are audited.

Otherwise, it means Rust will never be used to write Linux core parts
such as MM, VFS or block layer. Does this point make sense? At least,
Rust needs to get along with the existing C code (in an audited way)
rather than refuse C code.

My personal idea about Rust: I think Rust is just another _language
tool_ for the Linux kernel which could save us time and make the
kernel development better.

Or I wonder why not writing a complete new Rust stuff instead rather
than living in the C world?

> 
>> For Rust VFS abstraction, that is a different and indepenent story,
>> Yiyang don't have any bandwidth on this due to his limited time.
> 
> This seems a bit weird, you have the bandwidth to write your own
> abstractions, but not use the stuff that has already been developed?

It's not written by me, Yiyang is still an undergraduate tudent.
It's his research project and I don't think it's his responsibility
to make an upstreamable VFS abstraction.

> 
> I have quickly glanced over the patchset and the abstractions seem
> rather immature, not general enough for other filesystems to also take

I don't have enough time to take a full look of this patchset too
due to other ongoing work for now (Rust EROFS is not quite a high
priority stuff for me).

And that's why it's called "RFC PATCH".

> advantage of them. They also miss safety documentation and are in

I don't think it needs to be general enough, since we'd like to use
the new Rust language tool within a subsystem.

So why it needs to take care of other filesystems? Again, I'm not
working on a full VFS abstriction.

Yes, this patchset is not perfect.  But I've asked Yiyang to isolate
all VFS structures as much as possible, but it seems that it still
touches something.

> general poorly documented.

Okay, I think it can be improved then if you give more detailed hints.

> 
> Additionally, all of the code that I saw is put into the `fs/erofs` and
> `rust/erofs_sys` directories. That way people can't directly benefit
> from your code, put your general abstractions into the kernel crate.
> Soon we will be split the kernel crate, I could imagine that we end up
> with an `fs` crate, when that happens, we would put those abstractions
> there.
> 
> As I don't have the bandwidth to review two different sets of filesystem
> abstractions, I can only provide you with feedback if you use the
> existing abstractions.

I think Rust is just a tool, if you could have extra time to review
our work, that would be wonderful!  Many thanks then.

However, if you don't have time to review, IMHO, Rust is just a tool,
I think each subsystem can choose to use Rust in their codebase, or
I'm not sure what's your real point is?

> 
>> And I _also_ don't think an incomplete ROFS VFS Rust abstraction
>> is useful to Linux community
> 
> IIRC Wedson created ROFS VFS abstractions before going for the full
> filesystem. So it would definitely be useful for other read-only
> filesystems (as well as filesystems that also allow writing, since last
> time I checked, they often also support reading).

Leaving aside everything else, an incomplete Rust read-only VFS
abstraction itself is just an unsafe stuff.

> 
>> (because IMO for generic interface
>> design, we need a global vision for all filesystems instead of
>> just ROFSes.  No existing user is not an excuse for an incomplete
>> abstraction.)
> 
> Yes we need a global vision, but if you would use the existing
> abstractions, then you would participate in this global vision.
> 
> Sorry for repeating this point so many times, but it is *really*
> important that we don't have multiple abstractions for the same thing.

I've expressed my viewpoint.

> 
>> If a reasonble Rust VFS abstraction landed, I think we will switch
>> to use that, but as I said, they are completely two stories.
> 
> For them to land, there has to be some kind of user. For example, a rust
> reference driver, or a new filesystem. For example this one.

Without a full proper VFS abstraction, it's just broken and
needs to be refactored.  And that will be painful to all
users then.

=======
In the end,

Other thoughts, comments are helpful here since I wonder how "Rust
-for-Linux" works in the long term, and decide whether I will work
on Kernel Rust or not at least in the short term.

Thanks,
Gao Xiang

> 
> ---
> Cheers,
> Benno
> 

