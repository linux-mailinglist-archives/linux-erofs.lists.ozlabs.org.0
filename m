Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF03D4800
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 15:58:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GX77Z190xz30Dh
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 23:58:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GX77V43Dlz302V
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 23:58:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UgoXJ5n_1627135062; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgoXJ5n_1627135062) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 24 Jul 2021 21:57:44 +0800
Date: Sat, 24 Jul 2021 21:57:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: no compression case for tail-end block
 in vle_write_indexes()
Message-ID: <YPwcVurTB8oFt1p0@B-P7TQMD6M-0146.local>
References: <20210723062739.1415-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210723062739.1415-1-zbestahu@gmail.com>
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
Cc: yuchao0@huawei.com, zbestahu@163.com, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 23, 2021 at 02:27:39PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that count value will be always greater than EROFS_BLKSIZ when
> calling erofs_compress_destsize() in vle_compress_one(). So, the d1
> always >= 1 for compressed block in vle_write_indexes(). That is to
> say tail-end block can't be compressed.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Thanks, looks good to me:
Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
> v2: add DBG_BUGON(!raw), a TODO comment.
> 
>  lib/compress.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index af0c720..40723a1 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -73,10 +73,11 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>  
>  	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
>  
> -	/* whether the tail-end (un)compressed block or not */
> +	/* whether the tail-end uncompressed block or not */
>  	if (!d1) {
> -		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> -			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
> +		/* TODO: tail-packing inline compressed data */
> +		DBG_BUGON(!raw);
> +		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
>  		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
>  
>  		di.di_advise = advise;
> -- 
> 1.9.1
