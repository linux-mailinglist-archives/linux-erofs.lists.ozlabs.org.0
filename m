Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE44A16698
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 07:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737353824;
	bh=1CyzRqIKFOVVVwYrY1Es8wtuIfjuie1vA0jMiw/Zz54=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fkNx8QEN8oRnxrOuVWBU4O1dlujPQ6QwWt0tIUQp76AQKbxnzoIK7YjdbYqcnLce1
	 sOQKm6qBzEoD7wR2artbH83Ui7AnxB1NGRPjC4qH8ionFlI1zLrV3UlBDek5QIOK9u
	 MQ84DZv2okHUmMSRdyj/6II7wSQbJCS71I2hQtUtWH+Df481uLwf4j8WocCHao+DF5
	 3B0CAstoX4BaA+6gacd+fZnnqPpZCHb1xFYw+dFxfjIV9LTY+HjsbWWaKWtrB6u24G
	 QHGzG8EvnWCDeUuW2jvOselanAk50uV2PWC8Sy16OiHqylJZ6jU5oPg0rbDkN2zXUU
	 UI7BaM/iLaLIA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yc0VS4ZD9z301B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 17:17:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737353823;
	cv=none; b=el1R9PiQZrUfHZ6xeo2PmxcqTOFNkekYulRqVztJLaGLE1uTZ6c6K9Nc1MVAI2K6RvwAZGLtYMleMEniq/VvMXY9dzlqA2MxH+ZsbSu1pw1+belZaJ2FpBT5WbznSucT4oiqWBzMelN+BuDAOG7l0J27caMelvRl7EgfuHKuQivjDQBnaYkVifTUsFPpYOUDcSSibTNHGpYwDbW8jHhXVxYbVECiZPFHcAJzTqFF8KWPgi70IRaZPuMw3ARpRk/4pPLdgvsfayDaidjl2q3+LSCOYvFkVCUJS2zSE6GEeB9nxg/CcY5oDn42pvnJ/P6YObcKcKlKgRZw0zVpI3t+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737353823; c=relaxed/relaxed;
	bh=1CyzRqIKFOVVVwYrY1Es8wtuIfjuie1vA0jMiw/Zz54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DFquz1NY9eLH2lB7Rvo0mIJESi9z/fX7HKcueiFiwl9l5MFnODKxEGYkRDFZL6NSE0lJHTDu9CIbRViiJp4tfChDvy7lM//xo4EeOqrj37XrPbiwDpwd+utwgJFQNRCzhexzSOUnmPi7ArC1bN4yUAbHXVQqMqUn73Gpo4MmS/S/bmHiAbwbDprtgSLSmDNl4Dpq9lslteuquWoZYqn6lP7gb6UilbkbKk77VS5C8WvE/f1IuzQ48iDReurS1ofSBUltUGgPpis5ksjwKSP87USwQrHhI7lTyg9r7JEHZd/t7L7swVgGweQQNKdX9ghP1nPCOfjOtV/4DaW23MhF0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yc0VP3z2wz2xWT
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 17:16:59 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yc0QS5QsYz2MWsT;
	Mon, 20 Jan 2025 14:13:36 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C0421402E1;
	Mon, 20 Jan 2025 14:16:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jan 2025 14:16:52 +0800
Message-ID: <0e6a0fac-e9fd-4d5a-ae44-58f575d3da13@huawei.com>
Date: Mon, 20 Jan 2025 14:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
 <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
 <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
 <dd9beb64-3bdb-4f49-a94b-21c039325558@huawei.com>
 <47f74598-1b2f-4308-a8b8-18fc40bafe6d@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <47f74598-1b2f-4308-a8b8-18fc40bafe6d@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 11:46, Gao Xiang wrote:
> 
> 
> On 2025/1/20 11:43, Hongbo Li wrote:
>>
>>
>> On 2025/1/20 11:10, Gao Xiang wrote:
>>>
>>>
>>> On 2025/1/20 11:02, Hongbo Li wrote:
>>>>
>>>>
>>>
>>> ...
>>>
>>>>>>   }
>>>>>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct 
>>>>>> kiocb *iocb,
>>>>>> +                  struct iov_iter *iter)
>>>>>
>>>>> I wonder if it's possible to just extract a folio from
>>>>> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
>>>> Thanks for reviewing. Ok, I'll think about reusing the 
>>>> erofs_fileio_scan_folio logic in later version.
>>>
>>> Thanks.
>>>
>>>>
>>>> Additionally, for the file-backed mount case, can we consider 
>>>> removing the erofs's page cache and just using the backend file's 
>>>> page cache? If in this way, it will use buffer io for reading the 
>>>> backend's mounted files in default, and it also can decrease the 
>>>> memory overhead.
>>>
>>> I think it's too hacky for upstreaming, since EROFS can only
>>> operate its own page cache, otherwise it should only support
>>> overlayfs-like per-inode sharing.
>>>
>>> Per-extent sharing among different filesystems is too hacky
>> It just like the dax mode of erofs (but instead of the dax devices, 
>> it's a backend file). It does not share the page among the different 
>> filesystems, because there is only the backend file's page cache. I 
>> found the whole io path is similar to this direct io mode.
> 
> How do you handle a VMA which is consecutive as an
> EROFS file, but actually mapping to different part
> of the underlay inode, or even different underlay
> inodes?

The mmap is indeed a trouble, I'm still trying to figure out how to 
solve it. :)

Thanks,
Hongbo

> 
> It just cause the current MM layer broken, but FSDAX
> mode is a complete different story.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
>>> on the MM side, but if you have some detailed internal
>>> requirement, you could implement downstream.
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> This is just my initial idea, for uncompressed mode, this should 
>>>> make sense. But for compressed layout, it needs to be verified.
>>>>
>>>> Thanks,
>>>> Hongbo
>>>>
>>>>>
>>>>> It simplifies the codebase a lot, and I think the performance
>>>>> is almost the same.
>>>>>
>>>>> Otherwise currently it looks good to me.
>>>>>
>>>>> Thanks,
>>>>> Gao Xiang
>>>
> 
