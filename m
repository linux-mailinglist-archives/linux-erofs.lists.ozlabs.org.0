Return-Path: <linux-erofs+bounces-243-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06343A9E158
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 11:17:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zlgvx67MRz2yjN;
	Sun, 27 Apr 2025 19:17:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745745453;
	cv=none; b=nLGcvDU5fpT4MzDHYjkwf7qI3J7P7Cde5Aec1g4ZaSWxLApUQ6zdv0owmCgA+s+0YadgttVwSUK8aTUKvQWW6HKf1kOxHRsieIw4Xk6b1mY6YEDzQ/1X9oU10AJodnrO9bf9a4K2wW+Vi7Xyd91boK0/FcvikHs61T+InFlJFH9SUrpl6teDb+9s8qB4j68UvAGj+/42iDML2k/REF+T7M54KVmf+cfdkRb5RenTr8khi7Lc3tBgzWbPmT4FshaKZ6g45BQaXLT4dKM07Vs6PeUtPd2kpKLt6hikezYGKGndwA1xPbVan0veojA04yZi8OlZDzQVmdebQuSOiKGSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745745453; c=relaxed/relaxed;
	bh=JK5Tn6jP6lVfTZIYlhdz2w8nSBRQTDpOJvixZbhAvJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PLnHz0I7Jp/0MgMb0xmwhcAkE9qpcvkzsltyQ9uxqmt7fQZho0uTzmduTZqPx9wDnSSwwFIoZE5pEkn1Vyu67yMrwDd/HnEzT9PU42Cq/Uonpl2RGKtantd9LEDn9+HYl8uBnqX/0INzQix9M35QArE4H/vGKG2HmsxTRJgu0Y1fv7dzYlh/X0HebQ9m72F/kR4ezE2eA8Qc7fTaYakAzutkTmgcV6qaGvGzQPiHynnUp87nXEstsL4nEK8aPTVbNNjf9AWF4EUPuHIrgN7uln5tVmsNQKV3MGe5iLUrlsRVARyOw2lgsUfiTLpL080h5nDxKquFck8FmpsegQx79w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zlgvw6FWMz2yHj
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 19:17:32 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZlgvS3Vbjz2TSCv;
	Sun, 27 Apr 2025 17:17:08 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E4FE1A0188;
	Sun, 27 Apr 2025 17:17:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 27 Apr 2025 17:17:29 +0800
Message-ID: <7a10f3fb-1da9-49b4-9198-fa369fc64372@huawei.com>
Date: Sun, 27 Apr 2025 17:17:28 +0800
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
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
 <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
 <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
 <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
 <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 15:17, Gao Xiang wrote:
> 
> 
> On 2025/4/27 15:04, Hongbo Li wrote:
>>
>>
>> On 2025/4/27 10:56, Gao Xiang wrote:
> 
> ...
> 
>>>>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>>>>> index e6386d6..301f46a 100644
>>>>> --- a/lib/blobchunk.c
>>>>> +++ b/lib/blobchunk.c
>>>>> @@ -627,7 +627,8 @@ int erofs_blob_init(const char *blobfile_path, 
>>>>> erofs_off_t chunksize)
>>>>>           blobfile = erofs_tmpfile();
>>>>>           multidev = false;
>>>>>       } else {
>>>>> -        blobfile = open(blobfile_path, O_WRONLY | O_BINARY);
>>>>> +        blobfile = open(blobfile_path, O_WRONLY | O_CREAT |
>>>>> +                        O_TRUNC | O_BINARY, 0666);
>>>> To maintain consistency, is it better to set the default permission 
>>>> to 0644?
>>>
>>> I tend to switch all modes to 0666 around the codebase
>>> in the future, since umask(022) will mask them into 0644.
>>>
>> but 0644 can clearly show which permissions are set (the default umask 
>> 022 won't change anything). Or if we need to enforce a specific mode, 
>> can we umask to 0 at the beginning instead of relying on the default 
>> umask?
> 
> see fopen(3): https://man7.org/linux/man-pages/man3/fopen.3.html
> 
> In short, I'd like to change all 0644 to 0666 since
> there is no reason to mask off other permissions
> unless umask is also effective.
> 
> Or do you have other concerns?
> 
>>
>> By the way, I have another doubt (just occurred to me when seeing 
>> O_TRUNC, though it might be unrelated to this change): the chunk-based 
>> format can't be used together with the "--increase" option. Should we 
>> add a warning for that?
> 
> Why?
> 
Because some formatting options cannot be used in combination (such as 
--blobdev --chunksize --incremental=xxx in non-tar mode). But this might 
be outside the scope of this patch.

Perhaps we can add the constraints or some explanation to avoid any 
misunderstanding later. What's about your opinion?

Thanks,
Hongbo
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
>>> Thanks,
>>> Gao Xiang
> 

