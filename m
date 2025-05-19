Return-Path: <linux-erofs+bounces-348-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 98662ABC07A
	for <lists+linux-erofs@lfdr.de>; Mon, 19 May 2025 16:23:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1KfT3C6Sz2yjV;
	Tue, 20 May 2025 00:23:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747664593;
	cv=none; b=jFVtreem162fxRqaguiL5gemkVHW++Gna83qSTNTvUYOlxPK8C9GFNhoZ2oy93GsUae0yHPAfr505Z2+SSaBjH63OUFq+VWZOz4o+wF1X4ICAi1r9K+f9x5TmdIEhUm8MdVGOmK3jB8+803BTyVfqB1JfUR1L0vTMx+PJppXL+OP5gaNoxKulhQNa8nzN5GSSmuyJzC2l3NxA1AkNVdnuuewrj9hvxo+VlTw0xiaYFVWt3JSLgg+XQYaxIBkS5HfpiDKmzeFzZ5/S74sMlyQKicf/IBiHP54G39UcKzn7eHk9d8X1ShnNd1TMapR4n3VnvJxQRsC7fME9bjRVh866A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747664593; c=relaxed/relaxed;
	bh=//oUDoNetmAg9AyeQefN3OQ8B80sfXo6fUteYtrEMEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxALR1m/eXzNTn4XwNhX6IiD6fJvZxTjHwJC5cxxWtWvdPcmm9oPFHZTDboSPNiV1whK3+G3h2uCox5iTrHYpjtWgamT6pJgoznbo95f+6e2chYK29p9O0L+89SZ/71gnM/P88V+Mui0gG/x7JQDshgs6eyLHqjdvPlUQlB7IL4dDRmN3z8PuVhYI602Rq2hR1jah1G095ibP3TFQUUIF9O1U4Z1u5t5O87BppVHP2mEf6mSrQovnl9C0yXCXYBUCmEnUCR+U0lJpv+bWG68imjGfh+SIKoI99aMsc6WSyhbFlPdD2uqRTfaTxricd4MusQ7Adrf8TOfk3ze+KBYBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1KfR5dXHz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 May 2025 00:23:09 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4b1Kbm4PWDz1R7pT
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 22:20:52 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 056B9140154
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 May 2025 22:23:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 May 2025 22:23:03 +0800
Message-ID: <d6638387-1139-4dfb-afe9-bdd7bfe49db0@huawei.com>
Date: Mon, 19 May 2025 22:23:03 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: support deflate decompress by using Intel QAT
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250516082634.3801-1-liubo03@inspur.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250516082634.3801-1-liubo03@inspur.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/16 16:26, Bo Liu wrote:
> This patch introdueces the use of the Intel QAT to decompress compressed
> data in the EROFS filesystem, aiming to improve the decompression speed
> of compressed datea.
> 
> We created a 285MiB compressed file and then used the following command to
> create EROFS images with different cluster size.
>       # mkfs.erofs -zdeflate,level=9 -C16384
> 
> fio command was used to test random read and small random read(~5%) and
> sequential read performance.
>       # fio -filename=testfile  -bs=4k -rw=read -name=job1
>       # fio -filename=testfile  -bs=4k -rw=randread -name=job1
>       # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1
> 
> Here are some performance numbers for reference:
> 
> Processors: Intel(R) Xeon(R) 6766E(144 core)
> Memory:     521 GiB
> 
> |-----------------------------------------------------------------------------|
> |           | Cluster size | sequential read | randread  | small randread(5%) |
> |-----------|--------------|-----------------|-----------|--------------------|
> | Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
> | Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
> | Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
> | Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
> | Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
> | deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
> | deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
> | deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
> | deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
> | deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@inspur.com/
> v2: https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@inspur.com/T/#t
> 
> Changes since v2:
>   - Add a new kernel config option CONFIG_EROFS_FS_ZIP_CRYPTO.
>   - Modify the sysfs interface to merge enable and disable into
>     a single entry point, and add a read function to view the current state.
>   - Optimize the relevant code,use the sg_alloc_table_from_pages_segment interface.
> 
>   fs/erofs/Kconfig                |  14 +++
>   fs/erofs/Makefile               |   1 +
>   fs/erofs/compress.h             |  14 +++
>   fs/erofs/decompressor_crypto.c  | 199 ++++++++++++++++++++++++++++++++
>   fs/erofs/decompressor_deflate.c |  16 ++-
>   fs/erofs/sysfs.c                |  36 ++++++
>   6 files changed, 279 insertions(+), 1 deletion(-)
>   create mode 100644 fs/erofs/decompressor_crypto.c
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 331e49cd1b8d..db49ae3c1922 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -144,6 +144,20 @@ config EROFS_FS_ZIP_ZSTD
>   
>   	  If unsure, say N.
>   
> +config EROFS_FS_ZIP_CRYPTO
> +	bool "EROFS hardware decompression support (crypto interface)"
> +	depends on EROFS_FS_ZIP
> +	help
> +	  Saying Y here includes support for reading EROFS file systems
> +	  containing crypto compressed data.  It gives better decompression
> +	  speed than the software-implemented compression, and it costs
> +	  lower CPU overhead.
> +
> +	  Crypto support is an experimental feature for now and so most
> +	  file systems will be readable without selecting this option.
> +
> +	  If unsure, say N.
> +
>   config EROFS_FS_ONDEMAND
>   	bool "EROFS fscache-based on-demand read support (deprecated)"
>   	depends on EROFS_FS
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 4331d53c7109..247b263eb667 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -7,5 +7,6 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
> +erofs-$(CONFIG_EROFS_FS_ZIP_CRYPTO) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 2704d7a592a5..356ae2473bd5 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -70,10 +70,24 @@ struct z_erofs_stream_dctx {
>   	bool bounced;			/* is the bounce buffer used now? */
>   };
>   
> +struct z_erofs_crypto_engine {
> +	char *crypto_name;
> +	bool enabled;
> +	struct crypto_acomp *erofs_tfm;
> +};
> +
> +extern struct z_erofs_crypto_engine z_erofs_crypto[Z_EROFS_COMPRESSION_MAX][2];
> +
>   int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
>   			       void **src, struct page **pgpl);
>   int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>   			 unsigned int padbufsize);
>   int __init z_erofs_init_decompressor(void);
>   void z_erofs_exit_decompressor(void);
> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +						struct crypto_acomp *erofs_tfm, struct page **pgpl);
> +struct crypto_acomp *z_erofs_crypto_get_engine(int type);
> +int z_erofs_crypto_enable_engine(const char *name);
> +void z_erofs_crypto_disable_engine(void);
> +int z_erofs_crypto_engine_format(char *buf);
>   #endif
> diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
> new file mode 100644
> index 000000000000..55f6a9e6dcf6
> --- /dev/null
> +++ b/fs/erofs/decompressor_crypto.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/scatterlist.h>
> +#include <crypto/acompress.h>
> +
> +#include "compress.h"
> +
> +static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *erofs_tfm)
> +{
> +	struct sg_table st_src, st_dst;
> +	struct acomp_req *req;
> +	struct crypto_wait wait;
> +	u8 *headpage;
> +	int ret;
> +
> +	headpage = kmap_local_page(*rq->in);
> +	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
> +				min_t(unsigned int, rq->inputsize,
> +							rq->sb->s_blocksize - rq->pageofs_in));
> +	kunmap_local(headpage);
> +	if (ret)
> +		return ret;
> +
> +	req = acomp_request_alloc(erofs_tfm);
> +	if (!req) {
> +		erofs_err(rq->sb, "failed to alloc decompress request");
> +		return -ENOMEM;
> +	}
> +
> +	ret = sg_alloc_table_from_pages_segment(&st_src,
> +					rq->in, rq->inpages, rq->pageofs_in,
> +					rq->inputsize, UINT_MAX, GFP_KERNEL);
> +	if (ret < 0)
> +		goto failed_src_alloc;
> +
> +	ret = sg_alloc_table_from_pages_segment(&st_dst,
> +					rq->out, rq->outpages, rq->pageofs_out,
> +					rq->outputsize, UINT_MAX, GFP_KERNEL);
> +	if (ret < 0)
> +		goto failed_dst_alloc;
> +
> +	acomp_request_set_params(req, st_src.sgl,
> +		st_dst.sgl, rq->inputsize, rq->outputsize);
> +
> +	crypto_init_wait(&wait);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				crypto_req_done, &wait);
> +
> +	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
> +	if (ret < 0) {
> +		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
> +					ret, rq->inputsize, rq->pageofs_in, rq->outputsize);
> +		ret = -EIO;
> +	} else
> +		ret = 0;
> +
> +	sg_free_table(&st_dst);
> +failed_dst_alloc:
> +	sg_free_table(&st_src);
> +failed_src_alloc:
> +	acomp_request_free(req);
> +	return ret;
> +}
> +
> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *erofs_tfm, struct page **pgpl)
> +{
> +	int i;
> +
> +	for (i = 0; i < rq->outpages; i++) {
> +		struct page *const page = rq->out[i];
> +		struct page *victim;
> +
> +		if (!page) {
> +			victim = __erofs_allocpage(pgpl, rq->gfp, true);
> +			if (!victim)
> +				return -ENOMEM;
> +			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> +			rq->out[i] = victim;
> +		}
> +	}
> +
> +	return z_erofs_crypto_decompress_mem(rq, erofs_tfm);
> +}
> +
> +struct crypto_acomp *z_erofs_crypto_get_engine(int type)
> +{
> +	int i = 0;
> +
> +	while (z_erofs_crypto[type][i].crypto_name) {
> +		if (z_erofs_crypto[type][i].enabled)
> +			return z_erofs_crypto[type][i].erofs_tfm;
> +		i++;
> +	}
> +	return NULL;
> +}
> +
> +static int z_erofs_crypto_get_compress_type(const char *name)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; i++) {
> +		j = 0;
> +		while (z_erofs_crypto[i][j].crypto_name) {
> +			if (!strcmp(name, z_erofs_crypto[i][j].crypto_name))
> +				return i;
> +
> +			j++;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +int z_erofs_crypto_enable_engine(const char *name)
> +{
> +	int i = 0, type;
> +
> +	type = z_erofs_crypto_get_compress_type(name);
> +	if (type < 0)
> +		return -EINVAL;
> +
> +	while (z_erofs_crypto[type][i].crypto_name) {
> +		if (!strcmp(z_erofs_crypto[type][i].crypto_name, name)) {
> +			if (z_erofs_crypto[type][i].enabled)
> +				break;
> +
> +			z_erofs_crypto[type][i].erofs_tfm =
> +				crypto_alloc_acomp(z_erofs_crypto[type][i].crypto_name, 0, 0);
> +			if (IS_ERR(z_erofs_crypto[type][i].erofs_tfm)) {
> +				z_erofs_crypto[type][i].erofs_tfm = NULL;
> +				return -ENXIO;
> +			}
> +			z_erofs_crypto[type][i].enabled = true;
> +		} else if (z_erofs_crypto[type][i].enabled) {
> +			if (z_erofs_crypto[type][i].erofs_tfm)
> +				crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
> +			z_erofs_crypto[type][i].enabled = false;
> +		}
> +		i++;
> +	}
> +	return 0;
> +}
> +
> +void z_erofs_crypto_disable_engine(void)
> +{
> +	int i = 0, type;
> +
> +	for (type = 0; type < Z_EROFS_COMPRESSION_MAX; type++) {
> +		i = 0;
> +		while (z_erofs_crypto[type][i].crypto_name) {
> +			if (z_erofs_crypto[type][i].enabled &&
> +					z_erofs_crypto[type][i].erofs_tfm) {
> +				crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
> +				z_erofs_crypto[type][i].erofs_tfm = NULL;
> +				z_erofs_crypto[type][i].enabled = false;
> +			}
> +			i++;
> +		}
> +	}
> +}
> +
> +int z_erofs_crypto_engine_format(char *buf)
> +{
> +	int type, i, len = 0;
> +
> +	for (type = 0; type < Z_EROFS_COMPRESSION_MAX; type++) {
> +		i = 0;
> +		while (z_erofs_crypto[type][i].crypto_name) {
> +			if (z_erofs_crypto[type][i].enabled)
> +				len += scnprintf(buf + len, PATH_MAX - len, "%s ",
> +							z_erofs_crypto[type][i].crypto_name);
> +			i++;
> +		}
> +	}
> +	return len;
> +}
> +
> +struct z_erofs_crypto_engine z_erofs_crypto[Z_EROFS_COMPRESSION_MAX][2] = {
> +	[Z_EROFS_COMPRESSION_LZ4] = {
> +		(struct z_erofs_crypto_engine) {NULL},
> +		(struct z_erofs_crypto_engine) {NULL},
> +	},
> +	[Z_EROFS_COMPRESSION_LZMA] = {
> +		(struct z_erofs_crypto_engine) {NULL},
> +		(struct z_erofs_crypto_engine) {NULL},
> +	},
> +	[Z_EROFS_COMPRESSION_DEFLATE] = {
> +		(struct z_erofs_crypto_engine) {
> +			.crypto_name = "qat_deflate",
> +			.enabled = false,
> +			.erofs_tfm = NULL,
> +		},
> +		(struct z_erofs_crypto_engine) {NULL},
> +	},
> +	[Z_EROFS_COMPRESSION_ZSTD] = {
> +		(struct z_erofs_crypto_engine) {NULL},
> +		(struct z_erofs_crypto_engine) {NULL},
> +	},
> +};
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index c6908a487054..bebbf1eccd3d 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -97,7 +97,7 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
>   	return -ENOMEM;
>   }
>   
> -static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> +static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   				      struct page **pgpl)
>   {
>   	struct super_block *sb = rq->sb;
> @@ -178,6 +178,20 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   	return err;
>   }
>   
> +static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> +				struct page **pgpl)
> +{
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	struct crypto_acomp *erofs_tfm = NULL;
> +
> +	erofs_tfm = z_erofs_crypto_get_engine(Z_EROFS_COMPRESSION_DEFLATE);
> +	if (erofs_tfm && !rq->partial_decoding)
> +		return z_erofs_crypto_decompress(rq, erofs_tfm, pgpl);
> +	else
> +#endif
> +		return __z_erofs_deflate_decompress(rq, pgpl);
> +}
> +
>   const struct z_erofs_decompressor z_erofs_deflate_decomp = {
>   	.config = z_erofs_load_deflate_config,
>   	.decompress = z_erofs_deflate_decompress,
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dad4e6c6c155..00123c4d3196 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -7,12 +7,14 @@
>   #include <linux/kobject.h>
>   
>   #include "internal.h"
> +#include "compress.h"
>   
>   enum {
>   	attr_feature,
>   	attr_drop_caches,
>   	attr_pointer_ui,
>   	attr_pointer_bool,
> +	attr_crypto,
>   };
>   
>   enum {
> @@ -60,6 +62,9 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
>   EROFS_ATTR_FUNC(drop_caches, 0200);
>   #endif
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +EROFS_ATTR_FUNC(crypto, 0644);
> +#endif
>   
>   static struct attribute *erofs_attrs[] = {
>   #ifdef CONFIG_EROFS_FS_ZIP
> @@ -95,6 +100,9 @@ static struct attribute *erofs_feat_attrs[] = {
>   	ATTR_LIST(fragments),
>   	ATTR_LIST(dedupe),
>   	ATTR_LIST(48bit),
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	ATTR_LIST(crypto),
> +#endif
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(erofs_feat);
> @@ -128,6 +136,10 @@ static ssize_t erofs_attr_show(struct kobject *kobj,
>   		if (!ptr)
>   			return 0;
>   		return sysfs_emit(buf, "%d\n", *(bool *)ptr);
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	case attr_crypto:
> +		return z_erofs_crypto_engine_format(buf);
> +#endif
>   	}
>   	return 0;
>   }
> @@ -141,6 +153,10 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
>   	unsigned long t;
>   	int ret;
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	char *crypto_name;
> +	size_t sz;
> +#endif
>   
>   	switch (a->attr_id) {
>   	case attr_pointer_ui:
> @@ -181,6 +197,26 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   		if (t & 1)
>   			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
>   		return len;
> +#endif
> +#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
> +	case attr_crypto:
> +		buf = skip_spaces(buf);
> +		sz = strlen(buf);
> +		crypto_name = kstrdup(buf, GFP_KERNEL);
> +		if (!crypto_name)
> +			return -ENOMEM;
> +
> +		/* ignore trailing newline */
> +		if (sz > 0 && crypto_name[sz - 1] == '\n')
> +			crypto_name[sz - 1] = 0x00;
> +
> +		if (strlen(crypto_name) > 0) {
> +			ret = z_erofs_crypto_enable_engine(crypto_name);
> +			if (ret < 0)
> +				return ret;
> +		} else
> +			z_erofs_crypto_disable_engine();
Need kfree crypto_name after using it.

Thanks,
Hongbo

> +		return len;
>   #endif
>   	}
>   	return 0;

