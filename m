Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D7D83C470
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jan 2024 15:13:10 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Snxcde3T;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLN8N4dCXz3c2K
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jan 2024 01:13:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Snxcde3T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TLN8D4wG2z3bpt
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jan 2024 01:12:58 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d7232dcb3eso33944815ad.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jan 2024 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706191975; x=1706796775; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpJ1rdy+AQtCeVIbXtSCjUkJttMieQSTgjPiqYZd+FA=;
        b=Snxcde3T8iOX1zni4EO+scXubCwQh7IYByoRHCQmeUYsGw/uEIsyOalrMStSyzYKKO
         eJek9I9MuvRAfJowoiscFfqpDIVkHtnr9ron6H8Bjz9R+eWOJGfozNKg0OjUdbnsQ5AU
         Gkhh8GO1b6jaxWGpcn7JCSw3fF3S203krg67XgR4XMOPnWLsB+nnoGnMtJi064+mGV10
         nItbwm/UtRSa9we6oM6M/9MjPsuB/INScIyj3vRpPNhstMUnhJE3OhQXC1DTD8Cvp9Pb
         ITBN4rFN4i3sVAHVILKLfGhLQkXErxpKLVIMM4s7QP2nJXPlkGgj1vczvvQiSPo1W7w+
         Zp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191975; x=1706796775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpJ1rdy+AQtCeVIbXtSCjUkJttMieQSTgjPiqYZd+FA=;
        b=gygPvbzc/LqrGhqlPt2GJeVg7tF4EC1CmNapcO+sTjfPZqDtnCXV+IqBcgrBihegBT
         nU8tcYUQiFXGlW8xVoTZjM4wK7An/OTOxZRg697JAVhKg8nJmxOtTORAY34ALYat7d1s
         HANB+kFOMv1asBQv8w8vCJC/OhQTlqKB4IKSSD0tIjiGClFP8YHDZ1h1VZ98xVW4jm3N
         PJ6B8V1bTvJu+OsigrOieWVGbQtxvRz2ul+IDXR3gXHRsStF1QsOFp3Psg3pDHQNfUU5
         cnJMPdJkbqwVybojuX4Hifn+nzd14zOfZCT3e/ya5iuvZam4S/Qsda2beRCxS2b4hjm2
         BZfw==
X-Gm-Message-State: AOJu0YwfCul/I/oZL0nn2j7IpeMzRrVA9Etm5jgn6oYw6FwmMc3cei8p
	s+r7+Cw78QY4tKZSPvA8Q+nOX0NGdiLZD17J7hGnd1j5vWe29fbm
X-Google-Smtp-Source: AGHT+IHr1RzpEFGjMeQUHPWvxUxyVQQQC1cwSXzNxT0dg1BVheiKgFJTUoXXDPXWXYJ76knu2rJIpw==
X-Received: by 2002:a17:90a:fa08:b0:28e:8bb7:d373 with SMTP id cm8-20020a17090afa0800b0028e8bb7d373mr616918pjb.50.1706191974337;
        Thu, 25 Jan 2024 06:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVuK+UU9W6xHqNkW2tj5AFhw2CsQxHTXewyocJL+tmXJlZrtyILdxMzENgIMGp6o31/3FsyHRW4zOn0coY3zpHq/DmQtPl9M0x8EOYM
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090b278b00b002930639ad2fsm714394pjb.56.2024.01.25.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:12:54 -0800 (PST)
Date: Thu, 25 Jan 2024 22:12:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix infinite loop due to a race of filling
 compressed_bvecs
Message-ID: <20240125221248.00005540.zbestahu@gmail.com>
In-Reply-To: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
References: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
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

On Thu, 25 Jan 2024 20:00:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> I encountered a race issue after lengthy (~594647 sec) stress tests on
> a 64k-page arm64 VM with several 4k-block EROFS images.  The timing
> is like below:
> 
> z_erofs_try_inplace_io                  z_erofs_fill_bio_vec
>   cmpxchg(&compressed_bvecs[].page,
>           NULL, ..)
>                                         [access bufvec]
>   compressed_bvecs[] = *bvec;
> 
> Previously, z_erofs_submit_queue() just accessed bufvec->page only, so
> other fields in bufvec didn't matter.  After the subpage block support
> is landed, .offset and .end can be used too, but filling bufvec isn't
> an atomic operation which can cause inconsistency.
> 
> Let's use a spinlock to keep the atomicity of each bufvec.  More
> specifically, just reuse the existing spinlock `pcl->obj.lockref.lock`
> since it's rarely used (also it takes a short time if even used) as long
> as the pcluster has a reference.
> 
> Fixes: 192351616a9d ("erofs: support I/O submission for sub-page compressed blocks")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 74 +++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 583c062cd0e4..c1c77166b30f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -563,21 +563,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  	unsigned int i;
>  
> -	if (i_blocksize(fe->inode) != PAGE_SIZE)
> -		return;
> -	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
> +	if (i_blocksize(fe->inode) != PAGE_SIZE ||
> +	    fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
>  		return;
>  
>  	for (i = 0; i < pclusterpages; ++i) {
>  		struct page *page, *newpage;
>  		void *t;	/* mark pages just found for debugging */
>  
> -		/* the compressed page was loaded before */
> +		/* Inaccurate check w/o locking to avoid unneeded lookups */
>  		if (READ_ONCE(pcl->compressed_bvecs[i].page))
>  			continue;
>  
>  		page = find_get_page(mc, pcl->obj.index + i);
> -
>  		if (page) {
>  			t = (void *)((unsigned long)page | 1);
>  			newpage = NULL;
> @@ -597,9 +595,13 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
>  			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
>  			t = (void *)((unsigned long)newpage | 1);
>  		}
> -
> -		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL, t))
> +		spin_lock(&pcl->obj.lockref.lock);
> +		if (!pcl->compressed_bvecs[i].page) {
> +			pcl->compressed_bvecs[i].page = t;
> +			spin_unlock(&pcl->obj.lockref.lock);
>  			continue;
> +		}
> +		spin_unlock(&pcl->obj.lockref.lock);
>  
>  		if (page)
>  			put_page(page);
> @@ -718,31 +720,25 @@ int erofs_init_managed_cache(struct super_block *sb)
>  	return 0;
>  }
>  
> -static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> -				   struct z_erofs_bvec *bvec)
> -{
> -	struct z_erofs_pcluster *const pcl = fe->pcl;
> -
> -	while (fe->icur > 0) {
> -		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> -			     NULL, bvec->page)) {
> -			pcl->compressed_bvecs[fe->icur] = *bvec;
> -			return true;
> -		}
> -	}
> -	return false;
> -}
> -
>  /* callers must be with pcluster lock held */
>  static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>  			       struct z_erofs_bvec *bvec, bool exclusive)
>  {
> +	struct z_erofs_pcluster *pcl = fe->pcl;
>  	int ret;
>  
>  	if (exclusive) {
>  		/* give priority for inplaceio to use file pages first */
> -		if (z_erofs_try_inplace_io(fe, bvec))
> +		spin_lock(&pcl->obj.lockref.lock);
> +		while (fe->icur > 0) {
> +			if (pcl->compressed_bvecs[--fe->icur].page)
> +				continue;
> +			pcl->compressed_bvecs[fe->icur] = *bvec;
> +			spin_unlock(&pcl->obj.lockref.lock);
>  			return 0;
> +		}
> +		spin_unlock(&pcl->obj.lockref.lock);
> +
>  		/* otherwise, check if it can be used as a bvpage */
>  		if (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED &&
>  		    !fe->candidate_bvpage)
> @@ -1423,23 +1419,26 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  {
>  	gfp_t gfp = mapping_gfp_mask(mc);
>  	bool tocache = false;
> -	struct z_erofs_bvec *zbv = pcl->compressed_bvecs + nr;
> +	struct z_erofs_bvec zbv;
>  	struct address_space *mapping;
> -	struct page *page, *oldpage;
> +	struct page *page;
>  	int justfound, bs = i_blocksize(f->inode);
>  
>  	/* Except for inplace pages, the entire page can be used for I/Os */
>  	bvec->bv_offset = 0;
>  	bvec->bv_len = PAGE_SIZE;
>  repeat:
> -	oldpage = READ_ONCE(zbv->page);
> -	if (!oldpage)
> +	spin_lock(&pcl->obj.lockref.lock);
> +	zbv = pcl->compressed_bvecs[nr];
> +	page = zbv.page;
> +	justfound = (unsigned long)page & 1UL;
> +	page = (struct page *)((unsigned long)page & ~1UL);
> +	pcl->compressed_bvecs[nr].page = page;
> +	spin_unlock(&pcl->obj.lockref.lock);
> +	if (!page)
>  		goto out_allocpage;
>  
> -	justfound = (unsigned long)oldpage & 1UL;
> -	page = (struct page *)((unsigned long)oldpage & ~1UL);
>  	bvec->bv_page = page;
> -
>  	DBG_BUGON(z_erofs_is_shortlived_page(page));
>  	/*
>  	 * Handle preallocated cached pages.  We tried to allocate such pages
> @@ -1448,7 +1447,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	 */
>  	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
>  		set_page_private(page, 0);
> -		WRITE_ONCE(zbv->page, page);
>  		tocache = true;
>  		goto out_tocache;
>  	}
> @@ -1459,9 +1457,9 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	 * therefore it is impossible for `mapping` to be NULL.
>  	 */
>  	if (mapping && mapping != mc) {
> -		if (zbv->offset < 0)
> -			bvec->bv_offset = round_up(-zbv->offset, bs);
> -		bvec->bv_len = round_up(zbv->end, bs) - bvec->bv_offset;
> +		if (zbv.offset < 0)
> +			bvec->bv_offset = round_up(-zbv.offset, bs);
> +		bvec->bv_len = round_up(zbv.end, bs) - bvec->bv_offset;
>  		return;
>  	}
>  
> @@ -1471,7 +1469,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  
>  	/* the cached page is still in managed cache */
>  	if (page->mapping == mc) {
> -		WRITE_ONCE(zbv->page, page);
>  		/*
>  		 * The cached page is still available but without a valid
>  		 * `->private` pcluster hint.  Let's reconnect them.
> @@ -1503,11 +1500,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	put_page(page);
>  out_allocpage:
>  	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
> -	if (oldpage != cmpxchg(&zbv->page, oldpage, page)) {
> +	spin_lock(&pcl->obj.lockref.lock);
> +	if (pcl->compressed_bvecs[nr].page) {
>  		erofs_pagepool_add(&f->pagepool, page);
> +		spin_unlock(&pcl->obj.lockref.lock);
>  		cond_resched();
>  		goto repeat;
>  	}
> +	pcl->compressed_bvecs[nr].page = page;
> +	spin_unlock(&pcl->obj.lockref.lock);
>  	bvec->bv_page = page;
>  out_tocache:
>  	if (!tocache || bs != PAGE_SIZE ||
> @@ -1685,6 +1686,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  
>  			if (cur + bvec.bv_len > end)
>  				bvec.bv_len = end - cur;
> +			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
>  			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
>  					  bvec.bv_offset))
>  				goto submit_bio_retry;

Looks good to me.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
