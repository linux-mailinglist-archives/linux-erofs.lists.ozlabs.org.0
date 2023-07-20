Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F058175A494
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jul 2023 04:56:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R5y4J6KK1z30hG
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jul 2023 12:56:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R5y491fy4z2ytb
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jul 2023 12:55:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vno8Ffq_1689821744;
Received: from 30.97.48.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vno8Ffq_1689821744)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 10:55:45 +0800
Message-ID: <3fb50487-0531-fbef-5f85-089e5e405bf9@linux.alibaba.com>
Date: Thu, 20 Jul 2023 10:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] erofs: boost negative xattr lookup with bloom
 filter
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230714031034.53210-1-jefflexu@linux.alibaba.com>
 <20230714031034.53210-3-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230714031034.53210-3-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/14 11:10, Jingbo Xu wrote:
> Optimise the negative xattr lookup with bloom filter.
> 
> The bit value for the bloom filter map has a reverse semantics for
> compatibility.  That is, the bit value of 0 indicates existence, while
> the bit value of 1 indicates the absence of corresponding xattr.
> 
> This feature is enabled only when xattr_filter_reserved is non-zero.

The initial version is _only_ enabled when xattr_filter_reserved is zero.

> The on-disk format for the filter map may change in the future, in which
> case the reserved flag will be set non-zero and we don't need bothering
> the compatible bits again at that time.  For now disable the optimization
> if this reserved flag is non-zero.

The filter map internals may may change in the future, ...


> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/Kconfig    |  1 +
>   fs/erofs/internal.h |  3 +++
>   fs/erofs/super.c    |  1 +
>   fs/erofs/xattr.c    | 13 +++++++++++++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index f259d92c9720..f49669def828 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -38,6 +38,7 @@ config EROFS_FS_DEBUG
>   config EROFS_FS_XATTR
>   	bool "EROFS extended attributes"
>   	depends on EROFS_FS
> +	select XXHASH
>   	default y
>   	help
>   	  Extended attributes are name:value pairs associated with inodes by
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 36e32fa542f0..ebcad25e3750 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -151,6 +151,7 @@ struct erofs_sb_info {
>   	u32 xattr_prefix_start;
>   	u8 xattr_prefix_count;
>   	struct erofs_xattr_prefix_item *xattr_prefixes;
> +	unsigned int xattr_filter_reserved;
>   #endif
>   	u16 device_id_mask;	/* valid bits of device id to be used */
>   
> @@ -251,6 +252,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
>   EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>   EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>   EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> +EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>   
>   /* atomic flag definitions */
>   #define EROFS_I_EA_INITED_BIT	0
> @@ -270,6 +272,7 @@ struct erofs_inode {
>   	unsigned char inode_isize;
>   	unsigned int xattr_isize;
>   
> +	unsigned long xattr_name_filter;

	unsigned int xattr_name_filter or
	u32 xattr_name_filter?

no need to use unsinged long here.

>   	unsigned int xattr_shared_count;
>   	unsigned int *xattr_shared_xattrs;
>   
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9d6a3c6158bd..72122323300e 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -388,6 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
>   	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
>   	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
> +	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
>   #endif
>   	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
>   	sbi->root_nid = le16_to_cpu(dsb->root_nid);
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 40178b6e0688..eb1d1974d4b3 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021-2022, Alibaba Cloud
>    */
>   #include <linux/security.h>
> +#include <linux/xxhash.h>
>   #include "xattr.h"
>   
>   struct erofs_xattr_iter {
> @@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>   	}
>   
>   	ih = it.kaddr + erofs_blkoff(sb, it.pos);
> +	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
>   	vi->xattr_shared_count = ih->h_shared_count;
>   	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
>   						sizeof(uint), GFP_KERNEL);
> @@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
>   		   void *buffer, size_t buffer_size)
>   {
>   	int ret;
> +	uint32_t bit;

	uint32_t hashbit; ?

Thanks,
Gao Xiang
