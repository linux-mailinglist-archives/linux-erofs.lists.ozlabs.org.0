Return-Path: <linux-erofs+bounces-1778-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23164D074E8
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 07:03:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnWRh52gQz2xQ1;
	Fri, 09 Jan 2026 17:03:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767938624;
	cv=none; b=A0aJ2Qvogifex0GaQXUlUW/WvZabq+7AoO9O1ezqv/Cwtj+UH78ONoZ247HQotDIGu/z8uCSamoO08T7r1i1fUPBGYw93wfiSWIH4QknhOazEgIGnkEDmegeaqH337d7N06Z1ZGIZxm7sr3yJNqhYWgcihKWHvrxXjyQvR2QXGHXv59971H1EmLVU2BsgQxJXOyW3ARIFjq350OfcV3/wtGGAVba1s1eXHzNhO6TfeaQWK31ox/7iCBIV6o+FmlGL03zv6ijs6PNUXsUFgRVfPAmkk/2K5zBS3jarA4z4CcnbR5e9O2PkUhudDc4Pq/8TZkF86bmI3bRPtfDsdAVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767938624; c=relaxed/relaxed;
	bh=WSn8tUN5ji0ImOXN+znur1HXqv1SL9DZ3ghCylvKI/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw4CeaFLDOB+ohNsehSzcYPaCI9xwHUTlRfznc8trCQs8e/NwsRTWV4DzL6Vltpg1kkJxkFhpiQrf1Oo6F0m1AsNtRdQN2JMIFClfhsIAeu+l9FI2NS0PqqCrTY6OmHERvOL3ls/3IYDuBrL99+WX5c2biRo58XKILaDzsv/awK8HiqiPyiDq68mj4YEdOe7ThhE0e+9NiSz65GDh1f21C2dXWdkqWPC6CmUaGKOWCxY3CnwsKX7NyOpn48aBG5TJvzmj6siAc62eXXkuHyQ1lsWIcVYaX2afu/gpUo/dJr4nzJcotvrMqYZ07pbeXmxJOUMeS9oVN5G0iisNDwtPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EuEAkh3C; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EuEAkh3C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnWRd33S1z2y6G
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 17:03:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767938610; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WSn8tUN5ji0ImOXN+znur1HXqv1SL9DZ3ghCylvKI/M=;
	b=EuEAkh3Ccqj/4qm0h0Fv3gAjdn+i2N6gPYn6fSLw6EJgTabF2sVbgQqWISqD+NyK8GQGUqWTlzsMfhp8U5WIjuDRzLdMC+LaxSjunhEAEOSuDsURvA/d+rVdbFHbbzywzjWaVeyTTrj6HyFll2ZsRjMIAZO64G01w4uG+3Ns0K4=
Received: from 30.221.131.232(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwf8qgt_1767938608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 14:03:29 +0800
Message-ID: <d1d84c90-9bca-4f14-a635-6199ce84df48@linux.alibaba.com>
Date: Fri, 9 Jan 2026 14:03:28 +0800
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
Subject: Re: [PATCH v13 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
References: <20260109030140.594936-1-lihongbo22@huawei.com>
 <20260109030140.594936-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109030140.594936-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christoph, Darrick, Christian,

On 2026/1/9 11:01, Hongbo Li wrote:
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
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Could you help review or ack this patch?

This feature is almost in shape for the upcoming cycle,
I do hope this iomap patch could be reviewed, thanks!

Thanks,
Gao Xiang

> ---
>   fs/fuse/file.c         | 4 ++--
>   fs/iomap/buffered-io.c | 6 ++++--
>   include/linux/iomap.h  | 8 ++++----
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..f5d8887c1922 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>   		return -EIO;
>   	}
>   
> -	iomap_read_folio(&fuse_iomap_ops, &ctx);
> +	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>   	fuse_invalidate_atime(inode);
>   	return 0;
>   }
> @@ -1081,7 +1081,7 @@ static void fuse_readahead(struct readahead_control *rac)
>   	if (fuse_is_bad(inode))
>   		return;
>   
> -	iomap_readahead(&fuse_iomap_ops, &ctx);
> +	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>   }
>   
>   static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d93..5f7dcbabbda3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
>   	size_t bytes_submitted = 0;
>   	int ret;
> @@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
>   	size_t cur_bytes_submitted;
>   
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb501..441d614e9fdf 100644
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
> @@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
>   		.cur_folio	= folio,
>   	};
>   
> -	iomap_read_folio(ops, &ctx);
> +	iomap_read_folio(ops, &ctx, NULL);
>   }
>   
>   static inline void iomap_bio_readahead(struct readahead_control *rac,
> @@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
>   		.rac		= rac,
>   	};
>   
> -	iomap_readahead(ops, &ctx);
> +	iomap_readahead(ops, &ctx, NULL);
>   }
>   #endif /* CONFIG_BLOCK */
>   


