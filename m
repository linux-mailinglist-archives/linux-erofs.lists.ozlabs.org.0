Return-Path: <linux-erofs+bounces-54-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79603A5DCDF
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Mar 2025 13:41:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZCVcQ5zL9z3btk;
	Wed, 12 Mar 2025 23:41:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741783286;
	cv=none; b=bvkrrrMJPAgltvA/ty7zodlhssQp0We1bAf/E0Npayej5/D4CHMi8Taa3lbuF7ZgUAUysOYRpeK3ECBHSiwxc6/KDiWkReVflcn35FfRlGi20/9V4+bXBl7k0RY9pq42cWYAqj/wiyMPv0vyiFot0mAWEmpw2SKCDvdm3veKfVsy2gNubGMd95sSHG6RyivU8tYGSo2Sbhx747UHpjYDuy848o6PVZKCCpVCtF4FguWnidZQCGTONPcJ5hOdwNNgRtdKoHXYU2epQrKmBzBNk0cFjA5SISxNYRkQk7QZ1yunKjMdFumLAFz/xV76Ha6wDL/VDUZq9hRN1xnFUZ5lYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741783286; c=relaxed/relaxed;
	bh=byoy4lGPHlk+/7jnyQFo8ZlkUybA3oGJHC4262MlS70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZSsRT+IjL3JqTMQ5l4G/t1bGZGxkpt/iUGf+9bE2OYvNtCRlLOpLUouZ6Z+J2dzfQmJtOljvAYKqSvtUl55L9fAI+HUIi1IS9VclPH9tICckSJGCa/oNaI6eka04jtv2U0I8C9t8rG6fUGsH5u7GuFndoifFTGG+XeOdzWiU/5/1V4gairDSh50P1LaFWJUCVZVMQ0Ai3z6w0EuxmwRqoYefGs6wnodeP26Z+TmDbgExh7+V4px9fTtgboNgSapgN7dywe+fmcgJFuz+QfkQX6I1xVeP4aGIYq6n7+RjRenUwxqkDm9lxfo5eIQz5wR0efODCrjSVBU/dcrQrovQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3qoLWyK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=i3qoLWyK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZCVcN1cbhz3bmf
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Mar 2025 23:41:22 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741783279; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=byoy4lGPHlk+/7jnyQFo8ZlkUybA3oGJHC4262MlS70=;
	b=i3qoLWyKZNdejafaLlapWkfCAztofj6eCt1dqOqONpLGx6hN6g8/duBxviyfIVsNjfLnuTX7gpyXY+zhvDmzSQC2uOKZX5jMnlaiK7kOVnk65jsJlqQ/dxAjcEjvMhBCqNteLtJMiDBpf75NeGR6HRYX1bXNEPTpBIkHUkhOfew=
Received: from 30.74.129.75(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRCvGy4_1741783275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 20:41:15 +0800
Message-ID: <0ca82e20-1424-4564-972f-4f7ffb73ccaf@linux.alibaba.com>
Date: Wed, 12 Mar 2025 20:41:14 +0800
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
To: Yunsheng Lin <linyunsheng@huawei.com>, NeilBrown <neilb@suse.de>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>,
 Dave Chinner <david@fromorbit.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
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
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <> <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
 <174173371062.33508.12685894810362310394@noble.neil.brown.name>
 <14ef70cc-beba-4abb-b206-e9fb29381023@linux.alibaba.com>
 <c5cdd730-1e11-4440-849d-8841b5ce86ef@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c5cdd730-1e11-4440-849d-8841b5ce86ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org



On 2025/3/12 20:05, Yunsheng Lin wrote:
> On 2025/3/12 9:45, Gao Xiang wrote:
>>
>>
>> On 2025/3/12 06:55, NeilBrown wrote:
>>> On Mon, 10 Mar 2025, Gao Xiang wrote:
>>>>
>>>>     - Your new api covers narrow cases compared to the existing
>>>>       api, although all in-tree callers may be converted
>>>>       properly, but it increases mental burden of all users.
>>>>       And maybe complicate future potential users again which
>>>>       really have to "check NULL elements in the middle of page
>>>>       bulk allocating" again.
>>>
>>> I think that the current API adds a mental burden for most users.  For
>>> most users, their code would be much cleaner if the interface accepted
>>> an uninitialised array with length, and were told how many pages had
>>> been stored in that array.> A (very) few users benefit from the complexity.  So having two
>>> interfaces, one simple and one full-featured, makes sense.
> 
> Thanks for the above clear summarization.
> 
>>
>> Ok, I think for this part, diferrent people has different
>> perference on API since there is no absolutely right and
>> wrong in the API design area.
>>
>> But I have no interest to follow this for now.
> 
> Just to be clearer, as erofs seems to be able to be changed to
> use a simple interface, do you prefer to keep using the full-featured
> interface or change to use the simple interface?

Please keep using the old interface because I don't have any
bandwidth on this considering no real benefit.

Thanks,
Gao Xiang


