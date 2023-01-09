Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3766233E
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 11:34:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nr9Kf3r0nz3c4Y
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 21:34:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KLPEab//;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KLPEab//;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nr9KX2Z48z2ypJ
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 21:34:08 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 252AC60FE1;
	Mon,  9 Jan 2023 10:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45178C433D2;
	Mon,  9 Jan 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673260444;
	bh=4+41/x4EC6NqU/+mehLq4YWojS5p6S0n539ic8Dxjzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KLPEab//TbD4tEXztACY7jbMKY+V1PEisPOaSjv53K9s1ByZnszapjf+hp8j8dmhi
	 leIHi11Gd8rl48LQZ8vil32FY7RbME1aNmOmiBluphjCExSZsRigCOrCe5je6n1/p7
	 4T2w42Rt/WZEcBi43oaGadZGQdo6NdFHoXlyg9Bm7iKPptP/fEsS5UeTRNA4k2S+VJ
	 8ipXpJIAz9S6AMtWHo7xrZ50LDuI2+VbTVYTAwzZPUxevZXffjzMRR/VnOtmm2rchD
	 1o38xyqI+HesP2tnGi0fm2nmZOpQWv7Qz1ti5s8qutSR9sZ6TDdcqnQNTSMdxX2ERY
	 cTsMFikSbH74A==
Message-ID: <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
Date: Mon, 9 Jan 2023 18:34:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
 <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>, syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023/1/6 13:06, Gao Xiang wrote:
> 
> 
> On 2023/1/6 11:19, Gao Xiang wrote:
>> As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
>> Let's use kcalloc() instead.
>>
>> [1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
>> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
> 
> Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
> Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")
> 
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index ccf7c55d477f..08e982c77985 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>       if (!be->decompressed_pages)
>>           be->decompressed_pages =
>> -            kvcalloc(be->nr_pages, sizeof(struct page *),
>> -                 GFP_KERNEL | __GFP_NOFAIL);
>> +            kcalloc(be->nr_pages, sizeof(struct page *),
>> +                GFP_KERNEL | __GFP_NOFAIL);
>>       if (!be->compressed_pages)
>>           be->compressed_pages =
>> -            kvcalloc(pclusterpages, sizeof(struct page *),
>> -                 GFP_KERNEL | __GFP_NOFAIL);
>> +            kcalloc(pclusterpages, sizeof(struct page *),
>> +                GFP_KERNEL | __GFP_NOFAIL);

How about using kfree instead of kvfree for .decompressed_pages and
.compressed_pages memory release? It's trivial though.

Anyway, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>>       z_erofs_parse_out_bvecs(be);
>>       err2 = z_erofs_parse_in_bvecs(be, &overlapped);
