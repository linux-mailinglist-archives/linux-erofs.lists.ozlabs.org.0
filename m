Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA454F7250
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 04:50:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYm8Q6StHz2yh9
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 12:50:30 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYm8M3XdYz2xdN
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Apr 2022 12:50:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0V9Onnyg_1649299816; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V9Onnyg_1649299816) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 07 Apr 2022 10:50:18 +0800
Date: Thu, 7 Apr 2022 10:50:16 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 10/20] erofs: register fscache volume
Message-ID: <Yk5RaIdjg8fd3YQR@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-11-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-11-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:56:02PM +0800, Jeffle Xu wrote:
> A new fscache based mode is going to be introduced for erofs, in which
> case on-demand read semantics is implemented through fscache.
> 
> As the first step, register fscache volume for each erofs filesystem.
> That means, data blobs can not be shared among erofs filesystems. In the
> following iteration, we are going to introduce the domain semantics, in
> which case several erofs filesystems can belong to one domain, and data
> blobs can be shared among these erofs filesystems of one domain.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/Kconfig    | 10 ++++++++++
>  fs/erofs/Makefile   |  1 +
>  fs/erofs/fscache.c  | 37 +++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h | 13 +++++++++++++
>  fs/erofs/super.c    |  7 +++++++
>  5 files changed, 68 insertions(+)
>  create mode 100644 fs/erofs/fscache.c
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index f57255ab88ed..3d05265e3e8e 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -98,3 +98,13 @@ config EROFS_FS_ZIP_LZMA
>  	  systems will be readable without selecting this option.
>  
>  	  If unsure, say N.
> +
> +config EROFS_FS_ONDEMAND
> +	bool "EROFS fscache-based ondemand-read"
> +	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
> +	default n
> +	help
> +	  EROFS is mounted from data blobs and on-demand read semantics is
> +	  implemented through fscache.
> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 8a3317e38e5a..99bbc597a3e9 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -5,3 +5,4 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
>  erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>  erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> +erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> new file mode 100644
> index 000000000000..7a6d0239ebb1
> --- /dev/null
> +++ b/fs/erofs/fscache.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022, Alibaba Cloud
> + */
> +#include <linux/fscache.h>
> +#include "internal.h"
> +
> +int erofs_fscache_register_fs(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct fscache_volume *volume;
> +	char *name;
> +	int ret = 0;
> +
> +	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	volume = fscache_acquire_volume(name, NULL, NULL, 0);
> +	if (IS_ERR_OR_NULL(volume)) {
> +		erofs_err(sb, "failed to register volume for %s", name);
> +		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
> +		volume = NULL;
> +	}
> +
> +	sbi->volume = volume;
> +	kfree(name);
> +	return ret;
> +}
> +
> +void erofs_fscache_unregister_fs(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	fscache_relinquish_volume(sbi->volume, NULL, false);
> +	sbi->volume = NULL;
> +}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 05a97533b1e9..952a2f483f94 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -74,6 +74,7 @@ struct erofs_mount_opts {
>  	unsigned int max_sync_decompress_pages;
>  #endif
>  	unsigned int mount_opt;
> +	char *fsid;
>  };
>  
>  struct erofs_dev_context {
> @@ -146,6 +147,9 @@ struct erofs_sb_info {
>  	/* sysfs support */
>  	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
>  	struct completion s_kobj_unregister;
> +
> +	/* fscache support */
> +	struct fscache_volume *volume;
>  };
>  
>  #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -618,6 +622,15 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  }
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
> +/* fscache.c */
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +int erofs_fscache_register_fs(struct super_block *sb);
> +void erofs_fscache_unregister_fs(struct super_block *sb);
> +#else
> +static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
> +static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> +#endif
> +
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
>  
>  #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..6590ed1b7d3b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -601,6 +601,12 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> +	if (erofs_is_fscache_mode(sb)) {
> +		err = erofs_fscache_register_fs(sb);
> +		if (err)
> +			return err;
> +	}
> +
>  	err = erofs_read_superblock(sb);
>  	if (err)
>  		return err;
> @@ -757,6 +763,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev);
> +	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
>  }
> -- 
> 2.27.0
