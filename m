Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532E84711F5
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 06:33:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J9xJ71QJQz3cNV
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Dec 2021 16:33:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J9xJ33tWzz3cHW
 for <linux-erofs@lists.ozlabs.org>; Sat, 11 Dec 2021 16:33:06 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V-DjWG1_1639200767; 
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V-DjWG1_1639200767) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 11 Dec 2021 13:32:48 +0800
Message-ID: <aff937a0-b8fb-b9fc-22ef-d0099b392461@linux.alibaba.com>
Date: Sat, 11 Dec 2021 13:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC 02/19] cachefiles: implement key scheme for demand-read mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <20211210073619.21667-3-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
 <269788.1639134293@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <269788.1639134293@warthog.procyon.org.uk>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/10/21 7:04 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> Thus simplify the logic of placing backing files, in which backing files
>> are under "cache/<volume>/" directory directly.
> 
> You then have a scalability issue on the directory inode lock - and there may
> also be limits on the capacity of a directory.  The hash function is meant to
> work the same, no matter the cpu arch, so you should be able to copy that to
> userspace and derive the hash yourself.

Yes, as described in the cover letter, I plan to make the hashing
algorithm used by cachefiles built-in into our user daemon, so that the
user daemon could place the blob file on the right place. Then the core
logic of cachefiles won't be touched as much as possible.

> 
>> Also skip coherency checking currently to ease the development and debug.
> 
> Better if you can do that in erofs rather than cachefiles.  Just set your
> coherency data to all zeros or something.
> 

Yes it is preferred to keep the general part of cachefiles untouched.
Later we can set "CacheFiles.cache" xattr on blob files in advance to
pass this check.


-- 
Thanks,
Jeffle
