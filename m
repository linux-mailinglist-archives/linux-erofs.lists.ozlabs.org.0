Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC76402195
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 02:11:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3Qfk1x7Sz2y8S
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 10:11:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=g9tICKpi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=g9tICKpi; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3Qfg3fBwz2xnc
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 10:11:23 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FFDA60ED8;
 Tue,  7 Sep 2021 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630973481;
 bh=eEMqmHncb0jQ+YWjdQJLi7TmfiXDXYQ6feqH19dJIcY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g9tICKpiz6yH0FyHyHBEpXpTsOu+cUUn/UQSIh3vdUjn4ihulbbyhZWDMpDeLkL3L
 YN7KZiJxcGysrNw5JmFhmtwOO2wAMticWjnZSjRddwtDVuIP+NQyNvpRw08Y6Upiy3
 mnAvzfvntdpWQnakZu3AWx64ZZL4dPB+RzUDYSLgsdQyZzw6/dLj6Prkp/YFx/5u4a
 1xiNBVQ0AlSUaLlyI4SskJiJOVzrGoc3ZwtfA8wAXhEAyN84Bi8eoOcKupI1q7ehhq
 jxtGtzi7H6VyhwCGbP/BKqnuuGBaUiWUAgd57OWDPBszXylglP2eKyE7eMGxcSxwjW
 v76urL6H6pnAg==
Date: Tue, 7 Sep 2021 08:10:45 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] uerofs-utils: fix random data for block-aligned
 uncompressed file
Message-ID: <20210907001038.GC23541@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210906081359.17440-1-huangjianan@oppo.com>
 <20210906081359.17440-2-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906081359.17440-2-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: yh@oppo.com, kevin.liw@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 06, 2021 at 04:13:59PM +0800, Huang Jianan via Linux-erofs wrote:
> If the file size is block-aligned for uncompressed files, i_u is
> meaningless for erofs_inode on disk, but it's not cleared when
> datalayout is seted in erofs_prepare_inode_buffer. Clear the entire
> erofs_inode to zero to fix this.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  lib/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 0ad703d..1397cc5 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -834,7 +834,7 @@ static struct erofs_inode *erofs_new_inode(void)
>  	static unsigned int counter;
>  	struct erofs_inode *inode;
>  
> -	inode = malloc(sizeof(struct erofs_inode));
> +	inode = calloc(1, sizeof(struct erofs_inode));

If we decide to do this, how about removing all
	inode->idata_size = 0;
	inode->xattr_isize = 0;
	inode->extent_isize = 0;

	inode->bh = inode->bh_inline = inode->bh_data = NULL;
	inode->idata = NULL;
?

Thanks,
Gao Xiang

>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.25.1
> 
