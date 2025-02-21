Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CBA3F067
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2025 10:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1740130506;
	bh=KV6/ZMu6u/scLjwfN4QKh8XL+w11Fjmxpk6VPBV1oRc=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OaLa2eSLDWEM/MTKOUK6K585BTMBbKwR4q73y7YzFtG10KidBVDRUBxH3Rqg0VB83
	 PuB35TNNzdoJ0jrGRH567BxSS7Hu21bEqFSI+4SGb0q5vDTWNkFxKa15zeK15A8PaW
	 z6W7todPiVoOwT3Hp+kR+hMbX3/+NQfXYHhdajGAI2Buvd2kFuZMzwI3f4+nu864wq
	 1J/rxHfUpao//AnWXXh6lVZ9iOoTpR/hPgWZ60hwungG9BJqGyT+nngvqAQe/ueZA/
	 IJhiA7rWHeVIh0PoZczii+yhnh5boqKTYPdjvEIrHzKnnTXhEfEDrvKIiO0QXDf3+o
	 ZN4hFar3JzT3A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzlNB3W2cz30Vw
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2025 20:35:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740130503;
	cv=none; b=Kj1TceCT/jJ5ZkKlpNqRJC7gdwE0wlSQiMLxeXI3AIeQHiEsOCTqzV+ZRPHsDb0EYP1sOUuOk1PDHH1e/sX6Cx6lluz19pehLN2OCZ/IaawXarYrD7D3ovFDpdFXzIx3rMcewHaOtaTr0x3xcrHa0IY61Jdb9XzldbgPJR3JluYI3bNGoFu0rpMKU4tKEWhl+70iJHIlfSzw23avYpsQgYQUu8bb3EZfRDrrkM6LBoP7IB8YKVihYJAu1t4KAQMbQEqREWH50qhZPL/9pcx3IyxyE5mOTUJJAblGqXX1nXlF37dK0sP7wpHIPCLJ5o3eOmndArWJ5EyDkH4/tioYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740130503; c=relaxed/relaxed;
	bh=KV6/ZMu6u/scLjwfN4QKh8XL+w11Fjmxpk6VPBV1oRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OUzkt2p6NwQFmcUdeCYlBDMSMDK53LNED3OAaAj9r8+uyUQK/1dgPVMwAMfGstT4SRVGK23TKJciDxVYOZOjImvcvq+6VENvIdaGa/UDd/U+uLk9RtECT2jGIM9HnCQX61ZOpD1yPUKoG+41txT7ZaFZo8WNubF5WIqoZE/OXa/K9r813lZ870WhqIw8p/auDt5V9O8voeFYX7UtPRVbKaaiVIBgNvLcVL3eERHBxEGGQ2VSOS7KC3YPxoUBGX/Mq+YVcRft7mb8yoWKtUy8KWlSGChtqH3Q46965swJxd2J66D7WHHoD47SIOCvT+baWaoTYAzeHU970f55CD6YGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzlN51jsDz30T7
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2025 20:34:59 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YzlG03WHwzdb9B;
	Fri, 21 Feb 2025 17:29:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 57A03140158;
	Fri, 21 Feb 2025 17:34:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 17:34:22 +0800
Message-ID: <e55e4dd4-9f80-4b2b-a84e-4bcfa4cf40be@huawei.com>
Date: Fri, 21 Feb 2025 17:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
To: Chuck Lever <chuck.lever@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum
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
	<anna@kernel.org>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
 <abc3ae0b-620a-4e4a-8dd8-f8e7d3764b3a@oracle.com>
 <cc6fc730-e5f4-485b-b0b6-ec70374b3ab1@huawei.com>
 <7b7492c0-a3a7-470b-b7aa-697ac790a94b@oracle.com>
Content-Language: en-US
In-Reply-To: <7b7492c0-a3a7-470b-b7aa-697ac790a94b@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-0.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Yunsheng Lin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-nfs@vger.kernel.org, kvm@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>, linux-btrfs@vger.kernel.org, Luiz Capitulino <luizcap@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2025/2/18 22:17, Chuck Lever wrote:
> On 2/18/25 4:16 AM, Yunsheng Lin wrote:
>> On 2025/2/17 22:20, Chuck Lever wrote:
>>> On 2/17/25 7:31 AM, Yunsheng Lin wrote:
>>>> As mentioned in [1], it seems odd to check NULL elements in
>>>> the middle of page bulk allocating,
>>>
>>> I think I requested that check to be added to the bulk page allocator.
>>>
>>> When sending an RPC reply, NFSD might release pages in the middle of
>>
>> It seems there is no usage of the page bulk allocation API in fs/nfsd/
>> or fs/nfs/, which specific fs the above 'NFSD' is referring to?
> 
> NFSD is in fs/nfsd/, and it is the major consumer of
> net/sunrpc/svc_xprt.c.
> 
> 
>>> the rq_pages array, marking each of those array entries with a NULL
>>> pointer. We want to ensure that the array is refilled completely in this
>>> case.
>>>
>>
>> I did some researching, it seems you requested that in [1]?
>> It seems the 'holes are always at the start' for the case in that
>> discussion too, I am not sure if the case is referring to the caller
>> in net/sunrpc/svc_xprt.c? If yes, it seems caller can do a better
>> job of bulk allocating pages into a whole array sequentially without
>> checking NULL elements first before doing the page bulk allocation
>> as something below:
>>
>> +++ b/net/sunrpc/svc_xprt.c
>> @@ -663,9 +663,10 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>>                 pages = RPCSVC_MAXPAGES;
>>         }
>>
>> -       for (filled = 0; filled < pages; filled = ret) {
>> -               ret = alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
>> -               if (ret > filled)
>> +       for (filled = 0; filled < pages; filled += ret) {
>> +               ret = alloc_pages_bulk(GFP_KERNEL, pages - filled,
>> +                                      rqstp->rq_pages + filled);
>> +               if (ret)
>>                         /* Made progress, don't sleep yet */
>>                         continue;
>>
>> @@ -674,7 +675,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>>                         set_current_state(TASK_RUNNING);
>>                         return false;
>>                 }
>> -               trace_svc_alloc_arg_err(pages, ret);
>> +               trace_svc_alloc_arg_err(pages, filled);
>>                 memalloc_retry_wait(GFP_KERNEL);
>>         }
>>         rqstp->rq_page_end = &rqstp->rq_pages[pages];
>>
>>
>> 1. https://lkml.iu.edu/hypermail/linux/kernel/2103.2/09060.html
> 
> I still don't see what is broken about the current API.

As mentioned in [1], the page bulk alloc API before this patch may
have some space for improvement from performance and easy-to-use
perspective as the most existing calllers of page bulk alloc API
are trying to bulk allocate the page for the whole array sequentially.

1. https://lore.kernel.org/all/c9950a79-7bcb-41c2-a59e-af315dc6d7ff@huawei.com/

> 
> Anyway, any changes in svc_alloc_arg() will need to be run through the
> upstream NFSD CI suite before they are merged.

Is there any web link pointing to the above NFSD CI suite, so that I can
test it if removing assumption of populating only NULL elements is indeed
possible?

Look more closely, it seems svc_rqst_release_pages()/svc_rdma_save_io_pages()
does set rqstp->rq_respages[i] to NULL based on rqstp->rq_next_page,
and the original code before using the page bulk alloc API does seem to only
allocate page for NULL elements as can see from the below patch：
https://lore.kernel.org/all/20210325114228.27719-8-mgorman@techsingularity.net/T/#u

The clearing of rqstp->rq_respages[] to NULL does seems sequentially, is it
possible to only pass NULL elements in rqstp->rq_respages[] to alloc_pages_bulk()
so that bulk alloc API does not have to do the NULL checking and use the array only
as output parameter?

> 
> 
