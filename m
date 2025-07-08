Return-Path: <linux-erofs+bounces-547-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64563AFC0FF
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:45:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblpJ0QrZz3064;
	Tue,  8 Jul 2025 12:45:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751942727;
	cv=none; b=fPBQofR3irW1Z4+w5PbBSPff0qRnuX/GqZH46w3d/IqkPSnlp6zbVxJ6xz3v22RuD6LMW4kIAORZXReErQBRI2sYG4HLmYkaFauaNxf1QCqgYovdP9nzRKTocheaalGJznszgTP6DRirufBHXYX/IbLpfKxZtkbeuLlkQTqdlKiMX/FTdiiipSsbrz3ygEa7x+NSxRV4i1u5GK8iUYQHYFSauc2kKoUt6Q9WHp13KjCBtNP7BsKCEU2L87oigNICdgeAIwrSnxGtqN0oPxhKPP2bU/DsGC6hwafDKtxwQzo0XEdc+aRssZbw45nI9pUyM3aPhqMREmc42qRR6vEWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751942727; c=relaxed/relaxed;
	bh=sN32kB4hsfT9wimglClulmbkCRuz0T3ciRhWeAms7cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I6Kr+lD+mB+TPxDzLVJdOI32uH3bZLaAzUIUNG13SRmJBjDIP6xqYXtKpeTFperzcUsl2F/kq4vKT+qfI+60hQ7nkn1E4gk0WB33kdNhXofQZrhSO4lFnV5VpWB7+sI3+/c7mTqv4a2qUcxmfzAQNnZEgTpEvYJdE2cjJX86QI+58m2LCI0jhArwgDCepSnM9foil0HwASg+rOhIWQE3Y1jRNBdvg6rCBs4ZAa8IeAwCtSx5Yu7z7pZvXubFvuLBZakbXw2Mt5NCRn6kvcFHfa6KvunkmAzvXY2BcgVOPXKq6umEi4vQroPi+iH1YszUxRcEXm6uNYKKhqZAOFv4jA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblpH1yqLz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:45:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bblj35d8NzWfxm;
	Tue,  8 Jul 2025 10:40:55 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F36CE180B64;
	Tue,  8 Jul 2025 10:45:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 10:45:20 +0800
Message-ID: <e759af7b-0aef-4f3e-a84b-91a24602b32c@huawei.com>
Date: Tue, 8 Jul 2025 10:45:19 +0800
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
Subject: Re: [PATCH] erofs: do sanity check on m->type in
 z_erofs_load_compact_lcluster()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
	<xiang@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>
References: <20250707084723.2725437-1-chao@kernel.org>
 <3d04116f-5cee-4d41-9150-abbeb18f80be@huawei.com>
 <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <1a27683d-580b-4fa9-bd86-902ea78afe46@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/8 10:35, Gao Xiang wrote:
> 
> 
> On 2025/7/8 10:30, Hongbo Li wrote:
>>
>>
>> On 2025/7/7 16:47, Chao Yu wrote:
>>> All below functions will do sanity check on m->type, let's move sanity
>>> check to z_erofs_load_compact_lcluster() for cleanup.
>>> - z_erofs_map_blocks_fo
>>> - z_erofs_get_extent_compressedlen
>>> - z_erofs_get_extent_decompressedlen
>>> - z_erofs_extent_lookback
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/erofs/zmap.c | 60 ++++++++++++++++++-------------------------------
>>>   1 file changed, 22 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>> index 0bebc6e3a4d7..e530b152e14e 100644
>>> --- a/fs/erofs/zmap.c
>>> +++ b/fs/erofs/zmap.c
>>> @@ -240,6 +240,13 @@ static int z_erofs_load_compact_lcluster(struct 
>>> z_erofs_maprecorder *m,
>>>   static int z_erofs_load_lcluster_from_disk(struct 
>>> z_erofs_maprecorder *m,
>>>                          unsigned int lcn, bool lookahead)
>>>   {
>>> +    if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
>>> +        erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid 
>>> %llu",
>>> +                m->type, lcn, EROFS_I(m->inode)->nid);
>>> +        DBG_BUGON(1);
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>
>> Hi, Chao,
>>
>> After moving the condition in here, there is no need to check in 
>> z_erofs_extent_lookback, z_erofs_get_extent_compressedlen and 
>> z_erofs_get_extent_decompressedlen. Because in z_erofs_map_blocks_fo, 
>> the condition has been checked in before. Right?
> 
> I've replied some similar question.
> 
> Because z_erofs_get_extent_compressedlen and 
> z_erofs_get_extent_decompressedlen()
> use the different lcn (lcluster) against z_erofs_map_blocks_fo().
> 
> So if a new lcn(lcluster number) is loaded, we'd check if the type is 
> valid.
> 
Ok, the type will change after loading.

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 

