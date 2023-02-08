Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED868E9A5
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 09:16:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBXrk2tjKz3cdr
	for <lists+linux-erofs@lfdr.de>; Wed,  8 Feb 2023 19:16:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qXjFjfhw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=qXjFjfhw;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBXrf5XK2z3bbS
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 Feb 2023 19:16:17 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id mi9so17640094pjb.4
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 00:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTl7fViVDrpd0r98XV/moIDCKuAA/8H/tgCPYQR4MZ0=;
        b=qXjFjfhwTIXPvySEAKj/6laZofYQG1mTz5a6pEKClH6z+RYCtu/hA+J0yUGzHCwwhw
         TYx9HLeqHNw8BpxUKW3/6Mrt661EV93FBVKP9mmxCW4OeRfQ/Uk2NRms9Ru8dC6kGta8
         jn8s3ijes2/9Mbw+hW/uTss4cGKURtxu1DatK9kNgzIHsbAqAV6ENCHLFvrLSat1Dcag
         U/fXh4kgdlxz9bAn1l55bwa5QTF4kkfMfXCv9W1vWHrNR78HhokCtduRELPMriWgfYjV
         AmU41Mijut5DQTstxfy8UF+IO77dxNnYtnFr0LiB6dUqwRmodPtGwMDYaQfDg395gOvp
         X76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sTl7fViVDrpd0r98XV/moIDCKuAA/8H/tgCPYQR4MZ0=;
        b=xHY6TSTFpf0ZVdi4G1OYHt7fJp1zQu59QL8Q70qvju7+wzSPIZ9ekoqna3nwbviYDY
         uivUJv199UY6aGDjirHZ9pEGgu5C7tHa291TMG2xeMCb1UAtTew3xij9SMUBVDvR+Isa
         hTGJGJWH7TzHKuaS5GJqMSahh2AXNRo0GaKnXaAVEBMibg0ce/2Zsgy8Ws7tiTv41ZnW
         LjbYm/1jYVBfaDLkztY+Ua0RZzY9ONxYG7mytTwQB+U+4q5C18syl9H1NPdK4rKV+a7U
         WzQviiuKA0W3z4b2if3aRSOMvgEYVuhrPxhFhx0+Z/fKBAabAyzvypRtHA4A9A3R2geU
         iK5w==
X-Gm-Message-State: AO0yUKVwIxJ9mxYKXsV2bewLM3O7C7kX3Vz/DQvK4dxlynqeIFOr9NjN
	biXZRS4GScmp4yR6TLtpQH1A8VpxEwRQ1Avv
X-Google-Smtp-Source: AK7set+NNbWmGpTXvzWNBBgb2kmbNa+f35uQ2rupMfRb7hOBzTFRLUlh1GrGHp3nqoD5gdmQVa9Bhw==
X-Received: by 2002:a17:90a:e7cb:b0:22c:5cd:2672 with SMTP id kb11-20020a17090ae7cb00b0022c05cd2672mr7948845pjb.34.1675844170588;
        Wed, 08 Feb 2023 00:16:10 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090a73cd00b0022bf4d0f912sm890943pjk.22.2023.02.08.00.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:16:10 -0800 (PST)
Message-ID: <53323a3d-ca41-4f7d-cf4d-dc54d14f705a@bytedance.com>
Date: Wed, 8 Feb 2023 16:16:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 2/4] erofs: maintain cookies of share domain in
 self-contained list
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <99618b85e5802aacf498387b48c61f1307c6f1f7.1675840368.git.jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <99618b85e5802aacf498387b48c61f1307c6f1f7.1675840368.git.jefflexu@linux.alibaba.com>
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
> We'd better not touch sb->s_inodes list and inode->i_count directly.
> Let's maintain cookies of share domain in a self-contained list in erofs.
> 
> Besides, relinquish cookie with the mutext held.  Otherwise if a cookie
                                       ~~~~~~
                                       mutex
Besides this, LGTM.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> is registered when the old cookie with the same name in the same domain
> has been removed from the list but not relinquished yet, fscache may
> complain "Duplicate cookie detected".
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   fs/erofs/fscache.c  | 48 ++++++++++++++++++++++-----------------------
>   fs/erofs/internal.h |  4 ++++
>   2 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 03de4dc99302..2f5930e177cc 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,8 +7,11 @@
>   #include "internal.h"
>   
>   static DEFINE_MUTEX(erofs_domain_list_lock);
> -static DEFINE_MUTEX(erofs_domain_cookies_lock);
>   static LIST_HEAD(erofs_domain_list);
> +
> +static DEFINE_MUTEX(erofs_domain_cookies_lock);
> +static LIST_HEAD(erofs_domain_cookies_list);
> +
>   static struct vfsmount *erofs_pseudo_mnt;
>   
>   struct erofs_fscache_request {
> @@ -318,8 +321,6 @@ const struct address_space_operations erofs_fscache_access_aops = {
>   
>   static void erofs_fscache_domain_put(struct erofs_domain *domain)
>   {
> -	if (!domain)
> -		return;
>   	mutex_lock(&erofs_domain_list_lock);
>   	if (refcount_dec_and_test(&domain->ref)) {
>   		list_del(&domain->list);
> @@ -434,6 +435,8 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return ERR_PTR(-ENOMEM);
> +	INIT_LIST_HEAD(&ctx->node);
> +	refcount_set(&ctx->ref, 1);
>   
>   	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
>   					name, strlen(name), NULL, 0, 0);
> @@ -479,6 +482,7 @@ static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
>   	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
>   	fscache_relinquish_cookie(ctx->cookie, false);
>   	iput(ctx->inode);
> +	iput(ctx->anon_inode);
>   	kfree(ctx->name);
>   	kfree(ctx);
>   }
> @@ -511,6 +515,7 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   	ctx->domain = domain;
>   	ctx->anon_inode = inode;
> +	list_add(&ctx->node, &erofs_domain_cookies_list);
>   	inode->i_private = ctx;
>   	refcount_inc(&domain->ref);
>   	return ctx;
> @@ -524,29 +529,23 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   						   char *name,
>   						   unsigned int flags)
>   {
> -	struct inode *inode;
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
> -	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
> -	spin_lock(&psb->s_inode_list_lock);
> -	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
> -		ctx = inode->i_private;
> -		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
> +	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
> +		if (ctx->domain != domain || strcmp(ctx->name, name))
>   			continue;
>   		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> -			igrab(inode);
> +			refcount_inc(&ctx->ref);
>   		} else {
>   			erofs_err(sb, "%s already exists in domain %s", name,
>   				  domain->domain_id);
>   			ctx = ERR_PTR(-EEXIST);
>   		}
> -		spin_unlock(&psb->s_inode_list_lock);
>   		mutex_unlock(&erofs_domain_cookies_lock);
>   		return ctx;
>   	}
> -	spin_unlock(&psb->s_inode_list_lock);
>   	ctx = erofs_fscache_domain_init_cookie(sb, name, flags);
>   	mutex_unlock(&erofs_domain_cookies_lock);
>   	return ctx;
> @@ -563,23 +562,22 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
>   
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
>   {
> -	bool drop;
> -	struct erofs_domain *domain;
> +	struct erofs_domain *domain = NULL;
>   
>   	if (!ctx)
>   		return;
> -	domain = ctx->domain;
> -	if (domain) {
> -		mutex_lock(&erofs_domain_cookies_lock);
> -		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
> -		iput(ctx->anon_inode);
> -		mutex_unlock(&erofs_domain_cookies_lock);
> -		if (!drop)
> -			return;
> -	}
> +	if (!ctx->domain)
> +		return erofs_fscache_relinquish_cookie(ctx);
>   
> -	erofs_fscache_relinquish_cookie(ctx);
> -	erofs_fscache_domain_put(domain);
> +	mutex_lock(&erofs_domain_cookies_lock);
> +	if (refcount_dec_and_test(&ctx->ref)) {
> +		domain = ctx->domain;
> +		list_del(&ctx->node);
> +		erofs_fscache_relinquish_cookie(ctx);
> +	}
> +	mutex_unlock(&erofs_domain_cookies_lock);
> +	if (domain)
> +		erofs_fscache_domain_put(domain);
>   }
>   
>   int erofs_fscache_register_fs(struct super_block *sb)
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 48a2f33de15a..8358cf5f731e 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -109,7 +109,11 @@ struct erofs_fscache {
>   	struct fscache_cookie *cookie;
>   	struct inode *inode;
>   	struct inode *anon_inode;
> +
> +	/* used for share domain mode */
>   	struct erofs_domain *domain;
> +	struct list_head node;
> +	refcount_t ref;
>   	char *name;
>   };
>   
