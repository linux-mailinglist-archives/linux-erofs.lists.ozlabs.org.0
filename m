Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475045AFDB
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 00:13:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKgW13JFz2yfr
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 10:13:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IzacBFBF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IzacBFBF; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKgR4hGQz2yLd
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 10:13:07 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89AA960F9F;
 Tue, 23 Nov 2021 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637709185;
 bh=qI8k8SWcfOTf0dPmRhxg9uqxHXWp63uAbeW4/0Ozc7A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IzacBFBFhYh1FXrg7vX6C+KOP1OJxBbbaxlskfiRzRHZEcu+QVgT6TLPVe1C3qHil
 8w6H7EupDtAbvwL+YhPe1535bL7h0UBuS4dO0iEFrkQouRhqGT1M5iu0zTIt84UP35
 UJ8kQ0pSgv51CTWUeTa9oG2ShGEe8lGowjb1HLniNGys8CsRX+qESFdCphOZxlg8Nh
 SDWcaD/73OkeMq4lrTWsV3ChlvtjYmqSu0CE2EZvGeLbKpkBTx+DjBLn7sVm+YvSXb
 F0vt8O+an8SwKPzp9UrOyY70tBZndLxDC6VVIAk3CrRX19qSMcWPlKcStgHi/ulFjZ
 gJy9vInPH0O9g==
Date: Tue, 23 Nov 2021 15:13:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/29] dax: fix up some of the block device related ifdefs
Message-ID: <20211123231305.GU266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-28-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:07AM +0100, Christoph Hellwig wrote:
> The DAX device <-> block device association is only enabled if
> CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
> the right conditions for the fs_put_dax stub as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/dax.h | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 90f95deff504d..5568d3dca941b 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -108,28 +108,15 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>  
>  struct writeback_control;
> -#if IS_ENABLED(CONFIG_FS_DAX)
> +#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> -
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> +		u64 *start_off);
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  	put_dax(dax_dev);
>  }
> -
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
> -		u64 *start_off);
> -int dax_writeback_mapping_range(struct address_space *mapping,
> -		struct dax_device *dax_dev, struct writeback_control *wbc);
> -
> -struct page *dax_layout_busy_page(struct address_space *mapping);
> -struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> -dax_entry_t dax_lock_page(struct page *page);
> -void dax_unlock_page(struct page *page, dax_entry_t cookie);
> -int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> -		const struct iomap_ops *ops);
> -int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -		const struct iomap_ops *ops);
>  #else
>  static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  {
> @@ -138,17 +125,29 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
>  static inline void dax_remove_host(struct gendisk *disk)
>  {
>  }
> -
> -static inline void fs_put_dax(struct dax_device *dax_dev)
> -{
> -}
> -
>  static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
>  		u64 *start_off)
>  {
>  	return NULL;
>  }
> +static inline void fs_put_dax(struct dax_device *dax_dev)
> +{
> +}
> +#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> +
> +#if IS_ENABLED(CONFIG_FS_DAX)
> +int dax_writeback_mapping_range(struct address_space *mapping,
> +		struct dax_device *dax_dev, struct writeback_control *wbc);
>  
> +struct page *dax_layout_busy_page(struct address_space *mapping);
> +struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +dax_entry_t dax_lock_page(struct page *page);
> +void dax_unlock_page(struct page *page, dax_entry_t cookie);
> +int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> +		const struct iomap_ops *ops);
> +int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> +		const struct iomap_ops *ops);
> +#else
>  static inline struct page *dax_layout_busy_page(struct address_space *mapping)
>  {
>  	return NULL;
> -- 
> 2.30.2
> 
