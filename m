Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5D7146D4
	for <lists+linux-erofs@lfdr.de>; Mon, 29 May 2023 11:08:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QV8p95WG1z3f7d
	for <lists+linux-erofs@lfdr.de>; Mon, 29 May 2023 19:08:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=j1mqmSjp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=j1mqmSjp;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QV8p36TzHz3bjY
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 May 2023 19:08:25 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso366434a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 29 May 2023 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685351301; x=1687943301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka2xi3fIlxezm++Nu/yukOY+JQSVBC0i9rt//C55ldM=;
        b=j1mqmSjpQOYwbyEPcZJz4hSyQmGoBlk+K0+OR0GbksJdYiWfgl+65HtEenIW//fyQ2
         r87kYvwYoXmfl8EveG7GUR8ViStLsPGzNp0xVr2BErnrEGxZqJPvAmcWxN4rqNa8z/Ey
         vZ9ZwMaeEh9pmFDvx1kq1rm9sRB7enDRYr+PWUE0zZDl/it4+O5HXXJpbKI9738WIhEp
         4jiekAlhLBHngh8jj6aLcFuysMadNsQqn8fZzAKv+6Xy2L6uwSBjhHMQNQODOEJC/FUA
         kizpig8M0OYD8wEWGseFtYrq3eAx0sfh1UD7j9XKiTgT/C9vQOINOtREWIMpALDMjGBv
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685351301; x=1687943301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka2xi3fIlxezm++Nu/yukOY+JQSVBC0i9rt//C55ldM=;
        b=JDbIrZ8Hf039VOaKriNDE0hYdM4e0uYPFabT6H1O6PSbbowxNu2VF2ryq4+Cz8d3p4
         3t82LoGTnRSx/1j1sODS7Qe/P6Ew4QfKnxxM82LeOnUVOd0vTord7yp0F8jOGfZB3sY3
         xphBi3VnHUWQ4IVXDQeGNOWKpvhFY2MDrHoNc1isqqH9lA4uRB3qPK2uPetCPetKg9Kn
         wVt6PIJ9H0w6cgJIyi7Jplc5uo2cLHwpe1uBoIrWGkq/KetqMSTngPVQ471F8APYajHC
         dl5WaA1E8JB2gPOPPsC2uWi8q2LeD/7vVhrp39VUMkAQiuBDeObqNAV4rmCJa2cU0l92
         /0Yg==
X-Gm-Message-State: AC+VfDy/WJfbN41CuJB9ZdyjXbxtL7KPn5dfEXg0eqXXjii5r8bWXys3
	ITHrlYJsDCYLXBB1tYQuloreI6tTrQE=
X-Google-Smtp-Source: ACHHUZ6Ag7h8r+wXCY5qO80fw8EO+PqB3RuGqIbmsxjly+UV4AOCajIBJr5G8DMwhMZoeNKSUX9rmQ==
X-Received: by 2002:a17:90a:e7cc:b0:255:38ed:9dcd with SMTP id kb12-20020a17090ae7cc00b0025538ed9dcdmr7724376pjb.0.1685351301521;
        Mon, 29 May 2023 02:08:21 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a458400b00246f9725ffcsm6635916pjg.33.2023.05.29.02.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2023 02:08:21 -0700 (PDT)
Date: Mon, 29 May 2023 17:16:29 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2 5/6] erofs: use struct lockref to replace handcrafted
 approach
Message-ID: <20230529171629.0000292b.zbestahu@gmail.com>
In-Reply-To: <20230529072923.91736-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-6-hsiangkao@linux.alibaba.com>
	<20230529072923.91736-1-hsiangkao@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 29 May 2023 15:29:23 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Let's avoid the current handcrafted lockref although `struct lockref`
> inclusion usually increases extra 4 bytes with an explicit spinlock if
> CONFIG_DEBUG_SPINLOCK is off.
> 
> Apart from the size difference, note that the meaning of refcount is
> also changed to active users. IOWs, it doesn't take an extra refcount
> for XArray tree insertion.
> 
> I don't observe any significant performance difference at least on
> our cloud compute server but the new one indeed simplifies the
> overall codebase a bit.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>  - fix reference leaking due to improper fallback of
>    erofs_workgroup_put().
> 
>  fs/erofs/internal.h | 38 ++------------------
>  fs/erofs/utils.c    | 86 ++++++++++++++++++++++-----------------------
>  fs/erofs/zdata.c    | 15 ++++----
>  3 files changed, 52 insertions(+), 87 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 0b8506c39145..e63f6cd424a0 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -208,46 +208,12 @@ enum {
>  	EROFS_ZIP_CACHE_READAROUND
>  };
>  
> -#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
> -
>  /* basic unit of the workstation of a super_block */
>  struct erofs_workgroup {
> -	/* the workgroup index in the workstation */
>  	pgoff_t index;
> -
> -	/* overall workgroup reference count */
> -	atomic_t refcount;
> +	struct lockref lockref;
>  };
>  
> -static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
> -						 int val)
> -{
> -	preempt_disable();
> -	if (val != atomic_cmpxchg(&grp->refcount, val, EROFS_LOCKED_MAGIC)) {
> -		preempt_enable();
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
> -					    int orig_val)
> -{
> -	/*
> -	 * other observers should notice all modifications
> -	 * in the freezing period.
> -	 */
> -	smp_mb();
> -	atomic_set(&grp->refcount, orig_val);
> -	preempt_enable();
> -}
> -
> -static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
> -{
> -	return atomic_cond_read_relaxed(&grp->refcount,
> -					VAL != EROFS_LOCKED_MAGIC);
> -}
> -
>  enum erofs_kmap_type {
>  	EROFS_NO_KMAP,		/* don't map the buffer */
>  	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
> @@ -492,7 +458,7 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>  void erofs_release_pages(struct page **pagepool);
>  
>  #ifdef CONFIG_EROFS_FS_ZIP
> -int erofs_workgroup_put(struct erofs_workgroup *grp);
> +void erofs_workgroup_put(struct erofs_workgroup *grp);
>  struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>  					     pgoff_t index);
>  struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index 46627cb69abe..6ed79f10e2e2 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -33,22 +33,21 @@ void erofs_release_pages(struct page **pagepool)
>  /* global shrink count (for all mounted EROFS instances) */
>  static atomic_long_t erofs_global_shrink_cnt;
>  
> -static int erofs_workgroup_get(struct erofs_workgroup *grp)
> +static bool erofs_workgroup_get(struct erofs_workgroup *grp)
>  {
> -	int o;
> +	if (lockref_get_not_zero(&grp->lockref))
> +		return true;
>  
> -repeat:
> -	o = erofs_wait_on_workgroup_freezed(grp);
> -	if (o <= 0)
> -		return -1;
> -
> -	if (atomic_cmpxchg(&grp->refcount, o, o + 1) != o)
> -		goto repeat;
> +	spin_lock(&grp->lockref.lock);
> +	if (__lockref_is_dead(&grp->lockref)) {
> +		spin_unlock(&grp->lockref.lock);
> +		return false;
> +	}
>  
> -	/* decrease refcount paired by erofs_workgroup_put */
> -	if (o == 1)
> +	if (!grp->lockref.count++)
>  		atomic_long_dec(&erofs_global_shrink_cnt);
> -	return 0;
> +	spin_unlock(&grp->lockref.lock);
> +	return true;
>  }

May use lockref_get_not_dead() to simplify it a bit?

>  
>  struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
> @@ -61,7 +60,7 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>  	rcu_read_lock();
>  	grp = xa_load(&sbi->managed_pslots, index);
>  	if (grp) {
> -		if (erofs_workgroup_get(grp)) {
> +		if (!erofs_workgroup_get(grp)) {
>  			/* prefer to relax rcu read side */
>  			rcu_read_unlock();
>  			goto repeat;
> @@ -80,11 +79,10 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>  	struct erofs_workgroup *pre;
>  
>  	/*
> -	 * Bump up a reference count before making this visible
> -	 * to others for the XArray in order to avoid potential
> -	 * UAF without serialized by xa_lock.
> +	 * Bump up before making this visible to others for the XArray in order
> +	 * to avoid potential UAF without serialized by xa_lock.
>  	 */
> -	atomic_inc(&grp->refcount);
> +	lockref_get(&grp->lockref);
>  
>  repeat:
>  	xa_lock(&sbi->managed_pslots);
> @@ -93,13 +91,13 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
>  	if (pre) {
>  		if (xa_is_err(pre)) {
>  			pre = ERR_PTR(xa_err(pre));
> -		} else if (erofs_workgroup_get(pre)) {
> +		} else if (!erofs_workgroup_get(pre)) {
>  			/* try to legitimize the current in-tree one */
>  			xa_unlock(&sbi->managed_pslots);
>  			cond_resched();
>  			goto repeat;
>  		}
> -		atomic_dec(&grp->refcount);
> +		lockref_put_return(&grp->lockref);

Should check return error?

>  		grp = pre;
>  	}
>  	xa_unlock(&sbi->managed_pslots);
> @@ -112,38 +110,35 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>  	erofs_workgroup_free_rcu(grp);
>  }
>  
> -int erofs_workgroup_put(struct erofs_workgroup *grp)
> +void erofs_workgroup_put(struct erofs_workgroup *grp)
>  {
> -	int count = atomic_dec_return(&grp->refcount);
> +	if (lockref_put_not_zero(&grp->lockref))
> +		return;

May use lockref_put_or_lock() to avoid following lock?

>  
> -	if (count == 1)
> +	spin_lock(&grp->lockref.lock);
> +	DBG_BUGON(__lockref_is_dead(&grp->lockref));
> +	if (grp->lockref.count == 1)
>  		atomic_long_inc(&erofs_global_shrink_cnt);
> -	else if (!count)
> -		__erofs_workgroup_free(grp);
> -	return count;
> +	--grp->lockref.count;
> +	spin_unlock(&grp->lockref.lock);
>  }
>  
>  static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>  					   struct erofs_workgroup *grp)
>  {
> -	/*
> -	 * If managed cache is on, refcount of workgroups
> -	 * themselves could be < 0 (freezed). In other words,
> -	 * there is no guarantee that all refcounts > 0.
> -	 */
> -	if (!erofs_workgroup_try_to_freeze(grp, 1))
> -		return false;
> +	int free = false;
> +
> +	spin_lock(&grp->lockref.lock);
> +	if (grp->lockref.count)
> +		goto out;
>  
>  	/*
> -	 * Note that all cached pages should be unattached
> -	 * before deleted from the XArray. Otherwise some
> -	 * cached pages could be still attached to the orphan
> -	 * old workgroup when the new one is available in the tree.
> +	 * Note that all cached pages should be detached before deleted from
> +	 * the XArray. Otherwise some cached pages could be still attached to
> +	 * the orphan old workgroup when the new one is available in the tree.
>  	 */
> -	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
> -		erofs_workgroup_unfreeze(grp, 1);
> -		return false;
> -	}
> +	if (erofs_try_to_free_all_cached_pages(sbi, grp))
> +		goto out;
>  
>  	/*
>  	 * It's impossible to fail after the workgroup is freezed,
> @@ -152,10 +147,13 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>  	 */
>  	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
>  
> -	/* last refcount should be connected with its managed pslot.  */
> -	erofs_workgroup_unfreeze(grp, 0);
> -	__erofs_workgroup_free(grp);
> -	return true;
> +	lockref_mark_dead(&grp->lockref);
> +	free = true;
> +out:
> +	spin_unlock(&grp->lockref.lock);
> +	if (free)
> +		__erofs_workgroup_free(grp);
> +	return free;
>  }
>  
>  static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 15a383899540..2ea8e7f08372 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -643,7 +643,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
>  
>  	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
>  	/*
> -	 * refcount of workgroup is now freezed as 1,
> +	 * refcount of workgroup is now freezed as 0,
>  	 * therefore no need to worry about available decompression users.
>  	 */
>  	for (i = 0; i < pcl->pclusterpages; ++i) {
> @@ -676,10 +676,11 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
>  	if (!folio_test_private(folio))
>  		return true;
>  
> -	if (!erofs_workgroup_try_to_freeze(&pcl->obj, 1))
> -		return false;
> -
>  	ret = false;
> +	spin_lock(&pcl->obj.lockref.lock);
> +	if (pcl->obj.lockref.count > 0)
> +		goto out;
> +
>  	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
>  	for (i = 0; i < pcl->pclusterpages; ++i) {
>  		if (pcl->compressed_bvecs[i].page == &folio->page) {
> @@ -688,10 +689,10 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
>  			break;
>  		}
>  	}
> -	erofs_workgroup_unfreeze(&pcl->obj, 1);
> -
>  	if (ret)
>  		folio_detach_private(folio);
> +out:
> +	spin_unlock(&pcl->obj.lockref.lock);
>  	return ret;
>  }
>  
> @@ -807,7 +808,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>  	if (IS_ERR(pcl))
>  		return PTR_ERR(pcl);
>  
> -	atomic_set(&pcl->obj.refcount, 1);
> +	spin_lock_init(&pcl->obj.lockref.lock);
>  	pcl->algorithmformat = map->m_algorithmformat;
>  	pcl->length = 0;
>  	pcl->partial = true;

