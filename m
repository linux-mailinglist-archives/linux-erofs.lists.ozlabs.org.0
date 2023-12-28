Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FB81F9CA
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Dec 2023 16:58:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T1Cpt2WpFz3bsP
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 02:58:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T1Cpl3Pz6z30hQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 29 Dec 2023 02:58:21 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzOwWIl_1703779090;
Received: from 192.168.71.76(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzOwWIl_1703779090)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 23:58:12 +0800
Message-ID: <96632ab5-3748-4512-aeae-2e931ff14674@linux.alibaba.com>
Date: Thu, 28 Dec 2023 23:58:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add a global page pool for lz4 decompression
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
References: <20231228130053.1911057-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231228130053.1911057-1-guochunhai@vivo.com>
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

Hi Chunhai,

On 2023/12/28 21:00, Chunhai Guo wrote:
> Using a global page pool for LZ4 decompression significantly reduces the
> time spent on page allocation in low memory scenarios.
> 
> The table below shows the reduction in time spent on page allocation for
> LZ4 decompression when using a global page pool.
> The results were obtained from multi-app launch benchmarks on ARM64
> Android devices running the 5.15 kernel.
> +--------------+---------------+--------------+---------+
> |              | w/o page pool | w/ page pool |  diff   |
> +--------------+---------------+--------------+---------+
> | Average (ms) |     3434      |      21      | -99.38% |
> +--------------+---------------+--------------+---------+
> 
> Based on the benchmark logs, it appears that 256 pages are sufficient
> for most cases, but this can be adjusted as needed. Additionally,
> turning on CONFIG_EROFS_FS_DEBUG will simplify the tuning process.

Thanks for the patch. I have some questions:
  - what pcluster sizes are you using? 4k or more?

  - what the detailed configuration are you using for the multi-app
    launch workload? Such as CPU / Memory / the number of apps.

> 
> This patch currently only supports the LZ4 decompressor, other
> decompressors will be supported in the next step.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/compress.h     |   1 +
>   fs/erofs/decompressor.c |  42 ++++++++++++--
>   fs/erofs/internal.h     |   5 ++
>   fs/erofs/super.c        |   1 +
>   fs/erofs/utils.c        | 121 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 165 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 279933e007d2..67202b97d47b 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -31,6 +31,7 @@ struct z_erofs_decompressor {
>   /* some special page->private (unsigned long, see below) */
>   #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
>   #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
> +#define Z_EROFS_POOL_PAGE		(-3UL << 2)
>   
>   /*
>    * For all pages in a pcluster, page->private should be one of
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d08a6ee23ac5..41b34f01416f 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -54,6 +54,7 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
>   	sbi->lz4.max_distance_pages = distance ?
>   					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
>   					LZ4_MAX_DISTANCE_PAGES;
> +	erofs_global_page_pool_init();
>   	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
>   }
>   
> @@ -111,15 +112,42 @@ static int z_erofs_lz4_prepare_dstpages(struct z_erofs_lz4_decompress_ctx *ctx,
>   			victim = availables[--top];
>   			get_page(victim);
>   		} else {
> -			victim = erofs_allocpage(pagepool,
> +			victim = erofs_allocpage_for_decmpr(pagepool,
>   						 GFP_KERNEL | __GFP_NOFAIL);
For each read request, the extreme case here will be 15 pages
for 64k LZ4 sliding window (60k = 64k-4k). You could reduce
LZ4 sliding window to save more pages with slight compression
ratio loss.

Or, here __GFP_NOFAIL is actually unnecessary since we could
bail out this if allocation failed for all readahead requests
and only address __read requests__.   I have some plan to do
this but it's too close to the next merge window.  So I was
once to work this out for Linux 6.9.

Anyway, I'm not saying mempool is not a good idea, but I tend
to reserve memory as less as possible if there are some other
way to mitigate the same workload since reserving memory is
not free (which means 1 MiB memory will be only used for this.)
Even we will do a mempool, I wonder if we could unify pcpubuf
and mempool together to make a better pool.

IMHO, maybe we could do some analysis on your workload first
and think how to do this next.

Thanks,
Gao Xiang
