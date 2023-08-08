Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94B7736EF
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 04:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691462665;
	bh=ZZ3n364wJBBn5i6olC7X8xOphz5aoEwi3PPn9Humxy4=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Mbwr2q4JAEoIqSh6cwFRabnG8U96KRHl7v6p97i4G3jwXXu/O7LzlzwlU5uPy2GNJ
	 L89UXoMqw0E+UGK6H+SeDF1VNEcgKO36LonAOD7WHYZ68P7aDrxfTlAprWBtwxw8dZ
	 EyOTGxYRi4XUrYUvU63/SywEAOsqcxIu+1abN8CMlivB8NJ98M4rxjB9lRUAI/uSJk
	 andOM/m1ijMQ9qXPhr/5VHHlruP4FzqgB/Kk5Xe3F5lDzbd20x/hhze0gTYi8B2x6X
	 JN30iZTNZOVo4twF7rmGlqkfnF8375tYYiXKKzw1ymDxwXnXS9ZRr/BPqj7RF1X72y
	 dEG9sndu7LW7g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKcw90qmcz2ytK
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 12:44:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=c9iOPpy4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKcw3072qz2xpm
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 12:44:17 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc34b32785so33837775ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 19:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691462655; x=1692067455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ3n364wJBBn5i6olC7X8xOphz5aoEwi3PPn9Humxy4=;
        b=AbD1hWEmIMUXAYQVxbUrUQmSPSA/4XKugdbjsqhvYevmW7hp0hN62CA/a9eo5Kcg1z
         OHc+x9FF1jtW6d9Pd+zQl9rgFTAMkNQQl1pN1YDQ+2LLNH+MwD/czTRF4llTJ0k9Q9Fb
         6jyQAMojMFvbch9cJwZq0dQqxSHSyLxzHyr0u9XD6yC/fWh778nsW07OY0WuqaEyL/wB
         ZputdohRgDgxK4md1tO+J75OMrMzCwQGgdW8myFXZ90PU1SwO+AvTu186wLaU5oKvVQP
         KugMxVorGIihtQQsjcjxyIj5m/4LrUA8F0EEo5MepL6m/CydftGBoXR3RbARtw+N8FgY
         WaCA==
X-Gm-Message-State: AOJu0Yx36bKKkvR6XfSUnT9f8s0yop9NxJXwp+Um8atqoDwUMA2Rjbk6
	kP2gJ7vljy3A+9Bu6+Ed46q9BA==
X-Google-Smtp-Source: AGHT+IEZT2gUmOSYrkIbMjP5ySF6z1UEt5Q+o+GMN8zU98oO9pgzqqi+i8QK+swPthTlPTk4WQ36Qw==
X-Received: by 2002:a17:902:7287:b0:1b3:f5c7:4e75 with SMTP id d7-20020a170902728700b001b3f5c74e75mr9699662pll.58.1691462654669;
        Mon, 07 Aug 2023 19:44:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001b893b689a0sm7632067plg.84.2023.08.07.19.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:44:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qTChf-002XBg-27;
	Tue, 08 Aug 2023 12:44:11 +1000
Date: Tue, 8 Aug 2023 12:44:11 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 46/48] mm: shrinker: make memcg slab shrink lockless
Message-ID: <ZNGr+1orhHaBORJG@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-47-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-47-zhengqi.arch@bytedance.com>
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
From: Dave Chinner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, simon.horman@corigine.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, dlemoal@kernel.org, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 07, 2023 at 07:09:34PM +0800, Qi Zheng wrote:
> Like global slab shrink, this commit also uses refcount+RCU method to make
> memcg slab shrink lockless.

This patch does random code cleanups amongst the actual RCU changes.
Can you please move the cleanups to a spearate patch to reduce the
noise in this one?

> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index d318f5621862..fee6f62904fb 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -107,6 +107,12 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  					 lockdep_is_held(&shrinker_rwsem));
>  }
>  
> +static struct shrinker_info *shrinker_info_rcu(struct mem_cgroup *memcg,
> +					       int nid)
> +{
> +	return rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +}

This helper doesn't add value. It doesn't tell me that
rcu_read_lock() needs to be held when it is called, for one....

>  static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
>  				    int old_size, int new_nr_max)
>  {
> @@ -198,7 +204,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  		struct shrinker_info_unit *unit;
>  
>  		rcu_read_lock();
> -		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +		info = shrinker_info_rcu(memcg, nid);

... whilst the original code here was obviously correct.

>  		unit = info->unit[shriner_id_to_index(shrinker_id)];
>  		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
>  			/* Pairs with smp mb in shrink_slab() */
> @@ -211,7 +217,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  
>  static DEFINE_IDR(shrinker_idr);
>  
> -static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> +static int shrinker_memcg_alloc(struct shrinker *shrinker)

Cleanups in a separate patch.

> @@ -253,10 +258,15 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  	struct shrinker_info_unit *unit;
> +	long nr_deferred;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	rcu_read_lock();
> +	info = shrinker_info_rcu(memcg, nid);
>  	unit = info->unit[shriner_id_to_index(shrinker->id)];
> -	return atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
> +	nr_deferred = atomic_long_xchg(&unit->nr_deferred[shriner_id_to_offset(shrinker->id)], 0);
> +	rcu_read_unlock();
> +
> +	return nr_deferred;
>  }

This adds two rcu_read_lock() sections to every call to
do_shrink_slab(). It's not at all clear ifrom any of the other code
that do_shrink_slab() now has internal rcu_read_lock() sections....

> @@ -464,18 +480,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (!mem_cgroup_online(memcg))
>  		return 0;
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		return 0;
> -
> -	info = shrinker_info_protected(memcg, nid);
> +again:
> +	rcu_read_lock();
> +	info = shrinker_info_rcu(memcg, nid);
>  	if (unlikely(!info))
>  		goto unlock;
>  
> -	for (; index < shriner_id_to_index(info->map_nr_max); index++) {
> +	if (index < shriner_id_to_index(info->map_nr_max)) {
>  		struct shrinker_info_unit *unit;
>  
>  		unit = info->unit[index];
>  
> +		/*
> +		 * The shrinker_info_unit will not be freed, so we can
> +		 * safely release the RCU lock here.
> +		 */
> +		rcu_read_unlock();

Why - what guarantees that the shrinker_info_unit exists at this
point? We hold no reference to it, we hold no reference to any
shrinker, etc. What provides this existence guarantee?

> +
>  		for_each_set_bit(offset, unit->map, SHRINKER_UNIT_BITS) {
>  			struct shrink_control sc = {
>  				.gfp_mask = gfp_mask,
> @@ -485,12 +506,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  			struct shrinker *shrinker;
>  			int shrinker_id = calc_shrinker_id(index, offset);
>  
> +			rcu_read_lock();
>  			shrinker = idr_find(&shrinker_idr, shrinker_id);
> -			if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
> -				if (!shrinker)
> -					clear_bit(offset, unit->map);
> +			if (unlikely(!shrinker || !shrinker_try_get(shrinker))) {
> +				clear_bit(offset, unit->map);
> +				rcu_read_unlock();
>  				continue;
>  			}
> +			rcu_read_unlock();
>  
>  			/* Call non-slab shrinkers even though kmem is disabled */
>  			if (!memcg_kmem_online() &&
> @@ -523,15 +546,20 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  					set_shrinker_bit(memcg, nid, shrinker_id);
>  			}
>  			freed += ret;
> -
> -			if (rwsem_is_contended(&shrinker_rwsem)) {
> -				freed = freed ? : 1;
> -				goto unlock;
> -			}
> +			shrinker_put(shrinker);

Ok, so why is this safe to call without holding the rcu read lock?
The global shrinker has to hold the rcu_read_lock() whilst calling
shrinker_put() to guarantee the validity of the list next pointer,
but we don't hold off RCU here so what guarantees a racing global
shrinker walk doesn't trip over this shrinker_put() call dropping
the refcount to zero and freeing occuring in a different context...


> +		/*
> +		 * We have already exited the read-side of rcu critical section
> +		 * before calling do_shrink_slab(), the shrinker_info may be
> +		 * released in expand_one_shrinker_info(), so reacquire the
> +		 * shrinker_info.
> +		 */
> +		index++;
> +		goto again;

With that, what makes the use of shrinker_info in
xchg_nr_deferred_memcg() in do_shrink_slab() coherent and valid?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
