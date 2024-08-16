Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D07953EEC
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 03:30:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="::1"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v5nl+Ebo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlPZG4c8vz2ym1
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2024 11:30:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v5nl+Ebo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlPZ665cLz2xfX
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2024 11:30:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723771815; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=geUku74EdEu3CYFkUrb6ytG+GU3NyPQkQ1ipXiHbMhQ=;
	b=v5nl+EboPaTMn2SLUv4oBio+JjT7jPtNmcnG9GkQU/dYyvEoBvM59eGCAmNyH4+B7V9M1yl0pcPUXBjMNF7mXX5W9LInL1UZYykgYhAql8WmMjAyQe35tNffFBn9FKUPZCkjdM1n/I0soiS3X5Q1oAaKZJxXyV2Gmel3ygyOOGk=
Received: from 30.221.129.229(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCy7Up9_1723771813)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:30:14 +0800
Message-ID: <61d8a190-3520-4d5d-8c80-adeb7172a88f@linux.alibaba.com>
Date: Fri, 16 Aug 2024 09:30:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: adjust volume label maximum length to the
 kernel implementation
To: Naoto Yamaguchi <wata2ki@gmail.com>
References: <20240814153256.18230-1-naoto.yamaguchi@aisin.co.jp>
 <20240814155353.19076-1-naoto.yamaguchi@aisin.co.jp>
 <96efe46b-dcce-4490-bba1-a0b00932d1cc@linux.alibaba.com>
 <CABBJnRYcWVAMg04XsbFOb7zYZWmC17WDx4y_QEj3uVaaSPEG=Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABBJnRYcWVAMg04XsbFOb7zYZWmC17WDx4y_QEj3uVaaSPEG=Q@mail.gmail.com>
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
Cc: Naoto Yamaguchi <naoto.yamaguchi@aisin.co.jp>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/15 22:02, Naoto Yamaguchi wrote:
> Hi Gao.
> 
>>> ---
>>>    mkfs/main.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index b7129eb..ff26c16 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -151,7 +151,7 @@ static void usage(int argc, char **argv)
>>>        printf(
>>>                " -C#                   specify the size of compress physical cluster in bytes\n"
>>>                " -EX[,...]             X=extended options\n"
>>> -             " -L volume-label       set the volume label (maximum 16)\n"
>>> +             " -L volume-label       set the volume label (maximum 15 character)\n"
>>
>> 15 character might be ambiguous here, since there could be other encodings I guess?
> 
> I propose to...
> Solution 1.
>   -L volume-label       set the volume label (maximum 15 ASCII character)
> 
> Solution 2.
>   -L volume-label       set the volume label (maximum 15 bytes)
> 
> 
> Solution 3.  similar to tune2fs
> -L volume-label       set the volume label
> and
> erofs_err("Warning: label too long, truncating.");
> with truncating input string to 15 bytes.
> 
> Which is better?  Could you feedback?

I tend to use solution 2 anyway, solution 3 will truncate
the user input, not quite sure if that's the user's intention.

Thanks,
Gao Xiang

> 
> Thanks.
> Naoto Yamaguchi @ AGL community.
