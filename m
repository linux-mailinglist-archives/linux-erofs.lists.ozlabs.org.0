Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56F163A4B
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 03:36:03 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mhfm4P2szDqgd
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 13:36:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Mhfc4pdxzDqdZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 13:35:49 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 83358F8D75B7100BDEA5;
 Wed, 19 Feb 2020 10:35:42 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 10:35:42 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 19 Feb 2020 10:35:41 +0800
Date: Wed, 19 Feb 2020 10:34:22 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 11/16] erofs: Convert compressed files from readpages
 to readahead
Message-ID: <20200219023422.GA83440@architecture4>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-20-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 17, 2020 at 10:46:00AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in erofs.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

It looks good to me, although some further optimization exists
but we could make a straight-forward transform first, and
I haven't tested the whole series for now...
Will test it later.

Acked-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zdata.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 17f45fcb8c5c..7c02015d501d 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1303,28 +1303,23 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
>  	return nr <= sbi->max_sync_decompress_pages;
>  }
>  
> -static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
> -			     struct list_head *pages, unsigned int nr_pages)
> +static void z_erofs_readahead(struct readahead_control *rac)
>  {
> -	struct inode *const inode = mapping->host;
> +	struct inode *const inode = rac->mapping->host;
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
>  
> -	bool sync = should_decompress_synchronously(sbi, nr_pages);
> +	bool sync = should_decompress_synchronously(sbi, readahead_count(rac));
>  	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
> -	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
> -	struct page *head = NULL;
> +	struct page *page, *head = NULL;
>  	LIST_HEAD(pagepool);
>  
> -	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
> -			      nr_pages, false);
> +	trace_erofs_readpages(inode, readahead_index(rac),
> +			readahead_count(rac), false);
>  
> -	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
> -
> -	for (; nr_pages; --nr_pages) {
> -		struct page *page = lru_to_page(pages);
> +	f.headoffset = readahead_offset(rac);
>  
> +	readahead_for_each(rac, page) {
>  		prefetchw(&page->flags);
> -		list_del(&page->lru);
>  
>  		/*
>  		 * A pure asynchronous readahead is indicated if
> @@ -1333,11 +1328,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
>  		 */
>  		sync &= !(PageReadahead(page) && !head);
>  
> -		if (add_to_page_cache_lru(page, mapping, page->index, gfp)) {
> -			list_add(&page->lru, &pagepool);
> -			continue;
> -		}
> -
>  		set_page_private(page, (unsigned long)head);
>  		head = page;
>  	}
> @@ -1366,11 +1356,10 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
>  
>  	/* clean up the remaining free pages */
>  	put_pages_list(&pagepool);
> -	return 0;
>  }
>  
>  const struct address_space_operations z_erofs_aops = {
>  	.readpage = z_erofs_readpage,
> -	.readpages = z_erofs_readpages,
> +	.readahead = z_erofs_readahead,
>  };
>  
> -- 
> 2.25.0
> 
> 
