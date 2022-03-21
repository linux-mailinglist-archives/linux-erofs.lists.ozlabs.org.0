Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D24E2BC2
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 16:18:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMdYK4jyhz30Lq
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 02:18:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMdYB1Y4Nz306R
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 02:18:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7rdzHQ_1647875885; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7rdzHQ_1647875885) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Mar 2022 23:18:06 +0800
Message-ID: <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
Date: Mon, 21 Mar 2022 23:18:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjiLACenpRV4XTcs@casper.infradead.org>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/21/22 10:26 PM, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 10:08:47PM +0800, JeffleXu wrote:
>> reqs_lock is also used to protect the check of cache->flags. Please
>> refer to patch 4 [1] of this patchset.
> 
> Yes, that's exactly what I meant by "bad idea".
> 
>> ```
>> +	/*
>> +	 * Enqueue the pending request.
>> +	 *
>> +	 * Stop enqueuing the request when daemon is dying. So we need to
>> +	 * 1) check cache state, and 2) enqueue request if cache is alive.
>> +	 *
>> +	 * The above two ops need to be atomic as a whole. @reqs_lock is used
>> +	 * here to ensure that. Otherwise, request may be enqueued after xarray
>> +	 * has been flushed, in which case the orphan request will never be
>> +	 * completed and thus netfs will hang there forever.
>> +	 */
>> +	read_lock(&cache->reqs_lock);
>> +
>> +	/* recheck dead state under lock */
>> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
>> +		read_unlock(&cache->reqs_lock);
>> +		ret = -EIO;
>> +		goto out;
>> +	}
> 
> So this is an error path.  We're almost always going to take the xa_lock
> immediately after taking the read_lock.  In other words, you've done two
> atomic operations instead of one.

Right.

> 
>> +	xa_lock(xa);
>> +	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
>> +	if (!ret)
>> +		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
>> +	xa_unlock(xa);
>> +
>> +	read_unlock(&cache->reqs_lock);
>> ```
>>
>> It's mainly used to protect against the xarray flush.
>>
>> Besides, IMHO read-write lock shall be more performance friendly, since
>> most cases are the read side.
> 
> That's almost never true.  rwlocks are usually a bad idea because you
> still have to bounce the cacheline, so you replace lock contention
> (which you can see) with cacheline contention (which is harder to
> measure).  And then you have questions about reader/writer fairness
> (should new readers queue behind a writer if there's one waiting, or
> should a steady stream of readers be able to hold a writer off
> indefinitely?)

Interesting, I didn't notice it before. Thanks for explaining it.


BTW what I want is just

```
PROCESS 1		PROCESS 2
=========		=========
#lock			#lock
set DEAD state		if (not DEAD)
flush xarray		   enqueue into xarray
#unlock			#unlock
```

I think it is a generic paradigm. So it seems that the spinlock inside
xarray is already adequate for this job?

-- 
Thanks,
Jeffle
