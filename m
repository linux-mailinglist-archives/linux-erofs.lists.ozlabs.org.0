Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 932683FF900
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 05:06:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H12kj3cdWz2yJT
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 13:06:37 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H12kc0NSbz2xXS
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 13:06:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0Un3cJFF_1630638367; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Un3cJFF_1630638367) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Sep 2021 11:06:08 +0800
Date: Fri, 3 Sep 2021 11:06:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: remove the pagepool parameter from
 z_erofs_shifted_transform()
Message-ID: <YTGRHuRsVeiGM8Nq@B-P7TQMD6M-0146.local>
References: <20210831103204.881-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831103204.881-1-zbestahu@gmail.com>
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
Cc: xiang@kernel.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Tue, Aug 31, 2021 at 06:32:04PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We don't use the pagepool for plain format, remove it.

In my LZMA patchset, I'll rearrange such interface to make LZMA
integration easier:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?h=erofs/lzma&id=3fab9044a4fe9358e95e16780831640caf3de10b

This cleanup patch does no harm to that one, yet I think it has little
real impact (especially applying the patch above)... So I'd like to
hear Chao's suggestion about this as well. I'm fine in either ways.

(p.s. we are in 5.15 merge window, I will set up a new dev branch after
 -rc1 is out.)

Thanks,
Gao Xiang

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/erofs/decompressor.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index a5bc4b1..8f50a36 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -360,8 +360,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
>  	return ret;
>  }
>  
> -static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
> -				     struct list_head *pagepool)
> +static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq)
>  {
>  	const unsigned int nrpages_out =
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> @@ -403,6 +402,6 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
>  		       struct list_head *pagepool)
>  {
>  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
> -		return z_erofs_shifted_transform(rq, pagepool);
> +		return z_erofs_shifted_transform(rq);
>  	return z_erofs_decompress_generic(rq, pagepool);
>  }
> -- 
> 1.9.1
