Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFC5F4726
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Oct 2022 18:08:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhjLG27Mmz30Mn
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Oct 2022 03:08:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HFN/1mY+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HFN/1mY+;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MhjL70wGFz2xYy
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Oct 2022 03:08:30 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 827C2614B0;
	Tue,  4 Oct 2022 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD6EC433C1;
	Tue,  4 Oct 2022 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664899705;
	bh=uFMwOLP3RUhCOk0dtvA+jQ3MjGUaf7MqATOqt3PVaOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFN/1mY+sFwQiffx3YtSM4uJXf8ssrhi8l7C/bwLZfTtbMfDtwmVX/U93UJkuyfhf
	 tul7ZEdJ8N2YykR2wp5/2sG/S+N99dDIlM1mHOk9+Gq4SP/i9BvZwDdmcJkpMWPoau
	 ViCBwEKLUYNHgorUHZAv89jgPRlmBtKt309BhlwpF7h880R1zcaTr/NPBvTzcKVS0m
	 nQIeXAPPf8R/+umcG71x2/pdW+QOSIWIYS86pvrjSFkequhR+3wMZjedLLLshiJwmX
	 UDAJzlyit5UJVJfqZTCQRoLrHcKF4HquMvjprz55Y+uRr4fiOPKOV52dsO5IjPFJDc
	 WVdplxud/jGuw==
Date: Wed, 5 Oct 2022 00:08:21 +0800
From: Gao Xiang <xiang@kernel.org>
To: Yue Hu <zbestahu@163.com>
Subject: Re: [PATCH] erofs: fix the unmapped access in
 z_erofs_fill_inode_lazy()
Message-ID: <YzxadSy1YToNHQGr@debian>
Mail-Followup-To: Yue Hu <zbestahu@163.com>, chao@kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
References: <20221004144951.31075-1-zbestahu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004144951.31075-1-zbestahu@163.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Oct 04, 2022 at 10:49:51PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Note that we are still accessing 'h_idata_size' and 'h_fragmentoff'
> after calling erofs_put_metabuf(), that is not correct. Fix it.
> 
> Fixes: ab92184ff8f1 ("add on-disk compressed tail-packing inline support")
> Fixes: b15b2e307c3a ("support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/erofs/zmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 

erofs: fix invalid unmapped accesses in z_erofs_fill_inode_lazy()

> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 44c27ef39c43..1a15bbf18ba3 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -58,7 +58,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
>  		    vi->xattr_isize, 8);
>  	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
> -				   EROFS_KMAP_ATOMIC);
> +				   EROFS_KMAP);

	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP); ?

Also I will use kmap_local later to replace kmap and kmap_atomic if
possible.

>  	if (IS_ERR(kaddr)) {
>  		err = PTR_ERR(kaddr);
>  		goto out_unlock;
> @@ -73,7 +73,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
>  		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
>  		vi->z_tailextent_headlcn = 0;
> -		goto unmap_done;
> +		goto init_done;
>  	}
>  	vi->z_advise = le16_to_cpu(h->h_advise);
>  	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
> @@ -105,10 +105,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  		err = -EFSCORRUPTED;
>  		goto unmap_done;
>  	}
> -unmap_done:
> -	erofs_put_metabuf(&buf);
> -	if (err)
> -		goto out_unlock;
>  
>  	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
>  		struct erofs_map_blocks map = {
> @@ -127,7 +123,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  			err = -EFSCORRUPTED;
>  		}
>  		if (err < 0)
> -			goto out_unlock;
> +			goto unmap_done;
>  	}
>  
>  	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
> @@ -141,11 +137,14 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
>  					    EROFS_GET_BLOCKS_FINDTAIL);
>  		erofs_put_metabuf(&map.buf);
>  		if (err < 0)
> -			goto out_unlock;
> +			goto unmap_done;
>  	}
> +init_done:

done:

>  	/* paired with smp_mb() at the beginning of the function */
>  	smp_mb();
>  	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
> +unmap_done:

out_put_metabuf:

Thanks,
Gao Xiang

> +	erofs_put_metabuf(&buf);
>  out_unlock:
>  	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
>  	return err;
> -- 
> 2.25.1
> 
