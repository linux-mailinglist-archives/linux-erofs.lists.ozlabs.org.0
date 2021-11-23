Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A145AF48
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 23:40:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzJxN2FWDz2yg3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 09:40:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BURKP9F2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BURKP9F2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzJxK6zsXz2xsP
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 09:40:05 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBEF660C49;
 Tue, 23 Nov 2021 22:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637707203;
 bh=TPkdIIvK3hEApsrrBTQ54izWI2KU2MSsYLSgl81j84A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BURKP9F27CGb8J8d1Jn8pHGKCBiQFHCh/OkhU3opkn5+Upho52FaWc9Bjf3B0Rkmk
 Jg1lyp3oNqWs/ZLFEUEYW75h5sbh0qo09rD/8ooc1l0Q1KqRCfqugVoLoqBM+sSlsM
 59eKBtH7GdntlhPVjlkuRPfjWUTGx1vODvcKAE/8zO7NATG4YEq7YqVDPyUXy34Z8/
 y6tTvZCsxRK6Yy+GUKUuSVvSdO6GA24vYfdQQam4Lndl2BnG7ux4TOtoRJjZK1188L
 +fy7BpA9O7u4uV9MBf3qYADkpTRU/LQPzf7CRrOYloXhIW5whZ5lcDB++IZ0MyDUTX
 9pxX0uORKDeBg==
Date: Tue, 23 Nov 2021 14:40:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
Message-ID: <20211123224003.GK266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-17-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:32:56AM +0100, Christoph Hellwig wrote:
> The file relative offset must have the same alignment as the storage
> offset, so use that and get rid of the call to iomap_sector.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5364549d67a48..d7a923d152240 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1123,7 +1123,6 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
> -	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>  	long rc, id;
>  	void *kaddr;
> @@ -1131,8 +1130,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  	unsigned offset = offset_in_page(pos);
>  	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>  
> -	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
> -	    (size == PAGE_SIZE))
> +	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
>  		page_aligned = true;
>  
>  	id = dax_read_lock();
> -- 
> 2.30.2
> 
