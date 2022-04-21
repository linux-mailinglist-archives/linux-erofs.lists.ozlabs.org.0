Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8D509F2E
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 13:59:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kkbgf0FSzz30Dp
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 21:59:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkbgY0Vfzz2ynj
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Apr 2022 21:59:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0VAelXMA_1650542363; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VAelXMA_1650542363) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Apr 2022 19:59:25 +0800
Date: Thu, 21 Apr 2022 19:59:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v9 21/21] erofs: add 'fsid' mount option
Message-ID: <YmFHGjHkWOT7GoIm@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
 dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org,
 torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
 eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
 luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
 fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <20220415123614.54024-22-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-22-jefflexu@linux.alibaba.com>
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
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 15, 2022 at 08:36:14PM +0800, Jeffle Xu wrote:
> Introduce 'fsid' mount option to enable on-demand read sementics, in
> which case, erofs will be mounted from data blobs. Users could specify
> the name of primary data blob by this mount option.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/super.c | 31 ++++++++++++++++++++++++++++++-
>  fs/erofs/sysfs.c |  4 ++--
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index f68ba929100d..4a623630e1c4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -371,6 +371,8 @@ static int erofs_read_superblock(struct super_block *sb)
>  
>  	if (erofs_sb_has_ztailpacking(sbi))
>  		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
> +	if (erofs_is_fscache_mode(sb))
> +		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
>  out:
>  	erofs_put_metabuf(&buf);
>  	return ret;
> @@ -399,6 +401,7 @@ enum {
>  	Opt_dax,
>  	Opt_dax_enum,
>  	Opt_device,
> +	Opt_fsid,
>  	Opt_err
>  };
>  
> @@ -423,6 +426,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>  	fsparam_flag("dax",             Opt_dax),
>  	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
>  	fsparam_string("device",	Opt_device),
> +	fsparam_string("fsid",		Opt_fsid),
>  	{}
>  };
>  
> @@ -518,6 +522,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
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
> @@ -604,6 +618,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
> +	ctx->opt.fsid = NULL;
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> @@ -690,6 +705,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
> @@ -739,6 +759,7 @@ static void erofs_fc_free(struct fs_context *fc)
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  
>  	erofs_free_dev_context(ctx->devs);
> +	kfree(ctx->opt.fsid);
>  	kfree(ctx);
>  }
>  
> @@ -779,7 +800,10 @@ static void erofs_kill_sb(struct super_block *sb)
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
> @@ -789,6 +813,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  	fs_put_dax(sbi->dax_dev);
>  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
> +	kfree(sbi->opt.fsid);
>  	kfree(sbi);
>  	sb->s_fs_info = NULL;
>  }
> @@ -938,6 +963,10 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
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
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index f3babf1e6608..c1383e508bbe 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -205,8 +205,8 @@ int erofs_register_sysfs(struct super_block *sb)
>  
>  	sbi->s_kobj.kset = &erofs_root;
>  	init_completion(&sbi->s_kobj_unregister);
> -	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL,
> -				   "%s", sb->s_id);
> +	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
> +			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>  	if (err)
>  		goto put_sb_kobj;
>  	return 0;
> -- 
> 2.27.0
