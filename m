Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A938F50A3B9
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 17:12:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkgxZ3jBxz3bWf
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 01:12:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkgxT4tgKz2yHD
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 01:11:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAg.y.s_1650553903; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAg.y.s_1650553903) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Apr 2022 23:11:45 +0800
Message-ID: <a79e09a0-16d2-4d73-af9f-05a259431040@linux.alibaba.com>
Date: Thu, 21 Apr 2022 23:11:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 06/21] cachefiles: enable on-demand read mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-7-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1445691.1650550659@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1445691.1650550659@warthog.procyon.org.uk>
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



On 4/21/22 10:17 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
>> +	    !strcmp(args, "ondemand")) {
>> +		set_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
>> +	} else if (*args) {
>> +		pr_err("'bind' command doesn't take an argument\n");
> 
> The error message isn't true if CONFIG_CACHEFILES_ONDEMAND=y.  It would be
> better to say "Invalid argument to the 'bind' command".

Right. Or users may gets confused then. Will be fixed in the next version.

> 
>> -retry:
>>  	/* If the caller asked us to seek for data before doing the read, then
>>  	 * we should do that now.  If we find a gap, we fill it with zeros.
>>  	 */
>> @@ -120,16 +119,6 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
>>  			if (read_hole == NETFS_READ_HOLE_FAIL)
>>  				goto presubmission_error;
>>  
>> -			if (read_hole == NETFS_READ_HOLE_ONDEMAND) {
>> -				ret = cachefiles_ondemand_read(object, off, len);
>> -				if (ret)
>> -					goto presubmission_error;
>> -
>> -				/* fail the read if no progress achieved */
>> -				read_hole = NETFS_READ_HOLE_FAIL;
>> -				goto retry;
>> -			}
>> -
> 

Sorry, it's my mistake when doing "git rebase". The previous version
(v8) actually calls cachefiles_ondemand_read() in cachefiles_read().
However as explained in the commit message of patch 5 ("cachefiles:
implement on-demand read"), fscache_read() can only detect if the
requested file range is fully cache miss, whilst it can't detect if it
is partial cache miss, i.e. there's a hole inside the requested file range.

Thus in this patchset (v9), we move the entry of calling
cachefiles_ondemand_read() from cachefiles_read() to
cachefiles_prepare_read(). The above "deletion of newly added code" is
actually reverting the previous change to cachefiles_read(). It was
mistakenly merged to this patch when I was doing "git rebase"...
Actually it should be merged to patch 5 ("cachefiles: implement
on-demand read"), which initially introduce the change to cachefiles_read().

Apologize for the careless mistake...


-- 
Thanks,
Jeffle
