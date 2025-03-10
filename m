Return-Path: <linux-erofs+bounces-25-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6296CA589AE
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 01:33:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z9yYK2G0Sz2ynR;
	Mon, 10 Mar 2025 11:33:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741566805;
	cv=none; b=LJMFCyzh8H2dQKyt8oIe1np0H5DhF2KyX5HKIMjzOvrZPppCoLnk1NsYR+EJXd41N/F5K8nCJOdRhh7UOlQV+ljHO9TqCLOLKl/jOJH1Ei78xa6NWlasBiB4hMUaWaFOB6aPdpj2RXSSpLhYl4o8sgUlzVSmIIKYn0U3o5x2iGk/Eb+65ecb/98bh8WCCL87IplmSWlJLENapXFyT4GXXfVO9sTp+tGrFkLWfa9dAvg6GOWrDEn7/Emv7nLtsd1ebvnZ8D8+YsIXS+a+dp6NBgykO4SRYWH1UE/GP22jUb5/VL9TcsS4T4UjkyFVlW8iJFdyghaEPBUJo1KMpVhtjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741566805; c=relaxed/relaxed;
	bh=i9xoUJAz+Ulc3f5EECn+evsDiO91i2wyeFM4yQAvw+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmrsW192lAcoq/izbqPFp1P7/34In9/gV9HDH9oFtc7mA4LwSIC5YAacugTgbFmqovkv/ishDMcSv0ZupLyXANSK1x7qp7eQPRqSSewCiCRHbilzyxRPZtp9LCqn/qtk9bNcIvG1G36rXUNS6J+NJNET4FSU7pk6LayYLoplkzhqN3casKFX0Oe2sVHyzDKLB8Vj16+eosxEZeFU65T85ya42NtdNxLUhmzqeLbi63BQK/iwPYbBbTn2j4s5QwfqH91thazqT244THa3YmcInZSw7tzLx9KmZHuFV/KqkOzGgB8cqSebmixrQeiEN26hzXKm65m4hh0/KU3/gWBfDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ljCUoKY7; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ljCUoKY7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z9yYG6s06z2yjV
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 11:33:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741566796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i9xoUJAz+Ulc3f5EECn+evsDiO91i2wyeFM4yQAvw+Q=;
	b=ljCUoKY7e3khfir36iKZsE394dwNM0MWYbFvOudyrpQEl5JYfht4w0goAx/rbJNc1OynXavTkMb18X8dPG+yvjiI1yPVeUFxtOzLpuc2bv3vzGS8YMc5qjEqQZQyl9DdNB/CYVEw+IkV5KGQZ5YDLutpgERGGOtBjIOQskANl4c=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQy811n_1741566764 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 08:33:11 +0800
Message-ID: <625983f8-7e52-4f6c-97bb-629596341181@linux.alibaba.com>
Date: Mon, 10 Mar 2025 08:32:42 +0800
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
To: Yunsheng Lin <yunshenglin0825@gmail.com>,
 Dave Chinner <david@fromorbit.com>, Yunsheng Lin <linyunsheng@huawei.com>
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <cce03970-d66f-4344-b496-50ecf59483a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org



On 2025/3/9 21:40, Yunsheng Lin wrote:
> On 3/8/2025 2:43 PM, Dave Chinner wrote:
> 
> ...
> 
>>> I tested XFS using the below cmd and testcase, testing seems
>>> to be working fine, or am I missing something obvious here
>>> as I am not realy familiar with fs subsystem yet:
>>
>> That's hardly what I'd call a test. It barely touches the filesystem
>> at all, and it is not exercising memory allocation failure paths at
>> all.
>>
>> Go look up fstests and use that to test the filesystem changes you
>> are making. You can use that to test btrfs and NFS, too.
> 
> Thanks for the suggestion.
> I used the below xfstests to do the testing in a VM, the smoke testing
> seems fine for now, will do a full testing too:
> https://github.com/tytso/xfstests-bld
> 
> Also, it seems the fstests doesn't support erofs yet?

erofs is an read-only filesystem, and almost all xfstests
cases is unsuitable for erofs since erofs needs to preset
dataset in advance for runtime testing and only
read-related interfaces are cared:

You could check erofs-specfic test cases here:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests

Also the stress test:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=6fa861e282408f8df9ab1654b77b563444b17ea1

BTW, I don't like your new interface either, I don't know
why you must insist on this work now that others are
already nak this.  Why do you insist on it so much?

Thanks,
Gao Xiang

> 
>>
>> -Dave.
>>


