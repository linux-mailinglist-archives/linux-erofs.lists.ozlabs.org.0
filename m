Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFB3D33DF
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 07:02:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWHJ31tqdz302j
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 15:02:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWHHv36QBz2yWJ
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jul 2021 15:02:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UggGE66_1627016535; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UggGE66_1627016535) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 23 Jul 2021 13:02:16 +0800
Date: Fri, 23 Jul 2021 13:02:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: no compression case for tail-end block in
 vle_write_indexes()
Message-ID: <YPpNVoTg8xqRZOan@B-P7TQMD6M-0146.local>
References: <20210723034945.1337-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210723034945.1337-1-zbestahu@gmail.com>
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
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Fri, Jul 23, 2021 at 11:49:45AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that count value will be always greater than EROFS_BLKSIZ when
> calling erofs_compress_destsize() in vle_compress_one(). So, the d1
> always >= 1 for compressed block in vle_write_indexes(). That is to
> say tail-end block can't be compressed.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

I once thought tail end block can be compressed with < EROFS_BLKSIZ as
well (as long as it has some benefit) and also tail-packing inline
like uncompressed cases together after compress extents, so that when we
reading the last compress extent meta block, the tail-packing compressed
data can be loaded together.

Currently, I think we could do that, but could you add some DBG_BUGON
like DBG_BUGON(!raw) right above
"type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;" and a TODO comment to mention
tail-packing inline compressed cases is under TODO list? That would be
much better.

Thanks,
Gao Xiang

> ---
>  lib/compress.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index af0c720..93fc543 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -73,10 +73,9 @@ static void vle_write_indexes(struct z_erofs_vle_compress_ctx *ctx,
>  
>  	di.di_clusterofs = cpu_to_le16(ctx->clusterofs);
>  
> -	/* whether the tail-end (un)compressed block or not */
> +	/* whether the tail-end uncompressed block or not */
>  	if (!d1) {
> -		type = raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
> -			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
> +		type = Z_EROFS_VLE_CLUSTER_TYPE_PLAIN;
>  		advise = cpu_to_le16(type << Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT);
>  
>  		di.di_advise = advise;
> -- 
> 1.9.1
