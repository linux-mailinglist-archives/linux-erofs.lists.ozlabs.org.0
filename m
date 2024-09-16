Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E625697A9CF
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 01:58:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X721V30zXz2yNR
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 09:58:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726531116;
	cv=none; b=Dd4jyLkv4wFZQzWOUeKTJFicnsuOQRtVm3y61ZuOm1YexQzNxB6V+GN8L7wG6GZy4ZMhly0w5Eqm02qqEslTJVCuxQW1k4z0pdRTrrR+Kw61eYv/jtlGpgQ7nIrHws+OwyrhwZV0i9Za79LPCCFh34Q3XMheTWPbA/wSgBzoHLBY/q/hqNu2BBRjokTgoQjVGn4unfLoToXeceUe1tE1QeioLOnyYJprjWcYrJyhcy4Y73LtoAkf55vk70gchZvJkK4fbdBt7nn6+/I9baS+Cy4IJonckBu8JA/g4hhjI9ehALnHSrezbKigWi0cJCxYHXgpgmt5WdWj4P9BDW4rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726531116; c=relaxed/relaxed;
	bh=yLAj4r6pPBKpE+85JctjglgVpEkYjcC6fvMHSgvTiHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epwYhgn7CMf939eMdCVSBBL2qoZrMAfsyLrbj+hbYvYcxcukNebBb2kmR/pWKIuD3+nm2YzB2Sw7hF44qKX/g/QG+zKMrEPL+ufRGNT+MX9d7U7FZDp9tb6o3iXpkKrIQ7yjcpBGdmm8tBYCqyqzQK6iPQKwVIbqRdmSv2dUQyD6+qCs3gajiTzLQ6Z2Nv+KMQDRFV62+8/n8ehMgF+wB7Kxqbz5Lvt0RALibojUeYIAoEsAHskaTV0rcJMMecdTCDvwZne4BApxorahLKSvgVa4H6RhO0aVnZQLeCDYrknsLWpkt1yQygByjDgxk2Ae0nVufZnAJjs0I8qHUX3v3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dYw6zgH7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dYw6zgH7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X721R26gmz2xGF
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 09:58:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726531109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yLAj4r6pPBKpE+85JctjglgVpEkYjcC6fvMHSgvTiHQ=;
	b=dYw6zgH7tazVnbY4nIm0pxfuWqk2N5qEeBoMGx7ZqHRcJA6YhPgBUGsi+B/w7hUsebcrEAvUj4R9sZrWRp2vlkG/7I8b7+azeku5/UQRpVc+29kcTf4b8VcyHsYf4WzBEs5W0U7EGGd+Si8pxd50pZO7oawbGy+ZVHrG2UpNH2E=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9MKgN_1726531106)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 07:58:27 +0800
Message-ID: <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
Date: Tue, 17 Sep 2024 07:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Gary Guo <gary@garyguo.net>, Yiyang Wu <toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240916210111.502e7d6d.gary@garyguo.net>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gary,

On 2024/9/17 04:01, Gary Guo wrote:
> On Mon, 16 Sep 2024 21:56:13 +0800
> Yiyang Wu <toolmanp@tlmp.cc> wrote:
> 
>> Introduce Errno to Rust side code. Note that in current Rust For Linux,
>> Errnos are implemented as core::ffi::c_uint unit structs.
>> However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.
>>
>> Since the errno_base hasn't changed for over 13 years,
>> This patch merely serves as a temporary workaround for the missing
>> errno in the Rust For Linux.
>>
>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> As Greg said, please add missing errno that you need to kernel crate
> instead.

I've answered Greg about this in another email.

> 
> Also, it seems that you're building abstractions into EROFS directly
> without building a generic abstraction. We have been avoiding that. If
> there's an abstraction that you need and missing, please add that
> abstraction. In fact, there're a bunch of people trying to add FS

No, I'd like to try to replace some EROFS C logic first to Rust (by
using EROFS C API interfaces) and try if Rust is really useful for
a real in-tree filesystem.  If Rust can improve EROFS security or
performance (although I'm sceptical on performance), As an EROFS
maintainer, I'm totally fine to accept EROFS Rust logic landed to
help the whole filesystem better.

For Rust VFS abstraction, that is a different and indepenent story,
Yiyang don't have any bandwidth on this due to his limited time.
And I _also_ don't think an incomplete ROFS VFS Rust abstraction
is useful to Linux community (because IMO for generic interface
design, we need a global vision for all filesystems instead of
just ROFSes.  No existing user is not an excuse for an incomplete
abstraction.)

If a reasonble Rust VFS abstraction landed, I think we will switch
to use that, but as I said, they are completely two stories.

> support, please coordinate instead of rolling your own.
> 
> You also have been referencing `kernel::bindings::` directly in various
> places in the patch series. The module is marked as `#[doc(hidden)]`
> for a reason -- it's not supposed to referenced directly. It's only
> exposed so that macros can reference them. In fact, we have a policy
> that direct reference to raw bindings are not allowed from drivers.

This patch can be avoided if EUCLEAN is added to errno.

Thanks,
Gao Xiang
