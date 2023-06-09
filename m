Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF1729588
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 11:39:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcwyJ469dz3f5F
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 19:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcwy85cCYz3f05
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 19:38:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vkhc1h9_1686303529;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vkhc1h9_1686303529)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 17:38:50 +0800
Message-ID: <2a8a3417-b72d-c8aa-ed3c-dad50d99be43@linux.alibaba.com>
Date: Fri, 9 Jun 2023 17:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] erofs-utils: lib: refactor erofs compressors init
To: Guo Xuenan <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230609085041.14987-1-guoxuenan@huawei.com>
 <20230609085041.14987-2-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230609085041.14987-2-guoxuenan@huawei.com>
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



On 2023/6/9 16:50, Guo Xuenan via Linux-erofs wrote:
> refactor compressor code using constructor.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>   lib/compressor.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>   lib/compressor.h         | 15 ++++++++++++
>   lib/compressor_liblzma.c |  5 ++++
>   lib/compressor_lz4.c     |  5 ++++
>   lib/compressor_lz4hc.c   |  5 ++++
>   5 files changed, 79 insertions(+)
> 
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 52eb761..0fa7105 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -22,6 +22,40 @@ static const struct erofs_compressor *compressors[] = {
>   #endif
>   };
>   
> +/* compressing configuration specified by users */
> +static struct erofs_supported_algothrim {
> +	int algtype;
> +	const char *name;
> +} erofs_supported_algothrims[] = {
> +	{ Z_EROFS_COMPRESSION_LZ4, "lz4"},
> +	{ Z_EROFS_COMPRESSION_LZ4, "lz4hc"},
> +	{ Z_EROFS_COMPRESSION_LZMA, "lzma"},
> +};
> +
> +static struct erofs_compressors_cfg erofs_ccfg;
> +
> +int erofs_compressor_num(void)
> +{
> +	return erofs_ccfg.erofs_ccfg_num;



> +}
> +
> +void erofs_compressor_register(const char *name, const struct erofs_compressor *alg)
> +{
> +	int i;
> +
> +	for (i = 0; i < erofs_compressor_num(); i++) {
> +		if (!strcmp(erofs_ccfg.compressors[i].name, name)) {
> +			erofs_ccfg.compressors[i].handle.alg = alg;

should we return error?  and also, why we need dynamicly
register algorithms? liberofs expects to have given
algorithms all the time...

> +			return;
> +		}
> +	}
> +
> +	erofs_ccfg.compressors[i].name = name;
> +	erofs_ccfg.compressors[i].handle.alg = alg;
> +	erofs_ccfg.compressors[i].algorithmtype = erofs_supported_algothrims[i].algtype;
> +	erofs_ccfg.erofs_ccfg_num = ++i;
> +}
> +
>   int erofs_compress_destsize(const struct erofs_compress *c,
>   			    const void *src, unsigned int *srcsize,
>   			    void *dst, unsigned int dstsize, bool inblocks)
> @@ -106,3 +140,18 @@ int erofs_compressor_exit(struct erofs_compress *c)
>   		return c->alg->exit(c);
>   	return 0;
>   }
> +
> +void __attribute__((constructor(101))) __erofs_compressor_init(void)


Honestly I don't like __attribute__((constructor)) and
__attribute__((destructor)) which could causes unexpected behaviors and
not good at compatiability.

Thanks,
Gao Xiang
