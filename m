Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C847486B1EF
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 15:40:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ztl+Wg8n;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlH7j21m0z3d2S
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 01:40:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ztl+Wg8n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlH7c6cgQz30QJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 01:39:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709131190; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ca6yJLSV+Ch7ojovM1HCGFJfEgLm6QkfkQA0IjBMHpg=;
	b=Ztl+Wg8nulIc0Dk6tPcstvOIdj7N7aORuOTcR6BvKM6ShbzmyFUxg4uebbUAq7tPXwMgGxeVFYh2Gjv3crU4XMPkX8NerGOhfPEofjJPKnGX3E9OXMvv1MG+GUggUHcfqaEE0TSjg05OlXBZYNZssAUWdA8Lkp20OxrKssKJJfg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1Q8d6Z_1709131186;
Received: from 30.25.203.216(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1Q8d6Z_1709131186)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 22:39:48 +0800
Message-ID: <4cc27f19-bf68-4ee9-adb8-4c8d8827637e@linux.alibaba.com>
Date: Wed, 28 Feb 2024 22:39:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: introduce atomic operations
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240228082107.1014131-1-hsiangkao@linux.alibaba.com>
 <a8b23de9-1f35-48e9-a4af-8041bbd89739@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <a8b23de9-1f35-48e9-a4af-8041bbd89739@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/2/28 21:22, Yifan Zhao wrote:
> 
> On 2/28/24 16:21, Gao Xiang wrote:
>> Add some helpers (relaxed semantics) in order to prepare for the
>> upcoming multi-threaded support.
>>
>> For example, compressor may be initialized more than once in different
>> worker threads, resulting in noisy warnings.
>>
>> This patch makes sure that each message will be printed only once by
>> adding `__warnonce` atomic booleans to each erofs_compressor_init().
>>
>> Cc: Yifan Zhao<zhaoyifan@sjtu.edu.cn>
>> Signed-off-by: Gao Xiang<hsiangkao@linux.alibaba.com>
>> ---
>>   include/erofs/atomic.h      | 27 +++++++++++++++++++++++++++
>>   lib/compressor_deflate.c    | 11 ++++++++---
>>   lib/compressor_libdeflate.c |  6 +++++-
>>   lib/compressor_liblzma.c    |  5 ++++-
>>   4 files changed, 44 insertions(+), 5 deletions(-)
>>   create mode 100644 include/erofs/atomic.h
>>
>> diff --git a/include/erofs/atomic.h b/include/erofs/atomic.h
>> new file mode 100644
>> index 0000000..c486491
>> --- /dev/null
>> +++ b/include/erofs/atomic.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
>> +/*
>> + * Copyright (C) 2024 Alibaba Cloud
>> + */
>> +#ifndef __EROFS_ATOMIC_H
>> +#define __EROFS_ATOMIC_H
>> +
>> +/*
>> + * Just use GCC/clang built-in functions for now
>> + * See:https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>> + */
>> +typedef unsigned long erofs_atomic_t;
> 
> According to [1] *__atomic_test_and_set *should**only be used for operands of type bool or char.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
> 
> Maybe add
> 
> /typedef bool erofs_atomic_bool_t;
> /
> 
> for this purpose?
> 
> Otherwise LGTM and I will include it in my patchset.

Ok, I'm fine with that. you could revise it directly.

Thanks,
Gao Xiang
