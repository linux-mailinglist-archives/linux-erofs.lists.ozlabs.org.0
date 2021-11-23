Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE145AF1D
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:31:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzJlP1n7Xz2yg3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ald8zVq4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ald8zVq4; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzJlL0f3gz2xXZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:31:25 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9413360F5B;
 Tue, 23 Nov 2021 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637706683;
 bh=r20JVTKBJHoc53zIslwbeilRv4uu178TPIBVv5o01us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ald8zVq4C5OTAFArV+qBTzxz5zm0Hg31v6uU/nFzj4Zx1IYXgmHwUd1cQkz3Z3iuV
 cmF+LRNEKRTHvNXKL2mg5s562uocNqQQNGviHtuupuuKlFq0h5C8xRWG4n0522X7EX
 4NTGSyMJo/GjVxj6FmNo0LWMNpM8S+ANiF9EKQM2tFVfb3dCoTuebKVYaFnrdq1vCU
 i4ZN+SF1bfxxWHxJnBa4bJRM2fo153Ub22A4to7uDEGxnXcVmZPT+8zMLHJNcHoSPU
 ZJYmaGGoL3TvAuwGtG2r4ZPmWUnQu85GEXgt/aKEYH7WtGIoGUbsyn7gigGJFcwlsV
 1YfWzZ9dQ7SRQ==
Date: Tue, 23 Nov 2021 14:31:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/29] dax: remove dax_capable
Message-ID: <20211123223123.GF266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-9-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:32:48AM +0100, Christoph Hellwig wrote:
> Just open code the block size and dax_dev == NULL checks in the callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/dax/super.c          | 36 ------------------------------------
>  drivers/md/dm-table.c        | 22 +++++++++++-----------
>  drivers/md/dm.c              | 21 ---------------------
>  drivers/md/dm.h              |  4 ----
>  drivers/nvdimm/pmem.c        |  1 -
>  drivers/s390/block/dcssblk.c |  1 -
>  fs/erofs/super.c             | 11 +++++++----
>  fs/ext2/super.c              |  6 ++++--
>  fs/ext4/super.c              |  9 ++++++---
>  fs/xfs/xfs_super.c           | 21 ++++++++-------------
>  include/linux/dax.h          | 14 --------------
>  11 files changed, 36 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 482fe775324a4..803942586d1b6 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -108,42 +108,6 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>  	return dax_dev;
>  }
>  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> -
> -bool generic_fsdax_supported(struct dax_device *dax_dev,
> -		struct block_device *bdev, int blocksize, sector_t start,
> -		sector_t sectors)
> -{
> -	if (blocksize != PAGE_SIZE) {
> -		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
> -		return false;
> -	}
> -
> -	if (!dax_dev) {
> -		pr_debug("%pg: error: dax unsupported by block device\n", bdev);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> -
> -bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> -		int blocksize, sector_t start, sector_t len)
> -{
> -	bool ret = false;
> -	int id;
> -
> -	if (!dax_dev)
> -		return false;
> -
> -	id = dax_read_lock();
> -	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
> -		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
> -						  start, len);
> -	dax_read_unlock(id);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(dax_supported);

Hooray, more dax helpers goaway!

>  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>  
>  enum dax_device_flags {

<skipping to xfs part>

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 875fd3151d6c9..3a45d5caa28d5 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -331,28 +331,23 @@ xfs_set_inode_alloc(
>  	return xfs_is_inode32(mp) ? maxagi : agcount;
>  }
>  
> -static bool
> -xfs_buftarg_is_dax(
> -	struct super_block	*sb,
> -	struct xfs_buftarg	*bt)
> -{
> -	return dax_supported(bt->bt_daxdev, bt->bt_bdev, sb->s_blocksize, 0,
> -			bdev_nr_sectors(bt->bt_bdev));
> -}
> -
>  static int
>  xfs_setup_dax_always(
>  	struct xfs_mount	*mp)
>  {
> -	struct super_block	*sb = mp->m_super;
> -
> -	if (!xfs_buftarg_is_dax(sb, mp->m_ddev_targp) &&
> -	   (!mp->m_rtdev_targp || !xfs_buftarg_is_dax(sb, mp->m_rtdev_targp))) {
> +	if (!mp->m_ddev_targp->bt_daxdev &&
> +	   (!mp->m_rtdev_targp || !mp->m_rtdev_targp->bt_daxdev)) {

Nit: This  ^ paren should be indented one more column because it's a
sub-clause of the if() test.

>  		xfs_alert(mp,
>  			"DAX unsupported by block device. Turning off DAX.");
>  		goto disable_dax;
>  	}
>  
> +	if (mp->m_super->s_blocksize != PAGE_SIZE) {
> +		xfs_alert(mp,
> +			"DAX not supported for blocksize. Turning off DAX.\n");

Nit: xfs_alert() already adds a newline to the end of the format string.

With those two things fixed up, for the XFS parts and everything XFS
depends on:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(I don't feel confident saying that I've looked at dcssblk or dm-table,
though I didn't see anything obviously wrong there...)

--D

> +		goto disable_dax;
> +	}
> +
>  	if (xfs_has_reflink(mp)) {
>  		xfs_alert(mp, "DAX and reflink cannot be used together!");
>  		return -EINVAL;
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index e2e9a67004cbd..439c3c70e347b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -111,12 +111,6 @@ int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
>  #if IS_ENABLED(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> -bool generic_fsdax_supported(struct dax_device *dax_dev,
> -		struct block_device *bdev, int blocksize, sector_t start,
> -		sector_t sectors);
> -
> -bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> -		int blocksize, sector_t start, sector_t len);
>  
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
> @@ -139,14 +133,6 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  static inline void dax_remove_host(struct gendisk *disk)
>  {
>  }
> -#define generic_fsdax_supported		NULL
> -
> -static inline bool dax_supported(struct dax_device *dax_dev,
> -		struct block_device *bdev, int blocksize, sector_t start,
> -		sector_t len)
> -{
> -	return false;
> -}
>  
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
> -- 
> 2.30.2
> 
