Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBA4160D6
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 16:13:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFcZy35wgz2ynS
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Sep 2021 00:13:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BkyQEEYv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BkyQEEYv; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFcZv4jwCz2xtf
 for <linux-erofs@lists.ozlabs.org>; Fri, 24 Sep 2021 00:13:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A263460527;
 Thu, 23 Sep 2021 14:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632406405;
 bh=m3QBrSHhtUsj0sLXBZd9pjgg28d3bKTfA1avX1S/8lM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BkyQEEYvPlLpNSFkepxPxIoVQRdIk7HaoFvTYKXx/Jvki2B2YLF8HjQYg9kTx3UDJ
 DnjP/dw5K/yEPkDgxcARygksnC3wLyDYa+cK4N9LJpNL8ZU6LXOnYW1/jwfsiBitVs
 SzyWHGhERfwIRhdhryIhyCPZlelqc54oiwN9uOD7HNO3GvOJ7mkQHHQWo8/o5t99KA
 EargwtWTS80m+g34yi7ieYmM1BC6nWd99TmmYnLwUFdyVVk3fdRHwo50jLbyMZ8dip
 NRpG9acglfSkYQlc4xScU8/9Vhgg8NWRb78OVWwzU+hO6oQIo5x5/ZwNO927WBx1fb
 gkyRJg/pUAuww==
Subject: Re: [PATCH 2/2] erofs: clean up erofs_map_blocks tracepoints
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20210921143531.81356-1-hsiangkao@linux.alibaba.com>
 <20210921143531.81356-2-hsiangkao@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <448368d3-d8a2-b872-7000-d93363aec9c6@kernel.org>
Date: Thu, 23 Sep 2021 22:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210921143531.81356-2-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/9/21 22:35, Gao Xiang wrote:
> Since the new type of chunk-based files is introduced, there is no
> need to leave flatmode tracepoints. Rename to erofs_map_blocks.
> 
> Add the missing FIEMAP tracepoint map flag as well.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/data.c              | 31 ++++++++++++++-----------------
>   include/trace/events/erofs.h |  7 ++++---
>   2 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 9db8297..020c3e0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -26,14 +26,11 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   				     struct erofs_map_blocks *map,
>   				     int flags)
>   {
> -	int err = 0;
>   	erofs_blk_t nblocks, lastblk;
>   	u64 offset = map->m_la;
>   	struct erofs_inode *vi = EROFS_I(inode);
>   	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
>   
> -	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
> -
>   	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
>   	lastblk = nblocks - tailendpacking;
>   
> @@ -57,8 +54,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   				  "inline data cross block boundary @ nid %llu",
>   				  vi->nid);
>   			DBG_BUGON(1);
> -			err = -EFSCORRUPTED;
> -			goto err_out;
> +			return -EFSCORRUPTED;
>   		}
>   
>   		map->m_flags |= EROFS_MAP_META;
> @@ -67,14 +63,10 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>   			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
>   			  vi->nid, inode->i_size, map->m_la);
>   		DBG_BUGON(1);
> -		err = -EIO;
> -		goto err_out;
> +		return -EIO;
>   	}
> -
>   	map->m_llen = map->m_plen;
> -err_out:
> -	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
> -	return err;
> +	return 0;
>   }
>   
>   static int erofs_map_blocks(struct inode *inode,
> @@ -89,6 +81,7 @@ static int erofs_map_blocks(struct inode *inode,
>   	erofs_off_t pos;
>   	int err = 0;
>   
> +	trace_erofs_map_blocks_enter(inode, map, flags);
>   	if (map->m_la >= inode->i_size) {
>   		/* leave out-of-bound access unmapped */
>   		map->m_flags = 0;
> @@ -96,8 +89,10 @@ static int erofs_map_blocks(struct inode *inode,

map->m_flags = 0;
map->m_plen = 0;

It needs to reset map->m_llen to zero here like we did after 'out' label before?

Thanks,

>   		goto out;
>   	}
>   
> -	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
> -		return erofs_map_blocks_flatmode(inode, map, flags);
> +	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
> +		err = erofs_map_blocks_flatmode(inode, map, flags);
> +		goto out;
> +	}
>   
>   	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
>   		unit = sizeof(*idx);			/* chunk index */
> @@ -109,9 +104,10 @@ static int erofs_map_blocks(struct inode *inode,
>   		    vi->xattr_isize, unit) + unit * chunknr;
>   
>   	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> -
> +	if (IS_ERR(page)) {
> +		err = PTR_ERR(page);
> +		goto out;
> +	}
>   	map->m_la = chunknr << vi->chunkbits;
>   	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
>   			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
> @@ -147,11 +143,12 @@ static int erofs_map_blocks(struct inode *inode,
>   		map->m_flags = EROFS_MAP_MAPPED;
>   		break;
>   	}
> +	map->m_llen = map->m_plen;
>   out_unlock:
>   	unlock_page(page);
>   	put_page(page);
>   out:
> -	map->m_llen = map->m_plen;
> +	trace_erofs_map_blocks_exit(inode, map, flags, 0);
>   	return err;
>   }
>   
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index db4f2ce..5c91edd 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,7 +19,8 @@
>   		{ 1,		"DIR" })
>   
>   #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
> +	{ EROFS_GET_BLOCKS_RAW,	"RAW" },		\
> +	{ EROFS_GET_BLOCKS_FIEMAP, "FIEMAP" })
>   
>   #define show_mflags(flags) __print_flags(flags, "",	\
>   	{ EROFS_MAP_MAPPED,	"M" },			\
> @@ -169,7 +170,7 @@
>   		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
>   );
>   
> -DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
> +DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
>   	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>   		 unsigned flags),
>   
> @@ -221,7 +222,7 @@
>   		  show_mflags(__entry->mflags), __entry->ret)
>   );
>   
> -DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
> +DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
>   	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
>   		 unsigned flags, int ret),
>   
> 
