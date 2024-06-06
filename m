Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A98FDC95
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 04:13:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vvnth36mkz3cT1
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 12:13:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=black-desk.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.181; helo=mail-pl1-f181.google.com; envelope-from=clx814727823@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vvntc2b2Zz30WG
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 12:13:26 +1000 (AEST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d0fso4361985ad.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jun 2024 19:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640001; x=1718244801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlAXosdbnODsQ8npxIvKjulkhLzlvL231BCL39VHY6c=;
        b=RdOTi6p7xXJVDOSQkN0a1fuZIBpTiZqbNfEbnht01X3N5e1svwKOqjIZwxXe03LPiT
         vYSdJtbtWS8uL8a1gEuWf4rsOVbTMi+k0ebM2Z8HtABLEwpJfX8h2H8SgICjF1ATjT+b
         arIeX8z8CrFp/LwZfkY9QJuBXpvIxnejo5qybOE/3JIE8itMKnCzgx/kehDcP/V8f3cI
         aTuQWInZCqd1yscxtkKaZhoW+hvB9KSf53JTKaZh2u2FPgg6ggQ+RwHCL5BU7ODuf/23
         vDd9tyn07KcOzGEN0v6NbgN7R7JAw8rbh9lNpHuUYwdvqg2QCOcIumaTCKWccBsM6DJr
         izjQ==
X-Gm-Message-State: AOJu0YxPZyOcOBZKG2igijN6QkxEb4kU2zzbDipO+MKlj2HwGLIbWvwo
	xstn2YGqCYmh9zBv55dp5af8CtBR57XnnB/DOfaui5FUYgrE6vN3ar8rqFTLOo0ZoQ==
X-Google-Smtp-Source: AGHT+IF/rmuLHTqpUIn6TQJ13YDkksI9pWLAJ/0aKSpJPu22mC9L37f92u12GgW/qBianvq6G9QyZQ==
X-Received: by 2002:a17:902:ea0b:b0:1f6:7df5:7c07 with SMTP id d9443c01a7336-1f6a5a1a30bmr51231895ad.39.1717640000768;
        Wed, 05 Jun 2024 19:13:20 -0700 (PDT)
Received: from [10.20.52.147] ([191.96.243.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd81c9c2sm2182615ad.308.2024.06.05.19.13.19
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 19:13:20 -0700 (PDT)
Message-ID: <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
Date: Thu, 6 Jun 2024 10:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: linux-erofs@lists.ozlabs.org
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
 <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
Content-Language: en-US
From: Chen Linxuan <me@black-desk.cn>
In-Reply-To: <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
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

Hi Xiang!

On 2024/5/23 16:05, Gao Xiang wrote:
> Hi Comix!
> 
> On 2024/5/23 15:31, ComixHe wrote:
>> In some cases, developer may need to integrate erofs-utils into their
>> proejct as a static library to reduce package dependencies and
>> have more finer control over the feature used by the project.
> 
> Thanks for sharing this.
> 
>>
>> For exapmle, squashfuse provides a static library `libsquashfuse.a` and

We want a static library for running fuse-erofs, maybe liberofsfuse or 
something like that, to make a appimage like bundle with erofs.

For quite a long time, Appimage guys patch the fuse program of squashfs 
to get such a static library, and this patch is accepted by Debian.

https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch

https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96

The patch just make a binary to be a static library by changing `main` 
to `fusefs_main`.

We just want to do the same thing appimage guys do to squashfs.

>> exposes some useful functions, Appimage uses this static library to build
>> image. It could ensure that the executable image can be executed directly
>> on most linux platforms and the user doesn't need to install squashfuse
>> in order to execute the image.
>>
>> Signed-off-by: ComixHe <heyuming@deepin.org>
>> ---
>>   configure.ac     | 28 ++++++++++++++++++++++++++++
>>   dump/Makefile.am | 10 ++++++++++
>>   fsck/Makefile.am | 10 ++++++++++
>>   fuse/Makefile.am | 10 ++++++++++
>>   mkfs/Makefile.am | 10 ++++++++++
>>   5 files changed, 68 insertions(+)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 1989bca..16ddb7c 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -147,6 +147,30 @@ AC_ARG_ENABLE(fuse,
>>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse 
>> @<:@default=no@:>@])],
>>      [enable_fuse="$enableval"], [enable_fuse="no"])
>> +AC_ARG_ENABLE([static-fuse],
>> +    [AS_HELP_STRING([--enable-static-fuse],
>> +                    [build erofsfuse as a static library 
>> @<:@default=no@:>@])],
>> +    [enable_static_fuse="$enableval"],
>> +    [enable_static_fuse="no"])
>> +
>> +AC_ARG_ENABLE([static-dump],
>> +    [AS_HELP_STRING([--enable-static-dump],
>> +                    [build dump.erofs as a static library 
>> @<:@default=no@:>@])],
>> +    [enable_static_dump="$enableval"],
>> +    [enable_static_dump="no"])
>> +
>> +AC_ARG_ENABLE([static-mkfs],
>> +    [AS_HELP_STRING([--enable-static-mkfs],
>> +                    [build mkfs.erofs as a static library 
>> @<:@default=no@:>@])],
>> +    [enable_static_mkfs="$enableval"],
>> +    [enable_static_mkfs="no"])
>> +
>> +AC_ARG_ENABLE([static-fsck],
>> +    [AS_HELP_STRING([--enable-static-fsck],
>> +                    [build fsck.erofs as a static library 
>> @<:@default=no@:>@])],
>> +    [enable_static_fsck="$enableval"],
>> +    [enable_static_fsck="no"])
> 
> But how could we support static libraries from binaries?
> 
> I guess you need static liberofs instead?
> 
> Thanks,
> Gao Xiang
> 
