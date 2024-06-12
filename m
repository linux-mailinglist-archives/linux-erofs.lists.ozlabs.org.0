Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB496905DF0
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 23:47:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QffqexAz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vzzfk4cKkz3cF6
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 07:47:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QffqexAz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vzzfb74Wrz3bdV
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 07:47:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 273C560C22;
	Wed, 12 Jun 2024 21:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA68EC116B1;
	Wed, 12 Jun 2024 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718228849;
	bh=+/VTydx8DuKC+hBaP5Tnh04ofGemNXKWLfDD9tjXUwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QffqexAzs3KBLfngWw5SiR/LiYM9HWTJ+9du9kZ9zv+i8sSzY98yBnmXrjNyOZabB
	 U/ck13+Vg9ga/wkTZMgvz071bhJcm6aAO+VOId0A4vJ1tpoYrK0Pxr9sZIFO1z+/55
	 jNf0LSzjZcN81fAo7//dsmA5wDLGof5rgYgtaMIPuvCUrl6fQwiMApmoVoFmgUnKAM
	 IB6Gc/ysLm/Z5qm7rDoqVGb73GLOZIqfGt2hdqleDljCHOeHg0mjybbOeSgAKoiO6a
	 mZFQ2+6LCc8Rc70AZeesAubTqd5BfCNqrO3eX17/kjNmxlfQO8rv/YjLcY5VA31NSD
	 6fOIRtOCqzeEg==
Date: Wed, 12 Jun 2024 14:47:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 03/22] xfs: Use extent size granularity for
 iomap->io_block_size
Message-ID: <20240612214729.GL2764752@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607143919.2622319-4-john.g.garry@oracle.com>
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
Cc: ritesh.list@gmail.com, gfs2@lists.linux.dev, mikulas@artax.karlin.mff.cuni.cz, hch@lst.de, agruenba@redhat.com, miklos@szeredi.hu, linux-ext4@vger.kernel.org, catherine.hoang@oracle.com, linux-block@vger.kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, mcgrof@kernel.org, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, chandan.babu@oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jun 07, 2024 at 02:39:00PM +0000, John Garry wrote:
> Currently iomap->io_block_size is set to the i_blocksize() value for the
> inode.
> 
> Expand the sub-fs block size zeroing to now cover RT extents, by calling
> setting iomap->io_block_size as xfs_inode_alloc_unitsize().
> 
> In xfs_iomap_write_unwritten(), update the unwritten range fsb to cover
> this extent granularity.
> 
> In xfs_file_dio_write(), handle a write which is not aligned to extent
> size granularity as unaligned. Since the extent size granularity need not
> be a power-of-2, handle this also.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c  | 24 +++++++++++++++++++-----
>  fs/xfs/xfs_inode.c | 17 +++++++++++------
>  fs/xfs/xfs_inode.h |  1 +
>  fs/xfs/xfs_iomap.c |  8 +++++++-
>  4 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index b240ea5241dc..24fe3c2e03da 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -601,7 +601,7 @@ xfs_file_dio_write_aligned(
>  }
>  
>  /*
> - * Handle block unaligned direct I/O writes
> + * Handle unaligned direct IO writes.
>   *
>   * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
>   * them to be done in parallel with reads and other direct I/O writes.  However,
> @@ -630,9 +630,9 @@ xfs_file_dio_write_unaligned(
>  	ssize_t			ret;
>  
>  	/*
> -	 * Extending writes need exclusivity because of the sub-block zeroing
> -	 * that the DIO code always does for partial tail blocks beyond EOF, so
> -	 * don't even bother trying the fast path in this case.
> +	 * Extending writes need exclusivity because of the sub-block/extent
> +	 * zeroing that the DIO code always does for partial tail blocks
> +	 * beyond EOF, so don't even bother trying the fast path in this case.

Hummm.  So let's say the fsblock size is 4k, the rt extent size is 16k,
and you want to write bytes 8192-12287 of a file.  Currently we'd use
xfs_file_dio_write_aligned for that, but now we'd use
xfs_file_dio_write_unaligned?  Even though we don't need zeroing or any
of that stuff?

>  	 */
>  	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
>  		if (iocb->ki_flags & IOCB_NOWAIT)
> @@ -698,11 +698,25 @@ xfs_file_dio_write(
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>  	size_t			count = iov_iter_count(from);
> +	bool			unaligned;
> +	u64			unitsize;
>  
>  	/* direct I/O must be aligned to device logical sector size */
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>  		return -EINVAL;
> -	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
> +
> +	unitsize = xfs_inode_alloc_unitsize(ip);
> +	if (!is_power_of_2(unitsize)) {
> +		if (isaligned_64(iocb->ki_pos, unitsize) &&
> +		    isaligned_64(count, unitsize))
> +			unaligned = false;
> +		else
> +			unaligned = true;
> +	} else {
> +		unaligned = (iocb->ki_pos | count) & (unitsize - 1);
> +	}

Didn't I already write this?

> +	if (unaligned)

	if (!xfs_is_falloc_aligned(ip, iocb->ki_pos, count))

>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
>  	return xfs_file_dio_write_aligned(ip, iocb, from);
>  }
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 58fb7a5062e1..93ad442f399b 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -4264,15 +4264,20 @@ xfs_break_layouts(
>  	return error;
>  }
>  
> -/* Returns the size of fundamental allocation unit for a file, in bytes. */

Don't delete the comment, it has useful return type information.

/*
 * Returns the size of fundamental allocation unit for a file, in
 * fsblocks.
 */

>  unsigned int
> -xfs_inode_alloc_unitsize(
> +xfs_inode_alloc_unitsize_fsb(
>  	struct xfs_inode	*ip)
>  {
> -	unsigned int		blocks = 1;
> -
>  	if (XFS_IS_REALTIME_INODE(ip))
> -		blocks = ip->i_mount->m_sb.sb_rextsize;
> +		return ip->i_mount->m_sb.sb_rextsize;
> +
> +	return 1;
> +}
>  
> -	return XFS_FSB_TO_B(ip->i_mount, blocks);
> +/* Returns the size of fundamental allocation unit for a file, in bytes. */
> +unsigned int
> +xfs_inode_alloc_unitsize(
> +	struct xfs_inode	*ip)
> +{
> +	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_unitsize_fsb(ip));
>  }
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 292b90b5f2ac..90d2fa837117 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -643,6 +643,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
>  bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
>  void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
>  		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
> +unsigned int xfs_inode_alloc_unitsize_fsb(struct xfs_inode *ip);
>  unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
>  
>  struct xfs_dir_update_params {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ecb4cae88248..fbe69f747e30 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -127,7 +127,7 @@ xfs_bmbt_to_iomap(
>  	}
>  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> -	iomap->io_block_size = i_blocksize(VFS_I(ip));
> +	iomap->io_block_size = xfs_inode_alloc_unitsize(ip);

Oh, I see.  So io_block_size causes iomap to write zeroes to the storage
backing surrounding areas of the file range.  In this case, for direct
writes to the unwritten middle 4k of an otherwise written 16k extent,
we'll write zeroes to 0-4k and 8k-16k even though that wasn't what the
caller asked for?

IOWs, if you start with:

WWuW

write to the "U", then it'll write zeroes to the "W" areas?  That
doesn't sound good...

>  	if (mapping_flags & IOMAP_DAX)
>  		iomap->dax_dev = target->bt_daxdev;
>  	else
> @@ -577,11 +577,17 @@ xfs_iomap_write_unwritten(
>  	xfs_fsize_t	i_size;
>  	uint		resblks;
>  	int		error;
> +	unsigned int	rounding;
>  
>  	trace_xfs_unwritten_convert(ip, offset, count);
>  
>  	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>  	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
> +	rounding = xfs_inode_alloc_unitsize_fsb(ip);
> +	if (rounding > 1) {
> +		offset_fsb = rounddown_64(offset_fsb, rounding);
> +		count_fsb = roundup_64(count_fsb, rounding);
> +	}

...and then the ioend handler is supposed to be smart enough to know
that iomap quietly wrote to other parts of the disk.

Um, does this cause unwritten extent conversion for entire rtextents
after writeback to a rtextsize > 1fsb file?

Or am I really misunderstanding what's going on here with the io paths?

--D

>  	count_fsb = (xfs_filblks_t)(count_fsb - offset_fsb);
>  
>  	/*
> -- 
> 2.31.1
> 
> 
