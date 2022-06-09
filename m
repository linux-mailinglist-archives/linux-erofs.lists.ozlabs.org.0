Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F9545493
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 21:04:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJtmt6vdCz3brR
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 05:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DPDtpREh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DPDtpREh;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJtmq0q1Xz3bnW
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Jun 2022 05:04:10 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3A24FB83005;
	Thu,  9 Jun 2022 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24DBC34114;
	Thu,  9 Jun 2022 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654801445;
	bh=Yxnu6+83FYCfv/3NbAs8M+FkZ+oJRuDX8jaMn/PQaZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPDtpREhdB0j8JRKxYabn/GSmhFRQx135HzaS1QEKqIVh/3OLWcUqgRccNEM25gmk
	 kG/OrJ39Z46ozUpCD4lB0Pz1Cgw5Nr0wS2LvRNpnFS3G1qnalODO0aE13KHfgq2aVF
	 RBiVXksCRrbDV3G+6tdZE7M8qB5p84hUf24cfmQT69pB4ht/PfI68SUxb2hijm/Alk
	 Iy9ZomiMariI7kTxRnfRkGzQdVh+RKRQraiVWC+Xd/Y3laedlgOxz6E566fV4n10Vd
	 4RCPFzR938EQgajfXo30ffAkTSTF2nYqegz7D/8H6zPQrMmQALtMa5fIpBWwlTlMaX
	 oQLbte0bNq8JA==
Date: Fri, 10 Jun 2022 03:03:58 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
Message-ID: <YqJEHqD15q738aQY@debian>
Mail-Followup-To: David Howells <dhowells@redhat.com>, jlayton@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Mike Marshall <hubcap@omnibond.com>, Gao Xiang <xiang@kernel.org>,
	linux-afs@lists.infradead.org, v9fs-developer@lists.sourceforge.net,
	devel@lists.orangefs.org, linux-erofs@lists.ozlabs.org,
	linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, devel@lists.orangefs.org, Mike Marshall <hubcap@omnibond.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 09, 2022 at 09:07:01AM +0100, David Howells wrote:
> The maths at the end of iter_xarray_get_pages() to calculate the actual
> size doesn't work under some circumstances, such as when it's been asked to
> extract a partial single page.  Various terms of the equation cancel out
> and you end up with actual == offset.  The same issue exists in
> iter_xarray_get_pages_alloc().
> 
> Fix these to just use min() to select the lesser amount from between the
> amount of page content transcribed into the buffer, minus the offset, and
> the size limit specified.
> 
> This doesn't appear to have caused a problem yet upstream because network
> filesystems aren't getting the pages from an xarray iterator, but rather
> passing it directly to the socket, which just iterates over it.  Cachefiles
> *does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
> whole pages to be written or read.
> 
> Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Mike Marshall <hubcap@omnibond.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: devel@lists.orangefs.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org

Looks good to me,

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
> 
>  lib/iov_iter.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 834e1e268eb6..814f65fd0c42 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  {
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size = maxsize, actual;
> +	size_t size = maxsize;
>  	loff_t pos;
>  
>  	if (!size || !maxpages)
> @@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	actual = PAGE_SIZE * nr;
> -	actual -= offset;
> -	if (nr == count && size > 0) {
> -		unsigned last_offset = (nr > 1) ? 0 : offset;
> -		actual -= PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  /* must be done on non-empty ITER_IOVEC one */
> @@ -1602,7 +1596,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	struct page **p;
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size = maxsize, actual;
> +	size_t size = maxsize;
>  	loff_t pos;
>  
>  	if (!size)
> @@ -1631,13 +1625,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	actual = PAGE_SIZE * nr;
> -	actual -= offset;
> -	if (nr == count && size > 0) {
> -		unsigned last_offset = (nr > 1) ? 0 : offset;
> -		actual -= PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> 
> 
