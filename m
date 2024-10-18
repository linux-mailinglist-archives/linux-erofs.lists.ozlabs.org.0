Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A09A322A
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 03:44:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XV6vG2zBnz3bm7
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Oct 2024 12:44:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729215865;
	cv=none; b=M3b7ic1ND7IXsX8FzDJpUAILpsqaWAdoY7evymS25Wj2W8L1UHa1Zm/1rbvbCGytSzRDqlXxgvd6+rOWPHiqiggOinK5ADt3NqG32se/YJaU2MlGIy17F6dJLcO/GMa1XHlhvjdsad0+IAcm6ca7dBmttxOzAmvumy6yC+7tMEM8MpNqd9+OLLzH+qTthomTLwGUjau9i3ISXd8x7ksViXH3z56sjafy2GpM5jgP7gaT2QszjF56hup1FbonV4/09SNPhnaS9o8XrUSlz/aZxT1/ctY154+ltG2sRqP/Zu3uXGVB020o7LgQS4CztRKDt3U2zQJAo4Nj5xRstndKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729215865; c=relaxed/relaxed;
	bh=LrQw1Xi9Sb0d6T0yY4LpVBM0HbA4kS8pDDl44szB65E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d90DEDgTu5OA8ZCr10+zDzvt4pz4RigT2J6ET2UfXfwsl1ScH8ruyWPSRW4TVXwAJy5vlqv4RMNP/dNyVrb4EqV8I7hz3wpqwy7fFOqJP0CdEK/eqG2ZmCeitHpZdr7Duq/BX+lVG1lDHHN0E6mz91uOXTQfZbnMh8FvMO+m/cYCouvgrv6R0ImPLglCdopDzbcKHkzAgGWhqt425d9wwTFXa3+WD3ZBRhvF3g+74QnM4Gz9axDRtX1pIfw675FeHa24Q79bfq+JDtJ/qhGvpqE1kRiF+wpbqWe5KG14w+FJiefX/79FrMyv070Lih7AZQkLCqVGxxwp4YW62hhqUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xlPLJJAJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xlPLJJAJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XV6v73qHwz2xGw
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Oct 2024 12:44:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729215849; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LrQw1Xi9Sb0d6T0yY4LpVBM0HbA4kS8pDDl44szB65E=;
	b=xlPLJJAJlwb6W8OzyHSXGcvNTpQ+vK9yBrVo7+i+3m+V92H5YriUy9nGJJ88NIIdIpC7ahHugkX3LHUtau8XNER+N635sVJfL9DPfsLnTUSkAkeTlFZvXHThFgdDASaJIzC1Vb/6DiPzeZs2TNaufKWgtl3DK8zZTvq+H4OZEbw=
Received: from 30.27.73.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHMCYpl_1729215846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 09:44:08 +0800
Message-ID: <588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com>
Date: Fri, 18 Oct 2024 09:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: free pcluster right after decompression if
 possible
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240930140424.4049195-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240930140424.4049195-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

Thanks for the work!  Please rebase this work on
my "sunset z_erofs_workgroup` series.

On 2024/9/30 22:04, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> pages, its corresponding struct z_erofs_pcluster will be freed. This

Subject: free pclusters if no cached folio attached

cached folios, its corresponding `struct z_erofs_pcluster`...

> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for struct z_erofs_pcluster.
> 
> The tables below show approximately a 95% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for struct
					for `struct z_erofs_pcluster`

> z_erofs_pcluster after applying this patch. The results were obtained by
> performing a test to copy a 2.1 GB partition on ARM64 Android devices
> running the 5.15 kernel with an 8-core CPU and 8GB of memory.

I guess you could try to use more recent kernels for testing instead?

> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   3152    |   160    | -94.92% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 44503200  | 2293760  | -94.84% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/internal.h |  3 ++-
>   fs/erofs/zdata.c    | 14 ++++++++---
>   fs/erofs/zutil.c    | 58 +++++++++++++++++++++++++++++----------------
>   3 files changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..17b04bfd743f 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -456,7 +456,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>   void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
> -void erofs_workgroup_put(struct erofs_workgroup *grp);
> +void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
> +		bool can_released);
>   struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
>   					     pgoff_t index);
>   struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8936790618c6..656fd65aec33 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -888,7 +888,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>   	 * any longer if the pcluster isn't hosted by ourselves.
>   	 */
>   	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
> -		erofs_workgroup_put(&pcl->obj);
> +		erofs_workgroup_put(EROFS_I_SB(fe->inode), &pcl->obj, false);
>   
>   	fe->pcl = NULL;
>   }
> @@ -1046,6 +1046,9 @@ struct z_erofs_decompress_backend {
>   	struct list_head decompressed_secondary_bvecs;
>   	struct page **pagepool;
>   	unsigned int onstack_used, nr_pages;
> +
> +	/* whether the pcluster can be released after its decompression */
> +	bool try_free;
>   };
>   
>   struct z_erofs_bvec_item {
> @@ -1244,12 +1247,15 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   		WRITE_ONCE(pcl->compressed_bvecs[0].page, NULL);
>   		put_page(page);
>   	} else {
> +		be->try_free = true;
>   		/* managed folios are still left in compressed_bvecs[] */
>   		for (i = 0; i < pclusterpages; ++i) {
>   			page = be->compressed_pages[i];
>   			if (!page ||
> -			    erofs_folio_is_managed(sbi, page_folio(page)))
> +			    erofs_folio_is_managed(sbi, page_folio(page))) {
> +				be->try_free = false;
>   				continue;
> +			}
>   			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
>   			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
>   		}
> @@ -1285,6 +1291,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>   	if (be->decompressed_pages != be->onstack_pages)
>   		kvfree(be->decompressed_pages);
>   
> +	be->try_free = be->try_free && !pcl->partial;

I think no need to check `pcl->partial`.

>   	pcl->length = 0;
>   	pcl->partial = true;
>   	pcl->multibases = false;
> @@ -1320,7 +1327,8 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>   		if (z_erofs_is_inline_pcluster(be.pcl))
>   			z_erofs_free_pcluster(be.pcl);
>   		else
> -			erofs_workgroup_put(&be.pcl->obj);
> +			erofs_workgroup_put(EROFS_SB(io->sb), &be.pcl->obj,
> +					be.try_free);

We could just move

if (z_erofs_is_inline_pcluster(be.pcl))
	z_erofs_free_pcluster(be.pcl);
else
	z_erofs_put_pcluster(be.pcl);

into the end of z_erofs_decompress_pcluster() and
get rid of `be->try_free`;



>   	}
>   	return err;
>   }
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 37afe2024840..cf59ba6a2322 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -285,26 +285,11 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
>   	erofs_workgroup_free_rcu(grp);
>   }
>   
> -void erofs_workgroup_put(struct erofs_workgroup *grp)
> -{
> -	if (lockref_put_or_lock(&grp->lockref))
> -		return;
> -
> -	DBG_BUGON(__lockref_is_dead(&grp->lockref));
> -	if (grp->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--grp->lockref.count;
> -	spin_unlock(&grp->lockref.lock);
> -}
> -
> -static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +static bool erofs_prepare_to_release_workgroup(struct erofs_sb_info *sbi,
>   					   struct erofs_workgroup *grp)
>   {
> -	int free = false;
> -
> -	spin_lock(&grp->lockref.lock);
>   	if (grp->lockref.count)
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * Note that all cached pages should be detached before deleted from
> @@ -312,7 +297,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>   	 * the orphan old workgroup when the new one is available in the tree.
>   	 */
>   	if (erofs_try_to_free_all_cached_folios(sbi, grp))
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * It's impossible to fail after the workgroup is freezed,
> @@ -322,14 +307,47 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>   	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
>   
>   	lockref_mark_dead(&grp->lockref);
> -	free = true;
> -out:
> +	return true;
> +}
> +
> +static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +					   struct erofs_workgroup *grp)
> +{
> +	bool free = false;
> +
> +	/* Using trylock to avoid deadlock with erofs_workgroup_put() */
> +	if (!spin_trylock(&grp->lockref.lock))
> +		return free;
> +	free = erofs_prepare_to_release_workgroup(sbi, grp);
>   	spin_unlock(&grp->lockref.lock);
>   	if (free)
>   		__erofs_workgroup_free(grp);
>   	return free;
>   }
>   
> +void erofs_workgroup_put(struct erofs_sb_info *sbi, struct erofs_workgroup *grp,
> +		bool try_free)
> +{
> +	bool free = false;
> +
> +	if (lockref_put_or_lock(&grp->lockref))
> +		return;
> +
> +	DBG_BUGON(__lockref_is_dead(&grp->lockref));
> +	if (--grp->lockref.count == 0) {
> +		atomic_long_inc(&erofs_global_shrink_cnt);
> +
> +		if (try_free) {
> +			xa_lock(&sbi->managed_pslots);
> +			free = erofs_prepare_to_release_workgroup(sbi, grp);
> +			xa_unlock(&sbi->managed_pslots);
> +		}
> +	}
> +	spin_unlock(&grp->lockref.lock);
> +	if (free)
> +		__erofs_workgroup_free(grp);

need to wait for a RCU grace period.

Thanks,
Gao Xiang
