Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB833CFCF
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 09:26:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F05x80SlMz2xgN
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Mar 2021 19:26:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F05x50XRjz2y0N
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Mar 2021 19:26:45 +1100 (AEDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F05tl6x8Zz17Lxp;
 Tue, 16 Mar 2021 16:24:47 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 16 Mar
 2021 16:26:38 +0800
Subject: Re: [PATCH v6 2/2] erofs: decompress in endio if possible
To: Huang Jianan <huangjianan@oppo.com>, <linux-erofs@lists.ozlabs.org>
References: <20210316031515.90954-1-huangjianan@oppo.com>
 <20210316031515.90954-2-huangjianan@oppo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <cb51e5de-bfb9-509d-e165-243157404cb9@huawei.com>
Date: Tue, 16 Mar 2021 16:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210316031515.90954-2-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On 2021/3/16 11:15, Huang Jianan via Linux-erofs wrote:
> z_erofs_decompressqueue_endio may not be executed in the atomic
> context, for example, when dm-verity is turned on. In this scenario,
> data can be decompressed directly to get rid of additional kworker
> scheduling overhead. Also, it makes no sense to apply synchronous
> decompression for such case.

It looks this patch does more than one things:
- combine dm-verity and erofs workqueue
- change policy of decompression in context of thread

Normally, we do one thing in one patch, by this way, we will be benefit in
scenario of when backporting patches and bisecting problematic patch with
minimum granularity, and also it will help reviewer to focus on reviewing
single code logic by following patch's goal.

So IMO, it would be better to separate this patch into two.

One more thing is could you explain a little bit more about why we need to
change policy of decompression in context of thread? for better performance?

BTW, code looks clean to me. :)

Thanks,

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> ---
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    |  1 +
>   fs/erofs/zdata.c    | 15 +++++++++++++--
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 67a7ec945686..fbc4040715be 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -50,6 +50,8 @@ struct erofs_fs_context {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	/* current strategy of how to use managed cache */
>   	unsigned char cache_strategy;
> +	/* strategy of sync decompression (false - auto, true - force on) */
> +	bool readahead_sync_decompress;
>   
>   	/* threshold for decompression synchronously */
>   	unsigned int max_sync_decompress_pages;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d5a6b9b888a5..0445d09b6331 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -200,6 +200,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	ctx->cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>   	ctx->max_sync_decompress_pages = 3;
> +	ctx->readahead_sync_decompress = false;
>   #endif
>   #ifdef CONFIG_EROFS_FS_XATTR
>   	set_opt(ctx, XATTR_USER);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6cb356c4217b..25a0c4890d0a 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -706,9 +706,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   	goto out;
>   }
>   
> +static void z_erofs_decompressqueue_work(struct work_struct *work);
>   static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   				       bool sync, int bios)
>   {
> +	struct erofs_sb_info *const sbi = EROFS_SB(io->sb);
> +
>   	/* wake up the caller thread for sync decompression */
>   	if (sync) {
>   		unsigned long flags;
> @@ -720,8 +723,15 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>   		return;
>   	}
>   
> -	if (!atomic_add_return(bios, &io->pending_bios))
> +	if (atomic_add_return(bios, &io->pending_bios))
> +		return;
> +	/* Use workqueue and sync decompression for atomic contexts only */
> +	if (in_atomic() || irqs_disabled()) {
>   		queue_work(z_erofs_workqueue, &io->u.work);
> +		sbi->ctx.readahead_sync_decompress = true;
> +		return;
> +	}
> +	z_erofs_decompressqueue_work(&io->u.work);
>   }
>   
>   static bool z_erofs_page_is_invalidated(struct page *page)
> @@ -1333,7 +1343,8 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>   
>   	unsigned int nr_pages = readahead_count(rac);
> -	bool sync = (nr_pages <= sbi->ctx.max_sync_decompress_pages);
> +	bool sync = (sbi->ctx.readahead_sync_decompress &&
> +			nr_pages <= sbi->ctx.max_sync_decompress_pages);
>   	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
>   	struct page *page, *head = NULL;
>   	LIST_HEAD(pagepool);
> 
