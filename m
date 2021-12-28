Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B10480926
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 13:37:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JNYvT1nntz2yw9
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Dec 2021 23:37:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JNYvH3VsRz2xtw
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Dec 2021 23:36:58 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=13; SR=0; TI=SMTPD_---0V06qOCA_1640694803; 
Received: from 30.225.24.30(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V06qOCA_1640694803) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Dec 2021 20:33:24 +0800
Message-ID: <47831875-4bdd-8398-9f2d-0466b31a4382@linux.alibaba.com>
Date: Tue, 28 Dec 2021 20:33:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 19/23] cachefiles: implement .demand_read() for demand
 read
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-20-jefflexu@linux.alibaba.com>
 <YcndgcpQQWY8MJBD@casper.infradead.org>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <YcndgcpQQWY8MJBD@casper.infradead.org>
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
 dhowells@redhat.com, joseph.qi@linux.alibaba.com, linux-cachefs@redhat.com,
 bo.liu@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org, eguan@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 12/27/21 11:36 PM, Matthew Wilcox wrote:
> On Mon, Dec 27, 2021 at 08:54:40PM +0800, Jeffle Xu wrote:
>> +	spin_lock(&cache->reqs_lock);
>> +	ret = idr_alloc(&cache->reqs, req, 0, 0, GFP_KERNEL);
> 
> GFP_KERNEL while holding a spinlock?

Right. Thanks for pointing it out.

> 
> You should be using an XArray instead of an IDR in new code anyway.
> 

Regards.

-- 
Thanks,
Jeffle
