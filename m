Return-Path: <linux-erofs+bounces-623-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27FB04FA8
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Jul 2025 06:02:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh5B85ntFz3byh;
	Tue, 15 Jul 2025 14:02:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752552160;
	cv=none; b=DPdB1HzPvrPGo/2Rcpxedfv9b/vmHmEXBuji2p52VYd7bIALVWxK5hBs714VqhWI2pRkYVjl45px873uu6D/GhfynIcDbq9o+EIH5JxWEjzNv+ENfnOYB7thSO5PZvQF7DpDRr0gZADUfFzocTj7h84mjZIcOCB6WWoyI7TSui8+2OAXlkedXfOw5qD3gEKeCNPqZ9Lv0mnwq/ZRrTg8xuMT3xn66RATkh5tIJXjmARZfWVbJmyB0zJqgVXsPxkIv73IKX3mahKnTvXyju5hdjw8UXMtoeoxLAp/4Z7npAQ3bLh6ItS+Q8YWrinWPyI9DX0NEWA8coonEjXgK+AGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752552160; c=relaxed/relaxed;
	bh=wIYZRGrJQEEycgdG+8bi8uq7UDI55eVyQQzVXaOUKtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lod1b7cMGEd6ERzHQqEEFs9sHyzzugDJthJWxKeHFfUkTm3sAZZRGHdtB5x/BNgo6WXo2L9MyRENRQHlCAg1VK0Wev9QJUBiYTBOEGhGoo31B5VX3FTOpztE85B5tDpZHv4wwIak1uHiqT2hia22zh98YbiwEosF+RfCpwIW3mYlehpQmk4krA4SzALsFKlR2zK0SB8TohbOcAT197LjTX0w+yXaCRbtU4Ld8jXRJU20JSrFkoNBQS4zTDUJjqjJ+UunCIarTbeikpYn9SQGsRLlVFbDyqqYbgab+vee3VWMz7ha1Sv5lXitQhNmdqEmmheeLnzGgP+Jg1StU4lcgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh5B75XrXz3bxJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 14:02:37 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bh55G1ZYhz2Cfbj;
	Tue, 15 Jul 2025 11:58:26 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id A22DF14022E;
	Tue, 15 Jul 2025 12:02:32 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 12:02:32 +0800
Message-ID: <565ecd88-4535-4255-92ea-799c93025b66@huawei.com>
Date: Tue, 15 Jul 2025 12:02:31 +0800
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
Subject: Re: [PATCH v2] erofs: support metadata compression
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250711094004.2488-1-liubo03@inspur.com>
 <054c2678-c8a6-48d2-b10d-f051e86d259f@huawei.com>
 <b11bafba-fe9d-47d9-9ba1-1b514bd67f34@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <b11bafba-fe9d-47d9-9ba1-1b514bd67f34@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/14 11:15, Gao Xiang wrote:
> ..
> 
>>>       if (!name)
>>>           return -EINVAL;
>>> @@ -411,9 +416,12 @@ int erofs_getxattr(struct inode *inode, int 
>>> index, const char *name,
>>>       if (it.name.len > EROFS_NAME_LEN)
>>>           return -ERANGE;
>>> +    if (erofs_sb_has_xattr_compr(sbi))
>>
>> Is xattr_compr another feature under meta compr? In my opinion, how 
>> about splitting it with another patch?
> 
> Just answer this in advance, it should be in this patch, or
> as a seperate patch before this patch.
> 
> Otherwise it's non-bisectable (and thus causes a incompat
> feature) because users could use a kernel with metadata
> compression but without erofs_sb_has_xattr_compr, it
> causes the connected features fragmented.
> 

Ok,got it!

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>

