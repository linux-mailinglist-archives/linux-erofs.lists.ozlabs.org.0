Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9735B67EA
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 08:28:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRYS73xP2z3bYk
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 16:28:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRYS26QdSz2yZc
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 16:28:01 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPduYe-_1663050471;
Received: from 30.221.130.76(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPduYe-_1663050471)
          by smtp.aliyun-inc.com;
          Tue, 13 Sep 2022 14:27:52 +0800
Message-ID: <097a8ffb-c8b0-ed10-6c82-8a6de9bed09b@linux.alibaba.com>
Date: Tue, 13 Sep 2022 14:27:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 5/5] erofs: support fscache based shared domain
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-6-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-6-zhujia.zj@bytedance.com>
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
> Several erofs filesystems can belong to one domain, and data blobs can
> be shared among these erofs filesystems of same domain.
> 
> Users could specify domain_id mount option to create or join into a domain.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h | 12 ++++++++
>  fs/erofs/super.c    | 10 +++++--
>  3 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 439dd3cc096a..c01845808ede 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -559,12 +559,27 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  {
>  	struct erofs_fscache *ctx = *fscache;
> +	struct erofs_domain *domain;
>  
>  	if (!ctx)
>  		return;
> +	domain = ctx->domain;
> +	if (domain) {
> +		mutex_lock(&domain->mutex);
> +		/* Cookie is still in use */
> +		if (atomic_read(&ctx->anon_inode->i_count) > 1) {
> +			iput(ctx->anon_inode);
> +			mutex_unlock(&domain->mutex);
> +			return;
> +		}
> +		iput(ctx->anon_inode);
> +		kfree(ctx->name);
> +		mutex_unlock(&domain->mutex);
> +	}
>  
>  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>  	fscache_relinquish_cookie(ctx->cookie, false);
> +	erofs_fscache_domain_put(domain);
>  	ctx->cookie = NULL;
>  
>  	iput(ctx->inode);
> @@ -609,3 +624,61 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>  	sbi->volume = NULL;
>  	sbi->domain = NULL;
>  }
> +
> +static int erofs_fscache_domain_init_cookie(struct super_block *sb,
> +		struct erofs_fscache **fscache, char *name, bool need_inode)
> +{
> +	int ret;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +
> +	ret = erofs_fscache_register_cookie(sb, &ctx, name, need_inode);
> +	if (ret)
> +		return ret;
> +
> +	ctx->name = kstrdup(name, GFP_KERNEL);
> +	if (!ctx->name)
> +		return -ENOMEM;

Shall we clean up the above registered cookie in the error path?

> +
> +	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> +	if (!inode) {
> +		kfree(ctx->name);
> +		return -ENOMEM;
> +	}

Ditto.

> +
> +	ctx->domain = domain;
> +	ctx->anon_inode = inode;
> +	inode->i_private = ctx;
> +	erofs_fscache_domain_get(domain);
> +	*fscache = ctx;
> +	return 0;
> +}
> +
> +int erofs_domain_register_cookie(struct super_block *sb,
> +	struct erofs_fscache **fscache, char *name, bool need_inode)
> +{
> +	int err;
> +	struct inode *inode;
> +	struct erofs_fscache *ctx;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_domain *domain = sbi->domain;
> +	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
> +
> +	mutex_lock(&domain->mutex);

What is domain->mutex used for?


> +	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> +		ctx = inode->i_private;
> +		if (!ctx)
> +			continue;
> +		if (!strcmp(ctx->name, name)) {
> +			*fscache = ctx;
> +			igrab(inode);
> +			mutex_unlock(&domain->mutex);
> +			return 0;
> +		}
> +	}
> +	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
> +	mutex_unlock(&domain->mutex);
> +	return err;
> +}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 2790c93ffb83..efa4f4ad77cc 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -110,6 +110,9 @@ struct erofs_domain {
>  struct erofs_fscache {
>  	struct fscache_cookie *cookie;
>  	struct inode *inode;
> +	struct inode *anon_inode;

Why can't we reuse @inode for anon_inode?


> +	struct erofs_domain *domain;
> +	char *name;
>  };
>  
>  struct erofs_sb_info {
> @@ -625,6 +628,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
>  int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode);
> +int erofs_domain_register_cookie(struct super_block *sb,
> +				  struct erofs_fscache **fscache,
> +				  char *name, bool need_inode);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  
>  extern const struct address_space_operations erofs_fscache_access_aops;
> @@ -646,6 +652,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int erofs_domain_register_cookie(struct super_block *sb,
> +						struct erofs_fscache **fscache,
> +						char *name, bool need_inode)
> +{
> +	return -EOPNOTSUPP;
> +}
>  
>  static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 667a78f0ee70..11c5ba84567c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -245,8 +245,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  	}
>  
>  	if (erofs_is_fscache_mode(sb)) {
> -		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
> -				dif->path, false);
> +		if (sbi->opt.domain_id)
> +			ret = erofs_domain_register_cookie(sb, &dif->fscache, dif->path,
> +					false);
> +		else
> +			ret = erofs_fscache_register_cookie(sb, &dif->fscache, dif->path,
> +					false);
>  		if (ret)
>  			return ret;
>  	} else {
> @@ -726,6 +730,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			err = erofs_fscache_register_domain(sb);
>  			if (err)
>  				return err;
> +			err = erofs_domain_register_cookie(sb, &sbi->s_fscache,
> +					sbi->opt.fsid, true);
>  		} else {
>  			err = erofs_fscache_register_fs(sb);
>  			if (err)

-- 
Thanks,
Jingbo
