Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B22D268B
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 09:49:28 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cqv4P263TzDqTv
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Dec 2020 19:49:25 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=ZrixKqqL; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZrixKqqL; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cqv4K0kR7zDqBK
 for <linux-erofs@lists.ozlabs.org>; Tue,  8 Dec 2020 19:49:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607417358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVKEmPz+hR1MOnlGTe8fbrRzGCLUHNQb/QoMNYY2V2c=;
 b=ZrixKqqLsd9VN32XjHatbYfxQQJAQaDTQvOA++m2Pa0qBDif5mxnyTLkYi6dJNXCDOJs0+
 jVslkoCoqa/R+1Dvw8l8RB6XjC3tgEHD6vBjIvCQr6nHsUzBJZv/BufojmRMnC9EaVqsya
 cxnkYf/qN8fYhM2G9M7g9tBCSgol38I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607417358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVKEmPz+hR1MOnlGTe8fbrRzGCLUHNQb/QoMNYY2V2c=;
 b=ZrixKqqLsd9VN32XjHatbYfxQQJAQaDTQvOA++m2Pa0qBDif5mxnyTLkYi6dJNXCDOJs0+
 jVslkoCoqa/R+1Dvw8l8RB6XjC3tgEHD6vBjIvCQr6nHsUzBJZv/BufojmRMnC9EaVqsya
 cxnkYf/qN8fYhM2G9M7g9tBCSgol38I=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-MCeeG_j1Pi6c_SUV-Y-FMA-1; Tue, 08 Dec 2020 03:49:16 -0500
X-MC-Unique: MCeeG_j1Pi6c_SUV-Y-FMA-1
Received: by mail-pl1-f197.google.com with SMTP id u14so889794plx.23
 for <linux-erofs@lists.ozlabs.org>; Tue, 08 Dec 2020 00:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FVKEmPz+hR1MOnlGTe8fbrRzGCLUHNQb/QoMNYY2V2c=;
 b=Au4PNS2SjXbyAQnG0dCe0kOdGZt7jPzMXVDIz/UwU/n7bJWd7ZTYuscOqbI8H+43eF
 DGosmhXRCH76TKLHpu0IEgvBwLGDPfAtw6zW11J/9sddYOPIbEFpnCZQ44RnrLZN30Dq
 gwjIMmD1Et+oLD9pUNK3wXCfabPAEq13nOrR8efnOx3jDOMV2pYKbkLXat4v2JNUtehL
 77wY0fejjfnJnNAuFV9hdGzF1ISd+jpoEVPChTcmDTttNIku8JxaZTBnutNACCs8HVjb
 M8OCkR/lDxZk+MtdHdxKOBqRvSJueLVGsvMhKbF6zhWy595rQFtXqEf5MATEAclobczI
 uhBQ==
X-Gm-Message-State: AOAM530rXfqtRD2bGIwiJMAZtFWJHIn8GzcTXKtPMwxiz+7l+XLBzsaL
 ZF4QxBZ57ZfkDSwzkam6F++Yn/BMNNhukn/WLO/tBdnSEC3d+CQqzYZEJ5zhTZIH868eA9Yxrt4
 WLMuwxIYRzMUERNEfpXtnYh5g
X-Received: by 2002:a17:90b:14d3:: with SMTP id
 jz19mr3328899pjb.196.1607417355192; 
 Tue, 08 Dec 2020 00:49:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVVwLl/tb5ygU0mRdNtU1CDi3sGfGi/JjDj/VNYM/43xNAydkYfbdc6OZgWcOAuFtBetv1xg==
X-Received: by 2002:a17:90b:14d3:: with SMTP id
 jz19mr3328880pjb.196.1607417354921; 
 Tue, 08 Dec 2020 00:49:14 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b8sm14983646pgk.7.2020.12.08.00.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:49:14 -0800 (PST)
Date: Tue, 8 Dec 2020 16:49:04 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208084904.GA3060163@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
 <20201208082319.GB3006985@xiangao.remote.csb>
 <7da6fe17-1257-67e7-379c-99a0ebbe6ba4@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7da6fe17-1257-67e7-379c-99a0ebbe6ba4@huawei.com>
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

On Tue, Dec 08, 2020 at 04:44:12PM +0800, Chao Yu wrote:
> Hi Xiang,

...

> > 
> > I discussed this case in the original thread,
> > https://lore.kernel.org/r/20200519100612.GA3687@hsiangkao-HP-ZHAN-66-Pro-G1
> > 
> > The previous conclusion is that for EROFS case (see Matthew's reply) this
> > pair won't have too much usage. since EROFS pattern saves extra page
> > reference count (- and +) by cases.
> 
> Alright, I see.

Yeah, yet in order for further confusion (or questions from others), let me
update to use this pair as much as possible in the next version :( (If someone
breaks in the future, I may need to remind him in time though...)

> 

...

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks for the review!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > Thanks,
> > > 
> > > >    		}
> > > > @@ -648,12 +649,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > > >    retry:
> > > >    	err = z_erofs_attach_page(clt, page, page_type);
> > > > -	/* should allocate an additional staging page for pagevec */
> > > > +	/* should allocate an additional short-lived page for pagevec */
> > > >    	if (err == -EAGAIN) {
> > > >    		struct page *const newpage =
> > > >    				alloc_page(GFP_NOFS | __GFP_NOFAIL);
> > > > -		newpage->mapping = Z_EROFS_MAPPING_STAGING;
> > > > +		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> > > >    		err = z_erofs_attach_page(clt, newpage,
> > > >    					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
> > > >    		if (!err)
> > > > @@ -710,6 +711,11 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
> > > >    		queue_work(z_erofs_workqueue, &io->u.work);
> > > >    }
> > > > +static bool z_erofs_page_is_invalidated(struct page *page)
> > > > +{
> > > > +	return !page->mapping && !z_erofs_is_shortlived_page(page);
> > > > +}
> > > > +
> > > >    static void z_erofs_decompressqueue_endio(struct bio *bio)
> > > >    {
> > > >    	tagptr1_t t = tagptr_init(tagptr1_t, bio->bi_private);
> > > > @@ -722,7 +728,7 @@ static void z_erofs_decompressqueue_endio(struct bio *bio)
> > > >    		struct page *page = bvec->bv_page;
> > > >    		DBG_BUGON(PageUptodate(page));
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > >    		if (err)
> > > >    			SetPageError(page);
> > > > @@ -795,9 +801,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		/* all pages in pagevec ought to be valid */
> > > >    		DBG_BUGON(!page);
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		if (z_erofs_put_stagingpage(pagepool, page))
> > > > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> > > >    			continue;
> > > >    		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> > > > @@ -831,9 +837,9 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		/* all compressed pages ought to be valid */
> > > >    		DBG_BUGON(!page);
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		if (!z_erofs_page_is_staging(page)) {
> > > > +		if (!z_erofs_is_shortlived_page(page)) {
> > > >    			if (erofs_page_is_managed(sbi, page)) {
> > > >    				if (!PageUptodate(page))
> > > >    					err = -EIO;
> > > > @@ -858,7 +864,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    			overlapped = true;
> > > >    		}
> > > > -		/* PG_error needs checking for inplaced and staging pages */
> > > > +		/* PG_error needs checking for all non-managed pages */
> > > >    		if (PageError(page)) {
> > > >    			DBG_BUGON(PageUptodate(page));
> > > >    			err = -EIO;
> > > > @@ -897,8 +903,8 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		if (erofs_page_is_managed(sbi, page))
> > > >    			continue;
> > > > -		/* recycle all individual staging pages */
> > > > -		(void)z_erofs_put_stagingpage(pagepool, page);
> > > > +		/* recycle all individual short-lived pages */
> > > > +		(void)z_erofs_put_shortlivedpage(pagepool, page);
> > > >    		WRITE_ONCE(compressed_pages[i], NULL);
> > > >    	}
> > > > @@ -908,10 +914,10 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > > >    		if (!page)
> > > >    			continue;
> > > > -		DBG_BUGON(!page->mapping);
> > > > +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > > > -		/* recycle all individual staging pages */
> > > > -		if (z_erofs_put_stagingpage(pagepool, page))
> > > > +		/* recycle all individual short-lived pages */
> > > > +		if (z_erofs_put_shortlivedpage(pagepool, page))
> > > >    			continue;
> > > >    		if (err < 0)
> > > > @@ -1011,13 +1017,17 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> > > >    	mapping = READ_ONCE(page->mapping);
> > > >    	/*
> > > > -	 * unmanaged (file) pages are all locked solidly,
> > > > +	 * file-backed online pages in plcuster are all locked steady,
> > > >    	 * therefore it is impossible for `mapping' to be NULL.
> > > >    	 */
> > > >    	if (mapping && mapping != mc)
> > > >    		/* ought to be unmanaged pages */
> > > >    		goto out;
> > > > +	/* directly return for shortlived page as well */
> > > > +	if (z_erofs_is_shortlived_page(page))
> > > > +		goto out;
> > > > +
> > > >    	lock_page(page);
> > > >    	/* only true if page reclaim goes wrong, should never happen */
> > > > @@ -1062,8 +1072,8 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> > > >    out_allocpage:
> > > >    	page = erofs_allocpage(pagepool, gfp | __GFP_NOFAIL);
> > > >    	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
> > > > -		/* non-LRU / non-movable temporary page is needed */
> > > > -		page->mapping = Z_EROFS_MAPPING_STAGING;
> > > > +		/* turn into temporary page if fails */
> > > > +		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> > > >    		tocache = false;
> > > >    	}
> > > > diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> > > > index 68c9b29fc0ca..b503b353d4ab 100644
> > > > --- a/fs/erofs/zdata.h
> > > > +++ b/fs/erofs/zdata.h
> > > > @@ -173,6 +173,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
> > > >    	v = atomic_dec_return(u.o);
> > > >    	if (!(v & Z_EROFS_ONLINEPAGE_COUNT_MASK)) {
> > > > +		set_page_private(page, 0);
> > > >    		ClearPagePrivate(page);
> > > >    		if (!PageError(page))
> > > >    			SetPageUptodate(page);
> > > > 
> > > 
> > 
> > .
> > 
> 

