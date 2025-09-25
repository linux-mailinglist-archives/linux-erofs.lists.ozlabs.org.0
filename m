Return-Path: <linux-erofs+bounces-1093-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EDB9CF8A
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 03:02:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXFmx4Gg7z30Pg;
	Thu, 25 Sep 2025 11:02:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758762145;
	cv=none; b=W96FUeUqgsNVFWxmQ675TxbqrxmBBb7N4vV71ljbPcLy4RkZnAjbm/cCKXYGmpgSSH/0118iBcvxuaAPlghyWucRs88oGhzrfnzFqB/iE1UJCUga997ws+94hqXWlvM693lWtKoTpewmICmC2PKCZXj8iDQJh2s5x7BuI2M9nhZRT0qjxt5XrjmR1NC7GYPMle3QLQoCA0kTp8ocEzntGova9iNvEGQkESr0xGEW9jKC2MhfdCPmWUlQfhUgPGjxe5yMV3vGu+c/leEKf2JcT5XLHkAgpOfWHQiEn1vge9rswRfJG1VNnxPtjCtc7mn7XH9wPlLfZDwgUCxlILxoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758762145; c=relaxed/relaxed;
	bh=fp6dLPUCH9kMNbA/5Q4FjtRgq7lUrSNlzMZJyhZ1aQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j1CoI8FRSwdM+aeSmij7xX3mfVXtZjn5Tyje5EQrxQ6D6PRwFoHgGa2UdqLcnphaNzpDsWJ60z73BwQbEuPr+p4wil+NwXPBPckbxkZLhv1ioLCrVXqVmmRnSyPP/JWAfXnxbhaPAycMvX1YxLB8AP9c6ZjIAPpa3C2tHoGxcqFyeALwmz+GB4mL8gTeHvBmaRf9tZ9VDgsnPUpg9Scwg5SeibKsvVHEynrqo/50KPmptJF4D16UllSMZqNpbrUX4/LtpIITwmKBCddlX1IvaRbdDvHFqtQIrSVsmlme/W6rbMYqPm1MH+zfrs2SNJmBN/L+t3AzwBJrx5IdIE4h9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXFmw220Tz30Ng
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 11:02:22 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cXFgn6Vnzz13NFd
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 08:57:57 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A74BA1800B1
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 09:02:17 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:02:17 +0800
Message-ID: <b17e1d63-3d9e-4336-9b4e-a9bd2abff72a@huawei.com>
Date: Thu, 25 Sep 2025 09:02:17 +0800
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
Subject: Re: [PATCH v5] erofs: Add support for FS_IOC_GETFSLABEL
To: <linux-erofs@lists.ozlabs.org>
References: <20250923070112.16644-1-liubo03@inspur.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250923070112.16644-1-liubo03@inspur.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/23 15:01, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
> 
> v1: https://lore.kernel.org/linux-erofs/20250825120617.19746-1-liubo03@inspur.com/
> v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/
> v3: https://lore.kernel.org/linux-erofs/20250920060455.24002-1-liubo03@inspur.com/
> v4: https://lore.kernel.org/linux-erofs/20250922092937.2055-1-liubo03@inspur.com/
> 
> change since v4:
> - fix 0day build errors.
> 
>   fs/erofs/data.c     |  4 ++++
>   fs/erofs/dir.c      |  4 ++++
>   fs/erofs/inode.c    | 41 +++++++++++++++++++++++++++++++++++++----
>   fs/erofs/internal.h |  6 ++++++
>   fs/erofs/super.c    |  8 ++++++++
>   5 files changed, 59 insertions(+), 4 deletions(-)
> 
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
> index 9a2f59721522..a3c505e9425d 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "xattr.h"
> +#include <linux/compat.h>
>   #include <trace/events/erofs.h>
>   
>   static int erofs_fill_symlink(struct inode *inode, void *kaddr,
> @@ -213,10 +214,7 @@ static int erofs_fill_inode(struct inode *inode)
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
> @@ -341,6 +339,41 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>   	return 0;
>   }
>   
> +static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
> +{
> +	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
> +	int ret;
> +
> +	if (!sbi->volume_name)
> +		ret = clear_user(arg, 1);
> +	else
> +		ret = copy_to_user(arg, sbi->volume_name,
> +				   strlen(sbi->volume_name));
> +
> +	return ret ? -EFAULT : 0;
> +}
> +
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	void __user *argp = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case FS_IOC_GETFSLABEL:
> +		return erofs_ioctl_get_volume_label(inode, argp);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +#ifdef CONFIG_COMPAT
> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg)
> +{
> +	return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#endif
> +
>   const struct inode_operations erofs_generic_iops = {
>   	.getattr = erofs_getattr,
>   	.listxattr = erofs_listxattr,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ccc5f0ee8df..b70902e00586 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -166,6 +166,8 @@ struct erofs_sb_info {
>   	struct erofs_domain *domain;
>   	char *fsid;
>   	char *domain_id;
> +
> +	char *volume_name;
>   };
>   
>   #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -535,6 +537,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
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
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1b529ace4db0..f1535ebe03ec 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -343,6 +343,13 @@ static int erofs_read_superblock(struct super_block *sb)
>   	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>   	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>   
> +	if (dsb->volume_name[0]) {
> +		sbi->volume_name = kstrndup(dsb->volume_name,
> +					    sizeof(dsb->volume_name), GFP_KERNEL);
> +		if (!sbi->volume_name)
> +			return -ENOMEM;
> +	}
> +
>   	/* parse on-disk compression configurations */
>   	ret = z_erofs_parse_cfgs(sb, dsb);
>   	if (ret < 0)
> @@ -822,6 +829,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
>   	kfree(sbi->domain_id);
>   	if (sbi->dif0.file)
>   		fput(sbi->dif0.file);
> +	kfree(sbi->volume_name);
>   	kfree(sbi);
>   }
>   

