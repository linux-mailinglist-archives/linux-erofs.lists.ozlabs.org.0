Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F862D4139
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 12:37:35 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrZlw37vszDqn4
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 22:37:32 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=bIk8SZpO; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GfBCNZXm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrZlf4x0nzDqkb
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 22:37:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607513833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMTe9C7qcftVcw8zf44iLqZBVP9hQiLfFpyxTSvwF5c=;
 b=bIk8SZpO3MvEoxj+mmFu5/fSOtM8pG9ZxP4gbNURlTRpjD9t5+335vvgX0tVcQP2ToQypQ
 jHSxBAv95MrM4oN6EhYljO02XNDFjVKxOk+c89HezAVGTedtU+lDO2+kaTAXTnGq2KNNVl
 PzZbffvNlvxPzhYgt/mPLBJ+kr4gZW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607513834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMTe9C7qcftVcw8zf44iLqZBVP9hQiLfFpyxTSvwF5c=;
 b=GfBCNZXm1s0Yaob9IlE6hpSH7cke/N0KXGboHAeEtuRvc0p2MCRpdtWFP0jOMy/yX1Py/e
 IpylWYcTsujj18AjuywokGVrMz8Cg1UdCtP8IzioFfI/Ktf3nIQ49cmBp7e/h/NIDhcFP5
 KNHUtkEaYD1DVYDsMyXDu+8E0DQUh28=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-76T7-omIP8imFdzkFB2H7g-1; Wed, 09 Dec 2020 06:37:11 -0500
X-MC-Unique: 76T7-omIP8imFdzkFB2H7g-1
Received: by mail-pj1-f71.google.com with SMTP id hg11so707394pjb.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Dec 2020 03:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yMTe9C7qcftVcw8zf44iLqZBVP9hQiLfFpyxTSvwF5c=;
 b=JsNF0kVSSKGK7CVbnegX1R3/8M4+MZK0+1a9An+bcekDPMvIpod0OWNriYP+C6746n
 xkE2XeiqNuAOMubb0QSgsGG78xxwcAtK50kWxRMGohXYiOlf4kRdCIZYePxo89Hrlb2i
 5H8cWiwofbb+cG9SZ4S0TEpeJ/5fqfx34LaQU84ZoA1bcDSl+07kgOn/7Y6zDtcY3klh
 +iF87G3RaJxagilSV4wT4l7UYyUSt/nRWJoN4Wm1eLUpXxxXVA2G+yGYPmilJZZCUPTu
 PaCOIn8mLGJADRGLsY/Bzsx+pXGshE9ksn3v/PfRla+pn6maiFioYE7EnmH4uqBQ1o18
 dvOQ==
X-Gm-Message-State: AOAM531FoZUhgdo/xtyZCYE1JO0NbeBR7v2Iae0LRq4wqIMewJaq2zMp
 l0gw1nnzuwyUUKCeiISLR/NLcdAz7PcysdMGTtdm3x3OuI67hTsYk38b6D6F542zsnV94zrt0V/
 Sp11+ruxsEVDTvPOsOvlgfH5k
X-Received: by 2002:a63:5a52:: with SMTP id k18mr1586712pgm.407.1607513830120; 
 Wed, 09 Dec 2020 03:37:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkrhAgNjRvpI+uz27vNND6MGzXsuOo53iWNCnYA8AUkRb5ViwDCwM2Ai865u+P15iUM9zcMg==
X-Received: by 2002:a63:5a52:: with SMTP id k18mr1586695pgm.407.1607513829922; 
 Wed, 09 Dec 2020 03:37:09 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e31sm2307483pgb.16.2020.12.09.03.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 03:37:09 -0800 (PST)
Date: Wed, 9 Dec 2020 19:36:58 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: force inplace I/O under low memory scenario
Message-ID: <20201209113658.GA115396@xiangao.remote.csb>
References: <20201208054600.16302-1-hsiangkao.ref@aol.com>
 <20201208054600.16302-1-hsiangkao@aol.com>
 <85f41db3-8d64-240a-7876-9f3b3dea29cb@huawei.com>
MIME-Version: 1.0
In-Reply-To: <85f41db3-8d64-240a-7876-9f3b3dea29cb@huawei.com>
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

On Wed, Dec 09, 2020 at 06:07:08PM +0800, Chao Yu wrote:
> On 2020/12/8 13:46, Gao Xiang wrote:

...

> >   	bool standalone = true;
> > +	gfp_t gfp = mapping_gfp_constraint(mc, GFP_KERNEL) & ~__GFP_DIRECT_RECLAIM;
> 
> Could be local as there is only one place uses it.

This line is somewhat too long, I have no idea how to deal
with it inlined properly... I think I might leave it as-is
or find a better way to fold in it without generating too
long lines....

Thanks,
Gao Xiang

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >   	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
> >   		return;
> > @@ -168,6 +175,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
> >   		struct page *page;
> >   		compressed_page_t t;
> > +		struct page *newpage = NULL;
> >   		/* the compressed page was loaded before */
> >   		if (READ_ONCE(*pages))
> > @@ -179,7 +187,17 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   			t = tag_compressed_page_justfound(page);
> >   		} else if (type == DELAYEDALLOC) {
> >   			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
> > +		} else if (type == TRYALLOC) {
> > +			gfp |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> > +
> > +			newpage = erofs_allocpage(pagepool, gfp);
> > +			if (!newpage)
> > +				goto dontalloc;
> > +
> > +			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
> > +			t = tag_compressed_page_justfound(newpage);
> >   		} else {	/* DONTALLOC */
> > +dontalloc:
> >   			if (standalone)
> >   				clt->compressedpages = pages;
> >   			standalone = false;
> > @@ -189,8 +207,12 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
> >   			continue;
> > -		if (page)
> > +		if (page) {
> >   			put_page(page);
> > +		} else if (newpage) {
> > +			set_page_private(newpage, 0);
> > +			list_add(&newpage->lru, pagepool);
> > +		}
> >   	}
> >   	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
> > @@ -560,7 +582,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
> >   }
> >   static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > -				struct page *page)
> > +				struct page *page, struct list_head *pagepool)
> >   {
> >   	struct inode *const inode = fe->inode;
> >   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> > @@ -613,11 +635,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >   	/* preload all compressed pages (maybe downgrade role if necessary) */
> >   	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
> > -		cache_strategy = DELAYEDALLOC;
> > +		cache_strategy = TRYALLOC;
> >   	else
> >   		cache_strategy = DONTALLOC;
> > -	preload_compressed_pages(clt, MNGD_MAPPING(sbi), cache_strategy);
> > +	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > +				 cache_strategy, pagepool);
> >   hitted:
> >   	/*
> > @@ -1011,6 +1034,16 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   	justfound = tagptr_unfold_tags(t);
> >   	page = tagptr_unfold_ptr(t);
> > +	/*
> > +	 * preallocated cached pages, which is used to avoid direct reclaim
> > +	 * otherwise, it will go inplace I/O path instead.
> > +	 */
> > +	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> > +		WRITE_ONCE(pcl->compressed_pages[nr], page);
> > +		set_page_private(page, 0);
> > +		tocache = true;
> > +		goto out_tocache;
> > +	}
> >   	mapping = READ_ONCE(page->mapping);
> >   	/*
> > @@ -1073,7 +1106,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   		cond_resched();
> >   		goto repeat;
> >   	}
> > -
> > +out_tocache:
> >   	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
> >   		/* turn into temporary page if fails */
> >   		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> > @@ -1282,7 +1315,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
> >   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
> > -	err = z_erofs_do_read_page(&f, page);
> > +	err = z_erofs_do_read_page(&f, page, &pagepool);
> >   	(void)z_erofs_collector_end(&f.clt);
> >   	/* if some compressed cluster ready, need submit them anyway */
> > @@ -1336,7 +1369,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
> >   		/* traversal in reverse order */
> >   		head = (void *)page_private(page);
> > -		err = z_erofs_do_read_page(&f, page);
> > +		err = z_erofs_do_read_page(&f, page, &pagepool);
> >   		if (err)
> >   			erofs_err(inode->i_sb,
> >   				  "readahead error at page %lu @ nid %llu",
> > 
> 

