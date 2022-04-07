Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E33EC4F7364
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 05:25:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYmxB6cqDz2ygC
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Apr 2022 13:25:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYmx46Tnlz2xY0
 for <linux-erofs@lists.ozlabs.org>; Thu,  7 Apr 2022 13:25:41 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0V9OcA4p_1649301930; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V9OcA4p_1649301930) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 07 Apr 2022 11:25:33 +0800
Date: Thu, 7 Apr 2022 11:25:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v8 11/20] erofs: add fscache context helper functions
Message-ID: <Yk5ZqX4JkWbyAKdH@B-P7TQMD6M-0146.local>
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
 <20220406075612.60298-12-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-12-jefflexu@linux.alibaba.com>
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

On Wed, Apr 06, 2022 at 03:56:03PM +0800, Jeffle Xu wrote:
> Introduce a context structure for managing data blobs, and helper
> functions for initializing and cleaning up this context structure.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h | 19 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 7a6d0239ebb1..67a3c4935245 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,6 +5,52 @@
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +/*
> + * Create an fscache context for data blob.
> + * Return: 0 on success and allocated fscache context is assigned to @fscache,
> + *	   negative error number on failure.
> + */
> +int erofs_fscache_register_cookie(struct super_block *sb,
> +				  struct erofs_fscache **fscache, char *name)
> +{
> +	struct fscache_volume *volume = EROFS_SB(sb)->volume;
> +	struct erofs_fscache *ctx;
> +	struct fscache_cookie *cookie;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
> +					name, strlen(name), NULL, 0, 0);
> +	if (!cookie) {
> +		erofs_err(sb, "failed to get cookie for %s", name);
> +		kfree(name);
> +		return -EINVAL;
> +	}
> +
> +	fscache_use_cookie(cookie, false);
> +	ctx->cookie = cookie;
> +
> +	*fscache = ctx;
> +	return 0;
> +}
> +
> +void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
> +{
> +	struct erofs_fscache *ctx = *fscache;
> +
> +	if (!ctx)
> +		return;
> +
> +	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
> +	fscache_relinquish_cookie(ctx->cookie, false);
> +	ctx->cookie = NULL;
> +
> +	kfree(ctx);
> +	*fscache = NULL;
> +}
> +
>  int erofs_fscache_register_fs(struct super_block *sb)
>  {
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 952a2f483f94..c6a3351a4d7d 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -97,6 +97,10 @@ struct erofs_sb_lz4_info {
>  	u16 max_pclusterblks;
>  };
>  
> +struct erofs_fscache {
> +	struct fscache_cookie *cookie;
> +};
> +
>  struct erofs_sb_info {
>  	struct erofs_mount_opts opt;	/* options */
>  #ifdef CONFIG_EROFS_FS_ZIP
> @@ -626,9 +630,24 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  int erofs_fscache_register_fs(struct super_block *sb);
>  void erofs_fscache_unregister_fs(struct super_block *sb);
> +
> +int erofs_fscache_register_cookie(struct super_block *sb,
> +				  struct erofs_fscache **fscache, char *name);
> +void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> +
> +static inline int erofs_fscache_register_cookie(struct super_block *sb,
> +						struct erofs_fscache **fscache,
> +						char *name)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
> +{
> +}
>  #endif
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> -- 
> 2.27.0
