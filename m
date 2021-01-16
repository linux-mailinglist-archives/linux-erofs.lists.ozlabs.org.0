Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF82F8B6E
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 06:20:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHmbn0ZJhzDspy
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 16:20:53 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=AJhVLv6U; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AJhVLv6U; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHmbc6RxZzDspf
 for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jan 2021 16:20:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610774439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cN3aL0fx36IJi9GnISuWN7iWnfcYijjxhEaepF9kFh4=;
 b=AJhVLv6UPjXSK7iZoNcp/txNGFDcrhOMz8yf0tgHoEoC8Mdu72Y3hoF8HM8G5uEAD15Fp5
 94mICdBiKGKnFLYzaMMIbdGIOasPx4OYIYOMJYg98lNh+CpF2MZ/Vcf5LD7UHnBivu25QJ
 pSWjzDalpiazeH5IAAV5iFXnZ2bQ9gc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610774439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cN3aL0fx36IJi9GnISuWN7iWnfcYijjxhEaepF9kFh4=;
 b=AJhVLv6UPjXSK7iZoNcp/txNGFDcrhOMz8yf0tgHoEoC8Mdu72Y3hoF8HM8G5uEAD15Fp5
 94mICdBiKGKnFLYzaMMIbdGIOasPx4OYIYOMJYg98lNh+CpF2MZ/Vcf5LD7UHnBivu25QJ
 pSWjzDalpiazeH5IAAV5iFXnZ2bQ9gc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-Oalbx8b_NtKsYcO61X_tEQ-1; Sat, 16 Jan 2021 00:20:35 -0500
X-MC-Unique: Oalbx8b_NtKsYcO61X_tEQ-1
Received: by mail-pj1-f71.google.com with SMTP id u14so7540493pjl.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jan 2021 21:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cN3aL0fx36IJi9GnISuWN7iWnfcYijjxhEaepF9kFh4=;
 b=JW7sEFfp/j1mXjuY5sNYdZyApRU9g0BrVeMvmx3GUX8FXJtAViBWMm2SYFhS4s/3h/
 v+PQxioMXeX4uwoTLVyCGLsplzTOpCeypa1hnax9BarJrDP52GeYtpPs7l/dz/AyUvQV
 AvmVF8OYPKX45wQ/rKgXbbRxBh//c3OmPLU4T5IwkgGL1uafVuvdx5VVo52KdD+WcnGk
 7c0RprPjalvAAkPf/T3L7V7nrQ2sG/mILfOXN7UAs22WERqBNtGvZr7H9y795K0YOKB6
 h5zENTkxHZ6WYJo1r0YEjHU7g5JYDk4whwmVxiNXblOM0Kbl9nrB5cBYgKmEcXDxGIcs
 uh9g==
X-Gm-Message-State: AOAM532/oebdQRcK6m9cx3r1Q5RqjwaiPUBVsk5DDVL1tLPxvYlyc5Dh
 3H5zisd9UCoseKq09YHhrKjh4o77qqAYdofOa/ZKXoIJv/04zbO+Ay2dETXrAwinRl9dhmuIvBB
 tQg+hxGmi8h2pdQmeTqgt9CwJ
X-Received: by 2002:a62:e314:0:b029:19e:4cc:dc6f with SMTP id
 g20-20020a62e3140000b029019e04ccdc6fmr16251741pfh.33.1610774434477; 
 Fri, 15 Jan 2021 21:20:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy62Mmyy6s6Lgg+QoSYEgLuYWsly7r1MNpI4jjUgsFDd4ZYLaoJeTstdjOoFqGH02ootOYRUQ==
X-Received: by 2002:a62:e314:0:b029:19e:4cc:dc6f with SMTP id
 g20-20020a62e3140000b029019e04ccdc6fmr16251727pfh.33.1610774434168; 
 Fri, 15 Jan 2021 21:20:34 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x27sm10090746pfr.122.2021.01.15.21.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 21:20:33 -0800 (PST)
Date: Sat, 16 Jan 2021 13:20:24 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v3 2/2] erofs-utils: optimize mkfs to O(N), N = #files
Message-ID: <20210116052024.GA2041921@xiangao.remote.csb>
References: <20210116050438.4456-1-hsiangkao@aol.com>
 <20210116050438.4456-2-hsiangkao@aol.com>
MIME-Version: 1.0
In-Reply-To: <20210116050438.4456-2-hsiangkao@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Weiwen,

On Sat, Jan 16, 2021 at 01:04:38PM +0800, Gao Xiang via Linux-erofs wrote:
> From: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
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
> 
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

Also, there are still some duplicated code in erofs_balloc(). Maybe we
need to split some into a new helper. Could you help if time permits?

I've updated some coding style cases. e.g. exceed max 80-character lines
and single statement braces...

Also I'm thinking if we need to add an command line argument for users to
disable such optmization until it can be firmly confirmed stably... is
that necessary? I'm not sure though...

Thanks,
Gao Xiang

> ---
>  include/erofs/cache.h |  1 +
>  lib/cache.c           | 97 ++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 87 insertions(+), 11 deletions(-)
> 
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index f8dff67b9736..611ca5b8432b 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -39,6 +39,7 @@ struct erofs_buffer_head {
>  
>  struct erofs_buffer_block {
>  	struct list_head list;
> +	struct list_head mapped_list;
>  
>  	erofs_blk_t blkaddr;
>  	int type;
> diff --git a/lib/cache.c b/lib/cache.c
> index 32a58311f563..17b2b096632c 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh = {
>  };
>  static erofs_blk_t tail_blkaddr;
>  
> +/* buckets for all mapped buffer blocks to boost up allocation */
> +static struct list_head mapped_buckets[2][EROFS_BLKSIZ];
> +/* last mapped buffer block to accelerate erofs_mapbh() */
> +static struct erofs_buffer_block *last_mapped_block = &blkh;
> +
>  static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
>  {
>  	return erofs_bh_flush_generic_end(bh);
> @@ -62,12 +67,17 @@ struct erofs_bhops erofs_buf_write_bhops = {
>  /* return buffer_head of erofs super block (with size 0) */
>  struct erofs_buffer_head *erofs_buffer_init(void)
>  {
> +	int i, j;
>  	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
>  
>  	if (IS_ERR(bh))
>  		return bh;
>  
>  	bh->op = &erofs_skip_write_bhops;
> +
> +	for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
> +		for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
> +			init_list_head(&mapped_buckets[i][j]);
>  	return bh;
>  }
>  
> @@ -132,20 +142,61 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  	struct erofs_buffer_block *cur, *bb;
>  	struct erofs_buffer_head *bh;
>  	unsigned int alignsize, used0, usedmax;
> +	unsigned int used_before, used;
>  
>  	int ret = get_alignsize(type, &type);
>  
>  	if (ret < 0)
>  		return ERR_PTR(ret);
> +
> +	DBG_BUGON(type < 0 || type > META);
>  	alignsize = ret;
>  
>  	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
>  	usedmax = 0;
>  	bb = NULL;
>  
> -	list_for_each_entry(cur, &blkh.list, list) {
> -		unsigned int used_before, used;
> +	if (used0 == 0 || alignsize == EROFS_BLKSIZ)
> +		goto alloc;
> +
> +	/* Try find a most fit mapped buffer block first. */
> +	for (used_before = 1; used_before < EROFS_BLKSIZ; ++used_before) {
> +		struct list_head *bt = mapped_buckets[type] + used_before;
> +
> +		if (list_empty(bt))
> +			continue;
> +		cur = list_first_entry(bt, struct erofs_buffer_block,
> +				       mapped_list);
> +
> +		ret = __erofs_battach(cur, NULL, size, alignsize,
> +				      required_ext + inline_ext, true);
> +		if (ret < 0)
> +			continue;
> +
> +		used = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
> +
> +		/* should contain inline data in current block */
> +		if (used > EROFS_BLKSIZ)
> +			continue;
> +
> +		/*
> +		 * remaining should be smaller than before or
> +		 * larger than allocating a new buffer block
> +		 */
> +		if (used < used_before && used < used0)
> +			continue;
> +
> +		if (usedmax < used) {
> +			bb = cur;
> +			usedmax = used;
> +		}
> +	}
>  
> +	/* try to start from the last mapped one, which can be extended */
> +	cur = last_mapped_block;
> +	if (cur == &blkh)
> +		cur = list_next_entry(cur, list);
> +	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
>  		used_before = cur->buffers.off % EROFS_BLKSIZ;
>  
>  		/* skip if buffer block is just full */
> @@ -187,6 +238,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  		goto found;
>  	}
>  
> +alloc:
>  	/* allocate a new buffer block */
>  	if (used0 > EROFS_BLKSIZ)
>  		return ERR_PTR(-ENOSPC);
> @@ -200,6 +252,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
>  	bb->buffers.off = 0;
>  	init_list_head(&bb->buffers.list);
>  	list_add_tail(&bb->list, &blkh.list);
> +	init_list_head(&bb->mapped_list);
>  
>  	bh = malloc(sizeof(struct erofs_buffer_head));
>  	if (!bh) {
> @@ -214,6 +267,18 @@ found:
>  	return bh;
>  }
>  
> +static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
> +{
> +	struct list_head *bkt;
> +
> +	if (bb->blkaddr == NULL_ADDR)
> +		return;
> +
> +	bkt = mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
> +	list_del(&bb->mapped_list);
> +	list_add_tail(&bb->mapped_list, bkt);
> +}
> +
>  struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
>  					int type, unsigned int size)
>  {
> @@ -239,6 +304,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
>  		free(nbh);
>  		return ERR_PTR(ret);
>  	}
> +	erofs_bupdate_mapped(bb);
>  	return nbh;
>  
>  }
> @@ -247,8 +313,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  {
>  	erofs_blk_t blkaddr;
>  
> -	if (bb->blkaddr == NULL_ADDR)
> +	if (bb->blkaddr == NULL_ADDR) {
>  		bb->blkaddr = tail_blkaddr;
> +		last_mapped_block = bb;
> +		erofs_bupdate_mapped(bb);
> +	}
>  
>  	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
>  	if (blkaddr > tail_blkaddr)
> @@ -259,15 +328,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
>  
>  erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
>  {
> -	struct erofs_buffer_block *t, *nt;
> +	struct erofs_buffer_block *t = last_mapped_block;
>  
> -	if (!bb || bb->blkaddr == NULL_ADDR) {
> -		list_for_each_entry_safe(t, nt, &blkh.list, list) {
> -			(void)__erofs_mapbh(t);
> -			if (t == bb)
> -				break;
> -		}
> -	}
> +	do {
> +		t = list_next_entry(t, list);
> +		if (t == &blkh)
> +			break;
> +
> +		DBG_BUGON(t->blkaddr != NULL_ADDR);
> +		(void)__erofs_mapbh(t);
> +	} while (t != bb);
>  	return tail_blkaddr;
>  }
>  
> @@ -309,6 +379,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
>  
>  		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
>  
> +		list_del(&p->mapped_list);
>  		list_del(&p->list);
>  		free(p);
>  	}
> @@ -332,6 +403,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
>  	if (!list_empty(&bb->buffers.list))
>  		return;
>  
> +	if (bb == last_mapped_block)
> +		last_mapped_block = list_prev_entry(bb, list);
> +
> +	list_del(&bb->mapped_list);
>  	list_del(&bb->list);
>  	free(bb);
>  
> -- 
> 2.24.0
> 

