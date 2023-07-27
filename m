Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59307764F57
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 11:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690449610;
	bh=cb79b5va6gFfSJneJi5lY4rGeRwgOukMupryAUVW6kI=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gB4QkMZ0pw6WV6Xl1Y0ceCiCzifadQf4XQ4LmRCvLfcSMcaccjmVwSUCKzFQ0MSNS
	 aH03Sqk+WdrhwDG/hYwFZs1Z+GIFWP7B5PJzzZHzS6g+DUb1nYALayc81dmVcjUOp8
	 qI/zxQ1XuwKqwl38jYSX0SKM0GApT5fvk7SccZT5lvP29sVJB5U7T7RPB06PWlhmcy
	 57b3oddNRkug6LXFLHzcYNep7WQ5wrSgQteg2c8BZ4rdcLkunLXWN7WgYNuHVWdttV
	 TQx4w2hi4ljqlc/H84eXQNkWlmTMf7hkJEhBmjurSHiiwLPEgfFvcnVWwHDbgZgZvd
	 WUWmnDzrP/vZw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBQGL1SRfz3cCl
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 19:20:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=YCWSTu9U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=zhengqi.arch@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBQGG5Wqpz3bP2
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 19:20:05 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55b78bf0423so53662a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 02:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690449603; x=1691054403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb79b5va6gFfSJneJi5lY4rGeRwgOukMupryAUVW6kI=;
        b=M7Tq1cSmoFNxMxVJNy8Ey3v7+NSS4xcd8Az9I6hSk9EN8FwRksayejjAgscMFbHvNo
         SOb20ogwzgit4WzogQSkZO3Q1Ab1g9fjIUJI9oOutG2xsGaF+AuWQ/T24uFj5YEYin9z
         34LfYld1AUG/6X8usTHDNyifkhECm7k6u6YKlx9Sl7IuBjoR5LaoyBjR7ZT/EcI67Pge
         Flmif+IzY8MLzumy+gkS4HdL38/Fo9ng0pfAQWpG0ynaOZish5u5C+HGf1+zy0ysSU4Z
         Vh5b4ISOkPLsUunVlhDMbRdNVeCWEjhIMYDRBh0rn6CskUClUcS0z/spww6EIDK7UkDt
         /uYw==
X-Gm-Message-State: ABy/qLbo3HbLyCntop7/M4JsVqkLg5dzI9gBuXb/7lKu39aue/dhgezm
	F3GtzFIeAErReRzguVzMslHASw==
X-Google-Smtp-Source: APBJJlH+dm0mCsob/js+yZXnXAfwEH4KDToex0aS0MQ56gbjyJxo+xxDZzOa2lZ9gy3mjvwdmWQa2g==
X-Received: by 2002:a17:902:da82:b0:1b8:811:b079 with SMTP id j2-20020a170902da8200b001b80811b079mr5785873plx.0.1690449602958;
        Thu, 27 Jul 2023 02:20:02 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001bbb7d8fff2sm1109046plg.116.2023.07.27.02.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 02:20:02 -0700 (PDT)
Message-ID: <5f1b85b8-3655-1700-4d16-fa056b31ceeb@bytedance.com>
Date: Thu, 27 Jul 2023 17:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 40/49] xfs: dynamically allocate the xfs-qm shrinker
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-41-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-41-zhengqi.arch@bytedance.com>
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
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org, cluster-devel@redhat.com, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org, linux-bcache@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/27 16:04, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the xfs-qm shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct xfs_quotainfo.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   fs/xfs/xfs_qm.c | 26 +++++++++++++-------------
>   fs/xfs/xfs_qm.h |  2 +-
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 6abcc34fafd8..032f0a208bd2 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -504,8 +504,7 @@ xfs_qm_shrink_scan(
>   	struct shrinker		*shrink,
>   	struct shrink_control	*sc)
>   {
> -	struct xfs_quotainfo	*qi = container_of(shrink,
> -					struct xfs_quotainfo, qi_shrinker);
> +	struct xfs_quotainfo	*qi = shrink->private_data;
>   	struct xfs_qm_isolate	isol;
>   	unsigned long		freed;
>   	int			error;
> @@ -539,8 +538,7 @@ xfs_qm_shrink_count(
>   	struct shrinker		*shrink,
>   	struct shrink_control	*sc)
>   {
> -	struct xfs_quotainfo	*qi = container_of(shrink,
> -					struct xfs_quotainfo, qi_shrinker);
> +	struct xfs_quotainfo	*qi = shrink->private_data;
>   
>   	return list_lru_shrink_count(&qi->qi_lru, sc);
>   }
> @@ -680,16 +678,18 @@ xfs_qm_init_quotainfo(
>   	if (XFS_IS_PQUOTA_ON(mp))
>   		xfs_qm_set_defquota(mp, XFS_DQTYPE_PROJ, qinf);
>   
> -	qinf->qi_shrinker.count_objects = xfs_qm_shrink_count;
> -	qinf->qi_shrinker.scan_objects = xfs_qm_shrink_scan;
> -	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
> -	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
> -
> -	error = register_shrinker(&qinf->qi_shrinker, "xfs-qm:%s",
> -				  mp->m_super->s_id);
> -	if (error)
> +	qinf->qi_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "xfs-qm:%s",
> +					   mp->m_super->s_id);
> +	if (!qinf->qi_shrinker)

Here should set error to -ENOMEM, will fix.

>   		goto out_free_inos;
>   
> +	qinf->qi_shrinker->count_objects = xfs_qm_shrink_count;
> +	qinf->qi_shrinker->scan_objects = xfs_qm_shrink_scan;
> +	qinf->qi_shrinker->seeks = DEFAULT_SEEKS;
> +	qinf->qi_shrinker->private_data = qinf;
> +
> +	shrinker_register(qinf->qi_shrinker);
> +
>   	return 0;
>   
>   out_free_inos:
> @@ -718,7 +718,7 @@ xfs_qm_destroy_quotainfo(
>   	qi = mp->m_quotainfo;
>   	ASSERT(qi != NULL);
>   
> -	unregister_shrinker(&qi->qi_shrinker);
> +	shrinker_free(qi->qi_shrinker);
>   	list_lru_destroy(&qi->qi_lru);
>   	xfs_qm_destroy_quotainos(qi);
>   	mutex_destroy(&qi->qi_tree_lock);
> diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
> index 9683f0457d19..d5c9fc4ba591 100644
> --- a/fs/xfs/xfs_qm.h
> +++ b/fs/xfs/xfs_qm.h
> @@ -63,7 +63,7 @@ struct xfs_quotainfo {
>   	struct xfs_def_quota	qi_usr_default;
>   	struct xfs_def_quota	qi_grp_default;
>   	struct xfs_def_quota	qi_prj_default;
> -	struct shrinker		qi_shrinker;
> +	struct shrinker		*qi_shrinker;
>   
>   	/* Minimum and maximum quota expiration timestamp values. */
>   	time64_t		qi_expiry_min;
