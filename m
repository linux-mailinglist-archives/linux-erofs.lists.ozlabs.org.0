Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F934B5AB
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 10:32:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6ttK4tWdz30Cb
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 20:32:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6ttH5vJWz2xfR
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 20:32:51 +1100 (AEDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6tqd2cK4zyW7B;
 Sat, 27 Mar 2021 17:30:37 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 27 Mar
 2021 17:32:34 +0800
Subject: Re: [PATCH] erofs: don't use erofs_map_blocks() any more
To: Gao Xiang <hsiangkao@redhat.com>, Yue Hu <zbestahu@gmail.com>
References: <20210325071008.573-1-zbestahu@gmail.com>
 <20210325082948.GA2474089@xiangao.remote.csb>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <74d56e23-0cb9-b307-2920-5299de7bf527@huawei.com>
Date: Sat, 27 Mar 2021 17:32:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210325082948.GA2474089@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/3/25 16:29, Gao Xiang wrote:
> Hi Yue,
> 
> On Thu, Mar 25, 2021 at 03:10:08PM +0800, Yue Hu wrote:
>> From: Yue Hu <huyue2@yulong.com>
>>
>> Currently, erofs_map_blocks() will be called only from
>> erofs_{bmap, read_raw_page} which are all for uncompressed files.
>> So, the compression branch in erofs_map_blocks() is pointless. Let's
>> remove it and use erofs_map_blocks_flatmode() directly. Also update
>> related comments.
>>
> 
> You are right, since for compressed files, map_blocks_iter would be more
> effective than erofs_map_blocks. Originally, such unique interface was
> designed for fiemap (just for example), but I'm fine to get rid of it
> until related interfaces are finally implemented.
> 
> Also, I'd like to hear opinions from Chao as well.

Looks fine to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>> ---
>>   fs/erofs/data.c     | 19 ++-----------------
>>   fs/erofs/internal.h |  6 ++----
>>   2 files changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 1249e74..ebac756 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -109,21 +109,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>>   	return err;
>>   }
>>   
>> -int erofs_map_blocks(struct inode *inode,
>> -		     struct erofs_map_blocks *map, int flags)
>> -{
>> -	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>> -		int err = z_erofs_map_blocks_iter(inode, map, flags);
>> -
>> -		if (map->mpage) {
>> -			put_page(map->mpage);
>> -			map->mpage = NULL;
>> -		}
>> -		return err;
>> -	}
>> -	return erofs_map_blocks_flatmode(inode, map, flags);
>> -}
>> -
>>   static inline struct bio *erofs_read_raw_page(struct bio *bio,
>>   					      struct address_space *mapping,
>>   					      struct page *page,
>> @@ -159,7 +144,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>>   		erofs_blk_t blknr;
>>   		unsigned int blkoff;
>>   
>> -		err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>> +		err = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
>>   		if (err)
>>   			goto err_out;
>>   
>> @@ -318,7 +303,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>>   			return 0;
>>   	}
>>   
>> -	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
>> +	if (!erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW))
>>   		return erofs_blknr(map.m_pa);
>>   
>>   	return 0;
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index 30e63b7..db8c847 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -289,7 +289,7 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
>>   extern const struct address_space_operations z_erofs_aops;
>>   
>>   /*
>> - * Logical to physical block mapping, used by erofs_map_blocks()
>> + * Logical to physical block mapping
>>    *
>>    * Different with other file systems, it is used for 2 access modes:
>>    *
>> @@ -336,7 +336,7 @@ struct erofs_map_blocks {
>>   	struct page *mpage;
>>   };
>>   
>> -/* Flags used by erofs_map_blocks() */
>> +/* Flags used by erofs_map_blocks_flatmode() */
>>   #define EROFS_GET_BLOCKS_RAW    0x0001
>>   
>>   /* zmap.c */
>> @@ -358,8 +358,6 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>>   /* data.c */
>>   struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
>>   
>> -int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
>> -
>>   /* inode.c */
>>   static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
>>   {
>> -- 
>> 1.9.1
>>
> 
> .
> 
