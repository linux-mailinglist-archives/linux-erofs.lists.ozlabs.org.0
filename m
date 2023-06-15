Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D863C7315AA
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:44:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qhf7C524Lz3bPJ
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:44:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qhf763SSVz30PD
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:44:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlANDvb_1686825867;
Received: from 30.221.131.153(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VlANDvb_1686825867)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 18:44:28 +0800
Message-ID: <e03b6dd2-91dd-b457-a95b-b7bb22905e46@linux.alibaba.com>
Date: Thu, 15 Jun 2023 18:44:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] erofs-utils: lib: refactor erofs compressors init
To: Guo Xuenan <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-2-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230615101727.946446-2-guoxuenan@huawei.com>
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/15 18:17, Guo Xuenan via Linux-erofs wrote:
> using struct erofs_compressors_cfg for erofs compressor
> global configuration.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>   lib/compressor.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>   lib/compressor.h | 14 ++++++++++
>   2 files changed, 82 insertions(+)
> 
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 52eb761..88a2fb0 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -22,6 +22,74 @@ static const struct erofs_compressor *compressors[] = {
>   #endif
>   };
>   
> +/* for compressors type configuration */

This comment might be unnecessary.

> +static struct erofs_supported_algothrim {

				^ algorithm




> +	int algtype;
> +	const char *name;
> +} erofs_supported_algothrims[] = {
> +	{ Z_EROFS_COMPRESSION_LZ4, "lz4"},
> +	{ Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
> +	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
> +};
> +
> +/* global compressors configuration */


Let's avoid this comment as well.


> +static struct erofs_compressors_cfg erofs_ccfg;
> +
> +static void erofs_init_compressor(struct compressor *compressor,
> +	const struct erofs_compressor *alg)
> +{
> +
> +	compressor->handle.alg = alg;
> +
> +	/* should be written in "minimum compression ratio * 100" */
> +	compressor->handle.compress_threshold = 100;
> +
> +	/* optimize for 4k size page */
> +	compressor->handle.destsize_alignsize = erofs_blksiz();
> +	compressor->handle.destsize_redzone_begin = erofs_blksiz() - 16;
> +	compressor->handle.destsize_redzone_end = EROFS_CONFIG_COMPR_DEF_BOUNDARY;
> +
> +	if (alg && alg->init)
> +		alg->init(&compressor->handle);
> +}
> +
> +static void erofs_compressor_register(const char *name, const struct erofs_compressor *alg)
> +{
> +	int i;
> +
> +	for (i = 0; i < erofs_ccfg.erofs_ccfg_num; i++) {
> +		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
> +			erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
> +			return;
> +		}
> +	}
> +
> +	erofs_ccfg.compressors[i].name = name;
> +	erofs_ccfg.compressors[i].algorithmtype = erofs_supported_algothrims[i].algtype;
> +	erofs_init_compressor(&erofs_ccfg.compressors[i], alg);
> +	erofs_ccfg.erofs_ccfg_num = ++i;
> +}
> +
> +void erofs_register_compressors(void)
> +{
> +	int i;
> +
> +	erofs_ccfg.erofs_ccfg_num = 0;
> +	for (i = 0; i < ARRAY_SIZE(erofs_supported_algothrims); i++) {
> +		erofs_compressor_register(erofs_supported_algothrims[i].name, NULL);
> +	}
> +
> +#if LZ4_ENABLED
> +	erofs_compressor_register("lz4", &erofs_compressor_lz4);
> +#if LZ4HC_ENABLED
> +	erofs_compressor_register("lz4hc", &erofs_compressor_lz4hc);
> +#endif
> +#endif
> +#if HAVE_LIBLZMA
> +	erofs_compressor_register("lzma", &erofs_compressor_lzma);
> +#endif
> +}
> +
>   int erofs_compress_destsize(const struct erofs_compress *c,
>   			    const void *src, unsigned int *srcsize,
>   			    void *dst, unsigned int dstsize, bool inblocks)
> diff --git a/lib/compressor.h b/lib/compressor.h
> index cf063f1..1e760b6 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -8,6 +8,7 @@
>   #define __EROFS_LIB_COMPRESSOR_H
>   
>   #include "erofs/defs.h"
> +#include "erofs/config.h"
>   
>   struct erofs_compress;
>   
> @@ -40,6 +41,18 @@ struct erofs_compress {
>   	void *private_data;
>   };
>   
> +struct compressor {
> +	const char *name;
> +	struct erofs_compress handle;
> +	unsigned int algorithmtype;
> +	bool enable;

could we just use a struct erofs_supported_algothrim * to replace
name and algorithmtype?

Also, please use `struct erofs_compressor` here.

Thanks,
Gao Xiang
