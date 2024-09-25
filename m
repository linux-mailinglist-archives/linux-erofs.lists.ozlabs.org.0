Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8898687D
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Sep 2024 23:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727300810;
	bh=VckOAgRjdjkhJ0K9ZO4MPe4CiswPipPZEA7GbCxjh5M=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kezmpxJDHz2xOZQYCfBN7Bgya3d/pZjKUZ13SwPqBsE8tNQqX12B7g6kz2yGvrRnL
	 KVBhPIoKDqOAhC9fRM5PJKgcA6/0/Y5ORm/q6DIXeITSDwuMV0Dw/TdeoFpuXhUYhm
	 n5HJ2fcO+rAziFgVY2xLPgxxuaw4IBztM+UkpLwOG2vYv6+JhRbpQdPA3Q+1cbAF0V
	 B4PZqkB5UHOwh9hbdQTrBRZyDOFuqJ2mNb8XiAq16Yxv5AX2/t0ELyQ1V+qTDqf/cT
	 rQacYZ0UAf7nYWN5ReQLQTp+p1mwzwcVNN6oFAjBUrszUVO7ay2+TOxui7UCSstrlw
	 O9xV/Bs88LZYQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XDVgG3fYsz2yYy
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Sep 2024 07:46:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=173.37.86.77
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727300807;
	cv=none; b=Gqpg3V3+Vv+TKe5Y3TqIw+FWfslB/NsGbTrCcsZ/B3ztDmIayIWMV4pKXQr3zWhB61iu2CItl4qXQWHZtl176r9mdl+ZQ5iN5mJSL5zufP51+F8Qalj2yFZVtLRJ7E4bg8AYbgouQiS7Q45NyqzmLAOJAOdRw/V3BRFhFFJDodcMgVqWfYRk0685bNVp0cAJiHAaBMNrUs5SY76QgN0PDMQgP/eRIMg8ezn/CG8OUTDRMDNK4NMhLAGloVQjVIPlyfbCY8QAneSU/kRa88U2efkIEzcGtEvg3Whz6+uy/r4oJL2mlPAJ4i1/ki5+mQnzlhLguctGmvqCNiAAo12W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727300807; c=relaxed/relaxed;
	bh=VckOAgRjdjkhJ0K9ZO4MPe4CiswPipPZEA7GbCxjh5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olWcjNUG8bf5eO+QOB071RPO2JmniWB4mmtSITjn/TzOhRf38b0mK+IbXXq89as7orlujT+Zzs5Y4sys9g9oLvuzAiNABDXlBR7FnokYRvF664bnQsUtctOJt9VqvIkNybxNvuDywhX0krToNCFKfEAslbSRZFZ4F4h3J1RBsfaq2yDQSTlDwFcWBeLmDOyNAYsx/1CYQHrNyfEgJ56ZJgMD5xNGsAzHP8MlVsM84/u4heW1Iu48loiu4Q6HzQMBYkYM5MPitboGAeIwGXY4y2uUyWEUFO83tTorv13PyaDVdcV/As8CrR7gPtc+c2TJvOFyO1EAQOS/UtxTKV3E9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; dkim=pass (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=jE0UkYhV; dkim-atps=neutral; spf=pass (client-ip=173.37.86.77; helo=rcdn-iport-6.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org) smtp.mailfrom=cisco.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=jE0UkYhV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cisco.com (client-ip=173.37.86.77; helo=rcdn-iport-6.cisco.com; envelope-from=amiculas@cisco.com; receiver=lists.ozlabs.org)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XDVg56ZwYz2yDt
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Sep 2024 07:46:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5105; q=dns/txt; s=iport;
  t=1727300802; x=1728510402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VckOAgRjdjkhJ0K9ZO4MPe4CiswPipPZEA7GbCxjh5M=;
  b=jE0UkYhVgjWHGkIm38+OA8Zkgg6Iy0vKsZUOQCO6ifC3fpqNI4CEcnYi
   TlrfQVf3vQ5p+oNeUm4bkbkPo+7vkyHSEgyEOrixgCeqDzddVCJ2dCu2X
   LOcYJ2Jb2ojKM6iakFJuuKL62mP8chxt9IFl8V+3VjiBIjlZaWd6wQuzU
   8=;
X-CSE-ConnectionGUID: WQuQom6JQ06Xd3Zv61Pf8w==
X-CSE-MsgGUID: 8zLzPAsSQv2dNIE0WjRMNg==
X-IPAS-Result: =?us-ascii?q?A0ADAAC0g/RmmJxdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYNAWUNIBIxuhzCCIgOeFYF+DwEBAQ0BATsJBAEBhEFGA?=
 =?us-ascii?q?ooEAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBBQEBBQEBAQIBBwUUAQEBAQEBA?=
 =?us-ascii?q?QE3BUmFdQ2GWwEBAQECATo0CwULCw4KLlYGExSCbQGCQSMDEQawF3iBNIEBg?=
 =?us-ascii?q?2IB2k+BZgaBSAGISgGFZhuEXCcbgUlEhD8+glUMAQECgUiGWgSGcIp+DQ6BJ?=
 =?us-ascii?q?4lLfCVNiHATkH1Se3ghAhEBVRMXCwkFiTgKgxwpgUUmgQqDC4Ezg3KBZwlhi?=
 =?us-ascii?q?EmBDYE+gVkBgzdKg0+BeQU4Cj+CUWtOOQINAjeCKIEOglqFAE0dQAMLbT01F?=
 =?us-ascii?q?BusOYFbSIMFRSgQBAEEDAsCLAINcBgkQS0DkkpLB4JnjmKBOZ9KhCGMFpUmT?=
 =?us-ascii?q?RMDg2+NAYZEOpJBmHaNe5VhhRcCBAYFAheBZzqBWzMaCBsVgyITDDMZD44tD?=
 =?us-ascii?q?QmDWIRZO7oFQzICATgCBwsBAQMJi1aBfAEB?=
IronPort-Data: A9a23:FvU1bqM2Hhuk3+bvrR29kMFynXyQoLVcMsEvi/4bfWQNrUol1zEHy
 2YfWW/SOPyMZDCkctgiaIyw8R9QuJ/WztYwSXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdap1yFDmE/0fF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlvlV
 e/a+ZWFZAf0gWMsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68pXEXgxONM6w74pMW0Vx
 +JGcQgDPg/W0opawJrjIgVtrt4oIM+uN4QFtzQ9izrYFv0hB5vERs0m5/cBg2x23Z8ITK2YP
 pdHAdZsREyojxlnM1IWA486lfyAjXjkeDoeo1WQzUYyyzKNklYsieWzb7I5fPTaV+FHpm+Dn
 VvYpWjfIzxCC96l7ByKpyfEaujnxn6jB9lIS9VU7MVCnFqJ2GUXBAY+UVq9vOn8hEmjXd5WN
 00T/Gwpt6da3EiqSMTtGhCip3CflhodQMZLVeoo7AiH0ezT+QnxLmwFSCNRLdI9uMIoSDgCy
 FCEhZXqCCZpvbnTTmiSnp+KrCm1EToYK24cIysFSxYVpd75r8cujXrnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvjCihqZvJZgo04BjHUGW46A9weI+iYcqv81ezxexdN5rcQF6b+
 XwFndWOxP4BAIvLlyGXRugJWraz6J6tLDrbhVtmGYEJ6zCo4zioduh47zhkNW9mO9wVdiLuJ
 knepWt57pJVOnzsaahseIO3I9wwyrTnE5LgW5j8bsFPa55+dwaA1CVvY1OAmWnpkUIlm6h5M
 pCeGftAFl4AAqhhiTGxXepYjPkgxzs1wiXYQpWTIwmbPaS2W0eIcLAAbnm3Nr4J4Pi2vluMy
 9gPKJ7fo/lAa9HWbi7S+I8VCFkFK3knGJz7w/C7kMbdfmKK/0l/V5fsLaMdRmBzo0hCeg71E
 pyVQERUzh/0gmfKbFjMYXF4Y7SpVpF6xZ7aAcDOFQj0s5TASd/zhEv6S3fRVeJ6nACE5aUoJ
 8Tpg+3aXpxyps3volzxl6XVoo14bwiMjgmTJSejazVXV8c/HVOTooW6L1C2rnhm4s+LWS0W/
 eXIOuTzHMpreuieJJyKAB5S5wrr5CFGybgas7XgeYEKIRiEHHdWx9zZ1aJvfJpWdn0vNxOR1
 h2dBl8DtPLRroouuNjPjubskmtaO7UWI6auJEGCtezeHXCDpgKLmNYQOM7WJmq1fD2vp82fi
 RB9kquU3Asvxgga6uKR0t9DkMoD2jcYj+UHlV88QyuXPgvD53EJCiDu4PSjf5Zlntdx0TZak
 GrWkjWGEd1l4P/YLWM=
IronPort-HdrOrdr: A9a23:lRCHlqlZzZSEcjSRQa3F8T9TXMDpDfID3DAbv31ZSRFFG/FwWf
 rAoB0+726QtN9xYgBDpTnuAsO9qB/nmKKdpLNhWYtKPzOW21dATrsC0WKK+VSJcBEWtNQ86U
 4KScZD4bPLYWRSvILT/BS4H9E8wNOO7aykwdvFw2wFd3AMV0mlhD0Jczpy1SZNNW97OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AXp24JGsFh2/+uU3Er4puKZVJ6IsaS2Dky3KOAXb?=
 =?us-ascii?q?gV1ZlE4+LFwao9vN7xp8=3D?=
X-Talos-MUID: 9a23:w5wbjQrd+hl7jmlbCOUez2FwENVQyr+VMV5XnbMnlpG7NxZVHTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,258,1719878400"; 
   d="scan'208";a="266251567"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 21:45:26 +0000
Received: from localhost ([10.239.198.28])
	(authenticated bits=0)
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48PLjMBV025421
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Sep 2024 21:45:25 GMT
Date: Thu, 26 Sep 2024 00:45:18 +0300
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.198.28, [10.239.198.28]
X-Outbound-Node: rcdn-core-5.cisco.com
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
From: Ariel Miculas via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 24/09/26 12:35, Gao Xiang wrote:
> Hi Ariel,
> 
> On 2024/9/25 23:48, Ariel Miculas wrote:
> 
> ...
> 
> > I share the same opinions as Benno that we should try to use the
> > existing filesystem abstractions, even if they are not yet upstream.
> > Since erofs is a read-only filesystem and the Rust filesystem
> > abstractions are also used by other two read-only filesystems (TarFS and
> > PuzzleFS), it shouldn't be too difficult to adapt the erofs Rust code so
> > that it also uses the existing filesystem abstractions. And if there is
> > anything lacking, we can improve the existing generic APIs. This would
> > also increase the chances of upstreaming them.
> 
> I've expressed my ideas about "TarFS" [1] and PuzzleFS already: since
> I'm one of the EROFS authors, I should be responsible for this
> long-term project as my own promise to the Linux community and makes
> it serve for more Linux users (it has not been interrupted since 2017,
> even I sacrificed almost all my leisure time because the EROFS project
> isn't all my paid job, I need to maintain our internal kernel storage
> stack too).
> 
> [1] https://lore.kernel.org/r/3a6314fc-7956-47f3-8727-9dc026f3f50e@linux.alibaba.com
> 
> Basically there should be some good reasons to upstream a new stuff to
> Linux kernel, I believe it has no exception on the Rust side even it's
> somewhat premature: please help compare to the prior arts in details.
> 
> And there are all thoughts for reference [2][3][4][5]:
> [2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
> [3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
> [4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
> [5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/
> 
> Here still, I do really want to collaborate with you on your
> reasonable use cases.  But if you really want to do your upstream
> attempt without even any comparsion, please go ahead because I
> believe I can only express my own opinion, but I really don't
> decide if your work is acceptable for the kernel.
> 

Thanks for your thoughts on PuzzleFS, I would really like if we could
centralize the discussions on the latest patch series I sent to the
mailing lists back in May [1]. The reason I say this is because looking
at that thread, it seems there is no feedback for PuzzleFS. The feedback
exists, it's just scattered throughout different mediums. On top of
this, I would also like to engage in the discussions with Dave Chinner,
so I can better understand the limitations of PuzzleFS and the reasons
for which it might be rejected in the Linux Kernel. I do appreciate your
feedback and I need to take my time to respond to the technical issues
that you brought up in the github issue.

However, even if it's not upstream, PuzzleFS does use the latest Rust
filesystem abstractions and thus it stands as an example of how to use
them. And this thread is not about PuzzleFS, but about the Rust
filesystem abstractions and how one might start to use them. That's
where I offered to help, since I already went through the process of
having to use them.

[1] https://lore.kernel.org/all/20240516190345.957477-1-amiculas@cisco.com/

> > 
> > I'm happy to help you if you decide to go down this route.
> 
> Again, the current VFS abstraction is totally incomplete and broken
> [6].

If they're incomplete, we can work together to implement the missing
functionalities. Furthermore, we can work to fix the broken stuff. I
don't think these are good reasons to completely ignore the work that's
already been done on this topic.

By the way, what is it that's actually broken? You've linked to an LWN
article [2] (or at least I think your 6th link was supposed to link to
"Rust for filesystems" instead of the "Committing to Rust in the kernel"
one), but I'm interested in the specifics. What exactly doesn't work as
expected from the filesystem abstractions?

[2] https://lwn.net/Articles/978738/

> 
> I believe it should be driven by a full-featured read-write fs [7]
> (even like a simple minix fs in pre-Linux 1.0 era) and EROFS will

I do find it weird that you want a full-featured read-write fs
implemented in Rust, when erofs is a read-only filesystem.

> use Rust in "fs/erofs" as the experiment, but I will definitely
> polish the Rust version until it looks good before upstreaming.

I honestly don't see how it would look good if they're not using the
existing filesystem abstractions. And I'm not convinced that Rust in the
kernel would be useful in any way without the many subsystem
abstractions which were implemented by the Rust for Linux team for the
past few years.

Cheers,
Ariel

> 
> I really don't want to be a repeater again.
> 
> [6] https://lwn.net/SubscriberLink/991062/9de8e9a466a3faf5
> [7] https://lore.kernel.org/linux-fsdevel/ZZ3GeehAw%2F78gZJk@dread.disaster.area
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Cheers,
> > Ariel
> 
