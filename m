Return-Path: <linux-erofs+bounces-526-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B4AF9D0F
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 03:09:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYsq43qW7z2ydj;
	Sat,  5 Jul 2025 11:09:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751677776;
	cv=none; b=bumiG4/J+bwWyfIKVt9QOUmbC7nixSndedXnQb7XZGfBlBtHFrxqUg9Im75Hj/h2YBB4wkuxiWHKuNs6z8Q+WekNPRfM8TSH3DxB1hGD5p+MAzwifj0f1cm6TNLMu7XWUjp3EulfjtlZ3tkv692YzhkA+fn6MuRSyVmdwEG+KS3TrnX4SLlmYpCHaLeloc7U/BMMae/S3AVKJJDftyASXUmq/Yey+gYJflFGYVFqm6D6MRbMPxNBsWkXYR9W+d0jxe6R737zD5+4v0QbEcc7nMNIDB1pFZ3QYPZbjdN4A8R0njaJXWm2JsV9oGNc5sebbS/N82rE7Cxq1EAdZ0uxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751677776; c=relaxed/relaxed;
	bh=HdjYgT1mYn4cjjrEB+tasRoNWLoBazdWbk9NH0YJbx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbGWJAKRnqOZTPl187G6jQSGgX7aHS80LvGFlJuUeN99Var7e40A4QuZUVEqniIsN2/NQ/axb5HYRdHYCWsdp9HnWWTSErReoyAjjxFEkL+xJQkDkV09kqqHMhz28yyO5rGwcAnfbL0yXztczfjnbyrLilGwqtjXCpzg/JyNeKRojf6eNV3tgeaqvlCJP4HGFIlmGrbKVRC6OTrGdLRfBzP1Uf9EWOYRzj2FR1yiu9/pSBNuliUOcPh+jKu1EpdQs40qx+Z3Pg23bKeRAo0CdqkxyltuBko8SQ3s2LweGP80Rge5okcnDN63dVgaROal4PxzTekBGIymnXAUHTpu8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QyxtG6cr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QyxtG6cr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYsq22X4xz2yN1
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 11:09:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751677769; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HdjYgT1mYn4cjjrEB+tasRoNWLoBazdWbk9NH0YJbx0=;
	b=QyxtG6cr2EtSN+ezZ0gs8jYYslmvAW7AQrE1I9nkfPZwTCrJF9eReIwdiXGIxjIiC6byuIwdlWPJjh3qy+4i6OjY3mg9UcvoVzn3rTwz4aSwenoHcoVFzhXR4yrHn021iT4ecRpBBdaleDIEZz7moIn9LZOOj8MfUtTU1kSdTH4=
Received: from 30.13.128.169(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WhPymUJ_1751677766 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 09:09:27 +0800
Message-ID: <a67f082c-7328-41ea-94ef-2efd18e593ce@linux.alibaba.com>
Date: Sat, 5 Jul 2025 09:09:26 +0800
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
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org


On 2025/7/3 20:23, Christian Brauner wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading identical
> files (e.g., *.so files) from two different minor versions of container
> images will cost multiple copies of the same page cache, since different
> containers have different mount points. Therefore, sharing the page cache
> for files with the same content can save memory.
>
> This introduces the page cache share feature in erofs. During the mkfs
> phase, the file content is hashed and the hash value is stored in the
> `trusted.erofs.fingerprint` extended attribute. Inodes of files with the
> same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
> (indicated by the `ano_inode` field). When a read request occurs, the
> anonymous inode serves as a "container" whose page cache is shared. The
> actual operations involving the iomap are carried out by the original
> inode which is mapped to the anonymous inode.
>
> Below is the memory usage for reading all files in two different minor
> versions of container images:
>
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
>
> Additionally, the table below shows the runtime memory usage of the
> container:
>
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
>
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Link: https://lore.kernel.org/20240902110620.2202586-3-hongzhen@linux.alibaba.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/erofs/Kconfig           |  10 +++
>   fs/erofs/Makefile          |   1 +
>   fs/erofs/internal.h        |   4 +
>   fs/erofs/pagecache_share.c | 204 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/pagecache_share.h |  20 +++++
>   5 files changed, 239 insertions(+)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 6beeb7063871..553770068fee 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -192,3 +192,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_PAGE_CACHE_SHARE
> +       bool "EROFS page cache share support"
> +       depends on EROFS_FS
> +       default n
> +	help
> +	  This permits EROFS to share page cache for files with same
> +	  fingerprints.
> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..f4141fdfcb0b 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 30380f7baf5e..47136894d17d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -273,6 +273,9 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	struct inode *ano_inode;
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -369,6 +372,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations erofs_pcs_file_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
> new file mode 100644
> index 000000000000..309b33cc6c30
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include <linux/refcount.h>
> +#include "pagecache_share.h"
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#define PCS_FPRT_IDX	4
> +#define PCS_FPRT_NAME	"erofs.fingerprint"
> +#define PCS_FPRT_MAXLEN (sizeof(size_t) + 1024)
> +
> +static DEFINE_MUTEX(pseudo_mnt_lock);
> +static refcount_t pseudo_mnt_count;
> +static struct vfsmount *erofs_pcs_mnt;
> +
> +int erofs_pcs_init_mnt(void)
> +{
> +	struct vfsmount *mnt;
> +
> +	if (refcount_inc_not_zero(&pseudo_mnt_count))
> +		return 0;
> +
> +	guard(mutex)(&pseudo_mnt_lock);
> +	if (erofs_pcs_mnt) {
> +		refcount_inc(&pseudo_mnt_count);
> +		return 0;
> +	}
> +
> +	mnt = kern_mount(&erofs_anon_fs_type);
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
> +
> +	rcu_read_lock();
> +	rcu_assign_pointer(erofs_pcs_mnt, mnt);
> +	rcu_read_unlock();
> +	refcount_set_release(&pseudo_mnt_count, 1);
> +	return 0;
> +}
> +
> +void erofs_pcs_free_mnt(void)
> +{
> +	struct vfsmount *mnt = NULL;
> +
> +	if (refcount_dec_not_one(&pseudo_mnt_count))
> +		return;
> +
> +	scoped_guard(mutex, &pseudo_mnt_lock) {
> +		rcu_read_lock();
> +		if (refcount_dec_and_test(&pseudo_mnt_count))
> +			mnt = rcu_replace_pointer(erofs_pcs_mnt, NULL, true);
> +		rcu_read_unlock();
> +	}
> +	if (mnt)
> +		kern_unmount(mnt);
> +}
> +
> +static int erofs_pcs_eq(struct inode *inode, void *data)
> +{
> +	return inode->i_private && memcmp(inode->i_private, data,
> +			sizeof(size_t) + *(size_t *)data) == 0 ? 1 : 0;
> +}
> +
> +static int erofs_pcs_set_fprt(struct inode *inode, void *data)
> +{
> +	/* fprt length and content */
> +	inode->i_private = kmalloc(*(size_t *)data + sizeof(size_t),
> +				   GFP_KERNEL);
> +	memcpy(inode->i_private, data, sizeof(size_t) + *(size_t *)data);
> +	return 0;
> +}
> +
> +void erofs_pcs_fill_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	char fprt[PCS_FPRT_MAXLEN];
> +	struct inode *ano_inode;
> +	unsigned long fprt_hash;
> +	size_t fprt_len;
> +
> +	vi->ano_inode = NULL;
> +	fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME,
> +				  fprt + sizeof(size_t), PCS_FPRT_MAXLEN);
> +	if (fprt_len > 0 && fprt_len <= PCS_FPRT_MAXLEN) {
> +		*(size_t *)fprt = fprt_len;
> +		fprt_hash = xxh32(fprt + sizeof(size_t), fprt_len, 0);
> +		ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, fprt_hash,
> +					 erofs_pcs_eq, erofs_pcs_set_fprt,
> +					 fprt);
> +		vi->ano_inode = ano_inode;
> +		if (ano_inode->i_state & I_NEW) {
> +			if (erofs_inode_is_data_compressed(vi->datalayout))
> +				ano_inode->i_mapping->a_ops = &z_erofs_aops;
> +			else
> +				ano_inode->i_mapping->a_ops = &erofs_aops;
> +			ano_inode->i_size = inode->i_size;
> +			unlock_new_inode(ano_inode);
> +		}
> +	}
> +}
> +
> +/*
> + * TODO: Hm, could we leverage our fancy new backing file infrastructure
> + * as for overlayfs and fuse?
> + */
> +static struct file *erofs_pcs_alloc_file(struct file *file,
> +					 struct inode *ano_inode)
> +{
> +	struct file *ano_file;
> +
> +	ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
> +				     O_RDONLY, &erofs_file_fops);
> +	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
> +	ano_file->private_data = EROFS_I(file_inode(file));
> +	return ano_file;
> +}
> +
> +static int erofs_pcs_file_open(struct inode *inode, struct file *file)
> +{
> +	struct file *ano_file;
> +	struct inode *ano_inode;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +
> +	ano_inode = vi->ano_inode;
> +	if (!ano_inode)
> +		return -EINVAL;
> +
> +	ano_file = erofs_pcs_alloc_file(file, ano_inode);
> +	if (IS_ERR(ano_file))
> +		return PTR_ERR(ano_file);
> +
> +	file->private_data = ano_file;
> +	return 0;
> +}
> +
> +static int erofs_pcs_file_release(struct inode *inode, struct file *file)
> +{
> +	struct file *ano_file __free(fput) = NULL;
> +
> +	if (WARN_ON_ONCE(!file->private_data))
> +		return -EINVAL;
> +
> +	swap(file->private_data, ano_file);
> +	return 0;
> +}
> +
> +static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
> +					struct iov_iter *to)
> +{
> +	struct file *file, *ano_file;
> +	struct kiocb ano_iocb;
> +	ssize_t res;
> +
> +	if (!iov_iter_count(to))
> +		return 0;
> +
> +#ifdef CONFIG_FS_DAX
> +	if (IS_DAX(inode))
> +		return iocb->ki_filp->f_op->read_iter(iocb, to);
> +#endif
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return iocb->ki_filp->f_op->read_iter(iocb, to);
> +
> +	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
> +	file = iocb->ki_filp;
> +	ano_file = file->private_data;
> +	if (WARN_ON_ONCE(!ano_file))
> +		return -EINVAL;
> +	ano_iocb.ki_filp = ano_file;
> +	res = filemap_read(&ano_iocb, to, 0);
> +	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
> +	iocb->ki_filp = file;
> +	file_accessed(file);
> +	return res;
> +}
> +
> +/*
> + * TODO: Amir, you've got some experience in this area due to overlayfs
> + * and fuse. Does that work?
> + */
> +static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *ano_file = file->private_data;
> +
> +	vma_set_file(vma, ano_file);
> +	vma->vm_ops = &generic_file_vm_ops;
> +	return 0;
> +}
> +
> +const struct file_operations erofs_pcs_file_fops = {
> +	.open		= erofs_pcs_file_open,
> +	/*
> +	 * TODO: Why doesn't .llseek require similar treatment as
> +	 * .read_iter?
> +	 */

.llseek only needs to calculate the offset and requires no excessive 
handling for regular files, while .read_iter

involves actual data retrieval (EROFS-specific logic such as 
decompressing compressed data and cross-block reads),

thus necessitating page cache sharing logic.

Thanks,
Hongzhen

> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_pcs_file_read_iter,
> +	.mmap		= erofs_pcs_mmap,
> +	.release	= erofs_pcs_file_release,
> +	.get_unmapped_area = thp_get_unmapped_area,
> +	.splice_read	= filemap_splice_read,
> +};
> diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
> new file mode 100644
> index 000000000000..b8111291cf79
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#ifndef __EROFS_PAGECACHE_SHARE_H
> +#define __EROFS_PAGECACHE_SHARE_H
> +
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/rwlock.h>
> +#include <linux/mutex.h>
> +#include "internal.h"
> +
> +int erofs_pcs_init_mnt(void);
> +void erofs_pcs_free_mnt(void);
> +void erofs_pcs_fill_inode(struct inode *inode);
> +
> +extern const struct vm_operations_struct generic_file_vm_ops;
> +
> +#endif
>

