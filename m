Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601A45AFA2
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 00:00:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzKNs0dqQz2yg3
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 10:00:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SNfotjJ8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SNfotjJ8; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzKNp0tyqz2yLJ
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 10:00:25 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5E660FBF;
 Tue, 23 Nov 2021 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637708424;
 bh=sKHHXnnbT3vnShXHfDI+XrnWEu6cyJlqv49857pCV5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SNfotjJ8X++j3i9C0PzbRugHo7+tyQ3T4m1T2Z0oDe2BL+CvmLKMHbJ9Aof3VKeNY
 sDwLljj8mRvyOvc3cyUTZKzacZFGEg4uSutp+x+tnV8kkKHJifjLRY9EmRsdBMiUqe
 GxVn3bDkDVq06L3e6PgT9bShcPjCNafhZ8ZNi7Z1YJ5EtI6C7aXLzg2e0EWUycTBUP
 DPwpUyMgB1OAcoCUFI/b0zq3XhAyO+uD+jcL/j4IJjCewi4CbvT963KCjlHIf4yWwc
 jGAJ7NKjJpMVS8SUmH8wZarK5OakxSU7WDkhY0Kuv/p08iQVwJqBPPCGcgLRCX5dpb
 goCWZSExVEQpw==
Date: Tue, 23 Nov 2021 15:00:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
Message-ID: <20211123230023.GQ266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-23-hch@lst.de>
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

On Tue, Nov 09, 2021 at 09:33:02AM +0100, Christoph Hellwig wrote:
> Add a flag so that the file system can easily detect DAX operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c              | 7 ++++---
>  include/linux/iomap.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b52b878124ac..0bd6cdcbacfc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.inode		= inode,
>  		.pos		= pos,
>  		.len		= len,
> -		.flags		= IOMAP_ZERO,
> +		.flags		= IOMAP_DAX | IOMAP_ZERO,
>  	};
>  	int ret;
>  
> @@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		.inode		= iocb->ki_filp->f_mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(iter),
> +		.flags		= IOMAP_DAX,
>  	};
>  	loff_t done = 0;
>  	int ret;
> @@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		.inode		= mapping->host,
>  		.pos		= (loff_t)vmf->pgoff << PAGE_SHIFT,
>  		.len		= PAGE_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = 0;
>  	void *entry;
> @@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct iomap_iter iter = {
>  		.inode		= mapping->host,
>  		.len		= PMD_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  	pgoff_t max_pgoff;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6d1b08d0ae930..146a7e3e3ea11 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -141,6 +141,7 @@ struct iomap_page_ops {
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#define IOMAP_DAX		(1 << 8) /* DAX mapping */

Should this be #define'd to 0 ifndef CONFIG_FS_DAX so that the compiler
will optimize out all the IOMAP_DAX bits if dax isn't enabled in
Kconfig?  Kind of like what we do for S_DAX?

--D

>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.30.2
> 
