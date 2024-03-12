Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 289A287925D
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 11:45:37 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WqgFQr/z;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tv9KB6v0Mz3dRt
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 21:45:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WqgFQr/z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tv9K71cVjz3bw2
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Mar 2024 21:45:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710240327; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=cLF2JsP1WWf0JwDUGD4me/QAqgZHNzA2kvo/ggIbP5A=;
	b=WqgFQr/zgRh6Bbxr1cO1Y3nhWra920uODuofEY9lWLhB+dP7bzewxAMtJvsV/v82fP7l40GFEGtOe9SiJb5wsI1szufW3wXE+3tm+BWGLvkv24luYjLO8ctn9qxShEBFHr00ljnBZ0PfDz2b3rpDuQzTY/BZZ3RTVt+l44Hn5uQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W2LbcQ0_1710240290;
Received: from 30.221.130.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2LbcQ0_1710240290)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 18:45:26 +0800
Message-ID: <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
Date: Tue, 12 Mar 2024 18:45:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Gael Donval <gael.donval@manchester.ac.uk>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
In-Reply-To: <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/12 18:44, Gao Xiang wrote:
> Hi Gael,
> 
> On 2024/3/12 17:57, Gael Donval wrote:
>> Dear list,
>>
>>     $ mkdir foo && touch foo/bar && mkfs.erofs foo.erofs.img foo
>>     mkfs.erofs 1.7.1
>>     <E> erofs: failed to build shared xattrs: [Error 61] No data available
>>     <E> erofs:     Could not format the device : [Error 61] No data available
>> That is at a location backed by BTRFS (btrfs-progs v6.7.1) on kernel 6.8.0.
>>
>> If I use a TMPFS-supported folder instead all goes well.
>>
>>
>> Of course (NB "-x-1"),
>>
>>     $ mkdir foo && touch foo/bar && mkfs.erofs -x-1 foo.erofs.img foo
>>
>> also works but is not how mkfs.erofs is meant to work in the general case.
> 
> Thanks for your feedback.
> 
> Currently I don't have some BTRFS environment, I could set up one later.
> Yet in parallel could you provide a full message of
> "strace mkfs.erofs -x-1 foo.erofs.img foo" on BTRFS too?

sorry, I meant "strace mkfs.erofs foo.erofs.img foo"

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Kind regards,
>> Gaël
