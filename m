Return-Path: <linux-erofs+bounces-445-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF58ADC8A4
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 12:50:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM3Yg3BcDz309v;
	Tue, 17 Jun 2025 20:50:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750157431;
	cv=none; b=JLhxrWRRnnEDWAQ45hJYrg2kQuCbK/cqRT4LOeiZAdBqL27jK6E+hpMS0XeOcD4aqlh03UxBffFGvOAtKKccEkgeH0TZBrIWV8VXHuH97FkxOwukaFeUlSiKARJd2Pqyv5pLI8bGDFOAqyGI9qyWxNwqUPYsZk6k+40MiKWYxZxsiTjxPVUcxsMiUgylpKU3HeivHj9TBfpj44tMamEv+QPjcPCBeJqJRkogyKZ1VrXW4DAdy1kaHCx3AvU7dYdjXH7DeHnBNl3B90DvwNZ7v68DPGJfdCCJAN3OjVwq0cZ+Td1acR30uKIy+loRpVOS22ZbXYtOTz+ycq5rpdZr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750157431; c=relaxed/relaxed;
	bh=nIjxZpqi1KKKyie3czOOHVhwkjXiS6ZM/RpZ1EOM0iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UXSILOkctUHOvLM8bMGci06pdHEjjUO1dIptXVEz2K/kenqf0WKMsRs3UX8KSn89Y1VJjlyJChUc+5h/hbOsiCQ7mHiWnbJPLpjBdojMzvIE8nZu/rEhfX7NFaomIriS60jqX1Eq9dO3HUOavcTuOxjmopg5gA74hA0TOn5IZOjgnQe44439jN64M7SrL713OCYyloO4jn1BM2PDC7r5mFATCM1sdK1hS4cap4dSYwc7QDTkTKjn2veBf5wZjGuWpFZFuf3UJ1GW8+y5mhVq6Fg3Fzp4y16yJe2CjwAK/c1aGvpNnpFi7tmDt+E6xjxV0AihjbyfgzplG7g+iTdVVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM3Yf5HNMz307V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 20:50:30 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bM3T422q1z2CfBT
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 18:46:32 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CD5214010D
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 18:50:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 18:50:25 +0800
Message-ID: <ee0a69d4-907c-4d6a-a0fc-dead71eb1c38@huawei.com>
Date: Tue, 17 Jun 2025 18:50:24 +0800
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
To: <linux-erofs@lists.ozlabs.org>
References: <20250612224906.15000244@batman.local.home>
 <0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
 <20250613081728.6212a554@gandalf.local.home>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250613081728.6212a554@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/13 20:17, Steven Rostedt wrote:
> On Fri, 13 Jun 2025 14:08:32 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Hi Steven,
>>
>> On 2025/6/13 10:49, Steven Rostedt wrote:
>>> I have code that will trigger a warning if a trace event is defined but
>>> not used[1]. It gives a list of unused events. Here's what I have for
>>> erofs:
>>>
>>> warning: tracepoint 'erofs_destroy_inode' is unused.
>>
>> I'm fine to remove it, also I wonder if it's possible to disable
>> erofs tracepoints (rather than disable all tracepoints) in some
>> embedded use cases because erofs tracepoints might not be useful for
>> them and it can save memory (and .ko size) as you said below.
> 
> You can add #ifdef around them.
> 
Should we introduce a new CONFIG to disable them?

Thanks,
Hongbo

> Note, the "up to around 5K" means it can add up to that much depending on
> what you have configured. The TRACE_EVENT() macro (and more specifically
> the DECLARE_EVENT_CLASS() which TRACE_EVENT() has), is where all the bloat
> is. I generates unique code for each trace event that prints it, parses it,
> records it, the event fields, and has code specific for perf, ftrace and BPF.
> 
> The DEFINE_EVENT() which can be used to make several events that are
> similar use the same DECLARE_EVENT_CLASS() only takes up around 250 bytes.
> One reason I tell people to use DECLARE_EVENT_CLASS() when you have similar events.
> 
> There's also a DEFINE_EVENT_PRINT() that can use an existing
> DECLARE_EVENT_CLASS() but update the "printk" section. That adds some more
> code (the creation of the print function) but still much smaller than the
> DECLARE_EVENT_CLASS(). But this requires the tracepoint function (what the
> code calls) must have the same prototype.
> 
>>
>>>
>>> Each trace event can take up to around 5K in memory regardless if they
>>> are used or not. Soon there will be warnings when they are defined but
>>> not used. Please remove any unused trace event or at least hide it
>>> under an #ifdef if they are used within configs. I'm planning on adding
>>> these warning in the next merge window.
>>
>> If you don't have some interest to submit a removal patch, I will post
>> a patch later.
> 
> Please make the patch. There's too many for me to do them all.
> 
> Thanks!
> 
> -- Steve
> 

