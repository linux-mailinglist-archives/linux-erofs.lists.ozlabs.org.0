Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24918760FDC
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 11:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690279017;
	bh=/casiWQBa8FLPDyI/Gjog1Q/iFy65e/7JWaM5Gwrppw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HxLO0Bud6tIZpH5udOdvbzUEpakqbIQ7XDLBd99M8Xr0DmFaDgIdch9OetXyJ/UzM
	 HYWkdtTByVKjSg04wQKQzvv8thgw2ab0Z/whcx7RkcOd4SKe3u9lTNFQVQATDmjH+4
	 2BOtLjAjUHClIZJQsDH9MvsPZPw6ZLNOx/dkOLsq73hZgHydkBMbd39JWgpEtP0EuU
	 JAevnJy9pdg1re5/H6vJCDfpylQY4SmIxpdmUe04NI0MqcsFROG9CJ2iAy4V6Dy/CP
	 ptDyvTNnqAbw3F58L6iwRkkaII4bhTyJw4ezRQEyIsN27nHjyM+/1z7cA1Ptvck+H5
	 W0YSgTcKYqvwg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9C9j0KxBz2yTt
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 19:56:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kzP9jxhd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9C9Z26mgz2xVV
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 19:56:48 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2680edb9767so399430a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 02:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279003; x=1690883803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/casiWQBa8FLPDyI/Gjog1Q/iFy65e/7JWaM5Gwrppw=;
        b=KbmzxuadRaKiTVM0+KMQvwln79EwVmNDhyXkpsGsyZUN8i3jPzfXWZvYyMoGsg3GXK
         VRKIo41fRdwLP2NB7a5ZDYEglghqs8BPvGvhYm+JXs7caG4s+oy8us6n28GFY20v3ZP/
         al3rfx0o2wgQubJrBW4BTZHpWhjN6clW02qVVERATY3ZKSeSQSCV1XC1zza+O9YItu5J
         r396LtyRMjpwIktRR+JA4HJiIlH2h16F0gybJ6vud0VzNlxHHJqGWRcc/r1X5Wpu97Nm
         sr2zoFAffc2ODQAmKPiPfn4dnuc5/WmQMxfW14FSdrZogzXswfL61uMp+XMLCpVZsj63
         k97A==
X-Gm-Message-State: ABy/qLZ6mlxR6P6jrvKD5Vcq/GePGI55CdTz8JlY59rSwCAnJuyNEm+m
	tGXcOxJAY8a+3MhWvOI1jpafpg==
X-Google-Smtp-Source: APBJJlE4g3zxacKAsn4H4YysRKAp71VN9gqUpsqodFXfAXxBRsoAel6FjePiWo+WkUy1agkNvA6LJQ==
X-Received: by 2002:a17:90a:74cf:b0:268:196f:9656 with SMTP id p15-20020a17090a74cf00b00268196f9656mr4627258pjl.1.1690279003192;
        Tue, 25 Jul 2023 02:56:43 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b39ffff838sm10605398plx.25.2023.07.25.02.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:56:42 -0700 (PDT)
Message-ID: <c1a1952f-0c3e-2fa1-fdf9-8b3b8a592b23@bytedance.com>
Date: Tue, 25 Jul 2023 17:56:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
 <3648ca69-d65e-8431-135a-a5738586bc25@linux.dev>
In-Reply-To: <3648ca69-d65e-8431-135a-a5738586bc25@linux.dev>
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
From: Qi Zheng via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, brauner@kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Muchun,

On 2023/7/25 17:02, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> Currently, the shrinker instances can be divided into the following three
>> types:
>>
>> a) global shrinker instance statically defined in the kernel, such as
>>     workingset_shadow_shrinker.
>>
>> b) global shrinker instance statically defined in the kernel modules, 
>> such
>>     as mmu_shrinker in x86.
>>
>> c) shrinker instance embedded in other structures.
>>
>> For case a, the memory of shrinker instance is never freed. For case b,
>> the memory of shrinker instance will be freed after synchronize_rcu() 
>> when
>> the module is unloaded. For case c, the memory of shrinker instance will
>> be freed along with the structure it is embedded in.
>>
>> In preparation for implementing lockless slab shrink, we need to
>> dynamically allocate those shrinker instances in case c, then the memory
>> can be dynamically freed alone by calling kfree_rcu().
>>
>> So this commit adds the following new APIs for dynamically allocating
>> shrinker, and add a private_data field to struct shrinker to record and
>> get the original embedded structure.
>>
>> 1. shrinker_alloc()
>>
>> Used to allocate shrinker instance itself and related memory, it will
>> return a pointer to the shrinker instance on success and NULL on failure.
>>
>> 2. shrinker_free_non_registered()
>>
>> Used to destroy the non-registered shrinker instance.
> 
> At least I don't like this name. I know you want to tell others
> this function only should be called when shrinker has not been
> registed but allocated. Maybe shrinker_free() is more simple.
> And and a comment to tell the users when to use it.

OK, if no one else objects, I will change it to shrinker_free() in
the next version.

> 
>>
>> 3. shrinker_register()
>>
>> Used to register the shrinker instance, which is same as the current
>> register_shrinker_prepared().
>>
>> 4. shrinker_unregister()
>>
>> Used to unregister and free the shrinker instance.
>>
>> In order to simplify shrinker-related APIs and make shrinker more
>> independent of other kernel mechanisms, subsequent submissions will use
>> the above API to convert all shrinkers (including case a and b) to
>> dynamically allocated, and then remove all existing APIs.
>>
>> This will also have another advantage mentioned by Dave Chinner:
>>
>> ```
>> The other advantage of this is that it will break all the existing
>> out of tree code and third party modules using the old API and will
>> no longer work with a kernel using lockless slab shrinkers. They
>> need to break (both at the source and binary levels) to stop bad
>> things from happening due to using uncoverted shrinkers in the new
>> setup.
>> ```
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/shrinker.h |   6 +++
>>   mm/shrinker.c            | 113 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 961cb84e51f5..296f5e163861 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -70,6 +70,8 @@ struct shrinker {
>>       int seeks;    /* seeks to recreate an obj */
>>       unsigned flags;
>> +    void *private_data;
>> +
>>       /* These are for internal use */
>>       struct list_head list;
>>   #ifdef CONFIG_MEMCG
>> @@ -98,6 +100,10 @@ struct shrinker {
>>   unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup 
>> *memcg,
>>                 int priority);
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...);
>> +void shrinker_free_non_registered(struct shrinker *shrinker);
>> +void shrinker_register(struct shrinker *shrinker);
>> +void shrinker_unregister(struct shrinker *shrinker);
>>   extern int __printf(2, 3) prealloc_shrinker(struct shrinker *shrinker,
>>                           const char *fmt, ...);
>> diff --git a/mm/shrinker.c b/mm/shrinker.c
>> index 0a32ef42f2a7..d820e4cc5806 100644
>> --- a/mm/shrinker.c
>> +++ b/mm/shrinker.c
>> @@ -548,6 +548,119 @@ unsigned long shrink_slab(gfp_t gfp_mask, int 
>> nid, struct mem_cgroup *memcg,
>>       return freed;
>>   }
>> +struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, 
>> ...)
>> +{
>> +    struct shrinker *shrinker;
>> +    unsigned int size;
>> +    va_list __maybe_unused ap;
>> +    int err;
>> +
>> +    shrinker = kzalloc(sizeof(struct shrinker), GFP_KERNEL);
>> +    if (!shrinker)
>> +        return NULL;
>> +
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    va_start(ap, fmt);
>> +    shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>> +    va_end(ap);
>> +    if (!shrinker->name)
>> +        goto err_name;
>> +#endif
> 
> So why not introduce another helper to handle this and declare it
> as a void function when !CONFIG_SHRINKER_DEBUG? Something like the
> following:
> 
> #ifdef CONFIG_SHRINKER_DEBUG
> static int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const 
> char *fmt,
>                                         va_list vargs)
> 
> {
>      shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, vargs);
>      return shrinker->name ? 0 : -ENOMEM;
> }
> #else
> static int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const 
> char *fmt,
>                                         va_list vargs)
> {
>      return 0;
> }
> #endif

Will do in the next version.

> 
>> +    shrinker->flags = flags;
>> +
>> +    if (flags & SHRINKER_MEMCG_AWARE) {
>> +        err = prealloc_memcg_shrinker(shrinker);
>> +        if (err == -ENOSYS)
>> +            shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>> +        else if (err == 0)
>> +            goto done;
>> +        else
>> +            goto err_flags;
>> +    }
>> +
>> +    /*
>> +     * The nr_deferred is available on per memcg level for memcg aware
>> +     * shrinkers, so only allocate nr_deferred in the following cases:
>> +     *  - non memcg aware shrinkers
>> +     *  - !CONFIG_MEMCG
>> +     *  - memcg is disabled by kernel command line
>> +     */
>> +    size = sizeof(*shrinker->nr_deferred);
>> +    if (flags & SHRINKER_NUMA_AWARE)
>> +        size *= nr_node_ids;
>> +
>> +    shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
>> +    if (!shrinker->nr_deferred)
>> +        goto err_flags;
>> +
>> +done:
>> +    return shrinker;
>> +
>> +err_flags:
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    kfree_const(shrinker->name);
>> +    shrinker->name = NULL;
> 
> This could be shrinker_debugfs_name_free()

Will do.

> 
>> +err_name:
>> +#endif
>> +    kfree(shrinker);
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL(shrinker_alloc);
>> +
>> +void shrinker_free_non_registered(struct shrinker *shrinker)
>> +{
>> +#ifdef CONFIG_SHRINKER_DEBUG
>> +    kfree_const(shrinker->name);
>> +    shrinker->name = NULL;
> 
> This could be shrinker_debugfs_name_free()
> 
>> +#endif
>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>> +        down_write(&shrinker_rwsem);
>> +        unregister_memcg_shrinker(shrinker);
>> +        up_write(&shrinker_rwsem);
>> +    }
>> +
>> +    kfree(shrinker->nr_deferred);
>> +    shrinker->nr_deferred = NULL;
>> +
>> +    kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL(shrinker_free_non_registered);
>> +
>> +void shrinker_register(struct shrinker *shrinker)
>> +{
>> +    down_write(&shrinker_rwsem);
>> +    list_add_tail(&shrinker->list, &shrinker_list);
>> +    shrinker->flags |= SHRINKER_REGISTERED;
>> +    shrinker_debugfs_add(shrinker);
>> +    up_write(&shrinker_rwsem);
>> +}
>> +EXPORT_SYMBOL(shrinker_register);
>> +
>> +void shrinker_unregister(struct shrinker *shrinker)
> 
> You have made all shrinkers to be dynamically allocated, so
> we should prevent users from allocating shrinkers statically and
> use this function to unregister it. It is better to add a
> flag like SHRINKER_ALLOCATED which is set in shrinker_alloc(),
> and check whether it is set in shrinker_unregister(), if not
> maybe a warning should be added to tell the users what happened.

Make sense, will do.

> 
>> +{
>> +    struct dentry *debugfs_entry;
>> +    int debugfs_id;
>> +
>> +    if (!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))
>> +        return;
>> +
>> +    down_write(&shrinker_rwsem);
>> +    list_del(&shrinker->list);
>> +    shrinker->flags &= ~SHRINKER_REGISTERED;
>> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>> +        unregister_memcg_shrinker(shrinker);
>> +    debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
> 
> In the internal of this function, you also could use
> shrinker_debugfs_name_free().

Yeah, will do.

Thanks,
Qi

> 
> Thanks.
> 
>> +    up_write(&shrinker_rwsem);
>> +
>> +    shrinker_debugfs_remove(debugfs_entry, debugfs_id);
>> +
>> +    kfree(shrinker->nr_deferred);
>> +    shrinker->nr_deferred = NULL;
>> +
>> +    kfree(shrinker);
>> +}
>> +EXPORT_SYMBOL(shrinker_unregister);
>> +
>>   /*
>>    * Add a shrinker callback to be called from the vm.
>>    */
> 
