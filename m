Return-Path: <linux-erofs+bounces-1052-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CC2B8EB8A
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Sep 2025 03:49:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVQyK0LwPz2yrl;
	Mon, 22 Sep 2025 11:49:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758505752;
	cv=none; b=IX+V21eONq3DnxgD/MBW6ZsTW4WHq5kczwxPTd6m9iyp478WaHMJ9C5XIXLxGstqGWPikMPyWyoYv6Xk3JWsyY1Rvp4GR1W+sbIVL2qfs4R8eCo08pplhE4tGAk67y5TvdzO7ndMKNwLtsYZednCz5sDWgf7/PObqwKBqk0A6p5w16UC8pwF60SUa6qxaowrDJGpeeeFW7xEdX8sBBBAxUa1kYKP1ZGxrw0yHODzZL8KjnKIY2ZOB+b8CjwlfYxP8PULNZXrm5sCY3P0sTPKOKM9DoqRZsc5dGNUblolXPBTmc3uX9JynuKctc/aH5btiBsDQ0x1/xjY3L0ZXHyUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758505752; c=relaxed/relaxed;
	bh=Poayc0RqgwJy1pB7pq1QbfeCMD4BfPBzJE20vpS6iYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gseadV8gQOkbPTR7QMoXgpNV0+pvDxLdaeTfJiZDzLooCVGCLM8lwUQosF6lkKXYeMGXmJaHBSNsNqJoilLttgoyg0HnTWq9+urA7OsBNF4dJ7eweXVYLVXgFwoSlZrYDQ3RzWbtI19s0VcULitqRz4WKbE70/AuLBNsIxFQGF1ZFJq9or/6CL8L3w9qh9lmgWoGOKFboxCymMa4Gk8ZF9trENWowsh2Xfm5vNS+VvrMhFBCqs60yqmKZWPdqAzo+Y+VVMwh7LBLRGJzJe0Ob192YyO0SxePFqxOQ0L8lM/xQ9IVGOYBRxlNul2kVTviRKJIAi+CbPJnYBEyRhh7eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k75+ugLS; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k75+ugLS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVQyH1m3qz2yr9
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Sep 2025 11:49:09 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758505745; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Poayc0RqgwJy1pB7pq1QbfeCMD4BfPBzJE20vpS6iYk=;
	b=k75+ugLSutxOe8REjkDwPGbPucqhg7+nQp8GQvYHbnYmTi6p/vl5cn0bsUT39lb6ukUElHDZTN/ciRKq8MUrQe+nuNnW6+OPyAYmOnf70gYzIMfHGljkqyInru/V3iu3oe9vtonZpPU+s1ouNpqcVXBnwCvNNcg7qh7gCw5ko7Q=
Received: from 30.221.131.10(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoQX48k_1758505741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 09:49:02 +0800
Message-ID: <47107a3c-44d5-4937-bc35-2e01605bdb98@linux.alibaba.com>
Date: Mon, 22 Sep 2025 09:49:00 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <20250920060455.24002-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250920060455.24002-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/20 14:04, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> ---
> 
> v1: https://lore.kernel.org/linux-erofs/63904ade56634923ba734dcdab3c45d0@inspur.com/T/#t
> v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/T/#u
> 
> Changes since v2:
> - remove unnecessary code
> 
>   fs/erofs/Makefile   |  2 +-
>   fs/erofs/data.c     |  4 ++++
>   fs/erofs/dir.c      |  4 ++++
>   fs/erofs/inode.c    |  5 +----
>   fs/erofs/internal.h |  7 +++++++
>   fs/erofs/ioctl.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  8 ++++++++
>   7 files changed, 66 insertions(+), 5 deletions(-)
>   create mode 100644 fs/erofs/ioctl.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..5be6cc4acc1c 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   obj-$(CONFIG_EROFS_FS) += erofs.o
> -erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
> +erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o ioctl.o
>   erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>   erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3b1ba571c728..8ca29962a3dd 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
>   const struct file_operations erofs_file_fops = {
>   	.llseek		= erofs_file_llseek,
>   	.read_iter	= erofs_file_read_iter,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   	.mmap_prepare	= erofs_file_mmap_prepare,
>   	.get_unmapped_area = thp_get_unmapped_area,
>   	.splice_read	= filemap_splice_read,
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index debf469ad6bd..32b4f5aa60c9 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read		= generic_read_dir,
>   	.iterate_shared	= erofs_readdir,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>   };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 9a2f59721522..a7ec17eec4b2 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			inode->i_fop = &generic_ro_fops;
> -		else
> -			inode->i_fop = &erofs_file_fops;
> +		inode->i_fop = &erofs_file_fops;
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ccc5f0ee8df..311346a017a7 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -166,6 +166,9 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	/* volume name */

The comment is useless, just drop this line.

> +	char *volume_name;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -535,6 +538,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg);
> +
>   #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
>   
>   #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/erofs/ioctl.c b/fs/erofs/ioctl.c
> new file mode 100644
> index 000000000000..fbcbf820c4d7
> --- /dev/null
> +++ b/fs/erofs/ioctl.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/fs.h>
> +#include <linux/compat.h>
> +#include <linux/file.h>
> +
> +#include "internal.h"
> +
> +static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)

Can we just move these functions into inode.c instead?

Since there is no need to introduce a new file just for
a few new lines.

Otherwise it looks good to me.

Thanks,
Gao Xiang

