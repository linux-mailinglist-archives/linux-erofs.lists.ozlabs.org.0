Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC16933538
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 04:01:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HuYBQFPo;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNzgM1V4zz3dJs
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jul 2024 12:01:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HuYBQFPo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNzgD1RPpz30Vv
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jul 2024 12:00:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721181650; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qn4YNmQesyYA7x5FZl+8m77z1qbmFe4k/1rGJiEHD6Y=;
	b=HuYBQFPoEl7ihchENzCPvRt/8qoLaQFWV/ZAmrD6GKnRNAtozsF+fb6u2quFu6XJhGCDA/zKObsHxyytqjGQL4TS2rEHdDpVZUwFC9ny4vvdKPLJZOE9+tW6Zd8X/EBj4Z/lOOwfwxDrIbvXs1xK3WtFncVqULk2hw5+GPsmEN4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0WAircwo_1721181648;
Received: from 30.97.49.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WAircwo_1721181648)
          by smtp.aliyun-inc.com;
          Wed, 17 Jul 2024 10:00:49 +0800
Message-ID: <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
Date: Wed, 17 Jul 2024 10:00:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support STATX_DIOALIGN
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 dhowells@redhat.com
References: <20240716124534.2358151-1-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240716124534.2358151-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On 2024/7/16 20:45, Hongbo Li wrote:
> Add support for STATX_DIOALIGN to erofs, so that direct I/O
> alignment restrictions are exposed to userspace in a generic
> way.
> 
> [Before]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:0
> dio offset align:0
> ```
> 
> [After]
> ```
> ./statx_test /mnt/erofs/testfile
> statx(/mnt/erofs/testfile) = 0
> dio mem align:512
> dio offset align:512
> ```
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/inode.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..9325a6f0058a 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>   				  STATX_ATTR_IMMUTABLE);
>   
> +	/*
> +	 * Return the DIO alignment restrictions if requested.
> +	 *
> +	 * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
> +	 * the compressed file, so in these cases we report no DIO support.
> +	 */
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> +		stat->result_mask |= STATX_DIOALIGN;
> +		if (!erofs_is_fscache_mode(inode->i_sb) &&
> +			!erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
> +			struct block_device *bdev = inode->i_sb->s_bdev;
> +			unsigned int bsize = (bdev) ? bdev_logical_block_size(bdev) :
> +						i_blocksize(inode);

I guess in this way you could always use
			stat->dio_mem_align = bdev_logical_block_size(bdev);
			stat->dio_offset_align = stat->dio_mem_align;
? since bdev won't be NULL.

Otherwise it looks good to me.

Thanks,
Gao Xiang
