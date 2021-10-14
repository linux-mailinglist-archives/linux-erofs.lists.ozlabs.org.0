Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 468DD42D2EE
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 08:49:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVKl35DbZz2xrC
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 17:49:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVKkz47pmz2xMw
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 17:49:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UrlGJ8P_1634194154; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UrlGJ8P_1634194154) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Oct 2021 14:49:15 +0800
Date: Thu, 14 Oct 2021 14:49:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2] erofs: remove the fast path of per-CPU buffer
 decompression
Message-ID: <YWfS6Tm1AtIWgDj6@B-P7TQMD6M-0146.local>
References: <20211014063901.1629-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014063901.1629-1-zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 14, 2021 at 02:39:01PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> As Xiang mentioned, such path has no real impact to our current
> decompression strategy, remove it directly. Also, update the return
> value of z_erofs_lz4_decompress() to 0 if success to keep consistent
> with LZMA which will return 0 for that case.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2: just set ret = 0 in else branch and rearrange if statement into one line.
> 
>  fs/erofs/decompressor.c | 63 +++++++------------------------------------------
>  1 file changed, 8 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 88e33ad..f8a372e 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -243,6 +243,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
>  		if (ret >= 0)
>  			memset(out + ret, 0, rq->outputsize - ret);
>  		ret = -EIO;
> +	} else {
> +		ret = 0;
>  	}
>  
>  	if (maptype == 0) {
> @@ -269,33 +271,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
>  	},
>  };
>  
> -static void copy_from_pcpubuf(struct page **out, const char *dst,
> -			      unsigned short pageofs_out,
> -			      unsigned int outputsize)
> -{
> -	const char *end = dst + outputsize;
> -	const unsigned int righthalf = PAGE_SIZE - pageofs_out;
> -	const char *cur = dst - pageofs_out;
> -
> -	while (cur < end) {
> -		struct page *const page = *out++;
> -
> -		if (page) {
> -			char *buf = kmap_atomic(page);
> -
> -			if (cur >= dst) {
> -				memcpy(buf, cur, min_t(uint, PAGE_SIZE,
> -						       end - cur));
> -			} else {
> -				memcpy(buf + pageofs_out, cur + pageofs_out,
> -				       min_t(uint, righthalf, end - cur));
> -			}
> -			kunmap_atomic(buf);
> -		}
> -		cur += PAGE_SIZE;
> -	}
> -}
> -
>  static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
>  				      struct list_head *pagepool)
>  {
> @@ -306,34 +281,12 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
>  	void *dst;
>  	int ret;
>  
> -	/* two optimized fast paths only for non bigpcluster cases yet */
> -	if (rq->inputsize <= PAGE_SIZE) {
> -		if (nrpages_out == 1 && !rq->inplace_io) {
> -			DBG_BUGON(!*rq->out);
> -			dst = kmap_atomic(*rq->out);
> -			dst_maptype = 0;
> -			goto dstmap_out;
> -		}
> -
> -		/*
> -		 * For the case of small output size (especially much less
> -		 * than PAGE_SIZE), memcpy the decompressed data rather than
> -		 * compressed data is preferred.
> -		 */
> -		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
> -			dst = erofs_get_pcpubuf(1);
> -			if (IS_ERR(dst))
> -				return PTR_ERR(dst);
> -
> -			rq->inplace_io = false;
> -			ret = alg->decompress(rq, dst);
> -			if (!ret)
> -				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
> -						  rq->outputsize);
> -
> -			erofs_put_pcpubuf(dst);
> -			return ret;
> -		}
> +	/* one optimized fast paths only for non bigpcluster cases yet */
> +	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
> +		DBG_BUGON(!*rq->out);
> +		dst = kmap_atomic(*rq->out);
> +		dst_maptype = 0;
> +		goto dstmap_out;
>  	}
>  
>  	/* general decoding path which can be used for all cases */
> -- 
> 1.9.1
