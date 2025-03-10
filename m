Return-Path: <linux-erofs+bounces-45-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6CA59570
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 14:00:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBH6k2KlRz2yLB;
	Mon, 10 Mar 2025 23:59:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741611598;
	cv=none; b=WR4jdc723MH0hFcVesSZqv9UIp8pKAzC29NA4EdAAyHbnvOZvZGcQMw55V0rGbZLXcN7xd9QzrxZdPuH0J8AX8uLnxkip96sGXrmLC8kfouj85+bftiLcIlTR1S3/dcrhSOa63Rc5VNYx9f20YoeMCEKGGgMBs8E6S9Dr754hI5uxf/x5Gz8yepPepR1PZ0odNM/kGQhvXLUAc0WZz2VI6ee+uONFR19T+iQzNqViKSMa7rvwQcsWexfa+itwLr+LW1DNwR7ioDXzkx7Mm5mkaYiySWe8q9bM38r1nkL5QEz0TzYVMl5rPpGNo9jp/TUSXBH0ib1DLhICn7651JlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741611598; c=relaxed/relaxed;
	bh=RBXViRbgYvu9SyQX3LTahN7Wc3wvAYaCUKId9eKui+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aihOxKvJcNjKCrbAo9bx2slLEJww5rjFZsC/W+8q1WDjQUDbNEL+iFclB4pESytiKM2lwCZMG6dXzpnhOhWJmUdnmZ6k6WLkjUvoiVR7oScmOK05t4NxfKEe5/7l2vPFpHgt/ua/PSgVY3Nhed5Hxv92ndw4C914epEaWSb5sthmXFnao8wu33er/qdMTiiOPKYJTcTHvsoA1/+4o6s97DpoE/chAEGhKqfYrV17h+Jkx/GzcW/6RNrgkFjaENmNJM+N0h730VOqfj3VswXyufeLgtriL7h6Jstm42c1XHGzMiFgt72YI0x9+016O5IEmO/EBAcpErAzXZ10sL6OEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nA+4lbcZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nA+4lbcZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBH6h2kCDz2y34
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 23:59:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741611590; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RBXViRbgYvu9SyQX3LTahN7Wc3wvAYaCUKId9eKui+E=;
	b=nA+4lbcZa6zBlirYk6vuMbOh8gNs1V2LDvNYx4kgX1uAYEaQaaNzhNE/GlcLeLi8sMuIOklgWTrFeFxa/uwkjbZIG/C3JZQZY98oi5f50YbX1RNuX5XHIyJ5UobTAu2bf9kdGdFozGo5iLW3rClsz4DMUyGxVKE/63FG2AcLe8E=
Received: from 30.74.129.235(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR3.NYS_1741611585 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 20:59:46 +0800
Message-ID: <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
Date: Mon, 10 Mar 2025 20:59:45 +0800
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
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
 <Z8vnKRJlP78DHEk6@dread.disaster.area>
 <cce03970-d66f-4344-b496-50ecf59483a6@gmail.com>
 <625983f8-7e52-4f6c-97bb-629596341181@linux.alibaba.com>
 <14170f7f-97d0-40b4-9b07-92e74168e030@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <14170f7f-97d0-40b4-9b07-92e74168e030@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org



On 2025/3/10 20:31, Yunsheng Lin wrote:
> On 2025/3/10 8:32, Gao Xiang wrote:
> 
> ...
> 
>>>
>>> Also, it seems the fstests doesn't support erofs yet?
>>
>> erofs is an read-only filesystem, and almost all xfstests
>> cases is unsuitable for erofs since erofs needs to preset
>> dataset in advance for runtime testing and only
>> read-related interfaces are cared:
>>
>> You could check erofs-specfic test cases here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests
>>
>> Also the stress test:
>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=6fa861e282408f8df9ab1654b77b563444b17ea1
> 
> Thanks.
> 
>>
>> BTW, I don't like your new interface either, I don't know
>> why you must insist on this work now that others are
>> already nak this.  Why do you insist on it so much?
> 
> If the idea was not making any sense to me and it was nack'ed
> with clearer reasoning and without any supporting of the idea,
> I would have stopped working on it.
> 
> The background I started working at is something like below
> in the commit log:
> "As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation for most of existing users."
> 
> "Remove assumption of populating only NULL elements and treat
> page_array as output parameter like kmem_cache_alloc_bulk().
> Remove the above assumption also enable the caller to not
> zero the array before calling the page bulk allocating API,
> which has about 1~2 ns performance improvement for the test
> case of time_bench_page_pool03_slow() for page_pool in a
> x86 vm system, this reduces some performance impact of
> fixing the DMA API misuse problem in [2], performance
> improves from 87.886 ns to 86.429 ns."
> 
> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> 
> There is no 'must' here, it is just me taking some of my
> hoppy time and some of my work time trying to make the
> alloc_pages_bulk API simpler and more efficient here, and I
> also learnt a lot during that process.


Here are my own premature thoughts just for reference:

  - If you'd like to provide some performance gain, it would
    be much better to get a better end-to-end case to show
    your improvement is important and attractive to some
    in-tree user (rather than show 1~2ns instruction-level
    micro-benchmark margin, is it really important to some
    end use case? At least, the new api is not important to
    erofs since it may only impact our mount time by only
    1~2ns, which is almost nothing, so I have no interest
    to follow the whole thread) since it involves some api
    behavior changes rather than some trivial cleanups.

  - Your new api covers narrow cases compared to the existing
    api, although all in-tree callers may be converted
    properly, but it increases mental burden of all users.
    And maybe complicate future potential users again which
    really have to "check NULL elements in the middle of page
    bulk allocating" again.

To make it clearer, it's not nak from me. But I don't have
any interest to follow your work due to "the real benefit vs
behavior changes".

Thanks,
Gao Xiang

