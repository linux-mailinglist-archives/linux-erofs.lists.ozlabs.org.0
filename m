Return-Path: <linux-erofs+bounces-154-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E9A7E524
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Apr 2025 17:49:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWYYf0116z2yrv;
	Tue,  8 Apr 2025 01:49:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744040981;
	cv=none; b=Zi6J5ddEYBGLfqm0Noqj2JDAmlO6BG5D3NPEh/jUHiEky2yf3SAMCvyk/FhLeUT8k+UWX7hEBAyBfKDt/gusieO7ejo6KhQ8K+zt2/Du2qyG1HdYeWbWdsKrY5K4hH7J/De+IOCktPXm6hJF48MOLrTKrR1LZt245dUPJZQXTToAuQxeUzzC9CjTc9iMzaS6pSRR4azKIKhx3HyTELWpzYrVQZGy7UNo447svpDcKQCUdOYfOkPb04uysBtDMCIXUK9XKurxY2G1/MYs0KKSpnbxXkAoCwpkr1EtMgQ25Wg6Chz4pD0smE2ch5A7Bx+uLq9/NR8pCEay4o9gsGaHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744040981; c=relaxed/relaxed;
	bh=Uuao6a3Hk9qEI19jH9g3VC8nk2PN+ye3kVNY+myZ3fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mImZ/BPb/KyIbagY9W9krjnDbzlBQsjeh6yB59dDXZXOlfZQmeV5UaeMysDtt3n/+Pwoq6PfpuX+BdlQ+BITRyAZjbmW2xSfHTodCsTGGdEg6WXq93b9hKnkjwG7STFERKBI++WB2w/yXdS5PuS1sOvJz7D2Wv0UurxdrWxRKeoBaTZRm6HBoilMQLXFu5NG8vhthR14Idzbf9LcmAOmLMy3u0Gf7ga32G3/CKiGQcIXzqXIEPB+RvYThCyCUoU9fK5kvw2rtRhf0vjCZSpkTav/gFUhkEMQaTYkXyAH4dDyp7pMB6nTJo8Z5SGW5XDJTWVHCfb336DeWhiTvGvzGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w52YeEHR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w52YeEHR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWYYb5k51z2yrh
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 01:49:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744040974; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Uuao6a3Hk9qEI19jH9g3VC8nk2PN+ye3kVNY+myZ3fI=;
	b=w52YeEHRNnQwdbFtyiklWiwDRAm340eUSWdLCSYzTVlNE6IJT9d+fLmv5SvZ5eY5rEApIQYNllFLg/o+9JBylJ6DQiJ9WH3eQNcqqizDwoScGa1uGzBoQnzsCON1vYT60SdMmZhpSZlQcI4y8CwyTn5H9bjxbOX+F4xbRfXUmr0=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WW11ulY_1744040971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 07 Apr 2025 23:49:32 +0800
Message-ID: <d4eae031-8fbb-45e2-bdf4-f3a8a034b8ad@linux.alibaba.com>
Date: Mon, 7 Apr 2025 23:49:31 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] erofs: add 'offset' mount option for file-backed &
 bdev-based mounts
To: Karel Zak <kzak@redhat.com>, Sheng Yong <shengyong2021@gmail.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250407110551.1538457-1-shengyong1@xiaomi.com>
 <20250407110551.1538457-2-shengyong1@xiaomi.com>
 <7nupludayogog6jylmwnxwel4zlvfxeozzcg5qkf5g5a5fpt7g@3bgvpbqfuxxa>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7nupludayogog6jylmwnxwel4zlvfxeozzcg5qkf5g5a5fpt7g@3bgvpbqfuxxa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Karel,

On 2025/4/7 19:40, Karel Zak wrote:
> On Mon, Apr 07, 2025 at 07:05:51PM +0800, Sheng Yong wrote:
>> From: Sheng Yong <shengyong1@xiaomi.com>
>>
>> When attempting to use an archive file, such as APEX on android,
>> as a file-backed mount source, it fails because EROFS image within
>> the archive file does not start at offset 0. As a result, a loop
>> device is still needed to attach the image file at an appropriate
>> offset first. Similarly, if an EROFS image within a block device
>> does not start at offset 0, it cannot be mounted directly either.
> 
> Does it work with mount(8)? The mount option offset= has been defined
> for decades as userspace-only and is used for loop devices. If I
> remember correctly, libmount does not send the option to the kernel at
> all. The option also triggers loop device usage by mount(8).
> 
> In recent years, we use the "X-" prefix for userspace options.
> Unfortunately, loop=, offset=, and sizelimit= are older than any
> currently used convention (I see the option in mount code from year
> 1998).
> 
> We can improve it in libmount and add any if-erofs hack there, but my
> suggestion is to select a better name for the mount option. For
> example, erofsoff=, erostart=, fsoffset=, start=, or similar.

Thanks for your suggestion!

it's somewhat weird to use erofsprefix here, I think fsoffset
may be fine.

Thanks,
Gao Xiang

> 
>      Karel
> 
> 


