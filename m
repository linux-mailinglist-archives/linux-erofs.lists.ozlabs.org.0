Return-Path: <linux-erofs+bounces-1879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E837D220FB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 02:48:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds5Ts0YNqz2xrC;
	Thu, 15 Jan 2026 12:48:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768441681;
	cv=none; b=MK/5O1RFaZLn/jiYsyrA4YFfnPkp4KYNQDdiIFL2kT6Wgwe8pgxD4UW/n9QW8Hiy0K+eu9GswAX/4D+ozBpnQSzZcSRK9+oxoSDZC0kbyJ0OAhw7qqVlGTMESeNoqP+lUtXYAGdNodpJheNDMe1jPAjg0FFS79uYTrwfBYdDaOUNyP5w7XIUJd7m8fMzf+Ooofk1gCZ2piQGqbq1uPn6+RXubAlCKeRrcC7PRYywRj8Vb1ncV2LtY++atGy/I02I0kRqKJUNPhnQ1ycWQRuQW5RaaZPWQ+nKGxmITiw2AxBCPWUZMkgUQgyOmcNJKW/K0jx5polWnG1/WedioTVOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768441681; c=relaxed/relaxed;
	bh=C01OnGYG1L1pGK2zAThg6CrCN92Wwfy4Y4Qle2Tht9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHEKqpMS8M3wdwL4XJAdlc1WBlbggl7xaY5wXkzGRAhQJ4vAihqJLAsgD19LreKJ8WelfyFgWK94yrc4ize4D3jxVQkIe6tWwvD2MzxHuGeE9GmAM8RP75HTV9E5XwQCfcvuPyi36bjv+EvNLMHL8KPK4BqDo1DAeTaHvMbuXBfP+wFIm3PS9lA2JNXxsuIEON+vI1ylg9W0btZd3YzRpNWKM0J9Id/IFrqQlZP+eOgw7POUS6ywF9eRWsQEfjhCFz01Qe/ek5/ZISQ3X2GgPtI7cXEVdTNbpgCstLfWtAO8B/40nwETlSVoaLKbEkzS0MzuWTWpc3V4bFZ191vruQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N9k0wpAC; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N9k0wpAC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds5Tp3Wmyz2xqj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 12:47:58 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C01OnGYG1L1pGK2zAThg6CrCN92Wwfy4Y4Qle2Tht9c=;
	b=N9k0wpACInb9szt+0RbGoN/5ovo8SZ0Jp/T/dxpw2H7DlTzctJ1ZP39Lj0NnmNlbIKu9EWRq5
	bhncrOsxRMAydy2dx6wuNQljJTxd1UYRxN4cEgaCsz4Qb+7Du4y6j8M3SLTL+3aos5168/I87yo
	jHyS9Xk2B+YZ+TakkNBolj4=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ds5Ps51gwzKmSg;
	Thu, 15 Jan 2026 09:44:33 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E30540565;
	Thu, 15 Jan 2026 09:47:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 09:47:53 +0800
Message-ID: <ff6f1338-05aa-49af-a371-69e1d02f7e53@huawei.com>
Date: Thu, 15 Jan 2026 09:47:53 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/10] erofs: support unencoded inodes for page cache
 share
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
 <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
 <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/15 9:46, Gao Xiang wrote:
> 
> 
> On 2026/1/15 09:36, Hongbo Li wrote:
>> Hi,Xiang
>>
>> On 2026/1/14 22:51, Gao Xiang wrote:
>>>
>>>
>>> On 2026/1/9 18:28, Hongbo Li wrote:
>>>> This patch adds inode page cache sharing functionality for unencoded
>>>> files.
>>>>
>>>> I conducted experiments in the container environment. Below is the
>>
>> ...
>>>>               iomap->inline_data = ptr;
>>>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, 
>>>> struct folio *folio)
>>>>           .ops        = &iomap_bio_read_ops,
>>>>           .cur_folio    = folio,
>>>>       };
>>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>>> +    bool need_iput;
>>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>>>> +    };
>>>> -    trace_erofs_read_folio(folio, true);
>>>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>>> +    if (need_iput)
>>>> +        iput(iter_ctx.realinode);
>>>>       return 0;
>>>>   }
>>>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct 
>>>> readahead_control *rac)
>>>>           .ops        = &iomap_bio_read_ops,
>>>>           .rac        = rac,
>>>>       };
>>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>>> +    bool need_iput;
>>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>>>> +    };
>>>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>>>                       readahead_count(rac), true);
>>>
>>> Is it possible to add a commit to update the tracepoints
>>> to add the new realinode first?
>>
>> Yeah, so should we put the update on trace_erofs_read_folio and 
>> trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: 
>> Export alloc_empty_backing_file"?
> 
> I think the tracepoint one should be just before this patch.
> 
>>
>>   Since the first two patches in this series has merged in vfs tree 
>> (thanks Christian), should we reorder the left patches?
> 
> I think you just send the new patchset version
> in the future without the first two patches
> in the version.
> 

Ok,

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>

