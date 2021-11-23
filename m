Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9445AFBA
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 00:02:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKR74vWVz2yfr
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 10:02:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DGGP2Hw/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DGGP2Hw/; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKR452drz2yLJ
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 10:02:24 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8792A60F9F;
 Tue, 23 Nov 2021 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637708542;
 bh=GS50QTQfJ1+ToyzIbpu55dsHnRqqv0iWy7BBdE0JB2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DGGP2Hw/qt0fg0TjTYCkjZem7cLOTvAV+sYzt/gGFNVpe5YlzxKjG2+IdmBZqgOp0
 Tn14P64ZEMV4gebCdVgbL7CaMTp+X8CNJrxr0ZVMCKYY6k5XfA/+4EzCTh12rE7uwK
 fCo9ojaHmUFP3YFJWseiNw+SOmYbzBfz0SuuRHu/QcvKfxVhoRr5CXwdiB9KihiSTE
 OKdQ61mK9QOijxi5EjdC2NztG+GMSG+wrxjmHQLzMdOkMzK9cncUXf/Q/FakS6kyUJ
 su7FZZvTzHx1x8UJK7RJy9zA4zSLjCAN5QyeSRSJcE6pP1ZNqQvF4CqnWs+kY5B/nw
 RYEu1hk9aGLJQ==
Date: Tue, 23 Nov 2021 15:02:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
Message-ID: <20211123230222.GS266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-25-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:04AM +0100, Christoph Hellwig wrote:
> While the buffered write iomap ops do work due to the fact that zeroing
> never allocates blocks, the DAX zeroing should use the direct ops just
> like actual DAX I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Heh.  I've wanted to fix this for a long time, but I like your
surrounding cleanups better than anything I had time to work on. :)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cef3b68cba78..704292c6ce0c7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1324,7 +1324,7 @@ xfs_zero_range(
>  
>  	if (IS_DAX(inode))
>  		return dax_zero_range(inode, pos, len, did_zero,
> -				      &xfs_buffered_write_iomap_ops);
> +				      &xfs_direct_write_iomap_ops);
>  	return iomap_zero_range(inode, pos, len, did_zero,
>  				&xfs_buffered_write_iomap_ops);
>  }
> @@ -1339,7 +1339,7 @@ xfs_truncate_page(
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, did_zero,
> -					&xfs_buffered_write_iomap_ops);
> +					&xfs_direct_write_iomap_ops);
>  	return iomap_truncate_page(inode, pos, did_zero,
>  				   &xfs_buffered_write_iomap_ops);
>  }
> -- 
> 2.30.2
> 
