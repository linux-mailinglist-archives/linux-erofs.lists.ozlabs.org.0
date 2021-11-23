Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BAD45AFE2
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 00:13:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKgt3tYBz2xrP
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 10:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xkg5cXpS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Xkg5cXpS; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKgr1p72z2xrP
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 10:13:28 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE20260FC3;
 Tue, 23 Nov 2021 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637709206;
 bh=S/IswOJvRGBagLJRqzKcshhJ4v7k/vBIf4Vs4dGT10g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xkg5cXpSDqabGeFWq7rmygKLTwImdF/9Sn8heQe42R/Yl8XGgY+AtzzmXPkUQcdes
 4zRZL+6+IKzGfg8DyRHpUlMflgVYZ/a0qcsQEyYMUOQSt8H1PN4K/4ljnF008ROVTO
 Wg2Yd6TaoIuT1rAuP4MQ5LHhkZR3MdspZQIYDo/j0RNRprZ6410ZDfRsvNNn/3BD0+
 BoXvZo3OFj7dm6LvkaiMpI52H2gbmIFDE7KYsgtFIOJtVx6wi7KK5ENEEMdlQFU1kG
 B8pfwvl1QCAx3g0SlZH2FEStKzn7XwOOnWr83DmLf696ZJnUywGpWhj7Qom2caz144
 ti5mzeKHYeHAw==
Date: Tue, 23 Nov 2021 15:13:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 28/29] iomap: build the block based code conditionally
Message-ID: <20211123231325.GV266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-29-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:08AM +0100, Christoph Hellwig wrote:
> Only build the block based iomap code if CONFIG_BLOCK is set.  Currently
> that is always the case, but it will change soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/Kconfig        | 4 ++--
>  fs/iomap/Makefile | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a6313a969bc5f..6d608330a096e 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -15,11 +15,11 @@ config VALIDATE_FS_PARSER
>  	  Enable this to perform validation of the parameter description for a
>  	  filesystem when it is registered.
>  
> -if BLOCK
> -
>  config FS_IOMAP
>  	bool
>  
> +if BLOCK
> +
>  source "fs/ext2/Kconfig"
>  source "fs/ext4/Kconfig"
>  source "fs/jbd2/Kconfig"
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index 4143a3ff89dbc..fc070184b7faa 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -9,9 +9,9 @@ ccflags-y += -I $(srctree)/$(src)		# needed for trace events
>  obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
>  iomap-y				+= trace.o \
> -				   buffered-io.o \
> +				   iter.o
> +iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
>  				   direct-io.o \
>  				   fiemap.o \
> -				   iter.o \
>  				   seek.o
>  iomap-$(CONFIG_SWAP)		+= swapfile.o
> -- 
> 2.30.2
> 
