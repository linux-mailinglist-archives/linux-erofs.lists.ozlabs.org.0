Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BC49C380
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jan 2022 07:11:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JkCym4xf4z30MG
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jan 2022 17:11:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JkCyc513Rz2yQ9
 for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jan 2022 17:11:02 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2uAg.f_1643177453; 
Received: from 30.225.24.77(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2uAg.f_1643177453) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 14:10:55 +0800
Message-ID: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
Date: Wed, 26 Jan 2022 14:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read
 semantics
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2815558.1643127330@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2815558.1643127330@warthog.procyon.org.uk>
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
Cc: linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/26/22 12:15 AM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> The following issues still need further discussion. Thanks for your time
>> and patience.
>>
>> 1. I noticed that there's refactoring of netfs library[1],
>> ...
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
> 
> Yes.  I'm working towards getting netfslib to do handling writes and dio as
> well as reads, along with content crypto/compression, and the idea I'm aiming
> towards is that you just point your address_space_ops at netfs directly if
> possible - but it's going to require its own context now to manage pending
> writes.
> 
> See my netfs-experimental branch for more of that - it's still a work in
> progress, though.

Got it.

> 
> Btw, you could set rreq->netfs_priv in ->init_rreq() rather than passing it in
> to netfs_readpage().
> 
>> 2. The current implementation will severely conflict with the
>> refactoring of netfs library[1][2]. The assumption of 'struct
>> netfs_i_context' [2] is that, every file in the upper netfs will
>> correspond to only one backing file. While in our scenario, one file in
>> erofs can correspond to multiple backing files. That is, the content of
>> one file can be divided into multiple chunks, and are distrubuted over
>> multiple blob files, i.e. multiple backing files. Currently I have no
>> good idea solving this conflic.
> 
> I can think of a couple of options to explore:
> 
>  (1) Duplicate the cachefiles backend.  You can discard a lot of it, since a
>      much of it is concerned with managing local modifications - which you're
>      not going to do since you have a R/O filesystem and you're looking at
>      importing files into the cache externally to the kernel.
> 


>      I would suggest looking to see if you can do the blob mapping in the
>      backend rather than passing the offset down.  Maybe make the cookie index
>      key hold the index too, e.g. "/path/to/file+offset".

Have been discussed in [1].

[1]
https://lore.kernel.org/lkml/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local/T/#m25b1229f96bf24929fb73746a07e9996e8222ac6


"/path/to/file+offset"
		^

Besides, what does the 'offset' mean?


> 
>      Btw, do you still need cachefilesd for its culling duties?

Yes we still need cache management in this on-demand scenario, in case
of backing files exhausting the available blocks. (Though these backing
files are prepared by daemon in advance, these files can all be sparse
files.) And similarly the actual culling work should be done under
protection of S_KERNEL_FILE, so that the culled backing file can't be
picked back up.

> 
>  (2) Do you actually need to go through netfslib?  Might it be easier to call
>      fscache_read() directly?  Have a look at fs/nfs/fscache.c

It would be great if we can use fscache_read() directly.


> 
>> Besides there are still two quetions:
>> - What's the plan of [1]? When is it planned to be merged?
> 
> Hopefully next merge window, but that's going to depend on a number of things.
> 
>> - It seems that all upper fs using fscache is going to use netfs API,
>>   while the APIs like fscache_read_or_alloc_page() are deprecated. Is
>>   that true?
> 
> fscache_read_or_alloc_page() is gone completely.
> 
> You don't have to use the netfs API.  You can talk to fscache directly,
> doing DIO from the cache to an xarray-class iov_iter constructed from your
> inode's pagecache.
> 
> netfslib provides/will provide a number of services, such as multipage
> folios, transparent caching, crypto, compression and hiding the existence of
> pages/folios from the filesystem as entirely as possible.  However, you
> already have some of these implemented on top of iomap for the blockdev
> interface, it would appear.
> 

Got it.


In summary,

1) I prefer option 2, i.e. calling fscache_read() directly, as the one
at hand. In this case, the conflict with the netfs lib refactoring can
be avoided. Besides, there will be less modification needed to
cachefiles/netfs. Patch 1~3 are no longer required, while patch 4~6 are
still needed, which mainly introduce the new devnode.

2) Later we can change to option 1, i.e. calling netfs lib and also a
potential new R/O backend, if the issues in [1] can be clarified or solved.

[1]
https://lore.kernel.org/lkml/Yeeye2AUZITDsdh8@B-P7TQMD6M-0146.local/T/#m25b1229f96bf24929fb73746a07e9996e8222ac6

-- 
Thanks,
Jeffle
