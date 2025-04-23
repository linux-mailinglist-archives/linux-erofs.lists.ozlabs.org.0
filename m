Return-Path: <linux-erofs+bounces-215-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880BA97DA4
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 06:01:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zj54W708sz2yMD;
	Wed, 23 Apr 2025 14:00:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745380859;
	cv=none; b=O7kisDrtQRLLSkSIrUEhFalg0jMbPoiHzVGdv0mvs+QBVQSYdh8t8M6+Mqdhpyv8eNo6KF46feh3ZoKxtBeWwAPxiWKAXMls7aS+jWXjAQQaJ1xKbmtpGRLJ0ljKd6YN7eIN5uvILEhV7Wj/kyvyQV59kaB9FAORrrMi9t0tyQkcCy4buyWFHFozbi21y2/RuUQ+PWfCzKnBGa6EG1PzQiXbA+7uuLYjd2BBz491t997pWUJRTjgBUEaxgCeVIPGvlwHzBtzCsLfXTSUCkCrGsXD/fIDK50znmObhcHCsdxjNrRfUFcqLhUz3rck2FmSrX+bCpx4KRfG81OziqZejg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745380859; c=relaxed/relaxed;
	bh=QciegOL47TkkCG+QP7o5Gjgw8odD30EiR0x2AoVa48I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFGmsMNW2A0VX3VYOcpmEn2U2RZE6+FUYLaZINZ+ObYva3JIC9QCp56ZjQi1cRY4AC1kZpOjUExsxi48LiUQEEaKkZVfWWaXuHVW29rAxEQBFTQsXLWfX+uLRjTOtJ0orKqcfDSQT0iitkxkB6LYXgyfCPQ+baF1vlHKlgadwMuNSzXeC0anYKZbjvJoTIDeRBA+5PQdYntyJ86pnbRwWws8lsbwaasdkCCA0l4/aIFrnM8CV/yvg5CnIkLThw0JgezFGvwQP/+fBn9Ln4QGBW2anlryM5Ow0IvG9cNI7MXG/QtAnFTu09Lt2qo6HDPT/4sttNlm/wy4dbqtw+5qDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nhUuotwf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nhUuotwf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zj54T5kpSz2xlK
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 14:00:56 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745380852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QciegOL47TkkCG+QP7o5Gjgw8odD30EiR0x2AoVa48I=;
	b=nhUuotwfmU6TWQYnnDSFOx92OKigu4aCx+CeJmY/0MNejxczjlEsrEyajihtOoNhEMWCm1eAG2ibXPlL59/9zuxDJsBLYpTGLKwHmKeYUzNwE3L06+ybgs5qvLXAhsGMZsszlI4lY5NheDi+cr5VlQUr1doJ+RHnFKgIAvUw174=
Received: from 30.221.131.33(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXsrHkZ_1745380850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Apr 2025 12:00:50 +0800
Message-ID: <7a433a6f-4c35-493c-94a7-0f925ed52230@linux.alibaba.com>
Date: Wed, 23 Apr 2025 12:00:50 +0800
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
Subject: Re: [PATCH v3] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250422234546.2932092-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250422234546.2932092-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sandeep,

On 2025/4/23 07:45, Sandeep Dhavale wrote:
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
> v2: https://lore.kernel.org/linux-erofs/20250402202728.2157627-1-dhavale@google.com/
> Changes since v2:
> - Renamed functions to use pcpu so it is clear.
> - Removed z_erofs_init_workers_once() declaration from internal.h as
>    there is no need.
> - Removed empty stubs for helpers erofs_init_percpu_workers() and
>    erofs_destroy_percpu_workers().
> - Moved erofs_percpu_workers_initialized under
>    CONFIG_EROFS_FS_PCPU_KTHREAD as further cleanup.
> 
>   fs/erofs/zdata.c | 65 ++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 0671184d9cf1..e12df8b914b6 100644
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
> @@ -336,9 +339,44 @@ static int erofs_init_percpu_workers(void)
>   	}
>   	return 0;
>   }
> +
> +static int z_erofs_init_pcpu_workers(void)

I think you could just fold it in the caller.

> +{
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
> +	erofs_destroy_percpu_workers();
> +err_init_percpu_workers:
> +	atomic_set(&erofs_percpu_workers_initialized, 0);
> +	return err;
> +}
> +
> +static int z_erofs_init_workers_once(void)

and rename it as `z_erofs_init_pcpu_workers()` since
initializing once is just an internal implmentation.

> +{
> +	if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
> +		return 0;
> +	return z_erofs_init_pcpu_workers();
> +}
> +

..

>   err_pcluster_pool:
> @@ -644,10 +670,17 @@ static const struct address_space_operations z_erofs_cache_aops = {
>   
>   int z_erofs_init_super(struct super_block *sb)
>   {
> -	struct inode *const inode = new_inode(sb);
> +	struct inode *inode;
> +	int err;
>   
> +	err = z_erofs_init_workers_once();
> +	if (err)
> +		return err;


Then just call
	err = z_erofs_init_pcpu_workers();
	if (err)
		return err;
here.


Otherwise it looks good to me.

Thanks,
Gao Xiang

