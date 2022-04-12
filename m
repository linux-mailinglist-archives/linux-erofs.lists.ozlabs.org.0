Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843A4FCD2D
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Apr 2022 05:36:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kcrwt04Z3z2ync
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Apr 2022 13:36:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kcrwm0nVyz2xBF
 for <linux-erofs@lists.ozlabs.org>; Tue, 12 Apr 2022 13:36:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=18; SR=0; TI=SMTPD_---0V9sqOTP_1649734551; 
Received: from 30.225.24.141(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V9sqOTP_1649734551) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 12 Apr 2022 11:35:53 +0800
Message-ID: <a20ca50f-1d1a-d09e-75da-f6ced65f6c93@linux.alibaba.com>
Date: Tue, 12 Apr 2022 11:35:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v8 04/20] cachefiles: notify user daemon when withdrawing
 cookie
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
 <20220406075612.60298-5-jefflexu@linux.alibaba.com>
 <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <1091405.1649680508@warthog.procyon.org.uk>
 <1094493.1649684554@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1094493.1649684554@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-erofs@lists.ozlabs.org, fannaihao@baidu.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/11/22 9:42 PM, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>>>
>>>> +	if (fd == 0)
>>>> +		return -ENOENT;
>>>
>>> 0 is a valid fd.
>>
>> Yeah, but IMHO fd 0 is always for stdin? I think the allocated anon_fd
>> won't install at fd 0. Please correct me if I'm wrong.
> 
> If someone has closed 0, then you'll get 0 next, I'm pretty sure.  Try it and
> see.

Good catch.

> 
>> In fact I wanna use "fd == 0" as the initial state as struct
>> cachefiles_object is allocated with kmem_cache_zalloc().
> 
> I would suggest presetting it to something like -2 to avoid confusion.

Okay, as described in the previous email, I'm going to replace @fd to
@object_id. I will define some symbols to make it more readable,
something like

```
struct cachefiles_object {
	...
#ifdef CONFIG_CACHEFILES_ONDEMAND
#define CACHEFILES_OBJECT_ID_DEFAULT -2
#define CACHEFILES_OBJECT_ID_DEAD    -1
	int object_id;
#endif
	...
}
```

Thanks for your time.

-- 
Thanks,
Jeffle
