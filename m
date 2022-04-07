Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C538C4F7543
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 07:19:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYqS14jj8z2yjS
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 15:19:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYqRt6d3Cz2xgY
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Apr 2022 15:19:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0V9PKtJ2_1649308730; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V9PKtJ2_1649308730) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 07 Apr 2022 13:18:52 +0800
Date: Thu, 7 Apr 2022 13:18:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] erofs: do not prompt for risk any more when using big
 pcluster
Message-ID: <Yk50Op9SqCF9CVRc@B-P7TQMD6M-0146.local>
References: <20220407050101.12556-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407050101.12556-1-huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, zbesathu@gmail.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Apr 07, 2022 at 01:01:23PM +0800, Yue Hu wrote:
> The big pluster feature has been merged for a year, it has been mostly
> stable now.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Agreed,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/decompressor.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 3efa686c7644..0f445f7e1df8 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -46,8 +46,6 @@ int z_erofs_load_lz4_config(struct super_block *sb,
>  			erofs_err(sb, "too large lz4 pclusterblks %u",
>  				  sbi->lz4.max_pclusterblks);
>  			return -EINVAL;
> -		} else if (sbi->lz4.max_pclusterblks >= 2) {
> -			erofs_info(sb, "EXPERIMENTAL big pcluster feature in use. Use at your own risk!");
>  		}
>  	} else {
>  		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
> -- 
> 2.17.1
