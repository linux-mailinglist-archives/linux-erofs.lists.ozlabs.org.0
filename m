Return-Path: <linux-erofs+bounces-352-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB4AC0636
	for <lists+linux-erofs@lfdr.de>; Thu, 22 May 2025 09:54:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b30tS3yqkz3c3D;
	Thu, 22 May 2025 17:54:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747900464;
	cv=none; b=gbLc1JrJHA3Vm2lXD2rkjMOVJdV0X7jvKObXJaiYKNyV+HtSQCKZ8DS0AJ+uuOt6a7GRb3e/PDnWYZih4z0D4OFNV3QZ7huMG6B47iaElzy601XyO4rTXBRI8uPBpm42vF6l2CBZGRs7ihK7QxvsSYwlN47gccc5PH8/SDQiubYXfOsi0eUiOrVpyx/9TtduR9d4Pqw4dY8ctVYfAKSz/FfZwS+R2rhWbZMOLM5QkEBUQtcmfBMk6xsv3SqPLNipq2wo9CMOrEW9BA0vp3X4d6nhGGMzbzIIx6s4VJ/hKE398GgCAHvtnQ5lql3PJpyZKkJYFEx71I08VjPKNdSH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747900464; c=relaxed/relaxed;
	bh=xmllp+0pYS+iGPE0L4g0um6TnAHmX6fzEycWTLONE68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwh3l9JftaB9g15lhMwHiOLGI5trFhSnWfiGGKrA+WHsbj7g94iz+Hrwys8HzL7zfQB/6c7S/1p5iIQUsPco31EG8chWPFDLAh7tTja8Xqj/+ppDvEyVNPRNkYXYlJ9xyw6XHMeMniXT8gXBPxQgII1q82+5pPcEtdyFN7tIvbICWSu6wunhkU14/OuURMyy4TEdLjWciKwP6HYUB1hHmX6bio8ko/ziUcRZoOuhAdq+DwZYSxLCTmCvFv0vfF/IUvEWTYK6AZhE+8t4WBHajlDVq1cZoHKJofEwfT6VURi1ttoGFVCxOFaA6pCf4t51CJLcQcE+Bc3uvgZ97PgSpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiRM/R6F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yiRM/R6F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b30tQ5zzLz2yfK
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 May 2025 17:54:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747900457; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xmllp+0pYS+iGPE0L4g0um6TnAHmX6fzEycWTLONE68=;
	b=yiRM/R6FjMVFemioD5ViGIZrWtb+5wgY0+s/BFNvsKVx04lQB0de90+NKNIwJKdmCTKFOTdhwZOLquJQ9ArE1Hh8u9eQYfa3JZRYPRkDSSfPLpdd3jUOLNQJ9S8+j8Y4meuqsH1PyJPrNFtqANnB7c2gzVyF2LBhFlSylDjOc8w=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WbV0ft-_1747900454 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 15:54:15 +0800
Message-ID: <49ca7ddc-4ea7-4081-84ee-609a23b815e4@linux.alibaba.com>
Date: Thu, 22 May 2025 15:54:14 +0800
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
Subject: Re: [PATCH v5] erofs: support deflate decompress by using Intel QAT
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250522061611.7038-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250522061611.7038-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Bo,

On 2025/5/22 14:16, Bo Liu wrote:
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
> v3: https://lore.kernel.org/linux-erofs/20250516082634.3801-1-liubo03@inspur.com/
> v4: https://lore.kernel.org/linux-erofs/20250521100326.2867828-1-hsiangkao@linux.alibaba.com/
> change since v4:
>   - add sysfs documentation.
> 
>   Documentation/ABI/testing/sysfs-fs-erofs |  12 ++
>   fs/erofs/Kconfig                         |  14 ++
>   fs/erofs/Makefile                        |   1 +
>   fs/erofs/compress.h                      |  10 ++
>   fs/erofs/decompressor_crypto.c           | 186 +++++++++++++++++++++++
>   fs/erofs/decompressor_deflate.c          |  17 ++-
>   fs/erofs/sysfs.c                         |  34 ++++-
>   fs/erofs/zdata.c                         |   1 +
>   8 files changed, 272 insertions(+), 3 deletions(-)
>   create mode 100644 fs/erofs/decompressor_crypto.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index b134146d735b..95201a62f704 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -27,3 +27,15 @@ Description:	Writing to this will drop compression-related caches,
>   		- 1 : invalidate cached compressed folios
>   		- 2 : drop in-memory pclusters
>   		- 3 : drop in-memory pclusters and cached compressed folios
> +
> +What:		/sys/fs/erofs/accel
> +Date:		May 2025
> +Contact:	"Bo Liu" <liubo03@inspur.com>
> +Description:	The accel file is read-write and allows to set or show
> +		hardware decompression accelerators, and it supports writing
> +		multiple accelerators separated by ‘\n’.

		Used to set or show hardware accelerators in effect and multiple
		accelerators are separated by '\n'.

		Supported accelerator(s): qat_deflate

		Disable all accelerators with an empty string (echo > accel).

> +		Currently supported accelerators:

...

> +
> +static int __z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
> +				struct crypto_acomp *tfm)
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

	ret = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
				min_t(unsigned int, rq->inputsize,
				      rq->sb->s_blocksize - rq->pageofs_in));

Otherwise it looks good to me.

Thanks,
Gao Xiang

