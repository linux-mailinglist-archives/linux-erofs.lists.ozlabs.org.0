Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC1763258
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 11:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690364081;
	bh=0oULOTnWb1HIc+jcDQkyDbPD+ewEuK6cRZsxNFZBJHs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FsbgP/PUTIEsOL/iLhzWcRaa0v0crzmmvDQL3WOJlYgTvNiqSMvds5sB2nk4XtMoT
	 sjCcu7fFY7K/I6bMLSJNnIJlcRYYI20zpNAEmS7j1iTJ85vAzHjg5kOWM0RXbnjmC0
	 slujSU0ObEWKL76LiHH2NJ7QGL59WLOdHtKmHBA+RHPcEu/KMUJNOR/SFswLo5MW8Y
	 9jlBQAOfFsYcQOkIN5D+Ymi0q1NIHydIwX5cxc7zD3tgRUdEr73XZzJhNuJpbOmm6V
	 1667NJcfZFvQ34vsTONEe83e0xKezkqyhW0Po2jWxVAFVJ0BaeteUWVNij1KMfS01G
	 1QRbOS5We8vGQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9pdY3FyQz3cSJ
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 19:34:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=QJhhRpaT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9pcd1DhFz3c1W
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 19:33:52 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-682a5465e9eso1487405b3a.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 02:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364030; x=1690968830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oULOTnWb1HIc+jcDQkyDbPD+ewEuK6cRZsxNFZBJHs=;
        b=YOwokKI66qXZIhr/iI3nN4EKawZk/IKzl9kVd/T3fGGpfyHZP7cxjdPpienRzSbX+e
         E85Oi2ZfdJCdaNqhlL4dQz8uzciMN64F/mvBMAHqcGYplFKfDHzZpao2ZcsjyZ/363DW
         AMTS5xY8cJHTu5PbHJxj8/IcAvXLJi8hnuIiaNcTa6oF94ddQNFTpdIiUPZdz0HbujnW
         j0SdgRZB/sT8XP1TXflXlnPlS4Ub7nYaaJ9RAumg0X7jQqmsaqheVu9P+1lhKyY+CT/g
         NoG8zlLMlV/1pQDcdlourE8MAM5Xmmxe7tFMDQL8JhVP4UliHw7BL067Zmbr6WoS8TV6
         GVEQ==
X-Gm-Message-State: ABy/qLapL0O076CEV9vmSp6x0R5zHTesxQpAl9q2ONJjWbrGAZnbAxzb
	myir4lgMD0OyqSIeMtyu7JrHYA==
X-Google-Smtp-Source: APBJJlG8LKe8O0SB++JE7Hsj6dMankp6b2TdGG8KZmgQCX7ZvwrXNm6kysx08G1J6PXDjDRRJyafNA==
X-Received: by 2002:a17:903:32c9:b0:1b8:5827:8763 with SMTP id i9-20020a17090332c900b001b858278763mr2037984plr.4.1690364030014;
        Wed, 26 Jul 2023 02:33:50 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001b89466a5f4sm12582766plc.105.2023.07.26.02.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:33:49 -0700 (PDT)
Message-ID: <0f12022e-5dd2-fb1c-f018-05f8ff0303ae@bytedance.com>
Date: Wed, 26 Jul 2023 17:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 28/47] bcache: dynamically allocate the md-bcache
 shrinker
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-29-zhengqi.arch@bytedance.com>
 <4ee26da4-314e-0517-5d9a-31fb107368ef@linux.dev>
In-Reply-To: <4ee26da4-314e-0517-5d9a-31fb107368ef@linux.dev>
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



On 2023/7/26 15:32, Muchun Song wrote:
> 
> 
> On 2023/7/24 17:43, Qi Zheng wrote:
>> In preparation for implementing lockless slab shrink, use new APIs to
>> dynamically allocate the md-bcache shrinker, so that it can be freed
>> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
>> read-side critical section when releasing the struct cache_set.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   drivers/md/bcache/bcache.h |  2 +-
>>   drivers/md/bcache/btree.c  | 27 ++++++++++++++++-----------
>>   drivers/md/bcache/sysfs.c  |  3 ++-
>>   3 files changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>> index 5a79bb3c272f..c622bc50f81b 100644
>> --- a/drivers/md/bcache/bcache.h
>> +++ b/drivers/md/bcache/bcache.h
>> @@ -541,7 +541,7 @@ struct cache_set {
>>       struct bio_set        bio_split;
>>       /* For the btree cache */
>> -    struct shrinker        shrink;
>> +    struct shrinker        *shrink;
>>       /* For the btree cache and anything allocation related */
>>       struct mutex        bucket_lock;
>> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
>> index fd121a61f17c..c176c7fc77d9 100644
>> --- a/drivers/md/bcache/btree.c
>> +++ b/drivers/md/bcache/btree.c
>> @@ -667,7 +667,7 @@ static int mca_reap(struct btree *b, unsigned int 
>> min_order, bool flush)
>>   static unsigned long bch_mca_scan(struct shrinker *shrink,
>>                     struct shrink_control *sc)
>>   {
>> -    struct cache_set *c = container_of(shrink, struct cache_set, 
>> shrink);
>> +    struct cache_set *c = shrink->private_data;
>>       struct btree *b, *t;
>>       unsigned long i, nr = sc->nr_to_scan;
>>       unsigned long freed = 0;
>> @@ -734,7 +734,7 @@ static unsigned long bch_mca_scan(struct shrinker 
>> *shrink,
>>   static unsigned long bch_mca_count(struct shrinker *shrink,
>>                      struct shrink_control *sc)
>>   {
>> -    struct cache_set *c = container_of(shrink, struct cache_set, 
>> shrink);
>> +    struct cache_set *c = shrink->private_data;
>>       if (c->shrinker_disabled)
>>           return 0;
>> @@ -752,8 +752,8 @@ void bch_btree_cache_free(struct cache_set *c)
>>       closure_init_stack(&cl);
>> -    if (c->shrink.list.next)
>> -        unregister_shrinker(&c->shrink);
>> +    if (c->shrink)
>> +        shrinker_unregister(c->shrink);
>>       mutex_lock(&c->bucket_lock);
>> @@ -828,14 +828,19 @@ int bch_btree_cache_alloc(struct cache_set *c)
>>           c->verify_data = NULL;
>>   #endif
>> -    c->shrink.count_objects = bch_mca_count;
>> -    c->shrink.scan_objects = bch_mca_scan;
>> -    c->shrink.seeks = 4;
>> -    c->shrink.batch = c->btree_pages * 2;
>> +    c->shrink = shrinker_alloc(0, "md-bcache:%pU", c->set_uuid);
>> +    if (!c->shrink) {
>> +        pr_warn("bcache: %s: could not allocate shrinker\n", __func__);
>> +        return -ENOMEM;
> 
> Seems you have cheanged the semantic of this. In the past,
> it is better to have a shrinker, but now it becomes a mandatory.
> Right? I don't know if it is acceptable. From my point of view,
> just do the cleanup, don't change any behaviour.

Oh, should return 0 here, will do.

> 
>> +    }
>> +
>> +    c->shrink->count_objects = bch_mca_count;
>> +    c->shrink->scan_objects = bch_mca_scan;
>> +    c->shrink->seeks = 4;
>> +    c->shrink->batch = c->btree_pages * 2;
>> +    c->shrink->private_data = c;
>> -    if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
>> -        pr_warn("bcache: %s: could not register shrinker\n",
>> -                __func__);
>> +    shrinker_register(c->shrink);
>>       return 0;
>>   }
>> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
>> index 0e2c1880f60b..45d8af755de6 100644
>> --- a/drivers/md/bcache/sysfs.c
>> +++ b/drivers/md/bcache/sysfs.c
>> @@ -866,7 +866,8 @@ STORE(__bch_cache_set)
>>           sc.gfp_mask = GFP_KERNEL;
>>           sc.nr_to_scan = strtoul_or_return(buf);
>> -        c->shrink.scan_objects(&c->shrink, &sc);
>> +        if (c->shrink)
>> +            c->shrink->scan_objects(c->shrink, &sc);
>>       }
>>       sysfs_strtoul_clamp(congested_read_threshold_us,
> 
