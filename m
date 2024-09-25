Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D884F9864E9
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 18:35:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDMmF6H1fz2yVM
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 02:35:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727282137;
	cv=none; b=fMRIG7eFfdqqCJq3ldtzoq+1HWD33WOp9fbPl6GLPH9JLiOf7Xdj6FqnUur5qqe8n7ntbKyMx9VksFWF271QFFmyRpmPEa46yoRVLo6RI71wzAvS47V0WViHtzlwp2TbzzdraHEH3pAxAHAFk0Vfsi1pak4ALyJ+Kd+LXEQd1uOPPB66sQ1X1ncrHWC2CkapR/RQsYx8MYe08GFfJ2Ni5K0y1AXTBVWFcbI1WYl2lhEWUDFtIhbdfpK9lHUabvg/i7LZKB8BDl8d4D5LLs/LMRBx6mVQFVxhrkoZkTATwz8am6qIvofrW2tygtd5ejiOcTfNCahVkw8yUKccNIPAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727282137; c=relaxed/relaxed;
	bh=E6ocSw4NWKlqHxKRP24Nwyb3i7XLZtOr82Y4AE+Iu6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3BABR+QP+BEvIh8ccNvG/aGtPNLOA9to5QwP1loVbxDKfWor0aJyeDHFV0hjIlv0DXtToaQzgcJJ8ZMa4D2dXBgtPMo+54S/+uhotntFBO90dkqWa5mRQx+bUzk0En+01IgVVc7+eOAQHYYpJqTtxr+Ok2Pz7FIEJjjRCUD3TvySnh/PORtPeKqci1zqU366RQsQB7uyDgEkQwDuJci+E2qqK6nQqXauVxNSSj1sd8o3/l6K9RV9kKlGQMj5u60XHPoYPoqyNZCqLrJP3FFpgk9DYE27PkgF5JmdpUlXLBY+tXEeGgU9o1FdurHZ2GMmG2x4MLE7nRCMyJuk3ha2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k1Scjl4W; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k1Scjl4W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDMm80KYSz2xSl
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 02:35:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727282129; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E6ocSw4NWKlqHxKRP24Nwyb3i7XLZtOr82Y4AE+Iu6Q=;
	b=k1Scjl4WqEdDkC8lx3QVtpYr32FSDN/cQMWSrrup474/2QmRLOCx3kU7ClCTPm8H/IbWbIt/JgpofiAgnQjdTRuCc3QJU/3tKfqRjVi06RXkdVIxGfeDYHwTGEp5NT7rtU+MFFpltt1f0BGY5Hdq5MtB46BaclAfSNT1xLsWxV0=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFkHUjQ_1727282125)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 00:35:27 +0800
Message-ID: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
Date: Thu, 26 Sep 2024 00:35:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>, Benno Lossin <benno.lossin@proton.me>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
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
Cc: rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Ariel,

On 2024/9/25 23:48, Ariel Miculas wrote:

...

> I share the same opinions as Benno that we should try to use the
> existing filesystem abstractions, even if they are not yet upstream.
> Since erofs is a read-only filesystem and the Rust filesystem
> abstractions are also used by other two read-only filesystems (TarFS and
> PuzzleFS), it shouldn't be too difficult to adapt the erofs Rust code so
> that it also uses the existing filesystem abstractions. And if there is
> anything lacking, we can improve the existing generic APIs. This would
> also increase the chances of upstreaming them.

I've expressed my ideas about "TarFS" [1] and PuzzleFS already: since
I'm one of the EROFS authors, I should be responsible for this
long-term project as my own promise to the Linux community and makes
it serve for more Linux users (it has not been interrupted since 2017,
even I sacrificed almost all my leisure time because the EROFS project
isn't all my paid job, I need to maintain our internal kernel storage
stack too).

[1] https://lore.kernel.org/r/3a6314fc-7956-47f3-8727-9dc026f3f50e@linux.alibaba.com

Basically there should be some good reasons to upstream a new stuff to
Linux kernel, I believe it has no exception on the Rust side even it's
somewhat premature: please help compare to the prior arts in details.

And there are all thoughts for reference [2][3][4][5]:
[2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
[3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
[4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
[5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/

Here still, I do really want to collaborate with you on your
reasonable use cases.  But if you really want to do your upstream
attempt without even any comparsion, please go ahead because I
believe I can only express my own opinion, but I really don't
decide if your work is acceptable for the kernel.

> 
> I'm happy to help you if you decide to go down this route.

Again, the current VFS abstraction is totally incomplete and broken
[6].

I believe it should be driven by a full-featured read-write fs [7]
(even like a simple minix fs in pre-Linux 1.0 era) and EROFS will
use Rust in "fs/erofs" as the experiment, but I will definitely
polish the Rust version until it looks good before upstreaming.

I really don't want to be a repeater again.

[6] https://lwn.net/SubscriberLink/991062/9de8e9a466a3faf5
[7] https://lore.kernel.org/linux-fsdevel/ZZ3GeehAw%2F78gZJk@dread.disaster.area

Thanks,
Gao Xiang

> 
> Cheers,
> Ariel

