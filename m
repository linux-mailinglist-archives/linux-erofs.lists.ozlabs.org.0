Return-Path: <linux-erofs+bounces-12-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5AA549C8
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Mar 2025 12:43:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z7ncS2KGdz3bsP;
	Thu,  6 Mar 2025 22:43:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741261416;
	cv=none; b=ouf1VwmaRgfXEakrEmKGNrkAUPbS8UckPNfVAnKyzyEEGJTKeG9jGXdqRZEoX4yyD5ttLoCXqHOzVuLqudss57m3STeaRMEbj8560UXGfxrs7sHTMvnJGdCuq/Vzal2C+5TlCwROQ8gO78UQ2/hynegL6bMGidaDNRnpbqYU2wcHNTNWy+G0LENebog890zBSCoA48g5Pcce+Jc1Eop4412j3VJDNb/X/cQFR2p/lB7CJjr2SZaeaCQrgY1N8oyaZAFp3jl1jzjVsdB98zvf5FiWNyxWHCwwzWq+Fkf48aeiF33RSWE/WC6tbHz09Xs8lmC/gaYLVhTY8tZaKmaC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741261416; c=relaxed/relaxed;
	bh=DoX120ZqI8h9bKIJpKIkQfdkPAWLCpWz+Nri6rGXftE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mpLWpq2vCHiiuDfXY0V2PV2N6FkzHpwYzlNAgAVNYd154Ph3hOAKNpZajcyK62Twz09SxDqwjrAJ9UU3IPWzHg3Z3pN3wMmfIRG8+KOUOiV6vRuqalC2cVIYfl6oOBErY6Sm4yisSwAmg+On/29PjFatzzEqLuIQWk3up7iUvXdYu/JGJB8Pu6aLjCU+zFdgF8xSgJA2Zd7k49oWwAftVX387+o7TihWmkN8L2yHN2LVaPCwXPCJV42/+EhMj/rIfz5fu68NzJTn3f1gq3k+LBKJHyrzWgfP7ObZpdJMl0fHrsDAYH+AXxE1aWskBlyyp0TgL95FfuXgiuAjC8UvZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z7ncQ4ZQ4z3brR
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Mar 2025 22:43:32 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z7nZM3B73z1R5yB;
	Thu,  6 Mar 2025 19:41:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EF1211A0171;
	Thu,  6 Mar 2025 19:43:25 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 19:43:23 +0800
Message-ID: <f834a7cd-ca0a-4495-a787-134810aa0e4d@huawei.com>
Date: Thu, 6 Mar 2025 19:43:22 +0800
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
References: <> <18c68e7a-88c9-49d1-8ff8-17c63bcc44f4@huawei.com>
 <174121808436.33508.1242845473359255682@noble.neil.brown.name>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <174121808436.33508.1242845473359255682@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/3/6 7:41, NeilBrown wrote:
> On Wed, 05 Mar 2025, Yunsheng Lin wrote:
>>
>> For the existing btrfs and sunrpc case, I am agreed that there
>> might be valid use cases too, we just need to discuss how to
>> meet the requirements of different use cases using simpler, more
>> unified and effective APIs.
> 
> We don't need "more unified".

What I meant about 'more unified' is how to avoid duplicated code as
much as possible for two different interfaces with similar‌ functionality.

The best way I tried to avoid duplicated code as much as possible is
to defragment the page_array before calling the alloc_pages_bulk()
for the use case of btrfs and sunrpc so that alloc_pages_bulk() can
be removed of the assumption populating only NULL elements, so that
the API is simpler and more efficient.

> 
> If there are genuinely two different use cases with clearly different
> needs - even if only slightly different - then it is acceptable to have
> two different interfaces.  Be sure to choose names which emphasise the
> differences.

The best name I can come up with for the use case of btrfs and sunrpc
is something like alloc_pages_bulk_refill(), any better suggestion about
the naming?

> 
> Thanks,
> NeilBrown

