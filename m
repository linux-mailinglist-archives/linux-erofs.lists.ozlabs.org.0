Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1DB97AB27
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 07:46:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X79kH2hVCz2yN1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 15:45:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726551957;
	cv=none; b=hSc2NXU5oeLsswwvSRaHddZMIz3JT8LA9CV/pgNyAc8gMHlnk4Ty07f8XZG6kEAxOd89c3piL5/isb6UnIDbKmjYS3SJl/qYtEg252W+OHxx/bdamLLoqWbUT4zqe83U15W/6dF8IxHJyMlbsHgqax3x/yX/qZUNcw64EObuGMRFJ050D1gfi5LTA9f3EKs+iXieh3J5Plj1LUul2fgfXoooa0AtZlYJoFmUjkhFQTgGkMLLanlO/wTbxukE7iTy1dSOhwzpLOypq+ir71Ly7J/XkOi8UnoXdri8AXxauSFP7EnThzfRiDb9ZTDOE+fE94Xqt1rALKZW+bBbutVwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726551957; c=relaxed/relaxed;
	bh=xDEH82Zgluj/gfAW11o3LnXM+W8TtjK147IvqunUm2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB/GzWOSU28j9hrItID5maU41Uiyy5gwFq4Q+O1xGHaJjePRjV0Bh9RTKxRpMRolC/KLv+yzjBsfRR97OHd35VesisgxM/EQBbr0koc9GJwGknmDdvScU2u5Kd+K1W80Esc6MSLNc1NsPgMXn+eQUIwjtJszYLArcVqCnPAoOBI/XuvJkEz5sdCzMp5A7s67lubstnwbf7qjI5ouYR+lGWF650O3DpdWZYvA3jknI2ujErkQQL9FYIBbfH7p6yk6XcOGteQk3CxViKUw7LKSgkjuyK7A30h1+RQiAQHQ3CGT57Gw/IT8gO1EA3HV2Bdn4VYaQ3GAzMWryKTvHfgMwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ghpYZ6Ea; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ghpYZ6Ea;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X79kB0FMGz2xYg
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 15:45:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726551945; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xDEH82Zgluj/gfAW11o3LnXM+W8TtjK147IvqunUm2g=;
	b=ghpYZ6Ea2se7xsb0fcZato4y76PVigL85cuzbVMlTSg9yu0NU1Eurx2FbsKzMGQKsfB8lNr+2BddE7B922b3PF1ZK0X5iKZ7vsgO4SjU3b9K9054ojDbtNPiCO63NtwFe8VhrYpOHypKBkoCLfZVzk6LfHYOnYoRctOSez787tw=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFA17GO_1726551943)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 13:45:44 +0800
Message-ID: <35fbc99c-b914-4a0e-92c1-d680a3ae2345@linux.alibaba.com>
Date: Tue, 17 Sep 2024 13:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
To: Greg KH <gregkh@linuxfoundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
 <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
 <2024091702-easiest-prelude-7d4f@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091702-easiest-prelude-7d4f@gregkh>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/17 13:34, Greg KH wrote:
> On Tue, Sep 17, 2024 at 08:18:06AM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2024/9/17 01:55, Greg KH wrote:
>>> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
>>>> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
>>>> new file mode 100644
>>>> index 000000000000..0f1400175fc2
>>>> --- /dev/null
>>>> +++ b/fs/erofs/rust/erofs_sys.rs
>>>> @@ -0,0 +1,22 @@
>>>> +#![allow(dead_code)]
>>>> +// Copyright 2024 Yiyang Wu
>>>> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
>>>
>>> Sorry, but I have to ask, why a dual license here?  You are only linking
>>> to GPL-2.0-only code, so why the different license?  Especially if you
>>> used the GPL-2.0-only code to "translate" from.
>>>
>>> If you REALLY REALLY want to use a dual license, please get your
>>> lawyers to document why this is needed and put it in the changelog for
>>> the next time you submit this series when adding files with dual
>>> licenses so I don't have to ask again :)
>>
>> As a new Rust kernel developper, Yiyang is working on EROFS Rust
>> userspace implementation too.
>>
>> I think he just would like to share the common Rust logic between
>> kernel and userspace.
> 
> Is that actually possible here?  This is very kernel-specific code from
> what I can tell, and again, it's based on the existing GPL-v2 code, so
> you are kind of changing the license in the transformation to a
> different language, right?

It's possible, Yiyang implemented a total userspace Rust crates
to parse EROFS format with limited APIs:

https://github.com/ToolmanP/erofs-rs

Also take another C example, kernel XFS (fs/libxfs) and xfsprogs
(userspace) use the same codebase.  Although they both use GPL
license only.

> 
>> Since for the userspace side, Apache-2.0
>> or even MIT is more friendly for 3rd applications (especially
>> cloud-native applications). So the dual license is proposed here,
>> if you don't have strong opinion, I will ask Yiyang document this
>> in the next version.  Or we're fine to drop MIT too.
> 
> If you do not have explicit reasons to do this, AND legal approval with
> the understanding of how to do dual license kernel code properly, I
> would not do it at all as it's a lot of extra work.  Again, talk to your
> lawyers about this please.  And if you come up with the "we really want
> to do this," great, just document it properly as to what is going on
> here and why this decision is made.

Ok, then let's stay with GPL only.  Although as I mentioned,
cloud-native applications are happy with Apache-2.0 or MIT, which
means there could be diverged for kernel and userspace on the Rust
side too.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

