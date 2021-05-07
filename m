Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768A3760F8
	for <lists+linux-erofs@lfdr.de>; Fri,  7 May 2021 09:10:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fc1mg3V1mz2yXm
	for <lists+linux-erofs@lfdr.de>; Fri,  7 May 2021 17:10:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ilbPkBp9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ilbPkBp9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fc1mb0C93z2yXW
 for <linux-erofs@lists.ozlabs.org>; Fri,  7 May 2021 17:10:06 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16D07613D6;
 Fri,  7 May 2021 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620371403;
 bh=MtuWbyY+EYLzh3mUMbBdCAW1CaDTckQDuk/xLvHAQ1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ilbPkBp9pwJTNh+lmb0I4D42YUlORSTB5k5NCqGk9jhi7NfCUJhBRGCq0JE+KKLvl
 aJ4+cK0nWI7ZMWdHp3kWvhG3K7tUx2BRQSNj2aZIyMmKHdMhH0AFvY+r6v+LPc7jlQ
 F114EgHeSy2CwpDdS83ntAiMpq+12WGqZlvlF2HAJj6ULFXvslv528/D32N111B0AM
 KXU6xGD4ANGBIQaPxjO/MSXMBeMdacWVMvzkqwFRVckCutNFNYJBC/7sd4TkX6Wc2u
 bxslLi4A499+dJkX5iQl7lHkxj+FNbgbuyKDHTZmJKnQEDwEwNQgq5JGbiG1frPgu2
 6xU0ZilEE3g9A==
Date: Fri, 7 May 2021 15:09:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v1 2/2] erofs-utils: introduce erofs_subdirs to one dir
 for sort
Message-ID: <20210507070958.GA8929@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210505142615.38306-1-bluce.lee@aliyun.com>
 <20210505142615.38306-2-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505142615.38306-2-bluce.lee@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Wed, May 05, 2021 at 10:26:15PM +0800, Li Guifu via Linux-erofs wrote:
> The structure erofs_subdirs has a dir number and a list_head,
> the list_head is the same with i_subdirs in the inode.
> Using erofs_subdirs as a temp place for dentrys under the dir,
> and then sort it before replace to i_subdirs
> 
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
> ---
>  include/erofs/internal.h |  5 +++
>  lib/inode.c              | 95 +++++++++++++++++++++++++---------------
>  2 files changed, 64 insertions(+), 36 deletions(-)
> 
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 1339341..7cd42ca 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -172,6 +172,11 @@ struct erofs_inode {
>  #endif
>  };
>  
> +struct erofs_subdirs {
> +	struct list_head i_subdirs;
> +	unsigned int nr_subdirs;
> +};
> +
>  static inline bool is_inode_layout_compression(struct erofs_inode *inode)
>  {
>  	return erofs_inode_is_data_compressed(inode->datalayout);
> diff --git a/lib/inode.c b/lib/inode.c
> index 787e5b4..3e138a6 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -96,7 +96,7 @@ unsigned int erofs_iput(struct erofs_inode *inode)
>  	return 0;
>  }
>  
> -struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> +struct erofs_dentry *erofs_d_alloc(struct erofs_subdirs *subdirs,
>  				   const char *name)
>  {
>  	struct erofs_dentry *d = malloc(sizeof(*d));
> @@ -107,7 +107,8 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>  	strncpy(d->name, name, EROFS_NAME_LEN - 1);
>  	d->name[EROFS_NAME_LEN - 1] = '\0';
>  
> -	list_add_tail(&d->d_child, &parent->i_subdirs);
> +	list_add_tail(&d->d_child, &subdirs->i_subdirs);
> +	subdirs->nr_subdirs++;
>  	return d;
>  }
>  
> @@ -150,38 +151,12 @@ static int comp_subdir(const void *a, const void *b)
>  	return strcmp(da->name, db->name);
>  }
>  
> -int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
> +int erofs_prepare_dir_file(struct erofs_inode *dir)

Err... nope, that is not what I suggested, I was suggesting

int erofs_prepare_dir_file(struct erofs_inode *dir,
			   struct erofs_subdirs *subdirs)

>  {
> -	struct erofs_dentry *d, *n, **sorted_d;
> -	unsigned int d_size, i_nlink, i;
> +	struct erofs_dentry *d;
> +	unsigned int d_size, i_nlink;
>  	int ret;
>  
> -	/* dot is pointed to the current dir inode */
> -	d = erofs_d_alloc(dir, ".");
> -	d->inode = erofs_igrab(dir);
> -	d->type = EROFS_FT_DIR;
> -
> -	/* dotdot is pointed to the parent dir */
> -	d = erofs_d_alloc(dir, "..");
> -	d->inode = erofs_igrab(dir->i_parent);
> -	d->type = EROFS_FT_DIR;

Leave these two here, since it's a part of dir preparation.

> -
> -	/* sort subdirs */
> -	nr_subdirs += 2;
> -	sorted_d = malloc(nr_subdirs * sizeof(d));
> -	if (!sorted_d)
> -		return -ENOMEM;
> -	i = 0;
> -	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
> -		list_del(&d->d_child);
> -		sorted_d[i++] = d;
> -	}
> -	DBG_BUGON(i != nr_subdirs);
> -	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
> -	for (i = 0; i < nr_subdirs; i++)
> -		list_add_tail(&sorted_d[i]->d_child, &dir->i_subdirs);
> -	free(sorted_d);
> -
>  	/* let's calculate dir size and update i_nlink */
>  	d_size = 0;
>  	i_nlink = 0;
> @@ -926,13 +901,58 @@ void erofs_d_invalidate(struct erofs_dentry *d)
>  	erofs_iput(inode);
>  }
>  
> +void erofs_subdirs_init(struct erofs_inode *dir, struct erofs_subdirs *subdirs)
> +{
> +	struct erofs_dentry *d;
> +
> +	subdirs->nr_subdirs = 0;
> +	init_list_head(&subdirs->i_subdirs);
> +
> +	/* dot is pointed to the current dir inode */
> +	d = erofs_d_alloc(subdirs, ".");
> +	d->inode = erofs_igrab(dir);
> +	d->type = EROFS_FT_DIR;
> +
> +	/* dotdot is pointed to the parent dir */
> +	d = erofs_d_alloc(subdirs, "..");
> +	d->inode = erofs_igrab(dir->i_parent);
> +	d->type = EROFS_FT_DIR;
> +}

No need of this, just
struct erofs_subdirs subdirs = {0}; in erofs_mkfs_build_tree().

> +
> +static int erofs_subdirs_sorted(struct erofs_subdirs *subdirs)
> +{
> +	struct erofs_dentry *d, *n, **sorted_d;
> +	unsigned int i;
> +	const unsigned int nr_subdirs = subdirs->nr_subdirs;
> +
> +	if (nr_subdirs == 0) return 0;
> +
> +	sorted_d = malloc(nr_subdirs * sizeof(d));
> +	if (!sorted_d)
> +		return -ENOMEM;
> +	i = 0;
> +	list_for_each_entry_safe(d, n, &subdirs->i_subdirs, d_child) {
> +		list_del(&d->d_child);
> +		sorted_d[i++] = d;
> +	}
> +
> +	DBG_BUGON(i != nr_subdirs);
> +	DBG_BUGON(!list_empty(&subdirs->i_subdirs));
> +
> +	qsort(sorted_d, nr_subdirs, sizeof(d), comp_subdir);
> +	for (i = 0; i < nr_subdirs; i++)
> +		list_add_tail(&sorted_d[i]->d_child, &subdirs->i_subdirs);
> +	free(sorted_d);
> +	return 0;
> +}

Nope, no need this function, please fold it in erofs_prepare_dir_file().
Again, please sort the subdirs in erofs_prepare_dir_file().

> +
>  struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  {
>  	int ret;
>  	DIR *_dir;
>  	struct dirent *dp;
>  	struct erofs_dentry *d;
> -	unsigned int nr_subdirs;
> +	struct erofs_subdirs subdirs;
>  
>  	ret = erofs_prepare_xattr_ibody(dir);
>  	if (ret < 0)
> @@ -972,7 +992,7 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  		return ERR_PTR(-errno);
>  	}
>  
> -	nr_subdirs = 0;
> +	erofs_subdirs_init(dir, &subdirs);
>  	while (1) {
>  		/*
>  		 * set errno to 0 before calling readdir() in order to
> @@ -991,12 +1011,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
>  			continue;
>  
> -		d = erofs_d_alloc(dir, dp->d_name);
> +		d = erofs_d_alloc(&subdirs, dp->d_name);
>  		if (IS_ERR(d)) {
>  			ret = PTR_ERR(d);
>  			goto err_closedir;
>  		}
> -		nr_subdirs++;
>  
>  		/* to count i_nlink for directories */
>  		d->type = (dp->d_type == DT_DIR ?
> @@ -1009,7 +1028,11 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
>  	}
>  	closedir(_dir);
>  
> -	ret = erofs_prepare_dir_file(dir, nr_subdirs);
> +	ret = erofs_subdirs_sorted(&subdirs);
> +	if (ret) goto err;
> +
> +	list_replace(&subdirs.i_subdirs, &dir->i_subdirs);

No need list_replace here.

Thanks,
Gao Xiang

> +	ret = erofs_prepare_dir_file(dir);
>  	if (ret)
>  		goto err;
>  
> -- 
> 2.17.1
> 
