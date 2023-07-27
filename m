Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D2764465
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 05:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690428898;
	bh=pSHiqW/1Kwa6XMfrutppYGKtzk0jA+6GZMwxRhGaywI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IgZ1Emd4HIZwn7bThaDXlkcUp8dIyoAv4paOdKU74KZ547MckK1uubmhWn+ji5mS2
	 nQd22YKALLZtDoTXy1KNrLe+Q7Fl3uuHqFm+JV8adU11rldiohVxNap6zXBx0ZJWu/
	 AqKzh92e9sQTpoBQ/DnitrNDGRMbRqv6+uSSkXR7Aiy7YtWHOj9GcIGaAHs8u087qB
	 v9Pq3SHKh/Yp2cuwUdPiyn2+80snwoc3vsDa6PUo1Mcdenk9g+reXiTbtqL3EV8p8D
	 cXyuowdm/B2141mJq56f4fXs734gXXVqyNfniSq9NyzfK09cEt4O2v7nP1sI7ENFcA
	 5t66KsHuFMozQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBGc23bxJz3bY3
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 13:34:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JH3Gdn8e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBGbx4Mh5z2xpv
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 13:34:51 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-682eef7d752so141137b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 20:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690428886; x=1691033686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSHiqW/1Kwa6XMfrutppYGKtzk0jA+6GZMwxRhGaywI=;
        b=B0/Ol+Vz5NjKArPsm5bPIU9s2+5OBDI3O829p9NGy/DkVAEvtx0jni5xam1Tx2r5rh
         /tu+vpHqhY0c0cGE7Ka1skqSqTunEBGr7sDdy1OYr9MxZtA2vawTkPbjPT09g3ehxt9U
         u8rDCv35HKXmbwFtSAXV44a4/ly+bvVWSKXtX5waqYdTdysI0dH1bg1ICJTKC54Pd18K
         biAnWdOcR2YnNOY0UkHYDmNm55odch4K5gyokzNTEOsJdp7wGO0p0lOwsebBQ6/PBTTC
         wixr451PYv6AxXaGZBD71FxD6d3lGLt7BR+DYq/gtnzAlGzZtT2ZlFabJ4Woj+RF8DND
         sWBQ==
X-Gm-Message-State: ABy/qLZzpZdo/zNbIU5+M03c2/V1Kl5b3C9LHa1OxEozRDtl151M6/tJ
	zRkcA2GjM+u2y7A12NAjyp9Vyg==
X-Google-Smtp-Source: APBJJlGnfHXNUKtpZ8goterp0kPe1+GeF2c87BsTqhWXyrNp01VQ9DDS/+17IDHKN7LAqAttouOeag==
X-Received: by 2002:a05:6a21:339b:b0:137:4fd0:e2e6 with SMTP id yy27-20020a056a21339b00b001374fd0e2e6mr5017607pzb.6.1690428886364;
        Wed, 26 Jul 2023 20:34:46 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id z25-20020aa791d9000000b006828ee9fa69sm328803pfa.206.2023.07.26.20.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 20:34:46 -0700 (PDT)
Message-ID: <c942e424-276d-4df7-4917-d61063ab8502@bytedance.com>
Date: Thu, 27 Jul 2023 11:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 44/47] mm: shrinker: make global slab shrink lockless
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-45-zhengqi.arch@bytedance.com>
 <ZMDUkoIXUlTkCSYL@dread.disaster.area>
 <19ad6d06-8a14-6102-5eae-2134dc2c5061@bytedance.com>
 <ZMGnthZAh48JF+eV@dread.disaster.area>
In-Reply-To: <ZMGnthZAh48JF+eV@dread.disaster.area>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dave,

On 2023/7/27 07:09, Dave Chinner wrote:
> On Wed, Jul 26, 2023 at 05:14:09PM +0800, Qi Zheng wrote:
>> On 2023/7/26 16:08, Dave Chinner wrote:
>>> On Mon, Jul 24, 2023 at 05:43:51PM +0800, Qi Zheng wrote:
>>>> @@ -122,6 +126,13 @@ void shrinker_free_non_registered(struct shrinker *shrinker);
>>>>    void shrinker_register(struct shrinker *shrinker);
>>>>    void shrinker_unregister(struct shrinker *shrinker);
>>>> +static inline bool shrinker_try_get(struct shrinker *shrinker)
>>>> +{
>>>> +	return READ_ONCE(shrinker->registered) &&
>>>> +	       refcount_inc_not_zero(&shrinker->refcount);
>>>> +}
>>>
>>> Why do we care about shrinker->registered here? If we don't set
>>> the refcount to 1 until we have fully initialised everything, then
>>> the shrinker code can key entirely off the reference count and
>>> none of the lookup code needs to care about whether the shrinker is
>>> registered or not.
>>
>> The purpose of checking shrinker->registered here is to stop running
>> shrinker after calling shrinker_free(), which can prevent the following
>> situations from happening:
>>
>> CPU 0                 CPU 1
>>
>> shrinker_try_get()
>>
>>                         shrinker_try_get()
>>
>> shrinker_put()
>> shrinker_try_get()
>>                         shrinker_put()
> 
> I don't see any race here? What is wrong with having multiple active
> users at once?

Maybe I'm overthinking. What I think is that if there are multiple users
at once, it may cause the above-mentioned livelock, which will cause
shrinker_free() to wait for a long time. But this probability should be
very low.

> 
>>>
>>> This should use a completion, then it is always safe under
>>> rcu_read_lock().  This also gets rid of the shrinker_lock spin lock,
>>> which only exists because we can't take a blocking lock under
>>> rcu_read_lock(). i.e:
>>>
>>>
>>> void shrinker_put(struct shrinker *shrinker)
>>> {
>>> 	if (refcount_dec_and_test(&shrinker->refcount))
>>> 		complete(&shrinker->done);
>>> }
>>>
>>> void shrinker_free()
>>> {
>>> 	.....
>>> 	refcount_dec(&shrinker->refcount);
>>
>> I guess what you mean is shrinker_put(), because here may be the last
>> refcount.
> 
> Yes, I did.
> 
>>> 	wait_for_completion(&shrinker->done);
>>> 	/*
>>> 	 * lookups on the shrinker will now all fail as refcount has
>>> 	 * fallen to zero. We can now remove it from the lists and
>>> 	 * free it.
>>> 	 */
>>> 	down_write(shrinker_rwsem);
>>> 	list_del_rcu(&shrinker->list);
>>> 	up_write(&shrinker_rwsem);
>>> 	call_rcu(shrinker->rcu_head, shrinker_free_rcu_cb);
>>> }
>>>
>>> ....
>>>
>>>> @@ -686,11 +711,14 @@ EXPORT_SYMBOL(shrinker_free_non_registered);
>>>>    void shrinker_register(struct shrinker *shrinker)
>>>>    {
>>>> -	down_write(&shrinker_rwsem);
>>>> -	list_add_tail(&shrinker->list, &shrinker_list);
>>>> -	shrinker->flags |= SHRINKER_REGISTERED;
>>>> +	refcount_set(&shrinker->refcount, 1);
>>>> +
>>>> +	spin_lock(&shrinker_lock);
>>>> +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>>> +	spin_unlock(&shrinker_lock);
>>>> +
>>>>    	shrinker_debugfs_add(shrinker);
>>>> -	up_write(&shrinker_rwsem);
>>>> +	WRITE_ONCE(shrinker->registered, true);
>>>>    }
>>>>    EXPORT_SYMBOL(shrinker_register);
>>>
>>> This just looks wrong - you are trying to use WRITE_ONCE() as a
>>> release barrier to indicate that the shrinker is now set up fully.
>>> That's not necessary - the refcount is an atomic and along with the
>>> rcu locks they should provides all the barriers we need. i.e.
>>
>> The reason I used WRITE_ONCE() here is because the shrinker->registered
>> will be read and written concurrently (read in shrinker_try_get() and
>> written in shrinker_free()), which is why I added shrinker::registered
>> field instead of using SHRINKER_REGISTERED flag (this can reduce the
>> addition of WRITE_ONCE()/READ_ONCE()).
> 
> Using WRITE_ONCE/READ_ONCE doesn't provide memory barriers needed to
> use the field like this. You need release/acquire memory ordering
> here. i.e. smp_store_release()/smp_load_acquire().
> 
> As it is, the refcount_inc_not_zero() provides a control dependency,
> as documented in include/linux/refcount.h, refcount_dec_and_test()
> provides release memory ordering. The only thing I think we may need
> is a write barrier before refcount_set(), such that if
> refcount_inc_not_zero() sees a non-zero value, it is guaranteed to
> see an initialised structure...
> 
> i.e. refcounts provide all the existence and initialisation
> guarantees. Hence I don't see the need to use shrinker->registered
> like this and it can remain a bit flag protected by the
> shrinker_rwsem().

Ah, I didn't consider the memory order with refcount when I added
WRITE_ONCE/READ_ONCE to shrinker->registered, just didn't want KCSAN
to complain (there are multiple visitors at the same time, one of which
is a writer).

And the livelock case mentioned above is indeed unlikely to happen, so
I will delete shrinker->registered in the next version.

> 
> 
>>> void shrinker_register(struct shrinker *shrinker)
>>> {
>>> 	down_write(&shrinker_rwsem);
>>> 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>>> 	shrinker->flags |= SHRINKER_REGISTERED;
>>> 	shrinker_debugfs_add(shrinker);
>>> 	up_write(&shrinker_rwsem);
>>>
>>> 	/*
>>> 	 * now the shrinker is fully set up, take the first
>>> 	 * reference to it to indicate that lookup operations are
>>> 	 * now allowed to use it via shrinker_try_get().
>>> 	 */
>>> 	refcount_set(&shrinker->refcount, 1);
>>> }
>>>
>>>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>>>> index f1becfd45853..c5573066adbf 100644
>>>> --- a/mm/shrinker_debug.c
>>>> +++ b/mm/shrinker_debug.c
>>>> @@ -5,6 +5,7 @@
>>>>    #include <linux/seq_file.h>
>>>>    #include <linux/shrinker.h>
>>>>    #include <linux/memcontrol.h>
>>>> +#include <linux/rculist.h>
>>>>    /* defined in vmscan.c */
>>>>    extern struct rw_semaphore shrinker_rwsem;
>>>> @@ -161,17 +162,21 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>>>    {
>>>>    	struct dentry *entry;
>>>>    	char buf[128];
>>>> -	int id;
>>>> -
>>>> -	lockdep_assert_held(&shrinker_rwsem);
>>>> +	int id, ret = 0;
>>>>    	/* debugfs isn't initialized yet, add debugfs entries later. */
>>>>    	if (!shrinker_debugfs_root)
>>>>    		return 0;
>>>> +	down_write(&shrinker_rwsem);
>>>> +	if (shrinker->debugfs_entry)
>>>> +		goto fail;
>>>> +
>>>>    	id = ida_alloc(&shrinker_debugfs_ida, GFP_KERNEL);
>>>> -	if (id < 0)
>>>> -		return id;
>>>> +	if (id < 0) {
>>>> +		ret = id;
>>>> +		goto fail;
>>>> +	}
>>>>    	shrinker->debugfs_id = id;
>>>>    	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
>>>> @@ -180,7 +185,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>>>    	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
>>>>    	if (IS_ERR(entry)) {
>>>>    		ida_free(&shrinker_debugfs_ida, id);
>>>> -		return PTR_ERR(entry);
>>>> +		ret = PTR_ERR(entry);
>>>> +		goto fail;
>>>>    	}
>>>>    	shrinker->debugfs_entry = entry;
>>>> @@ -188,7 +194,10 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>>>>    			    &shrinker_debugfs_count_fops);
>>>>    	debugfs_create_file("scan", 0220, entry, shrinker,
>>>>    			    &shrinker_debugfs_scan_fops);
>>>> -	return 0;
>>>> +
>>>> +fail:
>>>> +	up_write(&shrinker_rwsem);
>>>> +	return ret;
>>>>    }
>>>>    int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>>>> @@ -243,6 +252,11 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
>>>>    	shrinker->name = NULL;
>>>>    	*debugfs_id = entry ? shrinker->debugfs_id : -1;
>>>> +	/*
>>>> +	 * Ensure that shrinker->registered has been set to false before
>>>> +	 * shrinker->debugfs_entry is set to NULL.
>>>> +	 */
>>>> +	smp_wmb();
>>>>    	shrinker->debugfs_entry = NULL;
>>>>    	return entry;
>>>> @@ -266,14 +280,26 @@ static int __init shrinker_debugfs_init(void)
>>>>    	shrinker_debugfs_root = dentry;
>>>>    	/* Create debugfs entries for shrinkers registered at boot */
>>>> -	down_write(&shrinker_rwsem);
>>>> -	list_for_each_entry(shrinker, &shrinker_list, list)
>>>> +	rcu_read_lock();
>>>> +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>>>> +		if (!shrinker_try_get(shrinker))
>>>> +			continue;
>>>> +		rcu_read_unlock();
>>>> +
>>>>    		if (!shrinker->debugfs_entry) {
>>>> -			ret = shrinker_debugfs_add(shrinker);
>>>> -			if (ret)
>>>> -				break;
>>>> +			/* Paired with smp_wmb() in shrinker_debugfs_detach() */
>>>> +			smp_rmb();
>>>> +			if (READ_ONCE(shrinker->registered))
>>>> +				ret = shrinker_debugfs_add(shrinker);
>>>>    		}
>>>> -	up_write(&shrinker_rwsem);
>>>> +
>>>> +		rcu_read_lock();
>>>> +		shrinker_put(shrinker);
>>>> +
>>>> +		if (ret)
>>>> +			break;
>>>> +	}
>>>> +	rcu_read_unlock();
>>>>    	return ret;
>>>>    }
>>>
>>> And all this churn and complexity can go away because the
>>> shrinker_rwsem is still used to protect shrinker_register()
>>> entirely....
>>
>> My consideration is that during this process, there may be a
>> driver probe failure and then shrinker_free() is called (the
>> shrinker_debugfs_init() is called in late_initcall stage). In
>> this case, we need to use RCU+refcount to ensure that the shrinker
>> is not freed.
> 
> Yeah, you're trying to work around the lack of a
> wait_for_completion() call in shrinker_free().
> 
> With that, this doesn't need RCU at all, and the iteration can be
> done fully under the shrinker_rwsem() safely and so none of this
> code needs to change.

Oh, indeed, here does not need to be changed.

Thanks,
Qi

> 
> Cheers,
> 
> Dave.
