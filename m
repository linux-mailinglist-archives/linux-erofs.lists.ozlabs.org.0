Return-Path: <linux-erofs+bounces-2818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KiEM7AXumnyRQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2818-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 04:10:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C02B56AB
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 04:10:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbDNV3rb6z2yZ5;
	Wed, 18 Mar 2026 14:10:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773803434;
	cv=none; b=KnovOgiKLBXEvFPBgQOsPbdYK0vYAg1F9gCFK9wW4ievkmoFQvAib4HOzWXOyB+xECVvA8I3lfsAKHiug53F6hIGbpdKxrNnuxR4u+d9ZvIU8MEcvmrI32wkZVoqV7SKVdkoN/pGdaMnqryJ5xYHjDID6tQ7SOaMFWEbl+iV2mFoS0ESJxX33KjkIw34UEMOJI9atbOymjsWORYAA0KSvGanpRladY31+Fd7QyYUS6L11guhr+xs1zVkRZdVmaMe7fgV0facc130LYIjEEP5rrEKbf8MU7nfMc/pXhZ+iA+BsSvCMsT9GZssaCE+sZolEW8ywFTtWNqECb5u5CKv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773803434; c=relaxed/relaxed;
	bh=gYknurx8oAYuO7mE+c3zbOmmInQV/xq8kKMbY0fLvj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQT9eYuIdCEsrSPSEeQd9G8AqaVVTbj0IkeTDVPpAJbe0wTvVHHrv4p0h7xVfR299Vl/yP9XOUp3awzVkKofxTOHel4sIPM8xOO7UVGmEewX+E9Bff5HXqatRPNxRywDs13CT3lwH9g3yV9Yn5V3Ry07Nr5lGgYwKCS2vPNo9QwrK5LsxohXQeMW/bPo8hx1OJicuKtnrLb/W+KZbPqYpQ17UBd+J/w6TBfZJCbOTHap8yZ0EmMR8H3Fqim2F4CkiyDFfmiHuKspKW4frx47sZRLmFq+XTuTjIMSf3aSQ9uv2myB2WbLdB7WBbLC8BHTmBElczaUr2KB2gJfeXt0sA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KNryVU8S; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KNryVU8S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbDNS1cwjz2xQr
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 14:10:30 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773803421; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gYknurx8oAYuO7mE+c3zbOmmInQV/xq8kKMbY0fLvj0=;
	b=KNryVU8SJrPVUCnv8Xqw31z5RLdX8p7EBJIqRlSfvf7y6BaKD4eI+VW8eN4lg3hsAweSP2KcLGQPLXr/VdOS95b5QjJBdU9KVD4PNP4aHjkPcFxWm7KOzOoP7/0/veSzlo3Ydeugz7o0hMwbikHlcqKf2CPh3CKKibhMU0Eap80=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.CrUxO_1773803419;
Received: from 30.221.133.123(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.CrUxO_1773803419 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 11:10:20 +0800
Message-ID: <6e0f2de8-5f02-437a-8eb1-330e57ee9e6f@linux.alibaba.com>
Date: Wed, 18 Mar 2026 11:10:19 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix thread join loop in
 erofs_destroy_workqueue
To: =?UTF-8?B?6LW16YC45Yeh?= <stopire@gmail.com>,
 Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, zhaoyifan28@huawei.com
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
 <CABra5+1T-FH54LSYF=Nz1UDrKVX47N32BS432TPo3HEAFJQ10w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABra5+1T-FH54LSYF=Nz1UDrKVX47N32BS432TPo3HEAFJQ10w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stopire@gmail.com,m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:zhaoyifan28@huawei.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2818-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B43C02B56AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/18 10:15, 赵逸凡 wrote:
> On 3/17/2026 12:33 PM, Nithurshen wrote:
>> Currently, erofs_destroy_workqueue returns immediately if a single
>> pthread_join fails. This halts the teardown process, potentially
>> leaving orphaned threads and leaking the workqueue's mutexes and
>> worker array.
>>
>> Refactor the joining logic to unconditionally join all worker
>> threads. Capture the first error encountered, continue joining the
>> remaining threads, and ensure all workqueue resources are properly
>> freed before returning the captured error.
>>
>> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
> 
> Hi Nithurshe,
> 
> 
> I'm afraid I cannot agree with this change. If pthread_join() fails, it
> implies that the worker thread is still alive.
> 
> Cleaning up the synchronization primitives and the workers array at this
> point would lead to a Use-After-Free issue, which is far more severe
> than the current resource leak.
> 
> I believe pthread_join() seldom fails, otherwise it indicates bugs in
> our codebase.

Yes, I wonder the real error number here, it seems there
is another bug somewhere.

> 
> How about just leaving an error log print for this scenario? cc @hsiangkao

Agreed, we should print the error message for each failure
instead.

Thanks,
Gao Xiang

> 
> 
> 
> Thanks,
> 
> Yifan
> 
> 
> 
>> ---
>>    lib/workqueue.c | 10 +++++++---
>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/workqueue.c b/lib/workqueue.c
>> index 18ee0f9..23eb460 100644
>> --- a/lib/workqueue.c
>> +++ b/lib/workqueue.c
>> @@ -42,6 +42,8 @@ static void *worker_thread(void *arg)
>>
>>    int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>>    {
>> +     int err = 0;
>> +
>>        if (!wq)
>>                return -EINVAL;
>>
>> @@ -53,15 +55,17 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>>        while (wq->nworker) {
>>                int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
>>
>> -             if (ret)
>> -                     return ret;
>> +             if (ret && !err)
>> +                     err = ret;
>> +
>>                --wq->nworker;
>>        }
>>        free(wq->workers);
>>        pthread_mutex_destroy(&wq->lock);
>>        pthread_cond_destroy(&wq->cond_empty);
>>        pthread_cond_destroy(&wq->cond_full);
>> -     return 0;
>> +
>> +     return err;
>>    }
>>
>>    int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,


