Return-Path: <linux-erofs+bounces-44-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA01A5948F
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 13:32:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBGVV2Nvlz2yLB;
	Mon, 10 Mar 2025 23:32:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741609922;
	cv=none; b=cdN7R4+6NGqlqUBTVuIBtLwKxIrcO57Vn69AoaRgna0qhX+78gC8IjFZzBErHj8fjjN95Xcn/VUqgQ6okqeUuqGklkAIQsEImgcQaoie2cN0c9Nl05Z0bVsaYbbox+GXL+MRUg+9ye5KChdSSXKWaF+iSMxQbLyMrSGzzMWyWWLm4ljBcSSlvUNkwTo/wIX6+hQ+Cw3M8gwRk0sf8/lxx48UO2ggd1prLhBDH2vHSEPNogkZhJS+B5rX3fWtLkVALA8LsEtF9r0bRwgsOtP+MiL3lyeiis3HiD18yv3/42dLEkTzFQxMc6ZVP+17zoiqCZ8cGhEb3sZX5KnF8V7pWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741609922; c=relaxed/relaxed;
	bh=Xd4jNcqLpUY1KCnLHQjwMNQPDUxxOW4HOxcEEEqfTNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YCe3W3UEK/Rfl7Z2bOUyUy8D/SpKfNCyLnNdoKgSoMr/uyD2TR6D1ZgYuIPe3DxzqKK4tdSYkncIzaxpM74/8FP6uOvgv1a9BDpD3everbYfvW3Z6UfoqcJnxkr1e4qOuVfB2979sOeVddujaxnQoteldKn5BPypk+UNWg5IIvvJcVj2RUquCFIokG59vsxviqSu+rzTKndE/dFLa5kLiR3NMCBCs3ZCFe8n4Eek5AL0qsX/u33D6fpr2WomgERDUTQ0vpkgFZ6uMUCasPj7u8m0Lhv2aOJRpl1BagTFrAbDfbmOVhZbsYMeV6Y6qkvsSiUjUa9PylJKrQUi+YZ2Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBGVR5ZKyz2yGY
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 23:31:57 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZBGSX4JpGzqVYH;
	Mon, 10 Mar 2025 20:30:20 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 351CC140361;
	Mon, 10 Mar 2025 20:31:50 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Mar 2025 20:31:49 +0800
Message-ID: <14170f7f-97d0-40b4-9b07-92e74168e030@huawei.com>
Date: Mon, 10 Mar 2025 20:31:49 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>, Dave Chinner <david@fromorbit.com>
CC: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian
	<kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Luiz Capitulino
	<luizcap@redhat.com>, Mel Gorman <mgorman@techsingularity.net>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-xfs@vger.kernel.org>,
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
 <Z8vnKRJlP78DHEk6@dread.disaster.area>
 <cce03970-d66f-4344-b496-50ecf59483a6@gmail.com>
 <625983f8-7e52-4f6c-97bb-629596341181@linux.alibaba.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <625983f8-7e52-4f6c-97bb-629596341181@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/3/10 8:32, Gao Xiang wrote:

...

>>
>> Also, it seems the fstests doesn't support erofs yet?
> 
> erofs is an read-only filesystem, and almost all xfstests
> cases is unsuitable for erofs since erofs needs to preset
> dataset in advance for runtime testing and only
> read-related interfaces are cared:
> 
> You could check erofs-specfic test cases here:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests
> 
> Also the stress test:
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=6fa861e282408f8df9ab1654b77b563444b17ea1

Thanks.

> 
> BTW, I don't like your new interface either, I don't know
> why you must insist on this work now that others are
> already nak this.  Why do you insist on it so much?

If the idea was not making any sense to me and it was nack'ed
with clearer reasoning and without any supporting of the idea,
I would have stopped working on it.

The background I started working at is something like below
in the commit log:
"As mentioned in [1], it seems odd to check NULL elements in
the middle of page bulk allocating, and it seems caller can
do a better job of bulk allocating pages into a whole array
sequentially without checking NULL elements first before
doing the page bulk allocation for most of existing users."

"Remove assumption of populating only NULL elements and treat
page_array as output parameter like kmem_cache_alloc_bulk().
Remove the above assumption also enable the caller to not
zero the array before calling the page bulk allocating API,
which has about 1~2 ns performance improvement for the test
case of time_bench_page_pool03_slow() for page_pool in a
x86 vm system, this reduces some performance impact of
fixing the DMA API misuse problem in [2], performance
improves from 87.886 ns to 86.429 ns."

1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/

There is no 'must' here, it is just me taking some of my
hoppy time and some of my work time trying to make the
alloc_pages_bulk API simpler and more efficient here, and I
also learnt a lot during that process.

Anyway, if there is still any hard nack after all the
discussion, it would be good to make it more explicit with
a clearer reasoning.

