Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB992575CC5
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 09:52:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lkk8p5hnpz3c4r
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LYsf9Xbf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LYsf9Xbf;
	dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lkk8h4zXgz3by2
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 17:52:02 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id e16so3994582pfm.11
        for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=at1d9rp4s19kXJ0EYSw6JgJl62gYpx4sN3jQfQIiovc=;
        b=LYsf9Xbf+L8oxuv26fH95NuHkxoYE+NTpsA0yA9ixEOBLupuJ7XLFQ32+fNX0iRw3N
         mazMszzIh7vyw+JgsgagfnrMRzkuMEfAiHoDjm2oVdKn/rGLGJUU98Ydudu2wJtRvqdN
         9WqWoPtg5icNhbZtWNB/qBI1XeeXt9IPnje+KpINUszFw4drAFlaCYWuS1T29b+PpCZ2
         LzsVUV8o6OKhwmu6Uwi5/jhgX16X3AM1SfFV2BUOltLUE3z9eyGKdbaEEP5s0vno1rnv
         jpf/F5ohqoY9Z09gI/374APO5uDDzhdPPoSvYqpOXyjnrco4/nKzlKmHZTWYVK0aoBMq
         g/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at1d9rp4s19kXJ0EYSw6JgJl62gYpx4sN3jQfQIiovc=;
        b=Q1HYmwk73g1OsVeJuHO+MRq+ssck8laRVnv6N9oEn9t0uj5h4wwVe8Ti26YNfAzkSY
         1NVWjdvaMP97LMMrWuFh2YFpD4h+2VeY5yLVrli30h5r6ZNV8n5ZXDlToJ+UGwRlcvDE
         xtOOXGZ2DxQycUeyF4/MZLEbEd/ZnRBAr/5+1vCFz0+IkprvxVPqJMUtiABT43j4jxd2
         ZK45yrTFhqI8f9+dhSqN7NhzbGZTd8hdRYu592niDpXHh0qxTEwtS+4qFMRtEc5Kt5ZW
         s939eUtPOuMroTm/ScaiLwQkkbMzlPm+1ItSn0olHlsVgqeDqZtMC9lsz1VOZw13ZPQb
         c0BA==
X-Gm-Message-State: AJIora/PjaTl+hW5aVuPQ4CakaYU41BDJPKoL2SDfzXtgNw4+ipwrXq5
	PqTb/XepQfJIIjQk8rNJc30=
X-Google-Smtp-Source: AGRyM1u30SiiUoMtAYl12/KiykEE8kau+Ucm/Km1h7aN0ep8fQLRj9B3T/fOhWjC7b1UWwBl5WN7vQ==
X-Received: by 2002:a63:710c:0:b0:40c:adcf:ce72 with SMTP id m12-20020a63710c000000b0040cadcfce72mr11447450pgc.310.1657871520526;
        Fri, 15 Jul 2022 00:52:00 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090aad0500b001ec84049064sm2740051pjq.41.2022.07.15.00.51.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 00:52:00 -0700 (PDT)
Date: Fri, 15 Jul 2022 15:53:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 07/16] erofs: switch compressed_pages[] to bufvec
Message-ID: <20220715155323.00005df4.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-8-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
	<20220714132051.46012-8-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 14 Jul 2022 21:20:42 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Convert compressed_pages[] to bufvec in order to avoid using
> page->private to keep onlinepage_index (decompressed offset)
> for inplace I/O pages.
> 
> In the future, we only rely on folio->private to keep a countdown
> to unlock folios and set folio_uptodate.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
>  fs/erofs/zdata.h |   4 +-
>  2 files changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 757d352bc2c7..f2e3f07baad7 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -134,7 +134,7 @@ static int z_erofs_create_pcluster_pool(void)
>  
>  	for (pcs = pcluster_pool;
>  	     pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
> -		size = struct_size(a, compressed_pages, pcs->maxpages);
> +		size = struct_size(a, compressed_bvecs, pcs->maxpages);
>  
>  		sprintf(pcs->name, "erofs_pcluster-%u", pcs->maxpages);
>  		pcs->slab = kmem_cache_create(pcs->name, size, 0,
> @@ -287,16 +287,16 @@ struct z_erofs_decompress_frontend {
>  
>  	struct page *candidate_bvpage;
>  	struct z_erofs_pcluster *pcl, *tailpcl;
> -	/* a pointer used to pick up inplace I/O pages */
> -	struct page **icpage_ptr;
>  	z_erofs_next_pcluster_t owned_head;
> -
>  	enum z_erofs_collectmode mode;
>  
>  	bool readahead;
>  	/* used for applying cache strategy on the fly */
>  	bool backmost;
>  	erofs_off_t headoffset;
> +
> +	/* a pointer used to pick up inplace I/O pages */
> +	unsigned int icur;

not a pointer?

>  };
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
> @@ -319,24 +319,21 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
>  	 */
>  	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> -	struct page **pages;
> -	pgoff_t index;
> +	unsigned int i;
>  
>  	if (fe->mode < COLLECT_PRIMARY_FOLLOWED)
>  		return;
>  
> -	pages = pcl->compressed_pages;
> -	index = pcl->obj.index;
> -	for (; index < pcl->obj.index + pcl->pclusterpages; ++index, ++pages) {
> +	for (i = 0; i < pcl->pclusterpages; ++i) {
>  		struct page *page;
>  		compressed_page_t t;
>  		struct page *newpage = NULL;
>  
>  		/* the compressed page was loaded before */
> -		if (READ_ONCE(*pages))
> +		if (READ_ONCE(pcl->compressed_bvecs[i].page))
>  			continue;
>  
> -		page = find_get_page(mc, index);
> +		page = find_get_page(mc, pcl->obj.index + i);
>  
>  		if (page) {
>  			t = tag_compressed_page_justfound(page);
> @@ -357,7 +354,8 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
>  			}
>  		}
>  
> -		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
> +		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL,
> +				     tagptr_cast_ptr(t)))
>  			continue;
>  
>  		if (page)
> @@ -388,7 +386,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>  	 * therefore no need to worry about available decompression users.
>  	 */
>  	for (i = 0; i < pcl->pclusterpages; ++i) {
> -		struct page *page = pcl->compressed_pages[i];
> +		struct page *page = pcl->compressed_bvecs[i].page;
>  
>  		if (!page)
>  			continue;
> @@ -401,7 +399,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>  			continue;
>  
>  		/* barrier is implied in the following 'unlock_page' */
> -		WRITE_ONCE(pcl->compressed_pages[i], NULL);
> +		WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
>  		detach_page_private(page);
>  		unlock_page(page);
>  	}
> @@ -411,36 +409,39 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>  int erofs_try_to_free_cached_page(struct page *page)
>  {
>  	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
> -	int ret = 0;	/* 0 - busy */
> +	int ret, i;
>  
> -	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
> -		unsigned int i;
> +	if (!erofs_workgroup_try_to_freeze(&pcl->obj, 1))
> +		return 0;
>  
> -		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> -		for (i = 0; i < pcl->pclusterpages; ++i) {
> -			if (pcl->compressed_pages[i] == page) {
> -				WRITE_ONCE(pcl->compressed_pages[i], NULL);
> -				ret = 1;
> -				break;
> -			}
> +	ret = 0;
> +	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> +	for (i = 0; i < pcl->pclusterpages; ++i) {
> +		if (pcl->compressed_bvecs[i].page == page) {
> +			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
> +			ret = 1;
> +			break;
>  		}
> -		erofs_workgroup_unfreeze(&pcl->obj, 1);
> -
> -		if (ret)
> -			detach_page_private(page);
>  	}
> +	erofs_workgroup_unfreeze(&pcl->obj, 1);
> +	if (ret)
> +		detach_page_private(page);
>  	return ret;
>  }
>  
>  /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
>  static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> -				   struct page *page)
> +				   struct z_erofs_bvec *bvec)
>  {
>  	struct z_erofs_pcluster *const pcl = fe->pcl;
>  
> -	while (fe->icpage_ptr > pcl->compressed_pages)
> -		if (!cmpxchg(--fe->icpage_ptr, NULL, page))
> +	while (fe->icur > 0) {
> +		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> +			     NULL, bvec->page)) {
> +			pcl->compressed_bvecs[fe->icur] = *bvec;
>  			return true;
> +		}
> +	}
>  	return false;
>  }
>  
> @@ -454,7 +455,7 @@ static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>  	if (fe->mode >= COLLECT_PRIMARY &&
>  	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
>  		/* give priority for inplaceio to use file pages first */
> -		if (z_erofs_try_inplace_io(fe, bvec->page))
> +		if (z_erofs_try_inplace_io(fe, bvec))
>  			return 0;
>  		/* otherwise, check if it can be used as a bvpage */
>  		if (fe->mode >= COLLECT_PRIMARY_FOLLOWED &&
> @@ -648,8 +649,7 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>  				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */
> -	fe->icpage_ptr = fe->pcl->compressed_pages +
> -			z_erofs_pclusterpages(fe->pcl);
> +	fe->icur = z_erofs_pclusterpages(fe->pcl);
>  	return 0;
>  }
>  
> @@ -769,7 +769,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  			goto err_out;
>  		}
>  		get_page(fe->map.buf.page);
> -		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
> +		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
> +			   fe->map.buf.page);
>  		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  	} else {
>  		/* bind cache first when cached decompression is preferred */
> @@ -927,8 +928,9 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
>  	*overlapped = false;
>  
>  	for (i = 0; i < pclusterpages; ++i) {
> -		unsigned int pagenr;
> -		struct page *page = pcl->compressed_pages[i];
> +		struct z_erofs_bvec *bvec = &pcl->compressed_bvecs[i];
> +		struct page *page = bvec->page;
> +		unsigned int pgnr;
>  
>  		/* compressed pages ought to be present before decompressing */
>  		if (!page) {
> @@ -951,21 +953,15 @@ static struct page **z_erofs_parse_in_bvecs(struct erofs_sb_info *sbi,
>  				continue;
>  			}
>  
> -			/*
> -			 * only if non-head page can be selected
> -			 * for inplace decompression
> -			 */
> -			pagenr = z_erofs_onlinepage_index(page);
> -
> -			DBG_BUGON(pagenr >= pcl->nr_pages);
> -			if (pages[pagenr]) {
> +			pgnr = (bvec->offset + pcl->pageofs_out) >> PAGE_SHIFT;
> +			DBG_BUGON(pgnr >= pcl->nr_pages);
> +			if (pages[pgnr]) {
>  				DBG_BUGON(1);
> -				SetPageError(pages[pagenr]);
> -				z_erofs_onlinepage_endio(pages[pagenr]);
> +				SetPageError(pages[pgnr]);
> +				z_erofs_onlinepage_endio(pages[pgnr]);
>  				err = -EFSCORRUPTED;
>  			}
> -			pages[pagenr] = page;
> -
> +			pages[pgnr] = page;
>  			*overlapped = true;
>  		}
>  
> @@ -1067,19 +1063,19 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  out:
>  	/* must handle all compressed pages before actual file pages */
>  	if (z_erofs_is_inline_pcluster(pcl)) {
> -		page = pcl->compressed_pages[0];
> -		WRITE_ONCE(pcl->compressed_pages[0], NULL);
> +		page = pcl->compressed_bvecs[0].page;
> +		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
>  		put_page(page);
>  	} else {
>  		for (i = 0; i < pclusterpages; ++i) {
> -			page = pcl->compressed_pages[i];
> +			page = pcl->compressed_bvecs[i].page;
>  
>  			if (erofs_page_is_managed(sbi, page))
>  				continue;
>  
>  			/* recycle all individual short-lived pages */
>  			(void)z_erofs_put_shortlivedpage(pagepool, page);
> -			WRITE_ONCE(pcl->compressed_pages[i], NULL);
> +			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
>  		}
>  	}
>  	kfree(compressed_pages);
> @@ -1193,7 +1189,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  	int justfound;
>  
>  repeat:
> -	page = READ_ONCE(pcl->compressed_pages[nr]);
> +	page = READ_ONCE(pcl->compressed_bvecs[nr].page);
>  	oldpage = page;
>  
>  	if (!page)
> @@ -1209,7 +1205,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  	 * otherwise, it will go inplace I/O path instead.
>  	 */
>  	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> -		WRITE_ONCE(pcl->compressed_pages[nr], page);
> +		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
>  		set_page_private(page, 0);
>  		tocache = true;
>  		goto out_tocache;
> @@ -1235,14 +1231,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  
>  	/* the page is still in manage cache */
>  	if (page->mapping == mc) {
> -		WRITE_ONCE(pcl->compressed_pages[nr], page);
> +		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
>  
>  		ClearPageError(page);
>  		if (!PagePrivate(page)) {
>  			/*
>  			 * impossible to be !PagePrivate(page) for
>  			 * the current restriction as well if
> -			 * the page is already in compressed_pages[].
> +			 * the page is already in compressed_bvecs[].
>  			 */
>  			DBG_BUGON(!justfound);
>  
> @@ -1271,7 +1267,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
>  	put_page(page);
>  out_allocpage:
>  	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
> -	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
> +	if (oldpage != cmpxchg(&pcl->compressed_bvecs[nr].page,
> +			       oldpage, page)) {
>  		erofs_pagepool_add(pagepool, page);
>  		cond_resched();
>  		goto repeat;
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index a755c5a44d87..a70f1b73e901 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -87,8 +87,8 @@ struct z_erofs_pcluster {
>  	/* I: compression algorithm format */
>  	unsigned char algorithmformat;
>  
> -	/* A: compressed pages (can be cached or inplaced pages) */
> -	struct page *compressed_pages[];
> +	/* A: compressed bvecs (can be cached or inplaced pages) */
> +	struct z_erofs_bvec compressed_bvecs[];
>  };
>  
>  /* let's avoid the valid 32-bit kernel addresses */

