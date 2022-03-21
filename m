Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882B4E2B18
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:43:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMcn838Zrz2yYc
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:43:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMcn422MDz3081
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:43:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7rWiGy_1647873800; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7rWiGy_1647873800) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Mar 2022 22:43:22 +0800
Message-ID: <a1543a27-7f52-266b-dd67-972902e80e8e@linux.alibaba.com>
Date: Mon, 21 Mar 2022 22:43:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 04/22] cachefiles: notify user daemon with anon_fd when
 looking up cookie
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220316131723.111553-5-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <1029248.1647871294@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1029248.1647871294@warthog.procyon.org.uk>
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 3/21/22 10:01 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	read_lock(&cache->reqs_lock);
>> +
>> +	/* recheck dead state under lock */
>> +	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
>> +		read_unlock(&cache->reqs_lock);
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	xa_lock(xa);
>> +	ret = __xa_alloc(xa, &id, req, xa_limit_32b, GFP_KERNEL);
> 
> You're holding a spinlock.  You can't use GFP_KERNEL.

Oh yes... I've dropped into this for second time... Sorry for that.

> 
>> +static int cachefiles_ondemand_cinit(struct cachefiles_cache *cache, char *args)
>> +{
>> ...
>> +	tmp = kstrdup(args, GFP_KERNEL);
> 
> No need to copy the string.  The caller already did that and added a NUL for
> good measure.

Right.


> 
> I would probably move most of the functions added in this patch to
> fs/cachefiles/ondemand.c.

Alright.


-- 
Thanks,
Jeffle
