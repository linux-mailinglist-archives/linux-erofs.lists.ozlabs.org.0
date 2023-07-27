Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06631764F1C
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 11:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690449365;
	bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CnFDHVGsY5ke/kRb40qTLu5SROO73mq9siDe9az8NyzDNGdXujAdoRTIIsnWMHUtw
	 1uD4qR6Kx0LTd0IwBfT7SFIuBazsNVGklnaVvnFvF7H0ucJz9Kx5IahCkEtMGLlaGZ
	 lfD1rXE4g52LB9PygvAEwrLCZGAIr00xGlZUGgOXuijvbtF1FcXZI+8A5T8/SPKofA
	 g2GAZCdnXVXDtdfvoo3Ev+JxJLwbCwSyvCnTBaOXPZkwovmGuaBSrK+XYMyyjOYraP
	 tg5kmgS5VvQC68L09JKr/AgD9Nlij/uyHF5sEaDHd7qjPfGheP1xndVhB1e/31x/BB
	 p0KaGMUIyZeew==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBQ9d6QFqz3cCj
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 19:16:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=gs/PU4tG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBQ9Z1y0Cz30F5
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 19:16:01 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56366112d64so76445a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 02:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449359; x=1691054159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=;
        b=cNs/WxB8jM9pfA1pbVDYTpqyIOBDjYLiJ9VyfF0c/58wSCHYTnzjbUSvojjYygLNwC
         mYC1hI+I3/ZlwsyAJtn8hCeljdzZggwFJXXI26Y+mijbJzrLABOsazVj986ZGl4IJdeF
         qEzZEJ536z+8ttjtBFlp/op3azCNJLFH2039PDuz8jIdM39k1tQeEsuYILRH6cH1DD+8
         UerqFuT7OpqGnWUr0RTL2IubUcMHV14aSqtOrEBxv9Te6x6MxFQ5L3MOXTiI6yG/Q5Lz
         zGMhuxBlW+SxVPKQUYUU3ddGLpwanIqm7QWWNHucdWSuB7gbpbiVYKLDTWtp8a5hrpGD
         LjKQ==
X-Gm-Message-State: ABy/qLas3F4xeX4WHgbbySvPPHf7dWwEZwNqJNFoM429Y8nKIa8Q1Xbx
	g0TVS9BLiCgXEVyXhzWfyr3/cw==
X-Google-Smtp-Source: APBJJlFWNasuQyGNPy0hcIGkgu46yCpujoddgwDeBo2nmYNJTDqcdO/STO03uju2nKSJGm9+FY3b7g==
X-Received: by 2002:a17:90a:7c48:b0:268:38a7:842e with SMTP id e8-20020a17090a7c4800b0026838a7842emr4155117pjl.2.1690449358970;
        Thu, 27 Jul 2023 02:15:58 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id bv21-20020a17090af19500b0026596b8f33asm2403500pjb.40.2023.07.27.02.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:15:58 -0700 (PDT)
Message-ID: <8f8aa0d6-8f5c-958d-096d-d4c6d3e71e7a@bytedance.com>
Date: Thu, 27 Jul 2023 17:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 29/49] md/raid5: dynamically allocate the md-raid5
 shrinker
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-30-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-30-zhengqi.arch@bytedance.com>
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
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the md-raid5 shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct r5conf.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   drivers/md/raid5.c | 25 ++++++++++++++-----------
>   drivers/md/raid5.h |  2 +-
>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 85b3004594e0..fbb4e6f5ff43 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7414,7 +7414,7 @@ static void free_conf(struct r5conf *conf)
>   
>   	log_exit(conf);
>   
> -	unregister_shrinker(&conf->shrinker);
> +	shrinker_free(conf->shrinker);
>   	free_thread_groups(conf);
>   	shrink_stripes(conf);
>   	raid5_free_percpu(conf);
> @@ -7462,7 +7462,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
>   static unsigned long raid5_cache_scan(struct shrinker *shrink,
>   				      struct shrink_control *sc)
>   {
> -	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
> +	struct r5conf *conf = shrink->private_data;
>   	unsigned long ret = SHRINK_STOP;
>   
>   	if (mutex_trylock(&conf->cache_size_mutex)) {
> @@ -7483,7 +7483,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
>   static unsigned long raid5_cache_count(struct shrinker *shrink,
>   				       struct shrink_control *sc)
>   {
> -	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
> +	struct r5conf *conf = shrink->private_data;
>   
>   	if (conf->max_nr_stripes < conf->min_nr_stripes)
>   		/* unlikely, but not impossible */
> @@ -7718,18 +7718,21 @@ static struct r5conf *setup_conf(struct mddev *mddev)
>   	 * it reduces the queue depth and so can hurt throughput.
>   	 * So set it rather large, scaled by number of devices.
>   	 */
> -	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
> -	conf->shrinker.scan_objects = raid5_cache_scan;
> -	conf->shrinker.count_objects = raid5_cache_count;
> -	conf->shrinker.batch = 128;
> -	conf->shrinker.flags = 0;
> -	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
> -	if (ret) {
> -		pr_warn("md/raid:%s: couldn't register shrinker.\n",
> +	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
> +	if (!conf->shrinker) {

Here should set ret to -ENOMEM, will fix.

> +		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
>   			mdname(mddev));
>   		goto abort;
>   	}
>   
> +	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
> +	conf->shrinker->scan_objects = raid5_cache_scan;
> +	conf->shrinker->count_objects = raid5_cache_count;
> +	conf->shrinker->batch = 128;
> +	conf->shrinker->private_data = conf;
> +
> +	shrinker_register(conf->shrinker);
> +
>   	sprintf(pers_name, "raid%d", mddev->new_level);
>   	rcu_assign_pointer(conf->thread,
>   			   md_register_thread(raid5d, mddev, pers_name));
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index 97a795979a35..22bea20eccbd 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -670,7 +670,7 @@ struct r5conf {
>   	wait_queue_head_t	wait_for_stripe;
>   	wait_queue_head_t	wait_for_overlap;
>   	unsigned long		cache_state;
> -	struct shrinker		shrinker;
> +	struct shrinker		*shrinker;
>   	int			pool_size; /* number of disks in stripeheads in pool */
>   	spinlock_t		device_lock;
>   	struct disk_info	*disks;
