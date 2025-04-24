Return-Path: <linux-erofs+bounces-220-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E04A99D08
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Apr 2025 02:31:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjcNk4mrrz30HB;
	Thu, 24 Apr 2025 10:31:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745454710;
	cv=none; b=Y4wLO//A64S01bcY0TsNrYH0UcSSyYzQrzwgIRYS7iJGIGArSNNvYhU+5lCH6n3W+5wqsCWCnNmBSBSawnDbCzxQaw0l7jad+z/xs+64WGKsF2veGuLoBA5OYbZCnNeQ1Wuk9yMR4WXWEv+z1byCqph0Is3owB4+IC6UJo/LiIq8fQQqoHmwzLcPFWaIDxI1BCnINd/zk2pi082nrwKhNuztAg9v6Ar9qJCbKu2Wc8WfPAnMfqdpoOTPPN26LJpvWm7J6HiJ7E/fCcrT+M4hWEpoFiraqj72SVf2WMGP39t6wixx1IR8riENYax3DGIILL092d3ZL188Il+E34iv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745454710; c=relaxed/relaxed;
	bh=c8ZCQX8M22/L+jhRyOZyyKQ/yi6W0hwrq83O3s9SBSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPFP+AsNkamquWdQGV5quKevtJ2kiKXt1qdvm9YrJfujxuhTDDjWE0afHpgSTMALZT3cvGe0AOQ1Heus1LEAfcemZ45jqCuWsDfp3ZhoHdRLU0djlZsplIWDbuWGPHZ3CK7f5DCYfztD5cIOgUN3BUw5nCYLdK9OnVwDGVGa7ccW/1WBDfJUyak8V/Jb3mGhu32ccf5hiwmPqLKRSOdW3DVhGerQygnEFcBF2YGicV9I9dfCgU9Bw2Na5PvRlwHYf/ZguBIzULrvSLda8H5octiLvupbTNPxDPoZrD04vJCS9ENRL05dKCLJQFZZNh4OU8JthPs5tRGGnRq7Z/PwSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pXPx8hNx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pXPx8hNx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjcNj4gyJz2ykX
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Apr 2025 10:31:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745454705; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=c8ZCQX8M22/L+jhRyOZyyKQ/yi6W0hwrq83O3s9SBSE=;
	b=pXPx8hNxYFNmpvsLdMss92Pu7HcUCEq7QvPYcDShlg2Usqasmv2Fx4NHqjufcO3NTQOl6aioZ/6Dn2kxX1JpLdZ9k+FVXH/8XSlorqnH2DQCQTyOzpwy5sPyR0KUx4UTW8MtJkCaqn9A2LqArJTZcP6VIm5lIm6Wd34cdEjXlP8=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WXw4zKR_1745454703 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 08:31:43 +0800
Message-ID: <94c702b9-cad5-4727-a7f1-16de1827841e@linux.alibaba.com>
Date: Thu, 24 Apr 2025 08:31:42 +0800
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
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20250423061023.131354-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250423061023.131354-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

> ---

...

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
> +	inode = new_inode(sb);
>   	if (!inode)
>   		return -ENOMEM;
> +

I think the new blank line is redundant, the setup part
should be next to new_inode().

I could fix up this part manually if you don't have strong
opinion on this.

Thanks,
Gao Xiang

