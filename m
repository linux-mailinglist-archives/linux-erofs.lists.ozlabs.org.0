Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93014029A1
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 15:21:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3mBX4F34z2y0C
	for <lists+linux-erofs@lfdr.de>; Tue,  7 Sep 2021 23:21:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j74HXNab;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=j74HXNab; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3mBT0Q2wz2xfn
 for <linux-erofs@lists.ozlabs.org>; Tue,  7 Sep 2021 23:21:36 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 891256056B;
 Tue,  7 Sep 2021 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631020893;
 bh=7Llz34Nhn66XhQTgSQCh3c5vBRXgk79rOKSxi1FpMH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j74HXNabTY36zbZGBeoRVF0RYeJP2tqtaWk3Udx1i9DmOl28zytlHDpbWLxi9T/NZ
 RjNasAAgI6ZldYdNhIuKo1FcDlZTc+f0SNEnNkBVSbLs5We2WiicNkn2qVINGjtp3O
 NglvWjgi/n45OJ+qVT+6osU/quH5Q89Q+QazZDxhYj8ICdAcjmtzSJ4Kag6y9v1cKc
 iw6ocsCrwY/EOvYL1tBKXBczLCnS5hv6+TLObk+npfdemC0IPk35GSzdlkSq6ZhsbN
 4q2wpYHU/xsrfbTtDHYlkJcI6+QdBdfk+h7/dyy+vxeblJeB73d51hxo5z+y502pps
 P5Bk+dUKN/PzQ==
Date: Tue, 7 Sep 2021 21:20:50 +0800
From: Gao Xiang <xiang@kernel.org>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH V2] erofs-utils: fix random data for block-aligned
 uncompressed file
Message-ID: <20210907132048.GA2401@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Huang Jianan <huangjianan@oppo.com>,
 linux-erofs@lists.ozlabs.org, yh@oppo.com, kevin.liw@oppo.com,
 guoweichao@oppo.com, guanyuwei@oppo.com
References: <20210906081359.17440-2-huangjianan@oppo.com>
 <20210907035345.22735-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907035345.22735-1-huangjianan@oppo.com>
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

On Tue, Sep 07, 2021 at 11:53:45AM +0800, Huang Jianan via Linux-erofs wrote:
> If the file size is block-aligned for uncompressed files, i_u is
> meaningless for erofs_inode on disk, but it's not cleared when
> datalayout is seted in erofs_prepare_inode_buffer.
> 
> This problem will cause inconsistent reproducible builds. Clear the
> entire erofs_inode to zero to fix this.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

BTW, how about adding --from="Huang Jianan <huangjianan@oppo.com>" when
sending patches with OPPO emails.

Otherwise, it seems the author becomes
"Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>" when
reaching to the mailing list and I have to update it by hand....

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 5bad75e..0cce07d 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -834,25 +834,15 @@ static struct erofs_inode *erofs_new_inode(void)
>  	static unsigned int counter;
>  	struct erofs_inode *inode;
>  
> -	inode = malloc(sizeof(struct erofs_inode));
> +	inode = calloc(1, sizeof(struct erofs_inode));
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -	inode->i_parent = NULL;	/* also used to indicate a new inode */
> -
>  	inode->i_ino[0] = counter++;	/* inode serial number */
>  	inode->i_count = 1;
>  
>  	init_list_head(&inode->i_subdirs);
>  	init_list_head(&inode->i_xattrs);
> -
> -	inode->idata_size = 0;
> -	inode->xattr_isize = 0;
> -	inode->extent_isize = 0;
> -
> -	inode->bh = inode->bh_inline = inode->bh_data = NULL;
> -	inode->idata = NULL;
> -	inode->z_physical_clusterblks = 0;
>  	return inode;
>  }
>  
> -- 
> 2.25.1
> 
