Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6589522A
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 13:45:10 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=el/RDzDt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V85fD2QNtz3dSp
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Apr 2024 22:45:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=el/RDzDt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V85f63XBfz3cCx
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Apr 2024 22:44:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712058294; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2LlP5A3jA4i6BC9C1h7o21bfuQpjLNLxWPXmD86XwE0=;
	b=el/RDzDtdj6PmTojt5aX1n6nfzrfjDtSEbjzhfdpHWdcQz+K89U+ROKLpR2s7MCYwVHYSg4btae2a3JU5wrEj06D1YpLnV9THxydyigojtTLE4TthOwX+r4QCgLR35DytPv3Vdb5ey/J1XsIaYxYMLWngolymhSsZ/3A3Bky/UQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W3oKOU1_1712058291;
Received: from 30.97.48.168(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3oKOU1_1712058291)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 19:44:52 +0800
Message-ID: <9daf9d31-cb12-4c8d-b53e-ff837bd14b7a@linux.alibaba.com>
Date: Tue, 2 Apr 2024 19:44:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add a reserved buffer pool for lz4 decompression
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240402084525.2624202-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240402084525.2624202-1-guochunhai@vivo.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/4/2 16:45, Chunhai Guo wrote:
> This adds a special global buffer pool (in the end) for reserved pages.
> 
> Using a reserved pool for LZ4 decompression significantly reduces the
> time spent on extra temporary page allocation for the extreme cases in
> low memory scenarios.
> 
> The table below shows the reduction in time spent on page allocation for
> LZ4 decompression when using a reserved pool. The results were obtained
> from multi-app launch benchmarks on ARM64 Android devices running the
> 5.15 kernel with an 8-core CPU and 8GB of memory. In the benchmark, we
> launched 16 frequently-used apps, and the camera app was the last one in
> each round. The data in the table is the average time of camera app for
> each round.
> 
> After using the reserved pool, there was an average improvement of 150ms
> in the overall launch time of our camera app, which was obtained from
> the systrace log.
> 
> +--------------+---------------+--------------+---------+
> |              | w/o page pool | w/ page pool |  diff   |
> +--------------+---------------+--------------+---------+
> | Average (ms) |     3434      |      21      | -99.38% |
> +--------------+---------------+--------------+---------+
> 
> Based on the benchmark logs, 64 pages are sufficient for 95% of
> scenarios. This value can be adjusted from the module parameter.
> The default value is 0.
> 
> This pool is currently only used for the LZ4 decompressor, but it can be
> applied to more decompressors if needed.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/decompressor.c |  2 +-
>   fs/erofs/internal.h     |  6 ++++-
>   fs/erofs/zutil.c        | 59 ++++++++++++++++++++++++++++++-----------
>   3 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index e1239d886984..d2fe8130819e 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -111,7 +111,7 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>   			victim = availables[--top];
>   			get_page(victim);
>   		} else {
> -			victim = erofs_allocpage(pagepool, rq->gfp);
> +			victim = __erofs_allocpage(pagepool, rq->gfp, true);
>   			if (!victim)
>   				return -ENOMEM;
>   			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 1caa5d702835..664f6f7c971f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -445,7 +445,11 @@ void erofs_unregister_sysfs(struct super_block *sb);
>   int __init erofs_init_sysfs(void);
>   void erofs_exit_sysfs(void);
>   
> -struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp);
> +struct page *__erofs_allocpage(struct page **pagepool, gfp_t gfp, bool tryrsv);
> +static inline struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
> +{
> +	return __erofs_allocpage(pagepool, gfp, false);
> +}
>   static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>   {
>   	set_page_private(page, (unsigned long)*pagepool);
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 14440c0bf64e..b45ca0b8b547 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -12,10 +12,12 @@ struct z_erofs_gbuf {
>   	unsigned int nrpages;
>   };
>   
> -static struct z_erofs_gbuf *z_erofs_gbufpool;
> -static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages;
> +static struct z_erofs_gbuf *z_erofs_gbufpool, *z_erofs_rsvbuf;
> +static unsigned int z_erofs_gbuf_count, z_erofs_gbuf_nrpages,
> +		z_erofs_rsv_nrpages;
>   
>   module_param_named(global_buffers, z_erofs_gbuf_count, uint, 0444);
> +module_param_named(reserved_pages, z_erofs_rsv_nrpages, uint, 0444);
>   
>   static atomic_long_t erofs_global_shrink_cnt;	/* for all mounted instances */
>   /* protected by 'erofs_sb_list_lock' */
> @@ -117,19 +119,28 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
>   
>   int __init z_erofs_gbuf_init(void)
>   {
> -	unsigned int i = num_possible_cpus();
> +	unsigned int i, total = num_possible_cpus();
>   
> -	if (!z_erofs_gbuf_count)
> -		z_erofs_gbuf_count = i;
> -	else
> -		z_erofs_gbuf_count = min(z_erofs_gbuf_count, i);
> +	if (z_erofs_gbuf_count)
> +		total = min(z_erofs_gbuf_count, total);
> +	z_erofs_gbuf_count = total;
>   
> -	z_erofs_gbufpool = kcalloc(z_erofs_gbuf_count,
> -			sizeof(*z_erofs_gbufpool), GFP_KERNEL);
> +	/* The last (special) global buffer is the reserved buffer */
> +	total += !!z_erofs_rsv_nrpages;
> +
> +	z_erofs_gbufpool = kcalloc(total, sizeof(*z_erofs_gbufpool),
> +				   GFP_KERNEL);
>   	if (!z_erofs_gbufpool)
>   		return -ENOMEM;
>   
> -	for (i = 0; i < z_erofs_gbuf_count; ++i)
> +	if (z_erofs_rsv_nrpages) {
> +		z_erofs_rsvbuf = &z_erofs_gbufpool[total - 1];
> +		z_erofs_rsvbuf->pages = kcalloc(z_erofs_rsv_nrpages,
> +				sizeof(*z_erofs_rsvbuf->pages), GFP_KERNEL);
> +		if (!z_erofs_rsvbuf->pages)
> +			z_erofs_rsvbuf = NULL;

It'd be better to reset z_erofs_rsv_nrpages to 0, since it can be
fetched from `/sys/module/erofs/parameters`, as:

		if (!z_erofs_rsvbuf->pages) {
			z_erofs_rsvbuf = NULL;
			z_erofs_rsv_nrpages = 0;
		}

Thanks,
Gao Xiang
