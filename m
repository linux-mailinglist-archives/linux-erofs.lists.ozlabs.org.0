Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B05845AF8F
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:55:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKHY1NGqz2yfr
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:55:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LktQf3iF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LktQf3iF; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKHV1CpFz2yJ5
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:55:50 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4550060F5D;
 Tue, 23 Nov 2021 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637708148;
 bh=XmDdcxvSraD+z9MecQbr8ySGBgUbDWDWR7VXjTKw2lA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LktQf3iFlh4ZK+EdJzgerBaJJ38tsjASFxBd+rWZ0pkw45n80+kYHakBGevYMVC5r
 OlNereV6xuQJRYlzU1K1seWdLhegspgCiiE39wAcXU3XlPhoKbmCeoHH9SZ8LW7iN7
 qffPxsP0Dt90OeybGC1TsANXv+vVe/DUi3AER/sPAPaxDUJsjHMZUi+orZ+xLltd1w
 EFU9aonPlu49LF0+AHMgQ+vcqqKAOKugdd7ndup8AKsWoqQtOCeajiJyouIvjgBSjm
 swKW/aFrCvx+8n3ibt30Sb8LnQ9JMzJZOq/fuUsfBvn93qfB1b9hsojXKtR3aKcxwL
 rpZ4U8yKOcsnQ==
Date: Tue, 23 Nov 2021 14:55:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 21/29] xfs: move dax device handling into
 xfs_{alloc,free}_buftarg
Message-ID: <20211123225548.GP266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-22-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:01AM +0100, Christoph Hellwig wrote:
> Hide the DAX device lookup from the xfs_super.c code.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This looks to be a straightforward conversion.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_buf.c   |  8 ++++----
>  fs/xfs/xfs_buf.h   |  4 ++--
>  fs/xfs/xfs_super.c | 26 +++++---------------------
>  3 files changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 631c5a61d89b7..4d4553ffa7050 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1892,6 +1892,7 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> +	fs_put_dax(btp->bt_daxdev);
>  
>  	kmem_free(btp);
>  }
> @@ -1932,11 +1933,10 @@ xfs_setsize_buftarg_early(
>  	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
>  }
>  
> -xfs_buftarg_t *
> +struct xfs_buftarg *
>  xfs_alloc_buftarg(
>  	struct xfs_mount	*mp,
> -	struct block_device	*bdev,
> -	struct dax_device	*dax_dev)
> +	struct block_device	*bdev)
>  {
>  	xfs_buftarg_t		*btp;
>  
> @@ -1945,7 +1945,7 @@ xfs_alloc_buftarg(
>  	btp->bt_mount = mp;
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
> -	btp->bt_daxdev = dax_dev;
> +	btp->bt_daxdev = fs_dax_get_by_bdev(bdev);
>  
>  	/*
>  	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index 6b0200b8007d1..bd7f709f0d232 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -338,8 +338,8 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
>  /*
>   *	Handling of buftargs.
>   */
> -extern struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *,
> -		struct block_device *, struct dax_device *);
> +struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
> +		struct block_device *bdev);
>  extern void xfs_free_buftarg(struct xfs_buftarg *);
>  extern void xfs_buftarg_wait(struct xfs_buftarg *);
>  extern void xfs_buftarg_drain(struct xfs_buftarg *);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 3a45d5caa28d5..7262716afb215 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -391,26 +391,19 @@ STATIC void
>  xfs_close_devices(
>  	struct xfs_mount	*mp)
>  {
> -	struct dax_device *dax_ddev = mp->m_ddev_targp->bt_daxdev;
> -
>  	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
>  		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
> -		struct dax_device *dax_logdev = mp->m_logdev_targp->bt_daxdev;
>  
>  		xfs_free_buftarg(mp->m_logdev_targp);
>  		xfs_blkdev_put(logdev);
> -		fs_put_dax(dax_logdev);
>  	}
>  	if (mp->m_rtdev_targp) {
>  		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
> -		struct dax_device *dax_rtdev = mp->m_rtdev_targp->bt_daxdev;
>  
>  		xfs_free_buftarg(mp->m_rtdev_targp);
>  		xfs_blkdev_put(rtdev);
> -		fs_put_dax(dax_rtdev);
>  	}
>  	xfs_free_buftarg(mp->m_ddev_targp);
> -	fs_put_dax(dax_ddev);
>  }
>  
>  /*
> @@ -428,8 +421,6 @@ xfs_open_devices(
>  	struct xfs_mount	*mp)
>  {
>  	struct block_device	*ddev = mp->m_super->s_bdev;
> -	struct dax_device	*dax_ddev = fs_dax_get_by_bdev(ddev);
> -	struct dax_device	*dax_logdev = NULL, *dax_rtdev = NULL;
>  	struct block_device	*logdev = NULL, *rtdev = NULL;
>  	int			error;
>  
> @@ -439,8 +430,7 @@ xfs_open_devices(
>  	if (mp->m_logname) {
>  		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
>  		if (error)
> -			goto out;
> -		dax_logdev = fs_dax_get_by_bdev(logdev);
> +			return error;
>  	}
>  
>  	if (mp->m_rtname) {
> @@ -454,25 +444,24 @@ xfs_open_devices(
>  			error = -EINVAL;
>  			goto out_close_rtdev;
>  		}
> -		dax_rtdev = fs_dax_get_by_bdev(rtdev);
>  	}
>  
>  	/*
>  	 * Setup xfs_mount buffer target pointers
>  	 */
>  	error = -ENOMEM;
> -	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev, dax_ddev);
> +	mp->m_ddev_targp = xfs_alloc_buftarg(mp, ddev);
>  	if (!mp->m_ddev_targp)
>  		goto out_close_rtdev;
>  
>  	if (rtdev) {
> -		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev, dax_rtdev);
> +		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev);
>  		if (!mp->m_rtdev_targp)
>  			goto out_free_ddev_targ;
>  	}
>  
>  	if (logdev && logdev != ddev) {
> -		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev, dax_logdev);
> +		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev);
>  		if (!mp->m_logdev_targp)
>  			goto out_free_rtdev_targ;
>  	} else {
> @@ -488,14 +477,9 @@ xfs_open_devices(
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
>  	xfs_blkdev_put(rtdev);
> -	fs_put_dax(dax_rtdev);
>   out_close_logdev:
> -	if (logdev && logdev != ddev) {
> +	if (logdev && logdev != ddev)
>  		xfs_blkdev_put(logdev);
> -		fs_put_dax(dax_logdev);
> -	}
> - out:
> -	fs_put_dax(dax_ddev);
>  	return error;
>  }
>  
> -- 
> 2.30.2
> 
