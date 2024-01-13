Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3D82CDFC
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Jan 2024 18:39:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ijuQJxhh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TC5J46grNz3bsT
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Jan 2024 04:39:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ijuQJxhh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TC5Hx6grTz307V
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jan 2024 04:39:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 77512CE12EF;
	Sat, 13 Jan 2024 17:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A67C433C7;
	Sat, 13 Jan 2024 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705167556;
	bh=Uxapz8swDMZzHGHmXwrlwTcBuCiFCwc8C3pREKlfodw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijuQJxhhWNGxr2vMx274d19SBTVskJvtPE7ln8KjOJYJsk7Rw5KkqeDaniSrDvhs9
	 sdx7yfqtaHZ3CI8pc+jC+pYlfubn8vJbNdtzfSJctokQEGJLqHHHFx9xFQlVrFMB5b
	 vvB5IDc/GBO/ngrU/hMlliRm2dv2Gjm2/1iKYOlXty9lXJzciuMLdw13zJgw9qD5ZQ
	 p3JRC96mkVfhaq7LKRnn/2v61Gy3n8NJMiOCAKAO1xgp91C+TiTjlXU0l3TdFhFgqd
	 KE5tDGxFRpM3geHpfBYsj09CbLgX/Ux5o4Yw2AgdEmwz3Wr5cHoWDiJ21Ibr20aWSC
	 XKdk3b3dTwRfA==
Date: Sun, 14 Jan 2024 01:39:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Subject: Re: [PATCH 1/3] erofs-utils: mkfs: merge erofs_compressor_setlevel()
 into erofs_compressor_init()
Message-ID: <ZaLKwAFbXtCOHcGA@debian>
Mail-Followup-To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>,
	linux-erofs@lists.ozlabs.org
References: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yifan,

On Sun, Jan 07, 2024 at 02:10:40AM +0800, Yifan Zhao wrote:
> Currently erofs_compressor_setlevel() is only called once just after
> erofs_compressor_init() while initializing compressors. Let's just hide
> this interface and set the compression level in erofs_compressor_init().
> 
> BTW, if the user gives a compression level to an algorithm which doesn't
> support it, let's report a warning rather than early aborting. Besides,

Really, we should error out invalid standard compression levels
instead of just ignoring.

Thanks,
Gao Xiang

> we do not need to assign the {default,best}_level for such an algorithm
> in erofs_compressor struct.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>  lib/compress.c       |  6 +-----
>  lib/compressor.c     | 28 ++++++++++++++--------------
>  lib/compressor.h     |  5 ++---
>  lib/compressor_lz4.c |  2 --
>  4 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 8f61f92..216aeb4 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1199,11 +1199,7 @@ int z_erofs_compress_init(struct erofs_sb_info *sbi, struct erofs_buffer_head *s
>  	for (i = 0; cfg.c_compr_alg[i]; ++i) {
>  		struct erofs_compress *c = &erofs_ccfg[i].handle;
>  
> -		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i]);
> -		if (ret)
> -			return ret;
> -
> -		ret = erofs_compressor_setlevel(c, cfg.c_compr_level[i]);
> +		ret = erofs_compressor_init(sbi, c, cfg.c_compr_alg[i], cfg.c_compr_level[i]);
>  		if (ret)
>  			return ret;
>  
> diff --git a/lib/compressor.c b/lib/compressor.c
> index a71436a..7ec51c2 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -77,20 +77,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
>  	return c->alg->c->compress_destsize(c, src, srcsize, dst, dstsize);
>  }
>  
> -int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level)
> -{
> -	DBG_BUGON(!c->alg);
> -	if (c->alg->c->setlevel)
> -		return c->alg->c->setlevel(c, compression_level);
> -
> -	if (compression_level >= 0)
> -		return -EINVAL;
> -	c->compression_level = 0;
> -	return 0;
> -}
> -
> -int erofs_compressor_init(struct erofs_sb_info *sbi,
> -			  struct erofs_compress *c, char *alg_name)
> +int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
> +			  char *alg_name, int compression_level)
>  {
>  	int ret, i;
>  
> @@ -113,6 +101,18 @@ int erofs_compressor_init(struct erofs_sb_info *sbi,
>  			continue;
>  
>  		ret = erofs_algs[i].c->init(c);
> +		if (ret)
> +			return ret;
> +
> +		if (erofs_algs[i].c->setlevel) {
> +			ret = erofs_algs[i].c->setlevel(c, compression_level);
> +		} else {
> +			if (compression_level >= 0)
> +				erofs_warn(
> +					"compression level %d is ignored for %s",
> +					compression_level, alg_name);
> +			c->compression_level = 0;
> +		}
>  		if (!ret) {
>  			c->alg = &erofs_algs[i];
>  			return 0;
> diff --git a/lib/compressor.h b/lib/compressor.h
> index 6875cf1..ec5485d 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -55,9 +55,8 @@ int erofs_compress_destsize(const struct erofs_compress *c,
>  			    const void *src, unsigned int *srcsize,
>  			    void *dst, unsigned int dstsize);
>  
> -int erofs_compressor_setlevel(struct erofs_compress *c, int compression_level);
> -int erofs_compressor_init(struct erofs_sb_info *sbi,
> -		struct erofs_compress *c, char *alg_name);
> +int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
> +			  char *alg_name, int compression_level);
>  int erofs_compressor_exit(struct erofs_compress *c);
>  
>  #endif
> diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
> index 6677693..f4e72c3 100644
> --- a/lib/compressor_lz4.c
> +++ b/lib/compressor_lz4.c
> @@ -37,8 +37,6 @@ static int compressor_lz4_init(struct erofs_compress *c)
>  }
>  
>  const struct erofs_compressor erofs_compressor_lz4 = {
> -	.default_level = 0,
> -	.best_level = 0,
>  	.init = compressor_lz4_init,
>  	.exit = compressor_lz4_exit,
>  	.compress_destsize = lz4_compress_destsize,
> -- 
> 2.43.0
> 
