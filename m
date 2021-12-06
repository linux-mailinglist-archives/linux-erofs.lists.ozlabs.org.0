Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B082D46955A
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 13:01:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J728f4z20z2ybK
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Dec 2021 23:01:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J728Z4J4fz2y7K
 for <linux-erofs@lists.ozlabs.org>; Mon,  6 Dec 2021 23:01:28 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UzdFtpu_1638792078; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UzdFtpu_1638792078) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 06 Dec 2021 20:01:20 +0800
Date: Mon, 6 Dec 2021 20:01:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH v6 3/3] erofs: add sysfs node to control sync
 decompression strategy
Message-ID: <Ya37jpMvLXVMSncO@B-P7TQMD6M-0146.local>
References: <20211112160935.19394-1-jnhuang95@gmail.com>
 <20211112160935.19394-3-jnhuang95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112160935.19394-3-jnhuang95@gmail.com>
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
Cc: yh@oppo.com, guanyuwei@oppo.com, guoweichao@oppo.com,
 linux-erofs@lists.ozlabs.org, zhangshiming@oppo.co
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Sat, Nov 13, 2021 at 12:09:35AM +0800, Huang Jianan wrote:
> From: Huang Jianan <huangjianan@oppo.com>
> 
> Although readpage is a synchronous path, there will be no additional
> kworker scheduling overhead in non-atomic contexts. So add a sysfs
> node to allow disable sync decompression.

Sorry for the delay. Please help update the following so I could apply
to -next.

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts together with
dm-verity.

Let's add a sysfs node to disable sync decompression as an option.

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
> since v4:
> - Resend in a clean chain.
> 
> since v3:
> - Clean up the sync decompressstrategy into a separate function.
> 
> since v2:
> - Use enum to indicate sync decompression strategy.
> - Add missing CONFIG_EROFS_FS_ZIP ifdef.
> 
> since v1:
> - Leave auto default.
> - Add a disable strategy for sync_decompress.
> 
>  Documentation/ABI/testing/sysfs-fs-erofs |  9 ++++++++
>  fs/erofs/internal.h                      | 10 ++++++--
>  fs/erofs/super.c                         |  2 +-
>  fs/erofs/sysfs.c                         | 15 ++++++++++++
>  fs/erofs/zdata.c                         | 29 ++++++++++++++++++++----
>  5 files changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index a9512594dc4c..8b620fb49962 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
>  		Supported features:
>  		zero_padding, compr_cfgs, big_pcluster, chunked_file,
>  		device_table, compr_head2, sb_chksum.
> +
> +What:		/sys/fs/erofs/<disk>/sync_decompress
> +Date:		November 2021
> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> +Description:	Control strategy of sync decompression
> +		- 0 (defalut, auto): enable for readpage, and enable for

                     ^ default

> +				     readahead on atomic contexts only,
> +		- 1 (force on): enable for readpage and readahead.
> +		- 2 (force off): disable for all situations.
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 43f0332fa489..8e70435629e5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -56,12 +56,18 @@ struct erofs_device_info {
>  	u32 mapped_blkaddr;
>  };
>  
> +enum {
> +	EROFS_SYNC_DECOMPRESS_AUTO,
> +	EROFS_SYNC_DECOMPRESS_FORCE_ON,
> +	EROFS_SYNC_DECOMPRESS_FORCE_OFF
> +};
> +
>  struct erofs_mount_opts {
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	/* current strategy of how to use managed cache */
>  	unsigned char cache_strategy;
> -	/* strategy of sync decompression (false - auto, true - force on) */
> -	bool readahead_sync_decompress;
> +	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
> +	unsigned int sync_decompress;
>  
>  	/* threshold for decompression synchronously */
>  	unsigned int max_sync_decompress_pages;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index abc1da5d1719..58f381f80205 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
>  	ctx->opt.max_sync_decompress_pages = 3;
> -	ctx->opt.readahead_sync_decompress = false;
> +	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
>  #endif
>  #ifdef CONFIG_EROFS_FS_XATTR
>  	set_opt(&ctx->opt, XATTR_USER);
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 80ca5ed59bb4..8f0a71e880ea 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -16,6 +16,7 @@ enum {
>  
>  enum {
>  	struct_erofs_sb_info,
> +	struct_erofs_mount_opts,
>  };
>  
>  struct erofs_attr {
> @@ -55,7 +56,14 @@ static struct erofs_attr erofs_attr_##_name = {			\
>  
>  #define ATTR_LIST(name) (&erofs_attr_##name.attr)
>  
> +#ifdef CONFIG_EROFS_FS_ZIP
> +EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
> +#endif
> +
>  static struct attribute *erofs_attrs[] = {
> +#ifdef CONFIG_EROFS_FS_ZIP
> +	ATTR_LIST(sync_decompress),
> +#endif
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(erofs);
> @@ -86,6 +94,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
>  {
>  	if (struct_type == struct_erofs_sb_info)
>  		return (unsigned char *)sbi + offset;
> +	if (struct_type == struct_erofs_mount_opts)
> +		return (unsigned char *)&sbi->opt + offset;
>  	return NULL;
>  }
>  
> @@ -132,6 +142,11 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>  			return ret;
>  		if (t > UINT_MAX)
>  			return -EINVAL;
> +#ifdef CONFIG_EROFS_FS_ZIP
> +		if (!strcmp(a->attr.name, "sync_decompress") &&
> +		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
> +			return -EINVAL;
> +#endif
>  		*(unsigned int *)ptr = t;
>  		return len;
>  	case attr_pointer_bool:
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index bcb1b91b234f..233c8a047c53 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -772,6 +772,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	goto out;
>  }
>  
> +static void set_sync_decompress_policy(struct erofs_sb_info *sbi)
> +{
> +	/* enable sync decompression in readahead for atomic contexts */
> +	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
> +		sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
> +}
> +
> +static bool get_sync_decompress_policy(struct erofs_sb_info *sbi,
> +				       unsigned int readahead_pages)

static bool z_erofs_get_sync_decompress_policy ...

> +{
> +	/* auto: enable for readpage, disable for readahead */
> +	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
> +		return readahead_pages == 0;

	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO &&
	    !readahead_pages)
		return true;

> +
> +	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON)
> +		return readahead_pages <= sbi->opt.max_sync_decompress_pages;

Same here.

> +
> +	return false;
> +}
> +
>  static void z_erofs_decompressqueue_work(struct work_struct *work);
>  static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>  				       bool sync, int bios)
> @@ -794,7 +814,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
>  	/* Use workqueue and sync decompression for atomic contexts only */
>  	if (in_atomic() || irqs_disabled()) {
>  		queue_work(z_erofs_workqueue, &io->u.work);
> -		sbi->opt.readahead_sync_decompress = true;
> +		set_sync_decompress_policy(sbi);

Please help inline this since this is the only one caller.

Thanks,
Gao Xiang
