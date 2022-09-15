Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 595815B92A9
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 04:26:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSh0l2Rspz3bcF
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 12:26:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56; helo=out30-56.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSh0g251cz30Dp
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 12:26:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VPqk4AT_1663208795;
Received: from 30.221.129.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VPqk4AT_1663208795)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 10:26:36 +0800
Message-ID: <6606b1d2-7612-2e9c-19f3-8790257219d3@linux.alibaba.com>
Date: Thu, 15 Sep 2022 10:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 2/6] erofs: code clean up for fscache
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
 xiang@kernel.org, chao@kernel.org
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-3-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220914105041.42970-3-zhujia.zj@bytedance.com>
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
> Some cleanups. No logic changes.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/fscache.c  | 26 +++++++++++++++-----------
>  fs/erofs/internal.h | 17 ++++++++---------
>  fs/erofs/super.c    | 22 +++++++++-------------
>  3 files changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8e01d89c3319..4159cf781924 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -417,9 +417,8 @@ const struct address_space_operations erofs_fscache_access_aops = {
>  	.readahead = erofs_fscache_readahead,
>  };
>  
> -int erofs_fscache_register_cookie(struct super_block *sb,
> -				  struct erofs_fscache **fscache,
> -				  char *name, bool need_inode)
> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> +						     char *name, bool need_inode)
>  {
>  	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>  	struct erofs_fscache *ctx;
> @@ -428,7 +427,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  
>  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
>  					name, strlen(name), NULL, 0, 0);
> @@ -458,8 +457,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  		ctx->inode = inode;
>  	}
>  
> -	*fscache = ctx;
> -	return 0;
> +	return ctx;
>  
>  err_cookie:
>  	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> @@ -467,13 +465,11 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  	ctx->cookie = NULL;
>  err:
>  	kfree(ctx);
> -	return ret;
> +	return ERR_PTR(ret);
>  }
>  
> -void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
> +void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>  {
> -	struct erofs_fscache *ctx = *fscache;
> -
>  	if (!ctx)
>  		return;
>  
> @@ -485,13 +481,13 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  	ctx->inode = NULL;
>  
>  	kfree(ctx);
> -	*fscache = NULL;
>  }
>  
>  int erofs_fscache_register_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  	struct fscache_volume *volume;
> +	struct erofs_fscache *fscache;
>  	char *name;
>  	int ret = 0;
>  
> @@ -508,6 +504,12 @@ int erofs_fscache_register_fs(struct super_block *sb)
>  
>  	sbi->volume = volume;
>  	kfree(name);

If the above fscache_acquire_volume() fails, we'd better return directly
without going on registering cookie.

> +
> +	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
> +	if (IS_ERR(fscache))
> +		return PTR_ERR(fscache);

We'd better add some comment like "the registered volume will be cleaned
up in .kill_sb() in error case".


> +
> +	sbi->s_fscache = fscache;
>  	return ret;
>  }
>  
> @@ -515,6 +517,8 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> +	erofs_fscache_unregister_cookie(sbi->s_fscache);
>  	fscache_relinquish_volume(sbi->volume, NULL, false);
> +	sbi->s_fscache = NULL;
>  	sbi->volume = NULL;
>  }
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index cfee49d33b95..aa71eb65e965 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -610,27 +610,26 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  int erofs_fscache_register_fs(struct super_block *sb);
>  void erofs_fscache_unregister_fs(struct super_block *sb);
>  
> -int erofs_fscache_register_cookie(struct super_block *sb,
> -				  struct erofs_fscache **fscache,
> -				  char *name, bool need_inode);
> -void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> +						     char *name, bool need_inode);
> +void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
>  
>  extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb)
>  {
> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>  
> -static inline int erofs_fscache_register_cookie(struct super_block *sb,
> -						struct erofs_fscache **fscache,
> -						char *name, bool need_inode)
> +static inline
> +struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> +						     char *name, bool need_inode)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
> +static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
>  {
>  }
>  #endif
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9716d355a63e..7aa57dcebf31 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -224,10 +224,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  			     struct erofs_device_info *dif, erofs_off_t *pos)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_fscache *fscache;
>  	struct erofs_deviceslot *dis;
>  	struct block_device *bdev;
>  	void *ptr;
> -	int ret;
>  
>  	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
>  	if (IS_ERR(ptr))
> @@ -245,10 +245,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>  	}
>  
>  	if (erofs_is_fscache_mode(sb)) {
> -		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
> -				dif->path, false);
> -		if (ret)
> -			return ret;
> +		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
> +		if (IS_ERR(fscache))
> +			return PTR_ERR(fscache);
> +		dif->fscache = fscache;
>  	} else {
>  		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
>  					  sb->s_type);
> @@ -706,11 +706,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (err)
>  			return err;
>  
> -		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
> -						    sbi->opt.fsid, true);
> -		if (err)
> -			return err;
> -
>  		err = super_setup_bdi(sb);
>  		if (err)
>  			return err;
> @@ -817,7 +812,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	fs_put_dax(dif->dax_dev, NULL);
>  	if (dif->bdev)
>  		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
> -	erofs_fscache_unregister_cookie(&dif->fscache);
> +	erofs_fscache_unregister_cookie(dif->fscache);
> +	dif->fscache = NULL;
>  	kfree(dif->path);
>  	kfree(dif);
>  	return 0;
> @@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
>  
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
>  	kfree(sbi);
> @@ -909,7 +904,8 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> +	erofs_fscache_unregister_cookie(sbi->s_fscache);
> +	sbi->s_fscache = NULL;

How about calling erofs_fscache_unregister_fs() here? It shall be okay
to also unregister volume here.

>  }
>  
>  static struct file_system_type erofs_fs_type = {

-- 
Thanks,
Jingbo
