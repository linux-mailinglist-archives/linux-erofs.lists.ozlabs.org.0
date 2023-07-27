Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFB766015
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jul 2023 00:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690498791;
	bh=8CTrna5t3S7P99W+zrM1I2ApZYIkXTVQedDFVAI6oIw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=R8WgbMRiw8mYVdJNj/ZIkMqTAsicXyPyjfwaOp2W7dknferI3LNZhz6gx1vHblkOl
	 X2AYSJkoFBUTZJb2JOibN3EUGDB4JDzwezLQE4OVjzAEt67cYPSTEMZcq/6TfWHLyT
	 3Ns0DQYk5FrCDtyHcXasYGFZI3WHQgho3DlIalzOjqQp7nq4tUSu8shTvjGAtobSMl
	 e1EIQf1E5w8OfPOCHSkptVc04MubzrhGEh0n5I22Dc+3EjNe3PfEkpn9c0Pb6079Me
	 yOMBUa4l+UoUBmitAf7w/g/7YzPlhwdh5mHh83qXGZkOlDWCqfLeJUO4WTzTQQLSEf
	 UPZOO1Uo+AUyQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBmS74NFTz2xgt
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jul 2023 08:59:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=X7pt5Ouy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBmS36vWGz2xgt
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jul 2023 08:59:45 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so940094b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 15:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498781; x=1691103581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CTrna5t3S7P99W+zrM1I2ApZYIkXTVQedDFVAI6oIw=;
        b=R4RG8L6osMMmop8J0daO5TDhZcUbc1Av5VG1xS6waIN9U4qOjh0AgmysIQ4wFYf4cS
         B4g29WFuJLvBVsu3vraN3P1qH43nTkcLSaZNXx+5ItKE+QQWNF3iGbCuc9WurrFh2gqb
         mgP5HJJBr5KUNUAkxm6QywJWVIZoktR+DtlK2ft7lnHVfGTGBJkpBnJGY4e8B3osWfwG
         hi8gHyUICfzTw3hkU6BIEIBf7vc5fXVoNNaCxg1FjaiaD/X/tqCt0vRsLrDXedEtxIzt
         WxEacJT4dFODu+loS1O6vWqW6xc9wLfONwZlHSnZMOWbC22CCSTf9Egmr61xyB8Gv0Wk
         pnEQ==
X-Gm-Message-State: ABy/qLaWyjj6LM+uUyPrqrCfslI67hoT74kvva0lOf44jjqCqYOcHcbi
	w47Jy1Uliotm812rR9+IkWGC6Q==
X-Google-Smtp-Source: APBJJlGFE8oAcAZu2XvzWjC5bjR81v7OIjjTfZ8m+EaEe6Rjpq3cuwvHN3I08mErFwOZJpneP9Ly1g==
X-Received: by 2002:a05:6a00:17a8:b0:64d:42b9:6895 with SMTP id s40-20020a056a0017a800b0064d42b96895mr61072pfg.5.1690498780930;
        Thu, 27 Jul 2023 15:59:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b0068702b66ab1sm1115813pfn.174.2023.07.27.15.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 15:59:40 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qP9xJ-00BKKZ-1O;
	Fri, 28 Jul 2023 08:59:37 +1000
Date: Fri, 28 Jul 2023 08:59:37 +1000
To: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 28/49] dm zoned: dynamically allocate the
 dm-zoned-meta shrinker
Message-ID: <ZML22YJi5vPBDEDj@dread.disaster.area>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-29-zhengqi.arch@bytedance.com>
 <baaf7de4-9a0e-b953-2b6a-46e60c415614@kernel.org>
 <56ee1d92-28ee-81cb-9c41-6ca7ea6556b0@bytedance.com>
 <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba0868b2-9f90-3d81-1c91-8810057fb3ce@kernel.org>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, brauner@kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, dri-devel@lists.freedesktop.org, Muchun Song <songmuchun@bytedance.com>, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu, netdev@vger.kernel.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 27, 2023 at 07:20:46PM +0900, Damien Le Moal wrote:
> On 7/27/23 17:55, Qi Zheng wrote:
> >>>           goto err;
> >>>       }
> >>>   +    zmd->mblk_shrinker->count_objects = dmz_mblock_shrinker_count;
> >>> +    zmd->mblk_shrinker->scan_objects = dmz_mblock_shrinker_scan;
> >>> +    zmd->mblk_shrinker->seeks = DEFAULT_SEEKS;
> >>> +    zmd->mblk_shrinker->private_data = zmd;
> >>> +
> >>> +    shrinker_register(zmd->mblk_shrinker);
> >>
> >> I fail to see how this new shrinker API is better... Why isn't there a
> >> shrinker_alloc_and_register() function ? That would avoid adding all this code
> >> all over the place as the new API call would be very similar to the current
> >> shrinker_register() call with static allocation.
> > 
> > In some registration scenarios, memory needs to be allocated in advance.
> > So we continue to use the previous prealloc/register_prepared()
> > algorithm. The shrinker_alloc_and_register() is just a helper function
> > that combines the two, and this increases the number of APIs that
> > shrinker exposes to the outside, so I choose not to add this helper.
> 
> And that results in more code in many places instead of less code + a simple
> inline helper in the shrinker header file...

It's not just a "simple helper" - it's a function that has to take 6
or 7 parameters with a return value that must be checked and
handled.

This was done in the first versions of the patch set - the amount of
code in each caller does not go down and, IMO, was much harder to
read and determine "this is obviously correct" that what we have
now.

> So not adding that super simple
> helper is not exactly the best choice in my opinion.

Each to their own - I much prefer the existing style/API over having
to go look up a helper function every time I want to check some
random shrinker has been set up correctly....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
