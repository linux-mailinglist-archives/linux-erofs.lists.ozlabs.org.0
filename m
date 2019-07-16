Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F06A504
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 11:36:02 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nwJ00tGXzDqSx
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 19:36:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nwHw51T4zDqSF
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 19:35:56 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 31DD32688B92528745E9;
 Tue, 16 Jul 2019 17:35:54 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 17:35:47 +0800
Subject: Re: [PATCH] staging: erofs: avoid opened loop codes
To: Chao Yu <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
References: <20190716085259.103481-1-yuchao0@huawei.com>
 <55609788-6615-72e1-78cc-9eadadce68a7@huawei.com>
 <8f84339b-9300-df41-7d95-bfb344d9c4f3@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <6a5175b2-5e25-4942-8030-b229cd33a89b@huawei.com>
Date: Tue, 16 Jul 2019 17:35:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <8f84339b-9300-df41-7d95-bfb344d9c4f3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/16 17:27, Chao Yu wrote:
> Hi Xiang,
> 
> On 2019/7/16 17:12, Gao Xiang wrote:
>> Hi Chao,
>>
>> On 2019/7/16 16:52, Chao Yu wrote:
>>> Use __GFP_NOFAIL to avoid opened loop codes in z_erofs_vle_unzip().
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  drivers/staging/erofs/unzip_vle.c | 17 ++++++++---------
>>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
>>> index f0dab81ff816..3a0dbcb8cc9f 100644
>>> --- a/drivers/staging/erofs/unzip_vle.c
>>> +++ b/drivers/staging/erofs/unzip_vle.c
>>> @@ -921,18 +921,17 @@ static int z_erofs_vle_unzip(struct super_block *sb,
>>>  		 mutex_trylock(&z_pagemap_global_lock))
>>>  		pages = z_pagemap_global;
>>>  	else {
>>> -repeat:
>>> -		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
>>> -				       GFP_KERNEL);
>>> +		gfp_t flags = GFP_KERNEL;
>>> +
>>> +		if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
>>> +			flags |= __GFP_NOFAIL;
>>> +
>>> +		pages = kvmalloc_array(nr_pages, sizeof(struct page *), flags);
>>
>> How about omitting variable `flags' since it's only used once, or
>> rename it since `flags' is too general?  some thoughts?
> 
> That's minor thing, if you do care about this, I guess 'gfp_flags' maybe?

Be better, I prefer to omitting this variable, gfp_flags looks good as well.

> 
>>
>> BTW, This piece of code has been changed in
>> "[PATCH v2 00/24] erofs: promote erofs from staging", I will sync the code
>> after some guys takes a look at v2....
> 
> We have enough time to merge modified staging codes to generic fs one till next
> merge window, so don't worry, you can do the merge in batch.

Yes, you are right. Actually I am not too worry about the staging merges but
how to catch Viro's eye (sigh...)...

Thanks,
Gao Xiang

> 
> Thanks,
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>  
>>>  		/* fallback to global pagemap for the lowmem scenario */
>>>  		if (unlikely(!pages)) {
>>> -			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
>>> -				goto repeat;
>>> -			else {
>>> -				mutex_lock(&z_pagemap_global_lock);
>>> -				pages = z_pagemap_global;
>>> -			}
>>> +			mutex_lock(&z_pagemap_global_lock);
>>> +			pages = z_pagemap_global;
>>>  		}
>>>  	}
>>>  
>>>
>> .
>>
