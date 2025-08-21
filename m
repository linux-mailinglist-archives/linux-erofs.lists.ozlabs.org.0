Return-Path: <linux-erofs+bounces-852-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF8B2EC2A
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 05:39:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6pw31V8Yz30T8;
	Thu, 21 Aug 2025 13:39:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755747555;
	cv=none; b=UucF5ilu9sDb8f7HL8ilESb5SV53b8brPq6Vt0ZOvzD0AuxmN+0+zSd9mJrGuUEqI1HaDZp0jBFMjGXkHpoQtgEjEY95RV66nLDk5tANU3GP28ZCAafXx1DZjcmH8XDWl+0LKtGC4DAE/zpbc1+GpcfvO+YyuqPjKi2Zu3PzGuYfnSsIdhByQcnXUq7kfx0lvJTdAQlyQLkIRRYYted15XKkka39VPOx3F7krUoQlghTNRuUcw9h0z4srdTce23c/PJSqP57mHQ0GwjnbjQnA1EC1jxMx1/ZPBP8uInhOsDKJJDjiqwrYm/jaUyEwtf0ukJAFyyPmTd/KGWESc+o1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755747555; c=relaxed/relaxed;
	bh=kufTGZ/KTydt4GmOJc30Tq1GtULgsj+JLUvavGs+ktE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m9mqiFVtCiPwkjhXs0EtXs30hYeB9zovVyO4LSRPfwFhX55IBHCoCgm91TU3JBy/9LP4NCQucu/ruybmstV7eiLibk+Q1aS5Df9DFYnrroiH4/uClBGJRXuHKnwjR91aFzEKrUeq4eP6q608SKDtuFmzJ4fxHkQUX6MyZu/RnORmZ8D6BBm9AgNNa9Ywj5sQHFkiRLI0QasQzM4giEL0EcEtq2X0NqhECXkWWHewK4cE7a4BkYYHywiCKfiCTaKRN0AGnUwZmtDehnVge+RdScywkC81kh33L+aMktpQO21ZCaoUiIJMYCwzXTUYBAiBhbaKH78SqztJKp6fmeBSew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=amhMx7uQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=amhMx7uQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6pw13lFjz2xpn
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 13:39:12 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755747548; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=kufTGZ/KTydt4GmOJc30Tq1GtULgsj+JLUvavGs+ktE=;
	b=amhMx7uQ1SLw23s0pZdoDYlmNpO+dDtMnTx1EigRTuA4o89/It5MBGjJTid71oRzLEuCQNmSxP+RR5YZ1RMh5NV9B6M3ArEmYTMGu4yY1TQoDj1pBHlcOuNiU6OQ0/Kg2IrLe1JdCBe7FfEqxhDkgGlzidCP2WGnoQTZ0kVEyik=
Received: from 30.221.130.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmEbLOz_1755747546 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 11:39:07 +0800
Message-ID: <97d6c19f-1faf-423f-83e7-0996fff2ca26@linux.alibaba.com>
Date: Thu, 21 Aug 2025 11:39:06 +0800
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
Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250820072352.4151620-1-friendy.su@sony.com>
 <39f81655-8bef-428c-843b-b57c9e50c90d@linux.alibaba.com>
 <TY0PR04MB61910F716A77A3E6F0F8FE43FD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <5be2a340-acbc-4ce9-8bb6-1bfb91562944@linux.alibaba.com>
 <TY0PR04MB61914EA9FEB78ACA041F59CBFD33A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <96d466e7-eb96-48b7-bd89-b67381737b4b@linux.alibaba.com>
 <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
In-Reply-To: <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/21 11:33, Gao Xiang wrote:
> Hi Friendy,
> 
> On 2025/8/21 11:17, Friendy.Su@sony.com wrote:
>> Hi, Gao,
>>
>>> So I tend to just constrain the case to your limited case
>>> first, could you explain more if chunk deduplication is
>>> needed for your scenarios? and what's your real `chunksize`?
>>
>> chunk deduplication is needed.
>>
>> As I wrote in commit msg, we expect scenario below:
>>
>> 1. mount with -o dax=always,
>> 2. application calls mmap(addr, file).
>> 3. application read from addr, page fault is triggered.
>> We hope in kernel, erofs_dax_vm_ops.huge_fault() can be handled, do not fallback to erofs_dax_vm_ops.fault().
> 
> I totally understand the runtime side, but in short:
> 
>>
>> This required file body on blob devices aligned on huge page(2M), and deduplicate unit also is 2M. We can specify --dsunit=512, --chunksize=2*1024*1024 to fulfill this.
>>
>> I don't think need a new command option.
>> Currently, '--dsunit' can be set for formatting blobdev. The following cmdline completes successfully. User certainly thinks mkfs.erofs has executed --dsunit alignment.
>> But actually, it does not.  This patch just simply makes actual runtime fit for cmdline looks like.
>>
>> mkfs.erofs --blobdev /dev/sdb1 --dsunit 512 ......
>>
>> If actually `--dsunit` does not work on blobdev, should prompt warning msg to user.
> 
> My cercern is why `--chunksize=4096 --dsunit=512` will not
> lead to each 4k chunk to the 2M data boundary, is it obvious?
> 
> chunksize = 4096
> dsunit = 512 = 2M
> 
> inode A (8k)    2M, 4M
> inode B (12k)    6M, 2M, 4M, 8M?
> 
> Are you sure if there is no such use case in the
> future? Mixing `--chunksize=4096 --dsunit=512` seems
> non-obvious for this case.

Or as I mentioned before, I'm fine to leave each `dsunit` logical
aligned chunks (but not any deduplicated chunk in this logical range)
alignes with dsunit value, it enables PMD-mapping as you mentioned.

But if there is some deduplciated chunks in the logical dsunit
boundary, don't align it at all since there is no real benefit.
Although I'm still not sure what's the default behavior of `dsunit`
for chunks.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> 
>>
>> Best Regards
>> Friendy Su
>>
>> ________________________________________
>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Sent: Thursday, August 21, 2025 10:00
>> To: Su, Friendy; linux-erofs@lists.ozlabs.org
>> Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
>> Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
>>
>> On 2025/8/20 17: 38, Friendy. Su@ sony. com wrote: > Hi, Gao, > >> What's your `--chunksize` ? consider the following: > > chunksize = 4096 > dsunit = 512 = 2M > >> and two inodes: > >> inode A (8k) 2M, 2M+4k
>>
>>
>>
>>
>> On 2025/8/20 17:38, Friendy.Su@sony.com wrote:
>>> Hi, Gao,
>>>
>>>> What's your `--chunksize` ? consider the following:
>>>
>>>     chunksize = 4096
>>>     dsunit = 512 = 2M
>>>
>>>> and two inodes:
>>>
>>>> inode A (8k)    2M, 2M+4k
>>>
>>>> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?
>>>
>>>> Is it possible? what's the expected behavior of
>>>> this case.
>>>
>>> Yes. This is the expected behavior. See runtime below:
>>
>> I understand that is the expected behavior according to this
>> patch, but I'm just unsure if it's an expected behavior for
>> the future wider setups (because some users may use `--dsunit`
>> for other usage).
>>
>> So I tend to just constrain the case to your limited case
>> first, could you explain more if chunk deduplication is
>> needed for your scenarios? and what's your real `chunksize`?
>>
>> Maybe adding another command option for this is better.
>>
>> Thanks,
>> Gao Xiang
> 


