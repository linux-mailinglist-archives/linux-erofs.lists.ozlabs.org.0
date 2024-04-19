Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE238AAC9A
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 12:13:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L0u2/NcA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLVpx0SHzz3cPl
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 20:13:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L0u2/NcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLVpp09DNz3bvX
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Apr 2024 20:13:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 78BEACE1A4F;
	Fri, 19 Apr 2024 10:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F709C072AA;
	Fri, 19 Apr 2024 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521614;
	bh=wj4r4PZTD9VeC2bOYlp5oAQl2RQdx30YKGcIWnuAFbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0u2/NcAQtxSXmP+xCJ+SPrkvptctqAEkSg7TDv2d+UtuejBS6Ug0Qs5nh13p2pye
	 3UuHmZuKD3sKlIErNMdro6izcpwSBBYRurddoC+bOsPcFd3BHbYMbbo6f9M+UQbEsN
	 hND1kyTRe5ySGgkFmPcIUeetihWlvPCJ6sWocK/OTWEsDLzwQbfhXYxgAORqXNCCj8
	 fGXURx5JV9+ceR+RrddGK9VWmybhHSfH7P6gXD3mO4Zk5qwHb+XG4KeBNWstxh+jOl
	 9FPlONX9ySnWzlvA6c9e4JAC+sZqMvxQVK+7uhEXm6+ZzcGqxPF++9WwB6FZRjUuZT
	 82lwS/MY4GLJA==
Date: Fri, 19 Apr 2024 12:13:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH -next] erofs: get rid of erofs_fs_context
Message-ID: <20240419-tundra-komodowaran-5c3758d496e4@brauner>
References: <20240419031459.3050864-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240419031459.3050864-1-libaokun1@huawei.com>
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
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 19, 2024 at 11:14:59AM +0800, Baokun Li wrote:
> Instead of allocating the erofs_sb_info in get_tree() allocate it during
> init_fs_context() and after this erofs_fs_context is no longer needed,
> so replace ctx with sbi, no functional changes.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> Hi Gao Xiang,
> Hi Jingbo,
> 
> I noticed that Christian's original patch has been merged into the next
> branch, so I'm sending this patch out separately.

An an accident on my part as I left it in the vfs.fixes branch. I expect
that the erofs tree will pick it up.

> 
> Regards,
> Baokun
> 
>  fs/erofs/internal.h |   7 ---
>  fs/erofs/super.c    | 112 ++++++++++++++++++--------------------------
>  2 files changed, 46 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 116c1d5d1932..53ebba952a2f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -84,13 +84,6 @@ struct erofs_dev_context {
>  	bool flatdev;
>  };
>  
> -struct erofs_fs_context {
> -	struct erofs_mount_opts opt;
> -	struct erofs_dev_context *devs;
> -	char *fsid;
> -	char *domain_id;
> -};
> -
>  /* all filesystem-wide lz4 configurations */
>  struct erofs_sb_lz4_info {
>  	/* # of pages needed for EROFS lz4 rolling decompression */
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4fc34b984e51..7172271290b9 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -370,18 +370,18 @@ static int erofs_read_superblock(struct super_block *sb)
>  	return ret;
>  }
>  
> -static void erofs_default_options(struct erofs_fs_context *ctx)
> +static void erofs_default_options(struct erofs_sb_info *sbi)
>  {
>  #ifdef CONFIG_EROFS_FS_ZIP
> -	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
> -	ctx->opt.max_sync_decompress_pages = 3;
> -	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
> +	sbi->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
> +	sbi->opt.max_sync_decompress_pages = 3;
> +	sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
>  #endif
>  #ifdef CONFIG_EROFS_FS_XATTR
> -	set_opt(&ctx->opt, XATTR_USER);
> +	set_opt(&sbi->opt, XATTR_USER);
>  #endif
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
> -	set_opt(&ctx->opt, POSIX_ACL);
> +	set_opt(&sbi->opt, POSIX_ACL);
>  #endif
>  }
>  
> @@ -426,16 +426,16 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>  {
>  #ifdef CONFIG_FS_DAX
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>  
>  	switch (mode) {
>  	case EROFS_MOUNT_DAX_ALWAYS:
> -		set_opt(&ctx->opt, DAX_ALWAYS);
> -		clear_opt(&ctx->opt, DAX_NEVER);
> +		set_opt(&sbi->opt, DAX_ALWAYS);
> +		clear_opt(&sbi->opt, DAX_NEVER);
>  		return true;
>  	case EROFS_MOUNT_DAX_NEVER:
> -		set_opt(&ctx->opt, DAX_NEVER);
> -		clear_opt(&ctx->opt, DAX_ALWAYS);
> +		set_opt(&sbi->opt, DAX_NEVER);
> +		clear_opt(&sbi->opt, DAX_ALWAYS);
>  		return true;
>  	default:
>  		DBG_BUGON(1);
> @@ -450,7 +450,7 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>  static int erofs_fc_parse_param(struct fs_context *fc,
>  				struct fs_parameter *param)
>  {
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>  	struct fs_parse_result result;
>  	struct erofs_device_info *dif;
>  	int opt, ret;
> @@ -463,9 +463,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  	case Opt_user_xattr:
>  #ifdef CONFIG_EROFS_FS_XATTR
>  		if (result.boolean)
> -			set_opt(&ctx->opt, XATTR_USER);
> +			set_opt(&sbi->opt, XATTR_USER);
>  		else
> -			clear_opt(&ctx->opt, XATTR_USER);
> +			clear_opt(&sbi->opt, XATTR_USER);
>  #else
>  		errorfc(fc, "{,no}user_xattr options not supported");
>  #endif
> @@ -473,16 +473,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  	case Opt_acl:
>  #ifdef CONFIG_EROFS_FS_POSIX_ACL
>  		if (result.boolean)
> -			set_opt(&ctx->opt, POSIX_ACL);
> +			set_opt(&sbi->opt, POSIX_ACL);
>  		else
> -			clear_opt(&ctx->opt, POSIX_ACL);
> +			clear_opt(&sbi->opt, POSIX_ACL);
>  #else
>  		errorfc(fc, "{,no}acl options not supported");
>  #endif
>  		break;
>  	case Opt_cache_strategy:
>  #ifdef CONFIG_EROFS_FS_ZIP
> -		ctx->opt.cache_strategy = result.uint_32;
> +		sbi->opt.cache_strategy = result.uint_32;
>  #else
>  		errorfc(fc, "compression not supported, cache_strategy ignored");
>  #endif
> @@ -504,27 +504,27 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  			kfree(dif);
>  			return -ENOMEM;
>  		}
> -		down_write(&ctx->devs->rwsem);
> -		ret = idr_alloc(&ctx->devs->tree, dif, 0, 0, GFP_KERNEL);
> -		up_write(&ctx->devs->rwsem);
> +		down_write(&sbi->devs->rwsem);
> +		ret = idr_alloc(&sbi->devs->tree, dif, 0, 0, GFP_KERNEL);
> +		up_write(&sbi->devs->rwsem);
>  		if (ret < 0) {
>  			kfree(dif->path);
>  			kfree(dif);
>  			return ret;
>  		}
> -		++ctx->devs->extra_devices;
> +		++sbi->devs->extra_devices;
>  		break;
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  	case Opt_fsid:
> -		kfree(ctx->fsid);
> -		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
> -		if (!ctx->fsid)
> +		kfree(sbi->fsid);
> +		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
> +		if (!sbi->fsid)
>  			return -ENOMEM;
>  		break;
>  	case Opt_domain_id:
> -		kfree(ctx->domain_id);
> -		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
> -		if (!ctx->domain_id)
> +		kfree(sbi->domain_id);
> +		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
> +		if (!sbi->domain_id)
>  			return -ENOMEM;
>  		break;
>  #else
> @@ -582,7 +582,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_fs_context *ctx = fc->fs_private;
>  	int err;
>  
>  	sb->s_magic = EROFS_SUPER_MAGIC;
> @@ -590,14 +589,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &erofs_sops;
>  
> -	sb->s_fs_info = sbi;
> -	sbi->opt = ctx->opt;
> -	sbi->devs = ctx->devs;
> -	ctx->devs = NULL;
> -	ctx->fsid = NULL;
> -	sbi->domain_id = ctx->domain_id;
> -	ctx->domain_id = NULL;
> -
>  	sbi->blkszbits = PAGE_SHIFT;
>  	if (erofs_is_fscache_mode(sb)) {
>  		sb->s_blocksize = PAGE_SIZE;
> @@ -701,15 +692,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = fc->fs_private;
> -	struct erofs_sb_info *sbi;
> -
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>  
> -	fc->s_fs_info = sbi;
> -	sbi->fsid = ctx->fsid;
>  	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
> @@ -720,19 +704,19 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
>  {
>  	struct super_block *sb = fc->root->d_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	struct erofs_fs_context *ctx = fc->fs_private;
> +	struct erofs_sb_info *new_sbi = fc->s_fs_info;
>  
>  	DBG_BUGON(!sb_rdonly(sb));
>  
> -	if (ctx->fsid || ctx->domain_id)
> +	if (new_sbi->fsid || new_sbi->domain_id)
>  		erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
>  
> -	if (test_opt(&ctx->opt, POSIX_ACL))
> +	if (test_opt(&new_sbi->opt, POSIX_ACL))
>  		fc->sb_flags |= SB_POSIXACL;
>  	else
>  		fc->sb_flags &= ~SB_POSIXACL;
>  
> -	sbi->opt = ctx->opt;
> +	sbi->opt = new_sbi->opt;
>  
>  	fc->sb_flags |= SB_RDONLY;
>  	return 0;
> @@ -763,16 +747,12 @@ static void erofs_free_dev_context(struct erofs_dev_context *devs)
>  
>  static void erofs_fc_free(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = fc->fs_private;
>  	struct erofs_sb_info *sbi = fc->s_fs_info;
>  
> -	erofs_free_dev_context(ctx->devs);
> -	kfree(ctx->fsid);
> -	kfree(ctx->domain_id);
> -	kfree(ctx);
> -
> -	if (sbi)
> -		kfree(sbi);
> +	erofs_free_dev_context(sbi->devs);
> +	kfree(sbi->fsid);
> +	kfree(sbi->domain_id);
> +	kfree(sbi);
>  }
>  
>  static const struct fs_context_operations erofs_context_ops = {
> @@ -784,22 +764,22 @@ static const struct fs_context_operations erofs_context_ops = {
>  
>  static int erofs_init_fs_context(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx;
> +	struct erofs_sb_info *sbi;
>  
> -	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> -	if (!ctx)
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
>  		return -ENOMEM;
>  
> -	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
> -	if (!ctx->devs) {
> -		kfree(ctx);
> +	sbi->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
> +	if (!sbi->devs) {
> +		kfree(sbi);
>  		return -ENOMEM;
>  	}
> -	fc->fs_private = ctx;
> +	fc->fs_private = sbi;

I don't understand how your patch is going to work. fs_private isn't
transfered by the generic code to sb->s_fs_info. Did you mean
fc->s_fs_info = sbi?

>  
> -	idr_init(&ctx->devs->tree);
> -	init_rwsem(&ctx->devs->rwsem);
> -	erofs_default_options(ctx);
> +	idr_init(&sbi->devs->tree);
> +	init_rwsem(&sbi->devs->rwsem);
> +	erofs_default_options(sbi);
>  	fc->ops = &erofs_context_ops;
>  	return 0;
>  }
> -- 
> 2.31.1
> 
