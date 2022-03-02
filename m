Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8D4C9C6A
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 05:23:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7gwc0tCGz3bVf
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Mar 2022 15:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ih6fUwjC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e;
 helo=mail-pg1-x52e.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Ih6fUwjC; dkim-atps=neutral
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7gwV001Bz30Hp
 for <linux-erofs@lists.ozlabs.org>; Wed,  2 Mar 2022 15:23:35 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 132so604188pga.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 01 Mar 2022 20:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iNy7mBzqUByEcsJ4CF9ICjC++ci7G3gLkp1DxoEMzC0=;
 b=Ih6fUwjCG/9r2VJ2iMfM0j59eUgNSer2O4xnE1bg36epVIRhA4bTtNOqSKM7lc/w3M
 VMDgPDH+FnGn+HwrIBNj9f67F3tFOOdYM4MXuwrTy8NGOrZBIc7vbPl026sX8oQ9A77w
 ye7reA2BpyW0pSO3TdevZJVxrzZDDUAZiuaxubq9HhPNlyQ7L3MSyafcqwt34BchYAiZ
 C/ttfXwGGlFYXd2UpyWa/uzsdZWbbNRvpJaIOP4lLaq9MiB8/rPXhmqFYj8kOMDokBSj
 H8QEljowyNHttyc2BfxLceZrW6jVqhzzPgD/BGKI1speSNgpCWcU4br64IsXaTMyKamu
 szXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iNy7mBzqUByEcsJ4CF9ICjC++ci7G3gLkp1DxoEMzC0=;
 b=6SKtNFkH+Fjqo7ed3YnQuZ6VF2QPY58IfHunQgmp3lWWyAZXmSpI7ruTgM6JXVEOv7
 zFUAJXWxQ6320FVal5518YxpHkmlSz0At3bn+5pMe5fFKqh4MhI9wEnukX+FLgqUs187
 zy8tuM3DjmZrI3lznszlQkOMIMKBnYIWAGVzovHUDLQFbo5pywZVvC/iiiOY99UPECif
 N6jyu5BQZOgWT8mBu+d5EloDLfsGhqXhGVO9yephfbNupQzIsdHFJZISbmFbOklAo5rl
 h7ZfFQj9GQINPaJYoaqIsZqdijwsqnZshj2uAx/XLg9JFb0NN2Qnix+K4/wUG/ZkUldn
 ezrg==
X-Gm-Message-State: AOAM530C9gHy93DLZ9fMhVemDtlt8BB3+/MVZ4cMjh0ueEQBb7l7N7EU
 R7jiUEFIjxTh/P//b3Tu/b8=
X-Google-Smtp-Source: ABdhPJzJ8LHY5J9lykEw+r2TkfZI1aqV7fnrEV3lGN6Rs9XQZQriCK4VW/lRdAhfQGGEs4QaMxnL3Q==
X-Received: by 2002:a63:10a:0:b0:372:e458:e707 with SMTP id
 10-20020a63010a000000b00372e458e707mr24349909pgb.39.1646195011692; 
 Tue, 01 Mar 2022 20:23:31 -0800 (PST)
Received: from localhost ([103.220.76.197]) by smtp.gmail.com with ESMTPSA id
 o5-20020a056a00214500b004bd7036b50asm18290653pfk.172.2022.03.01.20.23.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Mar 2022 20:23:31 -0800 (PST)
Date: Wed, 2 Mar 2022 12:22:03 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: get rid of `struct z_erofs_collector'
Message-ID: <20220302122203.000046f5.zbestahu@gmail.com>
In-Reply-To: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Wed,  2 Mar 2022 03:49:50 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Avoid `struct z_erofs_collector' since there is another context
> structure called "struct z_erofs_decompress_frontend".
> 
> No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 163 ++++++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 86 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 423bc1a61da5..2673fc105861 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -192,7 +192,10 @@ enum z_erofs_collectmode {
>  	COLLECT_PRIMARY_FOLLOWED,
>  };
>  
> -struct z_erofs_collector {
> +struct z_erofs_decompress_frontend {
> +	struct inode *const inode;
> +	struct erofs_map_blocks map;
> +
>  	struct z_erofs_pagevec_ctor vector;
>  
>  	struct z_erofs_pcluster *pcl, *tailpcl;
> @@ -202,13 +205,6 @@ struct z_erofs_collector {
>  	z_erofs_next_pcluster_t owned_head;
>  
>  	enum z_erofs_collectmode mode;
> -};
> -
> -struct z_erofs_decompress_frontend {
> -	struct inode *const inode;
> -
> -	struct z_erofs_collector clt;
> -	struct erofs_map_blocks map;
>  
>  	bool readahead;
>  	/* used for applying cache strategy on the fly */
> @@ -216,30 +212,26 @@ struct z_erofs_decompress_frontend {
>  	erofs_off_t headoffset;
>  };
>  
> -#define COLLECTOR_INIT() { \
> -	.owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = COLLECT_PRIMARY_FOLLOWED }
> -
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
> -	.inode = __i, .clt = COLLECTOR_INIT(), \
> -	.backmost = true, }
> +	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> +	.mode = COLLECT_PRIMARY_FOLLOWED }
>  
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);
>  
> -static void preload_compressed_pages(struct z_erofs_collector *clt,
> +static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
>  				     struct address_space *mc,
>  				     enum z_erofs_cache_alloctype type,
>  				     struct page **pagepool)
>  {
> -	struct z_erofs_pcluster *pcl = clt->pcl;
> +	struct z_erofs_pcluster *pcl = fe->pcl;
>  	bool standalone = true;
>  	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  	struct page **pages;
>  	pgoff_t index;
>  
> -	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
> +	if (fe->mode < COLLECT_PRIMARY_FOLLOWED)
>  		return;
>  
>  	pages = pcl->compressed_pages;
> @@ -288,7 +280,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
>  	 * managed cache since it can be moved to the bypass queue instead.
>  	 */
>  	if (standalone)
> -		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> +		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  }
>  
>  /* called by erofs_shrinker to get rid of all compressed_pages */
> @@ -350,47 +342,47 @@ int erofs_try_to_free_cached_page(struct page *page)
>  }
>  
>  /* page_type must be Z_EROFS_PAGE_TYPE_EXCLUSIVE */
> -static bool z_erofs_try_inplace_io(struct z_erofs_collector *clt,
> +static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
>  				   struct page *page)
>  {
> -	struct z_erofs_pcluster *const pcl = clt->pcl;
> +	struct z_erofs_pcluster *const pcl = fe->pcl;
>  
> -	while (clt->icpage_ptr > pcl->compressed_pages)
> -		if (!cmpxchg(--clt->icpage_ptr, NULL, page))
> +	while (fe->icpage_ptr > pcl->compressed_pages)
> +		if (!cmpxchg(--fe->icpage_ptr, NULL, page))
>  			return true;
>  	return false;
>  }
>  
>  /* callers must be with collection lock held */
> -static int z_erofs_attach_page(struct z_erofs_collector *clt,
> +static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>  			       struct page *page, enum z_erofs_page_type type,
>  			       bool pvec_safereuse)
>  {
>  	int ret;
>  
>  	/* give priority for inplaceio */
> -	if (clt->mode >= COLLECT_PRIMARY &&
> +	if (fe->mode >= COLLECT_PRIMARY &&
>  	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
> -	    z_erofs_try_inplace_io(clt, page))
> +	    z_erofs_try_inplace_io(fe, page))
>  		return 0;
>  
> -	ret = z_erofs_pagevec_enqueue(&clt->vector, page, type,
> +	ret = z_erofs_pagevec_enqueue(&fe->vector, page, type,
>  				      pvec_safereuse);
> -	clt->cl->vcnt += (unsigned int)ret;
> +	fe->cl->vcnt += (unsigned int)ret;
>  	return ret ? 0 : -EAGAIN;
>  }
>  
> -static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
> +static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
>  {
> -	struct z_erofs_pcluster *pcl = clt->pcl;
> -	z_erofs_next_pcluster_t *owned_head = &clt->owned_head;
> +	struct z_erofs_pcluster *pcl = f->pcl;
> +	z_erofs_next_pcluster_t *owned_head = &f->owned_head;
>  
>  	/* type 1, nil pcluster (this pcluster doesn't belong to any chain.) */
>  	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_NIL,
>  		    *owned_head) == Z_EROFS_PCLUSTER_NIL) {
>  		*owned_head = &pcl->next;
>  		/* so we can attach this pcluster to our submission chain. */
> -		clt->mode = COLLECT_PRIMARY_FOLLOWED;
> +		f->mode = COLLECT_PRIMARY_FOLLOWED;
>  		return;
>  	}
>  
> @@ -401,24 +393,24 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_collector *clt)
>  	if (cmpxchg(&pcl->next, Z_EROFS_PCLUSTER_TAIL,
>  		    *owned_head) == Z_EROFS_PCLUSTER_TAIL) {
>  		*owned_head = Z_EROFS_PCLUSTER_TAIL;
> -		clt->mode = COLLECT_PRIMARY_HOOKED;
> -		clt->tailpcl = NULL;
> +		f->mode = COLLECT_PRIMARY_HOOKED;
> +		f->tailpcl = NULL;
>  		return;
>  	}
>  	/* type 3, it belongs to a chain, but it isn't the end of the chain */
> -	clt->mode = COLLECT_PRIMARY;
> +	f->mode = COLLECT_PRIMARY;
>  }
>  
> -static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
> +static int z_erofs_lookup_collection(struct z_erofs_decompress_frontend *fe,
>  				     struct inode *inode,
>  				     struct erofs_map_blocks *map)
>  {
> -	struct z_erofs_pcluster *pcl = clt->pcl;
> +	struct z_erofs_pcluster *pcl = fe->pcl;
>  	struct z_erofs_collection *cl;
>  	unsigned int length;
>  
>  	/* to avoid unexpected loop formed by corrupted images */
> -	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
> +	if (fe->owned_head == &pcl->next || pcl == fe->tailpcl) {
>  		DBG_BUGON(1);
>  		return -EFSCORRUPTED;
>  	}
> @@ -449,15 +441,15 @@ static int z_erofs_lookup_collection(struct z_erofs_collector *clt,
>  	}
>  	mutex_lock(&cl->lock);
>  	/* used to check tail merging loop due to corrupted images */
> -	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> -		clt->tailpcl = pcl;
> +	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
> +		fe->tailpcl = pcl;
>  
> -	z_erofs_try_to_claim_pcluster(clt);
> -	clt->cl = cl;
> +	z_erofs_try_to_claim_pcluster(fe);
> +	fe->cl = cl;
>  	return 0;
>  }
>  
> -static int z_erofs_register_collection(struct z_erofs_collector *clt,
> +static int z_erofs_register_collection(struct z_erofs_decompress_frontend *fe,
>  				       struct inode *inode,
>  				       struct erofs_map_blocks *map)
>  {
> @@ -485,8 +477,8 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);
>  
>  	/* new pclusters should be claimed as type 1, primary and followed */
> -	pcl->next = clt->owned_head;
> -	clt->mode = COLLECT_PRIMARY_FOLLOWED;
> +	pcl->next = fe->owned_head;
> +	fe->mode = COLLECT_PRIMARY_FOLLOWED;
>  
>  	cl = z_erofs_primarycollection(pcl);
>  	cl->pageofs = map->m_la & ~PAGE_MASK;
> @@ -512,18 +504,18 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  		}
>  
>  		if (grp != &pcl->obj) {
> -			clt->pcl = container_of(grp,
> +			fe->pcl = container_of(grp,
>  					struct z_erofs_pcluster, obj);
>  			err = -EEXIST;
>  			goto err_out;
>  		}
>  	}
>  	/* used to check tail merging loop due to corrupted images */
> -	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> -		clt->tailpcl = pcl;
> -	clt->owned_head = &pcl->next;
> -	clt->pcl = pcl;
> -	clt->cl = cl;
> +	if (fe->owned_head == Z_EROFS_PCLUSTER_TAIL)
> +		fe->tailpcl = pcl;
> +	fe->owned_head = &pcl->next;
> +	fe->pcl = pcl;
> +	fe->cl = cl;
>  	return 0;
>  
>  err_out:
> @@ -532,18 +524,18 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
>  	return err;
>  }
>  
> -static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> +static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe,
>  				   struct inode *inode,
>  				   struct erofs_map_blocks *map)
>  {
>  	struct erofs_workgroup *grp;
>  	int ret;
>  
> -	DBG_BUGON(clt->cl);
> +	DBG_BUGON(fe->cl);
>  
>  	/* must be Z_EROFS_PCLUSTER_TAIL or pointed to previous collection */
> -	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
> -	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
> +	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
> +	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
>  
>  	if (map->m_flags & EROFS_MAP_META) {
>  		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> @@ -555,28 +547,28 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
>  
>  	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
>  	if (grp) {
> -		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> +		fe->pcl = container_of(grp, struct z_erofs_pcluster, obj);
>  	} else {
>  tailpacking:
> -		ret = z_erofs_register_collection(clt, inode, map);
> +		ret = z_erofs_register_collection(fe, inode, map);
>  		if (!ret)
>  			goto out;
>  		if (ret != -EEXIST)
>  			return ret;
>  	}
>  
> -	ret = z_erofs_lookup_collection(clt, inode, map);
> +	ret = z_erofs_lookup_collection(fe, inode, map);
>  	if (ret) {
> -		erofs_workgroup_put(&clt->pcl->obj);
> +		erofs_workgroup_put(&fe->pcl->obj);
>  		return ret;
>  	}
>  
>  out:
> -	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> -				  clt->cl->pagevec, clt->cl->vcnt);
> +	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> +				  fe->cl->pagevec, fe->cl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */
> -	clt->icpage_ptr = clt->pcl->compressed_pages +
> -			z_erofs_pclusterpages(clt->pcl);
> +	fe->icpage_ptr = fe->pcl->compressed_pages +
> +			z_erofs_pclusterpages(fe->pcl);
>  	return 0;
>  }
>  
> @@ -610,24 +602,24 @@ static void z_erofs_collection_put(struct z_erofs_collection *cl)
>  	erofs_workgroup_put(&pcl->obj);
>  }
>  
> -static bool z_erofs_collector_end(struct z_erofs_collector *clt)
> +static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
>  {
> -	struct z_erofs_collection *cl = clt->cl;
> +	struct z_erofs_collection *cl = fe->cl;
>  
>  	if (!cl)
>  		return false;
>  
> -	z_erofs_pagevec_ctor_exit(&clt->vector, false);
> +	z_erofs_pagevec_ctor_exit(&fe->vector, false);
>  	mutex_unlock(&cl->lock);
>  
>  	/*
>  	 * if all pending pages are added, don't hold its reference
>  	 * any longer if the pcluster isn't hosted by ourselves.
>  	 */
> -	if (clt->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
> +	if (fe->mode < COLLECT_PRIMARY_FOLLOWED_NOINPLACE)
>  		z_erofs_collection_put(cl);
>  
> -	clt->cl = NULL;
> +	fe->cl = NULL;
>  	return true;
>  }
>  
> @@ -651,7 +643,6 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	struct inode *const inode = fe->inode;
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>  	struct erofs_map_blocks *const map = &fe->map;
> -	struct z_erofs_collector *const clt = &fe->clt;
>  	const loff_t offset = page_offset(page);
>  	bool tight = true;
>  
> @@ -672,7 +663,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	if (offset + cur >= map->m_la &&
>  	    offset + cur < map->m_la + map->m_llen) {
>  		/* didn't get a valid collection previously (very rare) */
> -		if (!clt->cl)
> +		if (!fe->cl)
>  			goto restart_now;
>  		goto hitted;
>  	}
> @@ -680,7 +671,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	/* go ahead the next map_blocks */
>  	erofs_dbg("%s: [out-of-range] pos %llu", __func__, offset + cur);
>  
> -	if (z_erofs_collector_end(clt))
> +	if (z_erofs_collector_end(fe))
>  		fe->backmost = false;
>  
>  	map->m_la = offset + cur;
> @@ -693,11 +684,11 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	if (!(map->m_flags & EROFS_MAP_MAPPED))
>  		goto hitted;
>  
> -	err = z_erofs_collector_begin(clt, inode, map);
> +	err = z_erofs_collector_begin(fe, inode, map);

now, we can get 'inode' and 'map' from 'fe'. so, it should be z_erofs_collector_begin(fe)?
if it's, need to change z_erofs_{register | lookup}_collection() correspondingly. 

>  	if (err)
>  		goto err_out;
>  
> -	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> +	if (z_erofs_is_inline_pcluster(fe->pcl)) {
>  		void *mp;
>  
>  		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> @@ -709,8 +700,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  			goto err_out;
>  		}
>  		get_page(fe->map.buf.page);
> -		WRITE_ONCE(clt->pcl->compressed_pages[0], fe->map.buf.page);
> -		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> +		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
> +		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  	} else {
>  		/* preload all compressed pages (can change mode if needed) */
>  		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
> @@ -719,7 +710,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		else
>  			cache_strategy = DONTALLOC;
>  
> -		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> +		preload_compressed_pages(fe, MNGD_MAPPING(sbi),
>  					 cache_strategy, pagepool);
>  	}
>  
> @@ -730,8 +721,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	 * those chains are handled asynchronously thus the page cannot be used
>  	 * for inplace I/O or pagevec (should be processed in strict order.)
>  	 */
> -	tight &= (clt->mode >= COLLECT_PRIMARY_HOOKED &&
> -		  clt->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
> +	tight &= (fe->mode >= COLLECT_PRIMARY_HOOKED &&
> +		  fe->mode != COLLECT_PRIMARY_FOLLOWED_NOINPLACE);
>  
>  	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>  	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
> @@ -746,18 +737,18 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
>  
>  	if (cur)
> -		tight &= (clt->mode >= COLLECT_PRIMARY_FOLLOWED);
> +		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
>  
>  retry:
> -	err = z_erofs_attach_page(clt, page, page_type,
> -				  clt->mode >= COLLECT_PRIMARY_FOLLOWED);
> +	err = z_erofs_attach_page(fe, page, page_type,
> +				  fe->mode >= COLLECT_PRIMARY_FOLLOWED);
>  	/* should allocate an additional short-lived page for pagevec */
>  	if (err == -EAGAIN) {
>  		struct page *const newpage =
>  				alloc_page(GFP_NOFS | __GFP_NOFAIL);
>  
>  		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> -		err = z_erofs_attach_page(clt, newpage,
> +		err = z_erofs_attach_page(fe, newpage,
>  					  Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
>  		if (!err)
>  			goto retry;
> @@ -773,7 +764,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	/* bump up the number of spiltted parts of a page */
>  	++spiltted;
>  	/* also update nr_pages */
> -	clt->cl->nr_pages = max_t(pgoff_t, clt->cl->nr_pages, index + 1);
> +	fe->cl->nr_pages = max_t(pgoff_t, fe->cl->nr_pages, index + 1);
>  next_part:
>  	/* can be used for verification */
>  	map->m_llen = offset + cur - map->m_la;
> @@ -1309,7 +1300,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
>  	z_erofs_next_pcluster_t qtail[NR_JOBQUEUES];
>  	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
>  	void *bi_private;
> -	z_erofs_next_pcluster_t owned_head = f->clt.owned_head;
> +	z_erofs_next_pcluster_t owned_head = f->owned_head;
>  	/* bio is NULL initially, so no need to initialize last_{index,bdev} */
>  	pgoff_t last_index;
>  	struct block_device *last_bdev;
> @@ -1417,7 +1408,7 @@ static void z_erofs_runqueue(struct super_block *sb,
>  {
>  	struct z_erofs_decompressqueue io[NR_JOBQUEUES];
>  
> -	if (f->clt.owned_head == Z_EROFS_PCLUSTER_TAIL)
> +	if (f->owned_head == Z_EROFS_PCLUSTER_TAIL)
>  		return;
>  	z_erofs_submit_queue(sb, f, pagepool, io, &force_fg);
>  
> @@ -1517,7 +1508,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
>  	err = z_erofs_do_read_page(&f, page, &pagepool);
>  	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
>  
> -	(void)z_erofs_collector_end(&f.clt);
> +	(void)z_erofs_collector_end(&f);
>  
>  	/* if some compressed cluster ready, need submit them anyway */
>  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
> @@ -1567,7 +1558,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  		put_page(page);
>  	}
>  	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
> -	(void)z_erofs_collector_end(&f.clt);
> +	(void)z_erofs_collector_end(&f);
>  
>  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
>  			 z_erofs_get_sync_decompress_policy(sbi, nr_pages));
