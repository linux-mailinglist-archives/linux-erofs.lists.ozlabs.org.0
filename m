Return-Path: <linux-erofs+bounces-1878-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B9D220F2
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 02:46:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds5Rt5RYzz2xrC;
	Thu, 15 Jan 2026 12:46:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768441578;
	cv=none; b=Hn/HYgnOyKqVAh4+JZe4+7dVznPaQX6QmE3iGj8hgvzIy0ZPibE7KBXaAh70qxy4EzMP98ejXZsKx4VjySupVXViArdYaeXJzyadpJ0aQHd/KjgN9D9MztbZLnOiGIkz1mxhjMw1BCwUslIZNhX64kdNMtPw6u8gPThkzGVN6WLEzRShlH8WiLFmwQGxj0qs3a2B4ekSlOqbn3kTIC6U0dDGazl2AYzDRjGA3dJcltK8kwXT52TMH0TPMBvhj4dx95Egz6O0+MkD0WgV9kwVLuwxsCsFFG2h8V6idLc1h6ictgaxc/jijNUS7KnOHD7P7OtVVkOhUXq5Ic0AMp175g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768441578; c=relaxed/relaxed;
	bh=lA+iVxthBSSAwhyqVps17pUkMesnLzVESsOf8nBTCWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As6tVBCkCYnFoSrQoFFa1tb5kTBep2bLxOya7MblvSan+Q+miqXL6F2tkGrATjhiz9uzlQQ3HYVGzNG4Zlti+WCv7wGPAkPTeks/t/mUdgjmLot5F0CpeP7KjL1Yh7UlNqB1PGNrgO7fVeSofzqy/eP2N9o6cJsVzVcU221Rjeuf6jai/WARFWmMEvbzVaBdLf3s+EvLPNktTYpXZDWa7VzXkji+A1qoeTwiGForkmjAdhUE8gaNq44tb6QoyQo2Qu3lDtD8/Lz3qpBOT1QvWt++TpEmTPjVpxeM35NpBCU4k0XtqG6FLEYvzabttK84c1gRDd+TN4klVc7XkAAvHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkXM8tFj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkXM8tFj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds5Rs2rgVz2xqj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 12:46:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768441572; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lA+iVxthBSSAwhyqVps17pUkMesnLzVESsOf8nBTCWg=;
	b=PkXM8tFjR92rgnWM574pUjjNfQ67MeZcIztMbd5amwPUFbyiyZ8aECpaRtxPQjsIGbfUyo9wXeDYVmQgbbUGsiokR9tLsnYCtZ3Kh+TJFKj/7hK4UEmuku4V/ipJ8Hm0KeUGXdqwYxCKHzd0GFBNWOGYIud/cqd9phpGxIvxPxc=
Received: from 30.221.132.28(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx4lzf._1768441570 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 09:46:11 +0800
Message-ID: <2cec78b5-671a-447f-abbe-2b77c1f5d0da@linux.alibaba.com>
Date: Thu, 15 Jan 2026 09:46:10 +0800
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
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-9-lihongbo22@huawei.com>
 <2d33cc2f-8188-4e62-b0be-bf985237bf24@linux.alibaba.com>
 <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <4152e93b-3f7d-4861-aad9-b7dc1ef71470@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/15 09:36, Hongbo Li wrote:
> Hi,Xiang
> 
> On 2026/1/14 22:51, Gao Xiang wrote:
>>
>>
>> On 2026/1/9 18:28, Hongbo Li wrote:
>>> This patch adds inode page cache sharing functionality for unencoded
>>> files.
>>>
>>> I conducted experiments in the container environment. Below is the
> 
> ...
>>>               iomap->inline_data = ptr;
>>> @@ -383,11 +385,16 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>>>           .ops        = &iomap_bio_read_ops,
>>>           .cur_folio    = folio,
>>>       };
>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>> +    bool need_iput;
>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>> +        .realinode = erofs_real_inode(folio_inode(folio), &need_iput),
>>> +    };
>>> -    trace_erofs_read_folio(folio, true);
>>> +    trace_erofs_read_folio(iter_ctx.realinode, folio, true);
>>>       iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
>>> +    if (need_iput)
>>> +        iput(iter_ctx.realinode);
>>>       return 0;
>>>   }
>>> @@ -397,12 +404,17 @@ static void erofs_readahead(struct readahead_control *rac)
>>>           .ops        = &iomap_bio_read_ops,
>>>           .rac        = rac,
>>>       };
>>> -    struct erofs_iomap_iter_ctx iter_ctx = {};
>>> +    bool need_iput;
>>> +    struct erofs_iomap_iter_ctx iter_ctx = {
>>> +        .realinode = erofs_real_inode(rac->mapping->host, &need_iput),
>>> +    };
>>> -    trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>>> +    trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
>>>                       readahead_count(rac), true);
>>
>> Is it possible to add a commit to update the tracepoints
>> to add the new realinode first?
> 
> Yeah, so should we put the update on trace_erofs_read_folio and trace_erofs_readahead in a single patch after "[PATCH v14 03/10] fs: Export alloc_empty_backing_file"?

I think the tracepoint one should be just before this patch.

> 
>   Since the first two patches in this series has merged in vfs tree (thanks Christian), should we reorder the left patches?

I think you just send the new patchset version
in the future without the first two patches
in the version.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 

