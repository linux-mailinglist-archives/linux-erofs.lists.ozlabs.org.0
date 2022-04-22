Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2050ADF3
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 04:44:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkzJr5HN3z3bVd
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 12:44:44 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkzJg3fW7z2xsW
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 12:44:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAjn9jI_1650595459; 
Received: from 30.225.24.197(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAjn9jI_1650595459) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Apr 2022 10:44:22 +0800
Message-ID: <cb91ef9f-62ab-6bca-2bde-ac1977ec6f37@linux.alibaba.com>
Date: Fri, 22 Apr 2022 10:44:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v9 03/21] cachefiles: unbind cachefiles gracefully in
 on-demand mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-4-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1444916.1650549738@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1444916.1650549738@warthog.procyon.org.uk>
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



On 4/21/22 10:02 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	struct kref			unbind_pincount;/* refcount to do daemon unbind */
> 
> Please use refcount_t or atomic_t, especially as this isn't the refcount for
> the structure.

Okay, will be done in the next version.

> 
>> -	cachefiles_daemon_unbind(cache);
>> -
>>  	/* clean up the control file interface */
>>  	cache->cachefilesd = NULL;
>>  	file->private_data = NULL;
>>  	cachefiles_open = 0;
> 
> Please call cachefiles_daemon_unbind() before the cleanup.

Since the cachefiles_struct struct will be freed once the pincount is
decreased to 0, "cache->cachefilesd = NULL;" needs to be done before
decreasing the pincount. BTW, "cachefiles_open = 0;" indeed should be
done only when pincount has been decreased to 0.


-- 
Thanks,
Jeffle
