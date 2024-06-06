Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EEB8FDD42
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 05:17:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvqJm6nTMz3cVS
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 13:17:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=black-desk.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.173; helo=mail-pf1-f173.google.com; envelope-from=clx814727823@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvqJh68VNz3cQX
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 13:17:39 +1000 (AEST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025cb09553so420299b3a.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jun 2024 20:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717643858; x=1718248658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/St2fto4ApxlCsSZjOgvPWnSbnMM7v6vWYp+a4yC84=;
        b=GeCIOlUy8TLb3+5qhHSBM1QZmFEYeZH1Zg3jiEn5NyvNOmTOozh4yo+yI9HFT+D/Ca
         FajEhjCnIiWkGT126EGR6p9FKm3k8GhBdxWvdGSCT63oQ0HeZELBZnugxFWyLfTC5iNU
         8xoCf4hMFHlv8xgGZ3sPpsOGGJg+tS/X/CMKP0GwJ7fl0f3jrB/9RZ4iOYeaxCQZYj6q
         GLtW8wPgRje2fBi2jit/PXvzd0LYylWldo95siFntmFAMdtviTwhBu/YkcURTei4cA9H
         aTyeGUD5b7u8mRtCC0/E+ZtMFw1P7koYBTuQTh2DKBhqLEBIGqMROZ3yBTyVgQeA+tIo
         yiGg==
X-Forwarded-Encrypted: i=1; AJvYcCWy31HwXUnXYHcyU8WRhhY1NDgflSGFlfY6p1Z6Gh5zkSvVN5i9etRmaaRdVChPZyv8ZQyANwMfc+IbioQa9WoQV4iPWWBhh5q9fGjj
X-Gm-Message-State: AOJu0YwxPCzTpR/8Wqm+59ShGlnmzepCz4eX7Fv8X38nwbVcAAjAVzOi
	xNrKoBt0OpN2p10m2rN9oSWatR0xzwjjNvKcrj8IGUKOpWMKYioOTvVhdHNHV37qSA==
X-Google-Smtp-Source: AGHT+IESpdd8Nm3oGa1J5HOeiKp95AMbjxGnPZDcWkVrl4C7fA6S9AL9JP6jizN0UvpGvbxyvxcCoQ==
X-Received: by 2002:a05:6a21:6d9a:b0:1af:cd4a:212a with SMTP id adf61e73a8af0-1b2b6e2d286mr5918142637.1.1717643857545;
        Wed, 05 Jun 2024 20:17:37 -0700 (PDT)
Received: from [10.20.52.147] (42-2-126-170.static.netvigator.com. [42.2.126.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4de93csm233269b3a.165.2024.06.05.20.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 20:17:37 -0700 (PDT)
Message-ID: <714a2ab0-331d-41ce-8056-d4f70a8f8272@black-desk.cn>
Date: Thu, 6 Jun 2024 11:17:34 +0800
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
 <7a8d4742-5dc1-434a-806b-0432a5515ebf@black-desk.cn>
 <b638be29-3531-44d8-9599-528e8699cfb1@linux.alibaba.com>
Content-Language: en-US
From: Chen Linxuan <me@black-desk.cn>
In-Reply-To: <b638be29-3531-44d8-9599-528e8699cfb1@linux.alibaba.com>
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

On 2024/6/6 11:13, Gao Xiang wrote:
> 
> 
> On 2024/6/6 11:06, Chen Linxuan wrote:
>> On 2024/6/6 10:45, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/6 10:25, Chen Linxuan wrote:
>>>> Hi,
>>>>
>>>> On 2024/6/6 10:22, Gao Xiang wrote:
>>>>> Hi,
>>>>>
>>>>> On 2024/6/6 10:13, Chen Linxuan wrote:
>>>>>> Hi Xiang!
>>>>>>
>>>>>> On 2024/5/23 16:05, Gao Xiang wrote:
>>>>>>> Hi Comix!
>>>>>>>
>>>>>>> On 2024/5/23 15:31, ComixHe wrote:
>>>>>>>> In some cases, developer may need to integrate erofs-utils into 
>>>>>>>> their
>>>>>>>> proejct as a static library to reduce package dependencies and
>>>>>>>> have more finer control over the feature used by the project.
>>>>>>>
>>>>>>> Thanks for sharing this.
>>>>>>>
>>>>>>>>
>>>>>>>> For exapmle, squashfuse provides a static library 
>>>>>>>> `libsquashfuse.a` and
>>>>>>
>>>>>> We want a static library for running fuse-erofs, maybe 
>>>>>> liberofsfuse or something like that, to make a appimage like 
>>>>>> bundle with erofs.
>>>>>>
>>>>>> For quite a long time, Appimage guys patch the fuse program of 
>>>>>> squashfs to get such a static library, and this patch is accepted 
>>>>>> by Debian.
>>>>>>
>>>>>> https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch
>>>>>>
>>>>>> https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96
>>>>>>
>>>>>> The patch just make a binary to be a static library by changing 
>>>>>> `main` to `fusefs_main`.
>>>>>>
>>>>>
>>>>> Since squashfs don't have any offical libsquashfs, so I guess they 
>>>>> tried
>>>>> export the squashfuse project as a library.
>>>>>
>>>>> But erofs-utils is quite another story since we already have an 
>>>>> offical
>>>>> `liberofs` concept.   If you'd like to export some FUSE interface, 
>>>>> would
>>>>> you mind moving some logic in fuse/ to lib/?  Does this way also work
>>>>> for you?
>>>>
>>>> Sure.
>>>>
>>>> We will send other patches later.
>>>
>>> Err, sorry, a second thought.. If you just would like
>>> to move all code from fuse/main.c to lib/,  I also think
>>> it's somewhat strange.
>>>
>>> So just address your requirement (erofsfuse_main), would
>>> you mind just export liberofsfuse static library instead?
>>> Since it's a bit tangled with libfuse version, so I'm now
>>> hesitated to move into lib/...
>>
>> So you mean that I should export a static library call "liberofsfuse".
>> And the only function it has is erofsfuse_main. Am I right?
> 
> You could export any function in the fuse/main.c, also you
> could rename main() as erofsfuse_main() for the liberofsfuse
> library.
> 
>>
>> But where should I place the source code of this new library? 
>> "liberofsfuse/", "lib/fuse" or somewhere else?
> 
> Just like the current patch, fuse/main.c is okay for me (since

Maybe you want to check the original patch again?

We build liberofsfuse with -Dmain=erofsfuse_main at that patch, which 
sounds like what you suggest here.

Thanks,
Chen Linxuan

> it's tangled with libfuse internals), but I guess we'd better
> to avoid self-contained libmkerofs and more.  `liberofs` is
> much better to be directy used for mkfs, fsck usage.
> 
> Thanks,
> Gao Xiang
> 
> 
>>
>> Thanks,
>> Chen Linxuan
>>
>>>
>>> For mkfs, I guess we will have offical API interfaces for
>>> users to build images later, so libmkerofs is not worthwhile.
>>>
>>> I'm not sure dump.erofs is useful too since low-level APIs
>>> are provided. As for fsck, it's similar to mkfs in the future.
>>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>> Chen Linxuan
>>>>
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>>>
>>>>>
> 

