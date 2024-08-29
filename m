Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA39642D2
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 13:16:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wvdxp69xfz2yy7
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2024 21:15:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724930154;
	cv=none; b=aNOwaVbJZ9/J0YXf1MqCMcaQzDwruvpn6AvNLkyoEFJEAJdgjZeNkOqR2iHBObxgWlTTddyFeNbX/iXmYbPr6lbf3ach4oD7zoP1PTrZz/eIQ2TXylqYZcKDlso9H5iQOco/X1SjnH+tCMLsesGLDCQiHaAg/1F3MpOQ2TjO2aZTHrB1Zw8gEJeNHQL9uD0Yjnuoej09h6L6E+bdyTO9WAwOkuXLRkyEL67H86El5ggnjuvOL458q8sKmoAJbHfEN3PHZn6hx6dr/0rUSkJlMbxXSBlJTWfvUuVPLYwqq6XBaJfuPmEsVUAI4WnnCh0stK8ng1QXsX8pqToiOBtQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724930154; c=relaxed/relaxed;
	bh=zEwB9Si8ou8T0UofhaL2qWYwFGv9oGMQFPNW8VpmMXA=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=IA9PilpvlrWF7W62l1X4OMT4AtJ/IGqgiewSVUJOdia0Aqe8hkKBLy6yAMSJEfqPVYQR5B1A5hb4T7IGCaKImYbl8eBpIi0zau1IxQPuqw41t19dNbEXNpY2Ob8pTO3hTn5daSXEkRYKjlk6Y/BrvgNwINughKsBZbRud9P2i/+HThVU/nG77kSlEJB1DGOR6PfKCl2pgnRQw+H1oRcTFVk70dBVFzt929xLn/jOY3L0P2ltBqUinBJL3HUyMTpYL4FZ3iZN3wpUociTNF4qyL5MUXPWNdrGAEcoV2vNe5qJKuiJXLyZTA4UUUFBnccEwswgM+BuO2Mo5Bw1ahUkKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T6lHOZq3; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T6lHOZq3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wvdxh1SF2z2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2024 21:15:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724930146; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zEwB9Si8ou8T0UofhaL2qWYwFGv9oGMQFPNW8VpmMXA=;
	b=T6lHOZq3GOZGcBBdfa37xk1Lcb47OfOLlBZnQFnM4CXxyuljSjCZGFtkF9YtTbxMMCNz9d3czoP8moK7MYpFwYhb5gbAxSWXIu9f6AzWv9jr62GtVKmAygRmovc4gqoVDteiNM0EBQEg9CULIXPRcKB/MRhVmgzAGbJKRpEkScU=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDsuHEm_1724930143)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 19:15:44 +0800
Message-ID: <76c8e7c1-82c0-46bd-9e46-96c8eaac83b1@linux.alibaba.com>
Date: Thu, 29 Aug 2024 19:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: [PATCH v2] Prevent entering an infinite loop when
 i is 0
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: liujinbao1 <jinbaoliu365@gmail.com>
References: <20240823030525.4081970-1-jinbaoliu365@gmail.com>
 <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
In-Reply-To: <b399e356-6e95-489a-a844-3545a6f22e12@linux.alibaba.com>
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
Cc: mazhenhua@xiaomi.com, liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi liujinbao1,

Since it's a trivial bug which can be simply fixed, I just
would like to confirm if you still have time and interest to
send a workable patch (after a week).

If you don't have time to follow up, I will ask Hongzhen to
fix this with your "Reported-by:" tomorrow.

Thanks,
Gao Xiang

On 2024/8/23 20:03, Gao Xiang wrote:
> 
> 
> On 2024/8/23 11:05, liujinbao1 wrote:
>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>
>> When i=0 and err is not equal to 0,
>> the while(-1) loop will enter into an
>> infinite loop. This patch avoids this issue.
>>
>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
>> ---
>>   fs/erofs/decompressor.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>>> Hi,
> 
> The patch is corrupted and the patch subject
> line is also broken.
> 
> I think it should be:
> [PATCH v2] erofs: prevent entering an infinite loop when i is 0
> 
>>>
>>> On 2024/8/22 14:27, liujinbao1 wrote:
>>>> From: liujinbao1 <liujinbao1@xiaomi.com>
>>>>
>>>> When i=0 and err is not equal to 0,
>>>> the while(-1) loop will enter into an
>>>> infinite loop. This patch avoids this issue.
>>>
>>> Missing your Signed-off-by here.
>>>
>>>> ---
>>>>   fs/erofs/decompressor.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index
>>>> c2253b6a5416..1b2b8cc7911c 100644
>>>> --- a/fs/erofs/decompressor.c
>>>> +++ b/fs/erofs/decompressor.c
>>>> @@ -539,6 +539,8 @@ int __init z_erofs_init_decompressor(void)
>>>>       for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>>               err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>>>               if (err) {
>>>> +                    if (!i)
>>>> +                            return err;
>>>>                       while (--i)
>>>>                               if (z_erofs_decomp[i])
>>>>                                       z_erofs_decomp[i]->exit();
>>>
>>>
>>> Thanks for catching this, how about the following diff (space-demaged).
>>>
>>> If it looks good to you, could you please send another version?
>>
>>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c index c2253b6a5416..c9b2bc1309d2 100644
>>> --- a/fs/erofs/decompressor.c
>>> +++ b/fs/erofs/decompressor.c
>>> @@ -534,18 +534,16 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
>>>
>>> int __init z_erofs_init_decompressor(void)
>>> {
>>> -      int i, err;
>>> +      int i, err = 0;
>>>
>>>         for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>>>                 err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
>>> -              if (err) {
>>> +              if (err && i)
>>>                         while (--i)
>>>                                 if (z_erofs_decomp[i])
>>>                                         z_erofs_decomp[i]->exit();
>>> -                      return err;
>> +                        break;
>>> -              }
>>>         }
>>> -      return 0;
>>> +      return err;
>>> }
>>>
>> missing break?
> 
> Why needing a break?
> 
> Thanks,
> Gao Xiang

