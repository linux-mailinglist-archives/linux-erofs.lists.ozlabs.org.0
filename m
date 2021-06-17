Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723F3AAF48
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 11:05:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5GNC0V95z3bsG
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Jun 2021 19:04:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5GN41K9Sz2yXW
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jun 2021 19:04:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0Uchrz-v_1623920669; 
Received: from bogon(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uchrz-v_1623920669) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Jun 2021 17:04:31 +0800
Date: Thu, 17 Jun 2021 17:04:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: do not check ->idata_size for compressed
 files in erofs_prepare_inode_buffer()
Message-ID: <YMsQHU+iSKE+FRO5@bogon>
References: <20210617082954.1001-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617082954.1001-1-zbestahu@gmail.com>
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
Cc: zbestahu@163.com, huyue2@yulong.com, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Thu, Jun 17, 2021 at 04:29:54PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> erofs_write_compressed_file() will always set inode->idata_size = 0
> if succeed, that means no tail-end data for compressed files. So, no
> need to call erofs_prepare_tail_block() which is used to handle
> tail-end data for that case. Just skip it.

Thanks for the patch, due to somewhat long time so I don't quite
remember the exact logic here now...

Yet from the description before, it's not strictly correct
since my original intention would be to support tail-packing
inline compressed data which is similar to uncompressed case
to decrease tail extent I/O and save more space.

BTW, if you have some interest, would you like to implement it? :)

Thanks,
Gao Xiang

> 
> Also, correct 'a inode' -> 'an inode'.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  lib/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index b6108db..b5f66de 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -111,7 +111,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>  	return d;
>  }
>  
> -/* allocate main data for a inode */
> +/* allocate main data for an inode */
>  static int __allocate_inode_bh_data(struct erofs_inode *inode,
>  				    unsigned long nblocks)
>  {
> @@ -572,11 +572,11 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
>  		int ret;
>  
>  		inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> -noinline:
>  		/* expend an extra block for tail-end data */
>  		ret = erofs_prepare_tail_block(inode);
>  		if (ret)
>  			return ret;
> +noinline:
>  		bh = erofs_balloc(INODE, inodesize, 0, 0);
>  		if (IS_ERR(bh))
>  			return PTR_ERR(bh);
> -- 
> 1.9.1
