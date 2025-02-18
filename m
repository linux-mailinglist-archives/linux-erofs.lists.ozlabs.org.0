Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E7A396E4
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 10:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739870500;
	bh=ZCtAjWsH8jT9hnaqtoB68T1TFs75Fw+Uj5uC9nRt6n0=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ESB06D67v5G92TGHjXeZlKBgbwk+/PvKxmSaIGrjsMGyHBA/ARN4TidBubpPn5ps3
	 pNJKiQNiByk3wWXXcdYyr88wDMHESOUGM7ZO7ObnzPFSRvV4+LsE6bApA+/Cg2Gs9W
	 6QIfXJ+aYi93KKMmQvGyUf3isvCvQ+tZ1j7vVmLjboVFoX8lusLBk4e9iYjGX8DOYD
	 g0L9TWzydDCsN1kncs+wYVBVWS1ZtPdoInDTqCYCa0Sfgp6CzeMf85AKtL1G371gUP
	 Nv3gNJ0Q6rpDfwe1/MoSwrWgw2eelJKVuij5nKuWJUkWK6vNllIG0C/k5nOSilUGmb
	 GPmwM1rax7QJA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxvD4335Sz30Nl
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 20:21:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739870499;
	cv=none; b=BcZBc1AmXolqXZxBSnxgqoaOnWacuq9ibZJF+KOheTxV4nZZkL8BWE64rFoJ9jSJ1h8QH0tgKp2+l0bL///2k/p4IxnLOExrKJ1ols9jFdR+xIsqTz3lYFd0Fl86dzks0xYAWggenOB5dXTh8R5jCLWHz2f2ppNBBjQCaFhekDwe5RHXxmmJfJWwki/eKH8izYryFIuqKexA+bbJAg9md6TB0Hvx0ZuyXJEKsAaR0Yi3cuY3TVlwjHEfE0xhucB18ebictbIJ6EbpsIM6NkljLQUrxDZ+IYzTT62o6X5c0XcgFr6Cr6LI46upYDS2k4HqUhrkY0zyg4dQ0oXGa6dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739870499; c=relaxed/relaxed;
	bh=ZCtAjWsH8jT9hnaqtoB68T1TFs75Fw+Uj5uC9nRt6n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YrVWEDpvKbmCtBEfw0bhnVdxUGBdbpM4VAUMrJ7TDzmpIkAmDvJc1WsPpbRqQ80qv44NMXNIkWHHwG0Y8A2rl7ExlkXFfX5qAMApqIF7nzZwEvrHqg02SdgbkG0K6LbapC3cISCforjGCPhBFrDbPONTRX46WaXv0eXs7wbinzlDXF6zhSum/SBiPRA6Ju2kDCAvLSShBng0ScnSSoB+SJwG3kF+Y89cIO2P+LitjOhlSfvebzSNOpIMRNWd0DlHbYJEhfECykkNoynwMLmFSubQuKUvarjZ02dZZkfzhgVdkd5W6va7tzQnhDKD1jawZrFGI+eM8YPkHGhRS8UQUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxvD158mbz2yTy
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 20:21:37 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yxv7P5668z1wn7M;
	Tue, 18 Feb 2025 17:17:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B723E1A016C;
	Tue, 18 Feb 2025 17:21:31 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 17:21:27 +0800
Message-ID: <cf270a65-c9fa-453a-b7a0-01708063f73e@huawei.com>
Date: Tue, 18 Feb 2025 17:21:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
To: Dave Chinner <david@fromorbit.com>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
 <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
Content-Language: en-US
In-Reply-To: <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: kvm@vger.kernel.org, Neil Brown <neilb@suse.de>, "Darrick J.
 Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, Eric Dumazet <edumazet@google.com>, Anna Schumaker <anna@kernel.org>, Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Olga Kornievskaia <okorniev@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Josef Bacik <josef@toxicpanda.com>, virtualization@lists.linux.dev, Tom Talpey <tom@talpey.com>, Alex Williamson <alex.williamson@redhat.com>, David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, linux-mm@kvack.org, linux-erofs@lists.ozlabs.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, linux-xfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, linux-btrfs@vger.kernel.org, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "David S. Miller" <davem@davemloft.net>, Trond Myklebust <trondmy@kernel.org>, Luiz Capitulino <luizcap@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2025/2/18 5:31, Dave Chinner wrote:

...

> .....
> 
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index 15bb790359f8..9e1ce0ab9c35 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
>>  	 * least one extra page.
>>  	 */
>>  	for (;;) {
>> -		long	last = filled;
>> +		long	alloc;
>>  
>> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
>> -					  bp->b_pages);
>> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
>> +					 bp->b_pages + refill);
>> +		refill += alloc;
>>  		if (filled == bp->b_page_count) {
>>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>>  			break;
>>  		}
>>  
>> -		if (filled != last)
>> +		if (alloc)
>>  			continue;
> 
> You didn't even compile this code - refill is not defined
> anywhere.
> 
> Even if it did complile, you clearly didn't test it. The logic is
> broken (what updates filled?) and will result in the first
> allocation attempt succeeding and then falling into an endless retry
> loop.

Ah, the 'refill' is a typo, it should be 'filled' instead of 'refill'.
The below should fix the compile error:
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -379,9 +379,9 @@ xfs_buf_alloc_pages(
        for (;;) {
                long    alloc;

-               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
-                                        bp->b_pages + refill);
-               refill += alloc;
+               alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - filled,
+                                        bp->b_pages + filled);
+               filled += alloc;
                if (filled == bp->b_page_count) {
                        XFS_STATS_INC(bp->b_mount, xb_page_found);
                        break;

> 
> i.e. you stepped on the API landmine of your own creation where
> it is impossible to tell the difference between alloc_pages_bulk()
> returning "memory allocation failed, you need to retry" and
> it returning "array is full, nothing more to allocate". Both these
> cases now return 0.

As my understanding, alloc_pages_bulk() will not be called when
"array is full" as the above 'filled == bp->b_page_count' checking
has ensured that if the array is not passed in with holes in the
middle for xfs.

> 
> The existing code returns nr_populated in both cases, so it doesn't
> matter why alloc_pages_bulk() returns with nr_populated != full, it
> is very clear that we still need to allocate more memory to fill it.

I am not sure if the array will be passed in with holes in the
middle for the xfs fs as mentioned above, if not, it seems to be
a typical use case like the one in mempolicy.c as below:

https://elixir.bootlin.com/linux/v6.14-rc1/source/mm/mempolicy.c#L2525

> 
> The whole point of the existing API is to prevent callers from
> making stupid, hard to spot logic mistakes like this. Forcing
> callers to track both empty slots and how full the array is itself,
> whilst also constraining where in the array empty slots can occur
> greatly reduces both the safety and functionality that
> alloc_pages_bulk() provides. Anyone that has code that wants to
> steal a random page from the array and then refill it now has a heap
> more complex code to add to their allocator wrapper.

Yes, I am agreed that it might be better to provide a common API or
wrapper if there is some clear use case that need to pass in an array
with holes in the middle by adding a new API like refill_pages_bulk()
as below.

> 
> IOWs, you just demonstrated why the existing API is more desirable
> than a highly constrained, slightly faster API that requires callers
> to get every detail right. i.e. it's hard to get it wrong with the
> existing API, yet it's so easy to make mistakes with the proposed
> API that the patch proposing the change has serious bugs in it.

IMHO, if the API is about refilling pages for the only NULL elements,
it seems better to add a API like refill_pages_bulk() for that, as
the current API seems to be prone to error of not initializing the
array to zero before calling alloc_pages_bulk().

> 
> -Dave.
