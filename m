Return-Path: <linux-erofs+bounces-328-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BCAB7CE1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 May 2025 07:12:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zydcs1q0mz3000;
	Thu, 15 May 2025 15:12:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747285949;
	cv=none; b=kOKx3QN3iJHa3cAnjXw0f3Uncw/kXnj0reEwSvZs/u3UtivZq/L/RTDF7cCm4CE1dNZSh48toLClTHqAwGvWn6dPE/ELnW+AFAVohUqqDq6rVxE7TffhC0WPY7IYIFWeqp/LMjdXb2M46DjAftW+I4XaVGodeCoknjhoN3ZE4+P7f00zhsWw84q6Yg9AEjlAQ2SfXoyRkzRz23kJ0H4oqH4YPv+0LZUTSMTnTPFJIX0S/LO3TAWM7f+1MslncY36OlhDhW+qYfAIDze8ABJJ8N3+AXIzH9r9AHpkkvFYRi5KHJowpEjPPAKZSxQoxeL7YXMN63BWrMsxkIAmZhVtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747285949; c=relaxed/relaxed;
	bh=5yywUV/xiFcY4OeZNBUwTIwtLax520drbbajaHqkS7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VDMpL0tRk8O5YV45fow+rmV+DlhH/6UAGoXgdBtIyJTqJf9dqcndaJbd8Kzcq/rIxgyfYE2UL2eH2z/LaBqn+ZqUpKGP1NvMVOBKK+JLr2i8fS+Y3Rn0qonETkyilf0VO4UorwwnkEK59kFMQmBo1NInQCscJGYv5k4MFx4MPuyOB0izQnW3mpS0HWKt43I77/rbTCqvIdmAr4LxOeKg++u7VRXnvlWdjYqLGD+CLd7I/Uq7cWbgzQu+Ic3psvgEgl8+aU4VD9bR/AESlQj/ertYhihrLeg3I2MXQtLZk9akPngmxC4DiT7r9jNHnSRxPLob4xmtaqboTfnwSAz9Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a8kLHeDl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a8kLHeDl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zydcl4qkvz2yvv
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 May 2025 15:12:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747285937; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5yywUV/xiFcY4OeZNBUwTIwtLax520drbbajaHqkS7Q=;
	b=a8kLHeDlHxE3YW26crHII5hPyHDtXmTc7zufXt0wSjKlFFxDeoENbqKvSlJWHUZ9MbNFVg8kGLpJKkmtYNamKFMiwPuO8zmgCt7bBd4Vx4cty+Wk6duzIGUs1vafAiN58WNpso09SRE8ofnAwm8OJTYt6K4rJPJvSqUZ1fVhXY4=
Received: from 30.221.131.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WapPNdi_1747285935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 May 2025 13:12:15 +0800
Message-ID: <b1c5c075-4835-4380-a1d4-29391e761459@linux.alibaba.com>
Date: Thu, 15 May 2025 13:12:14 +0800
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
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org,
 Bo Liu <liubo03@inspur.com>, LKML <linux-kernel@vger.kernel.org>
References: <20250514121709.2557-1-liubo03@inspur.com>
 <001d2160-e999-43cd-8bf1-2507e4a4eb1d@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <001d2160-e999-43cd-8bf1-2507e4a4eb1d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/15 11:08, Hongbo Li wrote:
> 
> 
> On 2025/5/14 20:17, Bo Liu wrote:
>> This patch introdueces the use of the Intel QAT to decompress compressed
>> data in the EROFS filesystem, aiming to improve the decompression speed
>> of compressed datea.
>>
>> We created a 285MiB compressed file and then used the following command to
>> create EROFS images with different cluster size.
>>       # mkfs.erofs -zdeflate,level=9 -C16384
>>
>> fio command was used to test random read and small random read(~5%) and
>> sequential read performance.
>>       # fio -filename=testfile  -bs=4k -rw=read -name=job1
>>       # fio -filename=testfile  -bs=4k -rw=randread -name=job1
>>       # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1
>>
>> Here are some performance numbers for reference:
>>
>> Processors: Intel(R) Xeon(R) 6766E(144 core)
>> Memory:     521 GiB
>>
>> |-----------------------------------------------------------------------------|
>> |           | Cluster size | sequential read | randread  | small randread(5%) |
>> |-----------|--------------|-----------------|-----------|--------------------|
>> | Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
>> | Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
>> | Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
>> | Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
>> | Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
>> | deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
>> | deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
>> | deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
>> | deflate   |    131072    |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
>> | deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |
>>
>> Signed-off-by: Bo Liu <liubo03@inspur.com>
>> ---
>> v1: https://lore.kernel.org/linux-erofs/20250410042048.3044-1-liubo03@inspur.com/
>> Changes since v1:
>>   - Move the code to the decompress_crypto.c file.
>>   - Add a struct z_erofs_crypto_engine to maintain accelerator information.
>>   - Add a sysfs interface to enable/disable the accelerator.
>>
>>   fs/erofs/Makefile               |   2 +-
>>   fs/erofs/compress.h             |  13 ++
>>   fs/erofs/decompressor_crypto.c  | 219 ++++++++++++++++++++++++++++++++
>>   fs/erofs/decompressor_deflate.c |  14 +-
>>   fs/erofs/sysfs.c                |  19 +++
>>   5 files changed, 265 insertions(+), 2 deletions(-)
>>   create mode 100644 fs/erofs/decompressor_crypto.c
>>
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 4331d53c7109..8462e16a8356 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -3,7 +3,7 @@
>>   obj-$(CONFIG_EROFS_FS) += erofs.o
>>   erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
>>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>> -erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>> +erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
>> index 2704d7a592a5..909fab195d93 100644
>> --- a/fs/erofs/compress.h
>> +++ b/fs/erofs/compress.h
>> @@ -70,10 +70,23 @@ struct z_erofs_stream_dctx {
>>       bool bounced;            /* is the bounce buffer used now? */
>>   };
>> +struct z_erofs_crypto_engine {
>> +    char *crypto_name;
>> +    bool enabled;
>> +    struct crypto_acomp *erofs_tfm;
>> +};
>> +
>> +extern struct z_erofs_crypto_engine *z_erofs_crypto[];
>> +
>>   int z_erofs_stream_switch_bufs(struct z_erofs_stream_dctx *dctx, void **dst,
>>                      void **src, struct page **pgpl);
>>   int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
>>                unsigned int padbufsize);
>>   int __init z_erofs_init_decompressor(void);
>>   void z_erofs_exit_decompressor(void);
>> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
>> +                        struct crypto_acomp *erofs_tfm, struct page **pgpl);
>> +struct crypto_acomp *z_erofs_crypto_get_enbale_engine(int type);
>> +int z_erofs_crypto_enable_engine(const char *name);
>> +int z_erofs_crypto_disable_engine(const char *name);
>>   #endif
>> diff --git a/fs/erofs/decompressor_crypto.c b/fs/erofs/decompressor_crypto.c
>> new file mode 100644
>> index 000000000000..500cff5e9b17
>> --- /dev/null
>> +++ b/fs/erofs/decompressor_crypto.c
>> @@ -0,0 +1,219 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +

Unnecessary new line.

>> +#include <linux/scatterlist.h>
>> +#include <crypto/acompress.h>
>> +
>> +#include "compress.h"
>> +
>> +static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq,
>> +                struct crypto_acomp *erofs_tfm)
>> +{
>> +    unsigned int nrpages_out = rq->outpages, nrpages_in = rq->inpages;

Could you just drop `nrpages_out` and `nrpages_in`? see below.

>> +    struct sg_table st_src, st_dst;
>> +    struct scatterlist *sg_src, *sg_dst;
>> +    struct acomp_req *req;
>> +    struct crypto_wait wait;
>> +    int ret, i;
>> +    u8 *headpage;
>> +
>> +


Unnecessary new line.

>> +    WARN_ON(!*rq->in);

Unnecessary WARN_ON since kmap_local_page() will oops otherwise.

>> +    headpage = kmap_local_page(*rq->in);
>> +    ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
>> +                min_t(unsigned int, rq->inputsize,
>> +                            rq->sb->s_blocksize - rq->pageofs_in));
>> +    kunmap_local(headpage);
>> +    if (ret)
>> +        return ret;
>> +
>> +    req = acomp_request_alloc(erofs_tfm);
>> +    if (!req) {
>> +        erofs_err(rq->sb, "failed to alloc decompress request");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (sg_alloc_table(&st_src, nrpages_in, GFP_KERNEL)) {
>> +        acomp_request_free(req);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (sg_alloc_table(&st_dst, nrpages_out, GFP_KERNEL)) {
>> +        acomp_request_free(req);
>> +        sg_free_table(&st_src);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    for_each_sg(st_src.sgl, sg_src, nrpages_in, i) {
>> +        if (i == 0)
>> +            sg_set_page(sg_src, rq->in[0],
>> +                PAGE_SIZE - rq->pageofs_in, rq->pageofs_in);
>> +        else if (i == nrpages_in - 1)
>> +            sg_set_page(sg_src, rq->in[i],
>> +                rq->pageofs_in + rq->inputsize - (nrpages_in - 1) * PAGE_SIZE, 0);
>> +        else
>> +            sg_set_page(sg_src, rq->in[i], PAGE_SIZE, 0);
>> +    }

Can we just use sg_alloc_table_from_pages_segment() here?

>> +
>> +    i = 0;

Unnecessary `i = 0;`

>> +    for_each_sg(st_dst.sgl, sg_dst, nrpages_out, i) {
>> +        if (i == 0)
>> +            sg_set_page(sg_dst, rq->out[0],
>> +                PAGE_SIZE - rq->pageofs_out, rq->pageofs_out);
>> +        else if (i == nrpages_out)
>> +            sg_set_page(sg_dst, rq->out[i],
>> +                rq->pageofs_out + rq->outputsize - (nrpages_out - 1) * PAGE_SIZE, 0);
>> +        else
>> +            sg_set_page(sg_dst, rq->out[i], PAGE_SIZE, 0);
>> +    }


Can we just use sg_alloc_table_from_pages_segment() here?

>> +
>> +    acomp_request_set_params(req, st_src.sgl,
>> +        st_dst.sgl, rq->inputsize, rq->outputsize);
>> +
>> +    crypto_init_wait(&wait);
>> +    acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
>> +                crypto_req_done, &wait);
>> +
>> +    ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
>> +    if (ret < 0) {
>> +        erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
>> +                    ret, rq->inputsize, rq->pageofs_in, rq->outputsize);
>> +        ret = -EIO;
>> +    } else
>> +        ret = 0;
>> +
>> +    acomp_request_free(req);
>> +    sg_free_table(&st_src);
>> +    sg_free_table(&st_dst);
>> +    return ret;
>> +}
>> +
>> +int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
>> +                struct crypto_acomp *erofs_tfm, struct page **pgpl)
>> +{
>> +    const unsigned int nrpages_out =
>> +        PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;

You could change here too.


>> +    int i;
>> +
>> +    /* one optimized fast path only for non bigpcluster cases yet */
>> +    if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
>> +        WARN_ON(!*rq->out);
>> +        goto dstmap_out;
>> +    }
>> +
>> +    for (i = 0; i < rq->outpages; i++) {
>> +        struct page *const page = rq->out[i];
>> +        struct page *victim;
>> +
>> +        if (!page) {
>> +            victim = __erofs_allocpage(pgpl, rq->gfp, true);
>> +            if (!victim)
>> +                return -ENOMEM;
>> +            set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
>> +            rq->out[i] = victim;
>> +        }
>> +    }
>> +
>> +dstmap_out:
>> +    return z_erofs_crypto_decompress_mem(rq, erofs_tfm);
>> +}
>> +
>> +struct crypto_acomp *z_erofs_crypto_get_enbale_engine(int type)


z_erofs_crypto_get_engine()

>> +{
>> +    int i = 0;
>> +
>> +    while (z_erofs_crypto[type][i].crypto_name) {

	for (i = 0; z_erofs_crypto[type][i].crypto_name; ++i) {
		...
	}

>> +        if (z_erofs_crypto[type][i].enabled)
>> +            return z_erofs_crypto[type][i].erofs_tfm;
>> +        i++;
>> +    }
>> +

I don't like the meaningless newline here.

>> +    return NULL;
>> +}
>> +
>> +static int z_erofs_crypto_get_compress_type(const char *name)
>> +{
>> +    int i, j;
>> +
>> +    for (i = 0; i < Z_EROFS_COMPRESSION_MAX; i++) {
>> +        j = 0;
>> +        while (z_erofs_crypto[i][j].crypto_name) {
>> +            if (!strncmp(name, z_erofs_crypto[i][j].crypto_name,
>> +                    strlen(z_erofs_crypto[i][j].crypto_name))) {
>> +                return i;
>> +            }
>> +            j++;
>> +        }
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +int z_erofs_crypto_enable_engine(const char *name)
>> +{
>> +    int i = 0, type;
>> +
>> +    type = z_erofs_crypto_get_compress_type(name);
>> +    if (type < 0)
>> +        return -EINVAL;
>> +
>> +    while (z_erofs_crypto[type][i].crypto_name) {

Use for loop...

>> +        if (!strncmp(z_erofs_crypto[type][i].crypto_name, name,
>> +                strlen(z_erofs_crypto[type][i].crypto_name))) {

Why not just use strcmp?

>> +            if (z_erofs_crypto[type][i].enabled)
>> +                break;
>> +
>> +            z_erofs_crypto[type][i].erofs_tfm =
>> +                crypto_alloc_acomp(z_erofs_crypto[type][i].crypto_name, 0, 0);
>> +            if (IS_ERR(z_erofs_crypto[type][i].erofs_tfm)) {
>> +                z_erofs_crypto[type][i].erofs_tfm = NULL;
>> +                break;
>> +            }
>> +            z_erofs_crypto[type][i].enabled = true;
>> +        } else if (z_erofs_crypto[type][i].enabled) {
>> +            if (z_erofs_crypto[type][i].erofs_tfm)
>> +                crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
>> +            z_erofs_crypto[type][i].enabled = false;
>> +        }
>> +        i++;
>> +    }
>> +

Redundent new line again.

>> +    return 0;
>> +}
>> +
>> +int z_erofs_crypto_disable_engine(const char *name)
>> +{
>> +    int i = 0, type;
>> +
>> +    type = z_erofs_crypto_get_compress_type(name);
>> +    if (type < 0)
>> +        return -EINVAL;
>> +
>> +    while (z_erofs_crypto[type][i].crypto_name) {
>> +        if (!strncmp(z_erofs_crypto[type][i].crypto_name, name,
>> +                strlen(z_erofs_crypto[type][i].crypto_name))) {
>> +            if (z_erofs_crypto[type][i].enabled &&
>> +                    z_erofs_crypto[type][i].erofs_tfm) {
>> +                crypto_free_acomp(z_erofs_crypto[type][i].erofs_tfm);
>> +                z_erofs_crypto[type][i].erofs_tfm = NULL;
>> +                z_erofs_crypto[type][i].enabled = false;
>> +            }
>> +        }
>> +        i++;
>> +    }
>> +
>> +    return 0;
>> +
>> +}
>> +
>> +struct z_erofs_crypto_engine *z_erofs_crypto[] = {
>> +    [Z_EROFS_COMPRESSION_LZ4] = &(struct z_erofs_crypto_engine) {NULL},
>> +    [Z_EROFS_COMPRESSION_LZMA] = &(struct z_erofs_crypto_engine) {NULL},
>> +    [Z_EROFS_COMPRESSION_DEFLATE] = {&(struct z_erofs_crypto_engine) {
>> +            .crypto_name = "qat_deflate",
>> +            .enabled = false,
>> +            .erofs_tfm = NULL,
>> +        },
>> +        &(const struct z_erofs_crypto_engine) { NULL },
>> +    },
>> +    [Z_EROFS_COMPRESSION_ZSTD] = &(struct z_erofs_crypto_engine) {NULL},
>> +};
>> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
>> index c6908a487054..35a5889880f4 100644
>> --- a/fs/erofs/decompressor_deflate.c
>> +++ b/fs/erofs/decompressor_deflate.c
>> @@ -97,7 +97,7 @@ static int z_erofs_load_deflate_config(struct super_block *sb,
>>       return -ENOMEM;
>>   }
>> -static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>> +static int __z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>>                         struct page **pgpl)
>>   {
>>       struct super_block *sb = rq->sb;
>> @@ -178,6 +178,18 @@ static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>>       return err;
>>   }
>> +static int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
>> +                struct page **pgpl)
>> +{
>> +    struct crypto_acomp *erofs_tfm = NULL;
>> +
>> +    erofs_tfm = z_erofs_crypto_get_enbale_engine(Z_EROFS_COMPRESSION_DEFLATE);
>> +    if (erofs_tfm && !rq->partial_decoding)
>> +        return z_erofs_crypto_decompress(rq, erofs_tfm, pgpl);
>> +    else
>> +        return __z_erofs_deflate_decompress(rq, pgpl);
>> +}
>> +
>>   const struct z_erofs_decompressor z_erofs_deflate_decomp = {
>>       .config = z_erofs_load_deflate_config,
>>       .decompress = z_erofs_deflate_decompress,
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index dad4e6c6c155..a9c0aad01264 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -7,12 +7,15 @@
>>   #include <linux/kobject.h>
>>   #include "internal.h"
>> +#include "compress.h"
>>   enum {
>>       attr_feature,
>>       attr_drop_caches,
>>       attr_pointer_ui,
>>       attr_pointer_bool,
>> +    attr_crypto_enable,
>> +    attr_crypto_disable,
>>   };
>>   enum {
>> @@ -59,6 +62,8 @@ static struct erofs_attr erofs_attr_##_name = {            \
>>   #ifdef CONFIG_EROFS_FS_ZIP
>>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
>>   EROFS_ATTR_FUNC(drop_caches, 0200);
>> +EROFS_ATTR_FUNC(crypto_enable, 0644);
>> +EROFS_ATTR_FUNC(crypto_disable, 0644);
>>   #endif
>>   static struct attribute *erofs_attrs[] = {
>> @@ -95,6 +100,8 @@ static struct attribute *erofs_feat_attrs[] = {
>>       ATTR_LIST(fragments),
>>       ATTR_LIST(dedupe),
>>       ATTR_LIST(48bit),
>> +    ATTR_LIST(crypto_enable),
>> +    ATTR_LIST(crypto_disable),
>>       NULL,
>>   };
>>   ATTRIBUTE_GROUPS(erofs_feat);
>> @@ -181,6 +188,18 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>>           if (t & 1)
>>               invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
>>           return len;
>> +    case attr_crypto_enable:
>> +        buf = skip_spaces(buf);
>> +        if (z_erofs_crypto_enable_engine(buf))
>> +            return -EINVAL;
> 
> Hi, Bo
> I wonder why we should need both enable and disable. If the crypto method is not set into enable, it will be disabled. So may be these two could probably be combined into one, right?


After rethinking, I agree with Hongbo too, how about

cat xxx/crypto -> show available engines in lines.


echo "qat_deflate" >> xxx/crypto -> enable "qat_deflate"

echo "" > xxx/crypto -> disable all engines.


> 
> Another one, is it possible to support multiple crypto methods instead of just one? If so, maybe we could join them with comma, such as echo -n "qat_deflate,xxx" > xxx/crypto_enable.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
> 
>> +
>> +        return len;
>> +    case attr_crypto_disable:
>> +        buf = skip_spaces(buf);
>> +        if (z_erofs_crypto_disable_engine(buf))
>> +            return -EINVAL;
>> +
>> +        return len;
>>   #endif
>>       }
>>       return 0;


