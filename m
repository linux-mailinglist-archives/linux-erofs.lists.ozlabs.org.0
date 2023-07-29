Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0093767D4F
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jul 2023 10:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690620500;
	bh=AbdgPGpGzwv3Ba9ss/qbC8w4dcIJ6EfJ8tT9+ztVBsQ=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dNicRo5Y7iY6H0LHejWDhpoq/E5ljEDuErMcZzjGaRqu/ej9t0q4oLwSBeZSuR8Vu
	 400jDd4t65NoPTOIhYI1k+P276S+XOIALdXc3mNXy4BkdJbiflyqPLfrFQufJX63Cb
	 NRTYhHebWvMeJ0oRCoukXi6wn6ATr85APxKemSBe1mvzS1ANMJpACWUVop2xkqwsWj
	 a3lzznWOAP6s2OCQbnqsIc6ZCBhdQIaFFDM7FF2nkPcYyFhdmNTr+Zad8HQEyxGY6D
	 VTkxAGbYjHFDkcdpHPM5/PbhmZ2nRI2R3THAzjtCQpfyXgN5o1v5Kurf/Vj/Z8RZp5
	 IQ3saHdHxs6HQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RCdSh65Hvz3bVf
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jul 2023 18:48:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DZFLwwmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RCdSZ6T8vz2ys9
	for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jul 2023 18:48:12 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-682ae5d4184so685367b3a.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jul 2023 01:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690620488; x=1691225288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbdgPGpGzwv3Ba9ss/qbC8w4dcIJ6EfJ8tT9+ztVBsQ=;
        b=hJ2UIXoXpb34GFz+LaeJWSuXx8hsxqKVgMMHLv41+6H3nbJXXGzN+DwEBsoxlP9j+L
         NhzI9G6aBoyn7taaS7M9UBYTarX2aIqzy5aGqDIfwMRmhwnD2JTl9b7+tWBWYuz6qkxr
         u5zQ8QS3TqOZshQGZgvkEBAwg4MVU/O3p9X2UIPYIxUFjv6t5C5lSlECP7ja+zwQe5m4
         FnFLi9tLwFdKj81+7CNaqjjbWk35X1FAUqlGBxcdTvSTNvHgncfNWWg92wwV4V3TNwPj
         tbsiLHT2FoCCLEI/ZbWe9HVphxV1oqFTwgoADtItVt3J7qzhNeppPB+CmwLnz5uCv/No
         u86w==
X-Gm-Message-State: ABy/qLZXBfXmpJRYyEWsWriEJyL9f+d2fJGJpYcZPGv+j+Wljjnv99Cg
	PUaKgsCaKz9kU4tFNq3uu5x3Vw==
X-Google-Smtp-Source: APBJJlGU4WvDtIE3roPXfr2RIP3jnPqKjXBKgd99me7vK4BYh3P3V9BBkMbm8JQkpcQK7ib8McexOg==
X-Received: by 2002:a05:6a00:32c8:b0:67f:7403:1fe8 with SMTP id cl8-20020a056a0032c800b0067f74031fe8mr1763906pfb.3.1690620488142;
        Sat, 29 Jul 2023 01:48:08 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:1c25:884:3ed:e1db:b610? ([240e:694:e21:b::2])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b00687087d8bc3sm2935245pfh.141.2023.07.29.01.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 01:48:07 -0700 (PDT)
Message-ID: <5e50711c-a616-f95f-d6d2-c69627ac3cf0@bytedance.com>
Date: Sat, 29 Jul 2023 16:47:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/49] mm: shrinker: add infrastructure for dynamically
 allocating shrinker
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-6-zhengqi.arch@bytedance.com>
 <ZMOx0y+wdHEATDho@corigine.com>
In-Reply-To: <ZMOx0y+wdHEATDho@corigine.com>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, david@fromorbit.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Simon,

On 2023/7/28 20:17, Simon Horman wrote:
> On Thu, Jul 27, 2023 at 04:04:18PM +0800, Qi Zheng wrote:
>> Currently, the shrinker instances can be divided into the following three
>> types:
>>
>> a) global shrinker instance statically defined in the kernel, such as
>>     workingset_shadow_shrinker.
>>
>> b) global shrinker instance statically defined in the kernel modules, such
>>     as mmu_shrinker in x86.
>>
>> c) shrinker instance embedded in other structures.
>>
>> For case a, the memory of shrinker instance is never freed. For case b,
>> the memory of shrinker instance will be freed after synchronize_rcu() when
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
>> 2. shrinker_register()
>>
>> Used to register the shrinker instance, which is same as the current
>> register_shrinker_prepared().
>>
>> 3. shrinker_free()
>>
>> Used to unregister (if needed) and free the shrinker instance.
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
> 
> nit: uncoverted -> unconverted

Thanks. Will fix.

> 
>> setup.
>> ```
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> ...
> 
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index f1becfd45853..506257585408 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
>> @@ -191,6 +191,20 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>   	return 0;
>>   }
>>   
>> +int shrinker_debugfs_name_alloc(struct shrinker *shrinker, const char *fmt,
>> +				va_list ap)
>> +{
>> +	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>> +
>> +	return shrinker->name ? 0 : -ENOMEM;
>> +}
>> +
>> +void shrinker_debugfs_name_free(struct shrinker *shrinker)
>> +{
>> +	kfree_const(shrinker->name);
>> +	shrinker->name = NULL;
>> +}
>> +
> 
> These functions have no prototype in this file,
> perhaps internal.h should be included?

The compiler can find these implementations, so I don't think there
is a need to include internal.h here?

Thanks,
Qi

> 
>>   int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>>   {
>>   	struct dentry *entry;
> 
> ...
