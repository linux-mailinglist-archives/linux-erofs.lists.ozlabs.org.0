Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEFF8FDD27
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 05:06:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vvq3n34qkz3cVG
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 13:06:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=black-desk.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.170; helo=mail-pl1-f170.google.com; envelope-from=clx814727823@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvq3g0glNz3cCb
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 13:06:21 +1000 (AEST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d10so4869015ad.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jun 2024 20:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717643179; x=1718247979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLu1837lrFbMusd+iGiMOEOaw8hrPEhUQTiJll1EkQU=;
        b=E9L+0knffSE3k0ZaPYw1iQgZ/7/MvylWJCvUlzEe6yV0VREvfi+nSbHBbo02obrh4d
         BCZ1LDqSvYQ+GG0RQbQR2EWp2IJUjPRzSVZVhVJwLJijMQ5TyAN69DiPjmPDcj09+hST
         0tG5z0JmwA+Nx2PT1pAroxZr5L6OJEoXzJ5Om9Dr0bdQ1sAE6v4sHXrtNdH5OvlQpxtZ
         exvEQYdLtCygTtSiS0nXbK9kpZ20dIDgIIl1JprkCWMjM8r6qXmZTu+zkoQ8R+b5N3U4
         iCOKj7m3dwVGaAU/62+TF6eguwCq06ztSp9mFG1DH/gRB1YgFnOb4Y7bghM3onEtLBZG
         qSNg==
X-Forwarded-Encrypted: i=1; AJvYcCUGd+Ine3+vOeJxo0DenbYeVUTa0f6QBZbftA+u0Wwy+7UTbDjBr/gbInOwDh/mbFIp4CbFouby18eqIEu3kfm49Yr+BopUkYnOxWoM
X-Gm-Message-State: AOJu0Yw9tDKXdPRI/LIFPLPBrCwfSzUP1Gz+ysZe/MVPjvK9NLn3+BOB
	UMM0Ya76iJP91XXtMTAfQRNajW1WQAaegs7ny2pThL8TgDBzTEaB+LGV/DZeRnbm7Q==
X-Google-Smtp-Source: AGHT+IG9wbRpe/nX8A6u8w/0Y9+ndwD3AH7JSIMbDlBQw5jZvXxGD91YFBdSL0vKdtjkc85VXzUuIQ==
X-Received: by 2002:a17:903:495:b0:1f6:8552:c18c with SMTP id d9443c01a7336-1f6a5a715femr37188685ad.49.1717643179377;
        Wed, 05 Jun 2024 20:06:19 -0700 (PDT)
Received: from [10.20.52.147] ([191.96.243.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccfc8sm2731305ad.159.2024.06.05.20.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 20:06:19 -0700 (PDT)
Message-ID: <7a8d4742-5dc1-434a-806b-0432a5515ebf@black-desk.cn>
Date: Thu, 6 Jun 2024 11:06:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
 <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
 <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
 <b11a08dd-cb27-4352-b031-2d0ab7b04fe8@linux.alibaba.com>
 <04076ce5-ea41-498f-b053-e51f00cf26e1@black-desk.cn>
 <9e406891-6afb-46ce-8382-ce9b1025e05e@linux.alibaba.com>
Content-Language: en-US
From: Chen Linxuan <me@black-desk.cn>
In-Reply-To: <9e406891-6afb-46ce-8382-ce9b1025e05e@linux.alibaba.com>
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

On 2024/6/6 10:45, Gao Xiang wrote:
> 
> 
> On 2024/6/6 10:25, Chen Linxuan wrote:
>> Hi,
>>
>> On 2024/6/6 10:22, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2024/6/6 10:13, Chen Linxuan wrote:
>>>> Hi Xiang!
>>>>
>>>> On 2024/5/23 16:05, Gao Xiang wrote:
>>>>> Hi Comix!
>>>>>
>>>>> On 2024/5/23 15:31, ComixHe wrote:
>>>>>> In some cases, developer may need to integrate erofs-utils into their
>>>>>> proejct as a static library to reduce package dependencies and
>>>>>> have more finer control over the feature used by the project.
>>>>>
>>>>> Thanks for sharing this.
>>>>>
>>>>>>
>>>>>> For exapmle, squashfuse provides a static library 
>>>>>> `libsquashfuse.a` and
>>>>
>>>> We want a static library for running fuse-erofs, maybe liberofsfuse 
>>>> or something like that, to make a appimage like bundle with erofs.
>>>>
>>>> For quite a long time, Appimage guys patch the fuse program of 
>>>> squashfs to get such a static library, and this patch is accepted by 
>>>> Debian.
>>>>
>>>> https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch
>>>>
>>>> https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96
>>>>
>>>> The patch just make a binary to be a static library by changing 
>>>> `main` to `fusefs_main`.
>>>>
>>>
>>> Since squashfs don't have any offical libsquashfs, so I guess they tried
>>> export the squashfuse project as a library.
>>>
>>> But erofs-utils is quite another story since we already have an offical
>>> `liberofs` concept.   If you'd like to export some FUSE interface, would
>>> you mind moving some logic in fuse/ to lib/?  Does this way also work
>>> for you?
>>
>> Sure.
>>
>> We will send other patches later.
> 
> Err, sorry, a second thought.. If you just would like
> to move all code from fuse/main.c to lib/,  I also think
> it's somewhat strange.
> 
> So just address your requirement (erofsfuse_main), would
> you mind just export liberofsfuse static library instead?
> Since it's a bit tangled with libfuse version, so I'm now
> hesitated to move into lib/...

So you mean that I should export a static library call "liberofsfuse".
And the only function it has is erofsfuse_main. Am I right?

But where should I place the source code of this new library? 
"liberofsfuse/", "lib/fuse" or somewhere else?

Thanks,
Chen Linxuan

> 
> For mkfs, I guess we will have offical API interfaces for
> users to build images later, so libmkerofs is not worthwhile.
> 
> I'm not sure dump.erofs is useful too since low-level APIs
> are provided. As for fsck, it's similar to mkfs in the future.
> 
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Chen Linxuan
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>
>>>> We just want to do the same thing appimage guys do to squashfs.
>>>>
>>>>>> exposes some useful functions, Appimage uses this static library 
>>>>>> to build
>>>>>> image. It could ensure that the executable image can be executed 
>>>>>> directly
>>>>>> on most linux platforms and the user doesn't need to install 
>>>>>> squashfuse
>>>>>> in order to execute the image.
>>>>>>
>>>>>> Signed-off-by: ComixHe <heyuming@deepin.org>
>>>>>> ---
>>>>>>   configure.ac     | 28 ++++++++++++++++++++++++++++
>>>>>>   dump/Makefile.am | 10 ++++++++++
>>>>>>   fsck/Makefile.am | 10 ++++++++++
>>>>>>   fuse/Makefile.am | 10 ++++++++++
>>>>>>   mkfs/Makefile.am | 10 ++++++++++
>>>>>>   5 files changed, 68 insertions(+)
>>>>>>
>>>>>> diff --git a/configure.ac b/configure.ac
>>>>>> index 1989bca..16ddb7c 100644
>>>>>> --- a/configure.ac
>>>>>> +++ b/configure.ac
>>>>>> @@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
>>>>>>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse 
>>>>>> @<:@default=no@:>@])],
>>>>>>      [enable_fuse="$enableval"], [enable_fuse="no"])
>>>>>> +AC_ARG_ENABLE([static-fuse],
>>>>>> +    [AS_HELP_STRING([--enable-static-fuse],
>>>>>> +                    [build erofsfuse as a static library 
>>>>>> @<:@default=no@:>@])],
>>>>>> +    [enable_static_fuse="$enableval"],
>>>>>> +    [enable_static_fuse="no"])
>>>>>> +
>>>>>> +AC_ARG_ENABLE([static-dump],
>>>>>> +    [AS_HELP_STRING([--enable-static-dump],
>>>>>> +                    [build dump.erofs as a static library 
>>>>>> @<:@default=no@:>@])],
>>>>>> +    [enable_static_dump="$enableval"],
>>>>>> +    [enable_static_dump="no"])
>>>>>> +
>>>>>> +AC_ARG_ENABLE([static-mkfs],
>>>>>> +    [AS_HELP_STRING([--enable-static-mkfs],
>>>>>> +                    [build mkfs.erofs as a static library 
>>>>>> @<:@default=no@:>@])],
>>>>>> +    [enable_static_mkfs="$enableval"],
>>>>>> +    [enable_static_mkfs="no"])
>>>>>> +
>>>>>> +AC_ARG_ENABLE([static-fsck],
>>>>>> +    [AS_HELP_STRING([--enable-static-fsck],
>>>>>> +                    [build fsck.erofs as a static library 
>>>>>> @<:@default=no@:>@])],
>>>>>> +    [enable_static_fsck="$enableval"],
>>>>>> +    [enable_static_fsck="no"])
>>>>>
>>>>> But how could we support static libraries from binaries?
>>>>>
>>>>> I guess you need static liberofs instead?
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
>>>
> 

