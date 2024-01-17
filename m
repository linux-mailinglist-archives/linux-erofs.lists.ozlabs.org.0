Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F2830406
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jan 2024 11:59:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TFND64v07z3bl7
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jan 2024 21:59:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TFND40X54z2xPd
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jan 2024 21:58:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W-p9MaD_1705489131;
Received: from 30.97.48.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-p9MaD_1705489131)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 18:58:53 +0800
Message-ID: <7f7c1afd-4e1c-4c21-9def-05498f64d5b4@linux.alibaba.com>
Date: Wed, 17 Jan 2024 18:58:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] erofs-utils: mkfs: reorganize logic in
 erofs_compressor_init()
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20240106181040.228922-1-zhaoyifan@sjtu.edu.cn>
 <20240106181137.229118-1-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240106181137.229118-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yifan,

Note that I don't have more useful comments of this one.
Let's see how PATCHSET v2 works first.

Thanks,
Gao Xiang

On 2024/1/7 02:11, Yifan Zhao wrote:
> Currently, the initialization of compressors is weird: init() is called
> first, followed by setlevel(), then setdictsize(). The initialization
> process occurs in the last called setdictsize() for lzma, deflate, and
> libdeflate.
> 
> This patch reorders the three functions, with init() now being invoked
> last, allowing it to use the compression level and dictsize already set
> so that the behavior of the functions matches their names.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>   lib/compressor.c            |  8 ++++----
>   lib/compressor_deflate.c    | 32 ++++++++++++++++----------------
>   lib/compressor_libdeflate.c | 14 +++++++++-----
>   lib/compressor_liblzma.c    | 34 +++++++++++++++++++---------------
>   lib/compressor_lz4hc.c      |  5 ++++-
>   5 files changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 5061417..27b4077 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -100,10 +100,6 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
>   		if (!erofs_algs[i].c)
>   			continue;
>   
> -		ret = erofs_algs[i].c->init(c);
> -		if (ret)
> -			return ret;
> -
>   		if (erofs_algs[i].c->setlevel) {
>   			ret = erofs_algs[i].c->setlevel(c, compression_level);
>   			if (ret)
> @@ -128,6 +124,10 @@ int erofs_compressor_init(struct erofs_sb_info *sbi, struct erofs_compress *c,
>   			c->dict_size = 0;
>   		}
>   
> +		ret = erofs_algs[i].c->init(c);
> +		if (ret)
> +			return ret;
> +
>   		if (!ret) {
>   			c->alg = &erofs_algs[i];
>   			return 0;
> diff --git a/lib/compressor_deflate.c b/lib/compressor_deflate.c
> index c95e53e..d9f8a91 100644
> --- a/lib/compressor_deflate.c
> +++ b/lib/compressor_deflate.c
> @@ -36,7 +36,14 @@ static int compressor_deflate_exit(struct erofs_compress *c)
>   
>   static int compressor_deflate_init(struct erofs_compress *c)
>   {
> -	c->private_data = NULL;
> +	if (c->private_data) {
> +		kite_deflate_end(c->private_data);
> +		c->private_data = NULL;
> +	}
> +
> +	c->private_data = kite_deflate_init(c->compression_level, c->dict_size);
> +	if (IS_ERR_VALUE(c->private_data))
> +		return PTR_ERR(c->private_data);
>   
>   	erofs_warn("EXPERIMENTAL DEFLATE algorithm in use. Use at your own risk!");
>   	erofs_warn("*Carefully* check filesystem data correctness to avoid corruption!");
> @@ -50,6 +57,11 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
>   	if (compression_level < 0)
>   		compression_level = erofs_compressor_deflate.default_level;
>   
> +	if (compression_level > erofs_compressor_deflate.best_level) {
> +		erofs_err("invalid compression level %d", compression_level);
> +		return -EINVAL;
> +	}
> +
>   	c->compression_level = compression_level;
>   	return 0;
>   }
> @@ -57,26 +69,14 @@ static int erofs_compressor_deflate_setlevel(struct erofs_compress *c,
>   static int erofs_compressor_deflate_setdictsize(struct erofs_compress *c,
>   						u32 dict_size)
>   {
> -	void *s;
> -
> -	if (c->private_data) {
> -		kite_deflate_end(c->private_data);
> -		c->private_data = NULL;
> -	}
> +	if (dict_size == 0)
> +		dict_size = erofs_compressor_deflate.default_dictsize;
>   
>   	if (dict_size > erofs_compressor_deflate.max_dictsize) {
> -		erofs_err("dict size %u is too large", dict_size);
> +		erofs_err("invalid dict size %u", dict_size);
>   		return -EINVAL;
>   	}
>   
> -	if (dict_size == 0)
> -		dict_size = erofs_compressor_deflate.default_dictsize;
> -
> -	s = kite_deflate_init(c->compression_level, dict_size);
> -	if (IS_ERR(s))
> -		return PTR_ERR(s);
> -
> -	c->private_data = s;
>   	c->dict_size = dict_size;
>   	return 0;
>   }
> diff --git a/lib/compressor_libdeflate.c b/lib/compressor_libdeflate.c
> index c0b019a..ad5eeec 100644
> --- a/lib/compressor_libdeflate.c
> +++ b/lib/compressor_libdeflate.c
> @@ -82,7 +82,10 @@ static int compressor_libdeflate_exit(struct erofs_compress *c)
>   
>   static int compressor_libdeflate_init(struct erofs_compress *c)
>   {
> -	c->private_data = NULL;
> +	libdeflate_free_compressor(c->private_data);
> +	c->private_data = libdeflate_alloc_compressor(c->compression_level);
> +	if (!c->private_data)
> +		return -ENOMEM;
>   
>   	erofs_warn("EXPERIMENTAL libdeflate compressor in use. Use at your own risk!");
>   	return 0;
> @@ -94,10 +97,11 @@ static int erofs_compressor_libdeflate_setlevel(struct erofs_compress *c,
>   	if (compression_level < 0)
>   		compression_level = erofs_compressor_deflate.default_level;
>   
> -	libdeflate_free_compressor(c->private_data);
> -	c->private_data = libdeflate_alloc_compressor(compression_level);
> -	if (!c->private_data)
> -		return -ENOMEM;
> +	if (compression_level > erofs_compressor_deflate.best_level) {
> +		erofs_err("invalid compression level %d", compression_level);
> +		return -EINVAL;
> +	}
> +
>   	c->compression_level = compression_level;
>   	return 0;
>   }
> diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
> index 5c7f830..0203a5c 100644
> --- a/lib/compressor_liblzma.c
> +++ b/lib/compressor_liblzma.c
> @@ -55,18 +55,13 @@ static int erofs_compressor_liblzma_exit(struct erofs_compress *c)
>   static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
>   					     int compression_level)
>   {
> -	struct erofs_liblzma_context *ctx = c->private_data;
> -	u32 preset;
> -
>   	if (compression_level < 0)
> -		preset = LZMA_PRESET_DEFAULT;
> -	else if (compression_level >= 100)
> -		preset = (compression_level - 100) | LZMA_PRESET_EXTREME;
> -	else
> -		preset = compression_level;
> +		compression_level = erofs_compressor_lzma.default_level;
>   
> -	if (lzma_lzma_preset(&ctx->opt, preset))
> +	if (compression_level > erofs_compressor_lzma.best_level) {
> +		erofs_err("invalid compression level %d", compression_level);
>   		return -EINVAL;
> +	}
>   
>   	c->compression_level = compression_level;
>   	return 0;
> @@ -75,17 +70,14 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
>   static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
>   						u32 dict_size)
>   {
> -	struct erofs_liblzma_context *ctx = c->private_data;
> +	if (dict_size == 0)
> +		dict_size = erofs_compressor_lzma.default_dictsize;
>   
>   	if (dict_size > erofs_compressor_lzma.max_dictsize) {
> -		erofs_err("dict size %u is too large", dict_size);
> +		erofs_err("invalid dict size %u", dict_size);
>   		return -EINVAL;
>   	}
>   
> -	if (dict_size == 0)
> -		dict_size = erofs_compressor_lzma.default_dictsize;
> -
> -	ctx->opt.dict_size = dict_size;
>   	c->dict_size = dict_size;
>   	return 0;
>   }
> @@ -93,11 +85,23 @@ static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
>   static int erofs_compressor_liblzma_init(struct erofs_compress *c)
>   {
>   	struct erofs_liblzma_context *ctx;
> +	u32 preset;
>   
>   	ctx = malloc(sizeof(*ctx));
>   	if (!ctx)
>   		return -ENOMEM;
> +
>   	ctx->strm = (lzma_stream)LZMA_STREAM_INIT;
> +	if (c->compression_level < 0)
> +		preset = LZMA_PRESET_DEFAULT;
> +	else if (c->compression_level >= 100)
> +		preset = (c->compression_level - 100) | LZMA_PRESET_EXTREME;
> +	else
> +		preset = c->compression_level;
> +	if (lzma_lzma_preset(&ctx->opt, preset))
> +		return -EINVAL;
> +	ctx->opt.dict_size = c->dict_size;
> +
>   	c->private_data = ctx;
>   	erofs_warn("EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!");
>   	erofs_warn("Note that it may take more time since the compressor is still single-threaded for now.");
> diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
> index b410e15..6fc8847 100644
> --- a/lib/compressor_lz4hc.c
> +++ b/lib/compressor_lz4hc.c
> @@ -7,6 +7,7 @@
>   #define LZ4_HC_STATIC_LINKING_ONLY (1)
>   #include <lz4hc.h>
>   #include "erofs/internal.h"
> +#include "erofs/print.h"
>   #include "compressor.h"
>   
>   #ifndef LZ4_DISTANCE_MAX	/* history window size */
> @@ -49,8 +50,10 @@ static int compressor_lz4hc_init(struct erofs_compress *c)
>   static int compressor_lz4hc_setlevel(struct erofs_compress *c,
>   				     int compression_level)
>   {
> -	if (compression_level > LZ4HC_CLEVEL_MAX)
> +	if (compression_level > erofs_compressor_lz4hc.best_level) {
> +		erofs_err("invalid compression level %d", compression_level);
>   		return -EINVAL;
> +	}
>   
>   	c->compression_level = compression_level < 0 ?
>   		LZ4HC_CLEVEL_DEFAULT : compression_level;
