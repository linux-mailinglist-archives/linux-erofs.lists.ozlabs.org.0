Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 13152764E95
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 11:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690448844;
	bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gf61Hb7nrqXFlU6pDOTdW26kcKj96mlvcPf3xb8wMzTRDLUAWx6Hw6mO+WPrhmOHN
	 bXQ7QCEpAZsJUdgldyYmDBK4KGtkuipo3rZ34M9PMVVfXNW+SBJvccovIVahVvoXnX
	 F8vHBy6/a5wonh7qx41Z0l8+rQaHVLzYMZzzJ7aRF5EAy6nRlLdxjdcZAkOL0gMryH
	 xqNBw326ABrRPGw4Zkgp70gUZJXwssvyVA67gN0sw/3e28gCR/8EdRz9/iWQGqpjZI
	 hfVPGlJOcy2Q+TKsW5QJ3xH7v0CcNi0JZuJczrCPbGOU8xNAPogZbRwFFMOjQiMkEW
	 NzzkryIpVJBWw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBPzb6vcDz3cCr
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 19:07:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DjrROq91;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBPzV0Dx1z3c37
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 19:07:15 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2659b1113c2so145047a91.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 02:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448833; x=1691053633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=;
        b=eAdBlBp99hcdME7drP9taOyxXsZbIUoy/HDTuctMPO0dl3Wfulc2cwdGWOUg8L56eI
         x3N2yHrs6F/HGqKzayIFLbkvKvvgTkrX+fBjPmR/xZbNchQ92e5lhy1oO6S+vrGL+Fa3
         OxtYt9Punx4M2MeW8dIoDYD3tb+yIdOfdxVhYWODZkAejozEeZZKXwUUxlsVNYXqmpxZ
         Qj5cLxbQb+9nQhozlbCPKATxiiTY01Ef6/dkR5heCKXQWMLKWBzcRJx5oeBriQeP3/EX
         a8morPeHgVb9BnPhmAqDlvaXxrTn5fBttLK89Bj6O4UEqbVt7584y1ZXXVq6bohSGvJ0
         x17Q==
X-Gm-Message-State: ABy/qLbmiMf3vOHVhMD4Lc2+8mcAzjUcl355dpIjlQFpoKfvY+884RbG
	CH3rTbreyOa+fFYX7gEY7rQNDA==
X-Google-Smtp-Source: APBJJlEquEzidizjgrmS1e55j2UU3CMKKyxPnlaVqAXQYQ+ePfvdxx8A4f9JU/BbmCjGKzVhoGuchQ==
X-Received: by 2002:a17:90a:128e:b0:263:25f9:65b2 with SMTP id g14-20020a17090a128e00b0026325f965b2mr4139877pja.4.1690448832920;
        Thu, 27 Jul 2023 02:07:12 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902ee8b00b001b7e63cfa19sm1063627pld.234.2023.07.27.02.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:07:12 -0700 (PDT)
Message-ID: <19461737-db63-2ab5-110b-e65035881ae2@bytedance.com>
Date: Thu, 27 Jul 2023 17:06:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/49] nfs: dynamically allocate the nfs-acl shrinker
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-16-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-16-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/27 16:04, Qi Zheng wrote:
> Use new APIs to dynamically allocate the nfs-acl shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   fs/nfs/super.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 2284f749d892..072d82e1be06 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
>   }
>   #endif /* CONFIG_NFS_V4_2 */
>   
> -static struct shrinker acl_shrinker = {
> -	.count_objects	= nfs_access_cache_count,
> -	.scan_objects	= nfs_access_cache_scan,
> -	.seeks		= DEFAULT_SEEKS,
> -};
> +static struct shrinker *acl_shrinker;
>   
>   /*
>    * Register the NFS filesystems
> @@ -153,9 +149,17 @@ int __init register_nfs_fs(void)
>   	ret = nfs_register_sysctl();
>   	if (ret < 0)
>   		goto error_2;
> -	ret = register_shrinker(&acl_shrinker, "nfs-acl");
> -	if (ret < 0)
> +
> +	acl_shrinker = shrinker_alloc(0, "nfs-acl");
> +	if (!acl_shrinker)
>   		goto error_3;

Here should set ret to -ENOMEM, will fix.

> +
> +	acl_shrinker->count_objects = nfs_access_cache_count;
> +	acl_shrinker->scan_objects = nfs_access_cache_scan;
> +	acl_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(acl_shrinker);
> +
>   #ifdef CONFIG_NFS_V4_2
>   	nfs_ssc_register_ops();
>   #endif
> @@ -175,7 +179,7 @@ int __init register_nfs_fs(void)
>    */
>   void __exit unregister_nfs_fs(void)
>   {
> -	unregister_shrinker(&acl_shrinker);
> +	shrinker_free(acl_shrinker);
>   	nfs_unregister_sysctl();
>   	unregister_nfs4_fs();
>   #ifdef CONFIG_NFS_V4_2
