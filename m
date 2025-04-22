Return-Path: <linux-erofs+bounces-205-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FAA96734
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 13:23:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhfwz704Tz2yrM;
	Tue, 22 Apr 2025 21:22:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745320979;
	cv=none; b=F3Jh5UvMuKbG4i50RMEBDVTY8OK96pY67WgdxevVQOoICN+WXMN7dlFoDgKPdp/jjLegspwIb4h0lXtfpufpci8SuSHSfwN2wCA/jjsGvqgTs6F+S8rv0Rueyh9tLUW6x1QU+aSYX4CiXsIg1aSkcZivULNAB9sFuDw/OR/q5CZqe6Z+XQOTsCJgf7ndXmuz+/kJ8xlKXgO/cHTdacPomLqJrtcBCr3U+T9T0jbsLPFXE58TuFqvkrOVhv5N/U6Azom38ceRNfrUw618mRlY43QQGjLRoiQigYq3Guqyu0dSxoB3NlfN9W+3kzQoz8M0o8Ph3foOfeKme81PuLjgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745320979; c=relaxed/relaxed;
	bh=OqUvGb/NeuZBLQIo7HiJxW1y6UF/RrjPcLqaKD9mJUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jH9ZwGJHIDjFw1u4d63QOro7d7ORLqOOyNyiVDq72+pEblBywJeca6qQ2WVQ20IoIucGo1JBqzOaU7NtdpDoeYH6wIeK0BJuQH/K1/9/kfdI9ci4dE241TMNgnYZOQBsLTLGrM4+TTZgGq7TAwRnOPSldQDzm9UzpR6ukTPz3C8nllucXvBowD1198mZCPmnicoDuz+BagLb/KHOXWH91VL/pVmeDjQ4x3XGaXML9ii8OqzRebqtOz6bVZh1UeBs7IIddU70GJYlThefDy6I/XoE/U0wHIQGOSEhVNw2x/9F7+Xud8Tpt53/IHUtL7ZM1kQGSXpGDsYfT+2fIryt0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=linyunsheng@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhfwy1HVlz2xpn
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 21:22:56 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zhfr23R0RzvWrs;
	Tue, 22 Apr 2025 19:18:42 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 395C9180087;
	Tue, 22 Apr 2025 19:22:51 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 19:22:50 +0800
Message-ID: <cd6db77d-fcb4-44d9-8f1b-61749b411c33@huawei.com>
Date: Tue, 22 Apr 2025 19:22:50 +0800
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
Subject: Re: [PATCH v3] mm: alloc_pages_bulk: support both simple and
 full-featured API
To: Leon Romanovsky <leon@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian
	<kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, Luiz Capitulino <luizcap@redhat.com>, Mel Gorman
	<mgorman@techsingularity.net>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20250414120819.3053967-1-linyunsheng@huawei.com>
 <20250420112110.GA32613@unreal>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250420112110.GA32613@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-Spam-Status: No, score=-3.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2025/4/20 19:21, Leon Romanovsky wrote:

...

>>
>> diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
>> index 11eda6b207f1..fb094527715f 100644
>> --- a/drivers/vfio/pci/mlx5/cmd.c
>> +++ b/drivers/vfio/pci/mlx5/cmd.c
>> @@ -446,8 +446,6 @@ static int mlx5vf_add_migration_pages(struct mlx5_vhca_data_buffer *buf,
>>  		if (ret)
>>  			goto err_append;
>>  		buf->allocated_length += filled * PAGE_SIZE;
>> -		/* clean input for another bulk allocation */
>> -		memset(page_list, 0, filled * sizeof(*page_list));
>>  		to_fill = min_t(unsigned int, to_alloc,
>>  				PAGE_SIZE / sizeof(*page_list));
> 
> If it is possible, let's drop this hunk to reduce merge conflicts.
> The whole mlx5vf_add_migration_pages() is planned to be rewritten.
> https://lore.kernel.org/linux-rdma/076a3991e663fe07c1a5395f5805c514b63e4d94.1744825142.git.leon@kernel.org/

It seems mlx5vf_add_migration_pages() is changed to use the pattern
of passing 'page_array + allocated' and 'nr_pages - allocated' in the
above patch, so I think it is ok to drop the above hunk.

Hi, Andrew
Do you want me to resend this patch without the above hunk or it is
possible that you can drop the above hunk when committing if there
is no other comment need fixing?

> 
> Thanks
> 
> 


