Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B70A42D239
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 08:17:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVK1m6MY3z2yg4
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 17:17:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVK1c4DHkz2yLm
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 17:17:07 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UrleTSs_1634192208; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UrleTSs_1634192208) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 14 Oct 2021 14:16:50 +0800
Date: Thu, 14 Oct 2021 14:16:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: remove the fast path of per-CPU buffer
 decompression
Message-ID: <YWfLUEQWSY3xpFJF@B-P7TQMD6M-0146.local>
References: <20211014055756.1549-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014055756.1549-1-zbestahu@gmail.com>
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

On Thu, Oct 14, 2021 at 01:57:56PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> As Xiang mentioned, such path has no real impact to our current
> decompression strategy, remove it directly. Also, update the return
> value of z_erofs_lz4_decompress() to 0 if success to keep consistent
> with LZMA which will return 0 as well for that case.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/erofs/decompressor.c | 64 +++++++------------------------------------------
>  1 file changed, 8 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index a5bc4b1..9905551 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -254,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
>  		DBG_BUGON(1);
>  		return -EFAULT;
>  	}
> -	return ret;
> +	return ret > 0 ? 0 : ret;

How about just updating the else branch of "if (ret != rq->outputsize)"?

>  }
>  
>  static struct z_erofs_decompressor decompressors[] = {
> @@ -268,33 +268,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
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
> @@ -305,34 +278,13 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
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
> +	/* one optimized fast path only for non bigpcluster cases yet */
> +	if (rq->inputsize <= PAGE_SIZE &&
> +	    nrpages_out == 1 && !rq->inplace_io) {

How about rearrange these into one line? (it seems just 80 char).

Otherwise looks good to me.

Thanks,
Gao Xiang

> +		DBG_BUGON(!*rq->out);
> +		dst = kmap_atomic(*rq->out);
> +		dst_maptype = 0;
> +		goto dstmap_out;
>  	}
>  
>  	/* general decoding path which can be used for all cases */
> -- 
> 1.9.1
