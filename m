Return-Path: <linux-erofs+bounces-819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C998AB27D9F
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Aug 2025 11:58:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3Hcd3zrYz3cdn;
	Fri, 15 Aug 2025 19:58:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755251921;
	cv=none; b=hHvQ2hQlH5r2S4vZaPAStQnviQpEy5P+0LgGpOGp9UT6TJrKTCuX2isvMiwZtgUeaGl7+u3S1GGvkZOIr2tsy8H0Jst9d+sINBca0xB4sEINI7McgL7ULmSE6foJllppvaoM210xDzdv0cAlrj1dMUwEOBAsL9Q49WRiD9UcnAm87pzFGVIeuJ9dDoFhWnj6kCiItCUQr2l46OAmqI0C9kD+J8+ZlACtLEDxblgCkUErVP21tk1WE790Hk4tI8fq3AJ7kjvF+rV1cXhMSoNli2KB0+OeYoJgXr70gxX1C3XZTym0dgN7COOBMSgiDm7nKKfWKACLpFzAUo9FSI2/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755251921; c=relaxed/relaxed;
	bh=+bKcUuxOtek04ygGs3zY3CQvTa4yL0aQ5Pg8ny0BiVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MLKLEiYbG0FnyspnE5uFvn18aekiAYopLaoHQyNRNEdGDaGJKdqijw7XFz2VGsO/R3UmsIG0kjig9fEdPc6lG80NoIKdwWdnLkAYfa9wCGaNf6Rq7C7FXknp46+ZxEYpPTdOO7oziELgIucwNRAFdmU/Ty2bM/gsiY0i5K4dT9mQxK1AbCepXHWDa5SsLKc6t24O2eiA3jHhDqMny7JUm37a3RD7zf6EFVMqzwQ31G/mYjDAuC8p1c0bbhtsGXGadfZ/fFDp2tSt3M6caNOBwieqN27hbLWn70M6ekzgNsCP6G8hkllrjt+TSU5jPtMpNqdwtBcYknUYRxFROdh3+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Hcc0Xxcz3cdm
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Aug 2025 19:58:39 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c3HXX13Gbz13NJr;
	Fri, 15 Aug 2025 17:55:08 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id E9854180486;
	Fri, 15 Aug 2025 17:58:34 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 17:58:34 +0800
Message-ID: <16d9e356-d0b0-4f62-9d92-9b696d7ffb4b@huawei.com>
Date: Fri, 15 Aug 2025 17:58:33 +0800
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
Subject: Re: [PATCH] erofs-utils: avoid redundant memcpy and sha256() for
 dedupe
To: wangzijie <wangzijie1@honor.com>, <hsiangkao@linux.alibaba.com>
CC: <bintian.wang@honor.com>, <feng.han@honor.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stopire@gmail.com>, <xiang@kernel.org>
References: <f2c93019-5f92-4ee2-88bc-feda330d8a55@linux.alibaba.com>
 <20250815095449.4163442-1-wangzijie1@honor.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20250815095449.4163442-1-wangzijie1@honor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Zijie,

It would be quite appreciated if you could help us polish the 
multithreading -Ededupe implementation. I will try to rebase the 
existing code to the latest codebase ASAP.

You could find the design decision in multithreading -Ededupe in this paper:

https://dl.acm.org/doi/pdf/10.1145/3671016.3671395


Thanks,

Yifan

On 2025/8/15 17:54, wangzijie wrote:
>> Hi Zijie,
>>
>> On 2025/8/15 16:44, wangzijie wrote:
>>> We have already use xxh64() for filtering first for dedupe, when we
>>> need to skip the same xxh64 hash, no need to do memcpy and sha256(),
>>> relocate the code to avoid it.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> Thanks for the patch, it makes sense to me since we only keep one
>> record according to xxh64 (instead of sha256) for now:
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Although I think multi-threaded deduplication is more useful, see:
>> https://github.com/erofs/erofs-utils/issues/25
>> but I'm not sure if you're interested in it... ;-)
> Hi Xiang,
> Thank you for providing this information, I want to optimize mkfs time with
> dedupe option and send this patch. I will find time to research Yifan's demo
> of multi-threaded deduplication and try to provide some help.
>
>> Thanks,
>> Gao Xiang
>
>

