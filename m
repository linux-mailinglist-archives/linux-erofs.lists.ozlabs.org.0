Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD34E2A4B
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Mar 2022 15:16:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KMc9y2ngrz30Ld
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Mar 2022 01:16:38 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KMc9t0CMYz2xrv
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Mar 2022 01:16:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=16; SR=0; TI=SMTPD_---0V7rRN9d_1647872182; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V7rRN9d_1647872182) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 21 Mar 2022 22:16:23 +0800
Message-ID: <eb558006-e5f2-59fe-9c58-844c6deff4dd@linux.alibaba.com>
Date: Mon, 21 Mar 2022 22:16:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
 <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <1027872.1647869684@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1027872.1647869684@warthog.procyon.org.uk>
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

Hi,

Thanks for reviewing.


On 3/21/22 9:34 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Fscache/cachefiles used to serve as a local cache for remote fs. This
>> patch, along with the following patches, introduces a new on-demand read
>> mode for cachefiles, which can boost the scenario where on-demand read
>> semantics is needed, e.g. container image distribution.
>>
>> The essential difference between the original mode and on-demand read
>> mode is that, in the original mode, when cache miss, netfs itself will
>> fetch data from remote, and then write the fetched data into cache file.
>> While in on-demand read mode, a user daemon is responsible for fetching
>> data and then writing to the cache file.
>>
>> This patch only adds the command to enable on-demand read mode. An optional
>> parameter to "bind" command is added. On-demand mode will be turned on when
>> this optional argument matches "ondemand" exactly, i.e.  "bind
>> ondemand". Otherwise cachefiles will keep working in the original mode.
> 
> You're not really adding a command, per se.  Also, I would recommend
> starting the paragraph with a verb.  How about:
> 
> 	Make it possible to enable on-demand read mode by adding an
> 	optional parameter to the "bind" command.  On-demand mode will be
> 	turned on when this parameter is "ondemand", i.e. "bind ondemand".
> 	Otherwise cachefiles will work in the original mode.
> 
> Also, I'd add a note something like the following:
> 
> 	This is implemented as a variation on the bind command so that it
> 	can't be turned on accidentally in /etc/cachefilesd.conf when
> 	cachefilesd isn't expecting it.	

Alright, looks much better :)

> 
>> The following patches will implement the data plane of on-demand read
>> mode.
> 
> I would remove this line.  If ondemand mode is not fully implemented in
> cachefiles at this point, I would be tempted to move this to the end of the
> cachefiles subset of the patchset.  That said, I'm not sure it can be made
> to do anything much before that point.


Alright.

> 
>> +#ifdef CONFIG_CACHEFILES_ONDEMAND
>> +static inline void cachefiles_ondemand_open(struct cachefiles_cache *cache)
>> +{
>> +	xa_init_flags(&cache->reqs, XA_FLAGS_ALLOC);
>> +	rwlock_init(&cache->reqs_lock);
>> +}
> 
> Just merge that into the caller.
> 
>> +static inline void cachefiles_ondemand_release(struct cachefiles_cache *cache)
>> +{
>> +	xa_destroy(&cache->reqs);
>> +}
> 
> Ditto.
> 
>> +static inline
>> +bool cachefiles_ondemand_daemon_bind(struct cachefiles_cache *cache, char *args)
>> +{
>> +	if (!strcmp(args, "ondemand")) {
>> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> ...
>> +	if (!cachefiles_ondemand_daemon_bind(cache, args) && *args) {
>> +		pr_err("'bind' command doesn't take an argument\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> I would merge these together, I think, and say something like "Ondemand
> mode not enabled in kernel" if CONFIG_CACHEFILES_ONDEMAND=n.
> 

The reason why I extract all these logic into small sized function is
that, the **callers** can call cachefiles_ondemand_daemon_bind()
directly without any clause like:

```
#ifdef CONFIG_CACHEFILES_ONDEMAND
	...
#else
	...
```



Another choice is like

```
if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND))
	...
else
	...
```


-- 
Thanks,
Jeffle
