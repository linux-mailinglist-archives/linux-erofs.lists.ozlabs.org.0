Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B48E245AF77
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:53:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKDd4SMZz2ybK
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:53:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PxY1PGqf;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PxY1PGqf; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKDZ3rZfz2x98
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:53:18 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C73460F5B;
 Tue, 23 Nov 2021 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637707996;
 bh=2WhtPiejbKEY71BPcoLAOGEJUoF3jWCgkrAKfG5rGdE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PxY1PGqf13ggNEeH2330RDC0SSRuWqNtlFphZ283NvQ+0BM4z1055FPWjmAViB9xp
 Yn9VMBTioVwzNl4psAGPfq6aldFFYpA35IAsIhxk97caz2TTF8ZeFtfc31pCRFEcJ9
 mJfVhybbOBrmxPjr30kGaeOWJ1DKe5F/E+SYGpqCEc8d7dAQEjj4m5lj/WzAVRz/XH
 +VpciseuZdKRVqA6wKQvn1Iqz67Ca3v07F1oy80sljv5NbfxLlIi7wtD7qYWDqYcF+
 psPOZ6je9UPGQM9QtLgWJUUaIFBUGk8CbbfTcdESbBYBq8ClH75H8/X4I5+Ij8Dw9f
 S9GJYDRytdYqw==
Date: Tue, 23 Nov 2021 14:53:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/29] fsdax: decouple zeroing from the iomap buffered
 I/O code
Message-ID: <20211123225315.GM266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-19-hch@lst.de>
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 09, 2021 at 09:32:58AM +0100, Christoph Hellwig wrote:
> Unshare the DAX and iomap buffered I/O page zeroing code.  This code
> previously did a IS_DAX check deep inside the iomap code, which in
> fact was the only DAX check in the code.  Instead move these checks
> into the callers.  Most callers already have DAX special casing anyway
> and XFS will need it for reflink support as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c               | 77 ++++++++++++++++++++++++++++++++++--------
>  fs/ext2/inode.c        |  6 ++--
>  fs/ext4/inode.c        |  4 +--
>  fs/iomap/buffered-io.c | 35 +++++++------------
>  fs/xfs/xfs_iomap.c     |  6 ++++
>  include/linux/dax.h    |  6 +++-
>  6 files changed, 91 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index dc9ebeff850ab..5b52b878124ac 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1135,24 +1135,73 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
>  	return rc;
>  }
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +static loff_t dax_zero_iter(struct iomap_iter *iter, bool *did_zero)

Shouldn't this return value remain s64 to match iomap_iter.processed?

>  {
> -	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -	long rc, id;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> +	const struct iomap *iomap = &iter->iomap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	loff_t pos = iter->pos;
> +	loff_t length = iomap_length(iter);

u64..

(I wonder, should iomap_iter have a debug check for iomap_length >
INT64_MAX?)

> +	loff_t written = 0;

s64...

> +
> +	/* already zeroed?  we're done. */
> +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +		return length;
> +
> +	do {
> +		unsigned offset = offset_in_page(pos);
> +		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> +		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> +		long rc;
> +		int id;
>  
> -	id = dax_read_lock();
> -	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -	else
> -		rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
> -	dax_read_unlock(id);
> +		id = dax_read_lock();
> +		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> +			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> +		else
> +			rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
> +		dax_read_unlock(id);
>  
> -	if (rc < 0)
> -		return rc;
> -	return size;
> +		if (rc < 0)
> +			return rc;
> +		pos += size;
> +		length -= size;
> +		written += size;
> +		if (did_zero)
> +			*did_zero = true;
> +	} while (length > 0);
> +
> +	return written;
> +}
> +
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops)
> +{
> +	struct iomap_iter iter = {
> +		.inode		= inode,
> +		.pos		= pos,
> +		.len		= len,
> +		.flags		= IOMAP_ZERO,
> +	};
> +	int ret;
> +
> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.processed = dax_zero_iter(&iter, did_zero);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dax_zero_range);
> +
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops)
> +{
> +	unsigned int blocksize = i_blocksize(inode);
> +	unsigned int off = pos & (blocksize - 1);
> +
> +	/* Block boundary? Nothing to do */
> +	if (!off)
> +		return 0;
> +	return dax_zero_range(inode, pos, blocksize - off, did_zero, ops);
>  }
> +EXPORT_SYMBOL_GPL(dax_truncate_page);
>  
>  static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		struct iov_iter *iter)
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 333fa62661d56..ae9993018a015 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1297,9 +1297,9 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  	inode_dio_wait(inode);
>  
>  	if (IS_DAX(inode)) {
> -		error = iomap_zero_range(inode, newsize,
> -					 PAGE_ALIGN(newsize) - newsize, NULL,
> -					 &ext2_iomap_ops);
> +		error = dax_zero_range(inode, newsize,
> +				       PAGE_ALIGN(newsize) - newsize, NULL,
> +				       &ext2_iomap_ops);
>  	} else if (test_opt(inode->i_sb, NOBH))
>  		error = nobh_truncate_page(inode->i_mapping,
>  				newsize, ext2_get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0f06305167d5a..8c443b753b815 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3783,8 +3783,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
>  		length = max;
>  
>  	if (IS_DAX(inode)) {
> -		return iomap_zero_range(inode, from, length, NULL,
> -					&ext4_iomap_ops);
> +		return dax_zero_range(inode, from, length, NULL,
> +				      &ext4_iomap_ops);
>  	}
>  	return __ext4_block_zero_page_range(handle, mapping, from, length);
>  }
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1753c26c8e76e..b1511255b4df8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -870,26 +870,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
> -{
> -	struct page *page;
> -	int status;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
> -
> -	status = iomap_write_begin(iter, pos, bytes, &page);
> -	if (status)
> -		return status;
> -
> -	zero_user(page, offset, bytes);
> -	mark_page_accessed(page);
> -
> -	return iomap_write_end(iter, pos, bytes, bytes, page);
> -}
> -
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -	struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
> @@ -900,12 +882,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		return length;
>  
>  	do {
> -		s64 bytes;
> +		unsigned offset = offset_in_page(pos);
> +		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
> +		struct page *page;
> +		int status;
>  
> -		if (IS_DAX(iter->inode))
> -			bytes = dax_iomap_zero(pos, length, iomap);

I'm glad this kind of IS_DAX clunkiness is all going away finally.

> -		else
> -			bytes = __iomap_zero_iter(iter, pos, length);
> +		status = iomap_write_begin(iter, pos, bytes, &page);
> +		if (status)
> +			return status;
> +
> +		zero_user(page, offset, bytes);
> +		mark_page_accessed(page);
> +
> +		bytes = iomap_write_end(iter, pos, bytes, bytes, page);
>  		if (bytes < 0)
>  			return bytes;
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d6d71ae9f2ae4..604000b6243ec 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1321,6 +1321,9 @@ xfs_zero_range(
>  {
>  	struct inode		*inode = VFS_I(ip);
>  
> +	if (IS_DAX(inode))
> +		return dax_zero_range(inode, pos, len, did_zero,
> +				      &xfs_buffered_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1333,6 +1336,9 @@ xfs_truncate_page(
>  {
>  	struct inode		*inode = VFS_I(ip);
>  
> +	if (IS_DAX(inode))
> +		return dax_truncate_page(inode, pos, did_zero,
> +					&xfs_buffered_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 324363b798ecd..a5cc2f1aa840e 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -14,6 +14,7 @@ typedef unsigned long dax_entry_t;
>  struct dax_device;
>  struct gendisk;
>  struct iomap_ops;
> +struct iomap_iter;
>  struct iomap;
>  
>  struct dax_operations {
> @@ -124,6 +125,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops);
>  #else
>  static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> @@ -204,7 +209,6 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>  				      pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
>  static inline bool dax_mapping(struct address_space *mapping)
>  {
>  	return mapping->host && IS_DAX(mapping->host);
> -- 
> 2.30.2
> 
