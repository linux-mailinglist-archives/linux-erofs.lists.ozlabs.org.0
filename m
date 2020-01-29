Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BDD14C444
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 01:57:55 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486lTD6YFrzDqNK
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 11:57:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mail105.syd.optusnet.com.au (client-ip=211.29.132.249;
 helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=fromorbit.com
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by lists.ozlabs.org (Postfix) with ESMTP id 486lT44Dx1zDqN8
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jan 2020 11:57:43 +1100 (AEDT)
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au
 [49.195.111.217])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 57DB03A1476;
 Wed, 29 Jan 2020 11:57:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1iwbfp-0005wG-QY; Wed, 29 Jan 2020 11:57:41 +1100
Date: Wed, 29 Jan 2020 11:57:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200129005741.GJ18610@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-8-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
 a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
 a=JfrnYn6hAAAA:8 a=voM4FWlXAAAA:8 a=7-415B0cAAAA:8 a=ARdszsHN92wWq2Ddru8A:9
 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
 a=biEYGPWJfzWAr4FL6Ov7:22
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 24, 2020 at 05:35:48PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in erofs.  Fix what I believe to be
> a refcounting bug in the error case.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-erofs@lists.ozlabs.org
> ---
>  fs/erofs/data.c              | 34 ++++++++++++++--------------------
>  fs/erofs/zdata.c             |  2 +-
>  include/trace/events/erofs.h |  6 +++---
>  3 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fc3a8d8064f8..335c1ab05312 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -280,42 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
>  	return 0;
>  }
>  
> -static int erofs_raw_access_readpages(struct file *filp,
> +static unsigned erofs_raw_access_readahead(struct file *file,
>  				      struct address_space *mapping,
> -				      struct list_head *pages,
> +				      pgoff_t start,
>  				      unsigned int nr_pages)
>  {
>  	erofs_off_t last_block;
>  	struct bio *bio = NULL;
> -	gfp_t gfp = readahead_gfp_mask(mapping);
> -	struct page *page = list_last_entry(pages, struct page, lru);
>  
> -	trace_erofs_readpages(mapping->host, page, nr_pages, true);
> +	trace_erofs_readpages(mapping->host, start, nr_pages, true);
>  
>  	for (; nr_pages; --nr_pages) {
> -		page = list_entry(pages->prev, struct page, lru);
> +		struct page *page = readahead_page(mapping, start++);
>  
>  		prefetchw(&page->flags);
> -		list_del(&page->lru);
>  
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
> -			bio = erofs_read_raw_page(bio, mapping, page,
> -						  &last_block, nr_pages, true);
> +		bio = erofs_read_raw_page(bio, mapping, page, &last_block,
> +				nr_pages, true);
>  
> -			/* all the page errors are ignored when readahead */
> -			if (IS_ERR(bio)) {
> -				pr_err("%s, readahead error at page %lu of nid %llu\n",
> -				       __func__, page->index,
> -				       EROFS_I(mapping->host)->nid);
> +		/* all the page errors are ignored when readahead */
> +		if (IS_ERR(bio)) {
> +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> +			       __func__, page->index,
> +			       EROFS_I(mapping->host)->nid);
>  
> -				bio = NULL;
> -			}
> +			bio = NULL;
> +			put_page(page);
>  		}
>  
> -		/* pages could still be locked */
>  		put_page(page);

A double put_page() on error?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
