Return-Path: <linux-erofs+bounces-1553-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA5CCD86EC
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 09:11:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db74t48Tlz2xlP;
	Tue, 23 Dec 2025 19:11:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766477486;
	cv=none; b=bJDzed10KnlL2QD2XHoOUE4dihN6qrHk8FzzDUVnaUn8C1Kueh2VSVtQpFVI115tcVKaKAo5gt94WWkTb2QzZrBTyK8KbD9EwswMh4CBitdraCieVHyn1DVvTzE6byO9p43Zwbf/Re+wFrNqND/ed0qYVKwLgls2xScYTQ+sGCNLo9PNVSZDOENaByjxrEwQeDsLOWZW5fn+8YxugKM4N48WS4jUalEu/o+5KpQKTibfiXXCTob2BF9nXHCqUFNLTmLDw4XLPVAlOD228Japn4nfaFvsy53WVLfU2vECaUR6dYSCbJVpzVZfA1Bdhnz/BBOUj/H35xrDukNKFodsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766477486; c=relaxed/relaxed;
	bh=MFtCT6ljMZlWxq7rA6g0GTsTl9xpHYQaYPejwGEQhVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9aNNSLa3CMnNjPQK5RIZUHM37B1FzWUfldNH1oBUKXzMU6gi53OydDm2cih6gCDUBLUmun/PlMta+WmayBuqJiQuUW9JyJr/cKR1qhmuo2QJ2wI8/Mp96LXE5i/6LOiIhAQmDtGqu9UjKwcAKBpx6ha+0kUcLcGMD4B4uCNkT+MwOYwOmh/c3uq+jE3ZCV1R3X9+L8FL7idIT1omGqmuwmfo+CaoNIETp0pTPkJSEMdB83LpsiRUBdoq4pJka1czcf12NaXbGvHFabiV3xBQl2xR+sU+G3ugqVsPK4Dj3XuH2/IwbP9QC5pqXQEhvVRaIvgKHYgiu3mSrApviVNTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OXYlMzdX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OXYlMzdX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db74q1VjKz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 19:11:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766477473; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MFtCT6ljMZlWxq7rA6g0GTsTl9xpHYQaYPejwGEQhVc=;
	b=OXYlMzdXCAn5O/tjTfF8KaJAsPxG59IZZkdZpIfGgTATaVgo7Z9iZdaaFfuB/hnd8QWYUUJ35k937qDCdU2ZzwT+99ovjlf/ERLjvBzZvexkKtZ0KW3wiF5mmGRGJPRclWbp270LZrDoQ/kK+D++M/GJoiZUmtUbke9oNltvhYM=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX-qdK_1766477469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:11:09 +0800
Message-ID: <97b475d1-d25e-4bea-b0b5-4bc7e65083f4@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:11:09 +0800
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
Subject: Re: [PATCH v10 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 09:56, Hongbo Li wrote:
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
>   fs/erofs/ishare.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  34 ++++++-
>   4 files changed, 272 insertions(+), 3 deletions(-)
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
> index 99e2857173c3..ae9560434324 100644
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

I think it would be better to reform as below:

struct erofs_inode_fingerprint {
	u8 *opaque;
	int size;
};

	struct list_head ishare_list;
	union {
		struct {
			struct erofs_inode_fingerprint fingerprint;
			spinlock_t ishare_lock;
		};
		struct inode *realinode;
	};


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
> +int __init erofs_init_ishare(void);
> +void erofs_exit_ishare(void);
> +bool erofs_ishare_fill_inode(struct inode *inode);
> +void erofs_ishare_free_inode(struct inode *inode);
> +#else
> +static inline int erofs_init_ishare(void) { return 0; }
> +static inline void erofs_exit_ishare(void) {}
> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>   			unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> new file mode 100644
> index 000000000000..4b46016bcd03
> --- /dev/null
> +++ b/fs/erofs/ishare.c
> @@ -0,0 +1,211 @@
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
> +static struct vfsmount *erofs_ishare_mnt;
> +
> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);

	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
	struct erofs_inode_fingerprint *fp2 = data;

	return fp1->size == fp2->size &&
		!memcmp(fp1->opaque, fp2->opaque, fp2->size);

	return vi->fingerprint.opaque && memcmp(vi->

> +
> +	return vi->fingerprint && memcmp(vi->fingerprint, data,
> +			sizeof(size_t) + *(size_t *)data) == 0;
> +}
> +
> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +> +	vi->fingerprint = data;

	vi->fingerprint = *(struct erofs_inode_fingerprint *)data;

> +	INIT_LIST_HEAD(&vi->backing_head);
> +	spin_lock_init(&vi->lock);
> +	return 0;
> +}
> +
> +bool erofs_ishare_fill_inode(struct inode *inode)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> +	struct erofs_xattr_prefix_item *ishare_prefix;

just call
	struct erofs_xattr_prefix_item *prefix;

is fine, since it's unambiguous.

> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct inode *idedup;
> +	/*
> +	 * fingerprint layout:
> +	 * fingerprint length + fingerprint content (xattr_value + domain_id)
> +	 */

That is too hard to follow, just convert to what I mentioned above;

	struct erofs_inode_fingerprint fp;

> +	char *ishare_key, *fingerprint;

	char *infix;

> +	ssize_t ishare_vlen;

	size_t valuelen;

> +	unsigned long hash;
> +	int key_idx;

	int base_index;

> +
> +	if (!sbi->domain_id || !erofs_sb_has_ishare_xattrs(sbi))
> +		return false;
> +
> +	ishare_prefix = sbi->xattr_prefixes + sbi->ishare_xattr_pfx;
> +	ishare_key = ishare_prefix->prefix->infix;
> +	key_idx = ishare_prefix->prefix->base_index;
> +	ishare_vlen = erofs_getxattr(inode, key_idx, ishare_key, NULL, 0);
> +	if (ishare_vlen <= 0 || ishare_vlen > (1 << sbi->blkszbits))
> +		return false;
> +

Then:
	fp.size = valuelen + strlen(sbi->domain_id);
	fp.opaque = kmalloc(fp.size, GFP_KERNEL);

And fix the remaining logic.

Thanks,
Gao Xiang

