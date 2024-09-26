Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3448986A4A
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 02:41:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDZXc3HwBz2yVV
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 10:41:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727311274;
	cv=none; b=CjnZIz1I1xEc/muY5bU5fGwpOLJxSTFaGx5+e7qKmGC0mkfDxndogkNoCte3lx93eksoNTQRM+5XS+TfkQ4yQaY+rRhxKSqqXAxGE8PHwaOrTviXiyU2RVlyr61eVhXUm/n81oUlOs2bZTh0wxaT5CEO4+3ZRCA/Q4lBzXIRAs84XI00m11UKqhzwKF3xlRLdcSV+dBBoCXaXuzG/E7U9IFtpD5KCFG2mZV+GNBOz1N8vKddKR8NA5qIPGwoKK+dKNaj8NswENrqhdKZSgDbzJY0BwkYHnh3ZHlQsIMrpranIHxbLxVCRCapPov6S+7HLl5ni+/dRTI1XJBzj145AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727311274; c=relaxed/relaxed;
	bh=/ooxu0myL1NDq78z/zYkSZU901mlk9sLoZWXOrPAioo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D19C8F9Tro0pzZQCC/u15osOOxaeA49Qv+uTD1S59FTQxwfqPTPOZDlmrSPgyYRUqaP0UMweQcQmBTGA8Hv83SkpQ9KbZ4kuoZBXwtpl5SvqrKniJnJvKztgplGsvT5jqgyPmO7QvKU1BgvZgckNpUuQYzBFwNp283AHp/sbIzWXmsYHv1mIw9q0otgpe/5LcQwpLyW5JMYVML/BqbEI1O7YFgMO3NnGWED464+PWIQ9wi0xfflMqLgMkDQHlTwBronnbQNt3028xOPcddp/nV79WCOhibIorRv+tnkjo0HKCIyQEdyoGd7V6YA/bMdi6d0b/2l453scYT9NclXmjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmZO4/xE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmZO4/xE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDZXQ5ZsQz2xLR
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 10:41:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727311261; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/ooxu0myL1NDq78z/zYkSZU901mlk9sLoZWXOrPAioo=;
	b=VmZO4/xEfm8up29YTn/nCSGZR2XK7QzO6EadJnhDRreAZee9ozQV2huu8jrTxSRPGi77RWtKVaIL8eJ97Vmc+2gBgxRQDTXevKH/lEsr2VFQJe/dCL4G5DvzmmILEeURXYZGqcq0qrfXUk/vAQ8G829DI59LWUnmEgG0/fgNl30=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFlGCJ7_1727311257)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 08:41:00 +0800
Message-ID: <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
Date: Thu, 26 Sep 2024 08:40:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
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



On 2024/9/26 05:45, Ariel Miculas wrote:
> On 24/09/26 12:35, Gao Xiang wrote:
>> Hi Ariel,
>>
>> On 2024/9/25 23:48, Ariel Miculas wrote:
>>

...

>>
>> And there are all thoughts for reference [2][3][4][5]:
>> [2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
>> [3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
>> [4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
>> [5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/
>>
>> Here still, I do really want to collaborate with you on your
>> reasonable use cases.  But if you really want to do your upstream
>> attempt without even any comparsion, please go ahead because I
>> believe I can only express my own opinion, but I really don't
>> decide if your work is acceptable for the kernel.
>>
> 
> Thanks for your thoughts on PuzzleFS, I would really like if we could
> centralize the discussions on the latest patch series I sent to the
> mailing lists back in May [1]. The reason I say this is because looking
> at that thread, it seems there is no feedback for PuzzleFS. The feedback
> exists, it's just scattered throughout different mediums. On top of
> this, I would also like to engage in the discussions with Dave Chinner,
> so I can better understand the limitations of PuzzleFS and the reasons
> for which it might be rejected in the Linux Kernel. I do appreciate your
> feedback and I need to take my time to respond to the technical issues
> that you brought up in the github issue.

In short, I really want to avoid open arbitary number files in the
page fault path regardless of the performance concerns, because
even there are many cases that mmap_lock is dropped, but IMHO there
is still cases that mmap_lock will be taken.

IOWs, I think it's controversal for a kernel fs to open random file
in the page fault context under mmap_lock in the begining.
Otherwise, it's pretty straight-forward to add some similiar feature
to EROFS.

> 
> However, even if it's not upstream, PuzzleFS does use the latest Rust
> filesystem abstractions and thus it stands as an example of how to use
> them. And this thread is not about PuzzleFS, but about the Rust
> filesystem abstractions and how one might start to use them. That's
> where I offered to help, since I already went through the process of
> having to use them.
> 
> [1] https://lore.kernel.org/all/20240516190345.957477-1-amiculas@cisco.com/
> 
>>>
>>> I'm happy to help you if you decide to go down this route.
>>
>> Again, the current VFS abstraction is totally incomplete and broken
>> [6].
> 
> If they're incomplete, we can work together to implement the missing
> functionalities. Furthermore, we can work to fix the broken stuff. I
> don't think these are good reasons to completely ignore the work that's
> already been done on this topic.

I've said, we don't miss any Rust VFS abstraction work, as long as
some work lands in the Linux kernel, we will switch to use them.

The reason we don't do that is again
  - I don't have time to work on this because my life is still limited
    for RFL in any way at least this year; I don't know if Yiyang has
    time to work on a complete ext2 and a Rust VFS abstraction.

  - We just would like to _use Rust_ for the core EROFS logic, instead
    of touching any VFS stuff.  I'm not sure why it's called "completely
    ignore the VFS abstraction", because there is absolutely no
    relationship between these two things.  Why we need to mix them up?

> 
> By the way, what is it that's actually broken? You've linked to an LWN
> article [2] (or at least I think your 6th link was supposed to link to
> "Rust for filesystems" instead of the "Committing to Rust in the kernel"
> one), but I'm interested in the specifics. What exactly doesn't work as
> expected from the filesystem abstractions?

For example, with my current Rust skill, I'm not sure why
fill_super for "T::SUPER_TYPE, sb::Type::BlockDev" must use
"new_sb.bdev().inode().mapper()".

It's unnecessary for a bdev-based fs to use bdev inode page
cache to read metadata;

Also it's unnecessary for a const fs type to be
sb::Type::BlockDev or sb::Type::Independent as

/// Determines how superblocks for this file system type are keyed.
+    const SUPER_TYPE: sb::Type = sb::Type::Independent;

because at least for the current EROFS use cases, we will
decide to use get_tree_bdev() or get_tree_nodev() according
to the mount source or mount options.

> 
> [2] https://lwn.net/Articles/978738/
> 
>>
>> I believe it should be driven by a full-featured read-write fs [7]
>> (even like a simple minix fs in pre-Linux 1.0 era) and EROFS will
> 
> I do find it weird that you want a full-featured read-write fs
> implemented in Rust, when erofs is a read-only filesystem.

I'm not sure why it's weird from the sane Rust VFS abstraction
perspective.

> 
>> use Rust in "fs/erofs" as the experiment, but I will definitely
>> polish the Rust version until it looks good before upstreaming.
> 
> I honestly don't see how it would look good if they're not using the
> existing filesystem abstractions. And I'm not convinced that Rust in the
> kernel would be useful in any way without the many subsystem
> abstractions which were implemented by the Rust for Linux team for the
> past few years.

So let's see the next version.

Thanks,
Gao Xiang

> 
> Cheers,
> Ariel
> 
