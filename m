Return-Path: <linux-erofs+bounces-17-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A5A563AD
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Mar 2025 10:23:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z8LSF1c80z3bwJ;
	Fri,  7 Mar 2025 20:23:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741339405;
	cv=none; b=V7ZMI9u3/idGWhOMLXNqCfwc44Fk2YY77Pfon5mglu6tAXZMTl5vwidP0Ojk+dLI4IOALNxncVmtva/onoosqImYaekf9o5Xp816EWOjQXAafzM2ypXxAds+o0fJfDZaA9v53PNi69s3Xoe83rDkCpDl5ek5O7Hn0dwEZPUVvxdmgOG0S4Hdvtg7qGJX6UQS5no9KZUdh57a20fUoaPry3tjMUn6loACs1TGd4fqp5bkxm0UMcYFAye+vqrrr+AFFy8ZBQheO+wCS1H06sFxZpgV93XiXRXwvMrqMVy1oKZrCRxPPPq6EGDHDNDpC1ZrhGt0OPEOBJ12HTf44Kk54g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741339405; c=relaxed/relaxed;
	bh=7aBlnKzCyQJ5WPz1NwuUgKmoggtwFa3Vb/k002Jvopo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f1kcsyxnRD1EXrBAYdLL9Gx8Wi8kz9JTAjTwHrnS59jvWAS4VJSrjzlLb3+Us2JyKvL7wCmoYrdljf/BY3Eq2xmKlkzMckPcuqy7yE8J0d8LcZ0oZpLB0HbWQHLKeZW67xgKuDJK5KhYYzedoWPOgje5JCt2T+hNPshY6ywu+h1WPYFJTH89pMsEGXtWEeMa+uGSM1MoHK5oZ9LLZkUAoH/DiDxsIEotJWTTLyCjdMk9dgOs9VF2iKnCspYhT2l7dtt4bn0YG7iaRRzlUkH70by/RTfqlqHU1TIn1VPR2dwGbu20NjEssqgog/l2G+sRmR9GAmiWmZoFLq33lojEdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z8LSC1fHCz2xjP
	for <linux-erofs@lists.ozlabs.org>; Fri,  7 Mar 2025 20:23:21 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z8LQ532WYz1R6Dn;
	Fri,  7 Mar 2025 17:21:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 59CC61402CE;
	Fri,  7 Mar 2025 17:23:12 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Mar 2025 17:23:11 +0800
Message-ID: <180818a1-b906-4a0b-89d3-34cb71cc26c9@huawei.com>
Date: Fri, 7 Mar 2025 17:23:11 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: NeilBrown <neilb@suse.de>
CC: Qu Wenruo <wqu@suse.com>, Yishai Hadas <yishaih@nvidia.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>, Josef
 Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Gao Xiang
	<xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Luiz Capitulino
	<luizcap@redhat.com>, Mel Gorman <mgorman@techsingularity.net>, Dave Chinner
	<david@fromorbit.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>, <netdev@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>
References: <> <f834a7cd-ca0a-4495-a787-134810aa0e4d@huawei.com>
 <174129565467.33508.7106343513316364028@noble.neil.brown.name>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <174129565467.33508.7106343513316364028@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/3/7 5:14, NeilBrown wrote:
> On Thu, 06 Mar 2025, Yunsheng Lin wrote:
>> On 2025/3/6 7:41, NeilBrown wrote:
>>> On Wed, 05 Mar 2025, Yunsheng Lin wrote:
>>>>
>>>> For the existing btrfs and sunrpc case, I am agreed that there
>>>> might be valid use cases too, we just need to discuss how to
>>>> meet the requirements of different use cases using simpler, more
>>>> unified and effective APIs.
>>>
>>> We don't need "more unified".
>>
>> What I meant about 'more unified' is how to avoid duplicated code as
>> much as possible for two different interfaces with similar‌ functionality.
>>
>> The best way I tried to avoid duplicated code as much as possible is
>> to defragment the page_array before calling the alloc_pages_bulk()
>> for the use case of btrfs and sunrpc so that alloc_pages_bulk() can
>> be removed of the assumption populating only NULL elements, so that
>> the API is simpler and more efficient.
>>
>>>
>>> If there are genuinely two different use cases with clearly different
>>> needs - even if only slightly different - then it is acceptable to have
>>> two different interfaces.  Be sure to choose names which emphasise the
>>> differences.
>>
>> The best name I can come up with for the use case of btrfs and sunrpc
>> is something like alloc_pages_bulk_refill(), any better suggestion about
>> the naming?
> 
> I think alloc_pages_bulk_refill() is a good name.
> 
> So:
> - alloc_pages_bulk() would be given an uninitialised array of page
>   pointers and a required count and would return the number of pages
>   that were allocated
> - alloc_pages_bulk_refill() would be given an initialised array of page
>   pointers some of which might be NULL.  It would attempt to allocate
>   pages for the non-NULL pointers and return the total number of

You meant 'NULL pointers' instead of 'non-NULL pointers' above?

>   allocated pages in the array - just like the current
>   alloc_pages_bulk().

I guess 'the total number of allocated pages in the array ' include
the pages which are already in the array before calling the above
API?

I guess it is worth mentioning that the current alloc_pages_bulk()
may return different value with the same size of arrays, but with
different layout of the same number of NULL pointers.
For the same size of arrays with different layout for the NULL pointer
below('*' indicate NULL pointer), and suppose buddy allocator is only
able to allocate two pages:
1. P**P*P: will return 4.
2. P*PP**: will return 5.

If the new API do the page defragmentation, then it will always return
the same value for different layout of the same number of NULL pointers.
I guess the new one is the more perfered behavior as it provides a more
defined semantic.

> 
> sunrpc could usefully use both of these interfaces.
> 
> alloc_pages_bulk() could be implemented by initialising the array and
> then calling alloc_pages_bulk_refill().  Or alloc_pages_bulk_refill()
> could be implemented by compacting the pages and then calling
> alloc_pages_bulk().
> If we could duplicate the code and have two similar but different
> functions.
> 
> The documentation for _refill() should make it clear that the pages
> might get re-ordered.

Does 'the pages might get re-ordered' mean defragmenting the page_array?
If yes, it makes sense to make it clear.

> 
> Having looked at some of the callers I agree that the current interface
> is not ideal for many of them, and that providing a simpler interface
> would help.

+1

> 
> Thanks,
> NeilBrown

