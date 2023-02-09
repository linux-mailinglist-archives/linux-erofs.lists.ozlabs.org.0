Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3968FD41
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 03:43:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC1QV0Cwrz3cgs
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 13:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Mk8Yc+aE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Mk8Yc+aE;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC1QK2l35z2ymk
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 13:43:35 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso5339818pju.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 18:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6iXDCmEIe8YwpqTZfUQ4aqLxhpWrn73JNMNernn3kk=;
        b=Mk8Yc+aEdxHXckXYsM8d6w5yMom9HAJTqxnJNCq9tOI5xxqq653wJt6aU1arFIS9vo
         RkG0iMquvJAyzeD+zZqYVaaLL6QOqLfcDvlGQYsxxefgsy2lTOojNdqMe5tSAxyCXj0U
         AyZSMJn1RYmOTwRYC3PVDQOLZTpUNKf8v4V0jZ4hhl63+gqPr2r1dHCC/lqdyPO+sEL8
         klRyGhswrSkHM2tt9IQJUPTfXjdnZYAkxHoAoAfM+IKj5LVI0grH6YXnuMnuiXmbiaUF
         m8eVo3nl929QIuwtQH8mF0zXOGCKHGH/MWVAiaN48vKUFsQAtrIJjW1kGvDZ8q7Q7WW7
         LlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6iXDCmEIe8YwpqTZfUQ4aqLxhpWrn73JNMNernn3kk=;
        b=1Oz6YexfMZpWuUndZ/Sh3R5RzQVeelIwYzW/EnLdfo95tR72e4rA0gV5akdkxPlEQz
         Qf0uQ2okNEHC/8IFm9J94KelAfOkgxWmbGeiAFYtQ7hubr/pbyDjI+B04G00FirqXYi7
         oZkYlzoqveljh+/MohEwRR7orIVuS5dsxWo8jKewDKXRWqp6YYR1A+9wBHwpl9wmkKps
         yZ2OoQ6XlImifTznlj04pReaH/nl4rY5TYz30F2BLvRh5oSPZrWqaSkN3oFgCx4Ssq6i
         wOvtZbGw+0RalfbNxUBN+AQ/ey+fNQJjCMHftDUdqifKDrS2HUSPq7KgZ0vE3l3ioXav
         W7ig==
X-Gm-Message-State: AO0yUKUPkz1VETe5wUn3GN/huWhJ0Q39YrS7MZ/2jbyaHdJxSSQJnCeC
	JPIRpYD+H5089iGMdrH/HI7jVA==
X-Google-Smtp-Source: AK7set+w7OSDqHLMhPECQU84Ihi0UG+DORJcjKgr98v3nxJqaiAUeq40TDrwYGZIvysMZVkwUm2fTg==
X-Received: by 2002:a17:902:f548:b0:199:2f53:4d95 with SMTP id h8-20020a170902f54800b001992f534d95mr10320393plf.50.1675910613291;
        Wed, 08 Feb 2023 18:43:33 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b004a737a6e62fsm220961pgp.14.2023.02.08.18.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 18:43:32 -0800 (PST)
Message-ID: <ce11c1b5-b83e-5c5d-5e03-ea3278059efb@bytedance.com>
Date: Thu, 9 Feb 2023 10:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] erofs: simplify the name collision checking in share
 domain mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org, houtao1@huawei.com
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
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



在 2023/2/8 15:17, Jingbo Xu 写道:
> When share domain is enabled, data blobs can be shared among filesystem
> instances in the same domain for data deduplication, while bootstrap
> blobs are always dedicated to the corresponding filesystem instance, and
> have no need to be shared.
> 
> In the initial implementation of share domain (commit 7d41963759fe
> ("erofs: Support sharing cookies in the same domain")), bootstrap blobs
> are also in the share domain, and thus can be referenced by the
> following filesystem instances.  In this case, mounting twice with the
> same fsid and domain_id will trigger warning in sysfs.  Commit
> 27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
> advance") fixes this by introducing the name collision checking.
> 
> This patch attempts to fix the above issue in another simpler way.
> Since the bootstrap blobs have no need to be shared, move them out of
> the share domain, so that one bootstrap blob can not be referenced by
> other filesystem instances.  Attempt to mount twice with the same fsid
> and domain_id will fail with info of duplicate cookies, which is
> consistent with the behavior in non-share-domain mode.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/erofs/fscache.c  | 36 ++++++++----------------------------
>   fs/erofs/internal.h |  4 ++--
>   fs/erofs/super.c    |  2 +-
>   3 files changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 8353a5fe8c71..8da6e05e9d23 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -505,25 +505,18 @@ struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
>   
>   static
>   struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
> -						   char *name,
> -						   unsigned int flags)
> +						   char *name)
>   {
>   	struct erofs_fscache *ctx;
>   	struct erofs_domain *domain = EROFS_SB(sb)->domain;
>   
>   	mutex_lock(&erofs_domain_cookies_lock);
>   	list_for_each_entry(ctx, &erofs_domain_cookies_list, node) {
> -		if (ctx->domain != domain || strcmp(ctx->name, name))
> -			continue;
> -		if (!(flags & EROFS_REG_COOKIE_NEED_NOEXIST)) {
> +		if (ctx->domain == domain && !strcmp(ctx->name, name)) {
>   			refcount_inc(&ctx->ref);
> -		} else {
> -			erofs_err(sb, "%s already exists in domain %s", name,
> -				  domain->domain_id);
> -			ctx = ERR_PTR(-EEXIST);
> +			mutex_unlock(&erofs_domain_cookies_lock);
> +			return ctx;
>   		}
> -		mutex_unlock(&erofs_domain_cookies_lock);
> -		return ctx;
>   	}
>   	ctx = erofs_fscache_domain_init_cookie(sb, name);
>   	mutex_unlock(&erofs_domain_cookies_lock);
> @@ -531,11 +524,10 @@ struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
>   }
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -						    char *name,
> -						    unsigned int flags)
> +						    char *name)
>   {
>   	if (EROFS_SB(sb)->domain_id)
> -		return erofs_domain_register_cookie(sb, name, flags);
> +		return erofs_domain_register_cookie(sb, name);
>   	return erofs_fscache_acquire_cookie(sb, sb, name);
>   }
>   
> @@ -564,7 +556,6 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	int ret;
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
> -	unsigned int flags = 0;
>   
>   	if (sbi->domain_id)
>   		ret = erofs_fscache_register_domain(sb);
> @@ -573,19 +564,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
>   	if (ret)
>   		return ret;
>   
> -	/*
> -	 * When shared domain is enabled, using NEED_NOEXIST to guarantee
> -	 * the primary data blob (aka fsid) is unique in the shared domain.
> -	 *
> -	 * For non-shared-domain case, fscache_acquire_volume() invoked by
> -	 * erofs_fscache_register_volume() has already guaranteed
> -	 * the uniqueness of primary data blob.
> -	 *
> -	 * Acquired domain/volume will be relinquished in kill_sb() on error.
> -	 */
> -	if (sbi->domain_id)
> -		flags |= EROFS_REG_COOKIE_NEED_NOEXIST;
> -	fscache = erofs_fscache_register_cookie(sb, sbi->fsid, flags);
> +	/* acquired domain/volume will be relinquished in kill_sb() on error */
> +	fscache = erofs_fscache_acquire_cookie(sb, sb, sbi->fsid);
>   	if (IS_ERR(fscache))
>   		return PTR_ERR(fscache);
>   
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 125e4aa8d295..fded736bc3d5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -570,7 +570,7 @@ int erofs_fscache_register_fs(struct super_block *sb);
>   void erofs_fscache_unregister_fs(struct super_block *sb);
>   
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags);
> +						    char *name);
>   void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
>   #else
>   static inline int erofs_fscache_register_fs(struct super_block *sb)
> @@ -581,7 +581,7 @@ static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
>   
>   static inline
>   struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
> -					char *name, unsigned int flags)
> +						    char *name)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..8706ca34f26a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -244,7 +244,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   	}
>   
>   	if (erofs_is_fscache_mode(sb)) {
> -		fscache = erofs_fscache_register_cookie(sb, dif->path, 0);
> +		fscache = erofs_fscache_register_cookie(sb, dif->path);
>   		if (IS_ERR(fscache))
>   			return PTR_ERR(fscache);
>   		dif->fscache = fscache;
