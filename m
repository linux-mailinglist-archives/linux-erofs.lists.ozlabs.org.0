Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED45B31F8
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 10:42:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP8cx6bGcz3bbr
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 18:42:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP8cs50hHz30FQ
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 18:42:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VP8g4UO_1662712934;
Received: from 30.221.130.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VP8g4UO_1662712934)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 16:42:15 +0800
Message-ID: <ac567b29-dd30-7b65-aefb-3f23e59781cb@linux.alibaba.com>
Date: Fri, 9 Sep 2022 16:42:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 2/5] erofs: introduce fscache-based domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-3-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-3-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 9/2/22 6:53 PM, Jia Zhu wrote:
> A new fscache-based shared domain mode is going to be introduced for
> erofs. In which case, same data blobs in same domain will be shared
> and reused to reduce on-disk space usage.
> 
> As the first step, we use pseudo mnt to manage and maintain domain's
> lifecycle.
> 
> The implementation of sharing blobs will be introduced in subsequent
> patches.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++-
>  fs/erofs/internal.h | 18 ++++++++-
>  fs/erofs/super.c    | 51 ++++++++++++++++++------
>  3 files changed, 149 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8e01d89c3319..439dd3cc096a 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -1,10 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2022, Alibaba Cloud
> + * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>   */
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +static DEFINE_MUTEX(erofs_domain_list_lock);
> +static LIST_HEAD(erofs_domain_list);
> +static struct vfsmount *erofs_pseudo_mnt;
> +
>  static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
>  					     loff_t start, size_t len)
>  {
> @@ -417,6 +422,87 @@ const struct address_space_operations erofs_fscache_access_aops = {
>  	.readahead = erofs_fscache_readahead,
>  };
>  
> +static void erofs_fscache_domain_get(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	refcount_inc(&domain->ref);
> +}

It seems that the input @domain can not be NULL, and thus the NULL check
is not needed.

Besides how about:

struct erofs_domain *domain erofs_fscache_domain_get(struct erofs_domain
*domain)
{
	refcount_inc(&domain->ref);
	return domain;
}

> +
> +static void erofs_fscache_domain_put(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	if (refcount_dec_and_test(&domain->ref)) {
> +		fscache_relinquish_volume(domain->volume, NULL, false);
> +		mutex_lock(&erofs_domain_list_lock);
> +		list_del(&domain->list);
> +		mutex_unlock(&erofs_domain_list_lock);
> +		kfree(domain->domain_id);
> +		kfree(domain);
> +	}
> +}
> +
> +static int erofs_fscache_init_domain(struct super_block *sb)
> +{
> +	int err;
> +	struct erofs_domain *domain;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
> +	if (!domain->domain_id) {
> +		kfree(domain);
> +		return -ENOMEM;
> +	}
> +	sbi->domain = domain;
> +	if (!erofs_pseudo_mnt) {
> +		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
> +		if (IS_ERR(erofs_pseudo_mnt)) {
> +			err = PTR_ERR(erofs_pseudo_mnt);
> +			goto out;
> +		}
> +	}
> +	err = erofs_fscache_register_fs(sb);
> +	if (err)
> +		goto out;
> +
> +	domain->volume = sbi->volume;
> +	refcount_set(&domain->ref, 1);
> +	mutex_init(&domain->mutex);
> +	list_add(&domain->list, &erofs_domain_list);
> +	return 0;
> +out:
> +	kfree(domain->domain_id);
> +	kfree(domain);
> +	sbi->domain = NULL;
> +	return err;
> +}
> +
> +int erofs_fscache_register_domain(struct super_block *sb)
> +{
> +	int err;
> +	struct erofs_domain *domain;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	mutex_lock(&erofs_domain_list_lock);
> +	list_for_each_entry(domain, &erofs_domain_list, list) {
> +		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
> +			erofs_fscache_domain_get(domain);
> +			sbi->domain = domain;

			sbi->domain = erofs_fscache_domain_get(domain);
			
> +			sbi->volume = domain->volume;
> +			mutex_unlock(&erofs_domain_list_lock);
> +			return 0;
> +		}
> +	}
> +	err = erofs_fscache_init_domain(sb);
> +	mutex_unlock(&erofs_domain_list_lock);
> +	return err;
> +}
> +
>  int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode)
> @@ -495,7 +581,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>  	char *name;
>  	int ret = 0;
>  
> -	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
> +	name = kasprintf(GFP_KERNEL, "erofs,%s",
> +			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);

Do we also need to encode the cookie name in the "<domain_id>,<fsid>"
format? This will affect the path of the cache files.

>  	if (!name)
>  		return -ENOMEM;
>  
> @@ -515,6 +602,10 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	fscache_relinquish_volume(sbi->volume, NULL, false);
> +	if (sbi->domain)
> +		erofs_fscache_domain_put(sbi->domain);
> +	else
> +		fscache_relinquish_volume(sbi->volume, NULL, false);
>  	sbi->volume = NULL;
> +	sbi->domain = NULL;
>  }
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index fe435d077f1a..2790c93ffb83 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -99,6 +99,14 @@ struct erofs_sb_lz4_info {
>  	u16 max_pclusterblks;
>  };
>  
> +struct erofs_domain {
> +	refcount_t ref;
> +	struct mutex mutex;
> +	struct list_head list;
> +	struct fscache_volume *volume;
> +	char *domain_id;
> +};
> +
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
>  	struct inode *inode;
> @@ -158,6 +166,7 @@ struct erofs_sb_info {
>  	/* fscache support */
>  	struct fscache_volume *volume;
>  	struct erofs_fscache *s_fscache;
> +	struct erofs_domain *domain;
>  };
>  
>  #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
> @@ -394,6 +403,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
>  }
>  
>  extern const struct super_operations erofs_sops;
> +extern struct file_system_type erofs_fs_type;
>  
>  extern const struct address_space_operations erofs_raw_access_aops;
>  extern const struct address_space_operations z_erofs_aops;
> @@ -610,6 +620,7 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  int erofs_fscache_register_fs(struct super_block *sb);
>  void erofs_fscache_unregister_fs(struct super_block *sb);
> +int erofs_fscache_register_domain(struct super_block *sb);
>  
>  int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
> @@ -620,10 +631,15 @@ extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb)
>  {
> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>  
> +static inline int erofs_fscache_register_domain(const struct super_block *sb)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int erofs_fscache_register_cookie(struct super_block *sb,
>  						struct erofs_fscache **fscache,
>  						char *name, bool need_inode)
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index d01109069c6b..69de1731f454 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -688,6 +688,13 @@ static const struct export_operations erofs_export_ops = {
>  	.get_parent = erofs_get_parent,
>  };
>  
> +static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	static const struct tree_descr empty_descr = {""};
> +
> +	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
> +}
> +
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct inode *inode;
> @@ -715,12 +722,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		sb->s_blocksize = EROFS_BLKSIZ;
>  		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
>  
> -		err = erofs_fscache_register_fs(sb);
> -		if (err)
> -			return err;
> -
> -		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
> -						    sbi->opt.fsid, true);
> +		if (sbi->opt.domain_id) {
> +			err = erofs_fscache_register_domain(sb);
> +			if (err)
> +				return err;
> +		} else {
> +			err = erofs_fscache_register_fs(sb);
> +			if (err)
> +				return err;
> +			err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
> +					sbi->opt.fsid, true);

We'd better keep only one entry to the fscache related codes. How about
moving erofs_fscache_register_cookie(), i.e. registering cookie for
bootstrap, into erofs_fscache_register_fs()? Similarly, check the
domain_id and call erofs_fscache_register_domain() inside
erofs_fscache_register_fs().

Similarly, check domain_id and call erofs_domain_register_cookie()
inside erofs_fscache_register_cookie().



> +		}
>  		if (err)
>  			return err;
>  
> @@ -798,8 +810,12 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  
> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->opt.fsid)
> -		return get_tree_nodev(fc, erofs_fc_fill_super);
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND)) {
> +		if (!ctx && fc->sb_flags & SB_KERNMOUNT)
> +			return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
> +		if (ctx->opt.fsid)
> +			return get_tree_nodev(fc, erofs_fc_fill_super);
> +	}
>  
>  	return get_tree_bdev(fc, erofs_fc_fill_super);
>  }
> @@ -849,6 +865,8 @@ static void erofs_fc_free(struct fs_context *fc)
>  {
>  	struct erofs_fs_context *ctx = fc->fs_private;
>  
> +	if (!ctx)
> +		return;
>  	erofs_free_dev_context(ctx->devs);
>  	kfree(ctx->opt.fsid);
>  	kfree(ctx->opt.domain_id);
> @@ -864,8 +882,12 @@ static const struct fs_context_operations erofs_context_ops = {
>  
>  static int erofs_init_fs_context(struct fs_context *fc)
>  {
> -	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	struct erofs_fs_context *ctx;
>  
> +	if (fc->sb_flags & SB_KERNMOUNT)
> +		goto out;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
>  		return -ENOMEM;
>  	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
> @@ -878,6 +900,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  	idr_init(&ctx->devs->tree);
>  	init_rwsem(&ctx->devs->rwsem);
>  	erofs_default_options(ctx);
> +out:
>  	fc->ops = &erofs_context_ops;
>  	return 0;
>  }
> @@ -892,6 +915,10 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>  
> +	if (sb->s_flags & SB_KERNMOUNT) {
> +		kill_litter_super(sb);
> +		return;
> +	}
>  	if (erofs_is_fscache_mode(sb))
>  		generic_shutdown_super(sb);
>  	else
> @@ -916,8 +943,8 @@ static void erofs_put_super(struct super_block *sb)
>  {
>  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>  
> -	DBG_BUGON(!sbi);
> -
> +	if (!sbi)
> +		return;
>  	erofs_unregister_sysfs(sb);
>  	erofs_shrinker_unregister(sb);
>  #ifdef CONFIG_EROFS_FS_ZIP
> @@ -927,7 +954,7 @@ static void erofs_put_super(struct super_block *sb)
>  	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  }
>  
> -static struct file_system_type erofs_fs_type = {
> +struct file_system_type erofs_fs_type = {
>  	.owner          = THIS_MODULE,
>  	.name           = "erofs",
>  	.init_fs_context = erofs_init_fs_context,

-- 
Thanks,
Jingbo
