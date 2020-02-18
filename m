Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F01636EA
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 00:09:00 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Mc3t02x3zDqdt
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 10:08:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.65;
 helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=IeItEZER; dkim-atps=neutral
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Mc3n3X0RzDqW7
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 10:08:52 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c6e740000>; Tue, 18 Feb 2020 15:08:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 15:08:49 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 18 Feb 2020 15:08:49 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 23:08:49 +0000
Subject: Re: [PATCH v6 05/19] mm: Remove 'page_offset' from readahead loop
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-8-willy@infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <af3a8179-ea65-7a47-3b96-70aeceac0352@nvidia.com>
Date: Tue, 18 Feb 2020 15:08:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-8-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582067316; bh=M7N9Wj3+9XwAeFwQi6TOYJxPABg1BqYz4tVXoRpCkIA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=IeItEZERl8RgD9gMu8hyrKs9zDAELxc/pcSyWfpoGI0TB2mLKgncHMG394p6px4ju
 zmtAMOymP1/ZtJoe4HlOHDlOUZc/uVCaP5RY2LCqtWb4PFiTTWf0yQduIPEsPrRM6I
 7+ZxiupuOA683TN7ev8l4qf1ne9j9TMe9yxP+4Gnp/KCmRvKAlcJ1KhnSHEd/mtvXA
 kETqqZe9Hl6tljU3UyeJaS2R5RC2d7bjB/6ICvno2hVU7UkwwH0PxFr9ixgVpcc7ww
 OuFMigzNUu1o/1PB1x64JUqXhqwxHJk3vxspEehlY/0wVnC7QAKbRSRGKmSy0mZ60N
 Ry89dWBs1XZZg==
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
> Eliminate the page_offset variable which was confusing with the
> 'offset' parameter and record the start of each consecutive run of
> pages in the readahead_control.


...presumably for the benefit of a subsequent patch, since it's not
consumed in this patch.

Thanks for breaking these up, btw, it really helps.


> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 3eca59c43a45..74791b96013f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -162,6 +162,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	struct readahead_control rac = {
>  		.mapping = mapping,
>  		.file = filp,
> +		._start = offset,
>  		._nr_pages = 0,
>  	};
>  
> @@ -175,12 +176,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 */
>  	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
>  		struct page *page;
> -		pgoff_t page_offset = offset + page_idx;


OK, this is still something I want to mention (I wrote the same thing when reviewing 
the wrong version of this patch, a moment ago).

You know...this ends up incrementing offset each time through the
loop, so yes, the behavior is the same as when using "offset + page_idx".
However, now it's a little harder to see that.

IMHO the page_offset variable is not actually a bad thing, here. I'd rather
keep it, all other things being equal (and I don't see any other benefits
here: line count is about the same, for example).

What do you think? (I don't feel strongly about this fine point.)


thanks,
-- 
John Hubbard
NVIDIA


>  
> -		if (page_offset > end_index)
> +		if (offset > end_index)
>  			break;
>  
> -		page = xa_load(&mapping->i_pages, page_offset);
> +		page = xa_load(&mapping->i_pages, offset);
>  		if (page && !xa_is_value(page)) {
>  			/*
>  			 * Page already present?  Kick off the current batch
> @@ -196,16 +196,18 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = page_offset;
> +		page->index = offset;
>  		list_add(&page->lru, &page_pool);
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
> +		offset++;
>  		continue;
>  read:
>  		if (readahead_count(&rac))
>  			read_pages(&rac, &page_pool, gfp_mask);
>  		rac._nr_pages = 0;
> +		rac._start = ++offset;
>  	}
>  
>  	/*
> 
