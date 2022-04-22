Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3406F50AE64
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 05:10:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kkztw0Rzfz3bWx
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 13:10:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.10;
 helo=out199-10.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com
 [47.90.199.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Kkztq70TFz2yK2
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 13:10:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAk49Jj_1650597028; 
Received: from 30.225.24.197(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAk49Jj_1650597028) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Apr 2022 11:10:30 +0800
Message-ID: <a15c3c93-3472-5bed-c8bb-4416bb809325@linux.alibaba.com>
Date: Fri, 22 Apr 2022 11:10:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 08/21] cachefiles: document on-demand read mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-9-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447053.1650552451@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1447053.1650552451@warthog.procyon.org.uk>
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

Hi David, thanks for polishing the documents. It's a detailed and
meticulous review again. Really thanks for your time :) I will fix all
these in the next version.

On 4/21/22 10:47 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +The essential difference between these two modes is that, in original mode,
>> +when a cache miss occurs, the netfs will fetch the data from the remote server
>> +and then write it to the cache file.  With on-demand read mode, however,
>> +fetching the data and writing it into the cache is delegated to a user daemon.
> 
> The starting sentence seems off.  How about:
> 
>   The essential difference between these two modes is seen when a cache miss
>   occurs: In the original mode, the netfs will fetch the data from the remote
>   server and then write it to the cache file; in on-demand read mode, fetching
>   data and writing it into the cache is delegated to a user daemon.

Okay, it sounds better.

>> the devnode ('/dev/cachefiles') to check if
>> +there's a pending request to be processed.  A POLLIN event will be returned
>> +when there's a pending request.
>> +
>> +The user daemon then reads the devnode to fetch a request and process it
>> +accordingly.
> 
> Reading the devnode doesn't process the request, so I think something like:
> 
> "... and process it accordingly" -> "... that it can then process."
> 
> or:
> 
> "... and process it accordingly" -> "... to process."

Yeah the original statement is indeed misleading.


>> Each cache file has a unique object_id, while it
>> +may have multiple anonymous fds. The user daemon may duplicate anonymous fds
>> +from the initial anonymous fd indicated by the @fd field through dup(). Thus
>> +each object_id can be mapped to multiple anonymous fds, while the usr daemon
>> +itself needs to maintain the mapping.
>> +
>> +With the given anonymous fd, the user daemon can fetch data and write it to the
>> +cache file in the background, even when kernel has not triggered a cache miss
>> +yet.
>> +
>> +The user daemon should complete the READ request
> 
> READ request -> OPEN request?

Good catch. Will be fixed.


>> in the READ request.  The ioctl is of the form::
>> +
>> +	ioctl(fd, CACHEFILES_IOC_CREAD, msg_id);
>> +
>> +	* ``fd`` is one of the anonymous fds associated with the given object_id
>> +	  in the READ request.
> 
> the given object_id in the READ request -> object_id
> 
>> +
>> +	* ``msg_id`` must match the msg_id field of the previous READ request.
> 
> By "previous READ request" is this referring to something different to "the
> READ request" you mentioned against the fd parameter?

Actually it is referring to the same thing (the same READ request). I
will change the statement simply to:

``msg_id`` must match the msg_id field of the READ request.

-- 
Thanks,
Jeffle
