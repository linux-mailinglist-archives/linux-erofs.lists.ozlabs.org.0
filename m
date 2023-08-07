Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A8773524
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 01:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691451656;
	bh=0xqamAux0UTVG6klbJHwJNM84FqVsjBhqmY+h06Y7S4=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I7AZ0HkB4Y9ADMIeKulu3PaZiNYvZOS2XUrXxH/YLygBhouMdA5Pu2WNiqpbS/IkW
	 QB+H1spitskUvtzp4QoYfrvkkY+Jr4ITEH29hUBNZkOyQS6ksfUVWXBw6TtMlw4oLK
	 5+YEXwa+nVzGYiUqRzOQSwPLhpUb6PbwZrfRLL3FzTH4rk8TbRqpgWGZ3P2JR7A/lv
	 dq4uCZr7a3RzLtZheXn8no2S0J5Jq83eHQOS311swEsQbxuI1oEU1+2tv8gMUlU45U
	 pgP72DQ0ZVHe1SBMjkt554I2UxeGDLV6XIvoSewXS3PuTaG+GG52aWkIpFk2DYlB4F
	 k6No6GwsQwIxw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKXrS4tL5z3d89
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 09:40:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=adlg0mZ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKXZW6FLRz3dDy
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 09:28:51 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b9964ae2so3587540b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Aug 2023 16:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691450928; x=1692055728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xqamAux0UTVG6klbJHwJNM84FqVsjBhqmY+h06Y7S4=;
        b=hYvvEOTlCI+fBRKL8AEZXp5V3+eR7SUdLrh3dIjVV5732sIcnMizGrAzYBMn9Wt2w3
         MgpqGZTSUQ87sIG5RPsOTr6XLKEG+mjkicdFsVoXuHNLMWmMrTe4CJH6d7tCL/4FCIAz
         F5yWTlyoW33UA4nrXk1sRlEzdRW+rLByb55sgZLygxEgUXAMSRkW5MG1ZidqBDETqC6e
         h37AzsZcOFzEXUEtPBXYs7yWeC3Mu46vawK01sPpLQWUnDp4eieN8A791q5y5sQtG/94
         Tyc9m0IKSG+nx+rYqb6W5lr4LpSs+s7aLi9km+XQ+YfhKnMEpQCPKFbPMCTaZK1xv8ps
         pzPQ==
X-Gm-Message-State: AOJu0YzrMZUj9XXaDHt+6bXlXY90AWY5J+UObtQklF8gf5d0tZ+Ieu9Z
	cYn4WYbWEftfxzddWbWee5Dkfg==
X-Google-Smtp-Source: AGHT+IHWcHOenJQfOaWa9c7YDyMdy3l3j1H0rEzsEcwqog5HJ9HhPve3KCBNDXb4QQT+YEAg/cljWw==
X-Received: by 2002:a05:6a20:8e04:b0:13c:8e50:34b8 with SMTP id y4-20020a056a208e0400b0013c8e5034b8mr12892217pzj.35.1691450928413;
        Mon, 07 Aug 2023 16:28:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-166-213.pa.nsw.optusnet.com.au. [49.180.166.213])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b0068620bee456sm6663729pfd.209.2023.08.07.16.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:28:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qT9eW-002TeM-1d;
	Tue, 08 Aug 2023 09:28:44 +1000
Date: Tue, 8 Aug 2023 09:28:44 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 45/48] mm: shrinker: make global slab shrink lockless
Message-ID: <ZNF+LLUpKWHDEG1u@dread.disaster.area>
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
> The shrinker_rwsem is a global read-write lock in shrinkers subsystem,
> which protects most operations such as slab shrink, registration and
> unregistration of shrinkers, etc. This can easily cause problems in the
> following cases.
....
> This commit uses the refcount+RCU method [5] proposed by Dave Chinner
> to re-implement the lockless global slab shrink. The memcg slab shrink is
> handled in the subsequent patch.
....
> ---
>  include/linux/shrinker.h | 17 ++++++++++
>  mm/shrinker.c            | 70 +++++++++++++++++++++++++++++-----------
>  2 files changed, 68 insertions(+), 19 deletions(-)

There's no documentation in the code explaining how the lockless
shrinker algorithm works. It's left to the reader to work out how
this all goes together....

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

What does the refcount protect, why do we need the completion, etc?

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

This comment really should be at the head of the function,
describing the algorithm used within the function itself. i.e. how
reference counts are used w.r.t. the rcu_read_lock() usage to
guarantee existence of the shrinker and the validity of the list
walk.

I'm not going to remember all these little details when I look at
this code in another 6 months time, and having to work it out from
first principles every time I look at the code will waste of a lot
of time...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
