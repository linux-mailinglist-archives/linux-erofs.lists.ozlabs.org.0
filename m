Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1EF762D46
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 09:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690356375;
	bh=+zeJUC9bLKU1rvuVX6lYw88hUmzqKAeHPtzffozeycY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KkAX9Hz0OB+Zlpb1bAwzuJVWEGkTqp53szV//E+MRPSg9YMj2gxDhcWIDyPDfervI
	 ghjd5zj6sYx0iuF64O1esaf+NyMYG0spWS3o0JpsjIBpzrKiXPRVwAmY0JyVjjYLOl
	 jENaXUOTLnqJvyx82eyOkkIOtyvR/GtQKaVjQZvJKeUMQpt/L2stqazkYZ7for++Oq
	 aIcXtVeq5CfXVfNIGndWnOk+4dN0GU6cNNwfxoPUPxVs0LF2DG7iH6k9FVmiwfkX2k
	 HyJIzTKS09ZJO8IKCAAPDOIlKvOgnxyzwI5SMeNd04lcQDw+7LHY9gwAH5Bv5R/1Jj
	 2w9Rcb3DLSO7A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9lnM04Ncz2yVF
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 17:26:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fromorbit-com.20221208.gappssmtp.com header.i=@fromorbit-com.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=tq09HWgU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fromorbit.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=david@fromorbit.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9lnH16CZz2yVF
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 17:26:10 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5929171b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 00:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690356367; x=1690961167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zeJUC9bLKU1rvuVX6lYw88hUmzqKAeHPtzffozeycY=;
        b=eHClbMyE8MKUkFOlj4xQW7bELwaORnm2PJ0Z73tF/08ozgyr0cb2RDvnBxrEDQU7XJ
         rv6v5SAJ56kg6meFIpR5xY+sriH1o9Bj+Q7VlWoxs8cUtm5H4jB5pGTbuDDiteAgWISI
         M1EHdABtOsgB+kNlCMFfB8Iw3vFfCXMNah4wXzSpB4AregF5GVTDWejD4MWo2skoOKha
         iQSxIFuv8AA3cC3f3OTU/c2rgpNX61N7CysRBpft0kMevYjeO7HhplexRxBMeoCknhBW
         4kyB0T1pHNE3ratIZ+dtxBHwN7M6czvKHo1/DA1NdmX7OLFCCYWMTeEmYNzfCYcEg+bw
         d0Aw==
X-Gm-Message-State: ABy/qLYOwnuNp+pkrr3aMun6c1pfTO3cSa8b0YNZ2Ki7xdkWUTUH/FKU
	lsPpM27lqTLz4lkW05YUcGoSpA==
X-Google-Smtp-Source: APBJJlH5b0OufxURLtAQUAf05ozn4hmRBD/Qn/v7OHyNHGefhP7kmXIN/eqXKV4z4NaYW1ZZNRUFVA==
X-Received: by 2002:a05:6a00:a0d:b0:67a:a906:9edb with SMTP id p13-20020a056a000a0d00b0067aa9069edbmr1921084pfh.30.1690356367307;
        Wed, 26 Jul 2023 00:26:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id r5-20020a62e405000000b00666e649ca46sm10751809pfh.101.2023.07.26.00.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:26:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qOYuK-00AfFC-0I;
	Wed, 26 Jul 2023 17:26:04 +1000
Date: Wed, 26 Jul 2023 17:26:04 +1000
To: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 03/47] mm: shrinker: add infrastructure for
 dynamically allocating shrinker
Message-ID: <ZMDKjBCZH6+OP5gW@dread.disaster.area>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-4-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724094354.90817-4-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org, x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org, linux-arm-msm@vger.kernel.org, linux-nfs@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz, linux-raid@vger.kernel.org, brauner@kernel.org, tytso@mit.edu, gregkh@linuxfoundation.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, senozhatsky@chromium.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 24, 2023 at 05:43:10PM +0800, Qi Zheng wrote:
> Currently, the shrinker instances can be divided into the following three
> types:
> 
> a) global shrinker instance statically defined in the kernel, such as
>    workingset_shadow_shrinker.
> 
> b) global shrinker instance statically defined in the kernel modules, such
>    as mmu_shrinker in x86.
> 
> c) shrinker instance embedded in other structures.
> 
> For case a, the memory of shrinker instance is never freed. For case b,
> the memory of shrinker instance will be freed after synchronize_rcu() when
> the module is unloaded. For case c, the memory of shrinker instance will
> be freed along with the structure it is embedded in.
> 
> In preparation for implementing lockless slab shrink, we need to
> dynamically allocate those shrinker instances in case c, then the memory
> can be dynamically freed alone by calling kfree_rcu().
> 
> So this commit adds the following new APIs for dynamically allocating
> shrinker, and add a private_data field to struct shrinker to record and
> get the original embedded structure.
> 
> 1. shrinker_alloc()
> 
> Used to allocate shrinker instance itself and related memory, it will
> return a pointer to the shrinker instance on success and NULL on failure.
> 
> 2. shrinker_free_non_registered()
> 
> Used to destroy the non-registered shrinker instance.

This is a bit nasty

> 
> 3. shrinker_register()
> 
> Used to register the shrinker instance, which is same as the current
> register_shrinker_prepared().
> 
> 4. shrinker_unregister()

rename this "shrinker_free()" and key the two different freeing
cases on the SHRINKER_REGISTERED bit rather than mostly duplicating
the two.

void shrinker_free(struct shrinker *shrinker)
{
	struct dentry *debugfs_entry = NULL;
	int debugfs_id;

	if (!shrinker)
		return;

	down_write(&shrinker_rwsem);
	if (shrinker->flags & SHRINKER_REGISTERED) {
		list_del(&shrinker->list);
		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
	} else if (IS_ENABLED(CONFIG_SHRINKER_DEBUG)) {
		kfree_const(shrinker->name);
	}

	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
		unregister_memcg_shrinker(shrinker);
	up_write(&shrinker_rwsem);

	if (debugfs_entry)
		shrinker_debugfs_remove(debugfs_entry, debugfs_id);

	kfree(shrinker->nr_deferred);
	kfree(shrinker);
}
EXPORT_SYMBOL_GPL(shrinker_free);

-- 
Dave Chinner
david@fromorbit.com
