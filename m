Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E98FDD37
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 05:13:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lJbWQog8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvqCz3Yhdz3cVY
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 13:13:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lJbWQog8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvqCs3tmWz3cNt
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 13:13:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717643603; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ERxmU9CFhVQjjlBwwYELtgiuvmaaxEDt3Ed97Y9HZTY=;
	b=lJbWQog8vaiSaEXL+1llDFGcaQN8zaICIlljFFN4J3xu5qbJyqtI7oZv58/GEPahxJGvcnGj9Cefr6C3HdLip7V/9gNDW6JvSNe5rJ0X2eSSgzOGDI/LnkxzAKyV/MeOotcB2gINesaGuqiYWiUpLXX0WyG6efi04NaowpQxR7I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7wc-rZ_1717643599;
Received: from 30.97.48.170(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7wc-rZ_1717643599)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:13:20 +0800
Message-ID: <b638be29-3531-44d8-9599-528e8699cfb1@linux.alibaba.com>
Date: Thu, 6 Jun 2024 11:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: support building static library
To: Chen Linxuan <me@black-desk.cn>, linux-erofs@lists.ozlabs.org
References: <43DE50371629F5AE+20240523073104.54391-1-heyuming@deepin.org>
 <cd255c91-ba26-49de-9df6-21306acaad64@linux.alibaba.com>
 <25f7c885-6f4f-4f70-9107-879d5d181f73@black-desk.cn>
 <b11a08dd-cb27-4352-b031-2d0ab7b04fe8@linux.alibaba.com>
 <04076ce5-ea41-498f-b053-e51f00cf26e1@black-desk.cn>
 <9e406891-6afb-46ce-8382-ce9b1025e05e@linux.alibaba.com>
 <7a8d4742-5dc1-434a-806b-0432a5515ebf@black-desk.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7a8d4742-5dc1-434a-806b-0432a5515ebf@black-desk.cn>
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



On 2024/6/6 11:06, Chen Linxuan wrote:
> On 2024/6/6 10:45, Gao Xiang wrote:
>>
>>
>> On 2024/6/6 10:25, Chen Linxuan wrote:
>>> Hi,
>>>
>>> On 2024/6/6 10:22, Gao Xiang wrote:
>>>> Hi,
>>>>
>>>> On 2024/6/6 10:13, Chen Linxuan wrote:
>>>>> Hi Xiang!
>>>>>
>>>>> On 2024/5/23 16:05, Gao Xiang wrote:
>>>>>> Hi Comix!
>>>>>>
>>>>>> On 2024/5/23 15:31, ComixHe wrote:
>>>>>>> In some cases, developer may need to integrate erofs-utils into their
>>>>>>> proejct as a static library to reduce package dependencies and
>>>>>>> have more finer control over the feature used by the project.
>>>>>>
>>>>>> Thanks for sharing this.
>>>>>>
>>>>>>>
>>>>>>> For exapmle, squashfuse provides a static library `libsquashfuse.a` and
>>>>>
>>>>> We want a static library for running fuse-erofs, maybe liberofsfuse or something like that, to make a appimage like bundle with erofs.
>>>>>
>>>>> For quite a long time, Appimage guys patch the fuse program of squashfs to get such a static library, and this patch is accepted by Debian.
>>>>>
>>>>> https://github.com/AppImageCommunity/libappimage/blob/master/src/patches/squashfuse.patch
>>>>>
>>>>> https://salsa.debian.org/sgmoore/squashfuse/-/commit/489b04eb7f5e45478f2ba5cd8d7173bb96
>>>>>
>>>>> The patch just make a binary to be a static library by changing `main` to `fusefs_main`.
>>>>>
>>>>
>>>> Since squashfs don't have any offical libsquashfs, so I guess they tried
>>>> export the squashfuse project as a library.
>>>>
>>>> But erofs-utils is quite another story since we already have an offical
>>>> `liberofs` concept.   If you'd like to export some FUSE interface, would
>>>> you mind moving some logic in fuse/ to lib/?  Does this way also work
>>>> for you?
>>>
>>> Sure.
>>>
>>> We will send other patches later.
>>
>> Err, sorry, a second thought.. If you just would like
>> to move all code from fuse/main.c to lib/,  I also think
>> it's somewhat strange.
>>
>> So just address your requirement (erofsfuse_main), would
>> you mind just export liberofsfuse static library instead?
>> Since it's a bit tangled with libfuse version, so I'm now
>> hesitated to move into lib/...
> 
> So you mean that I should export a static library call "liberofsfuse".
> And the only function it has is erofsfuse_main. Am I right?

You could export any function in the fuse/main.c, also you
could rename main() as erofsfuse_main() for the liberofsfuse
library.

> 
> But where should I place the source code of this new library? "liberofsfuse/", "lib/fuse" or somewhere else?

Just like the current patch, fuse/main.c is okay for me (since
it's tangled with libfuse internals), but I guess we'd better
to avoid self-contained libmkerofs and more.  `liberofs` is
much better to be directy used for mkfs, fsck usage.

Thanks,
Gao Xiang


> 
> Thanks,
> Chen Linxuan
> 
>>
>> For mkfs, I guess we will have offical API interfaces for
>> users to build images later, so libmkerofs is not worthwhile.
>>
>> I'm not sure dump.erofs is useful too since low-level APIs
>> are provided. As for fsck, it's similar to mkfs in the future.
>>
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Chen Linxuan
>>>
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>
