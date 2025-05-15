Return-Path: <linux-erofs+bounces-325-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C1AB7C1A
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 05:08:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZyZsg2gSkz2yvv;
	Thu, 15 May 2025 13:08:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.255
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747278503;
	cv=none; b=DjMhu4cMHXJTEFjyWGK1wG/dIgaxj8xIPEKEn1GMILmlZXo5H+VXubTsD+D9udKvKf0N5J8G4qSkWoOBifxaWMmbXUnmG5E9hAtTLnvTJvS8g6DhhXmuct62WJqZJ1jWWKO7NQQcq0tCQnmZAZ1OGcCVm0OEBEULShzhELC9SRrPX40iSj9Vh3bK6tuEePL7wTSRpqs/G6cBwtOPgdzfg7BWt2IjGYnubMR1IuMHEXmkhtPhtS1qdrYCh+7KxB9QJ1/zDZSizu9NraTqmHmRKV36B+/UxOmaAhKVwh8hAol4aijsVGQ4RYPQlFr2CfLsP+m6MXl0pF0pINbXq+oXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747278503; c=relaxed/relaxed;
	bh=7V+27vhhsn7ylAr6n6JaQmpJBsxvl1P8ulM+Ioqqxgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mc5TpvG/1QYVsqmbw7Gw6AZK6d1wscRWjjIYvihx4g2/RN4Wh3bYI7ag5gBYtYG86wlVnK0cGvEcAVPbrbJrL9QSe2PMQYPZmFjeOw457bnuqQjyrl11//1VuD3d5EQGx25lIlZfqY/o3ZlqvvnC8blMBDvCaAbu+8ji0+5dAmz1gWu74O8fbM09CWI7L2+f8JQR+IatRa+Xhc5s2jZST3islNU1Q7+Rc7kpaCDoXy3ww7YRBvCUD0ByDTR3XN7y7ZO1TPuMLr38hQ++6ZtOUdxbTQUr9uB/f0RXy4F6rrwRwsx3BEecSCA+qatNPkNBPUarVOHQFawT1MWLN/VmYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZyZsd5bb0z2yvk
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 13:08:21 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZyZqt1gcTz1DKYm
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:06:50 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B1AC1402EA
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 11:08:17 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 11:08:16 +0800
Message-ID: <001d2160-e999-43cd-8bf1-2507e4a4eb1d@huawei.com>
Date: Thu, 15 May 2025 11:08:15 +0800
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
Subject: Re: [PATCH v2] erofs: support deflate decompress by using Intel QAT
To: <linux-erofs@lists.ozlabs.org>
References: <20250514121709.2557-1-liubo03@inspur.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250514121709.2557-1-liubo03@inspur.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/14 20:17, Bo Liu wrote:
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
> Changes since v1:
>   - Move the code to the decompress_crypto.c file.
>   - Add a struct z_erofs_crypto_engine to maintain accelerator information.
>   - Add a sysfs interface to enable/disable the accelerator.
> 
>   fs/erofs/Makefile               |   2 +-
>   fs/erofs/compress.h             |  13 ++
>   fs/erofs/decompressor_crypto.c  | 219 ++++++++++++++++++++++++++++++++
>   fs/erofs/decompressor_deflate.c |  14 +-
>   fs/erofs/sysfs.c                |  19 +++
>   5 files changed, 265 insertions(+), 2 deletions(-)
>   create mode 100644 fs/erofs/decompressor_crypto.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 4331d53c7109..8462e16a8356 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -3,7 +3,7 @@
>   obj-$(CONFIG_EROFS_FS) += erofs.o
>   erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
> -erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
> +erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 2704d7a592a5..909fab195d93 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -70,10 +70,23 @@ struct z_erofs_stream_dctx {
>   	bool bounced;			/* is the bounce buffer used now? */
>   };
>   
> +struct z_erofs_crypto_engine {
> +	char *crypto_name;
> +	bool enabled;
> +	struct crypto_acomp *erofs_tfm;
> +};
> +
> +extern struct z_erofs_crypto_engine *z_erofs_crypto[];
> +
>   int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
>   			       void **src, struct page **pgpl);
>   int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>   			 unsigned int padbufsize);
>   int __init z_erofs_init_decompressor(void);
>   void z_erofs_exit_decompressor(void);
> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +						struct crypto_acomp *erofs_tfm, struct page **pgpl);
> +struct crypto_acomp *z_erofs_crypto_get_enbale_engine(int type);
> +int z_erofs_crypto_enable_engine(const char *name);
> +int z_erofs_crypto_disable_engine(const char *name);
>   #endif
> diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
> new file mode 100644
> index 000000000000..500cff5e9b17
> --- /dev/null
> +++ b/fs/erofs/decompressor_crypto.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/scatterlist.h>
> +#include <crypto/acompress.h>
> +
> +#include "compress.h"
> +
> +static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *erofs_tfm)
> +{
> +	unsigned int nrpages_out = rq->outpages, nrpages_in = rq->inpages;
> +	struct sg_table st_src, st_dst;
> +	struct scatterlist *sg_src, *sg_dst;
> +	struct acomp_req *req;
> +	struct crypto_wait wait;
> +	int ret, i;
> +	u8 *headpage;
> +
> +
> +	WARN_ON(!*rq->in);
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
> +	if (sg_alloc_table(&st_src, nrpages_in, GFP_KERNEL)) {
> +		acomp_request_free(req);
> +		return -ENOMEM;
> +	}
> +
> +	if (sg_alloc_table(&st_dst, nrpages_out, GFP_KERNEL)) {
> +		acomp_request_free(req);
> +		sg_free_table(&st_src);
> +		return -ENOMEM;
> +	}
> +
> +	for_each_sg(st_src.sgl, sg_src, nrpages_in, i) {
> +		if (i == 0)
> +			sg_set_page(sg_src, rq->in[0],
> +				PAGE_SIZE - rq->pageofs_in, rq->pageofs_in);
> +		else if (i == nrpages_in - 1)
> +			sg_set_page(sg_src, rq->in[i],
> +				rq->pageofs_in + rq->inputsize - (nrpages_in - 1) * PAGE_SIZE, 0);
> +		else
> +			sg_set_page(sg_src, rq->in[i], PAGE_SIZE, 0);
> +	}
> +
> +	i = 0;
> +	for_each_sg(st_dst.sgl, sg_dst, nrpages_out, i) {
> +		if (i == 0)
> +			sg_set_page(sg_dst, rq->out[0],
> +				PAGE_SIZE - rq->pageofs_out, rq->pageofs_out);
> +		else if (i == nrpages_out)
> +			sg_set_page(sg_dst, rq->out[i],
> +				rq->pageofs_out + rq->outputsize - (nrpages_out - 1) * PAGE_SIZE, 0);
> +		else
> +			sg_set_page(sg_dst, rq->out[i], PAGE_SIZE, 0);
> +	}
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
> +	acomp_request_free(req);
> +	sg_free_table(&st_src);
> +	sg_free_table(&st_dst);
> +	return ret;
> +}
> +
> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *erofs_tfm, struct page **pgpl)
> +{
> +	const unsigned int nrpages_out =
> +		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> +	int i;
> +
> +	/* one optimized fast path only for non bigpcluster cases yet */
> +	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
> +		WARN_ON(!*rq->out);
> +		goto dstmap_out;
> +	}
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
> +dstmap_out:
> +	return z_erofs_crypto_decompress_mem(rq, erofs_tfm);
> +}
> +
> +struct crypto_acomp *z_erofs_crypto_get_enbale_engine(int type)
> +{
> +	int i = 0;
> +
> +	while (z_erofs_crypto[type][i].crypto_name) {
> +		if (z_erofs_crypto[type][i].enabled)
> +			return z_erofs_crypto[type][i].erofs_tfm;
> +		i++;
> +	}
> +
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
> +			if (!strncmp(name, z_erofs_crypto[i][j].crypto_name,
> +					strlen(z_erofs_crypto[i][j].crypto_name))) {
> +				return i;
> +			}
> +			j++;
> +		}
> +	}
> +
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
> +		if (!strncmp(z_erofs_crypto[type][i].crypto_name, name,
> +				strlen(z_erofs_crypto[type][i].crypto_name))) {
> +			if (z_erofs_crypto[type][i].enabled)
> +				break;
> +
> +			z_erofs_crypto[type][i].erofs_tfm =
> +				crypto_alloc_acomp(z_erofs_crypto[type][i].crypto_name, 0, 0);
> +			if (IS_ERR(z_erofs_crypto[type][i].erofs_tfm)) {
> +				z_erofs_crypto[type][i].erofs_tfm = NULL;
> +				break;
> +			}
> +			z_erofs_crypto[type][i].enabled = true;
> +		} else if (z_erofs_crypto[type][i].enabled) {
> +			if (z_erofs_crypto[type][i].erofs_tfm)
> +				crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
> +			z_erofs_crypto[type][i].enabled = false;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +int z_erofs_crypto_disable_engine(const char *name)
> +{
> +	int i = 0, type;
> +
> +	type = z_erofs_crypto_get_compress_type(name);
> +	if (type < 0)
> +		return -EINVAL;
> +
> +	while (z_erofs_crypto[type][i].crypto_name) {
> +		if (!strncmp(z_erofs_crypto[type][i].crypto_name, name,
> +				strlen(z_erofs_crypto[type][i].crypto_name))) {
> +			if (z_erofs_crypto[type][i].enabled &&
> +					z_erofs_crypto[type][i].erofs_tfm) {
> +				crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
> +				z_erofs_crypto[type][i].erofs_tfm = NULL;
> +				z_erofs_crypto[type][i].enabled = false;
> +			}
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +struct z_erofs_crypto_engine *z_erofs_crypto[] = {
> +	[Z_EROFS_COMPRESSION_LZ4] = &(struct z_erofs_crypto_engine) {NULL},
> +	[Z_EROFS_COMPRESSION_LZMA] = &(struct z_erofs_crypto_engine) {NULL},
> +	[Z_EROFS_COMPRESSION_DEFLATE] = {&(struct z_erofs_crypto_engine) {
> +			.crypto_name = "qat_deflate",
> +			.enabled = false,
> +			.erofs_tfm = NULL,
> +		},
> +		&(const struct z_erofs_crypto_engine) { NULL },
> +	},
> +	[Z_EROFS_COMPRESSION_ZSTD] = &(struct z_erofs_crypto_engine) {NULL},
> +};
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
> index c6908a487054..35a5889880f4 100644
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
> @@ -178,6 +178,18 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>   	return err;
>   }
>   
> +static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> +				struct page **pgpl)
> +{
> +	struct crypto_acomp *erofs_tfm = NULL;
> +
> +	erofs_tfm = z_erofs_crypto_get_enbale_engine(Z_EROFS_COMPRESSION_DEFLATE);
> +	if (erofs_tfm && !rq->partial_decoding)
> +		return z_erofs_crypto_decompress(rq, erofs_tfm, pgpl);
> +	else
> +		return __z_erofs_deflate_decompress(rq, pgpl);
> +}
> +
>   const struct z_erofs_decompressor z_erofs_deflate_decomp = {
>   	.config = z_erofs_load_deflate_config,
>   	.decompress = z_erofs_deflate_decompress,
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index dad4e6c6c155..a9c0aad01264 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -7,12 +7,15 @@
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
> +	attr_crypto_enable,
> +	attr_crypto_disable,
>   };
>   
>   enum {
> @@ -59,6 +62,8 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   #ifdef CONFIG_EROFS_FS_ZIP
>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
>   EROFS_ATTR_FUNC(drop_caches, 0200);
> +EROFS_ATTR_FUNC(crypto_enable, 0644);
> +EROFS_ATTR_FUNC(crypto_disable, 0644);
>   #endif
>   
>   static struct attribute *erofs_attrs[] = {
> @@ -95,6 +100,8 @@ static struct attribute *erofs_feat_attrs[] = {
>   	ATTR_LIST(fragments),
>   	ATTR_LIST(dedupe),
>   	ATTR_LIST(48bit),
> +	ATTR_LIST(crypto_enable),
> +	ATTR_LIST(crypto_disable),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(erofs_feat);
> @@ -181,6 +188,18 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   		if (t & 1)
>   			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
>   		return len;
> +	case attr_crypto_enable:
> +		buf = skip_spaces(buf);
> +		if (z_erofs_crypto_enable_engine(buf))
> +			return -EINVAL;

Hi, Bo
I wonder why we should need both enable and disable. If the crypto 
method is not set into enable, it will be disabled. So may be these two 
could probably be combined into one, right?

Another one, is it possible to support multiple crypto methods instead 
of just one? If so, maybe we could join them with comma, such as echo -n 
"qat_deflate,xxx" > xxx/crypto_enable.

Thanks,
Hongbo


> +
> +		return len;
> +	case attr_crypto_disable:
> +		buf = skip_spaces(buf);
> +		if (z_erofs_crypto_disable_engine(buf))
> +			return -EINVAL;
> +
> +		return len;
>   #endif
>   	}
>   	return 0;

