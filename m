Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE2F4E29B3
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:09:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMc1P5Yxhz30M3
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:09:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMc1G50mVz2yxV
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:09:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7qO7VJ_1647871727; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7qO7VJ_1647871727) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Mar 2022 22:08:49 +0800
Message-ID: <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
Date: Mon, 21 Mar 2022 22:08:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjiAVezd5B9auhcP@casper.infradead.org>
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



On 3/21/22 9:40 PM, Matthew Wilcox wrote:
> On Wed, Mar 16, 2022 at 09:17:04PM +0800, Jeffle Xu wrote:
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
>> +	rwlock_t			reqs_lock;	/* Lock for reqs xarray */
> 
> Why do you have a separate rwlock when the xarray already has its own
> spinlock?  This is usually a really bad idea.

Hi,

Thanks for reviewing.

reqs_lock is also used to protect the check of cache->flags. Please
refer to patch 4 [1] of this patchset.

```
+	/*
+	 * Enqueue the pending request.
+	 *
+	 * Stop enqueuing the request when daemon is dying. So we need to
+	 * 1) check cache state, and 2) enqueue request if cache is alive.
+	 *
+	 * The above two ops need to be atomic as a whole. @reqs_lock is used
+	 * here to ensure that. Otherwise, request may be enqueued after xarray
+	 * has been flushed, in which case the orphan request will never be
+	 * completed and thus netfs will hang there forever.
+	 */
+	read_lock(&cache->reqs_lock);
+
+	/* recheck dead state under lock */
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		read_unlock(&cache->reqs_lock);
+		ret = -EIO;
+		goto out;
+	}
+
+	xa_lock(xa);
+	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (!ret)
+		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
+	xa_unlock(xa);
+
+	read_unlock(&cache->reqs_lock);
```

It's mainly used to protect against the xarray flush.

Besides, IMHO read-write lock shall be more performance friendly, since
most cases are the read side.


[1] https://lkml.org/lkml/2022/3/16/351

-- 
Thanks,
Jeffle
