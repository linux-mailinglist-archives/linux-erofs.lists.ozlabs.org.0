Return-Path: <linux-erofs+bounces-1375-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE230C613F7
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Nov 2025 12:53:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d8Tlv1NKJz2xqL;
	Sun, 16 Nov 2025 22:53:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763293995;
	cv=none; b=USYEiPolInzk8wy/CPUpXWkCH3u4tGL9wYSk3bO3jCQ6ilm9I5U4F/MiUkA+MSgGteLgJjc1V5MlkrgiKUFfxMGbeXL4yj0upMGp2sO4M4z6/NZGTrsO1hT4pX7RMSn5iZS0W+Ae2mC5wDjgUNDiOUrCPSVQ4juP2qX72vQ2sD4Z4szoAzK2SwYe/F8NdR3fADdxeroy+NkWNGR4ddxX2gh3fCw10ldCgvyU48UjGKg+RY4ni6E3MXEemAHgadXnPCunB4oxXHEqUHtXDqTaN8jG2RwHzvd8MeV3ifOKH9siyhEn4qpQmgLQFry9LEheREllrG395HkwE3gu6o9OtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763293995; c=relaxed/relaxed;
	bh=1ZEpqh4H+XHx/nCqMadPKeLPzQIshIyntSPO0k8Dcsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmaABMv4hHluwIPHbLSC4Dd9PFVHJ65Tj5Vceo6UL/9FoQmq76UbKRw6xUB1LIviHg6hIgVRqU3bc2aGroq3RdIY8JC6RErkeUdCpESyAcuDvuunR1O/pHHx8F2AzZkQm3RIBalPeKi2yV04w3qt1rzP16IEHeY1m1GI1gwS0ZVqsEvYilgZd19CUgZk93C4hEFWcXHrdzzbnFZwcUeuf7e6A7yN2+px89KypsgiGzXA4+MyC2+tbEcLhPxvKiSIzwJowz1cjTITgDh1V/TBdzfQKKIaqRjE5JdWgCBZhaABVJtGKjbgnNAFJIDLfc0ejNZK81H/W0IaNLxHyLRJ0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lPsnXroi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lPsnXroi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d8Tlr14H9z2xlK
	for <linux-erofs@lists.ozlabs.org>; Sun, 16 Nov 2025 22:53:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763293984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1ZEpqh4H+XHx/nCqMadPKeLPzQIshIyntSPO0k8Dcsc=;
	b=lPsnXroi3LBw6/+ITyoxw6AEdthH26FhP2dhGp+wsr3uIPYkookZlWzuaHktcUPERCHm3CFdFEuEWfNg5zWDnUaif32cKcr06lBRo2RTTOHpG1+rAOEq5iiIZMobzOdAyWuf2Ff4EB+x52Gxyb7efZYGKR7NMyrgPb6upj3Lc00=
Received: from 30.170.196.81(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsSHQRa_1763293981 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Nov 2025 19:53:02 +0800
Message-ID: <f50c667a-bad6-431c-9196-235c7a519590@linux.alibaba.com>
Date: Sun, 16 Nov 2025 19:53:01 +0800
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
Subject: Re: [PATCH v8 1/9] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/14 17:55, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/fuse/file.c         | 4 ++--
>   fs/iomap/buffered-io.c | 6 ++++--
>   include/linux/iomap.h  | 8 ++++----
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8275b6681b9b..98dd20f0bb53 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -973,7 +973,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>   		return -EIO;
>   	}
>   
> -	iomap_read_folio(&fuse_iomap_ops, &ctx);
> +	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>   	fuse_invalidate_atime(inode);
>   	return 0;
>   }
> @@ -1075,7 +1075,7 @@ static void fuse_readahead(struct readahead_control *rac)
>   	if (fuse_is_bad(inode))
>   		return;
>   
> -	iomap_readahead(&fuse_iomap_ops, &ctx);
> +	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>   }
>   
>   static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6ae031ac8058..8e79303c074e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -496,13 +496,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>   }
>   
>   void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>   {
>   	struct folio *folio = ctx->cur_folio;
>   	struct iomap_iter iter = {
>   		.inode		= folio->mapping->host,
>   		.pos		= folio_pos(folio),
>   		.len		= folio_size(folio),
> +		.private	= private,
>   	};
>   	size_t bytes_pending = 0;
>   	int ret;
> @@ -560,13 +561,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>    * the filesystem to be reentered.
>    */
>   void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>   {
>   	struct readahead_control *rac = ctx->rac;
>   	struct iomap_iter iter = {
>   		.inode	= rac->mapping->host,
>   		.pos	= readahead_pos(rac),
>   		.len	= readahead_length(rac),
> +		.private = private,
>   	};
>   	size_t cur_bytes_pending;
>   
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b1ac08c7474..c3ecbbdb14e8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>   		const struct iomap_ops *ops,
>   		const struct iomap_write_ops *write_ops, void *private);
>   void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>   void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>   bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>   struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>   bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> @@ -594,7 +594,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
>   		.cur_folio	= folio,
>   	};
>   
> -	iomap_read_folio(ops, &ctx);
> +	iomap_read_folio(ops, &ctx, NULL);
>   }
>   
>   static inline void iomap_bio_readahead(struct readahead_control *rac,
> @@ -605,7 +605,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
>   		.rac		= rac,
>   	};
>   
> -	iomap_readahead(ops, &ctx);
> +	iomap_readahead(ops, &ctx, NULL);
>   }
>   #endif /* CONFIG_BLOCK */
>   


