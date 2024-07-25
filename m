Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C093BD42
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2024 09:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721893430;
	bh=P1241DU4yjaG5Z5YZW+Sm52d2znFaamHYBq74xxj4ZM=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IeJyMgfZKH/UWdxn3uONXsFixyTob6696CA6SPliB73TWaYvTvl2DwXLctKFKPeN4
	 GsZqdQpnW2pL4dyZHCZ34bmgmhDQXjq6RNW1FW2WSaCcvGwacgJCkudxX5oLWJ2vzR
	 p8/wEmZ+s2FO7aKYY8ipnVh9PKutPU0v9yo/nwCmdDqx9T0DEmM7ywR0U4k6NwRMT/
	 CzDtKPzh7kkpxZTUBEt/l0Kx8FuWa9SriS6faAsloJaRpx7a0EfzpPoGynTM50txT1
	 K4u78swLFtgsPj9qcBJ9NNaAAu0vpYar3qvwYB1pX+HuTxxNnJSi7md/+Zco0CgtQd
	 Y8q3DPhsyy76w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WV2vB5xVxz3d2S
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jul 2024 17:43:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WV2v54mNQz3cf7
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jul 2024 17:43:40 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WV2sv0NtwzncXh;
	Thu, 25 Jul 2024 15:42:43 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FF6014011B;
	Thu, 25 Jul 2024 15:43:33 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 15:43:32 +0800
Message-ID: <a2a46233-40a1-43f2-a6d6-745d45ff13e8@huawei.com>
Date: Thu, 25 Jul 2024 15:43:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] erofs: introduce page cache share feature
Content-Language: en-US
To: <hongzhen@linux.alibaba.com>
References: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
 <20240722065355.1396365-4-hongzhen@linux.alibaba.com>
In-Reply-To: <20240722065355.1396365-4-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/22 14:53, Hongzhen Luo wrote:
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading identical
> files (e.g., *.so files) from two different minor versions of container
> images will cost multiple copies of the same page cache, since different
> containers have different mount points. Therefore, sharing the page cache
> for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. During the mkfs
> phase, file content is hashed and the hash value is stored in the
> `user.fingerprint` extended attribute. Inodes of files with the same
Does this mean the hash is calculated at the file granularity?
> `user.fingerprint` are mapped to an anonymous inode, whose page cache
> stores the actual contents. In this way, a single copy of the anonymous
> inode's page cache can serve read requests from several files mapped to it.
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
> |                   |        No        |     34.9    |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     33.6    |       4%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |    149.1    |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |    1027.9   |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |    934.3    |      10%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |    155.0    |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |    139.1    |      11%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     25.4    |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     18.8    |      26%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      99     |      47%      |
> +-------------------+------------------+-------------+---------------+
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   fs/erofs/Kconfig           |  10 ++
>   fs/erofs/Makefile          |   1 +
>   fs/erofs/internal.h        |   8 +
>   fs/erofs/pagecache_share.c | 313 +++++++++++++++++++++++++++++++++++++
>   fs/erofs/pagecache_share.h |  20 +++
>   5 files changed, 352 insertions(+)
>   create mode 100644 fs/erofs/pagecache_share.c
>   create mode 100644 fs/erofs/pagecache_share.h
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..756a74de623c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -158,3 +158,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
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
> index 097d672e6b14..f14a2ac0e561 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2c695ec6ee71..136d6bed417b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -288,6 +288,12 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	struct list_head pcs_list;
> +	char *fprt;
> +	int fprt_len;
> +	unsigned long fprt_hash;
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -376,6 +382,7 @@ extern const struct super_operations erofs_sops;
>   extern const struct address_space_operations erofs_raw_access_aops;
>   extern const struct address_space_operations z_erofs_aops;
>   extern const struct address_space_operations erofs_fscache_access_aops;
> +extern const struct address_space_operations erofs_pcs_aops;
>   
>   extern const struct inode_operations erofs_generic_iops;
>   extern const struct inode_operations erofs_symlink_iops;
> @@ -384,6 +391,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations erofs_pcs_file_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
> new file mode 100644
> index 000000000000..e8c8fe16cda5
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include "pagecache_share.h"
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#define PCS_FPRT_IDX	1
> +#define PCS_FPRT_NAME	"fingerprint"
> +#define PCS_FPRT_MAXLEN 1024
> +
> +struct erofs_pcs {
> +	struct erofs_inode *cur;
Why we should cur to pointer the inode? I think we only need to record 
the fprt of the content. When we need inode, we can check the 
list_empty, and to get the any inode to use.
> +	struct rw_semaphore rw_sem;
> +	struct mutex list_mutex;
> +	struct list_head list;
> +};
> +
> +static DEFINE_MUTEX(pseudo_mnt_lock);
> +static unsigned long pseudo_mnt_count;
> +static struct vfsmount *erofs_pcs_mnt;
> +
> +int erofs_pcs_init_mnt(void)
> +{
> +	mutex_lock(&pseudo_mnt_lock);
> +	if (!erofs_pcs_mnt) {
> +		erofs_pcs_mnt = kern_mount(&erofs_anon_fs_type);
> +		if (IS_ERR(erofs_pcs_mnt))
Not unlock here.
> +			return PTR_ERR(erofs_pcs_mnt);
> +		pseudo_mnt_count = 1;
> +	} else
> +		pseudo_mnt_count += 1;
> +	mutex_unlock(&pseudo_mnt_lock);
> +	return 0;
> +}
> +
> +int erofs_pcs_free_mnt(void)
> +{
> +	mutex_lock(&pseudo_mnt_lock);
> +	pseudo_mnt_count -= 1;
> +	if (pseudo_mnt_count < 0)
> +		return -EINVAL;
> +	if (pseudo_mnt_count == 0) {
> +		kern_unmount(erofs_pcs_mnt);
> +		erofs_pcs_mnt = NULL;
> +	}
> +	mutex_unlock(&pseudo_mnt_lock);
> +	return 0;
> +}
> +
> +void erofs_pcs_fill_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	char fprt[PCS_FPRT_MAXLEN];
> +
> +	vi->fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME, fprt,
> +				      PCS_FPRT_MAXLEN);
> +	if (vi->fprt_len > 0 && vi->fprt_len <= PCS_FPRT_MAXLEN) {
> +		vi->fprt = kmalloc(vi->fprt_len, GFP_KERNEL);
> +		if (IS_ERR(vi->fprt)) {
> +			vi->fprt_len = -1;
> +			return;
> +		}
> +		memcpy(vi->fprt, fprt, vi->fprt_len);
> +		vi->fprt_hash = xxh32(vi->fprt, vi->fprt_len, 0);
> +	}
> +}
> +
> +static int erofs_pcs_eq(struct inode *ano_inode, void *data)
> +{
> +	struct erofs_pcs *pcs = ano_inode->i_private;
> +	struct erofs_inode *vi = (struct erofs_inode *)data;
> +
> +	return pcs && pcs->cur && pcs->cur->fprt_len == vi->fprt_len &&
> +	       memcmp(pcs->cur->fprt, vi->fprt, vi->fprt_len) == 0 ? 1 : 0;
May be we just need compare vi->fprt_hash, no need memcmp?
> +}
> +
> +static int erofs_pcs_set_aops(struct inode *ano_inode, void *data)
> +{
> +	ano_inode->i_mapping->a_ops = &erofs_pcs_aops;
> +	ano_inode->i_size = ((struct erofs_inode *)data)->vfs_inode.i_size;
> +	return 0;
> +}
> +
> +int erofs_pcs_add(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct inode *ano_inode;
> +	struct erofs_pcs *pcs;
> +
> +	ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, vi->fprt_hash,
> +				 erofs_pcs_eq, erofs_pcs_set_aops, vi);
> +	spin_lock(&ano_inode->i_lock);
> +	if (!ano_inode->i_private) {
> +		pcs = kzalloc(sizeof(struct erofs_pcs), GFP_KERNEL);
> +		if (IS_ERR(pcs))
should call spin_unlock when failed
> +			return -ENOMEM;
> +		INIT_LIST_HEAD(&pcs->list);
> +		mutex_init(&pcs->list_mutex);
> +		init_rwsem(&pcs->rw_sem);
> +		ano_inode->i_private = pcs;
> +	}
> +	spin_unlock(&ano_inode->i_lock);
> +	pcs = ano_inode->i_private;
pcs = ano_inode->i_private;
spin_lock(&ano_inode->i_lock);
if (!pcs) {
xxx
}
spin_unlock(&ano_inode->i_lock);
> +	mutex_lock(&pcs->list_mutex);
> +	list_add_tail(&vi->pcs_list, &pcs->list);
> +	if (!pcs->cur) {
> +		pcs->cur = list_first_entry(&pcs->list,
> +					    struct erofs_inode, pcs_list);
> +	}
> +	mutex_unlock(&pcs->list_mutex);
> +	if (ano_inode->i_state & I_NEW)
> +		unlock_new_inode(ano_inode);
> +	return 0;
> +}
> +
> +int erofs_pcs_remove(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode), *p, *tmp;
> +	struct inode *ano_inode;
> +	struct erofs_pcs *pcs;
> +
> +	ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, vi->fprt_hash,
> +				 erofs_pcs_eq, erofs_pcs_set_aops, vi);
> +	iput(ano_inode);
> +	pcs = ano_inode->i_private;
> +	if (!pcs)
> +		return -EINVAL;
> +	mutex_lock(&pcs->list_mutex);
> +	if (vi == pcs->cur) {
> +		/* synchronize with reads using pcs->cur */
> +		down_write(&pcs->rw_sem);
> +		list_del(&pcs->cur->pcs_list);
> +		if (list_empty(&pcs->list)) {
> +			pcs->cur = NULL;
> +			up_write(&pcs->rw_sem);
> +			goto free_ano_inode;
> +		}
> +		pcs->cur = list_first_entry(&pcs->list, struct erofs_inode,
> +					    pcs_list);
> +		up_write(&pcs->rw_sem);
> +	} else {
> +		list_for_each_entry_safe(p, tmp, &pcs->list, pcs_list) {
> +			if (p == vi) {
> +				list_del(&p->pcs_list);
> +				break;
> +			}
> +		}
> +	}
> +	iput(ano_inode);
> +	mutex_unlock(&pcs->list_mutex);
> +	return 0;
> +
> +free_ano_inode:
> +	mutex_unlock(&pcs->list_mutex);
> +	spin_lock(&ano_inode->i_lock);
> +	if (atomic_read(&ano_inode->i_count) == 1) {
> +		ano_inode->i_private = NULL;
> +		kfree(pcs);
> +	}
> +	spin_unlock(&ano_inode->i_lock);
> +	iput(ano_inode);
> +	return 0;
> +}
> +
> +static int erofs_pcs_iomap_begin(struct inode *ano_inode, loff_t offset,
> +				loff_t length, unsigned int flags,
> +				struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct erofs_pcs *pcs;
> +
> +	pcs = ano_inode->i_private;
> +	if (!pcs || !pcs->cur)
> +		return -EINVAL;
> +
> +	return erofs_iomap_begin(&pcs->cur->vfs_inode, offset, length, flags,
> +				 iomap, srcmap);
> +}
> +
> +static int erofs_pcs_iomap_end(struct inode *ano_inode, loff_t pos,
> +			       loff_t length, ssize_t written,
> +			       unsigned int flags, struct iomap *iomap)
> +{
> +	struct erofs_pcs *pcs;
> +
> +	pcs = ano_inode->i_private;
> +	if (!pcs)
> +		return -EINVAL;
> +
> +	return erofs_iomap_end(&pcs->cur->vfs_inode, pos, length, written,
> +			       flags, iomap);
> +}
> +
> +const struct iomap_ops erofs_pcs_iomap_ops = {
> +	.iomap_begin = erofs_pcs_iomap_begin,
> +	.iomap_end = erofs_pcs_iomap_end,
Does this work on on-demand mode over fscache? As I know, this io path 
is only for erofs, not for erofs over fscache.
> +};
> +
> +static int erofs_pcs_read_folio(struct file *file, struct folio *folio)
> +{
> +	int err;
> +	struct erofs_pcs *pcs;
> +
> +	pcs = file->f_inode->i_private;
> +	if (!pcs)
> +		return -EINVAL;
> +	down_read(&pcs->rw_sem);
> +	err = iomap_read_folio(folio, &erofs_pcs_iomap_ops);
> +	up_read(&pcs->rw_sem);
> +	return err;
> +}
> +
> +static void erofs_pcs_readahead(struct readahead_control *rac)
> +{
> +	struct erofs_pcs *pcs;
> +
> +	pcs = rac->file->f_inode->i_private;
> +	if (!pcs)
> +		return;
> +	down_read(&pcs->rw_sem);
> +	iomap_readahead(rac, &erofs_pcs_iomap_ops);
> +	up_read(&pcs->rw_sem);
> +}
> +
> +const struct address_space_operations erofs_pcs_aops = {
> +	.read_folio = erofs_pcs_read_folio,
> +	.readahead = erofs_pcs_readahead,
> +};
> +
> +static struct file *erofs_pcs_alloc_file(struct file *file,
> +					 struct inode *ano_inode)
> +{
> +	struct file *ano_file;
> +
> +	ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
> +				     O_RDONLY, &erofs_file_fops);
> +	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
> +	return ano_file;
> +}
> +
> +static int erofs_pcs_file_open(struct inode *inode, struct file *file)
> +{
> +	struct file *ano_file;
> +	struct inode *ano_inode;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +
> +	ano_inode = iget5_locked(erofs_pcs_mnt->mnt_sb, vi->fprt_hash,
> +				 erofs_pcs_eq, erofs_pcs_set_aops, vi);
> +	if (!ano_inode)
> +		return -EINVAL;
> +	ano_file = erofs_pcs_alloc_file(file, ano_inode);
> +	file->private_data = (void *)ano_file;
> +	return 0;
> +}
> +
> +static int erofs_pcs_file_release(struct inode *inode, struct file *file)
> +{
> +	if (!file->private_data)
> +		return -EINVAL;
> +	fput((struct file *)file->private_data);
> +	file->private_data = NULL;
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
> +	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
> +	file = iocb->ki_filp;
> +	ano_file = file->private_data;
> +	if (!ano_file)
> +		return -EINVAL;
> +	ano_iocb.ki_filp = ano_file;
> +	res = filemap_read(&ano_iocb, to, 0);
> +	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
> +	iocb->ki_filp = file;
> +	file_accessed(file);
> +	return res;
> +}
> +
> +static vm_fault_t erofs_pcs_fault(struct vm_fault *vmf)
> +{
> +	return filemap_fault(vmf);
> +}
> +
> +static const struct vm_operations_struct erofs_pcs_file_vm_ops = {
> +	.fault = erofs_pcs_fault,
> +};
> +
> +static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *ano_file = file->private_data;
> +
> +	vma_set_file(vma, ano_file);
> +	vma->vm_ops = &erofs_pcs_file_vm_ops;
> +	return 0;
> +}
> +
> +const struct file_operations erofs_pcs_file_fops = {
> +	.open		= erofs_pcs_file_open,
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_pcs_file_read_iter,
> +	.mmap		= erofs_pcs_mmap,
> +	.release	= erofs_pcs_file_release,
> +	.get_unmapped_area = thp_get_unmapped_area,
> +	.splice_read	= filemap_splice_read,
> +};
> diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
> new file mode 100644
> index 000000000000..a7affb0382bd
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
> +int erofs_pcs_free_mnt(void);
> +void erofs_pcs_fill_inode(struct inode *inode);
> +int erofs_pcs_add(struct inode *inode);
> +int erofs_pcs_remove(struct inode *inode);
> +
> +#endif

Thanks,
Hongbo
