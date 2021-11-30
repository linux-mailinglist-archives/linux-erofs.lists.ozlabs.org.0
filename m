Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67292463E5D
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 20:02:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3Wn22WwZz307C
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 06:02:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rkpx333N;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Rkpx333N; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3Wn01kcZz2xXg
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 06:02:28 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E7DDECE1A42;
 Tue, 30 Nov 2021 19:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1852AC53FD0;
 Tue, 30 Nov 2021 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638298945;
 bh=8CCaUrkMgfFAHUElffH5PuYUb6W8y7kE51uYWrs+45k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rkpx333NnulU1kbHamJOItwjNc4P/uMuemgIj/QITzPwHVlFErq6q810KmllWFlgV
 ngL4puvvgq8n9anQphnn7Nmo9Hb6ikpeClrCU6ST1uw2/3nbK2PGk/bjNR6VBaj6TJ
 AFk4jV/zC0IyWL+OaLxK+V+IoHB86eaAI9kq/nkIPPTfCg0DbB5X1qGCJjgIpYQwDJ
 ZRS4nMSta1GOHzTm6dMKbgT4pwmc4c23fPRtsig46yYCbHRmrxNLe34bDGr/6IyJnA
 6NQ9MDOCsvD3XEsvkeomPw2fiEMJT4rxNOGvu9H53/JfU9C39ms2wqTcAvUIEPWeOj
 poF8m2DUFzJuQ==
Date: Tue, 30 Nov 2021 11:02:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 24/29] iomap: add a IOMAP_DAX flag
Message-ID: <20211130190224.GH8467@magnolia>
References: <20211129102203.2243509-1-hch@lst.de>
 <20211129102203.2243509-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102203.2243509-25-hch@lst.de>
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

On Mon, Nov 29, 2021 at 11:21:58AM +0100, Christoph Hellwig wrote:
> Add a flag so that the file system can easily detect DAX operations
> based just on the iomap operation requested instead of looking at
> inode state using IS_DAX.  This will be needed to apply the to be
> added partition offset only for operations that actually use DAX,
> but not things like fiemap that are based on the block device.
> In the long run it should also allow turning the bdev, dax_dev
> and inline_data into a union.

Heh. :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c              | 7 ++++---
>  fs/ext4/inode.c       | 4 ++--
>  fs/xfs/xfs_iomap.c    | 7 ++++---
>  fs/xfs/xfs_iomap.h    | 3 ++-
>  fs/xfs/xfs_pnfs.c     | 2 +-
>  include/linux/iomap.h | 5 +++++
>  6 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 43d58b4219fd0..148e8b0967f35 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.inode		= inode,
>  		.pos		= pos,
>  		.len		= len,
> -		.flags		= IOMAP_ZERO,
> +		.flags		= IOMAP_DAX | IOMAP_ZERO,
>  	};
>  	int ret;
>  
> @@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		.inode		= iocb->ki_filp->f_mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(iter),
> +		.flags		= IOMAP_DAX,
>  	};
>  	loff_t done = 0;
>  	int ret;
> @@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		.inode		= mapping->host,
>  		.pos		= (loff_t)vmf->pgoff << PAGE_SHIFT,
>  		.len		= PAGE_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = 0;
>  	void *entry;
> @@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct iomap_iter iter = {
>  		.inode		= mapping->host,
>  		.len		= PMD_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  	pgoff_t max_pgoff;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d316a2009489b..89c4a174bd393 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3349,8 +3349,8 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	 * DAX and direct I/O are the only two operations that are currently
>  	 * supported with IOMAP_WRITE.
>  	 */
> -	WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));
> -	if (IS_DAX(inode))
> +	WARN_ON(!(flags & (IOMAP_DAX | IOMAP_DIRECT)));
> +	if (flags & IOMAP_DAX)
>  		m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
>  	/*
>  	 * We use i_size instead of i_disksize here because delalloc writeback
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d6beb1502f8bc..0ed3e7674353b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -188,6 +188,7 @@ xfs_iomap_write_direct(
>  	struct xfs_inode	*ip,
>  	xfs_fileoff_t		offset_fsb,
>  	xfs_fileoff_t		count_fsb,
> +	unsigned int		flags,
>  	struct xfs_bmbt_irec	*imap)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -229,7 +230,7 @@ xfs_iomap_write_direct(
>  	 * the reserve block pool for bmbt block allocation if there is no space
>  	 * left but we need to do unwritten extent conversion.
>  	 */
> -	if (IS_DAX(VFS_I(ip))) {
> +	if (flags & IOMAP_DAX) {
>  		bmapi_flags = XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO;
>  		if (imap->br_state == XFS_EXT_UNWRITTEN) {
>  			force = true;
> @@ -620,7 +621,7 @@ imap_needs_alloc(
>  	    imap->br_startblock == DELAYSTARTBLOCK)
>  		return true;
>  	/* we convert unwritten extents before copying the data for DAX */
> -	if (IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN)
> +	if ((flags & IOMAP_DAX) && imap->br_state == XFS_EXT_UNWRITTEN)
>  		return true;
>  	return false;
>  }
> @@ -826,7 +827,7 @@ xfs_direct_write_iomap_begin(
>  	xfs_iunlock(ip, lockmode);
>  
>  	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
> -			&imap);
> +			flags, &imap);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 657cc02290f22..e88dc162c785e 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -12,7 +12,8 @@ struct xfs_inode;
>  struct xfs_bmbt_irec;
>  
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
> -		xfs_fileoff_t count_fsb, struct xfs_bmbt_irec *imap);
> +		xfs_fileoff_t count_fsb, unsigned int flags,
> +		struct xfs_bmbt_irec *imap);
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
>  xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
>  		xfs_fileoff_t end_fsb);
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 7ce1ea11fc3f3..d6334abbc0b3e 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -155,7 +155,7 @@ xfs_fs_map_blocks(
>  		xfs_iunlock(ip, lock_flags);
>  
>  		error = xfs_iomap_write_direct(ip, offset_fsb,
> -				end_fsb - offset_fsb, &imap);
> +				end_fsb - offset_fsb, 0, &imap);
>  		if (error)
>  			goto out_unlock;
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6d1b08d0ae930..5b9432f9f79eb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -141,6 +141,11 @@ struct iomap_page_ops {
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#ifdef CONFIG_FS_DAX
> +#define IOMAP_DAX		(1 << 8) /* DAX mapping */
> +#else
> +#define IOMAP_DAX		0
> +#endif /* CONFIG_FS_DAX */
>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.30.2
> 
