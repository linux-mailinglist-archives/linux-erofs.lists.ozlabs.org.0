Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED977367B
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 04:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691461463;
	bh=HUGk8Gm4qWKcvYyYW1oMdtOdnxgdWZtLrf0WmvG8aOg=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=DkGI1tXjiVvYSTzcSFnHpteUtWJXeJqq34cQ8AK6Fi2+4OwdTyptIcnxGdufVIfKy
	 7WLWTt9nCYx8v4iB7c5C3/TDXA1OmYAFWZNBNndN8JXyoJoRaDKCSpO2JbkNQ6k7Bz
	 xUqgAG+A9+h5rMznHgNRAF+I2cJsIaKHBSDp1l3Qd57Yhkta9EGXxQUvX0OsbaataR
	 ujsAkPBON0CsGfFWlpODexh8CdLSrL8h0Lz0YNgBuA9QIHtDYDQO/G5ifVfNM7m0R2
	 jyEoARy0foV9IM6F/s58NSdFoZluVlAISFYIuhGAp7ozFQp0fLM2troNIIffF3Wogm
	 x1X52ucVDunsQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKcT34cy1z2ytK
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 12:24:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=E8R/sNcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKcSw6G2Vz2y1d
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 12:24:15 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc6624623cso18732655ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 19:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461454; x=1692066254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUGk8Gm4qWKcvYyYW1oMdtOdnxgdWZtLrf0WmvG8aOg=;
        b=byOEv6tWPPSKk9EPNnNkomcci8XJCiZ9TEFG/NCB4qMWZJ5x8jw73dq4niSOnxyVu6
         UWX7rIq4Hsu0laIuIBpGtwwB8lnzhAmDeqWLLPqhRGFe1WFdT3gOe2tg9a1Wf7gfCtR4
         0yTJdkysRquAdR1esOiLrYbFYfnI9hl85TQCd6NgYlSSBO+7wsS53EbUxSgx+w8D2m+3
         2xg18XgBfb/YfA2ke7+xgMfmQmvtEqnmh+9BEnF7iyFsLqMifz+e46ZvI0+xAI9rZkNt
         uribaUnDjjrBTj8Eyy55YjY7cStBNGi3AXVxaUHKYihFMGGc4/xd3m95ZYpWG/5FrGpV
         B8qQ==
X-Gm-Message-State: AOJu0YxOeU+RGfmf0hCf55mtUyRqNWckA4ATfGerZmm6d/XpoKxe09Sa
	hgYB+xtM3aIM5QwHr3tUNsL+WQ==
X-Google-Smtp-Source: AGHT+IEzrDGpXyLCXRNBmZGxK80nBmbnZ3Zc29NdEkVzSJ3QNXEJvOFh13D52+77LsVxnWz7HKqTHA==
X-Received: by 2002:a17:902:8692:b0:1b9:d307:c1df with SMTP id g18-20020a170902869200b001b9d307c1dfmr10722096plo.17.1691461453690;
        Mon, 07 Aug 2023 19:24:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm7583543plf.154.2023.08.07.19.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 19:24:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qTCOH-002Wjl-2u;
	Tue, 08 Aug 2023 12:24:09 +1000
Date: Tue, 8 Aug 2023 12:24:09 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 45/48] mm: shrinker: make global slab shrink lockless
Message-ID: <ZNGnSbiPN0lDLpSW@dread.disaster.area>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
 <20230807110936.21819-46-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110936.21819-46-zhengqi.arch@bytedance.com>
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

On Mon, Aug 07, 2023 at 07:09:33PM +0800, Qi Zheng wrote:
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index eb342994675a..f06225f18531 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/types.h>
> +#include <linux/refcount.h>
> +#include <linux/completion.h>
>  
>  #define SHRINKER_UNIT_BITS	BITS_PER_LONG
>  
> @@ -87,6 +89,10 @@ struct shrinker {
>  	int seeks;	/* seeks to recreate an obj */
>  	unsigned flags;
>  
> +	refcount_t refcount;
> +	struct completion done;
> +	struct rcu_head rcu;

Documentation, please. What does the refcount protect, what does the
completion provide, etc.

> +
>  	void *private_data;
>  
>  	/* These are for internal use */
> @@ -120,6 +126,17 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>  void shrinker_register(struct shrinker *shrinker);
>  void shrinker_free(struct shrinker *shrinker);
>  
> +static inline bool shrinker_try_get(struct shrinker *shrinker)
> +{
> +	return refcount_inc_not_zero(&shrinker->refcount);
> +}
> +
> +static inline void shrinker_put(struct shrinker *shrinker)
> +{
> +	if (refcount_dec_and_test(&shrinker->refcount))
> +		complete(&shrinker->done);
> +}
> +
>  #ifdef CONFIG_SHRINKER_DEBUG
>  extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
>  						  const char *fmt, ...);
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 1911c06b8af5..d318f5621862 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -2,6 +2,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/rwsem.h>
>  #include <linux/shrinker.h>
> +#include <linux/rculist.h>
>  #include <trace/events/vmscan.h>
>  
>  #include "internal.h"
> @@ -577,33 +578,42 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		goto out;
> -
> -	list_for_each_entry(shrinker, &shrinker_list, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
>  			.memcg = memcg,
>  		};
>  
> +		if (!shrinker_try_get(shrinker))
> +			continue;
> +
> +		/*
> +		 * We can safely unlock the RCU lock here since we already
> +		 * hold the refcount of the shrinker.
> +		 */
> +		rcu_read_unlock();
> +
>  		ret = do_shrink_slab(&sc, shrinker, priority);
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> +
>  		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> +		 * This shrinker may be deleted from shrinker_list and freed
> +		 * after the shrinker_put() below, but this shrinker is still
> +		 * used for the next traversal. So it is necessary to hold the
> +		 * RCU lock first to prevent this shrinker from being freed,
> +		 * which also ensures that the next shrinker that is traversed
> +		 * will not be freed (even if it is deleted from shrinker_list
> +		 * at the same time).
>  		 */

This needs to be moved to the head of the function, and document
the whole list walk, get, put and completion parts of the algorithm
that make it safe. There's more to this than "we hold a reference
count", especially the tricky "we might see the shrinker before it
is fully initialised" case....


.....
>  void shrinker_free(struct shrinker *shrinker)
>  {
>  	struct dentry *debugfs_entry = NULL;
> @@ -686,9 +712,18 @@ void shrinker_free(struct shrinker *shrinker)
>  	if (!shrinker)
>  		return;
>  
> +	if (shrinker->flags & SHRINKER_REGISTERED) {
> +		shrinker_put(shrinker);
> +		wait_for_completion(&shrinker->done);
> +	}

Needs a comment explaining why we need to wait here...
> +
>  	down_write(&shrinker_rwsem);
>  	if (shrinker->flags & SHRINKER_REGISTERED) {
> -		list_del(&shrinker->list);
> +		/*
> +		 * Lookups on the shrinker are over and will fail in the future,
> +		 * so we can now remove it from the lists and free it.
> +		 */

.... rather than here after the wait has been done and provided the
guarantee that no shrinker is running or will run again...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
