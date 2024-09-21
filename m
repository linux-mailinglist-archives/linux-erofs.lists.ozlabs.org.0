Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CAD97DC5D
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 11:29:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X9kVX69nlz2yVt
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 19:29:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726910977;
	cv=none; b=Z7l9RyGso/7diIIGQojd1xNVBY4v+6NOijfOOnNybNLIkP3mJtzyb7JpZmS3wuN0ToOUvzwAdvY1d/QFLG/XOzbUiLAKwwG2WswAvTzCfTxTPyOSP31lKNVGXt8MN3Dhh0lqKb5DYuMc9CT6II43aRGO2sf56q7+NPlcReJdFZhNul/xR51se5Jv4NCFYNm+dMDMNWn/zxc+PtfCTW6mJn67PirE5vxMEfXelkmddakyF9NxeJNsXkjTlIQpMo2qcN8sepMTJAfPFkaSKca2pE01h7nwMcGazC+m8DULNlaMMYiSEoPoU2zPIiWf9XAaAuJ5v04BaqRkEB9SN8vmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726910977; c=relaxed/relaxed;
	bh=Db9JY12mR3v9qGVXqAPEtXS6YlRFHGoPfQPLW0pSgcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXNRRzQLpv4uRGjfaCrmuSc61eAR2JuCl1yt+nS2P9A1IjH5YMb32amUiawdJHmek5QKVF7lTaGZWOOVv5oWB/otfFszPCpF0oecEuP5W0mE9aUpfPl7uaq7mVeiyxIa4vnSWvbcOoVvQPJSgTSVaVce6d3gx4gNgrDPFyDzva9R/MtrvrolwELa1bYzbj9lU4mmraElHBl7TtnXaOuPWzo6ls884x/7DQ2+Leq3jZ6Os2MtSLJcCF+d3qvyWKM0qeqyWrx0NWozUla5x9lP+9iCp6ZV8QzYoi3mDaIhs2a9mJtKAgtN60nOUf69MHXJcArAOnZ/3tcd/+CArvBLjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ysec6DIW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ysec6DIW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X9kVR49hVz2xmZ
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 19:29:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726910969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Db9JY12mR3v9qGVXqAPEtXS6YlRFHGoPfQPLW0pSgcY=;
	b=ysec6DIW6Lwjn/GmBbyvViZzMakIzQM7YHYdTigC093C8PoUNyltZKquMi7YiOxMJlK8VYdpWecISlDMSKDmAhbf3qxefDQ6VQcfsQWwS3dRrqx6jGb4LDusokEv3iHFxPt3fZlLFNdGC/iVWtbSHfPgjdbhIZdFWltPD2MwIY4=
Received: from 30.27.103.103(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFNqScp_1726910965)
          by smtp.aliyun-inc.com;
          Sat, 21 Sep 2024 17:29:27 +0800
Message-ID: <3a6314fc-7956-47f3-8727-9dc026f3f50e@linux.alibaba.com>
Date: Sat, 21 Sep 2024 17:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <b5c77d5b-7f6d-4fe5-a711-6376c265ed53@linux.alibaba.com>
 <2024092139-kimono-heap-8431@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024092139-kimono-heap-8431@gregkh>
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
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2024/9/21 16:37, Greg Kroah-Hartman wrote:
> On Fri, Sep 20, 2024 at 08:49:26AM +0800, Gao Xiang wrote:
>>
>>

...

>>
>>>
>>>>>> For Rust VFS abstraction, that is a different and indepenent story,
>>>>>> Yiyang don't have any bandwidth on this due to his limited time.
>>>>>
>>>>> This seems a bit weird, you have the bandwidth to write your own
>>>>> abstractions, but not use the stuff that has already been developed?
>>>>
>>>> It's not written by me, Yiyang is still an undergraduate tudent.
>>>> It's his research project and I don't think it's his responsibility
>>>> to make an upstreamable VFS abstraction.
>>>
>>> That is fair, but he wouldn't have to start from scratch, Wedsons
>>> abstractions were good enough for him to write a Rust version of ext2.
>>
>> The Wedson one is just broken, I assume that you've read
>> https://lwn.net/Articles/978738/ ?
> 
> Yes, and if you see the patches on linux-fsdevel, people are working to
> get these vfs bindings correct for any filesystem to use.  Please review
> them and see if they will work for you for erofs, as "burying" the
> binding in just one filesystem is not a good idea.

Thanks for the reply!

I do think the first Rust filesystem should be ext2 or other
simple read-write fses due to many VFS member lifetime
concerns as other filesystem developpers suggested before [1],
otherwise honestly the VFS abstraction will be refactoredagain
and again just due to limited vision and broken functionality,
I do think which way is not how currently new C Linux kernel
APIs are proposed too (e.g. carefully review all potential use
cases).

[1] https://lore.kernel.org/linux-fsdevel/ZZ3GeehAw%2F78gZJk@dread.disaster.area/

> 
>>> In addition, tarfs and puzzlefs also use those bindings.
>>
>> These are both toy fses, I don't know who will use these two
>> fses for their customers.
> 
> tarfs is being used by real users as it solves a need they have today.
> And it's a good example of how the vfs bindings would work, although
> in a very simple way.  You have to start somewhere :)

EROFS has resolved the same functionality upstream in
2023, see [2]

```
Replacing tar or cpio archives with a filesystem is a
potential use case for EROFS. There has been a proposal
from the confidential-computing community for a kernel
tarfs filesystem, which would allow guest VMs to
efficiently mount a tar file directly. But EROFS would
be a better choice, he said. There is a proof-of-concept
patch set that allows directly mounting a downloaded tar
file using EROFS that performs better than unpacking the
tarball to ext4, then mounting it in the guest using
overlayfs.
```

Honestly, I've kept doing very friendly public/private
communitation with Wedson in the confidential-computing
community to see if there could be a collaboration for
our tar direct mount use cases, but he just ignored my
suggestion [3] and keep on his "tarfs" development (even
this "tarfs" has no relationship with the standard
POSIX tar/pax format because you cannot mount a real
POSIX tar/pax by his implementation.)

So my concern is just as below:
  1) EROFS can already work well for his "tarfs" use
     cases, so there is already an in-tree stuff works
     without any issue;

  2) No matter from his "tarfs" current on-disk format,
     and on-disk extendability perspersive, I think it
     will be used for a very narrow use case.
     So in the long term, it could be vanished or forget
     since there are more powerful alternatives in the
     kernel tree for more wider use cases.

I think there could be some example fs to show Rust VFS
abstraction (such as ext2, and even minix fs).  Those
fses shouldn't be too hard to get a Rust implementation
(e.g. minix fs for pre Linux 1.0).  But honestly I don't
think it's a good idea to upstream a narrow use case
stuff even it's written in Rust: also considering Wedson
has been quited, so the code may not be maintainerd
anymore.

In short, I do _hope_ a nice Rust VFS abstraction could
be landed upstream.  But it should be driven by a simple
no-journal read-write filesystem to check all Rust VFS
components in the global vision instead of some
unsustainable random upstream work just for
corporation pride likewise.

And if some other approach could compare EROFS as a known
prior art (as I once fully compared with SquashFS in the
paper) with good reasons, I will be very happy and feel
respect (also I could know the limitation of EROFS or how
to improve EROFS.)  But if there is no reason and just
ignore EROFS exists, and I think it's not the proper way
to propose a new kernel feature / filesystem.

[2] https://lwn.net/Articles/934047
[3] https://github.com/kata-containers/kata-containers/pull/7106#issuecomment-1592192981

> 
>>> Miguel Ojeda.
>>> However, we can only reach that longterm goal if maintainers are willing
>>> and ready to put Rust into their subsystems (either by knowing/learning
>>> Rust themselves or by having a co-maintainer that does just the Rust
>>> part). So you wanting to experiment is great. I appreciate that you also
>>> have a student working on this. Still, I think we should follow our
>>> guidelines and create abstractions in order to require as little
>>> `unsafe` code as possible.
>>
>> I've expressed my point.  I don't think some `guideline`
>> could bring success to RFL.  Since many subsystems needs
>> an incremental way, not just a black-or-white thing.
> 
> Incremental is good, and if you want to use a .rs file or two in the
> middle of your module, that's fine.  But please don't try to implement
> bindings to common kernel data structures like inodes and dentries and
> superblocks if at all possible and ignore the work that others are doing
> in this area as that's just duplicated work and will cause more
> confusion over time.

Yeah, agreed. That is what I'd like to say.

Honestly, Yiyang don't have enough time to implement
VFS abstraction due to his studies and my time slot is
limited for now too.

So I also asked him to "don't touch common kernel data
structures like inodes and dentries and superblocks
if possible" and just convert the EROFS core logic.

But it seems his RFC patch is still left something,
I think he will address them the next version.

> 
> It's the same for drivers, I will object strongly if someone attempted
> to create a USB binding for 'struct usb_interface' in the middle of a
> USB driver and instead insist they work on a generic binding that can be
> used by all USB drivers.  I imagine the VFS maintainers have the same
> opinion on their apis as well for valid reasons.

Agreed.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

