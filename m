Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 113812D25C4
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 09:23:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CqtVl2NvlzDqWf
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 19:23:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QCOe8M4Q; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoF2GyD8; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CqtVd4xG1zDqBr
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 19:23:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607415814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCLglRVFXwfDJ50Qfkr7jITr2lPUCffHrwsJCz37dKo=;
 b=QCOe8M4QiAvezqg/CE7u4X/xiZeMOMX9pG6F+1HCz9UxpfszXacN9oHqyUC36HTxuTehqF
 jGbZ/ycl7OJRZevZ9vH9ZMPfIA65aNC3dMQ2NIu+itYrvj/+GFWOGe12I0EXBA3H90zSap
 sLx8wudgiGnk9bWOhW5JVBBQtyXe6tA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607415815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCLglRVFXwfDJ50Qfkr7jITr2lPUCffHrwsJCz37dKo=;
 b=eoF2GyD8FD9QCE9BhvgFjVDKHpK33GmVISODqxu0/YbKef2n/wahjpP/MyXm44EURgr02i
 V/Ktdcif9C1xlZ9Ukg2b7qh9lhmEqs5Jf/ghGtfX6ThJerxWODbJFtkHf+5bR3OW81E9f6
 C+WQ3AFZf6VGOIQtCBMBxniAq5XH/Ug=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-CJZvUNtcNKW8iHtrfLZ0RQ-1; Tue, 08 Dec 2020 03:23:30 -0500
X-MC-Unique: CJZvUNtcNKW8iHtrfLZ0RQ-1
Received: by mail-pl1-f199.google.com with SMTP id c12so6481539pll.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rCLglRVFXwfDJ50Qfkr7jITr2lPUCffHrwsJCz37dKo=;
 b=E6qwHLU7okXHsBa6amMYcIl+uusueJuymKRuycCyZZFQrOd8K62jkbxnbI4YrjojcJ
 qslZ8H621Yr/5GQ22oSyyWFi8AWEBCcK7LrMjoBrVtNnY8IafRLkQwP7WU57XPHb/DWB
 1nDmT0tenOkINz8LZoWEvLRCzx0Ny3TjMIzE1Mw7lWeXl/jfAHMNHpXjYZdL/gsMUom8
 BFXvSJhE4RGNogsQUiMfGYTw4bHv8ZpisBCCrbTRGWghN3+hlVlur2am3TiVD/gfoSXk
 MRdxegOlayOf9lOOsjPlUt9OejRN8IxySi/tyshDw852WvvEucvHjUviFF3NRhjYqjNW
 5aUw==
X-Gm-Message-State: AOAM533x3MihxXEUXJxFmuM/+4atfjNfGAiHTfNmSf0GvG/iVQWjPHjY
 mx76F2zxM/dKes0ftNNelIvHJQ0Xj4g5lf0zSQiUiHICX0QMymk+oIMSgAuZhYDZX946bFxNhVw
 tOblEf/aRS+mO7ezN6UbDb+re
X-Received: by 2002:aa7:8003:0:b029:197:eb02:d711 with SMTP id
 j3-20020aa780030000b0290197eb02d711mr19721242pfi.72.1607415809799; 
 Tue, 08 Dec 2020 00:23:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfsmd6LVndY47lVHe5v8EG4dfMU8A2lQdYJSRrbMDHFs33oIPsComHIy5TwtwZx190AnLMTw==
X-Received: by 2002:aa7:8003:0:b029:197:eb02:d711 with SMTP id
 j3-20020aa780030000b0290197eb02d711mr19721224pfi.72.1607415809401; 
 Tue, 08 Dec 2020 00:23:29 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u7sm1968840pjj.56.2020.12.08.00.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:23:28 -0800 (PST)
Date: Tue, 8 Dec 2020 16:23:19 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208082319.GB3006985@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
MIME-Version: 1.0
In-Reply-To: <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, Dec 08, 2020 at 04:15:59PM +0800, Chao Yu wrote:
> On 2020/12/7 9:23, Gao Xiang wrote:
> > Previously, we played around with magical page->mapping for short-lived
> > temporary pages since we need to identify different types of pages in
> > the same pcluster but both invalidated and short-lived temporary pages
> > can have page->mapping == NULL. It was considered as safe because that
> > temporary pages are all non-LRU / non-movable pages.
> > 
> > This patch tends to use specific page->private to identify short-lived
> > pages instead so it won't rely on page->mapping anymore. Details are
> > described in "compress.h" as well.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> > tested with ro_fsstress for a whole night.
> > 
> > The old "[PATCH 4/4] erofs: complete a missing case for inplace I/O" is
> > temporarily dropped since ro_fsstress failed with such modification,
> > will look into later.
> > 
> >   fs/erofs/compress.h     | 50 ++++++++++++++++++++++++++++++-----------
> >   fs/erofs/decompressor.c |  2 +-
> >   fs/erofs/zdata.c        | 42 +++++++++++++++++++++-------------
> >   fs/erofs/zdata.h        |  1 +
> >   4 files changed, 65 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> > index 3d452443c545..2bbf47f353ef 100644
> > --- a/fs/erofs/compress.h
> > +++ b/fs/erofs/compress.h
> > @@ -26,30 +26,54 @@ struct z_erofs_decompress_req {
> >   	bool inplace_io, partial_decoding;
> >   };
> > +#define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
> > +
> >   /*
> > - * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
> > - * used to mark temporary allocated pages from other
> > - * file/cached pages and NULL mapping pages.
> > + * For all pages in a pcluster, page->private should be one of
> > + * Type                         Last 2bits      page->private
> > + * short-lived page             00              Z_EROFS_SHORTLIVED_PAGE
> > + * cached/managed page          00              pointer to z_erofs_pcluster
> > + * online page (file-backed,    01/10/11        sub-index << 2 | count
> > + *              some pages can be used for inplace I/O)
> > + *
> > + * page->mapping should be one of
> > + * Type                 page->mapping
> > + * short-lived page     NULL
> > + * cached/managed page  non-NULL or NULL (invalidated/truncated page)
> > + * online page          non-NULL
> > + *
> > + * For all managed pages, PG_private should be set with 1 extra refcount,
> > + * which is used for page reclaim / migration.
> 
> FYI, there is a generic way to set/clear page_private, it binds the private
> value set and page count operation in one function:
> 
> attach_page_private()
> detach_page_private()
> 
> If there are use cases, let's try to use them as much as possible.

I discussed this case in the original thread,
https://lore.kernel.org/r/20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1

The previous conclusion is that for EROFS case (see Matthew's reply) this
pair won't have too much usage. since EROFS pattern saves extra page
reference count (- and +) by cases.

I could use attach_page_private() and detach_page_private() if possible,
but the problem is I'm not not its such pair internal implementation is
stable (but the PG_Private rule is stable for decades); 

> 
> >    */
> > -#define Z_EROFS_MAPPING_STAGING         ((void *)0x5A110C8D)
> > -/* check if a page is marked as staging */
> > -static inline bool z_erofs_page_is_staging(struct page *page)
> > +/*
> > + * short-lived pages are pages directly from buddy system with specific
> > + * page->private (no need to set PagePrivate since these are non-LRU /
> > + * non-movable pages and bypass reclaim / migration code).
> > + */
> > +static inline bool z_erofs_is_shortlived_page(struct page *page)
> >   {
> > -	return page->mapping == Z_EROFS_MAPPING_STAGING;
> > +	if (page->private != Z_EROFS_SHORTLIVED_PAGE)
> > +		return false;
> > +
> > +	DBG_BUGON(page->mapping);
> > +	return true;
> >   }
> > -static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
> > -					   struct page *page)
> > +static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
> > +					      struct page *page)
> >   {
> > -	if (!z_erofs_page_is_staging(page))
> > +	if (!z_erofs_is_shortlived_page(page))
> >   		return false;
> > -	/* staging pages should not be used by others at the same time */
> > -	if (page_ref_count(page) > 1)
> > +	/* short-lived pages should not be used by others at the same time */
> > +	if (page_ref_count(page) > 1) {
> 
> Does this be a possible case?

Yes, see decompress.c, if will get_page(page);

> 
> >   		put_page(page);
> > -	else
> > +	} else {
> > +		/* follow the pcluster rule above. */
> > +		set_page_private(page, 0);
> >   		list_add(&page->lru, pagepool);
> > +	}
> >   	return true;
> >   }
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index cbadbf55c6c2..1cb1ffd10569 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -76,7 +76,7 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> >   			if (!victim)
> >   				return -ENOMEM;
> > -			victim->mapping = Z_EROFS_MAPPING_STAGING;
> > +			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> >   		}
> >   		rq->out[i] = victim;
> >   	}
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 86fd3bf62af6..afeadf413c2c 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -255,6 +255,7 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
> >   		erofs_workgroup_unfreeze(&pcl->obj, 1);
> >   		if (ret) {
> > +			set_page_private(page, 0);
> >   			ClearPagePrivate(page);
> >   			put_page(page);
> 
> detach_page_private()?

The same as the above.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> >   		}
> > @@ -648,12 +649,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >   retry:
> >   	err = z_erofs_attach_page(clt, page, page_type);
> > -	/* should allocate an additional staging page for pagevec */
> > +	/* should allocate an additional short-lived page for pagevec */
> >   	if (err == -EAGAIN) {
> >   		struct page *const newpage =
> >   				alloc_page(GFP_NOFS | __GFP_NOFAIL);
> > -		newpage->mapping = Z_EROFS_MAPPING_STAGING;
> > +		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> >   		err = z_erofs_attach_page(clt, newpage,
> >   					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> >   		if (!err)
> > @@ -710,6 +711,11 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> >   		queue_work(z_erofs_workqueue, &io->u.work);
> >   }
> > +static bool z_erofs_page_is_invalidated(struct page *page)
> > +{
> > +	return !page->mapping && !z_erofs_is_shortlived_page(page);
> > +}
> > +
> >   static void z_erofs_decompressqueue_endio(struct bio *bio)
> >   {
> >   	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> > @@ -722,7 +728,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
> >   		struct page *page = bvec->bv_page;
> >   		DBG_BUGON(PageUptodate(page));
> > -		DBG_BUGON(!page->mapping);
> > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> >   		if (err)
> >   			SetPageError(page);
> > @@ -795,9 +801,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >   		/* all pages in pagevec ought to be valid */
> >   		DBG_BUGON(!page);
> > -		DBG_BUGON(!page->mapping);
> > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > -		if (z_erofs_put_stagingpage(pagepool, page))
> > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> >   			continue;
> >   		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> > @@ -831,9 +837,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >   		/* all compressed pages ought to be valid */
> >   		DBG_BUGON(!page);
> > -		DBG_BUGON(!page->mapping);
> > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > -		if (!z_erofs_page_is_staging(page)) {
> > +		if (!z_erofs_is_shortlived_page(page)) {
> >   			if (erofs_page_is_managed(sbi, page)) {
> >   				if (!PageUptodate(page))
> >   					err = -EIO;
> > @@ -858,7 +864,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >   			overlapped = true;
> >   		}
> > -		/* PG_error needs checking for inplaced and staging pages */
> > +		/* PG_error needs checking for all non-managed pages */
> >   		if (PageError(page)) {
> >   			DBG_BUGON(PageUptodate(page));
> >   			err = -EIO;
> > @@ -897,8 +903,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >   		if (erofs_page_is_managed(sbi, page))
> >   			continue;
> > -		/* recycle all individual staging pages */
> > -		(void)z_erofs_put_stagingpage(pagepool, page);
> > +		/* recycle all individual short-lived pages */
> > +		(void)z_erofs_put_shortlivedpage(pagepool, page);
> >   		WRITE_ONCE(compressed_pages[i], NULL);
> >   	}
> > @@ -908,10 +914,10 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >   		if (!page)
> >   			continue;
> > -		DBG_BUGON(!page->mapping);
> > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > -		/* recycle all individual staging pages */
> > -		if (z_erofs_put_stagingpage(pagepool, page))
> > +		/* recycle all individual short-lived pages */
> > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> >   			continue;
> >   		if (err < 0)
> > @@ -1011,13 +1017,17 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   	mapping = READ_ONCE(page->mapping);
> >   	/*
> > -	 * unmanaged (file) pages are all locked solidly,
> > +	 * file-backed online pages in plcuster are all locked steady,
> >   	 * therefore it is impossible for `mapping' to be NULL.
> >   	 */
> >   	if (mapping && mapping != mc)
> >   		/* ought to be unmanaged pages */
> >   		goto out;
> > +	/* directly return for shortlived page as well */
> > +	if (z_erofs_is_shortlived_page(page))
> > +		goto out;
> > +
> >   	lock_page(page);
> >   	/* only true if page reclaim goes wrong, should never happen */
> > @@ -1062,8 +1072,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   out_allocpage:
> >   	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
> >   	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
> > -		/* non-LRU / non-movable temporary page is needed */
> > -		page->mapping = Z_EROFS_MAPPING_STAGING;
> > +		/* turn into temporary page if fails */
> > +		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> >   		tocache = false;
> >   	}
> > diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> > index 68c9b29fc0ca..b503b353d4ab 100644
> > --- a/fs/erofs/zdata.h
> > +++ b/fs/erofs/zdata.h
> > @@ -173,6 +173,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
> >   	v = atomic_dec_return(u.o);
> >   	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
> > +		set_page_private(page, 0);
> >   		ClearPagePrivate(page);
> >   		if (!PageError(page))
> >   			SetPageUptodate(page);
> > 
> 

