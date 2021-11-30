Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D53463E57
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 20:02:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3Wmr6csdz305v
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 06:02:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IA3GYpTW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IA3GYpTW; 
 dkim-atps=neutral
X-Greylist: delayed 505 seconds by postgrey-1.36 at boromir;
 Wed, 01 Dec 2021 06:02:15 AEDT
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3Wml3HMsz2xXg
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 06:02:15 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 6E79CCE1AFF;
 Tue, 30 Nov 2021 18:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFBEC53FCC;
 Tue, 30 Nov 2021 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638298424;
 bh=AIHUlCAfQeuWbXcK3mFtUa0/D0kezwwWhkPvl5x6m4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IA3GYpTW/PQnvWUGs+UT7wnn+Gvoo4+pPYVJjU9/TqhoIop4Rp19/0YF+ysOS6p7n
 sgK7hcU4Ve3nK1SuQ8llTJqf0K/7NXy+QVSP7yfeY13CFH7Xqtqqw3EBxNI8Thf/4G
 0GGCGez5CkyWHj4C78f90cEgb03emFZ17uJyYE21IPB7QOh9x3UVA9EuMQTVclwQuo
 1A5Lcfv6pJ4SfRMK1II22+PZXz9Etl4nEgjWNYc/tOG8om0HfuMurphBcS+Etg5szS
 JbJDBC7X+LPje3qvocWAjEwJ1FinFBjioMGGuDEawA05JyfjbNN6VbfLf3vRxe5Q4N
 Za/B3XWhyd78g==
Date: Tue, 30 Nov 2021 10:53:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/29] fsdax: decouple zeroing from the iomap buffered
 I/O code
Message-ID: <20211130185344.GF8467@magnolia>
References: <20211129102203.2243509-1-hch@lst.de>
 <20211129102203.2243509-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102203.2243509-19-hch@lst.de>
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

On Mon, Nov 29, 2021 at 11:21:52AM +0100, Christoph Hellwig wrote:
> Unshare the DAX and iomap buffered I/O page zeroing code.  This code
> previously did a IS_DAX check deep inside the iomap code, which in
> fact was the only DAX check in the code.  Instead move these checks
> into the callers.  Most callers already have DAX special casing anyway
> and XFS will need it for reflink support as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Hooray, less dax entanglement!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c               | 77 ++++++++++++++++++++++++++++++++++--------
>  fs/ext2/inode.c        |  7 ++--
>  fs/ext4/inode.c        |  5 +--
>  fs/iomap/buffered-io.c | 35 +++++++------------
>  fs/xfs/xfs_iomap.c     |  7 +++-
>  include/linux/dax.h    |  7 +++-
>  6 files changed, 94 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index d5db1297a0bb6..43d58b4219fd0 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1135,24 +1135,73 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
>  	return ret;
>  }
>  
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -	long rc, id;
> -	unsigned offset = offset_in_page(pos);
> -	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> +	const struct iomap *iomap = &iter->iomap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	loff_t pos = iter->pos;
> +	u64 length = iomap_length(iter);
> +	s64 written = 0;
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
> index 333fa62661d56..01d69618277de 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -36,6 +36,7 @@
>  #include <linux/iomap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
> +#include <linux/dax.h>
>  #include "ext2.h"
>  #include "acl.h"
>  #include "xattr.h"
> @@ -1297,9 +1298,9 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
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
> index bfd3545f1e5d9..d316a2009489b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -41,6 +41,7 @@
>  #include <linux/bitops.h>
>  #include <linux/iomap.h>
>  #include <linux/iversion.h>
> +#include <linux/dax.h>
>  
>  #include "ext4_jbd2.h"
>  #include "xattr.h"
> @@ -3780,8 +3781,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
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
> index 71a36ae120ee8..f3176cf90351f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -876,26 +876,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
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
> @@ -906,12 +888,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
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
> index d6d71ae9f2ae4..6a0c3b307bd73 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -28,7 +28,6 @@
>  #include "xfs_dquot.h"
>  #include "xfs_reflink.h"
>  
> -
>  #define XFS_ALLOC_ALIGN(mp, off) \
>  	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
>  
> @@ -1321,6 +1320,9 @@ xfs_zero_range(
>  {
>  	struct inode		*inode = VFS_I(ip);
>  
> +	if (IS_DAX(inode))
> +		return dax_zero_range(inode, pos, len, did_zero,
> +				      &xfs_buffered_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1333,6 +1335,9 @@ xfs_truncate_page(
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
> index 324363b798ecd..b79036743e7fa 100644
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
> @@ -170,6 +171,11 @@ static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
>  }
>  #endif
>  
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops);
> +
>  #if IS_ENABLED(CONFIG_DAX)
>  int dax_read_lock(void);
>  void dax_read_unlock(int id);
> @@ -204,7 +210,6 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
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
