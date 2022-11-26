Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E057D63934C
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 03:17:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJwNM1VyPz3f5Y
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 13:17:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iQjRcdo2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iQjRcdo2;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJwNB6zwmz3ccg
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Nov 2022 13:16:58 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 846E361141;
	Sat, 26 Nov 2022 02:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDD6C433D6;
	Sat, 26 Nov 2022 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669429013;
	bh=kDvPHj5wCrq6WnlvH9zd0KKVGoU2QtKs7JnTTAoekQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQjRcdo2n2lwx+A88dpKbiGVImpKl4W2SIvwL8CR4GfPEFlknaNWNymoS59Os1y8s
	 wmkajOC2vs/62msCTU7udrSWzdvHlTtvHHiyYsayQk95GYP1+rKZ4IcxeKZPOK/nH7
	 Z/mu00lAOp3e2RqqRyIU6M6rMjkpbb6JP5d+Ooi+pP3EGLj/qH2wm9WD+WLEYmeMek
	 mVSS6lB7XeMvbxlEIuBr3kMvouLrz0ZluKN5+UCInBMXRnjAJyVZIDToI7BH0WxneK
	 JXSXjwkoLruGzlXzlatNbMJVzoQpmyRD2caAQ9bNEV3OUQAcV8Mk2YCZD3ycrVvDud
	 JUKWJBCNMpDlQ==
Date: Sat, 26 Nov 2022 10:16:48 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 2/2] erofs: enable large folio support for non-compressed
 format
Message-ID: <Y4F3EGk+0najgTco@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
 <20221126005756.7662-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221126005756.7662-3-jefflexu@linux.alibaba.com>
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

Hi Jingbo,

On Sat, Nov 26, 2022 at 08:57:56AM +0800, Jingbo Xu wrote:
> Enable large folio in both device and fscache mode.  Then the readahead

         ^ large folios in both iomap and fscache modes.

I tend to enable iomap/fscache large folios with two patches.
Also please see dev-test branch.


> routine will pass down large folio containing multiple pages.
> 
> Enable this feature for non-compressed format for now, until the
> compression part supports large folio later.

                            ^ large folios

> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 1 +
>  fs/erofs/inode.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 0643b205c7eb..d2dd58ce312b 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -436,6 +436,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>  		inode->i_size = OFFSET_MAX;
>  		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +		mapping_set_large_folios(inode->i_mapping);
>  

Meta inodes currently doesn't need large folios for now, and
we don't have readahead policy for these.

>  		ctx->inode = inode;
>  	}
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index ad2a82f2eb4c..85932086d23f 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -295,6 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>  		goto out_unlock;
>  	}
>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +	mapping_set_large_folios(inode->i_mapping);
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	if (erofs_is_fscache_mode(inode->i_sb))
>  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> -- 
> 2.19.1.6.gb485710b
> 
