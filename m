Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D698645AFE9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 00:13:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKhC5lpBz2yfm
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 10:13:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YmrMJlCX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YmrMJlCX; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKh90sHpz2xrP
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 10:13:45 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0598E60FC1;
 Tue, 23 Nov 2021 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637709223;
 bh=0lx8GFaumCvYFKCqIo5atmiVFp/pn2IMyOP4olSlTJg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YmrMJlCXXOUq098AjY55dEGQriwsEd/zsWv3kkKPJgdshScXkfBUmLoy/XMwhVsc9
 O/mlmEayflyVLaWvLIyFQcOF0OFYTa4CSjHFlZ/YU8LirvRyA12SC/tupkmtai7wmG
 xh9+tR6CqjsTkxNXjN2maqJxgIgDZRZ+JjVRIYiFZA8Ub74VLy5HtaTClmtPWXFeQM
 mtsNdJ0bO5jpxRPNMzE1EEd7DT2lltp3eu8XNwz66KKDFZFvJaM7mm4bD3I9uIrHad
 XpEKdq/bOnmFUZBItfTvQx/+CiGS1lCeim+CdWb86PECfthdvijctiMnO8k/Jrk9d+
 gKMaIHNoxpuiQ==
Date: Tue, 23 Nov 2021 15:13:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 29/29] fsdax: don't require CONFIG_BLOCK
Message-ID: <20211123231342.GW266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-30-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-30-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:09AM +0100, Christoph Hellwig wrote:
> The file system DAX code now does not require the block code.  So allow
> building a kernel with fuse DAX but not block layer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 6d608330a096e..7a2b11c0b8036 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -42,6 +42,8 @@ source "fs/nilfs2/Kconfig"
>  source "fs/f2fs/Kconfig"
>  source "fs/zonefs/Kconfig"
>  
> +endif # BLOCK
> +
>  config FS_DAX
>  	bool "File system based Direct Access (DAX) support"
>  	depends on MMU
> @@ -89,8 +91,6 @@ config FS_DAX_PMD
>  config FS_DAX_LIMITED
>  	bool
>  
> -endif # BLOCK
> -
>  # Posix ACL utility routines
>  #
>  # Note: Posix ACLs can be implemented without these helpers.  Never use
> -- 
> 2.30.2
> 
