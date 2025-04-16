Return-Path: <linux-erofs+bounces-203-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5BA8AD88
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Apr 2025 03:22:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zcjtd3VtMz3blC;
	Wed, 16 Apr 2025 11:22:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744766537;
	cv=none; b=HH2odW2VFoOX9FIVUT/bBIS1brBnH8hpdhJAdEZrPRp51iRvKGJj+dc5G3oYsw2nq5NtzBadOojL6JnjsqiyepOdriUVMmLKhjDxMPBmndJWjj+aWhebXM21J51bqVx5FfffvlLbFuRXSZDY/cT7nWdKAghYe6isqtXrVy5c8Az+jV96NfrWXOGfVyGdBRtIiem1VEzrLt/xanKJVHW1Tw+atzx1Nc5rab2cLU0axHurVKByF8il1VcpuWg4pBPCQzHYsFdh3Bf45Vq0sZxKSq35VDPShi1MWChuRn+UJnNe3GJFHqwQCB2hwR1ScV4VezIFiJ5K60mCTaDoPZ8MyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744766537; c=relaxed/relaxed;
	bh=S+gSHUgnZJkpNQEKAUzU8Rgqjm+4Add/shFYdufCnCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMq/NC56ThBzOh8p3MKwKMbKJlgNE8TCA2485NT3rS3gjKs+wMXPDHjHyEoYiaFDR7mk26m2EvXjXNg0QNeqsgGsVFwnQxCzsLt8TEJVYMjJ3ZbjNZf001a5nLHawcD3rixKBWUtMuCslYghrOP1voSC5cftipo0SgirQbGsybs8/JKUDuDJ/ust88XyJOKCjtsmMtADc4VMPjRip/AIhHLYc/NORNmua86MF0LAABQoLY98OPfBCoVhNEwdODjtI/UxgpeaxzRqKLPUAnqMI1NgRBObH6fmk7+DjreWogZNU46wlmY1aRbMWsSQpC10w5XGMq38sm8NSLPYQ0VI+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZGv0qAEb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZGv0qAEb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zcjtb1pFHz3bkG
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Apr 2025 11:22:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744766529; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S+gSHUgnZJkpNQEKAUzU8Rgqjm+4Add/shFYdufCnCM=;
	b=ZGv0qAEb+m439MJrk9UtfFszgYekavOh323gFVAsXI/cgM2gquDk84uCP3QxSvIYmcCjSKXtPNrtjYk9kNTBCaWjDPg7Tggl8igJ1a6P43RlAlNuQ/gaRsUMvZb1XXvmpVjU2DsulWB82GJRiatIZL/tv6JzwP2DtjblHYhWIXA=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WX6j.0Y_1744766526 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Apr 2025 09:22:07 +0800
Message-ID: <a1e86463-3427-4715-a4a2-0ef88cca6135@linux.alibaba.com>
Date: Wed, 16 Apr 2025 09:22:06 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250402202728.2157627-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250402202728.2157627-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,

On 2025/4/3 04:27, Sandeep Dhavale wrote:
> Currently, when EROFS is built with per-CPU workers, the workers are
> started and CPU hotplug hooks are registered during module initialization.
> This leads to unnecessary worker start/stop cycles during CPU hotplug
> events, particularly on Android devices that frequently suspend and resume.
> 
> This change defers the initialization of per-CPU workers and the
> registration of CPU hotplug hooks until the first EROFS mount. This
> ensures that these resources are only allocated and managed when EROFS is
> actually in use.
> 
> The tear down of per-CPU workers and unregistration of CPU hotplug hooks
> still occurs during z_erofs_exit_subsystem(), but only if they were
> initialized.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/20250331022011.645533-2-dhavale@google.com/
> Changes since v1:
> - Get rid of erofs_mount_count based init and tear down of resources
> - Initialize resource in z_erofs_init_super() as suggested by Gao
> - Introduce z_erofs_init_workers_once() and track it using atomic bool
> - Improve commit message
> 
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/zdata.c    | 57 ++++++++++++++++++++++++++++++++++-----------
>   2 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4ac188d5d894..bbc92ee41846 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -450,6 +450,7 @@ int z_erofs_gbuf_growsize(unsigned int nrpages);
>   int __init z_erofs_gbuf_init(void);
>   void z_erofs_gbuf_exit(void);
>   int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
> +int z_erofs_init_workers_once(void);
>   #else
>   static inline void erofs_shrinker_register(struct super_block *sb) {}
>   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> @@ -458,6 +459,7 @@ static inline void erofs_exit_shrinker(void) {}
>   static inline int z_erofs_init_subsystem(void) { return 0; }
>   static inline void z_erofs_exit_subsystem(void) {}
>   static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
> +static inline int z_erofs_init_workers_once(void) { return 0; };

Why we need this? I think it's unused if decompression
subsystem is disabled.

>   #endif	/* !CONFIG_EROFS_FS_ZIP */
>   
>   #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..75f0adcff97b 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -11,6 +11,7 @@
>   
>   #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
>   #define Z_EROFS_INLINE_BVECS		2
> +static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
>   
>   struct z_erofs_bvec {
>   	struct page *page;
> @@ -403,10 +404,44 @@ static inline int erofs_cpu_hotplug_init(void) { return 0; }
>   static inline void erofs_cpu_hotplug_destroy(void) {}

I wonder those helpers are still needed since we have
z_erofs_init_pcpu_workers().

>   #endif
>   
> -void z_erofs_exit_subsystem(void)
> +static int z_erofs_init_workers(void)

I think we need to rename it as
`static int z_erofs_init_pcpu_workers(void)`

>   {
> -	erofs_cpu_hotplug_destroy();
> +	int err;
> +
> +	err = erofs_init_percpu_workers();
> +	if (err)
> +		goto err_init_percpu_workers;
> +
> +	err = erofs_cpu_hotplug_init();
> +	if (err < 0)
> +		goto err_cpuhp_init;
> +	return err;
> +
> +err_cpuhp_init:
>   	erofs_destroy_percpu_workers();
> +err_init_percpu_workers:
> +	atomic_set(&erofs_percpu_workers_initialized, 0);
> +	return err;
> +}
> +
> +int z_erofs_init_workers_once(void)

I'd like to inline them into z_erofs_init_super().

> +{
> +	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
> +		return 0;
> +	return z_erofs_init_workers();
> +}
> +
> +static void z_erofs_destroy_workers(void)

z_erofs_destroy_pcpu_workers()

> +{
> +	if (atomic_xchg(&erofs_percpu_workers_initialized, 0)) {

	if (atomic_xchg(&erofs_percpu_workers_initialized, 0))
		return;

> +		erofs_cpu_hotplug_destroy();
> +		erofs_destroy_percpu_workers();
> +	}
> +}
> +
> +void z_erofs_exit_subsystem(void)
> +{
> +	z_erofs_destroy_workers();
>   	destroy_workqueue(z_erofs_workqueue);
>   	z_erofs_destroy_pcluster_pool();
>   	z_erofs_exit_decompressor();
> @@ -430,19 +465,8 @@ int __init z_erofs_init_subsystem(void)
>   		goto err_workqueue_init;
>   	}
>   
> -	err = erofs_init_percpu_workers();
> -	if (err)
> -		goto err_pcpu_worker;
> -
> -	err = erofs_cpu_hotplug_init();
> -	if (err < 0)
> -		goto err_cpuhp_init;
>   	return err;
>   
> -err_cpuhp_init:
> -	erofs_destroy_percpu_workers();
> -err_pcpu_worker:
> -	destroy_workqueue(z_erofs_workqueue);
>   err_workqueue_init:
>   	z_erofs_destroy_pcluster_pool();
>   err_pcluster_pool:
> @@ -645,6 +669,13 @@ static const struct address_space_operations z_erofs_cache_aops = {
>   int z_erofs_init_super(struct super_block *sb)
>   {
>   	struct inode *const inode = new_inode(sb);
> +	int err;

	struct inode *inode;
	int err;

	err = z_erofs_init_workers_once();
	if (err)
		return err;
	inode = new_inode(sb);
	...

> +
> +	err = z_erofs_init_workers_once();
> +	if (err) {
> +		iput(inode);

To avoid such unnecessary iput() here...

Thanks,
Gao Xiang

