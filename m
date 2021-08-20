Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E43F291F
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 11:29:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrbvJ1ykVz3cLY
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 19:29:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=py2yHFuX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=py2yHFuX; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grbv93Nh2z2xZR
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 19:29:41 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9CCF6112E;
 Fri, 20 Aug 2021 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629451779;
 bh=WaYnwW7PP95GB9J6yAYyjsj+JlmkBWPltN09DfCgScQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=py2yHFuXqM1Z0MVtupybvOMMcpJqbxqrnHWzHAB2a1wtXxOxLwqo+iUjJdsmbncAD
 HxCsP2ZgGe7drJR2pAvg+ZXh+6W32zld5WgN2W+R5YF4uImFs933AfOLmxumvFMaSa
 pQz2deVrsW/bHwkIeSO0M0LC068kastemQUwwmOaW41yK3t/h+JVm93dqrFrvYMl2L
 P/L5w8zE8mFSlQ6voOW6K+YlX46eeiCW3I93xaKqTv2VZg5sFVyUopuQnTC35kY1/F
 N4skl3EikO33+NXpwL5PQiuGbQwVzfW04cMTT4HhdHLDtOAlRgFK68RHw4AcJOBkhf
 5A4Tuf3buGJZw==
Subject: Re: [PATCH v2 2/2] erofs: support reading chunk-based uncompressed
 files
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-2-hsiangkao@linux.alibaba.com>
 <aaf64137-02f9-db98-10d4-4757bc6f25ec@kernel.org>
 <YR9x7W4wObWdZdrx@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <f501144f-f7fc-1150-0c41-4c1981bd0594@kernel.org>
Date: Fri, 20 Aug 2021 17:29:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR9x7W4wObWdZdrx@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Tao Ma <boyu.mt@taobao.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, Eryu Guan <eguan@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/8/20 17:12, Gao Xiang wrote:
> Hi Chao,
> 
> On Fri, Aug 20, 2021 at 05:04:13PM +0800, Chao Yu wrote:
>> On 2021/8/19 14:33, Gao Xiang wrote:
> 
> ...
> 
>>>    }
>>> +static int erofs_map_blocks(struct inode *inode,
>>> +			    struct erofs_map_blocks *map, int flags)
>>> +{
>>> +	struct super_block *sb = inode->i_sb;
>>> +	struct erofs_inode *vi = EROFS_I(inode);
>>> +	struct erofs_inode_chunk_index *idx;
>>> +	struct page *page;
>>> +	u64 chunknr;
>>> +	unsigned int unit;
>>> +	erofs_off_t pos;
>>> +	int err = 0;
>>> +
>>> +	if (map->m_la >= inode->i_size) {
>>> +		/* leave out-of-bound access unmapped */
>>> +		map->m_flags = 0;
>>> +		map->m_plen = 0;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
>>> +		return erofs_map_blocks_flatmode(inode, map, flags);
>>> +
>>> +	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>>> +		unit = sizeof(*idx);	/* chunk index */
>>> +	else
>>> +		unit = 4;		/* block map */
>>
>> You mean sizeof(__le32)?
> 
> Yeah, sizeof(__le32) == 4, either way works for me.
> 
> If some tendency about this, I will update when applying.

Xiang,

Yeah, I preper:

#define EROFS_BLOCK_MAP_ENTRY_SIZE	sizeof(__le32)

	unit = EROFS_BLOCK_MAP_ENTRY_SIZE;

to improve readablity, but unit = sizeof(__le32) is fine as well.

Thanks,

> 
>>
>> Otherwise it looks good to me.
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
>>
> 
> Thanks for the review!
> 
> Thanks,
> Gao Xiang
> 
>> Thanks,
>>
>>> +
>>> +	chunknr = map->m_la >> vi->chunkbits;
>>> +	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
>>> +		    vi->xattr_isize, unit) + unit * chunknr;
>>> +
>>> +	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
>>> +	if (IS_ERR(page))
>>> +		return PTR_ERR(page);
>>> +
>>> +	map->m_la = chunknr << vi->chunkbits;
>>> +	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
>>> +			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
>>> +
>>> +	/* handle block map */
>>> +	if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
>>> +		__le32 *blkaddr = page_address(page) + erofs_blkoff(pos);
>>> +
>>> +		if (le32_to_cpu(*blkaddr) == EROFS_NULL_ADDR) {
>>> +			map->m_flags = 0;
>>> +		} else {
>>> +			map->m_pa = blknr_to_addr(le32_to_cpu(*blkaddr));
>>> +			map->m_flags = EROFS_MAP_MAPPED;
>>> +		}
>>> +		goto out_unlock;
>>> +	}
>>> +	/* parse chunk indexes */
>>> +	idx = page_address(page) + erofs_blkoff(pos);
>>> +	switch (le32_to_cpu(idx->blkaddr)) {
>>> +	case EROFS_NULL_ADDR:
>>> +		map->m_flags = 0;
>>> +		break;
>>> +	default:
>>> +		/* only one device is supported for now */
>>> +		if (idx->device_id) {
>>> +			erofs_err(sb, "invalid device id %u @ %llu for nid %llu",
>>> +				  le32_to_cpu(idx->device_id),
>>> +				  chunknr, vi->nid);
>>> +			err = -EFSCORRUPTED;
>>> +			goto out_unlock;
>>> +		}
>>> +		map->m_pa = blknr_to_addr(le32_to_cpu(idx->blkaddr));
>>> +		map->m_flags = EROFS_MAP_MAPPED;
>>> +		break;
>>> +	}
>>> +out_unlock:
>>> +	unlock_page(page);
>>> +	put_page(page);
>>> +out:
>>> +	map->m_llen = map->m_plen;
>>> +	return err;
>>> +}
>>> +
>>>    static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>>    		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>>>    {
>>> @@ -94,7 +164,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>>    	map.m_la = offset;
>>>    	map.m_llen = length;
>>> -	ret = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
>>> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
>>>    	if (ret < 0)
>>>    		return ret;
>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>> index d13e0709599c..4408929bd6f5 100644
>>> --- a/fs/erofs/inode.c
>>> +++ b/fs/erofs/inode.c
>>> @@ -2,6 +2,7 @@
>>>    /*
>>>     * Copyright (C) 2017-2018 HUAWEI, Inc.
>>>     *             https://www.huawei.com/
>>> + * Copyright (C) 2021, Alibaba Cloud
>>>     */
>>>    #include "xattr.h"
>>> @@ -122,7 +123,9 @@ static struct page *erofs_read_inode(struct inode *inode,
>>>    		/* total blocks for compressed files */
>>>    		if (erofs_inode_is_data_compressed(vi->datalayout))
>>>    			nblks = le32_to_cpu(die->i_u.compressed_blocks);
>>> -
>>> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
>>> +			/* fill chunked inode summary info */
>>> +			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>>>    		kfree(copied);
>>>    		break;
>>>    	case EROFS_INODE_LAYOUT_COMPACT:
>>> @@ -160,6 +163,8 @@ static struct page *erofs_read_inode(struct inode *inode,
>>>    		inode->i_size = le32_to_cpu(dic->i_size);
>>>    		if (erofs_inode_is_data_compressed(vi->datalayout))
>>>    			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
>>> +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
>>> +			vi->chunkformat = le16_to_cpu(dic->i_u.c.format);
>>>    		break;
>>>    	default:
>>>    		erofs_err(inode->i_sb,
>>> @@ -169,6 +174,17 @@ static struct page *erofs_read_inode(struct inode *inode,
>>>    		goto err_out;
>>>    	}
>>> +	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
>>> +		if (!(vi->chunkformat & EROFS_CHUNK_FORMAT_ALL)) {
>>> +			erofs_err(inode->i_sb,
>>> +				  "unsupported chunk format %x of nid %llu",
>>> +				  vi->chunkformat, vi->nid);
>>> +			err = -EOPNOTSUPP;
>>> +			goto err_out;
>>> +		}
>>> +		vi->chunkbits = LOG_BLOCK_SIZE +
>>> +			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
>>> +	}
>>>    	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
>>>    	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
>>>    	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>> index 91089ab8a816..9524e155b38f 100644
>>> --- a/fs/erofs/internal.h
>>> +++ b/fs/erofs/internal.h
>>> @@ -2,6 +2,7 @@
>>>    /*
>>>     * Copyright (C) 2017-2018 HUAWEI, Inc.
>>>     *             https://www.huawei.com/
>>> + * Copyright (C) 2021, Alibaba Cloud
>>>     */
>>>    #ifndef __EROFS_INTERNAL_H
>>>    #define __EROFS_INTERNAL_H
>>> @@ -261,6 +262,10 @@ struct erofs_inode {
>>>    	union {
>>>    		erofs_blk_t raw_blkaddr;
>>> +		struct {
>>> +			unsigned short	chunkformat;
>>> +			unsigned char	chunkbits;
>>> +		};
>>>    #ifdef CONFIG_EROFS_FS_ZIP
>>>    		struct {
>>>    			unsigned short z_advise;
>>>
