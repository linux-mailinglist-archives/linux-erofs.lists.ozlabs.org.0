Return-Path: <linux-erofs+bounces-1583-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E6CDB7A6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 07:26:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbhjB367wz2xqG;
	Wed, 24 Dec 2025 17:26:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766557582;
	cv=none; b=UGj44GL/r2uT+6uCFus1CXfPp8/QMoqPnYzQ02s8++5NsI2rLlvOxFAqLeWD3IOkg353CqKHVJ+ZaXG6WThRPU9VnQPar6S3w9sgWWF2FhrFGrzpnOyuQdVhTqJg13TIvnGMxcpqzr43M6epUKFPoKEup/zv76bPbg4WCEJ3CEQbS1VHBHMDFZ9yRF4M2Qc6lcHmia15UnWXRfwDg6kL1m9nNYNW4+ZAAsq03JmAfIUnlTh3LRu8NCzDZFgHn4Wla8PhtIa1wGWNeFIZSQcoLJxhHJK4gtRDVmx6HSnixpto8p+R+SDovT1X8KfG48aDrNvZFQnoWFcjzbeL2QOq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766557582; c=relaxed/relaxed;
	bh=tRD6vTBkMhzsh0XSKyN261ilvkwt2FzgJ+X2pfaPLGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SdbZt5Zjd8R3m+U7xTiIWQZ0Tjb8YMkzFnogCdzehVShGQMBLb80hBBTWyDY2t1jIJWhIt3FROHu1gAh+0oLqCWJfLAH/nD6gYiGApc1v12Bz4jI1sLnL7ziq7lMxpLnapP5zIPkRn5+LJ1FvV3FoK664+kESCv6h+3q9V3W7ACU0xMWb+CbFNCxfgX7pOzqrvwzqmBWYvAvVZHTsetAcbhJ+ub0l63r++C0DIqTAZ/dOfnC0DM/aDKoeOjfSghoINnLRHOYWwXXY/2/WPSdqnLk99BCuG6Jnc7C28XT/wDlHXNnjW8PrmxegH68ltHVGVYSiFDlNss+Pb7zsxHF/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aRnHlXTH; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=aRnHlXTH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbhj71TLfz2xnl
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 17:26:16 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tRD6vTBkMhzsh0XSKyN261ilvkwt2FzgJ+X2pfaPLGU=;
	b=aRnHlXTHO4Ggc/lQ1d4I1TICOpLlGkUhvjDqTi15sSIn3D33i3UBY4bVhBDpBPLtfhAC2VJlK
	5nSraAq61Mvmv0mKGFCsnXojEDKG0UXMsvqCeNAsKWQ0TulEyojBM6AVJD33iao4GIyGRuQAjKf
	ygOUoQTh25X8Tdz496Np+Wc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dbhdL07mGz1prPg;
	Wed, 24 Dec 2025 14:23:02 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E3F0520104;
	Wed, 24 Dec 2025 14:26:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Dec 2025 14:26:10 +0800
Message-ID: <8f9bbbb2-b53a-424b-871c-d3b1a4484c8a@huawei.com>
Date: Wed, 24 Dec 2025 14:26:09 +0800
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
Subject: Re: [PATCH v11 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-5-lihongbo22@huawei.com>
 <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <0081b97d-4b46-4b20-9d23-18d9642881cf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:25, Gao Xiang wrote:
> 
> 
> On 2025/12/24 12:09, Hongbo Li wrote:
>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Move the `struct erofs_anon_fs_type` to the super.c and
>> expose it in preparation for the upcoming page cache share
>> feature.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Are you sure this is my previous version of this one?
> 
> Could you please check carefully before sending
> out the next version?

Sorry, I mixed up my local patches. I will check carefully in the next time.

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/erofs/fscache.c  | 13 -------------
>>   fs/erofs/internal.h |  2 ++
>>   fs/erofs/super.c    | 15 +++++++++++++++
>>   3 files changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 7a346e20f7b7..f4937b025038 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -3,7 +3,6 @@
>>    * Copyright (C) 2022, Alibaba Cloud
>>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>>    */
>> -#include <linux/pseudo_fs.h>
>>   #include <linux/fscache.h>
>>   #include "internal.h"
>> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>>   static LIST_HEAD(erofs_domain_cookies_list);
>>   static struct vfsmount *erofs_pseudo_mnt;
>> -static int erofs_anon_init_fs_context(struct fs_context *fc)
>> -{
>> -    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> -}
>> -
>> -static struct file_system_type erofs_anon_fs_type = {
>> -    .owner        = THIS_MODULE,
>> -    .name           = "pseudo_erofs",
>> -    .init_fs_context = erofs_anon_init_fs_context,
>> -    .kill_sb        = kill_anon_super,
>> -};
>> -
>>   struct erofs_fscache_io {
>>       struct netfs_cache_resources cres;
>>       struct iov_iter        iter;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index f7f622836198..98fe652aea33 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct 
>> erofs_sb_info *sbi)
>>       return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && 
>> sbi->dif0.file;
>>   }
>> +extern struct file_system_type erofs_anon_fs_type;
>> +
>>   static inline bool erofs_is_fscache_mode(struct super_block *sb)
>>   {
>>       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 937a215f626c..2a44c4e5af4f 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs_parser.h>
>>   #include <linux/exportfs.h>
>>   #include <linux/backing-dev.h>
>> +#include <linux/pseudo_fs.h>
>>   #include "xattr.h"
>>   #define CREATE_TRACE_POINTS
>> @@ -936,6 +937,20 @@ static struct file_system_type erofs_fs_type = {
>>   };
>>   MODULE_ALIAS_FS("erofs");
>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
>> +static int erofs_anon_init_fs_context(struct fs_context *fc)
>> +{
>> +    return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
>> +}
>> +
>> +struct file_system_type erofs_anon_fs_type = {
>> +    .owner        = THIS_MODULE,
>> +    .name           = "pseudo_erofs",
>> +    .init_fs_context = erofs_anon_init_fs_context,
>> +    .kill_sb        = kill_anon_super,
>> +};
>> +#endif
>> +
>>   static int __init erofs_module_init(void)
>>   {
>>       int err;
> 

