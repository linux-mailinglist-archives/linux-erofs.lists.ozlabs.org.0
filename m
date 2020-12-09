Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33552D3F84
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 11:07:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrXmB1SS4zDqpk
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 21:07:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrXlz53GnzDqn4
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 21:07:21 +1100 (AEDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CrXl40Bz5zhnGq;
 Wed,  9 Dec 2020 18:06:40 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 18:07:09 +0800
Subject: Re: [PATCH] erofs: force inplace I/O under low memory scenario
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>
References: <20201208054600.16302-1-hsiangkao.ref@aol.com>
 <20201208054600.16302-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <85f41db3-8d64-240a-7876-9f3b3dea29cb@huawei.com>
Date: Wed, 9 Dec 2020 18:07:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201208054600.16302-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/12/8 13:46, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Try to forcely switch to inplace I/O under low memory scenario in
> order to avoid direct memory reclaim due to cached page allocation.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> This was commercially used internally for years, but due to customized
> page->mapping before, it cannot cleanly upstream till now. Since magical
> page->mapping is now gone, adapt this to the latest dev branch for
> better low-memory performance (fully use inplace I/O instead.)
> 
>   fs/erofs/compress.h |  3 +++
>   fs/erofs/zdata.c    | 49 +++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> index 2bbf47f353ef..c51a741a1232 100644
> --- a/fs/erofs/compress.h
> +++ b/fs/erofs/compress.h
> @@ -27,11 +27,13 @@ struct z_erofs_decompress_req {
>   };
>   
>   #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
> +#define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
>   
>   /*
>    * For all pages in a pcluster, page->private should be one of
>    * Type                         Last 2bits      page->private
>    * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
> + * preallocated page (tryalloc) 00              Z_EROFS_PREALLOCATED_PAGE
>    * cached/managed page          00              pointer to z_erofs_pcluster
>    * online page (file-backed,    01/10/11        sub-index << 2 | count
>    *              some pages can be used for inplace I/O)
> @@ -39,6 +41,7 @@ struct z_erofs_decompress_req {
>    * page->mapping should be one of
>    * Type                 page->mapping
>    * short-lived page     NULL
> + * preallocated page    NULL
>    * cached/managed page  non-NULL or NULL (invalidated/truncated page)
>    * online page          non-NULL
>    *
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index b1b6cd03046f..b84e6a2fb00c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -20,6 +20,11 @@
>   enum z_erofs_cache_alloctype {
>   	DONTALLOC,	/* don't allocate any cached pages */
>   	DELAYEDALLOC,	/* delayed allocation (at the time of submitting io) */
> +	/*
> +	 * try to use cached I/O if page allocation succeeds or fallback
> +	 * to in-place I/O instead to avoid any direct reclaim.
> +	 */
> +	TRYALLOC,
>   };
>   
>   /*
> @@ -154,13 +159,15 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
>   
>   static void preload_compressed_pages(struct z_erofs_collector *clt,
>   				     struct address_space *mc,
> -				     enum z_erofs_cache_alloctype type)
> +				     enum z_erofs_cache_alloctype type,
> +				     struct list_head *pagepool)
>   {
>   	const struct z_erofs_pcluster *pcl = clt->pcl;
>   	const unsigned int clusterpages = BIT(pcl->clusterbits);
>   	struct page **pages = clt->compressedpages;
>   	pgoff_t index = pcl->obj.index + (pages - pcl->compressed_pages);
>   	bool standalone = true;
> +	gfp_t gfp = mapping_gfp_constraint(mc, GFP_KERNEL) & ~__GFP_DIRECT_RECLAIM;

Could be local as there is only one place uses it.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   
>   	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
>   		return;
> @@ -168,6 +175,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>   	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
>   		struct page *page;
>   		compressed_page_t t;
> +		struct page *newpage = NULL;
>   
>   		/* the compressed page was loaded before */
>   		if (READ_ONCE(*pages))
> @@ -179,7 +187,17 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>   			t = tag_compressed_page_justfound(page);
>   		} else if (type == DELAYEDALLOC) {
>   			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
> +		} else if (type == TRYALLOC) {
> +			gfp |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> +
> +			newpage = erofs_allocpage(pagepool, gfp);
> +			if (!newpage)
> +				goto dontalloc;
> +
> +			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
> +			t = tag_compressed_page_justfound(newpage);
>   		} else {	/* DONTALLOC */
> +dontalloc:
>   			if (standalone)
>   				clt->compressedpages = pages;
>   			standalone = false;
> @@ -189,8 +207,12 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>   		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
>   			continue;
>   
> -		if (page)
> +		if (page) {
>   			put_page(page);
> +		} else if (newpage) {
> +			set_page_private(newpage, 0);
> +			list_add(&newpage->lru, pagepool);
> +		}
>   	}
>   
>   	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
> @@ -560,7 +582,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
>   }
>   
>   static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> -				struct page *page)
> +				struct page *page, struct list_head *pagepool)
>   {
>   	struct inode *const inode = fe->inode;
>   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> @@ -613,11 +635,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   
>   	/* preload all compressed pages (maybe downgrade role if necessary) */
>   	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
> -		cache_strategy = DELAYEDALLOC;
> +		cache_strategy = TRYALLOC;
>   	else
>   		cache_strategy = DONTALLOC;
>   
> -	preload_compressed_pages(clt, MNGD_MAPPING(sbi), cache_strategy);
> +	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> +				 cache_strategy, pagepool);
>   
>   hitted:
>   	/*
> @@ -1011,6 +1034,16 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>   	justfound = tagptr_unfold_tags(t);
>   	page = tagptr_unfold_ptr(t);
>   
> +	/*
> +	 * preallocated cached pages, which is used to avoid direct reclaim
> +	 * otherwise, it will go inplace I/O path instead.
> +	 */
> +	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> +		WRITE_ONCE(pcl->compressed_pages[nr], page);
> +		set_page_private(page, 0);
> +		tocache = true;
> +		goto out_tocache;
> +	}
>   	mapping = READ_ONCE(page->mapping);
>   
>   	/*
> @@ -1073,7 +1106,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>   		cond_resched();
>   		goto repeat;
>   	}
> -
> +out_tocache:
>   	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
>   		/* turn into temporary page if fails */
>   		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> @@ -1282,7 +1315,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
>   
>   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
>   
> -	err = z_erofs_do_read_page(&f, page);
> +	err = z_erofs_do_read_page(&f, page, &pagepool);
>   	(void)z_erofs_collector_end(&f.clt);
>   
>   	/* if some compressed cluster ready, need submit them anyway */
> @@ -1336,7 +1369,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>   		/* traversal in reverse order */
>   		head = (void *)page_private(page);
>   
> -		err = z_erofs_do_read_page(&f, page);
> +		err = z_erofs_do_read_page(&f, page, &pagepool);
>   		if (err)
>   			erofs_err(inode->i_sb,
>   				  "readahead error at page %lu @ nid %llu",
> 
