Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E9718D78D
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 19:44:27 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kXkK4018zDrdL
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 05:44:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=VyRgr5Le; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kXkG4Q6bzDrPF
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 05:44:22 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9895A2051A;
 Fri, 20 Mar 2020 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584729860;
 bh=5pZqAya2TSGOpl920vnSvHi9jKtNxmt64mv8PAdFI3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VyRgr5LelhylhzZlcVYEomgTosDPQP2hFACxdbSh1g8cxdYQj8CURPVdAol5gz7Rg
 ExBTz35Q8O5vnKTi+DibRxVv6t5mUtWBLawcyZ38iKpEQsk8AEImcLdLmORUJEYHIs
 e+oJ5iVBFhvWYyFYTKBJXTMNGFlzAY6GTvEUiHMY=
Date: Fri, 20 Mar 2020 11:44:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9 21/25] ext4: Pass the inode to ext4_mpage_readpages
Message-ID: <20200320184418.GH851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320142231.2402-22-willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, William Kucharski <william.kucharski@oracle.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 07:22:27AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This function now only uses the mapping argument to look up the inode,
> and both callers already have the inode, so just pass the inode instead
> of the mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/ext4/ext4.h     | 2 +-
>  fs/ext4/inode.c    | 4 ++--
>  fs/ext4/readpage.c | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1570a0b51b73..bc1b34ba6eab 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3278,7 +3278,7 @@ static inline void ext4_set_de_type(struct super_block *sb,
>  }
>  
>  /* readpages.c */
> -extern int ext4_mpage_readpages(struct address_space *mapping,
> +extern int ext4_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct page *page);
>  extern int __init ext4_init_post_read_processing(void);
>  extern void ext4_exit_post_read_processing(void);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d674c5f9066c..4f3703c1408d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3226,7 +3226,7 @@ static int ext4_readpage(struct file *file, struct page *page)
>  		ret = ext4_readpage_inline(inode, page);
>  
>  	if (ret == -EAGAIN)
> -		return ext4_mpage_readpages(page->mapping, NULL, page);
> +		return ext4_mpage_readpages(inode, NULL, page);
>  
>  	return ret;
>  }
> @@ -3239,7 +3239,7 @@ static void ext4_readahead(struct readahead_control *rac)
>  	if (ext4_has_inline_data(inode))
>  		return;
>  
> -	ext4_mpage_readpages(rac->mapping, rac, NULL);
> +	ext4_mpage_readpages(inode, rac, NULL);
>  }
>  
>  static void ext4_invalidatepage(struct page *page, unsigned int offset,
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 66275f25235d..5761e9961682 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -221,13 +221,12 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
>  	return i_size_read(inode);
>  }
>  
> -int ext4_mpage_readpages(struct address_space *mapping,
> +int ext4_mpage_readpages(struct inode *inode,
>  		struct readahead_control *rac, struct page *page)
>  {
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
>  
> -	struct inode *inode = mapping->host;
>  	const unsigned blkbits = inode->i_blkbits;
>  	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
>  	const unsigned blocksize = 1 << blkbits;
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
