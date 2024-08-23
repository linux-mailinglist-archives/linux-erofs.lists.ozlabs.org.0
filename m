Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F303195CBF9
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 14:04:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqzJ84sLmz2yyM
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2024 22:04:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724414644;
	cv=none; b=UhY8S09wfPjEj2lqvJ0UjLObvV/4jN3vgM0s4ZzE87z+S4DDd2aeQPaGFgV32LpBblPV2FqwL/luJcPH4Pzm9TuqrUuSIOLYU5XxVORyzHCY1KsWhDszhiYg6Ur7u/11QnF5qfkSIJG0hCjcBsxS4koSMi8HjIncItoTsNZ3WD4lSSVdASKkEMhWp3T7QMn+C6yK6Ry2a584q79br4kNMNASnWrs+MrVRQV9KbLnNzoYytU3IvTmsTOvA/Zq5EXn0O1Dg4FsBAywNaEIHhB0r8YeI/FLYRz6Pqudp9MAuyVUmwIL5odoK1gOhTxvTm+R7QIqtC3rhF2DDDf4M6cqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724414644; c=relaxed/relaxed;
	bh=AQqCQwb+Jccrz3xk4NCyo0ZnAcB4vP2QRPGZr5pucPg=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=TNW7K/jTrH3pgRDnw/BE66F/D2hhOm4jDKgl+N6TVUaFj9KAMQ2Uuekh8cw5TKsfTwOSg/9A1TEnWi+HAjLvVml+yBgWMnjFRjvPi0eQkZ9vwJKPzIL9h6ZFpuQczl3+jD/bD8uNQKQlhWUaKOjJE/ZS3kkESyt5se3wP0DYqt0zmBA7KZJtk5iKW/6IF93L4rE4d48K1Gg8aourz6VO5bj4agN0R6Kpk6Lvsen5sTxasqqQfidKOv3Ii5qxBdjnFncg86ofcRUpezEkNbKQv3ChOXPLpdh+SoTO4rFx3VNrmETdkb4innUEmFBXdDgJ5V+aXVlp5V8mCZoJCFbNDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tzHCSiiz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tzHCSiiz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WqzJ25Wmbz2yGv
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2024 22:04:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724414637; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AQqCQwb+Jccrz3xk4NCyo0ZnAcB4vP2QRPGZr5pucPg=;
	b=tzHCSiiz3rdcIB3BfUgBZF7Sb1lr0jsO+f9/msbZhRZH5wqSsulPKKtA117Tn6EY6aiqFyqWM9CcRSWgYcmaqXfXEYm6Bgjum3YUqZtF/T1uDgGDEdEfR3+Wkd2pT9op5HI2+yy9RfUeWdliiCQZ5Z5LgFcKGX39uKaezSqpO+w=
Received: from 172.20.10.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDTYZkX_1724414634)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 20:03:55 +0800
Message-ID: <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
Date: Fri, 23 Aug 2024 20:03:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when
 i is 0
To: liujinbao1 <jinbaoliu365@gmail.com>, xiang@kernel.org
References: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
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
Cc: mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/23 11:05, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> When i=0 and err is not equal to 0,
> the while(-1) loop will enter into an
> infinite loop. This patch avoids this issue.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   fs/erofs/decompressor.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
>> Hi,

The patch is corrupted and the patch subject
line is also broken.

I think it should be:
[PATCH v2] erofs: prevent entering an infinite loop when i is 0

>>
>> On 2024/8/22 14:27, liujinbao1 wrote:
>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>
>>> When i=0 and err is not equal to 0,
>>> the while(-1) loop will enter into an
>>> infinite loop. This patch avoids this issue.
>>
>> Missing your Signed-off-by here.
>>
>>> ---
>>>   fs/erofs/decompressor.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index
>>> c2253b6a5416..1b2b8cc7911c 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>>       for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>               err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>>               if (err) {
>>> +                    if (!i)
>>> +                            return err;
>>>                       while (--i)
>>>                               if (z_erofs_decomp[i])
>>>                                       z_erofs_decomp[i]->exit();
>>
>>
>> Thanks for catching this, how about the following diff (space-demaged).
>>
>> If it looks good to you, could you please send another version?
> 
>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>> --- a/fs/erofs/decompressor.c
>> +++ b/fs/erofs/decompressor.c
>> @@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>
>> int __init z_erofs_init_decompressor(void)
>> {
>> -      int i, err;
>> +      int i, err = 0;
>>
>>         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>> -              if (err) {
>> +              if (err && i)
>>                         while (--i)
>>                                 if (z_erofs_decomp[i])
>>                                         z_erofs_decomp[i]->exit();
>> -                      return err;
> +						break;
>> -              }
>>         }
>> -      return 0;
>> +      return err;
>> }
>>
> missing break?

Why needing a break?

Thanks,
Gao Xiang

