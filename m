Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB553FF90D
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 05:17:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H12zV2flnz2yJV
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 13:17:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H12zQ2TK0z2xh0
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 13:17:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0Un3Lefy_1630639049; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Un3Lefy_1630639049) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 03 Sep 2021 11:17:31 +0800
Date: Fri, 3 Sep 2021 11:17:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH 4/5] erofs-utils: remove unnecessary codes and comments
Message-ID: <YTGTyXf176qLxQph@B-P7TQMD6M-0146.local>
References: <20210831165116.16575-1-jnhuang95@gmail.com>
 <20210831165116.16575-5-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831165116.16575-5-jnhuang95@gmail.com>
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

On Wed, Sep 01, 2021 at 12:51:15AM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  lib/inode.c | 4 ----
>  lib/zmap.c  | 1 -
>  2 files changed, 5 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 62047d3..f001016 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -677,11 +677,7 @@ out:
>  		 * Don't leave DATA buffers which were written in the global
>  		 * buffer list. It will make balloc() slowly.
>  		 */
> -#if 0
> -		bh->op = &erofs_drop_directly_bhops;
> -#else
>  		erofs_bdrop(bh, false);
> -#endif
>  		inode->bh_data = NULL;
>  	}
>  	return 0;
> diff --git a/lib/zmap.c b/lib/zmap.c
> index fdc84af..88da515 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -423,7 +423,6 @@ static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
>  			goto err_bonus_cblkcnt;
>  		if (m->compressedlcs)
>  			break;
> -		/* fallthrough */

I don't think this should be removed. On the kernel side, we use
"fallthrough;" instead.

Could we add all the missing "/* fallthrough */"?

Thanks,
Gao Xiang

>  	default:
>  		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
>  			  lcn, vi->nid | 0ULL);
> -- 
> 2.25.1
