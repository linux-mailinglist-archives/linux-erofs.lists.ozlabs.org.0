Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F14E4C50
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 06:33:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KNcTC3N7bz2ymt
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Mar 2022 16:33:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KNcT52t8Lz2xCC
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Mar 2022 16:33:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7zuNYS_1648013577; 
Received: from 30.225.24.115(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7zuNYS_1648013577) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 23 Mar 2022 13:32:58 +0800
Message-ID: <8f93abf9-2c3e-51cd-9afa-ee2b68e61a4b@linux.alibaba.com>
Date: Wed, 23 Mar 2022 13:32:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>
References: <YjiX5oXYkmN6WrA3@casper.infradead.org>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <YjiAVezd5B9auhcP@casper.infradead.org>
 <6bc551d2-15fc-5d17-c99b-8db588c6b671@linux.alibaba.com>
 <YjiLACenpRV4XTcs@casper.infradead.org>
 <adb957da-8909-06d8-1b2c-b8a293b37930@linux.alibaba.com>
 <1035025.1647876652@warthog.procyon.org.uk>
 <YjoBpm8mUHX/w/rK@casper.infradead.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YjoBpm8mUHX/w/rK@casper.infradead.org>
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
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
 luodaowen.backend@bytedance.com, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/23/22 1:04 AM, Matthew Wilcox wrote:
> On Mon, Mar 21, 2022 at 03:30:52PM +0000, David Howells wrote:
>> Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> Absolutely; just use xa_lock() to protect both setting & testing the
>>> flag.
>>
>> How should Jeffle deal with xarray dropping the lock internally in order to do
>> an allocation and then taking it again (actually in patch 5)?
> 
> There are a number of ways to handle this.  I'll outline two; others
> are surely possible.

Thanks.


> 
> option 1:
> 
> add side:
> 
> xa_lock();
> if (!DEAD)
> 	xa_store(GFP_KERNEL);
> 	if (DEAD)
> 		xa_erase();
> xa_unlock();
> 
> destroy side:
> 
> xa_lock();
> set DEAD;
> xa_for_each()
> 	xa_erase();
> xa_unlock();
> 
> That has the problem (?) that it might be temporarily possible to see
> a newly-added entry in a DEAD array.

I think this problem doesn't matter in our scenario.


> 
> If that is a problem, you can use xa_reserve() on the add side, followed
> by overwriting it or removing it, depending on the state of the DEAD flag.

Right. Then even the normal path (when memory allocation succeeds) needs
to call xa_reserve() once.


> 
> If you really want to, you can decompose the add side so that you always
> check the DEAD flag before doing the store, ie:
> 
> do {
> 	xas_lock();
> 	if (DEAD)
> 		xas_set_error(-EINVAL);
> 	else
> 		xas_store();
> 	xas_unlock();
> } while (xas_nomem(GFP_KERNEL));

This way is more cleaner from the locking semantics, with the cost of
code duplication. However, after decomposing the __xa_alloc(), we can
also reuse the xas when setting CACHEFILES_REQ_NEW mark.

```
+	xa_lock(xa);
+	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
+	if (!ret)
+		__xa_set_mark(xa, id, CACHEFILES_REQ_NEW);
+	xa_unlock(xa);
```

So far personally I prefer the decomposing way in our scenario.


-- 
Thanks,
Jeffle
