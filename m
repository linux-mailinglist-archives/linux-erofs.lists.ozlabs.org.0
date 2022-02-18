Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1054BB2CE
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 08:02:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K0N1q4Nszz3cPg
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Feb 2022 18:02:55 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K0N1k21r4z3bWj
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Feb 2022 18:02:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V4oKdcg_1645167758; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V4oKdcg_1645167758) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 18 Feb 2022 15:02:40 +0800
Date: Fri, 18 Feb 2022 15:02:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: fix memory leak when load compress hints file
Message-ID: <Yg9Ejqjt+y7HPaOv@B-P7TQMD6M-0146.local>
References: <20220218031137.18716-1-huangjianan@oppo.com>
 <20220218031137.18716-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218031137.18716-2-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Feb 18, 2022 at 11:11:36AM +0800, Huang Jianan via Linux-erofs wrote:
> Execute fclose before return error.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

It's actually a file descriptor leakage? 

Thanks,
Gao Xiang

> ---
>  lib/compress_hints.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/compress_hints.c b/lib/compress_hints.c
> index c3f3d48..c52e2d3 100644
> --- a/lib/compress_hints.c
> +++ b/lib/compress_hints.c
> @@ -88,6 +88,7 @@ int erofs_load_compress_hints(void)
>  	char buf[PATH_MAX + 100];
>  	FILE *f;
>  	unsigned int line, max_pclustersize = 0;
> +	int ret = 0;
>  
>  	if (!cfg.c_compress_hints_file)
>  		return 0;
> @@ -105,7 +106,8 @@ int erofs_load_compress_hints(void)
>  		if (!pattern || *pattern == '\0') {
>  			erofs_err("cannot find a match pattern at line %u",
>  				  line);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;
>  		}
>  		if (pclustersize % EROFS_BLKSIZ) {
>  			erofs_warn("invalid physical clustersize %u, "
> @@ -119,10 +121,12 @@ int erofs_load_compress_hints(void)
>  		if (pclustersize > max_pclustersize)
>  			max_pclustersize = pclustersize;
>  	}
> -	fclose(f);
> +
>  	if (cfg.c_pclusterblks_max * EROFS_BLKSIZ < max_pclustersize) {
>  		cfg.c_pclusterblks_max = max_pclustersize / EROFS_BLKSIZ;
>  		erofs_warn("update max pclusterblks to %u", cfg.c_pclusterblks_max);
>  	}
> -	return 0;
> +out:
> +	fclose(f);
> +	return ret;
>  }
> -- 
> 2.25.1
