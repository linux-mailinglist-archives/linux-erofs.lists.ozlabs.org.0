Return-Path: <linux-erofs+bounces-851-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122FB2EBFA
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Aug 2025 05:33:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6pnc3dLpz2xc8;
	Thu, 21 Aug 2025 13:33:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755747220;
	cv=none; b=SWZRjOko3ld5V8WybOqS3GNE00HuUMYi+sX8O7iyhd9laZPSTQoQdXOcDM8EZ7itgLz4xcN5BmLT6TVUs8AHW0HQRz/GFNbfrYK45EN+rIxc2XblQRumdXTxr/X3iXJzGYincwOP+DIVKs/fPLkfTQVKjtMcgrRu5P1dKwN3UIvLMAEJ9YlqYgaWvTO2ANljhbFbWy88oH6n17jwXDvxoqHY1Mf0yi2bUGW4GpJsKxRr8Rb5vjsx1MnoCAOHQAX3VvaB02/zeNVY8Ou90s0fDePWxyPEjvXy+iR9cS614ZdjHi8YcwtrGjaa162pmU+awhKONuTO3ohLaHUBXq5rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755747220; c=relaxed/relaxed;
	bh=fmTDa6y/le+D1pKNUq2U9gE0ae6Gp04rGCeVBrRkiDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdHtFn1x+sO9aFAMYKvnp7CodsGHziAleh/kHir6RsWgrSyrDrfzq1O7ufAYcf5a+ayXFaTuX280Od/DVlie0/lsgeCye9rnE5Ue+7xKZIoGs2dRq24j/mRhOveSS/UBZwYYvmvmLlkYiPf000IFh8o6nnyVzRsY/8X9M7ReBeHgqnS3nqBb0ogvlepRVkvo3S2oqLXV+ZYYL6g+nTo6is3Q8ielkCEqjy0m76fdRAaqdQ6EEt7TJW3U+vsFb52R6LE7YgXbyvNvUob+IW8zJXla9IOVDe98ZzJqoh/QvWGJTRXMBJ6md2/j381OI96r61NUpPYdESoToCzGPq10nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YL1FTITi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YL1FTITi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6pnY1YlSz2xQt
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Aug 2025 13:33:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755747203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fmTDa6y/le+D1pKNUq2U9gE0ae6Gp04rGCeVBrRkiDk=;
	b=YL1FTITiGHytP6ilQvtxMyvQg1AOWjdO26arGS7KQVDyGNqOLTUPFeeMPkvMyv8qCT61/4FWQFC5VEZiwItv/CsvoCCjkNUBrbnLu4Hveo6AqnzllpPL28zFykB7FwDdyZjlSNfUZPdtTIn0OZvVyGS5oWBdL0wy1oWbDL+8J7A=
Received: from 30.221.130.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmEW8CL_1755747200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Aug 2025 11:33:21 +0800
Message-ID: <6b611a64-6a63-4588-acbf-dd853d3bc624@linux.alibaba.com>
Date: Thu, 21 Aug 2025 11:33:20 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB61911E8A1B8975C7B69651D9FD32A@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Friendy,

On 2025/8/21 11:17, Friendy.Su@sony.com wrote:
> Hi, Gao,
> 
>> So I tend to just constrain the case to your limited case
>> first, could you explain more if chunk deduplication is
>> needed for your scenarios? and what's your real `chunksize`?
> 
> chunk deduplication is needed.
> 
> As I wrote in commit msg, we expect scenario below:
> 
> 1. mount with -o dax=always,
> 2. application calls mmap(addr, file).
> 3. application read from addr, page fault is triggered.
> We hope in kernel, erofs_dax_vm_ops.huge_fault() can be handled, do not fallback to erofs_dax_vm_ops.fault().

I totally understand the runtime side, but in short:

> 
> This required file body on blob devices aligned on huge page(2M), and deduplicate unit also is 2M. We can specify --dsunit=512, --chunksize=2*1024*1024 to fulfill this.
> 
> I don't think need a new command option.
> Currently, '--dsunit' can be set for formatting blobdev. The following cmdline completes successfully. User certainly thinks mkfs.erofs has executed --dsunit alignment.
> But actually, it does not.  This patch just simply makes actual runtime fit for cmdline looks like.
> 
> mkfs.erofs --blobdev /dev/sdb1 --dsunit 512 ......
> 
> If actually `--dsunit` does not work on blobdev, should prompt warning msg to user.

My cercern is why `--chunksize=4096 --dsunit=512` will not
lead to each 4k chunk to the 2M data boundary, is it obvious?

chunksize = 4096
dsunit = 512 = 2M

inode A (8k)    2M, 4M
inode B (12k)	6M, 2M, 4M, 8M?

Are you sure if there is no such use case in the
future? Mixing `--chunksize=4096 --dsunit=512` seems
non-obvious for this case.

Thanks,
Gao Xiang


> 
> Best Regards
> Friendy Su
> 
> ________________________________________
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> Sent: Thursday, August 21, 2025 10:00
> To: Su, Friendy; linux-erofs@lists.ozlabs.org
> Cc: Mo, Yuezhang; Palmer, Daniel (SGC)
> Subject: Re: [PATCH v1] erofs-utils: mkfs: Implement 'dsunit' alignment on blobdev
> 
> On 2025/8/20 17: 38, Friendy. Su@ sony. com wrote: > Hi, Gao, > >> What's your `--chunksize` ? consider the following: > > chunksize = 4096 > dsunit = 512 = 2M > >> and two inodes: > >> inode A (8k) 2M, 2M+4k
> 
> 
> 
> 
> On 2025/8/20 17:38, Friendy.Su@sony.com wrote:
>> Hi, Gao,
>>
>>> What's your `--chunksize` ? consider the following:
>>
>>     chunksize = 4096
>>     dsunit = 512 = 2M
>>
>>> and two inodes:
>>
>>> inode A (8k)    2M, 2M+4k
>>
>>> inode B (12k)   4M, 2M, 4M+4k, 4M+8k?
>>
>>> Is it possible? what's the expected behavior of
>>> this case.
>>
>> Yes. This is the expected behavior. See runtime below:
> 
> I understand that is the expected behavior according to this
> patch, but I'm just unsure if it's an expected behavior for
> the future wider setups (because some users may use `--dsunit`
> for other usage).
> 
> So I tend to just constrain the case to your limited case
> first, could you explain more if chunk deduplication is
> needed for your scenarios? and what's your real `chunksize`?
> 
> Maybe adding another command option for this is better.
> 
> Thanks,
> Gao Xiang


