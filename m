Return-Path: <linux-erofs+bounces-223-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 24092A99F27
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 05:03:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjglP0TQMz2yFQ;
	Thu, 24 Apr 2025 13:03:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745463792;
	cv=none; b=P6r8NrTxyHzCrd2kmJapa9uQ5wZb/PAZ3eC0ao8A9fF907WJRCpvHR8E3kvlFDTAI/mGUw25q14NeaXPWHQ6KxKlHv9rjn3blZwlMhvcsbisg++tgG9Rqp2hqkk4zIyJcLy807JeLdi5u78RZ7LQWnjwyYctr7WgCLI9NZw7uN6fRSTVQzbMQxTyXdsfzhI9KGOgvOrCZ2ds7kF1RarB0UmYaMx3pzx3YKqD9HiU5xHlmM9UvU8CnELsLpWStZoC6m4KbVHQUhzZaylGroZFT5sJECb1nNSx6MP8BIOZp+lOpw1GpFm2g94fQSV3fl7zPwDoFzgujM11PUKQB0kA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745463792; c=relaxed/relaxed;
	bh=oXVbyLoxNFFCXlJCXI2zBVdSpM7dKm82BqXpDewh/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SHfAPkb9e02+l7I7vPv1gGGPbXgDjlOPJ1m9LF5TJocqocWEkRbrnWclAaQ8zoafYHv1vvfthMUJXQO/jcQU/SQyVkvRxzzG5yCoXqIXA0zA2VcKWIBscHY57hC4HD0BAQjgZYevxkWvZk6jPyL1aGK5qzgows7E6KzXbUx/knEjSCxlsxs6zAkVNJu8eKXveMb3DLP7UiEijcfpG29fMgcn53P8BfeddFS5I2DNdwDiBnMdav4NMMM8wdVTKpn0sQvGzoR+Eh7ODgPCle6IWldbr5js4mzieL37ICsTBme0wxEhJ/jk2ckg3w/1n+QaDZM/sCMNZ1oeBut6a3P0uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjglM1hPhz2xRv
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 13:03:09 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zjghw5n3Yz1R7YM
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 11:01:04 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D0B5918005F
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 11:03:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 11:03:04 +0800
Message-ID: <b37750dd-9496-4adf-89a9-06f4c77e9680@huawei.com>
Date: Thu, 24 Apr 2025 11:03:03 +0800
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
Subject: Re: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20250423061023.131354-1-dhavale@google.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250423061023.131354-1-dhavale@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/23 14:10, Sandeep Dhavale wrote:
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
>   fs/erofs/zdata.c | 61 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..647a8340c9a1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -291,6 +291,9 @@ static struct workqueue_struct *z_erofs_workqueue __read_mostly;
>   
>   #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
>   static struct kthread_worker __rcu **z_erofs_pcpu_workers;
> +static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
> +static int erofs_cpu_hotplug_init(void);
> +static void erofs_cpu_hotplug_destroy(void);
>   
>   static void erofs_destroy_percpu_workers(void)
>   {
> @@ -336,9 +339,40 @@ static int erofs_init_percpu_workers(void)
>   	}
>   	return 0;
>   }
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
> +
> +static void z_erofs_destroy_pcpu_workers(void)
> +{
> +	if (!atomic_xchg(&erofs_percpu_workers_initialized, 0))
> +		return;
> +	erofs_cpu_hotplug_destroy();
> +	erofs_destroy_percpu_workers();
> +}
>   #else
> -static inline void erofs_destroy_percpu_workers(void) {}
> -static inline int erofs_init_percpu_workers(void) { return 0; }
> +static inline int z_erofs_init_pcpu_workers(void) { return 0; }
> +static inline void z_erofs_destroy_pcpu_workers(void) {}
>   #endif
>   
>   #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_EROFS_FS_PCPU_KTHREAD)
> @@ -405,8 +439,7 @@ static inline void erofs_cpu_hotplug_destroy(void) {}
>   
>   void z_erofs_exit_subsystem(void)
>   {
> -	erofs_cpu_hotplug_destroy();
> -	erofs_destroy_percpu_workers();
> +	z_erofs_destroy_pcpu_workers();
>   	destroy_workqueue(z_erofs_workqueue);
>   	z_erofs_destroy_pcluster_pool();
>   	z_erofs_exit_decompressor();
> @@ -430,19 +463,8 @@ int __init z_erofs_init_subsystem(void)
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
> @@ -644,10 +666,17 @@ static const struct address_space_operations z_erofs_cache_aops = {
>   
>   int z_erofs_init_super(struct super_block *sb)
>   {
> -	struct inode *const inode = new_inode(sb);
> +	struct inode *inode;
> +	int err;
>   
> +	err = z_erofs_init_pcpu_workers();
> +	if (err)
> +		return err;
> +
This will slow down the first mount action, but it seems unavoidable for 
now. :)

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> +	inode = new_inode(sb);
>   	if (!inode)
>   		return -ENOMEM;
> +
>   	set_nlink(inode, 1);
>   	inode->i_size = OFFSET_MAX;
>   	inode->i_mapping->a_ops = &z_erofs_cache_aops;

