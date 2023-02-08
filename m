Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE868EA51
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 10:01:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBYsG2d3bz3cfH
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 20:01:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Q85RsRHo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Q85RsRHo;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBYs611n7z3cMT
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 20:01:44 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso1691039pjb.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5L8X1P50a1/A239jO7Vfe7IF4w2WawHRdeCiR+ULlw=;
        b=Q85RsRHo+ASrParwWoz3b9ErQ2Zr7Shvj4rbEJLY8IzFUwyI6HfR2zXSY6nNFoMJbR
         /SYVHoH8+GLwto7x/d/L5WHAEMmjRgwhOhLiTy9tkuIrMNLQyttMFhc0zPg6/cuwSIzL
         4cJE6QFsvmb6dnmlY1lNqvwHEI4AzWheCw5y6keD5IvHSuzmGhxC9q3FBKeogrruiCP1
         batMLUM9NlYPxMBUw2iULTbWbEgQeaJuaiHgn6QDxwElC9hBNRXEU80DQ+ApG2f9iq4M
         OlXH0EiHt9M02dXIVOhbjqC1REuvdsPusRALRbOcdA8WNu556gERZ6HoO4SPldBxfIDZ
         QiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z5L8X1P50a1/A239jO7Vfe7IF4w2WawHRdeCiR+ULlw=;
        b=CfxresdwYdjRycg1kxPsLG+tanlXY8u7rYIxEKAWWglj6D6/M0KYJNNZ0Juc+CEyKX
         NWl3M1de5Rw9PK4Z2kevQWbIrbKQNvQYagNVKiZRodg51ui1lS6e3inGMkat6/W3ZKM3
         PLJrpU4wCdzNwXAP9zIA18cPzlwceuw+9IEAa13vo9CGqqDl9du2I7C1+h/xPb5KYSE3
         iPvHP+rNfaUB3ww3lwFZ/Q5Ea/pHoEuezfYFAN8OQeKqvhk2FrcgliBAI45RrcwSlPMh
         9qp0xZJ/ePASRhgDtuOPqitKNE28MwhqcWuKIY7v4NgQeNpTYXOCSz4lu09qGpDQAv49
         X9IA==
X-Gm-Message-State: AO0yUKXCRDNhoEiWlt2r+y0DwWyJrr6fcnx0Fy691Ss5O4jxZUwTss69
	KMZONCctSLfarvpxV9/lRIZg2Q==
X-Google-Smtp-Source: AK7set+y+qFTAyNGEscBi7H2qixAmCdfXxZdKf708VPOxiyOKJQzvKFGfcKImaYwxVhhlKLEiWFsqw==
X-Received: by 2002:a17:902:ca92:b0:198:f31d:de7d with SMTP id v18-20020a170902ca9200b00198f31dde7dmr4421614pld.64.1675846900840;
        Wed, 08 Feb 2023 01:01:40 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001991942dde7sm5384904plo.125.2023.02.08.01.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:01:40 -0800 (PST)
Message-ID: <29af5dbc-2bbe-d550-9fde-6c799a302b7c@bytedance.com>
Date: Wed, 8 Feb 2023 17:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 3/4] erofs: unify anonymous inodes for blob
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <c7430379f7ec2ae1c6ba98bb3a37a70b7fad2325.1675840368.git.jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <c7430379f7ec2ae1c6ba98bb3a37a70b7fad2325.1675840368.git.jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/2/8 15:16, Jingbo Xu 写道:
> Currently there're two anonymous inodes (inode and anon_inode in struct
> erofs_fscache) for each blob.  The former was introduced as the
> address_space of page cache for bootstrap.
> 
> The latter was initially introduced as both the address_space of page
> cache and also a sentinel in the shared domain.  Since now the management
> of cookies in share domain has been decoupled with the anonymous inode,
> there's no need to maintain an extra anonymous inode.  Let's unify these
> two anonymous inodes.
> 
> Besides, in non-share-domain mode only bootstrap will allocate anonymous
> inode.  To simplify the implementation, always allocate anonymous inode
> for both bootstrap and data blobs.  Similarly release anonymous inodes
> for data blobs when .put_super() is called, or we'll get "VFS: Busy
> inodes after unmount." warning.
> 
> Also remove the redundant set_nlink() when initializing the anonymous
> inode, since i_nlink has already been initialized to 1 when the inode
> gets allocated.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/fscache.c  | 70 ++++++++++++++++-----------------------------
>   fs/erofs/internal.h |  6 ++--
>   fs/erofs/super.c    |  2 ++
>   3 files changed, 28 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 2f5930e177cc..8353a5fe8c71 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -424,12 +424,12 @@ static int erofs_fscache_register_domain(struct super_block *sb)
>   
>   static
>   struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
> -						   char *name,
> -						   unsigned int flags)
> +					struct super_block *isb, char *name)
>   {
>   	struct fscache_volume *volume = EROFS_SB(sb)->volume;
>   	struct erofs_fscache *ctx;
>   	struct fscache_cookie *cookie;
> +	struct inode *inode;
>   	int ret;
>   
>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> @@ -445,33 +445,27 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   		ret = -EINVAL;
>   		goto err;
>   	}
> -
>   	fscache_use_cookie(cookie, false);
> -	ctx->cookie = cookie;
> -
> -	if (flags & EROFS_REG_COOKIE_NEED_INODE) {
> -		struct inode *const inode = new_inode(sb);
> -
> -		if (!inode) {
> -			erofs_err(sb, "failed to get anon inode for %s", name);
> -			ret = -ENOMEM;
> -			goto err_cookie;
> -		}
> -
> -		set_nlink(inode, 1);
> -		inode->i_size = OFFSET_MAX;
> -		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> -		inode->i_private = ctx;
>   
> -		ctx->inode = inode;
> +	inode = new_inode(isb);
> +	if (!inode) {
> +		erofs_err(sb, "failed to get anon inode for %s", name);
> +		ret = -ENOMEM;
> +		goto err_cookie;
>   	}
>   
> +	inode->i_size = OFFSET_MAX;
> +	inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +	inode->i_private = ctx;
> +
> +	ctx->cookie = cookie;
> +	ctx->inode = inode;
>   	return ctx;
>   
>   err_cookie:
> -	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> -	fscache_relinquish_cookie(ctx->cookie, false);
> +	fscache_unuse_cookie(cookie, NULL, NULL);
> +	fscache_relinquish_cookie(cookie, false);
>   err:
>   	kfree(ctx);
>   	return ERR_PTR(ret);
> @@ -482,46 +476,31 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
>   	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>   	fscache_relinquish_cookie(ctx->cookie, false);
>   	iput(ctx->inode);
> -	iput(ctx->anon_inode);
>   	kfree(ctx->name);
>   	kfree(ctx);
>   }
>   
>   static
>   struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
> -						       char *name,
> -						       unsigned int flags)
> +						       char *name)
>   {
> -	int err;
> -	struct inode *inode;
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
> -	ctx = erofs_fscache_acquire_cookie(sb, name, flags);
> +	ctx = erofs_fscache_acquire_cookie(sb, erofs_pseudo_mnt->mnt_sb, name);
>   	if (IS_ERR(ctx))
>   		return ctx;
>   
>   	ctx->name = kstrdup(name, GFP_KERNEL);
>   	if (!ctx->name) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -
> -	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
> -	if (!inode) {
> -		err = -ENOMEM;
> -		goto out;
> +		erofs_fscache_relinquish_cookie(ctx);
> +		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	refcount_inc(&domain->ref);
>   	ctx->domain = domain;
> -	ctx->anon_inode = inode;
>   	list_add(&ctx->node, &erofs_domain_cookies_list);
> -	inode->i_private = ctx;
> -	refcount_inc(&domain->ref);
>   	return ctx;
> -out:
> -	erofs_fscache_relinquish_cookie(ctx);
> -	return ERR_PTR(err);
>   }
>   
>   static
> @@ -546,7 +525,7 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> -	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
> +	ctx = erofs_fscache_domain_init_cookie(sb, name);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
>   }
> @@ -557,7 +536,7 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>   {
>   	if (EROFS_SB(sb)->domain_id)
>   		return erofs_domain_register_cookie(sb, name, flags);
> -	return erofs_fscache_acquire_cookie(sb, name, flags);
> +	return erofs_fscache_acquire_cookie(sb, sb, name);

How about using <sb, flags> to indicate shared/non-shared domain
mode?
Besides, LGTM.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

>   }
>   
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
> @@ -585,7 +564,7 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	int ret;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
> -	unsigned int flags;
> +	unsigned int flags = 0;
>   
>   	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
> @@ -604,7 +583,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	 *
>   	 * Acquired domain/volume will be relinquished in kill_sb() on error.
>   	 */
> -	flags = EROFS_REG_COOKIE_NEED_INODE;
>   	if (sbi->domain_id)
>   		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
>   	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 8358cf5f731e..125e4aa8d295 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -107,8 +107,7 @@ struct erofs_domain {
>   
>   struct erofs_fscache {
>   	struct fscache_cookie *cookie;
> -	struct inode *inode;
> -	struct inode *anon_inode;
> +	struct inode *inode;	/* anonymous indoe for the blob */
>   
>   	/* used for share domain mode */
>   	struct erofs_domain *domain;
> @@ -450,8 +449,7 @@ extern const struct file_operations erofs_dir_fops;
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
>   /* flags for erofs_fscache_register_cookie() */
> -#define EROFS_REG_COOKIE_NEED_INODE	1
> -#define EROFS_REG_COOKIE_NEED_NOEXIST	2
> +#define EROFS_REG_COOKIE_NEED_NOEXIST	1
>   
>   void erofs_unmap_metabuf(struct erofs_buf *buf);
>   void erofs_put_metabuf(struct erofs_buf *buf);
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 715efa94eed4..19b1ae79cec4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -968,6 +968,8 @@ static void erofs_put_super(struct super_block *sb)
>   	iput(sbi->packed_inode);
>   	sbi->packed_inode = NULL;
>   #endif
> +	erofs_free_dev_context(sbi->devs);
> +	sbi->devs = NULL;
>   	erofs_fscache_unregister_fs(sb);
>   }
>   
