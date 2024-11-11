Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 464C29C3682
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 03:25:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xmtgv6v8xz2yYf
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 13:25:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731291945;
	cv=none; b=fllkgSmrRC8U+SBNQtV2OiOYW6fly0SI+MGLLo78Wd8/8yFpePtxIOiLq82ADPNIKmwERkCJoE9/kitgnsmG29HVctfbbUwAMse8N9ztBP/2MhYV3IQowWfkxEOePC1P3TxtLlJg9/DQQQOXKaQEzgZVyPvkuXEcJC/iR6U6gMio++Bzuk9HdPvNIOV04OzjEzmkST7K/BhKGWP3SHtaNDq/TnCQmx+ySMLGnbJD5SO8ossyyLj3ZE/2iw21VkHKmOmMzhupSmT+iEiYX18qLG7F9O1836rtANjInFcLIfUdA7K6zoreDberW+3LWnqUggBXtXwo963eqPUe89IX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731291945; c=relaxed/relaxed;
	bh=J7nJT3kT/1BIUWoxqyiSR8GeWtZCte2Tm+Vp1zGFxtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxrQCFyTIg+MEm3jpssz0U4BCG0CLSXpF3iIqZ8LhEXSx4D7pvhFQkn6LIyFOdiBrn04Gu5Ea3ycJ2tkNL2oBSumCWD9msmCihKQM1mwwMxNqoCzbs3a3Ij4o+S+cu/ROLtXOf7P8Vd8btBPEmnr8fiwYzxMqankYTGbmGPrSizI+3ipUnjUfZUgE+tPMlQ+c9iJazr3skMG76zkfxL7n+jFk5UROy7zbb7awfm+35CV9QN/DqbwpQ/anI2owsLVNts7cDjtBtOjuLUlpXtCA5aiHHfa2RqcP6nugSE8T4UfnL3VM+9A+AnnRFBXGLe2zqBaEKt6b2m6qVGxCeD5Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmFzjfb4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VmFzjfb4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xmtgk1WHqz2xrk
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 13:25:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731291930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J7nJT3kT/1BIUWoxqyiSR8GeWtZCte2Tm+Vp1zGFxtQ=;
	b=VmFzjfb4wB+gvXS+zYuywK/KZ7YtJFDSQhs+axpUD+Bw01W7uO0/EpTUErfiw/dLtVJzX3dHrBhymin1JhOsHGakgjvkZK5VbupFhp3E3ijFlGck7zryouq5Vrs3v0p3iB5Dz6fgL35S/6/JRenwPzRpzeAyvSbYufSvZtJKZG8=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ3wSZr_1731291929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:25:30 +0800
Message-ID: <f0fb91d9-6809-4efa-a5ab-b8d38fe5dbdc@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:25:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: free pclusters if no cached folio attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20241101063821.3021559-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241101063821.3021559-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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

On 2024/11/1 14:38, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
> change since v1:
>   - rebase this patch on "sunset z_erofs_workgroup` series
>   - remove check on pcl->partial and get rid of `be->try_free`
>   - update test results base on 6.6 kernel
> ---
>   fs/erofs/zdata.c | 59 +++++++++++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 4558e6a98336..1a7f56259f45 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -896,14 +896,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
>   			struct z_erofs_pcluster, rcu));
>   }
>   
> -static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
> +static bool erofs_prepare_to_release_pcluster(struct erofs_sb_info *sbi,
>   					  struct z_erofs_pcluster *pcl)
>   {
> -	int free = false;
> -
> -	spin_lock(&pcl->lockref.lock);
>   	if (pcl->lockref.count)
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * Note that all cached folios should be detached before deleted from
> @@ -911,7 +908,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>   	 * orphan old pcluster when the new one is available in the tree.
>   	 */
>   	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
> -		goto out;
> +		return false;
>   
>   	/*
>   	 * It's impossible to fail after the pcluster is freezed, but in order
> @@ -920,8 +917,18 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>   	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
>   
>   	lockref_mark_dead(&pcl->lockref);
> -	free = true;
> -out:
> +	return true;
> +}
> +
> +static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
> +					  struct z_erofs_pcluster *pcl)
> +{
> +	bool free = false;
> +
> +	/* Using trylock to avoid deadlock with z_erofs_put_pcluster() */
> +	if (!spin_trylock(&pcl->lockref.lock))
> +		return free;

Thanks for the patch!

I think no need to move the common shrink path into trylock,
instead

> +	free = erofs_prepare_to_release_pcluster(sbi, pcl);
>   	spin_unlock(&pcl->lockref.lock);
>   	if (free) {
>   		atomic_long_dec(&erofs_global_shrink_cnt);
> @@ -953,16 +960,27 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
>   	return freed;
>   }
>   
> -static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
> +static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
> +		struct z_erofs_pcluster *pcl, bool try_free)
>   {
> +	bool free = false;
> +
>   	if (lockref_put_or_lock(&pcl->lockref))
>   		return;
>   
>   	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
> -	if (pcl->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--pcl->lockref.count;
> +	if (--pcl->lockref.count == 0) {
> +		if (try_free) {

I think here since we are really doing _try free_, so just

			spin_unlock(&pcl->lockref.lock);

			xa_lock(&sbi->managed_pslots);
			free = erofs_try_to_release_pcluster(sbi, pcl);
			xa_unlock(&sbi->managed_pslots);

is enough. IOWs, if other users race with it, I think the other user
will be responsible for this.

Thanks,
Gao Xiang

> +			xa_lock(&sbi->managed_pslots);
> +			free = erofs_prepare_to_release_pcluster(sbi, pcl);
> +			xa_unlock(&sbi->managed_pslots);
> +		}
> +		if (!free)
> +			atomic_long_inc(&erofs_global_shrink_cnt);
> +	}
>   	spin_unlock(&pcl->lockref.lock);
> +	if (free)
> +		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
