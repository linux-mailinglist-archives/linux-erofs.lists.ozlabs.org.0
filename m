Return-Path: <linux-erofs+bounces-380-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B7ACBEB0
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:09:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBG0938LWz2yGM;
	Tue,  3 Jun 2025 13:09:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748920169;
	cv=none; b=DJL8LnPrOQXRchpGFb5piKqDeEC5DzOQkoC2inf2kekFjt8Iz3s996zp3GZmAJ70Rp3zWsWx4fMmwmXPwqpqc4fjKQtjNEF9d/zO/yRQwPuD5igQ4O9o38i4Q7RjLqhhpQQY/GJLMP/Fmh3IJEFulHMJyNM/BOts4Wv7deoGc8DlQ3z00q4xcoBJn3Xvax8pAx1FhcgpmgH8DaFNqqzyJIW0+cB0+IdWMEMuwUD/9n3Cl0ZuaxbL8dJTlQUqTFmctiVHmHW/oSOFxO4WpFzJ7DCA4IYk0JUsLFqkG5Wc5VfIIj6jQkzfIijsu/4hZxcf1uVeksOZBmIdLvVD2B99KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748920169; c=relaxed/relaxed;
	bh=G0vlMa0+2NS68skWnW6I8+rokoV9f3s5rvePWFdAGY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I5iOgL5NfsJjZ8XfQF17V/8ijZLyMlc8vZn0Bazqbpkab09SpwuMxthUa0hR3UAnh9vblI4gWCDfn/9JqLmT4dxwFr2dZB1ijTv3ITTwdF0iQ4PMrIQcKxtdfoPRR9BXi7WkHDKUx2+cehDR8D3fTR/hwfhK2RMzevVmx8Cx12jv5o168izGcxB4KsvBrIm5OHtj/TPqYyMOHsPFCBLyVkcVlVEFAcsggnSSzH9WgtLxBhLhXiGPSbeRxaPz2tXnFICFRBJCgbPilHrtPMQOJjfJ5JaCw6HS/pZGhmrctokf/PDUDi6iPLvgqbv3URif3UfxLv6JFYJTucsshox2gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBG0861QKz2xpl
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:09:28 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bBFxy51PFz13LyP;
	Tue,  3 Jun 2025 11:07:34 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 723B3180A9E;
	Tue,  3 Jun 2025 11:09:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 11:09:26 +0800
Message-ID: <21c9bc85-4abd-4ce0-a978-5eabe77c337c@huawei.com>
Date: Tue, 3 Jun 2025 11:09:25 +0800
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
Subject: Re: [PATCH] erofs-utils: mkfs: fix image reproducibility of
 `-E(all-)fragments`
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>
References: <20250531002954.432151-1-hsiangkao@linux.alibaba.com>
 <9a234fc8-2ef0-435b-bc25-47881182d6c5@huawei.com>
 <afdfdab2-bc8d-4ba2-90b6-b38845c111e9@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <afdfdab2-bc8d-4ba2-90b6-b38845c111e9@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/6/2 20:23, Gao Xiang wrote:
> Hi Hongbo,
> 
> On 2025/6/2 17:31, Hongbo Li wrote:
>> Hi, Xiang,
>>
>> On 2025/5/31 8:29, Gao Xiang wrote:
>>> The timestamp of the packed inode should be fixed to the build time.
>>>
>>> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   lib/inode.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index 7a10624..ca49a80 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -910,7 +910,8 @@ out:
>>>       return 0;
>>>   }
>>> -static bool erofs_should_use_inode_extended(struct erofs_inode *inode)
>>> +static bool erofs_should_use_inode_extended(struct erofs_inode *inode,
>>> +                        const char *path)
>>>   {
>>>       if (cfg.c_force_inodeversion == FORCE_INODE_EXTENDED)
>>>           return true;
>>> @@ -924,7 +925,8 @@ static bool 
>>> erofs_should_use_inode_extended(struct erofs_inode *inode)
>>>           return true;
>>>       if (inode->i_nlink > USHRT_MAX)
>>>           return true;
>>> -    if ((inode->i_mtime != inode->sbi->build_time ||
>>> +    if (path != EROFS_PACKED_INODE &&
>>> +        (inode->i_mtime != inode->sbi->build_time ||
>>>            inode->i_mtime_nsec != inode->sbi->build_time_nsec) &&
>>>           !cfg.c_ignore_mtime)
>>>           return true;
>>> @@ -1016,6 +1018,10 @@ int __erofs_fill_inode(struct erofs_inode 
>>> *inode, struct stat *st,
>>>           erofs_err("gid overflow @ %s", path);
>>>       inode->i_gid += cfg.c_gid_offset;
>>> +    if (path == EROFS_PACKED_INODE) {
>>> +        inode->i_mtime = sbi->build_time;
>>> +        inode->i_mtime_nsec = 0;
>>> +    }
>>>       inode->i_mtime = st->st_mtime;
>>>       inode->i_mtime_nsec = ST_MTIM_NSEC(st);
>>
>> Should we put the condition in here? Because it will be reassigned if 
>> we do like this.
> 
> Oh, that is my fault, I will fix it soon.
> 
>>
>> And what about assigning sbi->build_time_nsec to inode->i_mtime_nsec 
>> like the FIXED case?
> 
> I just would like a quick fix for this because I have
> other features to work on.
> 
> If you want to improve that, could you submit a patch?
> 
Ok, I send the new one based on your v2.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>

