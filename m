Return-Path: <linux-erofs+bounces-1700-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE81CFCAF0
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 09:52:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmMGk4Srxz2xbQ;
	Wed, 07 Jan 2026 19:51:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767775918;
	cv=none; b=ko+Z1f4507zvwQu8h/bU/ykIIAdI663Yl938+fYsRBLs71GFBdJsE/+83xgiv9cl2ccTAqzBN2iktxFsMO7K59OkZogTEg9tiyMmMzybM7Boe0qgvPLCg1/jB5HwdgjTDZf6bg7OAZbW53f9uAEK9M+p4wF1X2yZd/+Jx22B4eQRmxoI9fV5m7tMUeQCzGVczjJgshbLv8VaZrN3R6T4yVBLarexfIZCwJwUg+Slk1TlRlcI+ToyUFgqxKDuqlnuGijRSnNrEYRiMbNpGPaLH2de/Ovb7fzpSjrgWR6geVGHbJh6FCTA1j2XggeTeetc/o6U2+y4b/99XUkE191BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767775918; c=relaxed/relaxed;
	bh=108JVCh9GjW5xEolruiVkAuLbJubn8gbsNhgLVBoKqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WE2t3LDwDOtg8LOnQsuGCb60XZxKSW/wtzAHA8BT0/0YnaFY2K6oV+P6Xo6VWBis+/iMMZWFJIW4VxjjtTLeAPWpBVd/hazvF9rFenuf8SMnKksW3/eg1IDdcs8PyYzfUgwnxJD7hUiKauwkGVSWxqYuPhS3IURY8qlmUXKUU69jzlLJGSyNot6/z++ufZKQ35neuL51zyzdYJfCJ9rFAh8Em12+/ja25Z1whIPYusHem2I+vdwxRaJA6FuZwP9f9lJl4fK3qmSJ68iEBn8aEf4+RKjQCHJiK3NKUfKpmRKS0x/pC4E9KN9pY8BEU/1Bv9CGjGqZ6SamIdH7jljQwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TC6Orfwj; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=TC6Orfwj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmMGg2xbGz2xLR
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 19:51:53 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=108JVCh9GjW5xEolruiVkAuLbJubn8gbsNhgLVBoKqk=;
	b=TC6OrfwjILeUR0KaiqaMcbO4w48VARs0s030Z2ePHb4C042l+lNMSEY4UOVf3It7FQzoGUqwE
	lGF4NhoysCpulm2w2SyOkk+vfiIymdRLydvpPBDq8pHNoIEk+f2HcqZJEnuLWP/0bj4NCYNPujK
	N/37crmhGe9aPhZEIh1vFIo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dmMBp21pBz1cyQn;
	Wed,  7 Jan 2026 16:48:34 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 2989E40539;
	Wed,  7 Jan 2026 16:51:49 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 16:51:48 +0800
Message-ID: <eeb5efea-aa9c-449b-b2f8-157130b02aed@huawei.com>
Date: Wed, 7 Jan 2026 16:51:47 +0800
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
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
 <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
 <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
 <48755c73-323d-469e-9125-07051daf7c19@huawei.com>
 <d82c60eb-a170-48fe-9e50-e64c80681cb6@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d82c60eb-a170-48fe-9e50-e64c80681cb6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/7 15:53, Gao Xiang wrote:
> 
> 
> On 2026/1/7 15:32, Hongbo Li wrote:
>>
>>
>> On 2026/1/7 15:27, Gao Xiang wrote:
>>>
>>>
>>> On 2026/1/7 15:17, Hongbo Li wrote:
>>>> Hi, Xiang
>>>>
>>>
>>> ...
>>>
>>>>>>>> +
>>>>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>>>>> +{
>>>>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>>>>> +    struct erofs_inode_fingerprint fp;
>>>>>>>> +    struct inode *sharedinode;
>>>>>>>> +    unsigned long hash;
>>>>>>>> +
>>>>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>>>>> +        return false;
>>>>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>>>>> +    if (!fp.size)
>>>>>>>> +        return false;
>>>>>>>
>>>>>>> Why not just:
>>>>>>>
>>>>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>>>>          return false;
>>>>>>>
>>>>>>
>>>>>> When erofs_sb_has_ishare_xattrs returns false, 
>>>>>> erofs_xattr_fill_ishare_fp also considers success.
>>>>>
>>>>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>>>>
>>>>
>>>> The MOUNT_INODE_SHARE flag is passed from user's mount option. And 
>>>> it is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do 
>>>> the check when the superblock without ishare_xattrs. (It seems the 
>>>> mount options is static, although it is useless for mounting with 
>>>> inode_share on one EROFS image without ishare_xattrs).
>>>> So should we check that if the superblock has not ishare_xattrs 
>>>> feature, and we return -ENOSUPP?
>>>
>>> I think you should just mask off the INODE_SHARE if the on-disk
>>> compat feature is unavailable, and print a warning just like
>>> FSDAX fallback.
>>>
>>
>> Ok, it seems reasonable, and also can remove the check logic in 
>> erofs_xattr_fill_ishare_fp. I will change in next version.
> 
> I think you should move
> 
> if (!test_opt(&sbi->opt, INODE_SHARE))
>      return -EOPNOTSUPP;
> 
> into erofs_xattr_fill_inode_fingerprint() directly.
> 

Ok.

Thanks,
Hongbo

> Thanks,
> Gao Xiang

