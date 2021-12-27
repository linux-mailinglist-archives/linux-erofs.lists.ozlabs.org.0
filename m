Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179E47FAFD
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 09:21:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMrGj360Wz2yw1
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 19:21:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iuJ6eiEC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=iuJ6eiEC; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMrGc53mcz2xBT
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 19:21:10 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id w7so10399158plp.13
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k8dYywQL1ixZoQCcfvpwhTmEgtVTnKccni+YzM2KWAQ=;
 b=iuJ6eiECHN9XJwLKqqO15+z0+1WczQjF2onToV7l6ad9hBTe4mCFgs6fvJnf3T4Jdz
 VHZrqiXsCKdlta7LFtplsro2fGRngkzuZcrrsSVk/kbTE3RpV9JWuufx6RxXceYQ8a3K
 1Oj0VDTTGsJ4bkI0OE0tM+jkUw2YKjAsJlC3Sc6HlYhGJWZLWx1Zeg+XkueBRhehVjBS
 pfHOTt2hexXvatHNJTQkpKdbZ2gqwFfBuKjCDYQsBqudju3eFlytrdY9ORDZ1iLhJjSG
 uC0/wlygDSMQoThpPxBbp/suZ4mP2gWdK5cfge+BQmaiQvbnbBuFVeIkcKNSTVCtF9l4
 OaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k8dYywQL1ixZoQCcfvpwhTmEgtVTnKccni+YzM2KWAQ=;
 b=yHjIw9lMe0CifQd5s3SIJ2V1PBhi7Hq5SPCG+4X2PH21KCGl82mf7K2MAfbuhMs04l
 dSsmOgK7UJ5GuNGKfOlqOGNmJ0i/nJzTewu2NWqpUye0SdDJCd+AFBmImJfE/Tjj7el/
 qdW9diRLVt1rDGsVR0B0VjLhIq+GffQXeFCJSTPO3fLwj3rrPPUESn138YxaC34+AgTj
 XeCmCC+qLevrFuB5hF4o6kstBWRQH3scMq29fpuJ2WjP7l2MpZvtjyihuatFz/rdbxyC
 5krMpmUJwbrjmSEoCEnvNxTJOID1KgbUn9xefM4xAWF6PSM9xKtKcce3vmjPhc4ibfc9
 lOtQ==
X-Gm-Message-State: AOAM530iAGCIGBDs01Js5HyXSxGRMLiQWdKeNrLT90Rg/m5IktO64CRv
 Pg77XVjt7Ks9JjpEaMJRIss=
X-Google-Smtp-Source: ABdhPJwJ+Z46175LXE1wrDecBOZbe6H3FcnahCdgy6vfTpJq3zxBVvm7T5BKJfSKb2vfGq0aoh4+Gg==
X-Received: by 2002:a17:90a:c253:: with SMTP id
 d19mr19806746pjx.157.1640593267798; 
 Mon, 27 Dec 2021 00:21:07 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p10sm16301300pfw.87.2021.12.27.00.21.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Dec 2021 00:21:07 -0800 (PST)
Date: Mon, 27 Dec 2021 16:18:19 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3 4/5] erofs: support inline data decompression
Message-ID: <20211227161819.00000148.zbestahu@gmail.com>
In-Reply-To: <20211225070626.74080-5-hsiangkao@linux.alibaba.com>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-5-hsiangkao@linux.alibaba.com>
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
Cc: geshifei@coolpad.com, LKML <linux-kernel@vger.kernel.org>,
 zhangwen@coolpad.com, Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Sat, 25 Dec 2021 15:06:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, we have already support tail-packing inline for
> uncompressed file, let's also implement this for compressed
> files to save I/Os and storage space.
> 
> Different from normal pclusters, compressed data is available
> in advance because of other metadata I/Os. Therefore, they
> directly move into the bypass queue without extra I/O submission.
> 
> It's the last compression feature before folio/subpage support.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 128 ++++++++++++++++++++++++++++++++---------------
>  fs/erofs/zdata.h |  24 ++++++++-
>  2 files changed, 109 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index bc765d8a6dc2..e6ef02634e08 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -82,12 +82,13 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
>  
>  static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
>  {
> +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
>  		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
>  
> -		if (pcl->pclusterpages > pcs->maxpages)
> +		if (pclusterpages > pcs->maxpages)
>  			continue;
>  
>  		kmem_cache_free(pcs->slab, pcl);
> @@ -298,6 +299,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>  		container_of(grp, struct z_erofs_pcluster, obj);
>  	int i;
>  
> +	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
>  	/*
>  	 * refcount of workgroup is now freezed as 1,
>  	 * therefore no need to worry about available decompression users.
> @@ -331,6 +333,7 @@ int erofs_try_to_free_cached_page(struct page *page)
>  	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
>  		unsigned int i;
>  
> +		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
>  		for (i = 0; i < pcl->pclusterpages; ++i) {
>  			if (pcl->compressed_pages[i] == page) {
>  				WRITE_ONCE(pcl->compressed_pages[i], NULL);
> @@ -458,6 +461,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  				       struct inode *inode,
>  				       struct erofs_map_blocks *map)
>  {
> +	bool ztailpacking = map->m_flags & EROFS_MAP_META;
>  	struct z_erofs_pcluster *pcl;
>  	struct z_erofs_collection *cl;
>  	struct erofs_workgroup *grp;
> @@ -469,12 +473,12 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  	}
>  
>  	/* no available pcluster, let's allocate one */
> -	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
> +	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
> +				     map->m_plen >> PAGE_SHIFT);
>  	if (IS_ERR(pcl))
>  		return PTR_ERR(pcl);
>  
>  	atomic_set(&pcl->obj.refcount, 1);
> -	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
>  	pcl->algorithmformat = map->m_algorithmformat;
>  	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
>  		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
> @@ -494,16 +498,25 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  	mutex_init(&cl->lock);
>  	DBG_BUGON(!mutex_trylock(&cl->lock));
>  
> -	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> -	if (IS_ERR(grp)) {
> -		err = PTR_ERR(grp);
> -		goto err_out;
> -	}
> +	if (ztailpacking) {
> +		pcl->obj.index = 0;	/* which indicates ztailpacking */
> +		pcl->pageofs_in = erofs_blkoff(map->m_pa);
> +		pcl->tailpacking_size = map->m_plen;
> +	} else {
> +		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
>  
> -	if (grp != &pcl->obj) {
> -		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> -		err = -EEXIST;
> -		goto err_out;
> +		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> +		if (IS_ERR(grp)) {
> +			err = PTR_ERR(grp);
> +			goto err_out;
> +		}
> +
> +		if (grp != &pcl->obj) {
> +			clt->pcl = container_of(grp,
> +					struct z_erofs_pcluster, obj);
> +			err = -EEXIST;
> +			goto err_out;
> +		}
>  	}
>  	/* used to check tail merging loop due to corrupted images */
>  	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> @@ -532,17 +545,20 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
>  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
>  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
>  
> -	if (!PAGE_ALIGNED(map->m_pa)) {
> -		DBG_BUGON(1);
> -		return -EINVAL;
> +	if (map->m_flags & EROFS_MAP_META) {
> +		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> +			DBG_BUGON(1);
> +			return -EFSCORRUPTED;
> +		}
> +		goto tailpacking;
>  	}
>  
>  	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
>  		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
>  	} else {
> +tailpacking:
>  		ret = z_erofs_register_collection(clt, inode, map);
> -
>  		if (!ret)
>  			goto out;
>  		if (ret != -EEXIST)
> @@ -558,9 +574,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
>  out:
>  	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
>  				  clt->cl->pagevec, clt->cl->vcnt);
> -
>  	/* since file-backed online pages are traversed in reverse order */
> -	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
> +	clt->icpage_ptr = clt->pcl->compressed_pages +
> +			z_erofs_pclusterpages(clt->pcl);
>  	return 0;
>  }
>  
> @@ -687,8 +703,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	else
>  		cache_strategy = DONTALLOC;
>  
> -	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> -				 cache_strategy, pagepool);
> +	if (z_erofs_is_inline_pcluster(clt->pcl)) {

current cache_strategy is only for preload_compressed_pages(), so the cache_strategy should be
needless for inline branch.

> +		struct page *mpage;
> +
> +		mpage = erofs_get_meta_page(inode->i_sb,
> +					    erofs_blknr(map->m_pa));

could we just use the map->mpage directly if it's what we want(which is the most cases when test),
if not we erofs_get_meta_page()?

> +		if (IS_ERR(mpage)) {
> +			err = PTR_ERR(mpage);
> +			erofs_err(inode->i_sb,
> +				  "failed to get inline page, err %d", err);
> +			goto err_out;
> +		}
> +		/* TODO: new subpage feature will get rid of it */
> +		unlock_page(mpage);
> +
> +		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> +		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> +	} else {
> +		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> +					 cache_strategy, pagepool);
> +	}
>  
>  hitted:
>  	/*
> @@ -844,6 +878,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct page **pagepool)
>  {
>  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
>  	struct z_erofs_pagevec_ctor ctor;
>  	unsigned int i, inputsize, outputsize, llen, nr_pages;
>  	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
> @@ -925,16 +960,15 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  	overlapped = false;
>  	compressed_pages = pcl->compressed_pages;
>  
> -	for (i = 0; i < pcl->pclusterpages; ++i) {
> +	for (i = 0; i < pclusterpages; ++i) {
>  		unsigned int pagenr;
>  
>  		page = compressed_pages[i];
> -
>  		/* all compressed pages ought to be valid */
>  		DBG_BUGON(!page);
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
>  
> -		if (!z_erofs_is_shortlived_page(page)) {
> +		if (!z_erofs_is_inline_pcluster(pcl) &&

some inline checks may exist for noinline case if it's bigpcluster. And i understand the
behavior of ztailpacking page is differ from normal page. So better to branch them? moving
the inline check outside the for loop? 

> +		    !z_erofs_is_shortlived_page(page)) {
>  			if (erofs_page_is_managed(sbi, page)) {
>  				if (!PageUptodate(page))
>  					err = -EIO;
> @@ -960,10 +994,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  		}
>  
>  		/* PG_error needs checking for all non-managed pages */
> -		if (PageError(page)) {
> -			DBG_BUGON(PageUptodate(page));
> +		if (!PageUptodate(page))
>  			err = -EIO;
> -		}
>  	}
>  
>  	if (err)
> @@ -978,11 +1010,16 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  		partial = true;
>  	}
>  
> -	inputsize = pcl->pclusterpages * PAGE_SIZE;
> +	if (z_erofs_is_inline_pcluster(pcl))
> +		inputsize = pcl->tailpacking_size;
> +	else
> +		inputsize = pclusterpages * PAGE_SIZE;
> +
>  	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
>  					.sb = sb,
>  					.in = compressed_pages,
>  					.out = pages,
> +					.pageofs_in = pcl->pageofs_in,
>  					.pageofs_out = cl->pageofs,
>  					.inputsize = inputsize,
>  					.outputsize = outputsize,
> @@ -992,17 +1029,22 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				 }, pagepool);
>  
>  out:
> -	/* must handle all compressed pages before ending pages */
> -	for (i = 0; i < pcl->pclusterpages; ++i) {
> -		page = compressed_pages[i];
> -
> -		if (erofs_page_is_managed(sbi, page))
> -			continue;
> +	/* must handle all compressed pages before actual file pages */
> +	if (z_erofs_is_inline_pcluster(pcl)) {
> +		page = compressed_pages[0];
> +		WRITE_ONCE(compressed_pages[0], NULL);
> +		put_page(page);
> +	} else {
> +		for (i = 0; i < pclusterpages; ++i) {
> +			page = compressed_pages[i];
>  
> -		/* recycle all individual short-lived pages */
> -		(void)z_erofs_put_shortlivedpage(pagepool, page);
> +			if (erofs_page_is_managed(sbi, page))
> +				continue;
>  
> -		WRITE_ONCE(compressed_pages[i], NULL);
> +			/* recycle all individual short-lived pages */
> +			(void)z_erofs_put_shortlivedpage(pagepool, page);
> +			WRITE_ONCE(compressed_pages[i], NULL);
> +		}
>  	}
>  
>  	for (i = 0; i < nr_pages; ++i) {
> @@ -1288,6 +1330,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  
>  		pcl = container_of(owned_head, struct z_erofs_pcluster, next);
>  
> +		/* close the main owned chain at first */
> +		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
> +				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
> +		if (z_erofs_is_inline_pcluster(pcl)) {
> +			move_to_bypass_jobqueue(pcl, qtail, owned_head);
> +			continue;
> +		}
> +
>  		/* no device id here, thus it will always succeed */
>  		mdev = (struct erofs_map_dev) {
>  			.m_pa = blknr_to_addr(pcl->obj.index),
> @@ -1297,10 +1347,6 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  		cur = erofs_blknr(mdev.m_pa);
>  		end = cur + pcl->pclusterpages;
>  
> -		/* close the main owned chain at first */
> -		owned_head = cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
> -				     Z_EROFS_PCLUSTER_TAIL_CLOSED);
> -
>  		do {
>  			struct page *page;
>  
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index 4a69515dea75..e043216b545f 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -62,8 +62,16 @@ struct z_erofs_pcluster {
>  	/* A: lower limit of decompressed length and if full length or not */
>  	unsigned int length;
>  
> -	/* I: physical cluster size in pages */
> -	unsigned short pclusterpages;
> +	/* I: page offset of inline compressed data */
> +	unsigned short pageofs_in;
> +
> +	union {
> +		/* I: physical cluster size in pages */
> +		unsigned short pclusterpages;
> +
> +		/* I: tailpacking inline compressed size */
> +		unsigned short tailpacking_size;
> +	};
>  
>  	/* I: compression algorithm format */
>  	unsigned char algorithmformat;
> @@ -94,6 +102,18 @@ struct z_erofs_decompressqueue {
>  	} u;
>  };
>  
> +static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
> +{
> +	return !pcl->obj.index;
> +}
> +
> +static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
> +{
> +	if (z_erofs_is_inline_pcluster(pcl))
> +		return 1;
> +	return pcl->pclusterpages;
> +}
> +
>  #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
>  #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
>  #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)

