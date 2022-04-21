Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F750A511
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Apr 2022 18:14:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KkjL14yY1z3bWm
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Apr 2022 02:14:49 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KkjKt6D1Rz2yHL
 for <linux-erofs@lists.ozlabs.org>; Fri, 22 Apr 2022 02:14:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=19; SR=0; TI=SMTPD_---0VAgYtNo_1650557669; 
Received: from 30.15.235.48(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VAgYtNo_1650557669) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 22 Apr 2022 00:14:31 +0800
Message-ID: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
Date: Fri, 22 Apr 2022 00:14:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
 <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <1447543.1650552898@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <1447543.1650552898@warthog.procyon.org.uk>
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



On 4/21/22 10:54 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +	fd_install(fd, file);
> 
> Do you need to mitigate potential EMFILE/ENFILE problems?  You're potentially
> trebling up the number of accounted systemwide fds: one for erofs itself, one
> anonfd per cache object file to communicate with the daemon and one in the
> daemon to talk to the server.  Cachefiles has a fourth internally, but it's
> kept off the books - further, cachefiles closes them fairly quickly after a
> period of nonuse.
> 

Hi, thanks for pointing it out.

1. Actually in our using scenarios, one erofs filesystem is formed of
several chunk-deduplicated blobs (which are really cached by
Cachefiles), while each blob can contain many files of erofs. For
example, one container image for node.js will correspond to ~20 blob
files in total. Only these blob files are cached by Cachefiles. In
densely employed environment, there could be hundreds of containers and
thus thousands of backing files on one machine. That is, only tens of
thousands of fds/files is needed in this case.

2. Our user daemon will configure rlimit-nofile to a reasonably large
(e.g. 1 million) value, so that it won't fail when trying to allocate fds.

https://github.com/dragonflyoss/image-service/blob/master/src/bin/nydusd/main.rs#L152

3. Our user daemon will close the anonymous fd once the corresponding
backing file has fully downloaded, to free the fd resources.

4. Even if fd/file allocation fails (in cachefiles_ondemand_get_fd()),
the INIT request will fail, and thus the erofs mount will fail then.
That is, it won't break the upper erofs in this case.

5. If later we find that the number of fds/files is indeed an issue,
then we also plan to make the user daemon close some fds to spare some
free resources. And then the Cachefiles kernel module needs to
reallocate an anonymous fd for the backing file when cache miss. But it
remains to be done later if it's really needed.


-- 
Thanks,
Jeffle
