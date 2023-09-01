Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942D78F7CC
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 07:07:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RcQxl6QgXz3bkm
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 15:07:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RcQxd0cPjz2ym1
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Sep 2023 15:06:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vr0WGWc_1693544811;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vr0WGWc_1693544811)
          by smtp.aliyun-inc.com;
          Fri, 01 Sep 2023 13:06:52 +0800
Message-ID: <e1960051-bcd2-9c54-9396-08d2d5b665d1@linux.alibaba.com>
Date: Fri, 1 Sep 2023 13:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] erofs-utils: lib: fix `last_mapped_block` in
 erofs_bflush()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230901031244.108189-1-hsiangkao@linux.alibaba.com>
 <20230901031634.115999-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230901031634.115999-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/1/23 11:16 AM, Gao Xiang wrote:
> Currently, calling erofs_bflush() multiple times is broken due to
> outdated `last_mapped_block`.
> 
> Fixes: 82dee4501c5a ("erofs-utils: mkfs: enable xattr name filter feature by default")
> Fixes: 185b0bcdef4b ("erofs-utils: optimize buffer allocation logic")
> Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

> ---
> RESEND:
>  - fix my mismatch svb.
> 
>  lib/cache.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/cache.c b/lib/cache.c
> index d6e9b47..925054a 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -349,6 +349,18 @@ erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
>  	return tail_blkaddr;
>  }
>  
> +static void erofs_bfree(struct erofs_buffer_block *bb)
> +{
> +	DBG_BUGON(!list_empty(&bb->buffers.list));
> +
> +	if (bb == last_mapped_block)
> +		last_mapped_block = list_prev_entry(bb, list);
> +
> +	list_del(&bb->mapped_list);
> +	list_del(&bb->list);
> +	free(bb);
> +}
> +
>  bool erofs_bflush(struct erofs_buffer_block *bb)
>  {
>  	const unsigned int blksiz = erofs_blksiz(&sbi);
> @@ -384,13 +396,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
>  			dev_fillzero(&sbi, erofs_pos(&sbi, blkaddr) - padding,
>  				     padding, true);
>  
> -		DBG_BUGON(!list_empty(&p->buffers.list));
> -
>  		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
> -
> -		list_del(&p->mapped_list);
> -		list_del(&p->list);
> -		free(p);
> +		erofs_bfree(p);
>  	}
>  	return true;
>  }
> @@ -412,12 +419,7 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
>  	if (!list_empty(&bb->buffers.list))
>  		return;
>  
> -	if (bb == last_mapped_block)
> -		last_mapped_block = list_prev_entry(bb, list);
> -
> -	list_del(&bb->mapped_list);
> -	list_del(&bb->list);
> -	free(bb);
> +	erofs_bfree(bb);
>  
>  	if (rollback)
>  		tail_blkaddr = blkaddr;

-- 
Thanks,
Jingbo
