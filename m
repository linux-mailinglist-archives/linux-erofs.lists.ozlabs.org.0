Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CAA50A322
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 16:47:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkgPn5dyPz3bbB
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 00:47:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkgPX64tkz2ync
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 00:47:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAfplXu_1650552445; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAfplXu_1650552445) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Apr 2022 22:47:27 +0800
Message-ID: <62301f0e-8623-80ac-b351-a1b475a7004c@linux.alibaba.com>
Date: Thu, 21 Apr 2022 22:47:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 02/21] cachefiles: notify user daemon when looking up
 cookie
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1444650.1650549423@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1444650.1650549423@warthog.procyon.org.uk>
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
 joseph.qi@linux.alibaba.com, zhangjiachen.jaycee@bytedance.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

Thanks for reviewing :)


On 4/21/22 9:57 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	help
>> +	  This permits on-demand read mode of cachefiles.  In this mode, when
>> +	  cache miss, the cachefiles backend instead of netfs, is responsible
>> +	  for fetching data, e.g. through user daemon.
> 
> How about:
> 
> 	help
> 	  This permits userspace to enable the cachefiles on-demand read mode.
> 	  In this mode, when a cache miss occurs, responsibility for fetching
> 	  the data lies with the cachefiles backend instead of with the netfs
> 	  and is delegated to userspace.
> 
>> +	/*
>> +	 * 1) Cache has been marked as dead state, and then 2) flush all
>> +	 * pending requests in @reqs xarray. The barrier inside set_bit()
>> +	 * will ensure that above two ops won't be reordered.
>> +	 */
> 
> What set_bit()?  

"set_bit(CACHEFILES_DEAD, &cache->flags);" in cachefiles_daemon_release()

> What "above two ops"? 

The two operations I mentioned in the comment:
1) Cache has been marked as dead state, and then
2) flush all pending requests in @reqs xarray.


> And that's not how barriers work; they


> provide a partial ordering relative to another pair of barriered ops.
> 
> Also, set_bit() can't be relied upon to imply a barrier - see
> Documentation/memory-barriers.txt.

Yeah, it seems that set_bit() doesn't imply with a memory barrier,
though the x86 implementation (arch/x86/boot/bitops.h) indeed implies a
barrier, which may misleads me. Thanks for pointing it out. Then maybe a
full barrier is needed here before flushing the @reqs xarray.

> 
>> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
>> +	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {
> 
> It might be worth abstracting this into an inline function in internal.h:
> 
> 	static inline bool cachefiles_in_ondemand_mode(cache)
> 	{
> 		return IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> 			test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)
> 	}

Okay, will be fixed in the next version.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> 
> This looks like it ought to be superfluous, given the preceding test - though
> I can see why you need it:

Sorry I can't see the context. But I guess you are referring to the
snippet of cachefiles_daemon_poll()?

```
+	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
+	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+		if (!xa_empty(&cache->reqs))
+			mask |= EPOLLIN;
```

Yes the implementation here is indeed not elegant enough. As you
described below, if @reqs is defined non-conditionally in struct
cachefiles_cache, then the superfluous magic here is not needed then.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
>> +	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
>> +	u32				ondemand_id_next;
>> +#endif
> 
> I'm tempted to say that you should just make them non-conditional.  It's not
> like there's likely to be more than one or two cachefiles_cache structs on a
> system.

Okay, sounds reasonable.


-- 
Thanks,
Jeffle
