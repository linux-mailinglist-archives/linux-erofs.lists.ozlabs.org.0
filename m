Return-Path: <linux-erofs+bounces-1698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DDCFC5DF
	for <lists+linux-erofs@lfdr.de>; Wed, 07 Jan 2026 08:33:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmKWj3VpKz2xbQ;
	Wed, 07 Jan 2026 18:33:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767771185;
	cv=none; b=ndL6eyKpPiWYkfNUWPxzHEUJmyNoxeRTZ645Z16u68+meVxEp/d45kCQ2dGKW/2EPILScda94b9fEBUJjyS8FeVQC5tDcoZJrN14OhcTPhyUjyLE3Ohjd1cca42zb4NegBb9IvRpMGQCs/ccBZdN2mGQ7gr10j4qQf83wsCdWFOKuY9dV016lTPilgG5EWW4bYJsmyl28vd62+bXJn28+PYaFFBGPKjjZQKy7PoXDR9ngbXDwwsn297hFVu/5tWzXl0xUQhk7pA00h2ThqyGndfuoaE0kmxz1O2MJKDYU6BXTmWIkXa3vStWsB3ETgpSqzZWKG1mWrqHQBd2dS6nIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767771185; c=relaxed/relaxed;
	bh=ovydZChjF6LvSLr66bHJIe5sMD18RDOxmnPkHKcz4s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hg1BUBOkw0fnu5r5TyDSABVez64ZxWTU2PurneyEvOfZvwOoHy0lapOdQGdj++CkAqsxLmMSkwvKGONS3Jx4RtyTVsAusY7vHg0UAqPRjGeMfJTcrcvN4VXc6rRgT9k4ocbfMHwRAOuiz9/+3k6dCHCFPpWNJBoLvxgDY99biZrYipsLAswHstH7HEWqYmzKFidQbvvqSBvzBsjeq62dRgvF8F0BTegX0bqY9Rjf59iUKkzt6EQ96dqMiA+d8cqYh/FKLwo52vwaCOdWADPHUt2V+LBVLraS1v6hMALqaRdhlz/mF0YusLFEEbHBmTLQfdpRG2zyOoPr6+Z6kA9kpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zeDwcGtJ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=zeDwcGtJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmKWf6Z5Cz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 07 Jan 2026 18:33:00 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ovydZChjF6LvSLr66bHJIe5sMD18RDOxmnPkHKcz4s8=;
	b=zeDwcGtJuSIuXrbBqtA+58T16b98ib7rKAlZ7SgCfrAEfzv6/NFdO/Q2H/nWPw/2UHtBu+Lby
	nppAsciwzNZBIAKXHEBD5iGbDByUvtPabFVQgMPRFzzUBqy7/VOX2v5lv9SnrQ3Ti2vFr6bvsCR
	vTnaaq3VyHtuec2QpNlzij4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dmKRk5F9SzKm4Z;
	Wed,  7 Jan 2026 15:29:38 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id BC780402AB;
	Wed,  7 Jan 2026 15:32:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 15:32:54 +0800
Message-ID: <48755c73-323d-469e-9125-07051daf7c19@huawei.com>
Date: Wed, 7 Jan 2026 15:32:53 +0800
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
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <9bacd58e-40be-4250-9fab-7fb8e2606ad8@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/7 15:27, Gao Xiang wrote:
> 
> 
> On 2026/1/7 15:17, Hongbo Li wrote:
>> Hi, Xiang
>>
> 
> ...
> 
>>>>>> +
>>>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>>>> +{
>>>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>>>> +    struct erofs_inode_fingerprint fp;
>>>>>> +    struct inode *sharedinode;
>>>>>> +    unsigned long hash;
>>>>>> +
>>>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>>>> +        return false;
>>>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>>>> +    if (!fp.size)
>>>>>> +        return false;
>>>>>
>>>>> Why not just:
>>>>>
>>>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>>>          return false;
>>>>>
>>>>
>>>> When erofs_sb_has_ishare_xattrs returns false, 
>>>> erofs_xattr_fill_ishare_fp also considers success.
>>>
>>> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
>>>
>>
>> The MOUNT_INODE_SHARE flag is passed from user's mount option. And it 
>> is controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do the 
>> check when the superblock without ishare_xattrs. (It seems the mount 
>> options is static, although it is useless for mounting with 
>> inode_share on one EROFS image without ishare_xattrs).
>> So should we check that if the superblock has not ishare_xattrs 
>> feature, and we return -ENOSUPP?
> 
> I think you should just mask off the INODE_SHARE if the on-disk
> compat feature is unavailable, and print a warning just like
> FSDAX fallback.
> 

Ok, it seems reasonable, and also can remove the check logic in 
erofs_xattr_fill_ishare_fp. I will change in next version.

Thanks,
Hongbo

> Thanks,
> Gao Xiang

