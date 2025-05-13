Return-Path: <linux-erofs+bounces-311-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2816AAB5652
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 15:40:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zxczv4tx1z2yZ6;
	Tue, 13 May 2025 23:40:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747143627;
	cv=none; b=l5+m4CWpM9Ei3tEtjr2+fIXHK9cKw8R9UGIJLi0jtRbQtaUImnEKRf/bCu7QPWGApum4UbUxZkDH6chJ0OeGWnJl9vYxFHgEUf6ASQwuThcoB9J3MD5e22KGpv22LIbIE8F30wAy8Pay91Mg+R018lf6kAbwV5lVYLjB6gWxrnEeZkuDVXmEPximWWqQHjIroLN/qVqKcLuBsucXyu3uGsG0shYVEkxFpMP1SLqxMf74iE2zpWWDh96XjZQsJ6dHhf9y1Lo0ljzeC+7xAWwVova8gx5TVFvPC7GW5TPO9Eifr53A3zCRIfx+a5+RuUGRF3dqrpaH6JWmHGh+bBSyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747143627; c=relaxed/relaxed;
	bh=F9k5tA67iu9T+baZ2jT1XQXD75crzacPreodeSrMw38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AKb2AhIdj0nQbrPYDBqIVIN7Kk8AceqvkEF2i72shn3y1plaBoNXJga+4vCXMONAchtyu0spzuZ/nzBs8XDZKg3PAIpLc+8zjedzcFV08j/vI4kuY85TjQAXYz/1iDhMK/o3UP2e/IgG8Po0hL5RnzF6aBPshuif/HKAICITnCKMUyx8vQuShQqu5BBCaNYSi8f8x53c52B8GVvJiHUDRcEhvhZ/ifdg9rZoLatr1Rz9F/HTKfSwUYq5pitqN6lhGB5JEpsEK0bEtE2JU8sS/S35BkPjBFg1q0b+iT5vC7N9ST8uiiRyHDziKUnHoHrRI3IzhVsTmyMLSf67NFoylQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zxczt2yb4z2xdL
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 23:40:24 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zxcy66rz0z1DKYQ;
	Tue, 13 May 2025 21:38:54 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E8D431800B3;
	Tue, 13 May 2025 21:40:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 May 2025 21:40:19 +0800
Message-ID: <47cc3a44-74d7-4c04-a962-139f50c9089d@huawei.com>
Date: Tue, 13 May 2025 21:40:18 +0800
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
Subject: Re: [PATCH v4 2/2] erofs: add 'fsoffset' mount option for file-backed
 & bdev-based mounts
To: Sheng Yong <shengyong2021@gmail.com>, Gao Xiang
	<hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
 <20250408122351.2104507-2-shengyong1@xiaomi.com>
 <4aced850-18a0-4b05-80f4-4f690e387a13@huawei.com>
 <c5110e03-90ea-40be-b05f-bc920332a1e1@linux.alibaba.com>
 <68236af8-6302-44b8-9f6e-d0228bd40b61@gmail.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <68236af8-6302-44b8-9f6e-d0228bd40b61@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/13 19:27, Sheng Yong wrote:
> On 5/13/25 15:17, Gao Xiang wrote:
>>
>>
>> On 2025/5/13 15:06, Hongbo Li wrote:
>>>
>>>
>>> On 2025/4/8 20:23, Sheng Yong wrote:
>>>> From: Sheng Yong <shengyong1@xiaomi.com>
>>>>
>>>> When attempting to use an archive file, such as APEX on android,
>>>> as a file-backed mount source, it fails because EROFS image within
>>>> the archive file does not start at offset 0. As a result, a loop
>>>> device is still needed to attach the image file at an appropriate
>>>> offset first. Similarly, if an EROFS image within a block device
>>>> does not start at offset 0, it cannot be mounted directly either.
>>>>
>>>> To address this issue, this patch adds a new mount option `fsoffset=x'
>>>> to accept a start offset for both file-backed and bdev-based mounts.
>>>> The offset should be aligned to block size. EROFS will add this offset
>>>
>>> Hi Yong,
>>>
>>> Why the offset should be aligned to block size? I mean, we can use 
>>> the original offset directly during read, and then add this offset 
>>> after reading.
>>
>> Currently metabuf and bio are all block-based I/Os (otherwise
>> taking metadata for example, it could cross page boundary), I
> 
> Hi, Hongbo and Xiang,
> 
> I agree that "we cannot handle cross page/block" is the main reason. And
> for use case, e.g APEX file, to achieve a better performance and make it
> easy to extract filesystem image from a APEX file, the fs image is used
> to put at page/block-size-aligned position.
> 

ok, it may be complex, such as reading extra data with an aligned 
position after plus fsoffset and redirecting the internal offset.

Should we consider adding the explanations in Documentation?

Thanks,
Hongbo

> thanks,
> shengyong
> 
>> uess it's complex to support unaligned offsets.  Also it seems
>> lack of use cases?
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Hongbo
>>
>>
> 

