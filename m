Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F697A9E6
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 02:18:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X72SD5QGBz2yMk
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 10:18:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726532298;
	cv=none; b=Uo6nD4j8DaL4RhVHy1aNC3q0geMfW4rSgals/Vv0juZ7Vko0Nk5CSGnNeLV9rggAEUKQMjVI2rAvHDjUtEsxCjr5NY0B7CzU+dN2xPD+aQUlM1R3GZpv4y7R3CuAwEdM0pE7QNznLSVZP92rs8GVhZ/zLEuheGDH5oqCLjuRxugwCAoIkn3LWWODGNPDHYSlaBMj7lkfCx0y/nLdHktqRIliua+qmd5K4MoNMRXPTxjg1BljYHw/NXMwrLkldjpDw96ETwHzJTuSRfiYHFRVw/w3jk14iGfAy0BQlTPN4JoVFTmw+2lYNZ3OPKhfqRVCMpMI3ok+N51EEArwCUvvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726532298; c=relaxed/relaxed;
	bh=7GIfLCzeyMWB6rR4gwhPkw73w43jwPFWmSDKoY5Td70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDtVC/D4FsbwgdZeXRd7QSYZ25yCyn3ovFETu4CFKQD7VWpPMT6vjuwVQ6FHh2ZEHqr2r4yPBTq4dqnGp2/c5Kq/MAXvq/WJZ71Gt7HWShJTSF5qIL5ZJE+DCusl/AGungEEbfAJ6K/1aSWqF8nZoqb1enO5J0YWEcHafsH/SZJ2/o6aK56ZyMGy9DC2jU6vqYpDzpxADUJIigUIKF1ZTwenEwU3uWZeNyQc2xJ4jIXenxeeUbEC7+LtJb3cWtviFACh1fS5T/u5i9HWmv+h/2CH0HodiPUjiKJ1Dnjph9nwrUkK9l1EhxLQ1UkNJptvSBx7mGqSq5Mize9+mJV8Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n51OusJS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n51OusJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X72S91RWvz2xGW
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 10:18:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726532288; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7GIfLCzeyMWB6rR4gwhPkw73w43jwPFWmSDKoY5Td70=;
	b=n51OusJSW6EkSmJH04obf0NssvbHBOESLGDGO7yR9gayqfoLrw8teR7IXxAwz2OeKzFRwqvljz60rs9AMb9SkISN0qwD7Ene1XW5voa7YezyVbWy1lWeDJCzUSzYG3e5fuPSamQeTfqp8wB6c2+dOgcDholOGDDRRw/gbo/w04Y=
Received: from 30.27.106.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WF9M2-u_1726532286)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 08:18:07 +0800
Message-ID: <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
Date: Tue, 17 Sep 2024 08:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
To: Greg KH <gregkh@linuxfoundation.org>, Yiyang Wu <toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024091655-sneeze-pacify-cf28@gregkh>
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

Hi Greg,

On 2024/9/17 01:55, Greg KH wrote:
> On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
>> diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
>> new file mode 100644
>> index 000000000000..0f1400175fc2
>> --- /dev/null
>> +++ b/fs/erofs/rust/erofs_sys.rs
>> @@ -0,0 +1,22 @@
>> +#![allow(dead_code)]
>> +// Copyright 2024 Yiyang Wu
>> +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> 
> Sorry, but I have to ask, why a dual license here?  You are only linking
> to GPL-2.0-only code, so why the different license?  Especially if you
> used the GPL-2.0-only code to "translate" from.
> 
> If you REALLY REALLY want to use a dual license, please get your
> lawyers to document why this is needed and put it in the changelog for
> the next time you submit this series when adding files with dual
> licenses so I don't have to ask again :)

As a new Rust kernel developper, Yiyang is working on EROFS Rust
userspace implementation too.

I think he just would like to share the common Rust logic between
kernel and userspace.  Since for the userspace side, Apache-2.0
or even MIT is more friendly for 3rd applications (especially
cloud-native applications). So the dual license is proposed here,
if you don't have strong opinion, I will ask Yiyang document this
in the next version.  Or we're fine to drop MIT too.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

