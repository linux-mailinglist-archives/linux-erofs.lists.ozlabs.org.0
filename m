Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42B8FDCB3
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 04:25:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vvp8z1wNWz3cXZ
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 12:25:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=black-desk.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.171; helo=mail-pf1-f171.google.com; envelope-from=clx814727823@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvp864G7Rz3cVG
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 12:25:09 +1000 (AEST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7024d571d8eso376815b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jun 2024 19:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640708; x=1718245508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSMlFtxyHe7Yy1o3OlYgyypa6lryrsGh9aAvHvPPJA=;
        b=T/snSZvbSzonh2YnQ7Y97xIDEFkrK0HQbh84R/OZUuPHYp6DNUXvvCsj3W5gWOhQeI
         QGjuaHsi4YDXGuieqcgT6qqPxUszkWvqZMA/ITr0ZdwqQiJC30OfMHbN4ErPZ2JrzWl4
         WxoVnfLZ6zqjezzjYCO9O6Zt87VpSHrxDnsMedNjSBfEYKYrIEtUSQtPGlX7MQ8jtet/
         378YVuwt39wZBOBn19EuNN+BdU5YprG8sl2na1nBxicAqIb3jZVxS0tTmjZzHHeooryV
         xdMOl9x3BO7MBDStCVBfS47h0EY7MqlbSMij6Rb8348UoOxugWkDPDxyrpWOhep5CVDi
         mzdA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJ8kQMQ1Eo95PZpBBvmVBTXu2nBZ6D8d2pBeIylfwn5ZhVw5EH4tTyxedn/vg6301m7ohtTyxNKqnvAK3Iek8lC70iTR777B0GU87
X-Gm-Message-State: AOJu0YxlBXxK2f9sbX8et+VHauJk+l0bI17Ee+Zvy60ktkImu9q4tb2H
	nWTos+nHGNdOCTWgaS9oLuqzZjMQLFmpiPDdm8ukLauD4I3h0MIf
X-Google-Smtp-Source: AGHT+IEbxIJPG6H+dO4IqG1c7pvMmffbf5+39BALveSPHVipAxQmEk5GSbEIULkCLbS1VrctjIvOEg==
X-Received: by 2002:a05:6a00:b93:b0:6ed:d8d2:5040 with SMTP id d2e1a72fcca58-703e5a1d57dmr5486261b3a.21.1717640707850;
        Wed, 05 Jun 2024 19:25:07 -0700 (PDT)
Received: from [10.20.52.147] (n119237117100.netvigator.com. [119.237.117.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae01bsm188622a12.66.2024.06.05.19.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 19:25:07 -0700 (PDT)
Message-ID: <04076ce5-ea41-498f-b053-e51f00cf26e1@black-desk.cn>
Date: Thu, 6 Jun 2024 10:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
 <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
 <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
 <b11a08dd-cb27-4352-b031-2d0ab7b04fe8@linux.alibaba.com>
Content-Language: en-US
From: Chen Linxuan <me@black-desk.cn>
In-Reply-To: <b11a08dd-cb27-4352-b031-2d0ab7b04fe8@linux.alibaba.com>
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

On 2024/6/6 10:22, Gao Xiang wrote:
> Hi,
> 
> On 2024/6/6 10:13, Chen Linxuan wrote:
>> Hi Xiang!
>>
>> On 2024/5/23 16:05, Gao Xiang wrote:
>>> Hi Comix!
>>>
>>> On 2024/5/23 15:31, ComixHe wrote:
>>>> In some cases, developer may need to integrate erofs-utils into their
>>>> proejct as a static library to reduce package dependencies and
>>>> have more finer control over the feature used by the project.
>>>
>>> Thanks for sharing this.
>>>
>>>>
>>>> For exapmle, squashfuse provides a static library `libsquashfuse.a` and
>>
>> We want a static library for running fuse-erofs, maybe liberofsfuse or 
>> something like that, to make a appimage like bundle with erofs.
>>
>> For quite a long time, Appimage guys patch the fuse program of 
>> squashfs to get such a static library, and this patch is accepted by 
>> Debian.
>>
>> https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch
>>
>> https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96
>>
>> The patch just make a binary to be a static library by changing `main` 
>> to `fusefs_main`.
>>
> 
> Since squashfs don't have any offical libsquashfs, so I guess they tried
> export the squashfuse project as a library.
> 
> But erofs-utils is quite another story since we already have an offical
> `liberofs` concept.   If you'd like to export some FUSE interface, would
> you mind moving some logic in fuse/ to lib/?  Does this way also work
> for you?

Sure.

We will send other patches later.

Thanks,
Chen Linxuan

> 
> Thanks,
> Gao Xiang
> 
> 
>> We just want to do the same thing appimage guys do to squashfs.
>>
>>>> exposes some useful functions, Appimage uses this static library to 
>>>> build
>>>> image. It could ensure that the executable image can be executed 
>>>> directly
>>>> on most linux platforms and the user doesn't need to install squashfuse
>>>> in order to execute the image.
>>>>
>>>> Signed-off-by: ComixHe <heyuming@deepin.org>
>>>> ---
>>>>   configure.ac     | 28 ++++++++++++++++++++++++++++
>>>>   dump/Makefile.am | 10 ++++++++++
>>>>   fsck/Makefile.am | 10 ++++++++++
>>>>   fuse/Makefile.am | 10 ++++++++++
>>>>   mkfs/Makefile.am | 10 ++++++++++
>>>>   5 files changed, 68 insertions(+)
>>>>
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 1989bca..16ddb7c 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
>>>>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse 
>>>> @<:@default=no@:>@])],
>>>>      [enable_fuse="$enableval"], [enable_fuse="no"])
>>>> +AC_ARG_ENABLE([static-fuse],
>>>> +    [AS_HELP_STRING([--enable-static-fuse],
>>>> +                    [build erofsfuse as a static library 
>>>> @<:@default=no@:>@])],
>>>> +    [enable_static_fuse="$enableval"],
>>>> +    [enable_static_fuse="no"])
>>>> +
>>>> +AC_ARG_ENABLE([static-dump],
>>>> +    [AS_HELP_STRING([--enable-static-dump],
>>>> +                    [build dump.erofs as a static library 
>>>> @<:@default=no@:>@])],
>>>> +    [enable_static_dump="$enableval"],
>>>> +    [enable_static_dump="no"])
>>>> +
>>>> +AC_ARG_ENABLE([static-mkfs],
>>>> +    [AS_HELP_STRING([--enable-static-mkfs],
>>>> +                    [build mkfs.erofs as a static library 
>>>> @<:@default=no@:>@])],
>>>> +    [enable_static_mkfs="$enableval"],
>>>> +    [enable_static_mkfs="no"])
>>>> +
>>>> +AC_ARG_ENABLE([static-fsck],
>>>> +    [AS_HELP_STRING([--enable-static-fsck],
>>>> +                    [build fsck.erofs as a static library 
>>>> @<:@default=no@:>@])],
>>>> +    [enable_static_fsck="$enableval"],
>>>> +    [enable_static_fsck="no"])
>>>
>>> But how could we support static libraries from binaries?
>>>
>>> I guess you need static liberofs instead?
>>>
>>> Thanks,
>>> Gao Xiang
>>>
> 

