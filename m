Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F332E934A27
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 10:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721292223;
	bh=IgMMEvrEKSyg4OjwOmnH2M493eUuMi1beTEmu7VZtYU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ifWD2bzPjOIts6hKzaG+tuQnzpxpplGfRx+RZ/ECRjE+5uPSyns56PP7eqlh0x0KW
	 g0t54OGHIxvLmg1Vltf2SPu2XbwzIqwSHtPw0MFoX+I0EqWFPhd3Fi0iPw++rpaIPY
	 Y77sdfPXPtvsvd4xwV+kjlRH/JObBz9KdTOftPAoLwmIvgtbC/gnCt/iiu9o2qjvYT
	 n6VLyNKnWaiSKJzquosmopxwnbunU97Hg08aIzke6eRvALNVubFunoiET9MTuOxjNa
	 St8TvEQhPN8cxg0AAbQUVwkA48OylSRRAEJa1J0v9M0kgix+yfYXf3pUlFTWIogYbE
	 ZUIcVEqJBIOnQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPmYW67tXz3dFL
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 18:43:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPmYP3XtTz30Vy
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 18:43:33 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WPmSW1T0lzQm3G
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 16:39:23 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B51DF14041B
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 16:43:27 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 16:43:27 +0800
Message-ID: <9cfae641-4b87-4017-8ca4-4c46a91fce34@huawei.com>
Date: Thu, 18 Jul 2024 16:43:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support STATX_DIOALIGN
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20240718063756.2982763-1-lihongbo22@huawei.com>
 <20240718083243.2485437-1-hsiangkao@linux.alibaba.com>
 <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
In-Reply-To: <f91c15d1-cdd9-4b12-9143-fba6c7bf6565@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 16:35, Gao Xiang wrote:
> 
> 
> On 2024/7/18 16:32, Gao Xiang wrote:
>> From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
> 
> Also I will fix the email address issue
> (Hongbo Li <lihongbo22@huawei.com>) when applying too.
> 
>>
>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>> alignment restrictions are exposed to userspace in a generic
>> way.
>>
>> [Before]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:0
>> dio offset align:0
>> ```
>>
>> [After]
>> ```
>> ./statx_test /mnt/erofs/testfile
>> statx(/mnt/erofs/testfile) = 0
>> dio mem align:512
>> dio offset align:512
>> ```
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> Hi Hongbo,
>>
>> I tidy up the patch a bit according to the current codebase,
>> I will apply this later for this cycle.
it's ok, and thank you!

Thanks,
Hongbo
>>
>> Also r-v-bs are always welcome...
>>
>> Thanks,
>> Gao Xiang
>>
>>   fs/erofs/inode.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..43c09aae2afc 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -334,14 +334,29 @@ int erofs_getattr(struct mnt_idmap *idmap, const 
>> struct path *path,
>>             unsigned int query_flags)
>>   {
>>       struct inode *const inode = d_inode(path->dentry);
>> +    bool compressed =
>> +        erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout);
>> -    if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
>> +    if (compressed)
>>           stat->attributes |= STATX_ATTR_COMPRESSED;
>> -
>>       stat->attributes |= STATX_ATTR_IMMUTABLE;
>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>                     STATX_ATTR_IMMUTABLE);
>> +    /*
>> +     * Return the DIO alignment restrictions if requested.
>> +     *
>> +     * In EROFS, STATX_DIOALIGN is not supported in ondemand mode and
>> +     * compressed files, so in these cases we report no DIO support.
>> +     */
>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>> +        stat->result_mask |= STATX_DIOALIGN;
>> +        if (!erofs_is_fscache_mode(inode->i_sb) && !compressed) {
>> +            stat->dio_mem_align =
>> +                bdev_logical_block_size(inode->i_sb->s_bdev);
>> +            stat->dio_offset_align = stat->dio_mem_align;
>> +        }
>> +    }
>>       generic_fillattr(idmap, request_mask, inode, stat);
>>       return 0;
>>   }
