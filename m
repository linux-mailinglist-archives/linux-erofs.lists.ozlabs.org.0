Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E2C7631F3
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:28:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690363688;
	bh=3q/836hkNQMpcz/8YX2aFfQHacV0FqcsnRX2KDKmGK4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HILjgnrKZWOw002oQpLcSveET9l9FkmH37v+CrzzeBtztKpMUqX1LnxILZ+XfWj13
	 FaOhsO3pSI0QTIujzf8gKJxrkHHso6KC7mSzz5z80hf6lRt5JJMmNslY7aj18Ev4F4
	 1VLZvMvqaKvnUs58X87BOQN74pFtaZ24o2u/bQIhazg/eVcqtUMvBXkJXAqxnprr8z
	 w280gjVzyLnNSekChh0XfrfzCDjEvzQKvkSgLDbPb6B169hCfHrTUTDdHFK+DZt//l
	 xdoENMCDyBFuaLk4imRLeUSmMmqXFAVyW9o+x8JyCZ3RjmjVrTzPPULD/nOeSAdHDn
	 MtwtIoBv41PSw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9pV0214vz3bmP
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 19:28:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VrX61tol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9pTx1Wm8z2yV5
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 19:28:04 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-682eef7d752so1495620b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363681; x=1690968481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q/836hkNQMpcz/8YX2aFfQHacV0FqcsnRX2KDKmGK4=;
        b=GjxT/pMrxotIwqXTwAJr9JTL4uM6RX5GZeFvZZKzfJ/aUI13esUmxYpW/OyuehgzC/
         4jTZjZqezA0BE7KtdMlNGGZq8dkeeceexKc1IfCBkRF7sqWOjSQATwlhb1m8abo59198
         EmRWz5m+AEMh/Sf3qR2WYFHX9TCWJDDBVZ822SzLt4P9iOh2/wBDFaGqRbVdky2RUaEU
         5w4U/9494gNwNM/O0q12J7hMr7+ntEpWZ1k2OwYfYthCfj1VOm9pjey5d5iiHTu92Me9
         BVpjZa24E5zJXAU/0+TB9TVdO6kGuQ+YqVP2Q/+aClBvVZ4+I/2JZLAAO9HCHKCdQohJ
         7P/w==
X-Gm-Message-State: ABy/qLbezvSMPjs0W5dhPFcp8jQgocpNqJFcuqqGodVORnanTkM+umDP
	sEHnWOgO9BYxGaZgICsrEVE9+A==
X-Google-Smtp-Source: APBJJlFbGXVT1jvZWB8OqMMjwV1wWa8tPHrXXzsgQ/SF73jQ8jhDFJz/C4eSTJgkpJW81UF91auuJQ==
X-Received: by 2002:a05:6a20:3c90:b0:134:d4d3:f0a5 with SMTP id b16-20020a056a203c9000b00134d4d3f0a5mr1941746pzj.2.1690363681365;
        Wed, 26 Jul 2023 02:28:01 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l73-20020a633e4c000000b00563da87a52dsm1901427pga.40.2023.07.26.02.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:28:01 -0700 (PDT)
Message-ID: <665ccd89-8434-fc45-4813-c6412ef80c10@bytedance.com>
Date: Wed, 26 Jul 2023 17:27:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 19/47] mm: thp: dynamically allocate the thp-related
 shrinkers
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-20-zhengqi.arch@bytedance.com>
 <d41d09bc-7c1c-f708-ecfa-ffac59bf58ad@linux.dev>
In-Reply-To: <d41d09bc-7c1c-f708-ecfa-ffac59bf58ad@linux.dev>
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



On 2023/7/26 15:10, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> Use new APIs to dynamically allocate the thp-zero and thp-deferred_split
>> shrinkers.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/huge_memory.c | 69 +++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 45 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8c94b34024a2..4db5a1834d81 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -65,7 +65,11 @@ unsigned long transparent_hugepage_flags 
>> __read_mostly =
>>       (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>>       (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
>> -static struct shrinker deferred_split_shrinker;
>> +static struct shrinker *deferred_split_shrinker;
>> +static unsigned long deferred_split_count(struct shrinker *shrink,
>> +                      struct shrink_control *sc);
>> +static unsigned long deferred_split_scan(struct shrinker *shrink,
>> +                     struct shrink_control *sc);
>>   static atomic_t huge_zero_refcount;
>>   struct page *huge_zero_page __read_mostly;
>> @@ -229,11 +233,7 @@ static unsigned long 
>> shrink_huge_zero_page_scan(struct shrinker *shrink,
>>       return 0;
>>   }
>> -static struct shrinker huge_zero_page_shrinker = {
>> -    .count_objects = shrink_huge_zero_page_count,
>> -    .scan_objects = shrink_huge_zero_page_scan,
>> -    .seeks = DEFAULT_SEEKS,
>> -};
>> +static struct shrinker *huge_zero_page_shrinker;
> 
> Same as patch #17.

OK, will do.

> 
>>   #ifdef CONFIG_SYSFS
>>   static ssize_t enabled_show(struct kobject *kobj,
>> @@ -454,6 +454,40 @@ static inline void hugepage_exit_sysfs(struct 
>> kobject *hugepage_kobj)
>>   }
>>   #endif /* CONFIG_SYSFS */
>> +static int thp_shrinker_init(void)
> 
> Better to declare it as __init.

Will do.

> 
>> +{
>> +    huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
>> +    if (!huge_zero_page_shrinker)
>> +        return -ENOMEM;
>> +
>> +    deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
>> +                         SHRINKER_MEMCG_AWARE |
>> +                         SHRINKER_NONSLAB,
>> +                         "thp-deferred_split");
>> +    if (!deferred_split_shrinker) {
>> +        shrinker_free_non_registered(huge_zero_page_shrinker);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    huge_zero_page_shrinker->count_objects = 
>> shrink_huge_zero_page_count;
>> +    huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
>> +    huge_zero_page_shrinker->seeks = DEFAULT_SEEKS;
>> +    shrinker_register(huge_zero_page_shrinker);
>> +
>> +    deferred_split_shrinker->count_objects = deferred_split_count;
>> +    deferred_split_shrinker->scan_objects = deferred_split_scan;
>> +    deferred_split_shrinker->seeks = DEFAULT_SEEKS;
>> +    shrinker_register(deferred_split_shrinker);
>> +
>> +    return 0;
>> +}
>> +
>> +static void thp_shrinker_exit(void)
> 
> Same as here.

Will do.

> 
>> +{
>> +    shrinker_unregister(huge_zero_page_shrinker);
>> +    shrinker_unregister(deferred_split_shrinker);
>> +}
>> +
>>   static int __init hugepage_init(void)
>>   {
>>       int err;
>> @@ -482,12 +516,9 @@ static int __init hugepage_init(void)
>>       if (err)
>>           goto err_slab;
>> -    err = register_shrinker(&huge_zero_page_shrinker, "thp-zero");
>> -    if (err)
>> -        goto err_hzp_shrinker;
>> -    err = register_shrinker(&deferred_split_shrinker, 
>> "thp-deferred_split");
>> +    err = thp_shrinker_init();
>>       if (err)
>> -        goto err_split_shrinker;
>> +        goto err_shrinker;
>>       /*
>>        * By default disable transparent hugepages on smaller systems,
>> @@ -505,10 +536,8 @@ static int __init hugepage_init(void)
>>       return 0;
>>   err_khugepaged:
>> -    unregister_shrinker(&deferred_split_shrinker);
>> -err_split_shrinker:
>> -    unregister_shrinker(&huge_zero_page_shrinker);
>> -err_hzp_shrinker:
>> +    thp_shrinker_exit();
>> +err_shrinker:
>>       khugepaged_destroy();
>>   err_slab:
>>       hugepage_exit_sysfs(hugepage_kobj);
>> @@ -2851,7 +2880,7 @@ void deferred_split_folio(struct folio *folio)
>>   #ifdef CONFIG_MEMCG
>>           if (memcg)
>>               set_shrinker_bit(memcg, folio_nid(folio),
>> -                     deferred_split_shrinker.id);
>> +                     deferred_split_shrinker->id);
>>   #endif
>>       }
>>       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> @@ -2925,14 +2954,6 @@ static unsigned long deferred_split_scan(struct 
>> shrinker *shrink,
>>       return split;
>>   }
>> -static struct shrinker deferred_split_shrinker = {
>> -    .count_objects = deferred_split_count,
>> -    .scan_objects = deferred_split_scan,
>> -    .seeks = DEFAULT_SEEKS,
>> -    .flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
>> -         SHRINKER_NONSLAB,
>> -};
>> -
>>   #ifdef CONFIG_DEBUG_FS
>>   static void split_huge_pages_all(void)
>>   {
> 
