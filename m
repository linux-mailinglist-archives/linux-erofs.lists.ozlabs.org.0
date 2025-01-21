Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47665A17DAC
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 13:17:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YcmRQ63Nxz30TQ
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Jan 2025 23:17:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737461825;
	cv=none; b=TM9t6r6hl89tPdk99ifAyZbOY3qlqF8nK6QEKEKII/m0pXuq28S7/nlIL+SgJDWNcJkbx2iv7sayWHLWWl1Ch1yYU0tSLv8PmhvrLYyhJHdrB4VksPkyOMByiUsCI536wbse9lD0Tb1T21356FzWKayHICn2fyGMChynM/vLF/YRKZ351jLHd9YadVb5YhVSq+/LWjOVn5GKYi327Y4LlCmyG6KA9uD6lFo8njkGTuSbgHQ3VQqLqCh59/J+Sc1rlNN/Nqr240ZSal2k66dZ1tRVIYwZocDf+eKgrBb8foueZXQ/t65XcprPfRFxj2KXUGePblWyNG33hE6M40Mr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737461825; c=relaxed/relaxed;
	bh=WIkn6AkjKb6XtnGUE7RS7G54jEYjiMZnBqfiqxhBLLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvi4403Nylh5Zvmlu2YbYrwlQceqtuVoxcRkDP2LIAH9ttxgPDCePD6ITrF0ZT6WS1mAV7ZsEvnBMRdUsANf+PMON9AmY7NbFuaV1xp7AoPOtBOFFDEPQrxhvE2xTu290eOPFdZQSMLEgaQ94IxZYeiC4U/9XDmWrwa/yV0kBHyozfCb/7IRMbwTRhoNNuJyU5bDmY5ZR/wYFGCAu31Q8GJNHSmiYkXsK2aW1EC92O9WbTdf6kFmgMTnsOYPCZ2VY9ybn4oWKr7BwCKdW41XP/q820V7llMLjsq6kidBkqrZHY40sET++R7bOrF9w7cT32J12QwDjW2dwX5icnznbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TnAqEz0s; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TnAqEz0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YcmRM1w7zz2yF7
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Jan 2025 23:17:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737461817; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WIkn6AkjKb6XtnGUE7RS7G54jEYjiMZnBqfiqxhBLLQ=;
	b=TnAqEz0s6sdIxox505DGh0IX3heXDEBYrARgNocmkQjs6Yzy+5emeiRyjkalGnkvFJCds/M0qncdVK3kEkjSLXx0jQLCLVCfESRQk0fF6P6LJOFgkjDou+DIN9VoLgbTc68TrfuL5tFjY6NzsdgujGS0GF91YoDqFrWkwNif+uE=
Received: from 30.41.15.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WO5QVp7_1737461809 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 20:16:55 +0800
Message-ID: <26a59c6f-f90d-4e99-9e7b-3f42efaad1f7@linux.alibaba.com>
Date: Tue, 21 Jan 2025 20:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 3/4] erofs: apply the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250105151208.3797385-1-hongzhen@linux.alibaba.com>
 <20250105151208.3797385-4-hongzhen@linux.alibaba.com>
 <5d34b289-c0f1-4c37-9536-fc955ce8b53b@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5d34b289-c0f1-4c37-9536-fc955ce8b53b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/21 19:59, Hongbo Li via Linux-erofs wrote:
> 
> 
> On 2025/1/5 23:12, Hongzhen Luo wrote:
>> This modifies relevant functions to apply the page cache
>> share feature.
>>
>> Below is the memory usage for reading all files in two different minor
>> versions of container images:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     241     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     872     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     2771    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     926     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     390     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     924     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |     474     |      49%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Additionally, the table below shows the runtime memory usage of the
>> container:
>>
>> +-------------------+------------------+-------------+---------------+
>> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
>> |                   |                  |             | Reduction (%) |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      35     |       -       |
>> |       redis       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     149     |       -       |
>> |      postgres     +------------------+-------------+---------------+
>> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     1028    |       -       |
>> |     tensorflow    +------------------+-------------+---------------+
>> |  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |     155     |       -       |
>> |       mysql       +------------------+-------------+---------------+
>> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
>> +-------------------+------------------+-------------+---------------+
>> |                   |        No        |      25     |       -       |
>> |       nginx       +------------------+-------------+---------------+
>> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
>> +-------------------+------------------+-------------+---------------+
>> |       tomcat      |        No        |     186     |       -       |
>> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
>> |                   |        Yes       |      98     |      48%      |
>> +-------------------+------------------+-------------+---------------+
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   fs/erofs/data.c            | 14 +++++++--
>>   fs/erofs/inode.c           |  5 ++-
>>   fs/erofs/pagecache_share.c | 63 ++++++++++++++++++++++++++++++++++++++
>>   fs/erofs/pagecache_share.h | 11 +++++++
>>   fs/erofs/super.c           |  7 +++++
>>   fs/erofs/zdata.c           |  9 ++++--
>>   6 files changed, 104 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 0cd6b5c4df98..fb08acbeaab6 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2021, Alibaba Cloud
>>    */
>>   #include "internal.h"
>> +#include "pagecache_share.h"
>>   #include <linux/sched/mm.h>
>>   #include <trace/events/erofs.h>
>> @@ -370,12 +371,21 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>    */
>>   static int erofs_read_folio(struct file *file, struct folio *folio)
>>   {
>> -    return iomap_read_folio(folio, &erofs_iomap_ops);
>> +    int ret, pcshr;
>> +
>> +    pcshr = erofs_pcshr_read_begin(file, folio);
>> +    ret = iomap_read_folio(folio, &erofs_iomap_ops);
>> +    erofs_pcshr_read_end(file, folio, pcshr);
>> +    return ret;
>>   }
>>   static void erofs_readahead(struct readahead_control *rac)
>>   {
>> -    return iomap_readahead(rac, &erofs_iomap_ops);
>> +    int pcshr;
>> +
>> +    pcshr = erofs_pcshr_readahead_begin(rac);
>> +    iomap_readahead(rac, &erofs_iomap_ops);
>> +    erofs_pcshr_readahead_end(rac, pcshr);
>>   }
>>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index d4b89407822a..0b070f4b46b8 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2021, Alibaba Cloud
>>    */
>>   #include "xattr.h"
>> +#include "pagecache_share.h"
>>   #include <trace/events/erofs.h>
>>   static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>> @@ -212,7 +213,9 @@ static int erofs_fill_inode(struct inode *inode)
>>       switch (inode->i_mode & S_IFMT) {
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>> -        if (erofs_inode_is_data_compressed(vi->datalayout))
>> +        if (erofs_pcshr_fill_inode(inode) == 0)
>> +            inode->i_fop = &erofs_pcshr_fops;
>> +        else if (erofs_inode_is_data_compressed(vi->datalayout))
>>               inode->i_fop = &generic_ro_fops;
>>           else
>>               inode->i_fop = &erofs_file_fops;
>> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
>> index 703fd17c002c..22172b5e21c7 100644
>> --- a/fs/erofs/pagecache_share.c
>> +++ b/fs/erofs/pagecache_share.c
>> @@ -22,6 +22,7 @@ struct erofs_pcshr_counter {
>>   struct erofs_pcshr_private {
>>       char fprt[PCSHR_FPRT_MAXLEN];
>> +    struct mutex mutex;
>>   };
>>   static struct erofs_pcshr_counter mnt_counter = {
>> @@ -84,6 +85,7 @@ static int erofs_fprt_set(struct inode *inode, void *data)
>>       if (!ano_private)
>>           return -ENOMEM;
>>       memcpy(ano_private, data, sizeof(size_t) + *(size_t *)data);
>> +    mutex_init(&ano_private->mutex);
>>       inode->i_private = ano_private;
>>       return 0;
>>   }
>> @@ -226,3 +228,64 @@ const struct file_operations erofs_pcshr_fops = {
>>       .get_unmapped_area = thp_get_unmapped_area,
>>       .splice_read    = filemap_splice_read,
>>   };
>> +
>> +int erofs_pcshr_read_begin(struct file *file, struct folio *folio)
>> +{
>> +    struct erofs_inode *vi;
>> +    struct erofs_pcshr_private *ano_private;
>> +
>> +    if (!(file && file->private_data))
>> +        return 0;
>> +
>> +    vi = file->private_data;
>> +    if (vi->ano_inode != file_inode(file))
>> +        return 0;
>> +
>> +    ano_private = vi->ano_inode->i_private;
>> +    mutex_lock(&ano_private->mutex);
> Can we lock in folio granularity? The erofs_pcshr_private mutex may limit the concurrent in reading.

I've asked Hongzhen to prepare a new reasonable version,
in this version it shouldn't be such mutex to lock the
whole submit process, but just keep all inodes stable.

Please just ignore this whole series.

Thanks,
Gao Xiang
