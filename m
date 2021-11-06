Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C3446E0D
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Nov 2021 14:27:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HmdTg1l7Rz2yS3
	for <lists+linux-erofs@lfdr.de>; Sun,  7 Nov 2021 00:27:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HmdTb0vDWz2xtN
 for <linux-erofs@lists.ozlabs.org>; Sun,  7 Nov 2021 00:27:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UvIHVwt_1636205234; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UvIHVwt_1636205234) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 06 Nov 2021 21:27:16 +0800
Date: Sat, 6 Nov 2021 21:27:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@yulong.com>
Subject: Re: [PATCH v2] erofs: remove useless cache strategy of DELAYEDALLOC
Message-ID: <YYaCr9YgK1I91MXX@B-P7TQMD6M-0146.local>
References: <20211106082315.25781-1-huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106082315.25781-1-huyue2@yulong.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 geshifei@yulong.com, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Sat, Nov 06, 2021 at 04:23:15PM +0800, Yue Hu wrote:
> DELAYEDALLOC is not used at all, remove related dead code. Also,
> remove the blank line at the end of zdata.h.

I'll update the commit message to:

After commit 1825c8d7ce93 ("erofs: force inplace I/O under low
memory scenario") and TRYALLOC is widely used, DELAYEDALLOC won't
be used anymore. Remove related dead code. Also, remove the blank
line at the end of zdata.h.

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2: remove the blank line at the end of zdata.h.
> 
>  fs/erofs/zdata.c | 20 --------------------
>  fs/erofs/zdata.h |  1 -
>  2 files changed, 21 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index bcb1b91b234f..812c7c6ae456 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -96,16 +96,9 @@ static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
>  	DBG_BUGON(1);
>  }
>  
> -/*
> - * a compressed_pages[] placeholder in order to avoid
> - * being filled with file pages for in-place decompression.
> - */
> -#define PAGE_UNALLOCATED     ((void *)0x5F0E4B1D)
> -
>  /* how to allocate cached pages for a pcluster */
>  enum z_erofs_cache_alloctype {
>  	DONTALLOC,	/* don't allocate any cached pages */
> -	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
>  	/*
>  	 * try to use cached I/O if page allocation succeeds or fallback
>  	 * to in-place I/O instead to avoid any direct reclaim.
> @@ -267,10 +260,6 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>  			/* I/O is needed, no possible to decompress directly */
>  			standalone = false;
>  			switch (type) {
> -			case DELAYEDALLOC:
> -				t = tagptr_init(compressed_page_t,
> -						PAGE_UNALLOCATED);
> -				break;
>  			case TRYALLOC:
>  				newpage = erofs_allocpage(pagepool, gfp);
>  				if (!newpage)
> @@ -1089,15 +1078,6 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  	if (!page)
>  		goto out_allocpage;
>  
> -	/*
> -	 * the cached page has not been allocated and
> -	 * an placeholder is out there, prepare it now.
> -	 */
> -	if (page == PAGE_UNALLOCATED) {
> -		tocache = true;
> -		goto out_allocpage;
> -	}
> -
>  	/* process the target tagged pointer */
>  	t = tagptr_init(compressed_page_t, page);
>  	justfound = tagptr_unfold_tags(t);
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index 879df5362777..4a69515dea75 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -179,4 +179,3 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
>  #define Z_EROFS_VMAP_GLOBAL_PAGES	2048
>  
>  #endif
> -
> -- 
> 2.17.1
> 
> 
