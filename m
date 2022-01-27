Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1849DB2F
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jan 2022 08:07:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jks946yvCz30gg
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jan 2022 18:07:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jks906QJLz2ybD
 for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jan 2022 18:07:13 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V2z08g._1643267220; 
Received: from 30.225.24.48(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V2z08g._1643267220) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 27 Jan 2022 15:07:02 +0800
Message-ID: <8f73d28e-db30-f2e4-0143-9d75c4b13087@linux.alibaba.com>
Date: Thu, 27 Jan 2022 15:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read
 semantics
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
References: <8f88459a-97e0-8b8d-3ec9-260d482a0d38@linux.alibaba.com>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2815558.1643127330@warthog.procyon.org.uk>
 <100895.1643187095@warthog.procyon.org.uk>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <100895.1643187095@warthog.procyon.org.uk>
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



On 1/26/22 4:51 PM, David Howells wrote:
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
>> "/path/to/file+offset"
>> 		^
>>
>> Besides, what does the 'offset' mean?
> 
> Assuming you're storing multiple erofs files within the same backend file, you
> need to tell the the cache backend how to find the data.  Assuming the erofs
> data is arranged such that each erofs file is a single contiguous region, then
> you need a pathname and a file offset to find one of them.
> 

Alright. In fact one erofs file can contain multiple chunks, which can
correspond to different backing blob files. Thus currently I will use
fscache_read() directly, to push this feature forward.

Thanks a lot.


-- 
Thanks,
Jeffle
