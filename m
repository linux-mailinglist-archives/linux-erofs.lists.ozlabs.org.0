Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CE6A4CA
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 11:23:27 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nw1T1DX4zDqSL
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 19:23:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nw1P4h6HzDqRN
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 19:23:20 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id CC74977E09F82BAF43FA;
 Tue, 16 Jul 2019 17:23:17 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 17:23:11 +0800
Subject: Re: [PATCH v2] staging: erofs: support bmap
To: Gao Xiang <gaoxiang25@huawei.com>, <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
References: <20190716084625.102366-1-yuchao0@huawei.com>
 <470cdf8c-b20c-5c38-59e5-977a2359af9d@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <229d481a-1f4c-d39d-6dd3-f9a1f077d8a3@huawei.com>
Date: Tue, 16 Jul 2019 17:23:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <470cdf8c-b20c-5c38-59e5-977a2359af9d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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

Hi Xiang,

On 2019/7/16 17:01, Gao Xiang wrote:
> Hi Chao,
> 
> Cc lkml mailing list?

Oh, no problem, let me update my default cc list.

> 
> On 2019/7/16 16:46, Chao Yu wrote:
>> Add erofs_bmap() to support FIBMAP ioctl on flatmode inode.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - support mapping normal blocks for inline inode suggested by Xiang
>> - rebase to linux-next
>>  drivers/staging/erofs/data.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
>> index cc31c3e5984c..5c7e3b9cff6a 100644
>> --- a/drivers/staging/erofs/data.c
>> +++ b/drivers/staging/erofs/data.c
>> @@ -392,9 +392,42 @@ static int erofs_raw_access_readpages(struct file *filp,
>>  	return 0;
>>  }
>>  
>> +static int erofs_get_block(struct inode *inode, sector_t iblock,
>> +			   struct buffer_head *bh, int create)
>> +{
>> +	struct erofs_map_blocks map = {
>> +		.m_la = iblock << 9,
>> +	};
>> +	int err;
>> +
>> +	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>> +	if (err)
>> +		return err;
>> +
>> +	if (map.m_flags & EROFS_MAP_MAPPED)
>> +		bh->b_blocknr = erofs_blknr(map.m_pa);
>> +
>> +	return err;
>> +}
>> +
>> +static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>> +{
>> +	struct inode *inode = mapping->host;
>> +
>> +	if (is_inode_flat_inline(inode)) {
>> +		unsigned int blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> 
> maybe we could use erofs_blk_t ?

Okay,

> 
>> +
>> +		if (!blks || block >> LOG_SECTORS_PER_BLOCK >= blks)
> 
> Could the above line be simplified to block >> LOG_SECTORS_PER_BLOCK >= blks?

That's right, original one was trying to consider readability and avoid
calculation of following statement when blks equals to zero.

Anyway, either is okay to me.

> 
> Other parts looks good to me,
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> However, I think resend a new patch is better.

Yeah, let me send v3.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> +			return 0;
>> +	}
>> +
>> +	return generic_block_bmap(mapping, block, erofs_get_block);
>> +}
>> +
>>  /* for uncompressed (aligned) files and raw access for other files */
>>  const struct address_space_operations erofs_raw_access_aops = {
>>  	.readpage = erofs_raw_access_readpage,
>>  	.readpages = erofs_raw_access_readpages,
>> +	.bmap = erofs_bmap,
>>  };
>>  
>>
> .
> 
