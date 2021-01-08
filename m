Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484312EF733
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jan 2021 19:17:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCBCN3mdKzDr8v
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Jan 2021 05:17:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FoQfHP5w; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CCCt+I7f; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DCBCF607TzDr7j
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Jan 2021 05:17:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610129830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk5NArUsROH3mjV/lkcmYjtwBeu7Yh4qURsQdXocSGA=;
 b=FoQfHP5wluIPlctt6h5saKRhX3qcDhY2yM0SIlD15QA2Qvx6d2O8URdZ3XuWIDd5M+MkQc
 fxzK/Md8hrLZ+H+yAwal4mYrX5hupUFuPdgFWR7wjKYTFJrxIuKAWqiEBnbzJYUgwoUrMN
 MMowcDdJX81Tb+SmzWs195YqFHKVR1s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610129831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wk5NArUsROH3mjV/lkcmYjtwBeu7Yh4qURsQdXocSGA=;
 b=CCCt+I7fPvFLCGe5nzasFLbir6AQpmXT+GR7ZvcnjjLWGZCRAtFNAdL8QbP7wSo6Qtg9FP
 kgmiafJeOh2aYGNNyXDN+2zvFlKvkFH0LlidZEpHatKM0x4vErSoI4yi3LDewlD4IxWTps
 c+gaHHL0XsWpgG2eq1C9ebm339p8Hbw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-MYtJ70pOPfazjHZBf9K5bQ-1; Fri, 08 Jan 2021 13:15:57 -0500
X-MC-Unique: MYtJ70pOPfazjHZBf9K5bQ-1
Received: by mail-pj1-f69.google.com with SMTP id gv14so7602403pjb.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 08 Jan 2021 10:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=wk5NArUsROH3mjV/lkcmYjtwBeu7Yh4qURsQdXocSGA=;
 b=qSi5C66PKJgkduurc40QJ/7OM7e00Wn6R7+b1ZTwNfFqWzouvGLXiBa7Ut5ELw2zmV
 /pjJN85bst2hEeAVHGgJU2doxFxr13svPk2nOrtA7CxUgxXZzHyw1S2YojN2qIUSWAiT
 hqp+Jo5qvZnTTay/BUb4nJEM9hq566xi/lwCM+M2arI9yJcY0W/sEFLtvgF8YcRdeEfP
 Me/jhClQbyN0+hQl1ZG1rXyhbXWV40YYTZGyvba0ngK5mSIFQ4DZx7+6mftLCsl9jd7c
 Zid6K3MQrOYA2AHfW7bWjeZS/ZhmCARzrE7a+4IoXf6G2LZcyq0nLWO8HFiAJUjDN/7J
 DisA==
X-Gm-Message-State: AOAM5336iGbOevUdsSPbj0Eg6P/oFXwr87GvWe52dFjJ+DQw5L2yutT4
 VUwRtVav9zWdS0ulQu2oFrU2qrRBlgWkrDoHIhGhdqTe0I5/oGaWyJVuFZLAUaCO0jX/jWdTqcE
 Znp6S1HNA/ZP9Qk/RxA7LoLo3
X-Received: by 2002:a17:902:eb03:b029:db:c0d6:5845 with SMTP id
 l3-20020a170902eb03b02900dbc0d65845mr8135291plb.76.1610129756612; 
 Fri, 08 Jan 2021 10:15:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUWIa4bZ4B0ZFkOYMkGF2Sz96r0lv7qI6OwY7YTVmD4swgQi03sbmm0S+eiTgh7+VRrGf60A==
X-Received: by 2002:a17:902:eb03:b029:db:c0d6:5845 with SMTP id
 l3-20020a170902eb03b02900dbc0d65845mr8135264plb.76.1610129756293; 
 Fri, 08 Jan 2021 10:15:56 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c18sm9306081pfj.200.2021.01.08.10.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 10:15:55 -0800 (PST)
Date: Sat, 9 Jan 2021 02:15:45 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: =?utf-8?B?6IOh546u5paH?= <huww98@outlook.com>
Subject: Re: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Message-ID: <20210108181545.GA613131@xiangao.remote.csb>
References: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
Cc: Gao Xiang <gaoxiang25@huawei.com>, linux-erofs@lists.ozlabs.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Fri, Jan 01, 2021 at 05:11:57PM +0800, 胡玮文 wrote:
> When using EROFS to pack our dataset which consists of millions of
> files, mkfs.erofs is very slow compared with mksquashfs.
> 
> The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
> iterate over all previously allocated buffer blocks, making the
> complexity of the algrithm O(N^2) where N is the number of files.
> 
> With this patch:
> 
> * global `last_mapped_block` is mantained to avoid full scan in
>   `erofs_mapbh` function.
> 
> * global `non_full_buffer_blocks` mantains a list of buffer block for
>   each type and each possible remaining bytes in the block. Then it is
>   used to identify the most suitable blocks in future `erofs_balloc`,
>   avoiding full scan.
> 
> Some new data structure is allocated in this patch, more RAM usage is
> expected, but not much. When I test it with ImageNet dataset (1.33M
> files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
> spent on IO.

Thanks for your patch again. I've read your patch, sorry about the delay
due to my pending work.

The idea generally looks to me.
Some suggestion about this as follows... :)

> 
> Signed-off-by: Hu Weiwen <huww98@outlook.com>
> ---
>  lib/cache.c | 102 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/cache.c b/lib/cache.c
> index 0d5c4a5..3412a0b 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -18,6 +18,18 @@ static struct erofs_buffer_block blkh = {
>  };
>  static erofs_blk_t tail_blkaddr;
>  
> +/**
> + * Some buffers are not full, we can reuse it to store more data
> + * 2 for DATA, META
> + * EROFS_BLKSIZ for each possible remaining bytes in the last block
> + **/
> +static struct erofs_buffer_block_record {
> +	struct list_head list;
> +	struct erofs_buffer_block *bb;
> +} non_full_buffer_blocks[2][EROFS_BLKSIZ];
> +

How about integrating the list_head to struct erofs_buffer_block and therefore
no need to malloc(struct erofs_buffer_block_record)?

and then we have
static struct list_head nonfull_bb_buckets[2][EROFS_BLKSIZ];

> +static struct erofs_buffer_block *last_mapped_block = &blkh;
> +
>  static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
>  {
>  	return erofs_bh_flush_generic_end(bh);
> @@ -62,6 +74,12 @@ struct erofs_bhops erofs_buf_write_bhops = {
>  /* return buffer_head of erofs super block (with size 0) */
>  struct erofs_buffer_head *erofs_buffer_init(void)
>  {
> +	for (int i = 0; i < 2; i++) {
> +		for (int j = 0; j < EROFS_BLKSIZ; j++) {
> +			init_list_head(&non_full_buffer_blocks[i][j].list);
> +		}
> +	}
> +

erofs-utils follows kernel coding style. so for the single statement,
no need to introduce braces...

https://www.kernel.org/doc/html/latest/process/coding-style.html

>  	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
>  
>  	if (IS_ERR(bh))
> @@ -131,7 +149,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  {
>  	struct erofs_buffer_block *cur, *bb;
>  	struct erofs_buffer_head *bh;
> -	unsigned int alignsize, used0, usedmax;
> +	unsigned int alignsize, used0, usedmax, total_size;
> +	struct erofs_buffer_block_record * reusing = NULL;
>  
>  	int ret = get_alignsize(type, &type);
>  
> @@ -143,7 +162,38 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  	usedmax = 0;
>  	bb = NULL;
>  
> -	list_for_each_entry(cur, &blkh.list, list) {
> +	erofs_dbg("balloc size=%lu alignsize=%u used0=%u", size, alignsize, used0);
> +	if (used0 == 0 || alignsize == EROFS_BLKSIZ) {
> +		goto alloc;
> +	}

same here.

> +	total_size = size + required_ext + inline_ext;
> +	if (total_size < EROFS_BLKSIZ) {
> +		// Try find a most fit block.
> +		DBG_BUGON(type < 0 || type > 1);
> +		struct erofs_buffer_block_record *non_fulls = non_full_buffer_blocks[type];
> +		for (struct erofs_buffer_block_record *r = non_fulls + round_up(total_size, alignsize);
> +				r < non_fulls + EROFS_BLKSIZ; r++) {
> +			if (!list_empty(&r->list)) {
> +				struct erofs_buffer_block_record *reuse_candidate =
> +						list_first_entry(&r->list, struct erofs_buffer_block_record, list);
> +				ret = __erofs_battach(reuse_candidate->bb, NULL, size, alignsize,
> +						required_ext + inline_ext, true);
> +				if (ret >= 0) {
> +					reusing = reuse_candidate;
> +					bb = reuse_candidate->bb;
> +					usedmax = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
> +				}
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* Try reuse last ones, which are not mapped and can be extended */
> +	cur = last_mapped_block;
> +	if (cur == &blkh) {
> +		cur = list_next_entry(cur, list);
> +	}

same here. 

> +	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
>  		unsigned int used_before, used;
>  
>  		used_before = cur->buffers.off % EROFS_BLKSIZ;
> @@ -175,22 +225,32 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  			continue;
>  
>  		if (usedmax < used) {
> +			reusing = NULL;
>  			bb = cur;
>  			usedmax = used;
>  		}
>  	}
>  
>  	if (bb) {
> +		erofs_dbg("reusing buffer. usedmax=%u", usedmax);
>  		bh = malloc(sizeof(struct erofs_buffer_head));
>  		if (!bh)
>  			return ERR_PTR(-ENOMEM);
> +		if (reusing) {
> +			list_del(&reusing->list);
> +			free(reusing);
> +		}
>  		goto found;
>  	}
>  
> +alloc:
>  	/* allocate a new buffer block */
> -	if (used0 > EROFS_BLKSIZ)
> +	if (used0 > EROFS_BLKSIZ) {
> +		erofs_dbg("used0 > EROFS_BLKSIZ");
>  		return ERR_PTR(-ENOSPC);
> +	}
>  
> +	erofs_dbg("new buffer block");
>  	bb = malloc(sizeof(struct erofs_buffer_block));
>  	if (!bb)
>  		return ERR_PTR(-ENOMEM);
> @@ -211,6 +271,16 @@ found:
>  			      required_ext + inline_ext, false);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
> +	if (ret != 0) {
> +		/* This buffer is not full yet, we may reuse it */
> +		reusing = malloc(sizeof(struct erofs_buffer_block_record));
> +		if (!reusing) {
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		reusing->bb = bb;
> +		list_add_tail(&reusing->list,
> +				&non_full_buffer_blocks[type][EROFS_BLKSIZ - ret - inline_ext].list);
> +	}
>  	return bh;
>  }
>  
> @@ -247,8 +317,10 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  {
>  	erofs_blk_t blkaddr;
>  
> -	if (bb->blkaddr == NULL_ADDR)
> +	if (bb->blkaddr == NULL_ADDR) {
>  		bb->blkaddr = tail_blkaddr;
> +		last_mapped_block = bb;
> +	}
>  
>  	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
>  	if (blkaddr > tail_blkaddr)
> @@ -259,15 +331,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  
>  erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
>  {
> -	struct erofs_buffer_block *t, *nt;
> -
> -	if (!bb || bb->blkaddr == NULL_ADDR) {
> -		list_for_each_entry_safe(t, nt, &blkh.list, list) {
> -			if (!end && (t == bb || nt == &blkh))
> -				break;
> -			(void)__erofs_mapbh(t);
> -			if (end && t == bb)
> -				break;
> +	DBG_BUGON(!end);
> +	struct erofs_buffer_block *t = last_mapped_block;
> +	while (1) {
> +		t = list_next_entry(t, list);
> +		if (t == &blkh) {
> +			break;
> +		}
> +		(void)__erofs_mapbh(t);
> +		if (t == bb) {
> +			break;
>  		}
>  	}
>  	return tail_blkaddr;
> @@ -334,6 +407,9 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
>  	if (!list_empty(&bb->buffers.list))
>  		return;
>  
> +	if (bb == last_mapped_block) {
> +		last_mapped_block = list_prev_entry(bb, list);
> +	}

same here.

Also, you could sent the patchset (I mean [PATCH 1/2],[PATCH 2/2]) entirely as a thread,
for example by using git send-email * --to="linux-erofs@lists.ozlabs" --cc="...."


Thanks,
Gao Xiang

>  	list_del(&bb->list);
>  	free(bb);
>  
> -- 
> 2.30.0
> 

