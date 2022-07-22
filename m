Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977E57DCFA
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 10:56:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lq3FQ01k1z3c7Q
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 18:56:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.10; helo=out199-10.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 307 seconds by postgrey-1.36 at boromir; Fri, 22 Jul 2022 18:56:04 AEST
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lq3FJ1W0Zz3byr
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 18:56:02 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK4TgQN_1658479845;
Received: from 30.227.66.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VK4TgQN_1658479845)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 16:50:45 +0800
Message-ID: <2dd86247-2fd4-8785-8545-009081291cab@linux.alibaba.com>
Date: Fri, 22 Jul 2022 16:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] erofs: get rid of erofs_prepare_dio() helper
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20220720082229.12172-1-hsiangkao@linux.alibaba.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220720082229.12172-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/20/22 4:22 PM, Gao Xiang wrote:
> Fold in erofs_prepare_dio() in order to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v1: https://lore.kernel.org/r/20220506194612.117120-1-hsiangkao@linux.alibaba.com
> 
>  fs/erofs/data.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index fbb037ba326e..fe8ac0e163f7 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -366,42 +366,33 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>  	return iomap_bmap(mapping, block, &erofs_iomap_ops);
>  }
>  
> -static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
> +static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	struct inode *inode = file_inode(iocb->ki_filp);
> -	loff_t align = iocb->ki_pos | iov_iter_count(to) |
> -		iov_iter_alignment(to);
> -	struct block_device *bdev = inode->i_sb->s_bdev;
> -	unsigned int blksize_mask;
> -
> -	if (bdev)
> -		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
> -	else
> -		blksize_mask = (1 << inode->i_blkbits) - 1;
>  
> -	if (align & blksize_mask)
> -		return -EINVAL;
> -	return 0;
> -}
> -
> -static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> -{
>  	/* no need taking (shared) inode lock since it's a ro filesystem */
>  	if (!iov_iter_count(to))
>  		return 0;
>  
>  #ifdef CONFIG_FS_DAX
> -	if (IS_DAX(iocb->ki_filp->f_mapping->host))
> +	if (IS_DAX(inode))
>  		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
>  #endif
>  	if (iocb->ki_flags & IOCB_DIRECT) {
> -		int err = erofs_prepare_dio(iocb, to);
> +		struct block_device *bdev = inode->i_sb->s_bdev;
> +		unsigned int blksize_mask;
> +
> +		if (bdev)
> +			blksize_mask = bdev_logical_block_size(bdev) - 1;
> +		else
> +			blksize_mask = (1 << inode->i_blkbits) - 1;
> +
> +		if ((iocb->ki_pos | iov_iter_count(to) |
> +		     iov_iter_alignment(to)) & blksize_mask)
> +			return -EINVAL;
>  
> -		if (!err)
> -			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> -					    NULL, 0, NULL, 0);
> -		if (err < 0)
> -			return err;
> +		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
> +				    NULL, 0, NULL, 0);
>  	}
>  	return filemap_read(iocb, to, 0);
>  }

LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
