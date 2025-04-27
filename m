Return-Path: <linux-erofs+bounces-239-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A7A9E039
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 09:04:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zlcyp11pxz2yqp;
	Sun, 27 Apr 2025 17:04:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745737490;
	cv=none; b=XyBJcA6NVQWsCcHiE9w3Tc/YvwN8aDt03zpyEgvOpmV/DIT6dI4b3kmiwIe6sL0/dgM8CH28jnS4ujmFBs/7NOcNsQb4FmcdHqKCY/65OF6pr8A6/znIiNXTjlv7YW/UfGYSF1/KqtxWzMaDgBVc6FarAvelf2vr7k1XFzzPrEct1iDNMIq6ntJ8NphaTs+AjjrrTgdH+E3rC62XByPcsP/21Z/LyMSdOB5tMxIbRLdC8Ivr+ui/jqvaLj/9NGAiPmyHVZ6mmKrKxQTs4jckkZuWIpsq59g0BLM4JhTV+vYyx/dwtjyiJFfQCMsgOZ38SONHqkiyY/36pXczaOu0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745737490; c=relaxed/relaxed;
	bh=ObX9FVUcYVkwto2gw28BXHwwyJG94GIpBSYG+TdwGeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EH10Q+aIPhTWqFzNC4COqah8jQjzXGFBgUGAoR8FLGU/KLskCPV4RS/lrCpgrJiv407zFQobppPVlwRCJlC11AsBSYzRbUKlIvU04OvcqHNllSnA4nbm+9Y8iPc45uje1K+PBkdiNFdHvP9aLDQvoKdG+XwMb4BTqczYHHMQwpXgT0y+6ccwQT8ry69ya43MroN49DYfGvD0LHpe0T2yihtsNOYTnBYrUDJe7ozWt2yvSihMfcpfHi+5o576vQXCHLNCBn4+hxNxDNUhy5l+69dsC3ZpL6hWvm/WZ9ET5O4EPPQVwAhtOyBZuFQSCV0InmwBtIM4KVaRdlHPXGUyfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zlcym6vHtz2ynh
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 17:04:47 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zlct93qWCz5vP6;
	Sun, 27 Apr 2025 15:00:49 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 954B5180080;
	Sun, 27 Apr 2025 15:04:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 27 Apr 2025 15:04:34 +0800
Message-ID: <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
Date: Sun, 27 Apr 2025 15:04:33 +0800
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
Subject: Re: [PATCH] erofs-utils: fix `--blobdev=X`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
 <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
 <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 10:56, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/4/27 10:49, Hongbo Li wrote:
>>
>>
>> On 2025/4/27 10:15, Gao Xiang wrote:
>>> Create one if the file doesn't exist.
>>>
>>> Fixes: b6b741d8daaf ("erofs-utils: lib: get rid of tmpfile()")
>>
>> I think the real fixes should be Fixes: bbeec3c93076 ("erofs-utils: 
>> mkfs: add extra blob device support").
> 
> Prior to b6b741d8daaf, the functionality is ok since
> fopen(..,"wb") will create the file too.

Sorry, you're right, I misread that.

> 
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   lib/blobchunk.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>>> index e6386d6..301f46a 100644
>>> --- a/lib/blobchunk.c
>>> +++ b/lib/blobchunk.c
>>> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, 
>>> erofs_off_t chunksize)
>>>           blobfile = erofs_tmpfile();
>>>           multidev = false;
>>>       } else {
>>> -        blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
>>> +        blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
>>> +                        O_TRUNC | O_BINARY, 0666);
>> To maintain consistency, is it better to set the default permission to 
>> 0644?
> 
> I tend to switch all modes to 0666 around the codebase
> in the future, since umask(022) will mask them into 0644.
> 
but 0644 can clearly show which permissions are set (the default umask 
022 won't change anything). Or if we need to enforce a specific mode, 
can we umask to 0 at the beginning instead of relying on the default umask?

By the way, I have another doubt (just occurred to me when seeing 
O_TRUNC, though it might be unrelated to this change): the chunk-based 
format can't be used together with the "--increase" option. Should we 
add a warning for that?

Thanks,
Hongbo

> Thanks,
> Gao Xiang

