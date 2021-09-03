Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B823FF911
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 05:18:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H130W6lN9z2yJV
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 13:18:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H130S1V6rz2xh0
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 13:18:31 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0Un3wm6H_1630639094; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Un3wm6H_1630639094) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Sep 2021 11:18:16 +0800
Date: Fri, 3 Sep 2021 11:18:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 5/5] erofs-utils: fix print style
Message-ID: <YTGT9shnxqLP6Iul@B-P7TQMD6M-0146.local>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210831165116.16575-6-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831165116.16575-6-jnhuang95@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 01, 2021 at 12:51:16AM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Fix warning "quoted string split across lines".
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  lib/inode.c | 3 +--
>  lib/io.c    | 3 +--
>  lib/zmap.c  | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index f001016..76f5fb3 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -741,8 +741,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
>  			  cfg.target_out_path,
>  			  &uid, &gid, &mode, &inode->capabilities);
>  
> -	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
> -		  "capabilities = 0x%" PRIx64 "\n",
> +	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, capabilities = 0x%" PRIx64 "\n",
>  		  fspath, mode, uid, gid, inode->capabilities);
>  
>  	if (decorated)
> diff --git a/lib/io.c b/lib/io.c
> index b053137..620cb9c 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -242,8 +242,7 @@ int dev_read(void *buf, u64 offset, size_t len)
>  	}
>  	if (offset >= erofs_devsz || len > erofs_devsz ||
>  	    offset > erofs_devsz - len) {
> -		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond"
> -			  "the end of device(%" PRIu64 ").",
> +		erofs_err("read posion[%" PRIu64 ", %zd] is too large beyond the end of device(%" PRIu64 ").",
>  			  offset, len, erofs_devsz);
>  		return -EINVAL;
>  	}
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 88da515..e4306ce 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -57,8 +57,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>  	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
>  	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
> -		erofs_err(
> -"big pcluster head1/2 of compact indexes should be consistent for nid %llu",
> +		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
>  			  vi->nid * 1ULL);
>  		return -EFSCORRUPTED;
>  	}
> -- 
> 2.25.1
