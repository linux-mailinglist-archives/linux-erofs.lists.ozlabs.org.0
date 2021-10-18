Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9543240A
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 18:44:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HY2l44qyrz2yws
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Oct 2021 03:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SgG+zrgJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SgG+zrgJ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HY2kz1zTkz2ypV
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Oct 2021 03:43:55 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1030561002;
 Mon, 18 Oct 2021 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634575432;
 bh=ndzn/cgjnN1D+UBSRO9lROqzj4w1+JVpStrCpNeonJE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SgG+zrgJcn47VIYSj3YzilH6qamtpHX2Ydp79Qvx7Wxh6NdjQiLSe39pSdPAG2gBz
 IyxCQUVQzJ7XUZ4gtcs8WceCSB2NahePCfq66/Layc7hZxqlzYYOLBySW2QWtd7P7M
 TTv9nwNV9Ot5ruqQa6nxmusgQhVkFVVmpNt1tauFIB7/jvVSfDklt+vkFLgpLGy0lJ
 +AibGWL+8y7C64Zr6vQ804z2SbwOAX8zyNdWSPM+gu5OGkgGT5cyj6rh8WNlMrRtOc
 OdYtkuBHsYZZXXsOcYayNw+dnkTsRyfLkUPd1u7mzxEa6negBF89Xl4tfDqAGgWd+h
 ZeVsLLSKK4Viw==
Date: Mon, 18 Oct 2021 09:43:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/11] xfs: factor out a xfs_setup_dax helper
Message-ID: <20211018164351.GT24307@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018044054.1779424-7-hch@lst.de>
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
Cc: no To-header on input <>, nvdimm@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-s390@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 18, 2021 at 06:40:49AM +0200, Christoph Hellwig wrote:
> Factor out another DAX setup helper to simplify future changes.  Also
> move the experimental warning after the checks to not clutter the log
> too much if the setup failed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_super.c | 47 +++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index c4e0cd1c1c8ca..d07020a8eb9e3 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -339,6 +339,32 @@ xfs_buftarg_is_dax(
>  			bdev_nr_sectors(bt->bt_bdev));
>  }
>  
> +static int
> +xfs_setup_dax(

/me wonders if this should be named xfs_setup_dax_always, since this
doesn't handle the dax=inode mode?

The only reason I bring that up is that Eric reminded me a while ago
that we don't actually print any kind of EXPERIMENTAL warning for the
auto-detection behavior.

That said, I never liked looking at the nested backwards logic of the
old code, so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

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
> @@ -1592,26 +1618,9 @@ xfs_fs_fill_super(
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
> +		error = xfs_setup_dax(mp);
> +		if (error)
>  			goto out_filestream_unmount;
> -		}
>  	}
>  
>  	if (xfs_has_discard(mp)) {
> -- 
> 2.30.2
> 
