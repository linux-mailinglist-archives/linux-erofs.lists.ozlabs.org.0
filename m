Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F23536D04
	for <lists+linux-erofs@lfdr.de>; Sat, 28 May 2022 14:56:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9MBB6tPQz3bmk
	for <lists+linux-erofs@lfdr.de>; Sat, 28 May 2022 22:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAXCeLmS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OAXCeLmS;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9MB44zXMz304F
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 May 2022 22:56:28 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4376560E88;
	Sat, 28 May 2022 12:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A0C34100;
	Sat, 28 May 2022 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653742584;
	bh=J7E0lVyIo+juV6HoBpjS0XC2CTEDG/qqYQnsEbI+6KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAXCeLmS0ELKIjWVPGhirgLBRU3x4frBF+lzSaeOqheE6zEQCAHO7boLdjdFQk700
	 s4v0CgbBnQfstpnz2kcfzQcPDfTSsmF4zfiiUoB2Rq4nZbIEftL1uJrqqQeWaI4gR6
	 MOaN39L1zpApUUXLgQ3G/IFF0RGXvPqCk613v8NsVeHH8VQpxVZ3WqempZOxNWE0Hp
	 z2xlNlJdsjte1PEHHlpYrLj5FkLUSMs+bw6xcVzl83WpsoBx/+Hb6B6aH/aoLl3UNz
	 7RUQzsCVXA8Vbv539D8qdBcG0QucPIclZEtfa2wgiO0jvrHk2NlZXWrlC03zX62WG8
	 q/kHXkS0/f1Jw==
Date: Sat, 28 May 2022 20:56:17 +0800
From: Gao Xiang <xiang@kernel.org>
To: Hongnan Li <hongnan.li@linux.alibaba.com>
Subject: Re: [PATCH] erofs: update ctx->pos for every emitted dirent
Message-ID: <YpIb8e7eWy+IFi/j@debian>
Mail-Followup-To: Hongnan Li <hongnan.li@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	linux-kernel@vger.kernel.org
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hongnan,

On Fri, May 27, 2022 at 03:25:36PM +0800, Hongnan Li wrote:
> erofs_readdir update ctx->pos after filling a batch of dentries
> and it may cause dir/files duplication for NFS readdirplus which
> depends on ctx->pos to fill dir correctly. So update ctx->pos for
> every emitted dirent in erofs_fill_dentries to fix it.
> 
> Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
> Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
> ---
>  fs/erofs/dir.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..3015974fe2ff 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
>  }
>  
>  static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
> -			       void *dentry_blk, unsigned int *ofs,
> +			       void *dentry_blk, void *dentry_begin,
>  			       unsigned int nameoff, unsigned int maxsize)
>  {
> -	struct erofs_dirent *de = dentry_blk + *ofs;
> +	struct erofs_dirent *de = dentry_begin;
>  	const struct erofs_dirent *end = dentry_blk + nameoff;
> +	loff_t begin_pos = ctx->pos;
>  
>  	while (de < end) {
>  		const char *de_name;
> @@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>  			/* stopped by some reason */
>  			return 1;
>  		++de;
> -		*ofs += sizeof(struct erofs_dirent);
> +		ctx->pos += sizeof(struct erofs_dirent);
>  	}
> -	*ofs = maxsize;
> +	ctx->pos = begin_pos + maxsize;
>  	return 0;
>  }
>  
> @@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  				goto skip_this;
>  		}
>  
> -		err = erofs_fill_dentries(dir, ctx, de, &ofs,
> +		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
>  					  nameoff, maxsize);

This will break the calculation, since de is a pointer of erofs_dirent
rather than byte-based.

Thanks,
Gao Xiang
