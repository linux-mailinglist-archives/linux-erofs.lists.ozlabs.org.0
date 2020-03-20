Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57D18D521
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 17:58:42 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kVNH3SRnzDrQR
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 03:58:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=cRbat8RE; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kVN96prnzDrMG
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 03:58:33 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6434C20753;
 Fri, 20 Mar 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584723510;
 bh=AxLDPN4LwuxzW4xjwlSgsVf6rtc0JFVKxbo5//wmPgc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cRbat8REA7EmmJnmLCrWxRoNW5LgyCKm+4EsNDf5E4lY0nLcYrSE6Jyr+LkCnKmyi
 n3W2x46nv8ZHmzqeZMc86Mj56kXxAhIEwG1PHXCTucYL5iivPYgJLLRVtDE0DPEV3X
 iA5d4+HsRZ/BNe0ydHe/SfLeiRxRKGyEVqIcRkok=
Date: Fri, 20 Mar 2020 09:58:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 12/25] mm: Move end_index check out of readahead loop
Message-ID: <20200320165828.GB851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-13-willy@infradead.org>
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By reducing nr_to_read, we can eliminate this check from inside the loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  mm/readahead.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index d01531ef9f3c..a37b68f66233 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -167,8 +167,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> -	struct page *page;
> -	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
> @@ -178,22 +176,29 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		._index = index,
>  	};
>  	unsigned long i;
> +	pgoff_t end_index;	/* The last page we want to read */
>  
>  	if (isize == 0)
>  		return;
>  
> -	end_index = ((isize - 1) >> PAGE_SHIFT);
> +	end_index = (isize - 1) >> PAGE_SHIFT;
> +	if (index > end_index)
> +		return;
> +	/* Avoid wrapping to the beginning of the file */
> +	if (index + nr_to_read < index)
> +		nr_to_read = ULONG_MAX - index + 1;
> +	/* Don't read past the page containing the last byte of the file */
> +	if (index + nr_to_read >= end_index)
> +		nr_to_read = end_index - index + 1;

There seem to be a couple off-by-one errors here.  Shouldn't it be:

	/* Avoid wrapping to the beginning of the file */
	if (index + nr_to_read < index)
		nr_to_read = ULONG_MAX - index;
	/* Don't read past the page containing the last byte of the file */
	if (index + nr_to_read > end_index)
		nr_to_read = end_index - index + 1;

I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.

Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
since otherwise nr_to_read can be increased by 1 rather than decreased or stay
the same as expected.

- Eric
