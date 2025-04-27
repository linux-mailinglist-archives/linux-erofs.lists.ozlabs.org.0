Return-Path: <linux-erofs+bounces-242-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB64A9E155
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 11:13:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zlgq83kXRz2yjN;
	Sun, 27 Apr 2025 19:13:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745745204;
	cv=none; b=JvoXYnuUsroCjlzIS5TJ9lm7E4QILayMT3SfAxAf47+9O/5P9vj9lTHf9HdpilbojRcEpSyivO+JQtsa6/Ay23REz/4RB4j5bvC3FARFISsolVEEzYimOH3yCFWzzCPZ1yJ7JS1tWwNoZg2PUgHF/FYGF4Wv3Tths0p+54wvrSOxA4TLool6uVGrdUs3YN+nSsq5C8ZImo+ozLfCLQo7DpINyzNaR5OnQw+dzLMkjHzJi2GlFamg6AveBF1Jb7CjHIxUu6uX2zrjuAEAkWB2nluikRBEExXVvCnKxP86MhA+EpFgtTqZn4yZyanqu7/ExftT0+0+avxnBUtJ7C4zaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745745204; c=relaxed/relaxed;
	bh=CirGkoW+OlOfVCzDsmuG5emTD4MAgiETYkp+kqsdWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kT8wynWL1IIrG730HfnoirCC/se9pKE9b5LsSOCBdcsQs+Kjo7m9UfQhg6VvxaPu7WR8jmdr8ybX7Jj05X8qWNWsIpzsyxc8bkwWBkk1B+HVvL28UmdaKX8sBEH8BNLxNXH2EghWrjMkx0V5UxzHqIDCKwRGAs+iUxSPUHLWp7UcFY/zsyZq5F4zwridfmgKgXf+s7nVuApgI8rfrZLUBfrye48FBzYjwyijPl3g1zCvUqkh6M8wN6x8RjWDNH95rLYvvct2xxLahQSUZhxRA+K3xaHv3bwaTI7yh4Yu3sTBvz7AKKJXBky5xKNmfx4EwydaCGrMxYY+E1kZ1xJjVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zlgq73hTSz2yHj
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 19:13:21 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zlgpb4350z2TS5M;
	Sun, 27 Apr 2025 17:12:55 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 325741400D4;
	Sun, 27 Apr 2025 17:13:17 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 27 Apr 2025 17:13:16 +0800
Message-ID: <9e14c042-4820-4a7f-9c9e-f8916e6f02a4@huawei.com>
Date: Sun, 27 Apr 2025 17:13:15 +0800
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
 <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
 <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

ok, I have not other concerns.

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> 
>>
>> By the way, I have another doubt (just occurred to me when seeing 
>> O_TRUNC, though it might be unrelated to this change): the chunk-based 
>> format can't be used together with the "--increase" option. Should we 
>> add a warning for that?
> 
> Why?
> 
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

