Return-Path: <linux-erofs+bounces-1534-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE6CD537C
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 10:00:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZXCV21hCz2xpm;
	Mon, 22 Dec 2025 20:00:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766394006;
	cv=none; b=lJ5lypnditGUmlrQaKsqo12VLSBhePNYUZijk1b3KQL0kvK2jblGOIPOOwelxpv+mtRfZ786zNSVFtfHJybyhPsoXUadyYx4HO1hof+G4kkmFsT4I4MOxYpMLq+ThwqlUOj7a6jDIYjVn+rlrk0VIHyNDwhs90mv/k3G1AqReVyYJzkPqHO7o6TSUXpeJ+2ZqQdNQXURtbyhlgvn17qymXHgSF/PuXXkSZuCoBFb/KZsYy4F5MuMMtbQIB4O97FZdGnY+rcfrzAqFnNFSvrmMzXcPpAnS6jbOOCXH6c/L5OzRzv7cHDK1DdwFMHwOQqV95hQakamzZWSL/OxDPArBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766394006; c=relaxed/relaxed;
	bh=jxe/cEa4eH1xVqpEhm+0NGaPUe2ug5mEQxd/s0liBI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvBQ+h04HqLjDUNsOYJOQr+oZpeuvA2u24sy3AYWCHI+C5RSeaTDIHro/NUd080qoz2QO3GCG06PhjYFRcraK4UhlX6PVIk9AskXwcQYt5QQt2dkX5YPow3rOQOs4zRZ/Vabu6rgV/Z4u10nWeAZWwQJ4LNR24Tda0sJgrt4fnKpc6GuAH1jY7hn8MpqXRu3atubafoAou7VuZYq5xL9fp/2RN/DnhrjChECKx+vWBk4dIBx2wpaW076r+9SfquwBOCaL5MAXKGptj9WtI4nEzAdf6FtXtqDR5E8FRHbBWJ64Ll56ViTKiM84pSiLQ5GqIRRYbkvYdMUFaR1f4oxsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q8XhGBW9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Q8XhGBW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZXCR2VcMz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 20:00:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766393996; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jxe/cEa4eH1xVqpEhm+0NGaPUe2ug5mEQxd/s0liBI4=;
	b=Q8XhGBW94FLcqn+QMR+QcD4hnU9jBn1BjIAWWsGWPd3izboW/xeIAB72OvnZDByradY+fqYPa8E14cuELreQATklGLYM0voyAIXpwkjXUmm3n0EKDzwg/BILRyTq4JDhmEUCKN/aXBbFhM767xujZk2wt+vah96VKcz14jGwWhY=
Received: from 30.221.132.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvOAy0V_1766393993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 16:59:53 +0800
Message-ID: <37fafc56-af2f-4a73-a5b7-2041049b8c71@linux.alibaba.com>
Date: Mon, 22 Dec 2025 16:59:52 +0800
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
Subject: Re: [PATCH v9 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251117132537.227116-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Hongbo,

On 2025/11/17 21:25, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/Makefile   |   1 +
>   fs/erofs/internal.h |  29 ++++++
>   fs/erofs/ishare.c   | 241 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  31 +++++-
>   4 files changed, 300 insertions(+), 2 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..a80e1762b607 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3033252211ba..93ad34f2b488 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -304,6 +304,22 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	union {
> +		/* internal dedup inode */
> +		struct {
> +			char *fingerprint;
> +			spinlock_t lock;
> +			/* all backing inodes */
> +			struct list_head backing_head;
> +		};
> +
> +		struct {
> +			struct inode *ishare;
> +			struct list_head backing_link;
> +		};
> +	};
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -410,6 +426,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations erofs_ishare_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> @@ -541,6 +558,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +int erofs_ishare_init(struct super_block *sb);
> +void erofs_ishare_exit(struct super_block *sb);
> +bool erofs_ishare_fill_inode(struct inode *inode);
> +void erofs_ishare_free_inode(struct inode *inode);
> +#else
> +static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
> +static inline void erofs_ishare_exit(struct super_block *sb) {}
> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>   			unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> new file mode 100644
> index 000000000000..f386efb260da
> --- /dev/null
> +++ b/fs/erofs/ishare.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include <linux/refcount.h>
> +#include <linux/mount.h>
> +#include <linux/mutex.h>
> +#include <linux/ramfs.h>
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#include "../internal.h"
> +
> +static DEFINE_MUTEX(erofs_ishare_lock);
> +static struct vfsmount *erofs_ishare_mnt;
> +static refcount_t erofs_ishare_supers;
> +
> +int erofs_ishare_init(struct super_block *sb)
> +{
> +	struct vfsmount *mnt = NULL;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	if (!erofs_sb_has_ishare_key(sbi))
> +		return 0;
> +
> +	mutex_lock(&erofs_ishare_lock);
> +	if (erofs_ishare_mnt) {
> +		refcount_inc(&erofs_ishare_supers);
> +	} else {
> +		mnt = kern_mount(&erofs_anon_fs_type);
> +		if (!IS_ERR(mnt)) {
> +			erofs_ishare_mnt = mnt;
> +			refcount_set(&erofs_ishare_supers, 1);
> +		}
> +	}
> +	mutex_unlock(&erofs_ishare_lock);

It seems this part is too complex, we could just
kern_mount() once.

and kern_unmount() before unregistering the module.

And since `erofs_anon_fs_type` is an internal fstype, we
could drop ".owner" field to avoid it from unloading the fs
module I think.

> +	return IS_ERR(mnt) ? PTR_ERR(mnt) : 0;
> +}
> +
> +void erofs_ishare_exit(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct vfsmount *tmp;
> +
> +	if (!erofs_sb_has_ishare_key(sbi) || !erofs_ishare_mnt)
> +		return;
> +
> +	mutex_lock(&erofs_ishare_lock);
> +	if (refcount_dec_and_test(&erofs_ishare_supers)) {
> +		tmp = erofs_ishare_mnt;
> +		erofs_ishare_mnt = NULL;
> +		mutex_unlock(&erofs_ishare_lock);
> +		kern_unmount(tmp);
> +		mutex_lock(&erofs_ishare_lock);
> +	}
> +	mutex_unlock(&erofs_ishare_lock);

Same here.

Thanks,
Gao Xiang

