Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069615D06A
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 04:25:15 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Jdzr3xSJzDqXV
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 14:25:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.143;
 helo=hqnvemgate24.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=sOVfkNWL; dkim-atps=neutral
X-Greylist: delayed 307 seconds by postgrey-1.36 at bilbo;
 Fri, 14 Feb 2020 14:25:06 AEDT
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Jdzk54bMzDqS0
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2020 14:25:05 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4611980000>; Thu, 13 Feb 2020 19:18:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 13 Feb 2020 19:19:54 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 13 Feb 2020 19:19:54 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 03:19:53 +0000
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e0f459af-bb5d-58b9-78be-5adf687477c0@nvidia.com>
Date: Thu, 13 Feb 2020 19:19:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211010348.6872-2-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581650328; bh=RNaZ4JfNFDU0NcYE8lJdvYhazrtkoisD3k8b6KMLtdc=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=sOVfkNWLLDt+JEZLsJm7PWpwNhbfMy7Zr3aDG23myvOrIan5N9yqRMjDlz3lXkn18
 DOkKMeiS/Gc4FUCYcIhmYx6Gd7Wh3GI9SHQJ9/gKNMFblTwGjqwXR5Q5D4ZJTz5GCZ
 Xeql/aFHQc1P1nooQI57fQbl4K4t7T8vB35SNzfiqeD93s0O06ZnBUEgtoW1hZorwx
 QM5A4B35PxahBIULwNXu6XXsvZ+FCzpvOZA92INsgfO8+7HlzE56nLNgNW3zAzwSYq
 nJ58IKrrUjUsb0ZBJ3d45ZXUZUk1+JGN1AjIVhnbFLrQYKBelF3S+H6U7y1Rblwba5
 U6Kkbjsxumihg==
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

On 2/10/20 5:03 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> ra_submit() which is a wrapper around __do_page_cache_readahead() already
> returns an unsigned long, and the 'nr_to_read' parameter is an unsigned
> long, so fix __do_page_cache_readahead() to return an unsigned long,
> even though I'm pretty sure we're not going to readahead more than 2^32
> pages ever.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/internal.h  | 2 +-
>  mm/readahead.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 3cf20ab3ca01..41b93c4b3ab7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -49,7 +49,7 @@ void unmap_page_range(struct mmu_gather *tlb,
>  			     unsigned long addr, unsigned long end,
>  			     struct zap_details *details);
>  
> -extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
> +extern unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size);
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2fe72cd29b47..6bf73ef33b7e 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -152,7 +152,7 @@ static int read_pages(struct address_space *mapping, struct file *filp,
>   *
>   * Returns the number of pages requested, or the maximum amount of I/O allowed.
>   */
> -unsigned int __do_page_cache_readahead(struct address_space *mapping,
> +unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size)
>  {
> @@ -161,7 +161,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;


What about page_idx, too? It should also have the same data type as nr_pages, as long as
we're trying to be consistent on this point.

Just want to ensure we're ready to handle those 2^33+ page readaheads... :)


thanks,
-- 
John Hubbard
NVIDIA
> -	unsigned int nr_pages = 0;
> +	unsigned long nr_pages = 0;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
>  
> 
