Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC78FDCAF
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 04:22:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q3hLuE08;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vvp4t0Tdhz3cT1
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 12:22:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q3hLuE08;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvp4l46w5z30W9
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 12:22:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717640528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=a/bfGSV376QcIoNM9tFFBQsVgukK2Pxe4ajjiqPr8Zk=;
	b=Q3hLuE08xvm7dnLoO6RpU3foojOThWbNjk5QSYWodxtMEsP2PKnvK8GmNz2YOinemEXCSKkusuvk1+5Xtac+/cC1BiUUlH868jPNcPwasFifEHX/xFIdUL3Rj7dRvoWCbhtOAoaAcfxEtqZNZOcNswynNSPtlCdfFU0zfDkPG1c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7wUK5j_1717640527;
Received: from 30.97.48.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7wUK5j_1717640527)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 10:22:07 +0800
Message-ID: <b11a08dd-cb27-4352-b031-2d0ab7b04fe8@linux.alibaba.com>
Date: Thu, 6 Jun 2024 10:22:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: Chen Linxuan <me@black-desk.cn>, linux-erofs@lists.ozlabs.org
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
 <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
 <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
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

Hi,

On 2024/6/6 10:13, Chen Linxuan wrote:
> Hi Xiang!
> 
> On 2024/5/23 16:05, Gao Xiang wrote:
>> Hi Comix!
>>
>> On 2024/5/23 15:31, ComixHe wrote:
>>> In some cases, developer may need to integrate erofs-utils into their
>>> proejct as a static library to reduce package dependencies and
>>> have more finer control over the feature used by the project.
>>
>> Thanks for sharing this.
>>
>>>
>>> For exapmle, squashfuse provides a static library `libsquashfuse.a` and
> 
> We want a static library for running fuse-erofs, maybe liberofsfuse or something like that, to make a appimage like bundle with erofs.
> 
> For quite a long time, Appimage guys patch the fuse program of squashfs to get such a static library, and this patch is accepted by Debian.
> 
> https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch
> 
> https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96
> 
> The patch just make a binary to be a static library by changing `main` to `fusefs_main`.
> 

Since squashfs don't have any offical libsquashfs, so I guess they tried
export the squashfuse project as a library.

But erofs-utils is quite another story since we already have an offical
`liberofs` concept.   If you'd like to export some FUSE interface, would
you mind moving some logic in fuse/ to lib/?  Does this way also work
for you?

Thanks,
Gao Xiang


> We just want to do the same thing appimage guys do to squashfs.
> 
>>> exposes some useful functions, Appimage uses this static library to build
>>> image. It could ensure that the executable image can be executed directly
>>> on most linux platforms and the user doesn't need to install squashfuse
>>> in order to execute the image.
>>>
>>> Signed-off-by: ComixHe <heyuming@deepin.org>
>>> ---
>>>   configure.ac     | 28 ++++++++++++++++++++++++++++
>>>   dump/Makefile.am | 10 ++++++++++
>>>   fsck/Makefile.am | 10 ++++++++++
>>>   fuse/Makefile.am | 10 ++++++++++
>>>   mkfs/Makefile.am | 10 ++++++++++
>>>   5 files changed, 68 insertions(+)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 1989bca..16ddb7c 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
>>>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>>>      [enable_fuse="$enableval"], [enable_fuse="no"])
>>> +AC_ARG_ENABLE([static-fuse],
>>> +    [AS_HELP_STRING([--enable-static-fuse],
>>> +                    [build erofsfuse as a static library @<:@default=no@:>@])],
>>> +    [enable_static_fuse="$enableval"],
>>> +    [enable_static_fuse="no"])
>>> +
>>> +AC_ARG_ENABLE([static-dump],
>>> +    [AS_HELP_STRING([--enable-static-dump],
>>> +                    [build dump.erofs as a static library @<:@default=no@:>@])],
>>> +    [enable_static_dump="$enableval"],
>>> +    [enable_static_dump="no"])
>>> +
>>> +AC_ARG_ENABLE([static-mkfs],
>>> +    [AS_HELP_STRING([--enable-static-mkfs],
>>> +                    [build mkfs.erofs as a static library @<:@default=no@:>@])],
>>> +    [enable_static_mkfs="$enableval"],
>>> +    [enable_static_mkfs="no"])
>>> +
>>> +AC_ARG_ENABLE([static-fsck],
>>> +    [AS_HELP_STRING([--enable-static-fsck],
>>> +                    [build fsck.erofs as a static library @<:@default=no@:>@])],
>>> +    [enable_static_fsck="$enableval"],
>>> +    [enable_static_fsck="no"])
>>
>> But how could we support static libraries from binaries?
>>
>> I guess you need static liberofs instead?
>>
>> Thanks,
>> Gao Xiang
>>
