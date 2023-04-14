Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 165746E2560
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Apr 2023 16:13:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pydj70mvWz3fRF
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Apr 2023 00:13:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681481627;
	bh=0khoLy+eSzRa5gLnIJcGGxbaem/Y8O3pCzVmwyuZdh8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VIf3igw+Teu8i7lcLAzztPmhLRC8mfKtWRRqct49Ptstrd1ps+470QQdvm2vB4ezc
	 hEDWwbfYAgymjFHQsyFpC8o0hWWLyjZfDt+yCdbZRGQg/203N7ENIa0QqZOLPld5Xl
	 florZCb6YMPKE/uAIV3w/z9G+i33roXhIKFaqZ1BBdioUWjjJzC8d+RwxY593yELJo
	 I+58k7dp4Dq2vzUUC1cOqbi0D3HJKOc5Kn4C4RfGVr2e+AKgkXdNKah8xNIWlJznCV
	 ZEdsr3LpQGfR5obBC8eHKGEFdaaKxdQsNSzq0EuRPgnB1sAHQ9RozM5H6wu4ajZyT5
	 qm3iZv46Bq5+Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aIsHBNmg;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pydj21WWCz30NN
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Apr 2023 00:13:40 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-247399d518dso117021a91.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Apr 2023 07:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481617; x=1684073617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0khoLy+eSzRa5gLnIJcGGxbaem/Y8O3pCzVmwyuZdh8=;
        b=DjySgpZyA3f/nk6WHOc2Jg7jstrSdfchdcNGfzx4TRLwbiIilxPuH0Esb8SlUP59dT
         UkC9eurhAJMdEfk7qaxz/iXjx5xh5vhrDHf/zeg9cnl1kE2su/CPa3BCjbR1B2POWhCq
         T7tpA5rfZZLeltlogd89/cF7pMvdqCqk9NEUa+epK8cqVKBu1o7v4cvxOlch/j5/hmZW
         Pfsg+XB0LUy+/coOoRjBB3StbxTinY4HmPs8M8ki5PM433i0Fvk8JK4j1fN8KnCzgd97
         iINfYnQalXMbZiSfeiv4spYzYrAEIc5mNxkd2fXix7P50QZfJkrRks0/7foJrVsSq54y
         mKTw==
X-Gm-Message-State: AAQBX9cQ/+wNIbeafIXWY2ganz70+JafsRyZwM2RjhjS4+1pIzqRuKNy
	GcChS0ee8c9t1L5eo94tJ1DUlA==
X-Google-Smtp-Source: AKy350aKg9lmYOUaUEQlZgWqZ66lzJFD1dcVcEBuDBWsSx/PM4wkmkAYb4pSZQkjOSGOhInZapBxgA==
X-Received: by 2002:a05:6a00:178c:b0:63b:4e99:807d with SMTP id s12-20020a056a00178c00b0063b4e99807dmr7746205pfg.8.1681481616918;
        Fri, 14 Apr 2023 07:13:36 -0700 (PDT)
Received: from [10.255.185.5] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b005921c46cbadsm3189981pfm.99.2023.04.14.07.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:13:36 -0700 (PDT)
Message-ID: <1a9c4365-aae1-b4fe-d31d-dfd9b42afae6@bytedance.com>
Date: Fri, 14 Apr 2023 22:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: [PATCH V5 4/5] cachefiles: narrow the scope of triggering
 EPOLLIN events in ondemand mode
To: David Howells <dhowells@redhat.com>
References: <20230329140155.53272-5-zhujia.zj@bytedance.com>
 <20230329140155.53272-1-zhujia.zj@bytedance.com>
 <1250225.1681480128@warthog.procyon.org.uk>
In-Reply-To: <1250225.1681480128@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
From: Jia Zhu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/4/14 21:48, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>>   	if (cachefiles_in_ondemand_mode(cache)) {
>> -		if (!xa_empty(&cache->reqs))
>> -			mask |= EPOLLIN;
>> +		if (!xa_empty(xa)) {
>> +			rcu_read_lock();
>> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
>> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
>> +					mask |= EPOLLIN;
>> +					break;
>> +				}
>> +			}
>> +			rcu_read_unlock();
> 
> You should probably use xas_for_each_marked() instead of xa_for_each_marked()
> as the former should perform better.
> 
> David

Hi David,

Thanks for your advice. I'll revise it in next version.

Jia
> 
