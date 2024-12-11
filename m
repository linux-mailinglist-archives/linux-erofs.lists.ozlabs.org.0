Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6989EC3FF
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 05:32:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7N4C3dnPz30Vb
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 15:32:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.120.2.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733891545;
	cv=none; b=KuYvNeikjtCQFd2nQyCp3X89A+LGueEFLOEPAhI2yTvefIPGK9RM9LcAXsQ1SfGnb4Cnh6Jb1LvTaudAucNtuLlRuGEF5n+eOgZ1t/BWGlTG1UuXU+cJgdXnYmfIC7B7phIwIm117gTO6rGQgBNUybTTocqKbqhT0GB9MPTEjFnnDRXaFSc+S3r+mSHSP3vGdB5dZdKatLjLcHedKw3ngcAnmvI/AinB3aZ0J0maI6MiiqnNUnjA8LW4WvldQY9c7SWH8zSOPpKA144SbjBCEozVPXAQnimt+3zCNUtM2rF8x3tDemQji3kABXeoVrtr2H/KRht5W1fpzyDeeeIxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733891545; c=relaxed/relaxed;
	bh=OhJn5NE8pXKNfAghZlCqGEI+o6xSTR4r3jvSNRtZT7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXn1pBNYoKs3y8egV/nFrjcn9lLNeX2RR5OCRhOeME12jC+1LIXGs/pGmHddw1V0sEHG4NPAD07+3uMuMVqXhlmUIc4/7GxSUTAyJ3pbHrt08S2XIDWRv6u9qd5HqOvaAm3YYxAHyU9mRcdc/NfH1oErCwBixt3rfPrpbEvIgijNpong6/oVS4KiYi6KIzbRzdUu96Rr1SNALGChSBJssHGZeT6hNOd1rTW4wweKCz5LomCdDBqfoPEssDoh065Rz0cipy2g9IU07wCEvdVa4Y7MM8KiGiva+qImCXx49zZI2pj/oz6mN7tljQzneuhekNURJC2aVliqatS8CGSjYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=sjtu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 547 seconds by postgrey-1.37 at boromir; Wed, 11 Dec 2024 15:32:24 AEDT
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7N4839Fnz304H
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 15:32:22 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 257A01008CBF8;
	Wed, 11 Dec 2024 12:23:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [111.186.0.119])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id A3E2A37C987;
	Wed, 11 Dec 2024 12:22:58 +0800 (CST)
Message-ID: <9d381b37-3bf3-42e7-a127-7c4fdb607211@sjtu.edu.cn>
Date: Wed, 11 Dec 2024 12:22:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: get rid of pthread_cancel() for
 workqueue
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
Content-Language: en-CA
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: Kelvin Zhang <zhangkelvin@google.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

LGTM.


Thanks,

Yifan Zhao

On 2024/12/11 10:50, Gao Xiang wrote:
> Bionic (Android's libc) does not have pthread_cancel, call
> erofs_destroy_workqueue() when initialization fails.
>
> Cc: Kelvin Zhang <zhangkelvin@google.com>
> Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> https://lore.kernel.org/r/20241002174308.2585690-1-zhangkelvin@google.com
> https://lore.kernel.org/r/20241002174912.42486-1-zhaoyifan@sjtu.edu.cn
>
>   lib/workqueue.c | 63 ++++++++++++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 32 deletions(-)
>
> diff --git a/lib/workqueue.c b/lib/workqueue.c
> index 47cec9b..840c204 100644
> --- a/lib/workqueue.c
> +++ b/lib/workqueue.c
> @@ -15,9 +15,9 @@ static void *worker_thread(void *arg)
>   	while (true) {
>   		pthread_mutex_lock(&wq->lock);
>   
> -		while (wq->job_count == 0 && !wq->shutdown)
> +		while (!wq->job_count && !wq->shutdown)
>   			pthread_cond_wait(&wq->cond_empty, &wq->lock);
> -		if (wq->job_count == 0 && wq->shutdown) {
> +		if (!wq->job_count && wq->shutdown) {
>   			pthread_mutex_unlock(&wq->lock);
>   			break;
>   		}
> @@ -40,6 +40,29 @@ static void *worker_thread(void *arg)
>   	return NULL;
>   }
>   
> +int erofs_destroy_workqueue(struct erofs_workqueue *wq)
> +{
> +	if (!wq)
> +		return -EINVAL;
> +
> +	pthread_mutex_lock(&wq->lock);
> +	wq->shutdown = true;
> +	pthread_cond_broadcast(&wq->cond_empty);
> +	pthread_mutex_unlock(&wq->lock);
> +
> +	while (wq->nworker) {
> +		int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
> +
> +		if (ret)
> +			return ret;
> +		--wq->nworker;
> +	}
> +	free(wq->workers);
> +	pthread_mutex_destroy(&wq->lock);
> +	pthread_cond_destroy(&wq->cond_empty);
> +	pthread_cond_destroy(&wq->cond_full);
> +	return 0;
> +}
>   int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>   			  unsigned int max_jobs, erofs_wq_func_t on_start,
>   			  erofs_wq_func_t on_exit)
> @@ -51,7 +74,6 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>   		return -EINVAL;
>   
>   	wq->head = wq->tail = NULL;
> -	wq->nworker = nworker;
>   	wq->max_jobs = max_jobs;
>   	wq->job_count = 0;
>   	wq->shutdown = false;
> @@ -67,14 +89,13 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>   
>   	for (i = 0; i < nworker; i++) {
>   		ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
> -		if (ret) {
> -			while (i)
> -				pthread_cancel(wq->workers[--i]);
> -			free(wq->workers);
> -			return ret;
> -		}
> +		if (ret)
> +			break;
>   	}
> -	return 0;
> +	wq->nworker = i;
> +	if (ret)
> +		erofs_destroy_workqueue(wq);
> +	return ret;
>   }
>   
>   int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
> @@ -99,25 +120,3 @@ int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
>   	pthread_mutex_unlock(&wq->lock);
>   	return 0;
>   }
> -
> -int erofs_destroy_workqueue(struct erofs_workqueue *wq)
> -{
> -	unsigned int i;
> -
> -	if (!wq)
> -		return -EINVAL;
> -
> -	pthread_mutex_lock(&wq->lock);
> -	wq->shutdown = true;
> -	pthread_cond_broadcast(&wq->cond_empty);
> -	pthread_mutex_unlock(&wq->lock);
> -
> -	for (i = 0; i < wq->nworker; i++)
> -		pthread_join(wq->workers[i], NULL);
> -
> -	free(wq->workers);
> -	pthread_mutex_destroy(&wq->lock);
> -	pthread_cond_destroy(&wq->cond_empty);
> -	pthread_cond_destroy(&wq->cond_full);
> -	return 0;
> -}
