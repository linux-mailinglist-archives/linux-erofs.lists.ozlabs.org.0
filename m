Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04696463E17
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 19:51:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J3WX760zwz30Pj
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 05:51:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f69KXMAp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=djwong@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f69KXMAp; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J3WX42Q74z2yJL
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Dec 2021 05:51:16 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D4D8FB8187B;
 Tue, 30 Nov 2021 18:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722D9C53FC7;
 Tue, 30 Nov 2021 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638298272;
 bh=pIN7ABzLdiksJYiI1GQ6S2KBxnScyKH3E9XuH9ab5kc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f69KXMApBRLMv9opuoCOfv4JankytX6MHovhMbMeU40j1k3J7m4Jmn9zdR8i4vbW5
 QnbFwqdl+oJCTfd2dr855rqMqz8YoePtTSvD755hNQUKrIJWPZ2p7YXIdxOkBJlpxq
 TYdc8P7bCoXFkE3o80zpEezt72ki72NBML6US4zN94x5cCMnIArnldLFtUKLH14Ihv
 Owa+V0+yrk2ewdnwg25W2WY8amMN1fYPIbAhnTAQz2ZfxWsvNQN3aOI9eIcdJkx/qf
 SNIly+1efcIP33FcCVYMoP1YgaJ7BbBUpt8KP9uPPGHfvvnBkG0hWP8YdjtEiu3hmA
 yluXJtwfN/c0A==
Date: Tue, 30 Nov 2021 10:51:12 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
Message-ID: <20211130185112.GE8467@magnolia>
References: <20211129102203.2243509-1-hch@lst.de>
 <20211129102203.2243509-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129102203.2243509-7-hch@lst.de>
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

On Mon, Nov 29, 2021 at 11:21:40AM +0100, Christoph Hellwig wrote:
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Makes more sense than the old "get the dax device and /then/ check if
it's ok to use it" strategy.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  drivers/dax/super.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c8500b7e2d8a2..f2cef47bdeafd 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -92,6 +92,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>  	if (!blk_queue_dax(bdev->bd_disk->queue))
>  		return NULL;
>  
> +	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> +	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> +		return NULL;
> +	}
> +
>  	id = dax_read_lock();
>  	dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
>  	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> @@ -106,10 +112,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>  		struct block_device *bdev, int blocksize, sector_t start,
>  		sector_t sectors)
>  {
> -	pgoff_t pgoff, pgoff_end;
> -	sector_t last_page;
> -	int err;
> -
>  	if (blocksize != PAGE_SIZE) {
>  		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
>  		return false;
> @@ -120,19 +122,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>  		return false;
>  	}
>  
> -	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
> -	if (err) {
> -		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -		return false;
> -	}
> -
> -	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
> -	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
> -	if (err) {
> -		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -		return false;
> -	}
> -
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> -- 
> 2.30.2
> 
