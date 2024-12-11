Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAE9EC45A
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 06:33:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y7PQ6564rz30Sy
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Dec 2024 16:33:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733895181;
	cv=none; b=EhB5Pyd1Vxx7/ddlvjYwd6uJ3bcc8yBGuWe/n5LZczUECD+eKkYL9qNQsud35/JhX7mhPE9oVbiVn/ZATw/AtKYUMWnW5SkqU/+SqTQQCyS3DmVfP3a51+PV+M55HoUlFK6NC+fkItzHx0MHwDkU5ivsqwpgas7M0l170ZamVtyjPIydngYJg9+f08W3MpB1CljlgC+puvAaHsSyh6oPjUGMOq5DvUyEKWcV/MIEwkPEQK4+sSTPQWIpAbLefG0OUUVfZf//jCMHOHu1wuHEz7yIBaHUfnC66fKbD5mmiqwjrW3PlplOitiXrMQmjX5QgtsW/8uL+IU/AzA2Wcncag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733895181; c=relaxed/relaxed;
	bh=gtKQpSLqOzDeMlMyJOUkthMVyA//c+xGloVO9glcES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI/V+B47BnQOxlUh7UJsKuAqPUcqJfj9nDOplW3gF03GvBPixdqs7fprFNpvi7Bl2YfCWsL40PblxIdLlG/22NveU7kMmvjx/4xN4q3oV6sBIG+Zbr6djvcpK1OdCQKezVeO4P+WjdznyGhVtbqdB1H7h4uglk7+0CXZQaeSamTjZQerVsS0mtTFlP+bu7zUqjOZwWPMzObYWg1m7AALctKiSLgYBJ6Tm1Pf2+Y+4RoCyvwPFFd7gNCumQxn8ryXSlW7Zh1283Skc0NE6pXnlIXuMxNy3huwTzzW5+n3zimFnliKuarqlF7DBd2T8Ck7IdyJpKB/cYtGe7iMJr3U9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EkAlRKf+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EkAlRKf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y7PQ105yVz2yjV
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Dec 2024 16:32:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733895169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gtKQpSLqOzDeMlMyJOUkthMVyA//c+xGloVO9glcES4=;
	b=EkAlRKf+NITn4dKmN2Sl508wHEI8eU3xBXTbXvXtVqr/H1bKCeFpl5DXnILHqBdPfMi9ouJ6IHQJcAkAX4e/5qEqRO9GzwwrY6y1/B4CSCiX8pvbznhlpBSpg0ThCDCyCfwIbYmPXceuVSCBk86XY+r0sqZSl1I6AvxoU71suyo=
Received: from 30.221.130.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLH7-1z_1733895166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 13:32:47 +0800
Message-ID: <3942833c-64e9-4d13-bebf-a013debd8a06@linux.alibaba.com>
Date: Wed, 11 Dec 2024 13:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: get rid of pthread_cancel() for
 workqueue
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20241211025009.3393476-1-hsiangkao@linux.alibaba.com>
 <9d381b37-3bf3-42e7-a127-7c4fdb607211@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9d381b37-3bf3-42e7-a127-7c4fdb607211@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Kelvin Zhang <zhangkelvin@google.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/11 12:22, Yifan Zhao wrote:
> LGTM.

Thanks, I will add as a r-v-b tag then.

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan Zhao
> 
> On 2024/12/11 10:50, Gao Xiang wrote:
>> Bionic (Android's libc) does not have pthread_cancel, call
>> erofs_destroy_workqueue() when initialization fails.
>>
>> Cc: Kelvin Zhang <zhangkelvin@google.com>
>> Cc: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> https://lore.kernel.org/r/20241002174308.2585690-1-zhangkelvin@google.com
>> https://lore.kernel.org/r/20241002174912.42486-1-zhaoyifan@sjtu.edu.cn
>>
>>   lib/workqueue.c | 63 ++++++++++++++++++++++++-------------------------
>>   1 file changed, 31 insertions(+), 32 deletions(-)
>>
>> diff --git a/lib/workqueue.c b/lib/workqueue.c
>> index 47cec9b..840c204 100644
>> --- a/lib/workqueue.c
>> +++ b/lib/workqueue.c
>> @@ -15,9 +15,9 @@ static void *worker_thread(void *arg)
>>       while (true) {
>>           pthread_mutex_lock(&wq->lock);
>> -        while (wq->job_count == 0 && !wq->shutdown)
>> +        while (!wq->job_count && !wq->shutdown)
>>               pthread_cond_wait(&wq->cond_empty, &wq->lock);
>> -        if (wq->job_count == 0 && wq->shutdown) {
>> +        if (!wq->job_count && wq->shutdown) {
>>               pthread_mutex_unlock(&wq->lock);
>>               break;
>>           }
>> @@ -40,6 +40,29 @@ static void *worker_thread(void *arg)
>>       return NULL;
>>   }
>> +int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>> +{
>> +    if (!wq)
>> +        return -EINVAL;
>> +
>> +    pthread_mutex_lock(&wq->lock);
>> +    wq->shutdown = true;
>> +    pthread_cond_broadcast(&wq->cond_empty);
>> +    pthread_mutex_unlock(&wq->lock);
>> +
>> +    while (wq->nworker) {
>> +        int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
>> +
>> +        if (ret)
>> +            return ret;
>> +        --wq->nworker;
>> +    }
>> +    free(wq->workers);
>> +    pthread_mutex_destroy(&wq->lock);
>> +    pthread_cond_destroy(&wq->cond_empty);
>> +    pthread_cond_destroy(&wq->cond_full);
>> +    return 0;
>> +}
>>   int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>>                 unsigned int max_jobs, erofs_wq_func_t on_start,
>>                 erofs_wq_func_t on_exit)
>> @@ -51,7 +74,6 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>>           return -EINVAL;
>>       wq->head = wq->tail = NULL;
>> -    wq->nworker = nworker;
>>       wq->max_jobs = max_jobs;
>>       wq->job_count = 0;
>>       wq->shutdown = false;
>> @@ -67,14 +89,13 @@ int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,
>>       for (i = 0; i < nworker; i++) {
>>           ret = pthread_create(&wq->workers[i], NULL, worker_thread, wq);
>> -        if (ret) {
>> -            while (i)
>> -                pthread_cancel(wq->workers[--i]);
>> -            free(wq->workers);
>> -            return ret;
>> -        }
>> +        if (ret)
>> +            break;
>>       }
>> -    return 0;
>> +    wq->nworker = i;
>> +    if (ret)
>> +        erofs_destroy_workqueue(wq);
>> +    return ret;
>>   }
>>   int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
>> @@ -99,25 +120,3 @@ int erofs_queue_work(struct erofs_workqueue *wq, struct erofs_work *work)
>>       pthread_mutex_unlock(&wq->lock);
>>       return 0;
>>   }
>> -
>> -int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>> -{
>> -    unsigned int i;
>> -
>> -    if (!wq)
>> -        return -EINVAL;
>> -
>> -    pthread_mutex_lock(&wq->lock);
>> -    wq->shutdown = true;
>> -    pthread_cond_broadcast(&wq->cond_empty);
>> -    pthread_mutex_unlock(&wq->lock);
>> -
>> -    for (i = 0; i < wq->nworker; i++)
>> -        pthread_join(wq->workers[i], NULL);
>> -
>> -    free(wq->workers);
>> -    pthread_mutex_destroy(&wq->lock);
>> -    pthread_cond_destroy(&wq->cond_empty);
>> -    pthread_cond_destroy(&wq->cond_full);
>> -    return 0;
>> -}

