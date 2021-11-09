Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A744A544
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 04:17:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpCnx1Lcwz2yPq
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 14:17:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpCnt1Yrvz2xKK
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 14:17:05 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0Uvj108s_1636427808; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uvj108s_1636427808) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 09 Nov 2021 11:16:49 +0800
Date: Tue, 9 Nov 2021 11:16:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH 2/2] erofs: add sysfs node to control sync decompression
 strategy
Message-ID: <YYnoHw+boVFtcyfv@B-P7TQMD6M-0146.local>
References: <20211109025445.12427-1-huangjianan@oppo.com>
 <20211109025445.12427-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109025445.12427-2-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 09, 2021 at 10:54:45AM +0800, Huang Jianan via Linux-erofs wrote:
> Although readpage is a synchronous path, there will be no additional
> kworker scheduling overhead in non-atomic contexts. So we can add a
> sysfs node to allow disable sync decompression.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/erofs/internal.h | 2 +-
>  fs/erofs/super.c    | 2 +-
>  fs/erofs/sysfs.c    | 6 ++++++
>  fs/erofs/zdata.c    | 9 ++++-----
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index d0cd712dc222..1ab96878009d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -60,7 +60,7 @@ struct erofs_mount_opts {
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	/* current strategy of how to use managed cache */
>  	unsigned char cache_strategy;
> -	/* strategy of sync decompression (false - auto, true - force on) */
> +	/* strategy of sync decompression (false - disable, true - force on) */

Please leave false - auto.

>  	bool readahead_sync_decompress;
>  
>  	/* threshold for decompression synchronously */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index abc1da5d1719..26585d865503 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>  	ctx->opt.max_sync_decompress_pages = 3;
> -	ctx->opt.readahead_sync_decompress = false;
> +	ctx->opt.readahead_sync_decompress = true;

Please leave readahead_sync_decompress = false 'auto' by default.

I don't like .readpage() applies async decompression since it's
actually a sync way, otherwise, it will cause more scheduling
overhead, see:
https://lore.kernel.org/r/20201016160443.18685-1-willy@infradead.org
https://lore.kernel.org/r/20201102184312.25926-16-willy@infradead.org

Thanks,
Gao Xiang
