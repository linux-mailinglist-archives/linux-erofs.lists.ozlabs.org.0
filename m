Return-Path: <linux-erofs+bounces-1065-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BBEB93FDC
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:23:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW3gk3dDLz3cYN;
	Tue, 23 Sep 2025 12:23:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758594226;
	cv=none; b=m0lw5k5e/9OWUndS5tyGh63mpwSYm0ptapf3deFmKP+pNPsFRXSZwrd0kKK97hoY4yGN//Hrg/ppDahr40Xpoj6puT8GsAHBSAYpopoJWVtPJGQPD0wGVnxgax7uqEqZMkgRphk79SzSXR3avtWNWQDbEcYnW/tyxQhPytJfnGmmh6Y637RfwNqJOeBA+ZDuiAyYaWCq/FDMV+C8mxPkrW4RVa/GCsX6IP/DgI8FxKH8m8sqyzLxGCTvfsJBcv8TgSXClVdSzvjBzS9qNxVeOTz7n9wqBcuDxB4a/uVeG34oAScYCe5wi7rH4C/yJHCHbPcr5WlLKtU88fkvnHHeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758594226; c=relaxed/relaxed;
	bh=Tqv8OPTvEXJFfZZR6E+sEY6j6abUp+q/jToPp5gotqM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VdHbh3ISDd5FFdQ9NRYCknzr6f4cYnkXcZ21tdGqOCcmFRKm4yd6AbW5hmqNNTfKvOVSCI4bCICGuLWHAGLXAgC5eYJfyWON1us7KDit4JWmI5CdZNE6EjExFE55AqkPA+U5uVAz9q1FCX7e1g/CGvQOKCSfAA1Fk2CG0PyxWaFt9/pla2lO3SfgitCIIbV9lUAiR681It0U2LGrV03Ul/1l+luGkz5jAZED+2JoNHVlac0Ugl9eHidgRjInDMEX3BbjUVDW2TLopBS/+HxEdgj9LoeWEu/e3eiqEhIkDI9306gX3KSO7AqcJV7syj9MbRbUxwt3SErxpcOuK1qPDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AYfyom/V; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AYfyom/V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW3gj58kCz2yqq
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:23:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 08F0F6026B;
	Tue, 23 Sep 2025 02:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A805EC113D0;
	Tue, 23 Sep 2025 02:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758594222;
	bh=AxEZsNUhk/mWV5vb+Fvf89PIeZjyYK9xKs2X6hoAXpA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AYfyom/V9Xs3eeRWmmzdsDC48p2NMprYig4B0Pryuu4r9wn86ccKqS0dGI2Ncbg9m
	 u5E92o87p72tpN9rj5lZGP6q+YOy/xC626sxtwFGIYQ/CMq18FDg5feBG8wA0xixH5
	 uAtdPE3VaQjc36TRXNOSuPaBeStqXTVu91LDORHgq7g57ejJ/GEKjXQREdQON2jizS
	 0Zz7O92NS48xFBvU8J+fzy+8mWAe78oZg+oY9utACLmwEWcgRKWtL50VodMtRY8EQr
	 FUC28H73XK5zUtadpKxz3O4c9lwcPQi9Rhkuu6MMuZOnT2RHPnanIIhb6vblqR/W+0
	 qv2oDyx38510w==
Message-ID: <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
Date: Tue, 23 Sep 2025 10:23:39 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250922092937.2055-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 9/22/25 17:29, Bo Liu wrote:
> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> 
> Add support for reading to the erofs volume label from the
> FS_IOC_GETFSLABEL ioctls.
> 
> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
> ---
> 
> v1: https://lore.kernel.org/linux-erofs/20250825120617.19746-1-liubo03@inspur.com/
> v2: https://lore.kernel.org/linux-erofs/20250826103926.4424-1-liubo03@inspur.com/
> v3: https://lore.kernel.org/linux-erofs/20250920060455.24002-1-liubo03@inspur.com/
> 
> change since v3:
> - move functions into inode.
> - remove useless comment.
> 
>  fs/erofs/data.c     |  4 ++++
>  fs/erofs/dir.c      |  4 ++++
>  fs/erofs/inode.c    | 40 ++++++++++++++++++++++++++++++++++++----
>  fs/erofs/internal.h |  6 ++++++
>  fs/erofs/super.c    |  8 ++++++++
>  5 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 3b1ba571c728..8ca29962a3dd 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -475,6 +475,10 @@ static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
>  const struct file_operations erofs_file_fops = {
>  	.llseek		= erofs_file_llseek,
>  	.read_iter	= erofs_file_read_iter,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>  	.mmap_prepare	= erofs_file_mmap_prepare,
>  	.get_unmapped_area = thp_get_unmapped_area,
>  	.splice_read	= filemap_splice_read,
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index debf469ad6bd..32b4f5aa60c9 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -123,4 +123,8 @@ const struct file_operations erofs_dir_fops = {
>  	.llseek		= generic_file_llseek,
>  	.read		= generic_read_dir,
>  	.iterate_shared	= erofs_readdir,
> +	.unlocked_ioctl = erofs_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl   = erofs_compat_ioctl,
> +#endif
>  };
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 9a2f59721522..7a9a9081f890 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -213,10 +213,7 @@ static int erofs_fill_inode(struct inode *inode)
>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFREG:
>  		inode->i_op = &erofs_generic_iops;
> -		if (erofs_inode_is_data_compressed(vi->datalayout))
> -			inode->i_fop = &generic_ro_fops;
> -		else
> -			inode->i_fop = &erofs_file_fops;
> +		inode->i_fop = &erofs_file_fops;
>  		break;
>  	case S_IFDIR:
>  		inode->i_op = &erofs_dir_iops;
> @@ -341,6 +338,41 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	return 0;
>  }
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
>  const struct inode_operations erofs_generic_iops = {
>  	.getattr = erofs_getattr,
>  	.listxattr = erofs_listxattr,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ccc5f0ee8df..b70902e00586 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -166,6 +166,8 @@ struct erofs_sb_info {
>  	struct erofs_domain *domain;
>  	char *fsid;
>  	char *domain_id;
> +
> +	char *volume_name;
>  };
>  
>  #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -535,6 +537,10 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>  static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>  #endif
>  
> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);

#ifdef CONFIG_COMPAT

> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
> +			unsigned long arg);

#endif

Thanks,

> +
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
>  
>  #endif	/* __EROFS_INTERNAL_H */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 1b529ace4db0..f1535ebe03ec 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -343,6 +343,13 @@ static int erofs_read_superblock(struct super_block *sb)
>  	sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>  	super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>  
> +	if (dsb->volume_name[0]) {
> +		sbi->volume_name = kstrndup(dsb->volume_name,
> +					    sizeof(dsb->volume_name), GFP_KERNEL);
> +		if (!sbi->volume_name)
> +			return -ENOMEM;
> +	}
> +
>  	/* parse on-disk compression configurations */
>  	ret = z_erofs_parse_cfgs(sb, dsb);
>  	if (ret < 0)
> @@ -822,6 +829,7 @@ static void erofs_sb_free(struct erofs_sb_info *sbi)
>  	kfree(sbi->domain_id);
>  	if (sbi->dif0.file)
>  		fput(sbi->dif0.file);
> +	kfree(sbi->volume_name);
>  	kfree(sbi);
>  }
>  


