Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD22D3F8B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 11:09:01 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrXnj6fbWzDqpv
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 21:08:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrXnY3c7NzDqn4
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 21:08:49 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CrXmz5MJYzhnbT;
 Wed,  9 Dec 2020 18:08:19 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 18:08:42 +0800
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
To: Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
References: <20201209023930.15554-1-huangjianan@oppo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
Date: Wed, 9 Dec 2020 18:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201209023930.15554-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/12/9 10:39, Huang Jianan wrote:
> iblock indicates the number of i_blkbits-sized blocks rather than
> sectors.
> 
> In addition, considering buffer_head limits mapped size to 32-bits,
> should avoid using generic_block_bmap.
> 
> Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/data.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 347be146884c..d6ea0a216b57 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
>   		submit_bio(bio);
>   }
>   
> -static int erofs_get_block(struct inode *inode, sector_t iblock,
> -			   struct buffer_head *bh, int create)
> -{
> -	struct erofs_map_blocks map = {
> -		.m_la = iblock << 9,
> -	};
> -	int err;
> -
> -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> -	if (err)
> -		return err;
> -
> -	if (map.m_flags & EROFS_MAP_MAPPED)
> -		bh->b_blocknr = erofs_blknr(map.m_pa);
> -
> -	return err;
> -}
> -
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>   {
>   	struct inode *inode = mapping->host;
> +	struct erofs_map_blocks map = {
> +		.m_la = blknr_to_addr(block),
> +	};
> +	sector_t blknr = 0;

It could be removed?

>   
>   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
>   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
>   
>   		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> -			return 0;

return 0;

> +			goto out;
>   	}
>   
> -	return generic_block_bmap(mapping, block, erofs_get_block);
> +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> +		blknr = erofs_blknr(map.m_pa);

return erofs_blknr(map.m_pa);

> +
> +out:
> +	return blknr;

return 0;

Anyway, LGTM.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   }
>   
>   /* for uncompressed (aligned) files and raw access for other files */
> 
