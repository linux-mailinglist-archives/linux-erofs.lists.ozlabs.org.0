Return-Path: <linux-erofs+bounces-1377-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24159C61432
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Nov 2025 13:01:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8TxV6nWtz2xqj;
	Sun, 16 Nov 2025 23:01:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763294494;
	cv=none; b=aU+96m7V5bNrTaZDbFWCtLHNgi/N0YscSN3fnhEnQE9R+V9zu03wPNUEDMNNzKf0UnICbT6vJY4CNxRmztTqyr9fXbzSFURzcpGz3/3sFDAQn6fvAnJiHj5fJJFG1u6RBOwQ8kt6J/+j/DMQ29g+/KFZxyGBmVEV8YBgncSXrfv5I9vy77z0YoF9X4b8a+UxUkAe6q0mt2s6ipWNOD5zMXwX4bALja96nnL7X7NlUT/toj1QcNoTSKsBm2JUNp594iCef9+x25CPr8I8pPR41QGjHPqNnoRWfWlDliutrvnu9p/F6EnyKG34TgFXE9Ne3Csw25S5Fn+ghfJBYkhZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763294494; c=relaxed/relaxed;
	bh=gneyMDW+YpWlILj4VMhSNxwPUQEUD67fBdmsbKndoUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUPHFY+sVla15aYfqu5xTjtP32zBlWxslGUKLfrurYI9rItROBe8lMqHFRdKwRpAtWawoaVR2pUv8UiBN+GQPeKGHjWip6VhMRzV+DONv8C2LaFRwlklX2hVInmLa6p+qqQYx1oC5XGWZ7jOGlrtBqqzGgbTF5pUBoUNh4vE0p69cZTSV7vFuhthbr46sk1eVxdfJh/JSXh+F8amoc5PuLaRb2fI9FS3ydkxlSbkMFwRd7SByJw1ZTdX+8TvsB198LaX1feoBWxaqF9IMVb6XRP9tdMuRKg+xkzpOU2ut+yciYI5slbEDBcziTpHnArIsB0Ni3IkhJ4/iuLWkI6rHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n2fIKVCX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n2fIKVCX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8TxS4y0Gz2xqL
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Nov 2025 23:01:31 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763294486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gneyMDW+YpWlILj4VMhSNxwPUQEUD67fBdmsbKndoUU=;
	b=n2fIKVCXDATOG42UQ3tRthRzz41RTvJhXOvCTBHqjSquODxDTGzy9sA4+uxa93AFmRCLxaSKpW6NGgD0c0nDTHAx7plCIHb9YRZvsfFhLxSi65bDPRAmKlijqygPsmLeDTybQ0ElOfzFsthDzt1j1HYUz7n/mRPTAOt32NMNV9I=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSHSBM_1763294484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 20:01:25 +0800
Message-ID: <f714479d-703c-4fc6-ad5a-b18d92f0a9b7@linux.alibaba.com>
Date: Sun, 16 Nov 2025 20:01:24 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] erofs: hold read context in iomap_iter if needed
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-3-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-3-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> Uncoming page cache sharing needs pass read context to iomap_iter,
> here we unify the way of passing the read context in EROFS. Moreover,
> bmap and fiemap don't need to map the inline data.
> 
> Note that we keep `struct page *` in `struct erofs_iomap_iter_ctx` as
> well to avoid bogus kmap_to_page usage.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/data.c | 79 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index bb13c4cb8455..bd3d85c61341 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -266,14 +266,23 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
>   	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
>   }
>   
> +struct erofs_iomap_iter_ctx {
> +	struct page *page;
> +	void *base;
> +};
> +
>   static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
>   {
>   	int ret;
> +	struct erofs_iomap_iter_ctx *ctx;
>   	struct super_block *sb = inode->i_sb;
>   	struct erofs_map_blocks map;
>   	struct erofs_map_dev mdev;
> +	struct iomap_iter *iter;
>   
> +	iter = container_of(iomap, struct iomap_iter, iomap);
> +	ctx = iter->private;

Can you just rearrange it as:

	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
	struct erofs_iomap_iter_ctx *ctx = iter->private;

?

>   	map.m_la = offset;
>   	map.m_llen = length;
>   	ret = erofs_map_blocks(inode, &map);
> @@ -283,7 +292,8 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	iomap->offset = map.m_la;
>   	iomap->length = map.m_llen;
>   	iomap->flags = 0;
> -	iomap->private = NULL;
> +	if (ctx)
> +		ctx->base = NULL;

I think this line is unnecessary if iter->private == ctx;

>   	iomap->addr = IOMAP_NULL_ADDR;
>   	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>   		iomap->type = IOMAP_HOLE;
> @@ -309,16 +319,20 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	}
>   
>   	if (map.m_flags & EROFS_MAP_META) {
> -		void *ptr;
> -		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> -
>   		iomap->type = IOMAP_INLINE;
> -		ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> -					 erofs_inode_in_metabox(inode));
> -		if (IS_ERR(ptr))
> -			return PTR_ERR(ptr);
> -		iomap->inline_data = ptr;
> -		iomap->private = buf.base;
> +		/* read context should read the inlined data */
> +		if (ctx) {
> +			void *ptr;
> +			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;

better to resort them as:
			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
			void *ptr;

> +
> +			ptr = erofs_read_metabuf(&buf, sb, map.m_pa,
> +						 erofs_inode_in_metabox(inode));
> +			if (IS_ERR(ptr))
> +				return PTR_ERR(ptr);
> +			iomap->inline_data = ptr;
> +			ctx->page = buf.page;
> +			ctx->base = buf.base;
> +		}
>   	} else {
>   		iomap->type = IOMAP_MAPPED;
>   	}
> @@ -328,18 +342,19 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
>   		ssize_t written, unsigned int flags, struct iomap *iomap)
>   {
> -	void *ptr = iomap->private;
> +	struct erofs_iomap_iter_ctx *ctx;
> +	struct iomap_iter *iter;
>   
> -	if (ptr) {
> +	iter = container_of(iomap, struct iomap_iter, iomap);
> +	ctx = iter->private;
> +	if (ctx && ctx->base) {
>   		struct erofs_buf buf = {
> -			.page = kmap_to_page(ptr),
> -			.base = ptr,
> +			.page = ctx->page,
> +			.base = ctx->base,
>   		};
>   
>   		DBG_BUGON(iomap->type != IOMAP_INLINE);
>   		erofs_put_metabuf(&buf);

so need to nullify ctx->base here:

		ctx->base = NULL;

> -	} else {
> -		DBG_BUGON(iomap->type == IOMAP_INLINE);
>   	}
>   	return written;
>   }
> @@ -369,18 +384,36 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>    */
>   static int erofs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct iomap_read_folio_ctx read_ctx = {
> +		.ops		= &iomap_bio_read_ops,
> +		.cur_folio	= folio,
> +	};
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.page		= NULL,
> +		.base		= NULL,
> +	};

it can be initialized just by:
	struct erofs_iomap_iter_ctx iter_ctx = {};

> +
>   	trace_erofs_read_folio(folio, true);
>   
> -	iomap_bio_read_folio(folio, &erofs_iomap_ops);
> +	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>   	return 0;
>   }
>   
>   static void erofs_readahead(struct readahead_control *rac)
>   {
> +	struct iomap_read_folio_ctx read_ctx = {
> +		.ops		= &iomap_bio_read_ops,
> +		.rac		= rac,
> +	};
> +	struct erofs_iomap_iter_ctx iter_ctx = {
> +		.page		= NULL,
> +		.base		= NULL,
> +	};

Same here.

> +
>   	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>   					readahead_count(rac), true);
>   
> -	iomap_bio_readahead(rac, &erofs_iomap_ops);
> +	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>   }
>   
>   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> @@ -400,9 +433,15 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	if (IS_DAX(inode))
>   		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>   #endif
> -	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
> +	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev) {
> +		struct erofs_iomap_iter_ctx iter_ctx = {
> +			.page = NULL,
> +			.base = NULL,
> +		};

Same here again.

Thanks,
Gao Xiang

