Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7985FE37
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Feb 2024 17:40:52 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tvzVmK1u;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tgf5t3cSWz3dVN
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Feb 2024 03:40:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tvzVmK1u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tgf5l3rKwz3ccV
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Feb 2024 03:40:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708620035; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XdipEthDX1evwNsHN74pscnuILxq8YeiYy8+oqoQ+nc=;
	b=tvzVmK1u1vPqfLPW3AdMV5P8Iz5hXrSRo+S8aFqnoMvyZ+KGj39chF6r7vPHoncFs29lvEzNZhAfOF/+xvFPmOYdrPLT3a2vkJuiv8hmDMRXC2cDC10dMN+N3DtwxW/p7Rxiy78Jv1GSHiokGSKEorOD3Ia9NVn9cYgFXhLLk7Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W11cWoW_1708620030;
Received: from 30.25.202.165(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W11cWoW_1708620030)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 00:40:32 +0800
Message-ID: <63dc8e76-acde-4736-8df7-65670b17f8d9@linux.alibaba.com>
Date: Fri, 23 Feb 2024 00:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] erofs-utils: mkfs: add --worker=# parameter
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240220075525.684205-1-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-2-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-3-zhaoyifan@sjtu.edu.cn>
 <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240220075525.684205-4-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/2/20 15:55, Yifan Zhao wrote:
> This patch introduces a --worker=# parameter for the incoming
> multi-threaded compression support. It also introduces a segment size
> used in multi-threaded compression, which has the default value 16MB
> and cannot be modified.

It also introduces a concept called `segment size` to split large files
for multi-threading, which has the default value 16MB for now.

> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>   include/erofs/config.h |  4 ++++
>   lib/config.c           |  4 ++++
>   mkfs/main.c            | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 73e3ac2..d19094e 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -75,6 +75,10 @@ struct erofs_configure {
>   	char c_force_chunkformat;
>   	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>   	int c_inline_xattr_tolerance;
> +#ifdef EROFS_MT_ENABLED
> +	u64 c_mt_segment_size;


I think mt_ prefix is not needed: c_segment_size;


> +	u32 c_mt_worker_num;
c_mt_workers;

> +#endif
>   
>   	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
>   	u32 c_max_decompressed_extent_bytes;
> diff --git a/lib/config.c b/lib/config.c
> index 947a183..8add06d 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -38,6 +38,10 @@ void erofs_init_configure(void)
>   	cfg.c_pclusterblks_max = 1;
>   	cfg.c_pclusterblks_def = 1;
>   	cfg.c_max_decompressed_extent_bytes = -1;
> +#ifdef EROFS_MT_ENABLED
> +	cfg.c_mt_segment_size = 16ULL * 1024 * 1024;
> +	cfg.c_mt_worker_num = 1;
> +#endif
>   
>   	erofs_stdout_tty = isatty(STDOUT_FILENO);
>   }
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 7aea64a..3882533 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -73,6 +73,9 @@ static struct option long_options[] = {
>   	{"gzip", no_argument, NULL, 517},
>   #endif
>   	{"offset", required_argument, NULL, 518},
> +#ifdef EROFS_MT_ENABLED
> +	{"worker", required_argument, NULL, 519},

let's use `--workers=#` instead of `worker`.

> +#endif
>   	{0, 0, 0, 0},
>   };
>   
> @@ -175,6 +178,9 @@ static void usage(int argc, char **argv)
>   		" --product-out=X       X=product_out directory\n"
>   		" --fs-config-file=X    X=fs_config file\n"
>   		" --block-list-file=X   X=block_list file\n"
> +#endif
> +#ifdef EROFS_MT_ENABLED
> +		" --worker=#            set the number of worker threads to # (default=1)\n"

--workers=#

Thanks,
Gao Xiang
