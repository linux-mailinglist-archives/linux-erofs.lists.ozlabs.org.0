Return-Path: <linux-erofs+bounces-453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CAADCD0E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 15:25:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM70f5dFSz30GV;
	Tue, 17 Jun 2025 23:25:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750166738;
	cv=none; b=D20PVygwmNbgRTpSqxOARuybt7B+vM7vaMQspuQ+qPLZgLxMyrCa66m1W+iTblP86sIcncBf8ABSqMA9RxNBHLjUaVlsJOxIPqjBCYYbb3cP8kidd2yQboiE60wJdE1YHrV/bLUG9cGKM7AJxjwnHzc4oa50CqLL/Fego/mHac3GsCntoSLtuvQ4iAmtG+yqILh6SM1ig8Ex1tuuPTrZTI+5kox/VSDhr3AZgMMCsZ/YglwSAM8+654VT/X7TnjM4QS1Oe/KX3BV2TtSimYwLvwUsOqKi32JY2hHWaiwziyOoibiLdPNzsjMaoJ5KDRFHLzrD7M2lQWg+2DdZ1QrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750166738; c=relaxed/relaxed;
	bh=gfi8cHsjcmw1E9DMoR+Li9l7jHJHJaPNfz9M3Il/AYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KYsJ2gPpRgpZDmKYQ7HOqUcNdmP6n010vj3PcSGrBewYVipxBa2QvttGXHSgmfuZyIs7IRyy+R8j0oiw34zwCwAu4MRLrXEhNHzt+LePMz4LE4SJhAdk7OS1RUlf/wwZZt72JtG8NPbpzovicHevTIVB7xpwtg7i6F+phNghVn6rkOlHIh727rjvQPbvLcThBGgznum0nV9MYgT+pPMbyQ0K3yRrWNvL3meoyKoiSKfgNSULLE/fjtvOlzmdpTZZRoNcVMocNLzo8uJnKBN5SuKZu2vvO6B7vXqVCojU5CHKPkEO6wgKQfydNMi/f+tqulCOxUeSFQZhEWItKO7mzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjQNSKWp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjQNSKWp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM70Z40wPz309v
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 23:25:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750166728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gfi8cHsjcmw1E9DMoR+Li9l7jHJHJaPNfz9M3Il/AYg=;
	b=GjQNSKWpO+SybnbQvtuL6EYtzpZ0r7SUWxZ+4IbHp3zLuchlNuA9ca/ITTRiSEXV+WnJdoJ/elem0NssgUL5cUn/ZROprMOM6p0NCwHGP5Snpcl8uKYqIpgH2vkKhiAt0I/uXNVeInpoEyXvkUB2dDa875p5/OcSCY6B2WP3jh8=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0We9l8ta_1750166725 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Jun 2025 21:25:26 +0800
Message-ID: <0f3172b7-abc9-484d-9ad3-a2416923f0ae@linux.alibaba.com>
Date: Tue, 17 Jun 2025 21:25:25 +0800
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
Subject: Re: Unused trace event in erofs
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250612224906.15000244@batman.local.home>
 <0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
 <20250613081728.6212a554@gandalf.local.home>
 <ee0a69d4-907c-4d6a-a0fc-dead71eb1c38@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ee0a69d4-907c-4d6a-a0fc-dead71eb1c38@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/17 18:50, Hongbo Li wrote:
> 
> 
> On 2025/6/13 20:17, Steven Rostedt wrote:
>> On Fri, 13 Jun 2025 14:08:32 +0800
>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>> Hi Steven,
>>>
>>> On 2025/6/13 10:49, Steven Rostedt wrote:
>>>> I have code that will trigger a warning if a trace event is defined but
>>>> not used[1]. It gives a list of unused events. Here's what I have for
>>>> erofs:
>>>>
>>>> warning: tracepoint 'erofs_destroy_inode' is unused.
>>>
>>> I'm fine to remove it, also I wonder if it's possible to disable
>>> erofs tracepoints (rather than disable all tracepoints) in some
>>> embedded use cases because erofs tracepoints might not be useful for
>>> them and it can save memory (and .ko size) as you said below.
>>
>> You can add #ifdef around them.
>>
> Should we introduce a new CONFIG to disable them?

I'd like to, and it seems much helpful to the embedded
device users.

Thanks,
Gao Xiang

