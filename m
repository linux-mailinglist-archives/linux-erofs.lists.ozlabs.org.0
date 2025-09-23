Return-Path: <linux-erofs+bounces-1071-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DAB94120
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 05:09:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW4hg4fwDz3cYR;
	Tue, 23 Sep 2025 13:09:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758596979;
	cv=none; b=h+ylwHgQj+Y4dsLsd6O1kiiHUbssrQEYdLwDmswEN1xqGzKBVig4BmXtmzBG9fk4M1AEp5MCBCe/cxA91iIJxj/IaGdcsFZ7SQj52AhT+kOCXi0oGIVXYsAnMeFGBI1GcuIwO1wOZcuuZ4cNcJuwYam8jrLehEmvm4PAQJNOLoH2mdb2vWqqu/9Mzz/aYLM5dS80ZC2arDr6dZu3NJV6XAfC69VAhgptCBk+GvWAbbrx5Tybk4E5N4HuQn9ZH72ojtMROck3Mh0YwwMwRg0CqcZLgiUeI70cG+kzwHjmG5SlbqP+MOAlEA4CwnFmLw3ylCGSwGMLXVbKiMZSuSG//w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758596979; c=relaxed/relaxed;
	bh=MSn+Vhnjxo+BI+izC8hXxxMDoNBqF0GPCzYe9ExyK10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEwCyKCqyvDCh1HiE0nwGtieU45VQdq+TzM206gT1VAQyl3jCpPp7gB8QFVbjcSyR3P+lIvtAn1VCu9lRuwfNn+SwnqpfBtwEk1s1ZT7USRmXcN4kcgQlqZk6QIb0w5Mn+r7Eu6g1pDvUzbkI9L8iU53QwxdR9tPdTT1p8DX1cT9pvrJOzqmQ39NcbI2i1SMQhObRbl0uEtx2e4L7/EvpbJ6yp6/hFqPOgPNtAmDxJVUM5MABHkbp/pV+WMFnFsCCOk0wPQuO+NBc4iwiaK1Lxj5P+tZo1Lnza9XVKbJ/0ENdkdc2iJGlxrTcV/TxuA97urc57+a3nRnT+zpbxCvig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SdxRpfpr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SdxRpfpr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW4hd1l9Cz3cYP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 13:09:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758596972; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MSn+Vhnjxo+BI+izC8hXxxMDoNBqF0GPCzYe9ExyK10=;
	b=SdxRpfprdCZmhKj5nIm6J39/V4vwJ4/F1YuQ4grU9PADp8HAYu4C+eUKZTMMyu8G+vQ3zbCEZUrNhL5UwMq59j+eRIRFRcILaS8Beun6T8uVODjMkg3swyAJhs+XpNYnTkJyXFiVyVKZf2D2DJFxp6GYKYQxPPwOxbgC2vgQGNQ=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WodN09V_1758596970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 11:09:30 +0800
Message-ID: <3e67c596-6002-4497-b8a5-70fba7c69e9d@linux.alibaba.com>
Date: Tue, 23 Sep 2025 11:09:29 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
 <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
 <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/23 10:59, Chao Yu wrote:
> On 9/23/25 10:34, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2025/9/23 10:23, Chao Yu wrote:
>>> On 9/22/25 17:29, Bo Liu wrote:
>>>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>>
>>>> Add support for reading to the erofs volume label from the
>>>> FS_IOC_GETFSLABEL ioctls.
>>>>
>>>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>> ---
>>
>> ...
>>
>>>>    +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>>>
>>> #ifdef CONFIG_COMPAT
>>>
>>>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>>> +            unsigned long arg);
>>
>> Since it's a function declaration, when CONFIG_COMPAT is not defined,
>> there is no user to use erofs_compat_ioctl(), so I think it is fine
>> to just leave the declaration here?
> 
> Xiang,
> 
> Sure, it won't affect compile and link, we can leave it as it is since it's trivial.

Yeah, my preference is to avoid unnecessary #ifdef if possible,
anyway (since unused function declarations won't affect anything..)

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> #endif
>>>
>>> Thanks,
>>>
>>>> +
>>>
>>
>>


