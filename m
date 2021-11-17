Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D63E454BFF
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 18:31:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvVMq2k6jz2yb7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 04:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=REgDCmlv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=REgDCmlv; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvVMl44WLz2yXc
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 04:31:15 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A92261B9F;
 Wed, 17 Nov 2021 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637170271;
 bh=BiRKQ/d3nVUFjcnKBhqKmlNar5IqbY6hjBQWP//4lO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=REgDCmlv/GsdUGBCUzpgY0SLzbRa7hiC9XAkokcnw8ztdTAZXw6loYohaUrV7/92E
 P4bRiUjDuNTcTzI0vzrQ96agKc9CmHmCrcXaCZROvQtNhvQwR3t0TBYcHApAjclXSM
 RwG3+khdqhamkmbTKDMPmHpQzbrMwArDRtSrCF9cFjT4inXLa8SkeN78UiQ5CxL+yo
 NbLu0pV80tIJ7V1OH4OqygjECgeNMnPLK3PGbMD+HBNd52+pNQAUAMoBe5BtrmSENT
 wX6MAEmgIfeFftiBn3U9SsdpvtrK2RpoPT6ry6Uad/3tdXf4Om38cNgzsujDy0Bu6U
 p63F7wtEJbVHw==
Date: Wed, 17 Nov 2021 09:31:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/29] xfs: factor out a xfs_setup_dax_always helper
Message-ID: <20211117173111.GZ24307@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-8-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:32:47AM +0100, Christoph Hellwig wrote:
> Factor out another DAX setup helper to simplify future changes.  Also
> move the experimental warning after the checks to not clutter the log
> too much if the setup failed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e21459f9923a8..875fd3151d6c9 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -340,6 +340,32 @@ xfs_buftarg_is_dax(
>  			bdev_nr_sectors(bt->bt_bdev));
>  }
>  
> +static int
> +xfs_setup_dax_always(
> +	struct xfs_mount	*mp)
> +{
> +	struct super_block	*sb = mp->m_super;
> +
> +	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
> +	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
> +		xfs_alert(mp,
> +			"DAX unsupported by block device. Turning off DAX.");
> +		goto disable_dax;
> +	}
> +
> +	if (xfs_has_reflink(mp)) {
> +		xfs_alert(mp, "DAX and reflink cannot be used together!");
> +		return -EINVAL;
> +	}
> +
> +	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +	return 0;
> +
> +disable_dax:
> +	xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> +	return 0;
> +}
> +
>  STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
> @@ -1593,26 +1619,9 @@ xfs_fs_fill_super(
>  		sb->s_flags |= SB_I_VERSION;
>  
>  	if (xfs_has_dax_always(mp)) {
> -		bool rtdev_is_dax = false, datadev_is_dax;
> -
> -		xfs_warn(mp,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -
> -		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
> -		if (mp->m_rtdev_targp)
> -			rtdev_is_dax = xfs_buftarg_is_dax(sb,
> -						mp->m_rtdev_targp);
> -		if (!rtdev_is_dax && !datadev_is_dax) {
> -			xfs_alert(mp,
> -			"DAX unsupported by block device. Turning off DAX.");
> -			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> -		}
> -		if (xfs_has_reflink(mp)) {
> -			xfs_alert(mp,
> -		"DAX and reflink cannot be used together!");
> -			error = -EINVAL;
> +		error = xfs_setup_dax_always(mp);
> +		if (error)
>  			goto out_filestream_unmount;
> -		}
>  	}
>  
>  	if (xfs_has_discard(mp)) {
> -- 
> 2.30.2
> 
