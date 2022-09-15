Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F05B94BC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 08:53:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSnwF03J9z3bZP
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 16:53:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSnw92hkFz2y8L
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 16:53:12 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPrhg1A_1663224787;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPrhg1A_1663224787)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 14:53:08 +0800
Message-ID: <82473542-7810-3474-3f78-b61f9927d682@linux.alibaba.com>
Date: Thu, 15 Sep 2022 14:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 6/6] erofs: Support sharing cookies in the same domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-7-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220914105041.42970-7-zhujia.zj@bytedance.com>
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



On 9/14/22 6:50 PM, Jia Zhu wrote:
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.
> 
> Users could specify domain_id mount option to create or join into a
> domain.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 89 +++++++++++++++++++++++++++++++++++++++++++--
>  fs/erofs/internal.h |  4 +-
>  2 files changed, 89 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 4e0a441afb7d..e9ae1ee963e2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,7 @@
>  #include "internal.h"
>  
>  static DEFINE_MUTEX(erofs_domain_list_lock);
> +static DEFINE_MUTEX(erofs_domain_cookies_lock);
>  static LIST_HEAD(erofs_domain_list);
>  static struct vfsmount *erofs_pseudo_mnt;
>  
> @@ -504,7 +505,6 @@ static int erofs_fscache_init_domain(struct super_block *sb)
>  
>  	domain->volume = sbi->volume;
>  	refcount_set(&domain->ref, 1);
> -	mutex_init(&domain->mutex);

This needs to be folded into patch 4.


>  	list_add(&domain->list, &erofs_domain_list);
>  	return 0;
>  out:
> @@ -534,8 +534,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>  	return err;
>  }
>  
> -struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						     char *name, bool need_inode)
> +struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> +						    char *name, bool need_inode)
>  {
>  	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>  	struct erofs_fscache *ctx;
> @@ -585,13 +585,96 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>  	return ERR_PTR(ret);
>  }
>  
> +static
> +struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> +							char *name, bool need_inode)
> +{
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +
> +	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
> +	if (IS_ERR(ctx))
> +		return ctx;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name)
> +		return ERR_PTR(-ENOMEM);

The previously registered erofs_fscache needs to be cleaned up in the
error path.

> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		return ERR_PTR(-ENOMEM);
> +	}

Ditto.

> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	erofs_fscache_domain_get(domain);
> +	return ctx;
> +}
> +
> +static
> +struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> +						    char *name, bool need_inode)
> +{
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
> +
> +	mutex_lock(&erofs_domain_cookies_lock);
> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> +		ctx = inode->i_private;
> +		if (!ctx)
> +			continue;
> +		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
> +			igrab(inode);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return ctx;
> +		}
> +	}
> +	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
> +	mutex_unlock(&erofs_domain_cookies_lock);
> +	return ctx;
> +}
> +
> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> +						     char *name, bool need_inode)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	if (sbi->opt.domain_id)
> +		return erofs_domain_register_cookie(sb, name, need_inode);
> +	else
> +		return erofs_fscache_acquire_cookie(sb, name, need_inode);
> +}
> +
>  void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  {
> +	struct erofs_domain *domain;
> +
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&erofs_domain_cookies_lock);
> +		/* Cookie is still in use */
> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
> +			iput(ctx->anon_inode);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return;
> +		}
> +		iput(ctx->anon_inode);
> +		kfree(ctx->name);
> +		mutex_unlock(&erofs_domain_cookies_lock);

		mutex_lock(&erofs_domain_cookies_lock);
		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
		iput(ctx->anon_inode);
		mutex_unlock(&erofs_domain_cookies_lock);

		if (!drop)
			return;
> +	}
>  >  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	ctx->cookie = NULL;

	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
	fscache_relinquish_cookie(ctx->cookie, false);
	erofs_fscache_domain_put(domain);
	kfree(ctx->name);

>  
>  	iput(ctx->inode);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4dd0b545755a..8a6f94b27a23 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -101,7 +101,6 @@ struct erofs_sb_lz4_info {
>  
>  struct erofs_domain {
>  	refcount_t ref;
> -	struct mutex mutex;
>  	struct list_head list;
>  	struct fscache_volume *volume;
>  	char *domain_id;
> @@ -110,6 +109,9 @@ struct erofs_domain {
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
>  	struct inode *inode;
> +	struct inode *anon_inode;
> +	struct erofs_domain *domain;
> +	char *name;
>  };
>  
>  struct erofs_sb_info {

-- 
Thanks,
Jingbo
