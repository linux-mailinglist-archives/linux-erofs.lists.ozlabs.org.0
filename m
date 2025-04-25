Return-Path: <linux-erofs+bounces-232-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF1A9BCAE
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Apr 2025 04:15:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZkGf33hjcz2y8t;
	Fri, 25 Apr 2025 12:15:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745547339;
	cv=none; b=kIEOz/XWbPIhZIEdrAb5OnGY9cULs4cFvrZxlz+wXBHtddp5HDdXsMjZ1/R4xenN6N6B6MuvhtFGFE8+35Eu6GHZSJfF3krmsjpnWOr9V0MmtfCBMdSnDM1AfFykEvitCDqQlUflCjnPWVTVVABGkxKmlpJzjPOYv2ig8njQTmkZTQfuT9pzTK7h9Km1L5cmjf8aCDZ1Zh278XGkP42ZGQH96ixo1VFZq0vPeDLV0UrfQe/EzJFZ7GGw1si8rzYOy5bluYThDzp6V72Z63cMd1oR5P0ry9pEdya0U5edzhWESVoH99H303GEWQRRTO7K5b+iz4ffZUx+J7nNioih+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745547339; c=relaxed/relaxed;
	bh=NX2KtSdXT2BGhQIhO6c7pfLCiJJYxxTzng56KAAJZNM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=axua9GlzkZzAiz3v2nNZztzgk1IZlQ46TfY26Q1zAQG49sorNwTJU7ZFIXyPuO+6bP++BdvL2njExjx1cglfmyS9QYSV4hyjkmOpxdgb4Tji47B1tF9zaEkMYDysGF7IFehD3uo9Bv989Ksr1uXGgPPYKIUvTSZSv6Ny0n0ho4Swow1cLYf3uzJjLqr6TkBqpOFOEpfwYqeG4qkqNQWXW2BkhZXnFOZKIiXnQmQZD+Sa/OZGBES5cy2mc5J/YmZWFIYH/97zHSJhmwdAtM4TlJdqs+b/I7MLMna1D5OyNiyNdcZjqaDpfa/O+uJ/DUOC4wS0NDLEwehJSDa3yGgLqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gKrdOTeY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gKrdOTeY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZkGf200zGz2xs7
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Apr 2025 12:15:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CDE0344209;
	Fri, 25 Apr 2025 02:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99738C4CEE3;
	Fri, 25 Apr 2025 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547335;
	bh=c+MeKZSECjvZGJrBH9cgxMygC8mpb5MUZDEn3oLaRk4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gKrdOTeYlgJ33eACTcOzqWwCkxouez8RUD+GiyAR19KtT5qkO6AVjohyLGmEZMEOG
	 9G4kpR9O+AoQXwEBX6VzoEAzoK5cHbd7XZ72QaUhly69EKSuXMWQ1CqDD28QKgXm73
	 51DDuE0AxT2JeF1CufJpI/wX/EyeMfH91n3ELFLCTxpjd1W1yVgXK9XIr54sfsf702
	 IIbKkeCV4mPEdRWBbb+d5rGM2wakpllCbPXi6Hwj7GHRlP/RuqSQVOmegdp6dzr7kD
	 TE+8Hs/Y3ZTb3Sqca4Y5Vottmy0dLrW/+EDFMQgF0Uw/XLEpBNVEixNnIMOH1MWClT
	 sOCQ8Tj4HixgA==
Message-ID: <894ca2d3-e680-4395-9887-2b6060fc8096@kernel.org>
Date: Fri, 25 Apr 2025 10:15:31 +0800
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
Cc: chao@kernel.org, hsiangkao@linux.alibaba.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250423061023.131354-1-dhavale@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250423061023.131354-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 4/23/25 14:10, Sandeep Dhavale wrote:
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
> v3: https://lore.kernel.org/linux-erofs/20250422234546.2932092-1-dhavale@google.com/
> Changes since v3:
> - fold z_erofs_init_pcpu_workers() in the caller and rename the caller
> 
>  fs/erofs/zdata.c | 61 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..647a8340c9a1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -291,6 +291,9 @@ static struct workqueue_struct *z_erofs_workqueue __read_mostly;
>  
>  #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
>  static struct kthread_worker __rcu **z_erofs_pcpu_workers;
> +static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
> +static int erofs_cpu_hotplug_init(void);
> +static void erofs_cpu_hotplug_destroy(void);
>  
>  static void erofs_destroy_percpu_workers(void)
>  {
> @@ -336,9 +339,40 @@ static int erofs_init_percpu_workers(void)
>  	}
>  	return 0;
>  }
> +
> +static int z_erofs_init_pcpu_workers(void)
> +{
> +	int err;
> +
> +	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
> +		return 0;
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
> +	erofs_destroy_percpu_workers();
> +err_init_percpu_workers:
> +	atomic_set(&erofs_percpu_workers_initialized, 0);
> +	return err;
> +}

- mount #1				- mount #2
 - z_erofs_init_pcpu_workers
  - atomic_xchg(, 1)
					 - z_erofs_init_pcpu_workers
					  - atomic_xchg(, 1)
					  : return 0 since atomic variable is 1
					  it will run w/o percpu workers and hotplug
  : update atomic variable to 1
  - erofs_init_percpu_workers
  : fail
  - atomic_set(, 0)
  : update atomic variable to 0 & fail the mount

Can we add some logs to show we succeed/fail to initialize workers or
hotplugs? As for mount #2, it expects it will run w/ them, but finally
it may not. So we'd better have a simple way to know?

Thanks,

> +
> +static void z_erofs_destroy_pcpu_workers(void)
> +{
> +	if (!atomic_xchg(&erofs_percpu_workers_initialized, 0))
> +		return;
> +	erofs_cpu_hotplug_destroy();
> +	erofs_destroy_percpu_workers();
> +}
>  #else
> -static inline void erofs_destroy_percpu_workers(void) {}
> -static inline int erofs_init_percpu_workers(void) { return 0; }
> +static inline int z_erofs_init_pcpu_workers(void) { return 0; }
> +static inline void z_erofs_destroy_pcpu_workers(void) {}
>  #endif
>  
>  #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_EROFS_FS_PCPU_KTHREAD)
> @@ -405,8 +439,7 @@ static inline void erofs_cpu_hotplug_destroy(void) {}
>  
>  void z_erofs_exit_subsystem(void)
>  {
> -	erofs_cpu_hotplug_destroy();
> -	erofs_destroy_percpu_workers();
> +	z_erofs_destroy_pcpu_workers();
>  	destroy_workqueue(z_erofs_workqueue);
>  	z_erofs_destroy_pcluster_pool();
>  	z_erofs_exit_decompressor();
> @@ -430,19 +463,8 @@ int __init z_erofs_init_subsystem(void)
>  		goto err_workqueue_init;
>  	}
>  
> -	err = erofs_init_percpu_workers();
> -	if (err)
> -		goto err_pcpu_worker;
> -
> -	err = erofs_cpu_hotplug_init();
> -	if (err < 0)
> -		goto err_cpuhp_init;
>  	return err;
>  
> -err_cpuhp_init:
> -	erofs_destroy_percpu_workers();
> -err_pcpu_worker:
> -	destroy_workqueue(z_erofs_workqueue);
>  err_workqueue_init:
>  	z_erofs_destroy_pcluster_pool();
>  err_pcluster_pool:
> @@ -644,10 +666,17 @@ static const struct address_space_operations z_erofs_cache_aops = {
>  
>  int z_erofs_init_super(struct super_block *sb)
>  {
> -	struct inode *const inode = new_inode(sb);
> +	struct inode *inode;
> +	int err;
>  
> +	err = z_erofs_init_pcpu_workers();
> +	if (err)
> +		return err;
> +
> +	inode = new_inode(sb);
>  	if (!inode)
>  		return -ENOMEM;
> +
>  	set_nlink(inode, 1);
>  	inode->i_size = OFFSET_MAX;
>  	inode->i_mapping->a_ops = &z_erofs_cache_aops;


