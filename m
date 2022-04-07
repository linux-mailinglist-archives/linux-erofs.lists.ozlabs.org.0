Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F404F81F6
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 16:39:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3tw6j3vz2ymg
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Apr 2022 00:39:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uDxZZ9M3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uDxZZ9M3; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3tt2dhdz2xsc
 for <linux-erofs@lists.ozlabs.org>; Fri,  8 Apr 2022 00:39:50 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DAD65B82776;
 Thu,  7 Apr 2022 14:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3D1C385A4;
 Thu,  7 Apr 2022 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649342386;
 bh=D6yWTP0RRyywT+VzxCMR096V+HzvnvXzEi7Yl21vJ70=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uDxZZ9M34REyRgkCw35b1LbD7PVG+FaSxHQf0UavbfGmtHeXYZKylQticNd2IQwzI
 rXaD2sSl2pJIOxeZxxrxgYShf3C4vzIDQKF7aNMoG+nTxDJDkvh6jwGGs4IAO0t/YG
 bMGOCyo42emGXsh/x57nYvO0Jx/vzCoI6Dh29ZMuhSvXnBkYyZ+HajwxASaJe9Zlg2
 P0bX1sPOuYzt92TaAnumMY3Qz0lbSWWxQKUwMW82qTZ8ww+PCGxLmVgcIloadbGzAe
 QAf4TVwp3XVEt0HAEcY62a6j+inGC5xqV36UQSjlPv45hY8NjeIUK9te0xAS5B0YhH
 4Nsuq+z9BCMTQ==
Date: Thu, 7 Apr 2022 22:39:36 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 20/20] erofs: add 'fsid' mount option
Message-ID: <Yk73qB7j1tz+tJhE@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-21-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-21-jefflexu@linux.alibaba.com>
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
Cc: tianzichen@kuaishou.com, linux-erofs@lists.ozlabs.org, fannaihao@baidu.com,
 willy@infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 06, 2022 at 03:56:12PM +0800, Jeffle Xu wrote:
> Introduce 'fsid' mount option to enable on-demand read sementics, in
> which case, erofs will be mounted from data blobs. Users could specify
> the name of primary data blob by this mount option.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/super.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index a5e4de60a0d8..292b4a70ce19 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -398,6 +398,7 @@ enum {
>  	Opt_dax,
>  	Opt_dax_enum,
>  	Opt_device,
> +	Opt_fsid,
>  	Opt_err
>  };
>  
> @@ -422,6 +423,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_flag("dax",             Opt_dax),
>  	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>  	fsparam_string("device",	Opt_device),
> +	fsparam_string("fsid",		Opt_fsid),
>  	{}
>  };
>  
> @@ -517,6 +519,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>  		}
>  		++ctx->devs->extra_devices;
>  		break;
> +	case Opt_fsid:
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +		kfree(ctx->opt.fsid);
> +		ctx->opt.fsid = kstrdup(param->string, GFP_KERNEL);
> +		if (!ctx->opt.fsid)
> +			return -ENOMEM;
> +#else
> +		errorfc(fc, "fsid option not supported");
> +#endif
> +		break;
>  	default:
>  		return -ENOPARAM;
>  	}
> @@ -597,9 +609,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_op = &erofs_sops;
>  
> -	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
> -		erofs_err(sb, "failed to set erofs blksize");
> -		return -EINVAL;
> +	if (erofs_is_fscache_mode(sb)) {
> +		sb->s_blocksize = EROFS_BLKSIZ;
> +		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
> +	} else {
> +		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
> +			erofs_err(sb, "failed to set erofs blksize");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> @@ -608,7 +625,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
> -	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
> +	ctx->opt.fsid = NULL;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> @@ -625,6 +642,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		err = super_setup_bdi(sb);
>  		if (err)
>  			return err;
> +	} else {
> +		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);

It should go with the previous patch? And even over long line here.

Thanks,
Gao Xiang

>  	}
>  
>  	err = erofs_read_superblock(sb);
> @@ -684,6 +703,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
> +	struct erofs_fs_context *ctx = fc->fs_private;
> +
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
> +		return get_tree_nodev(fc, erofs_fc_fill_super);
> +
>  	return get_tree_bdev(fc, erofs_fc_fill_super);
>  }
>  
> @@ -733,6 +757,7 @@ static void erofs_fc_free(struct fs_context *fc)
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  
>  	erofs_free_dev_context(ctx->devs);
> +	kfree(ctx->opt.fsid);
>  	kfree(ctx);
>  }
>  
> @@ -773,7 +798,10 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
> -	kill_block_super(sb);
> +	if (erofs_is_fscache_mode(sb))
> +		generic_shutdown_super(sb);
> +	else
> +		kill_block_super(sb);
>  
>  	sbi = EROFS_SB(sb);
>  	if (!sbi)
> @@ -783,6 +811,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	fs_put_dax(sbi->dax_dev);
>  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
> +	kfree(sbi->opt.fsid);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
>  }
> @@ -884,7 +913,10 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
> +	u64 id = 0;
> +
> +	if (!erofs_is_fscache_mode(sb))
> +		id = huge_encode_dev(sb->s_bdev->bd_dev);
>  
>  	buf->f_type = sb->s_magic;
>  	buf->f_bsize = EROFS_BLKSIZ;
> @@ -929,6 +961,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",dax=always");
>  	if (test_opt(opt, DAX_NEVER))
>  		seq_puts(seq, ",dax=never");
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +	if (opt->fsid)
> +		seq_printf(seq, ",fsid=%s", opt->fsid);
> +#endif
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 
