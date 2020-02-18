Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7C163606
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 23:22:41 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mb2Q6yVbzDqcG
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 09:22:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64;
 helo=hqnvemgate25.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=sMCo+kzH; dkim-atps=neutral
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Mb2G3C3wzDqYV
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 09:22:29 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c63810000>; Tue, 18 Feb 2020 14:21:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 14:22:25 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 14:22:25 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 22:22:25 +0000
Subject: Re: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-4-willy@infradead.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <e42273c5-1528-73d1-7a1c-6cc4253ddf5c@nvidia.com>
Date: Tue, 18 Feb 2020 14:22:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-4-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582064513; bh=ZZ7ZnXmWS/+25lCnS0Msc4oVcTYWx35dNubCQJlyios=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=sMCo+kzHChvgZdHGQm3ugwe95Yy3u85k0iTNa8iFdKNEtWD62hxHdqvdgNNSjtdxb
 enTEGW/SfVJLCHfbmpjg9Jefzr0FSn8p03k0hmK3im6emR6FuRzJ4Kjh2jAGWCPOAZ
 AJRFKt4RYh6NxqnG9BlGHsnneYy9zTg2CqrTbBftfsZBMhcHh5fR/jXoDtYl395Lyn
 GfNFP9aWRVAzaXP3VMZv/tOL1A3fARHojujr1xyeVhMxRRfK5C11alx3JJspYdo8HS
 n4v0x5ZPHFSa3fu1BIfcU7dkxH9vREijE68noNdkb+cNvvV8S4dd0wqjChm3q9T+nM
 7MAerZ+gnJAQw==
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> In this patch, only between __do_page_cache_readahead() and
> read_pages(), but it will be extended in upcoming patches.  Also add
> the readahead_count() accessor.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 17 +++++++++++++++++
>  mm/readahead.c          | 36 +++++++++++++++++++++---------------
>  2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..982ecda2d4a2 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -630,6 +630,23 @@ static inline int add_to_page_cache(struct page *page,
>  	return error;
>  }
>  
> +/*
> + * Readahead is of a block of consecutive pages.
> + */
> +struct readahead_control {
> +	struct file *file;
> +	struct address_space *mapping;
> +/* private: use the readahead_* accessors instead */


Really a minor point, sorry...what about documenting "input", "output", 
"input/output" instead? I ask because:

a) public and private seems sort of meaningless here: even in this initial
   patch, the code starts off by setting .file, .mapping, and .nr_pages.

b) The part that's confusing, and that might benefit from either documentation
   or naming changes, is the way _nr_pages is used. Is it "number of pages
   requested to read ahead", or "number of pages just read", or number of
   pages remaining to be read"? I've had trouble keeping it straight because
   I recall it being used differently at different points.


> +	pgoff_t _start;
> +	unsigned int _nr_pages;
> +};
> +
> +/* The number of pages in this readahead block */
> +static inline unsigned int readahead_count(struct readahead_control *rac)
> +{
> +	return rac->_nr_pages;
> +}


I took a peek at the generated code, and was reassured to see that this realy
does work even in the "for" loops. Once in a while I like to get my faith in
the compiler renewed. :)

> +
>  static inline unsigned long dir_pages(struct inode *inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 12d13b7792da..15329309231f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,26 +113,29 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static void read_pages(struct address_space *mapping, struct file *filp,
> -		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
> +static void read_pages(struct readahead_control *rac, struct list_head *pages,
> +		gfp_t gfp)
>  {
> +	const struct address_space_operations *aops = rac->mapping->a_ops;
>  	struct blk_plug plug;
>  	unsigned page_idx;
>  
>  	blk_start_plug(&plug);
>  
> -	if (mapping->a_ops->readpages) {
> -		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +	if (aops->readpages) {
> +		aops->readpages(rac->file, rac->mapping, pages,
> +				readahead_count(rac));
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  		goto out;
>  	}
>  
> -	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
> +	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
>  		struct page *page = lru_to_page(pages);
>  		list_del(&page->lru);
> -		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
> -			mapping->a_ops->readpage(filp, page);
> +		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
> +				gfp))
> +			aops->readpage(rac->file, page);
>  		put_page(page);
>  	}
>  
> @@ -155,9 +158,13 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;
> -	unsigned int nr_pages = 0;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> +	struct readahead_control rac = {
> +		.mapping = mapping,
> +		.file = filp,
> +		._nr_pages = 0,
> +	};
>  
>  	if (isize == 0)
>  		return;
> @@ -180,10 +187,9 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  			 * contiguous pages before continuing with the next
>  			 * batch.
>  			 */
> -			if (nr_pages)
> -				read_pages(mapping, filp, &page_pool, nr_pages,
> -						gfp_mask);
> -			nr_pages = 0;
> +			if (readahead_count(&rac))
> +				read_pages(&rac, &page_pool, gfp_mask);
> +			rac._nr_pages = 0;
>  			continue;
>  		}
>  
> @@ -194,7 +200,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		list_add(&page->lru, &page_pool);
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
> -		nr_pages++;
> +		rac._nr_pages++;
>  	}
>  
>  	/*
> @@ -202,8 +208,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * uptodate then the caller will launch readpage again, and
>  	 * will then handle the error.
>  	 */
> -	if (nr_pages)
> -		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
> +	if (readahead_count(&rac))
> +		read_pages(&rac, &page_pool, gfp_mask);
>  	BUG_ON(!list_empty(&page_pool));
>  }
>  
> 

In any case, this patch faithfully preserves the existing logic, so regardless of any
documentation decisions, 

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
