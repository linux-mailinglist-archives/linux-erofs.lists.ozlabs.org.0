Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB787631B5
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690363342;
	bh=xHFf+qIXuXcHU2hnpeM9isQldhnSqSauyHf1oBu4R8I=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Zk5LdzlSGDQgYjTbZikftDH2Ik1soT50q18gXI6WXqWb2u9uEfKqEb3DcOMzHVbWo
	 mdbekHHyFk3tDxzcLbTsoT9W46DqtuJelgpMxRZwqnviLUr+mMp1BZRb9EVVY2ekle
	 t6WdgImVpJ1zYnH4BQPXx5gYA+xwuRtcZd25Da2398wAiC2ZM6lftMICWOkw6q9NG1
	 zojpBkH1KInEJKqyVUiXk+jj3A1CRCMeMZjRbG3bWJofT6kei1vXFpaJS/ePLSIOJW
	 Cx2foNeuV5HhQcjBSIWM7lZH6PlvoDKLj83Wn11GQSuCGrzSzc3fBcmDyF4zk2m3Ao
	 gU2sIZhi8CMpQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9pML2T25z3byv
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 19:22:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jAMndxc3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9pMG24jpz30N3
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 19:22:18 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-682a5465e9eso1485688b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 02:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363335; x=1690968135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHFf+qIXuXcHU2hnpeM9isQldhnSqSauyHf1oBu4R8I=;
        b=T8KCjDb8p1IrRg39gVcFcHUllYxUQtNgd2WNDUC1pb1gn/bNfM9Qysh0Gc48213YC3
         2cU6DA6Wy2NHPI1a/eL81uuSXFc/QFosp97da6DBF3ed3JeLZztXzGVMxBWUVFfUaX/C
         Yp21WqpJslmXp8WX274s9m73aJjwH+vqRnKkNJNZjp22voW4+qpvUedvJ3X5eE0RrTki
         DTdsw8SJnkI3qFxRWfKWr7cNdv6d56Fwp8K1vF3u929n+/ZYeS/D8SiT6wGOOJF6lWoZ
         lTX/ZshLkVZs62dOSL90vVqZ3IVYedABYBoJ6f0eJfwLNJ56NgmUohdnUTGAzvsnc0Yf
         2V7w==
X-Gm-Message-State: ABy/qLaeSqGUd9N/KR4Liz6n1zSeUXqxv9j3B69ku030vZJ6TpYl/Txt
	vsfxDX0Kdi87+kOFbnYevcEhQA==
X-Google-Smtp-Source: APBJJlGzKLkoeooTK7rnc1fJ6mfD6dUCrzzNETRC7Ci4c1Yh8zXhisYlXfajH5gn3qqQbLizO8XVQA==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr1779967pzk.2.1690363335131;
        Wed, 26 Jul 2023 02:22:15 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k11-20020aa790cb000000b006827c26f147sm10955045pfk.138.2023.07.26.02.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:22:14 -0700 (PDT)
Message-ID: <d96777ce-be8a-1665-dd00-1e696e5575a8@bytedance.com>
Date: Wed, 26 Jul 2023 17:22:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/47] gfs2: dynamically allocate the gfs2-qd shrinker
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-12-zhengqi.arch@bytedance.com>
 <e7204276-9de5-17eb-90ae-e51657d73ef4@linux.dev>
In-Reply-To: <e7204276-9de5-17eb-90ae-e51657d73ef4@linux.dev>
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



On 2023/7/26 14:49, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> Use new APIs to dynamically allocate the gfs2-qd shrinker.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   fs/gfs2/main.c  |  6 +++---
>>   fs/gfs2/quota.c | 26 ++++++++++++++++++++------
>>   fs/gfs2/quota.h |  3 ++-
>>   3 files changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
>> index afcb32854f14..e47b1cc79f59 100644
>> --- a/fs/gfs2/main.c
>> +++ b/fs/gfs2/main.c
>> @@ -147,7 +147,7 @@ static int __init init_gfs2_fs(void)
>>       if (!gfs2_trans_cachep)
>>           goto fail_cachep8;
>> -    error = register_shrinker(&gfs2_qd_shrinker, "gfs2-qd");
>> +    error = gfs2_qd_shrinker_init();
>>       if (error)
>>           goto fail_shrinker;
>> @@ -196,7 +196,7 @@ static int __init init_gfs2_fs(void)
>>   fail_wq2:
>>       destroy_workqueue(gfs_recovery_wq);
>>   fail_wq1:
>> -    unregister_shrinker(&gfs2_qd_shrinker);
>> +    gfs2_qd_shrinker_exit();
>>   fail_shrinker:
>>       kmem_cache_destroy(gfs2_trans_cachep);
>>   fail_cachep8:
>> @@ -229,7 +229,7 @@ static int __init init_gfs2_fs(void)
>>   static void __exit exit_gfs2_fs(void)
>>   {
>> -    unregister_shrinker(&gfs2_qd_shrinker);
>> +    gfs2_qd_shrinker_exit();
>>       gfs2_glock_exit();
>>       gfs2_unregister_debugfs();
>>       unregister_filesystem(&gfs2_fs_type);
>> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
>> index 704192b73605..bc9883cea847 100644
>> --- a/fs/gfs2/quota.c
>> +++ b/fs/gfs2/quota.c
>> @@ -186,13 +186,27 @@ static unsigned long gfs2_qd_shrink_count(struct 
>> shrinker *shrink,
>>       return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
>>   }
>> -struct shrinker gfs2_qd_shrinker = {
>> -    .count_objects = gfs2_qd_shrink_count,
>> -    .scan_objects = gfs2_qd_shrink_scan,
>> -    .seeks = DEFAULT_SEEKS,
>> -    .flags = SHRINKER_NUMA_AWARE,
>> -};
>> +static struct shrinker *gfs2_qd_shrinker;
>> +
>> +int gfs2_qd_shrinker_init(void)
> 
> It's better to declare this as __init.

OK, Will do.

> 
>> +{
>> +    gfs2_qd_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "gfs2-qd");
>> +    if (!gfs2_qd_shrinker)
>> +        return -ENOMEM;
>> +
>> +    gfs2_qd_shrinker->count_objects = gfs2_qd_shrink_count;
>> +    gfs2_qd_shrinker->scan_objects = gfs2_qd_shrink_scan;
>> +    gfs2_qd_shrinker->seeks = DEFAULT_SEEKS;
>> +
>> +    shrinker_register(gfs2_qd_shrinker);
>> +    return 0;
>> +}
>> +
>> +void gfs2_qd_shrinker_exit(void)
>> +{
>> +    shrinker_unregister(gfs2_qd_shrinker);
>> +}
>>   static u64 qd2index(struct gfs2_quota_data *qd)
>>   {
>> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
>> index 21ada332d555..f9cb863373f7 100644
>> --- a/fs/gfs2/quota.h
>> +++ b/fs/gfs2/quota.h
>> @@ -59,7 +59,8 @@ static inline int gfs2_quota_lock_check(struct 
>> gfs2_inode *ip,
>>   }
>>   extern const struct quotactl_ops gfs2_quotactl_ops;
>> -extern struct shrinker gfs2_qd_shrinker;
>> +int gfs2_qd_shrinker_init(void);
>> +void gfs2_qd_shrinker_exit(void);
>>   extern struct list_lru gfs2_qd_lru;
>>   extern void __init gfs2_quota_hash_init(void);
> 
