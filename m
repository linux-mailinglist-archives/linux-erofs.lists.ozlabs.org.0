Return-Path: <linux-erofs+bounces-53-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEFA5DC49
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Mar 2025 13:06:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZCTrC6jNWz3btk;
	Wed, 12 Mar 2025 23:06:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741781195;
	cv=none; b=TAdLsvVMobhtZ/csSwHxpC7a+FLBrkb66g/OcgO+AQYZT0eG+iUVI9ebCNAb6VAhHs7nZ5XBgTeaVpzuO8anmeakpgZ1Qi7vhVpsYipbFk1XatT3M4nOTrYppynEeuoSwNzD1dDKnp99uvHL5Qf2CHEx1gAfUjhc8ZA6sl38MdkylcsPS7z3gvdWJ5G7UV3ZX2LRr3m6xvE5VX0M9Xgr/kxdTH1eaW+OJ8ahiAxEFArncd8qKqFdmM36045ga/FmbzX4EBF4X4A1L1DhlHb7O4b8z4owD/dGyBb7xcbOB0f9Bpt6EtJd0NiC6f7qFSnP1MwWe01aa9BB6mWXhlw+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741781195; c=relaxed/relaxed;
	bh=yY9yUaPPoPxebJ0yuTVmLrSLhe88mIGDenMpZM7HhSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b7ODfO3raTpTlGAI3L8gCtiEBSDccn3k1bhcQb0PI0cpNstQ1s60e1AnpVC0BUjUQUk/CFh5dfQKMBBgBuaSPu59rwqOh8J/2dsJUHtrkrlsic/VJjnTgSJorj47ItgBzb49x2k8dS9WGnG6udrZFYYViBI3R1SPk6mAlg1wrLg5B363tbSuKr4XF9lZ0okihG/VfUgtFJu80YtMrFJ7x2C1oyftxRkzZwlkqTTByxdJW5xRoQt1vFEH5MCyFsYWv1r5Cpm+vrHEGIsWRIGdnLLT79d7C7OOViLj8oJ8hI27WeqP3SHi697livgkhZmhOagS+xHaoH3j08Mak00B9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZCTrB0lCzz3bmf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 23:06:31 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZCTl019PpzvWs0;
	Wed, 12 Mar 2025 20:02:04 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BAA7A1401F1;
	Wed, 12 Mar 2025 20:05:54 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Mar 2025 20:05:51 +0800
Message-ID: <c5cdd730-1e11-4440-849d-8841b5ce86ef@huawei.com>
Date: Wed, 12 Mar 2025 20:05:51 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, NeilBrown <neilb@suse.de>
CC: Yunsheng Lin <yunshenglin0825@gmail.com>, Dave Chinner
	<david@fromorbit.com>, Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex.williamson@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Gao Xiang
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
	<luizcap@redhat.com>, Mel Gorman <mgorman@techsingularity.net>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-xfs@vger.kernel.org>,
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <> <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
 <174173371062.33508.12685894810362310394@noble.neil.brown.name>
 <14ef70cc-beba-4abb-b206-e9fb29381023@linux.alibaba.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <14ef70cc-beba-4abb-b206-e9fb29381023@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

On 2025/3/12 9:45, Gao Xiang wrote:
> 
> 
> On 2025/3/12 06:55, NeilBrown wrote:
>> On Mon, 10 Mar 2025, Gao Xiang wrote:
>>>
>>>    - Your new api covers narrow cases compared to the existing
>>>      api, although all in-tree callers may be converted
>>>      properly, but it increases mental burden of all users.
>>>      And maybe complicate future potential users again which
>>>      really have to "check NULL elements in the middle of page
>>>      bulk allocating" again.
>>
>> I think that the current API adds a mental burden for most users.  For
>> most users, their code would be much cleaner if the interface accepted
>> an uninitialised array with length, and were told how many pages had
>> been stored in that array.> A (very) few users benefit from the complexity.  So having two
>> interfaces, one simple and one full-featured, makes sense.

Thanks for the above clear summarization.

> 
> Ok, I think for this part, diferrent people has different
> perference on API since there is no absolutely right and
> wrong in the API design area.
> 
> But I have no interest to follow this for now.

Just to be clearer, as erofs seems to be able to be changed to
use a simple interface, do you prefer to keep using the full-featured
interface or change to use the simple interface?

> 
> Thanks,
> Gao Xiang

