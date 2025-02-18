Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E4A396B8
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 10:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739870176;
	bh=inAViMfXCQsf9ol1yPw8VadPDpS0D7kAWmkLjZ1Q7Cs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RuwtEYDY8gnRANeDfBtgw5P1P8vJpCHPXTjTWIPuMmLf7RqiZDs5RgQ5G+PZa0Rs8
	 fJhtnGDceAwh2vC6r2M+XSnCjKqEoajIVjJMiJY375eRXKnoiN3SjmYdaQUY4U0cKo
	 jKrchI65FqJw3qKlY34qXCJ9HOb4IpgbkuNdlgNMemtsRGXcK/rY9O7K5lDP00FO0D
	 +QIMsoZHEWjb4L0u+BSeAo9kjk7/2xiH770azd696/xhoBoMKPrRb6nDHMuUOt9u16
	 OvD/hL7FMcunnjL+axXUA/BsfKdWqdJYI6ezjKi13S3hAN0i2hdCE2z+uGedVaZuU1
	 7Q7BYoBDzoPpg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yxv5r69Mqz30Ns
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2025 20:16:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739870175;
	cv=none; b=m/5qTDBm2B40pawAKz7r8aqyyX6gyi2nKRkqnfAtm+dwCLbYeq3iQzjcY/FhNoYeoXVmkf5mLFz/9xY//XXjFhUleZ9YGy7Zn5xUdP3X/wULnk94tc1KbgR2oWJHNRe3BFNj5oIWmDpDA3O7Kh10qjJcgnXYn665A8D4W7+AgHH89+kMu61pVdN8kNuKSEtB+RSDhCV9ioeD1OTxMPbdtZQHrxeMAL508tLb6TX8/UtTJr5mOF5vRcUf4qRIYBMJEs8nTYgLGBoQEBEBkwBEjiJBBCmMweoRWUMOorBXtECOWy5o/oXOPHDHgvciNNamfxP9KsHTgs76GX0dNJ7xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739870175; c=relaxed/relaxed;
	bh=inAViMfXCQsf9ol1yPw8VadPDpS0D7kAWmkLjZ1Q7Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EQFUWWn8DD5dho5K29w2hg+2DGcRZSvxz/AI8U7Q6+NqVK+gmQyIoNjCpOXbA5aBqOQ2/KhSMbuSU+WiwbjY2q/dCSK3+Ghtgr4+J6YlvH6uO267Tu/FJ2GrRhvq+JV2oWtlvSMYqLLGSpcj0JzINYjsXi8AkuuSKR5aHKmoxcfMgkQgBCPniveZ8WNIt0jHpbT4Tb1ZUOFrAZBVgNj4x9K9IfykhathDpvSDJRrU9bzTGVWocEev+5/B8SpbGcQdGl/76NhfYTGEpHvLX2jZiHzBd0MGyXxwQ2iMn5AlYVX8GICilJCVp/OOFDij+FBDlFtuZ6M9cc5D4V/XGubcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yxv5n3rHQz3039
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Feb 2025 20:16:11 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yxv141mCDz1wn7M;
	Tue, 18 Feb 2025 17:12:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 46C8E180214;
	Tue, 18 Feb 2025 17:16:02 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 17:16:01 +0800
Message-ID: <cc6fc730-e5f4-485b-b0b6-ec70374b3ab1@huawei.com>
Date: Tue, 18 Feb 2025 17:16:00 +0800
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
Content-Language: en-US
In-Reply-To: <abc3ae0b-620a-4e4a-8dd8-f8e7d3764b3a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2025/2/17 22:20, Chuck Lever wrote:
> On 2/17/25 7:31 AM, Yunsheng Lin wrote:
>> As mentioned in [1], it seems odd to check NULL elements in
>> the middle of page bulk allocating,
> 
> I think I requested that check to be added to the bulk page allocator.
> 
> When sending an RPC reply, NFSD might release pages in the middle of

It seems there is no usage of the page bulk allocation API in fs/nfsd/
or fs/nfs/, which specific fs the above 'NFSD' is referring to?

> the rq_pages array, marking each of those array entries with a NULL
> pointer. We want to ensure that the array is refilled completely in this
> case.
> 

I did some researching, it seems you requested that in [1]?
It seems the 'holes are always at the start' for the case in that
discussion too, I am not sure if the case is referring to the caller
in net/sunrpc/svc_xprt.c? If yes, it seems caller can do a better
job of bulk allocating pages into a whole array sequentially without
checking NULL elements first before doing the page bulk allocation
as something below:

+++ b/net/sunrpc/svc_xprt.c
@@ -663,9 +663,10 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
                pages = RPCSVC_MAXPAGES;
        }

-       for (filled = 0; filled < pages; filled = ret) {
-               ret = alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
-               if (ret > filled)
+       for (filled = 0; filled < pages; filled += ret) {
+               ret = alloc_pages_bulk(GFP_KERNEL, pages - filled,
+                                      rqstp->rq_pages + filled);
+               if (ret)
                        /* Made progress, don't sleep yet */
                        continue;

@@ -674,7 +675,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
                        set_current_state(TASK_RUNNING);
                        return false;
                }
-               trace_svc_alloc_arg_err(pages, ret);
+               trace_svc_alloc_arg_err(pages, filled);
                memalloc_retry_wait(GFP_KERNEL);
        }
        rqstp->rq_page_end = &rqstp->rq_pages[pages];


1. https://lkml.iu.edu/hypermail/linux/kernel/2103.2/09060.html
