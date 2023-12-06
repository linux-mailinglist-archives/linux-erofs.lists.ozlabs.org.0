Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0D08072B0
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 15:42:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Slg8j6KjMz3cDk
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Dec 2023 01:41:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.237; helo=smtp237.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Slg8b3XjGz3bws
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Dec 2023 01:41:49 +1100 (AEDT)
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id D2FFB7FA53;
	Wed,  6 Dec 2023 22:41:36 +0800 (CST)
Received: from [192.168.1.104] (unknown [111.186.0.119])
	by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id 955C23FC532;
	Wed,  6 Dec 2023 22:41:32 +0800 (CST)
Message-ID: <26fcca1d-3bc3-4667-8806-ae9833c6a29e@sjtu.edu.cn>
Date: Wed, 6 Dec 2023 22:41:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix lz4 inplace decompression
Content-Language: en-US
To: linux-erofs@lists.ozlabs.org
References: <20231206045534.3920847-1-hsiangkao@linux.alibaba.com>
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20231206045534.3920847-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qkrwngud825@gmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

I'm writing code for multi-threaded compression of erofs, and I also ran 
into a weird bug where in-place decompression gives an incorrect result, 
but erofsfuse decompression works fine.

I could reproduce the problem Juhyung encountered in my machine, and I 
think my bug is caused by the same reason. Gao's patch successfully 
fixes the problem that both Juhyung and I encountered in my machine.


Tested-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>


Thanks,

Yifan Zhao

On 2023/12/6 12:55, Gao Xiang wrote:
> Currently EROFS can map another compressed buffer for inplace
> decompression, that was used to handle the cases that some pages of
> compressed data are actually not in-place I/O.
>
> However, like most simple LZ77 algorithms, LZ4 expects the compressed
> data is arranged at the end of the decompressed buffer and it
> explicitly uses memmove() to handle overlapping:
>    __________________________________________________________
>   |_ direction of decompression --> ____ |_ compressed data _|
>
> Although EROFS arranges compressed data like this, it typically maps two
> individual virtual buffers so the relative order is uncertain.
> Previously, it was hardly observed since LZ4 only uses memmove() for
> short overlapped literals and x86/arm64 memmove implementations seem to
> completely cover it up and they don't have this issue.  Juhyung reported
> that EROFS data corruption can be found on a new Intel x86 processor.
> After some analysis, it seems that recent x86 processors with the new
> FSRM feature expose this issue with "rep movsb".
>
> Let's strictly use the decompressed buffer for lz4 inplace
> decompression for now.  Later, as an useful improvement, we could try
> to tie up these two buffers together in the correct order.
>
> Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
> Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
> Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Cc: stable <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>   - address some nits pointed out by Juhyung.
>
>   fs/erofs/decompressor.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 5ec11f5024b7..d08a6ee23ac5 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -121,11 +121,11 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>   }
>   
>   static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
> -			void *inpage, unsigned int *inputmargin, int *maptype,
> -			bool may_inplace)
> +			void *inpage, void *out, unsigned int *inputmargin,
> +			int *maptype, bool may_inplace)
>   {
>   	struct z_erofs_decompress_req *rq = ctx->rq;
> -	unsigned int omargin, total, i, j;
> +	unsigned int omargin, total, i;
>   	struct page **in;
>   	void *src, *tmp;
>   
> @@ -135,12 +135,13 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
>   		    omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize))
>   			goto docopy;
>   
> -		for (i = 0; i < ctx->inpages; ++i) {
> -			DBG_BUGON(rq->in[i] == NULL);
> -			for (j = 0; j < ctx->outpages - ctx->inpages + i; ++j)
> -				if (rq->out[j] == rq->in[i])
> -					goto docopy;
> -		}
> +		for (i = 0; i < ctx->inpages; ++i)
> +			if (rq->out[ctx->outpages - ctx->inpages + i] !=
> +			    rq->in[i])
> +				goto docopy;
> +		kunmap_local(inpage);
> +		*maptype = 3;
> +		return out + ((ctx->outpages - ctx->inpages) << PAGE_SHIFT);
>   	}
>   
>   	if (ctx->inpages <= 1) {
> @@ -148,7 +149,6 @@ static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ctx *ctx,
>   		return inpage;
>   	}
>   	kunmap_local(inpage);
> -	might_sleep();
>   	src = erofs_vm_map_ram(rq->in, ctx->inpages);
>   	if (!src)
>   		return ERR_PTR(-ENOMEM);
> @@ -204,12 +204,12 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>   }
>   
>   static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
> -				      u8 *out)
> +				      u8 *dst)
>   {
>   	struct z_erofs_decompress_req *rq = ctx->rq;
>   	bool support_0padding = false, may_inplace = false;
>   	unsigned int inputmargin;
> -	u8 *headpage, *src;
> +	u8 *out, *headpage, *src;
>   	int ret, maptype;
>   
>   	DBG_BUGON(*rq->in == NULL);
> @@ -230,11 +230,12 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>   	}
>   
>   	inputmargin = rq->pageofs_in;
> -	src = z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
> +	src = z_erofs_lz4_handle_overlap(ctx, headpage, dst, &inputmargin,
>   					 &maptype, may_inplace);
>   	if (IS_ERR(src))
>   		return PTR_ERR(src);
>   
> +	out = dst + rq->pageofs_out;
>   	/* legacy format could compress extra data in a pcluster. */
>   	if (rq->partial_decoding || !support_0padding)
>   		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
> @@ -265,7 +266,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>   		vm_unmap_ram(src, ctx->inpages);
>   	} else if (maptype == 2) {
>   		erofs_put_pcpubuf(src);
> -	} else {
> +	} else if (maptype != 3) {
>   		DBG_BUGON(1);
>   		return -EFAULT;
>   	}
> @@ -308,7 +309,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
>   	}
>   
>   dstmap_out:
> -	ret = z_erofs_lz4_decompress_mem(&ctx, dst + rq->pageofs_out);
> +	ret = z_erofs_lz4_decompress_mem(&ctx, dst);
>   	if (!dst_maptype)
>   		kunmap_local(dst);
>   	else if (dst_maptype == 2)
