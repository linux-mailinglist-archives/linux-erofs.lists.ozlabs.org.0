Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3966262E
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 13:55:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrDSS1Hh8z3c3N
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 23:55:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44; helo=out30-44.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrDSP46qwz307T
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Jan 2023 23:55:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZEaZ.Q_1673268909;
Received: from 192.168.3.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZEaZ.Q_1673268909)
          by smtp.aliyun-inc.com;
          Mon, 09 Jan 2023 20:55:10 +0800
Message-ID: <9f4c8bf0-db3e-b97a-504d-6015b75a2174@linux.alibaba.com>
Date: Mon, 9 Jan 2023 20:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: fix kvcalloc() misuse with __GFP_NOFAIL
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20230106031937.113318-1-hsiangkao@linux.alibaba.com>
 <cbd4bc97-4ffb-45c5-8c3c-b9b81b20d813@linux.alibaba.com>
 <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c949dfe9-572f-61ee-a587-1f71be2f13d7@kernel.org>
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

Hi Chao,

On 2023/1/9 18:34, Chao Yu wrote:
> On 2023/1/6 13:06, Gao Xiang wrote:
>>
>>
>> On 2023/1/6 11:19, Gao Xiang wrote:
>>> As reported by syzbot [1], kvcalloc() cannot work with  __GFP_NOFAIL.
>>> Let's use kcalloc() instead.
>>>
>>> [1] https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com
>>> Reported-by: syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com
>>
>> Fixes: fe3e5914e6dc ("erofs: try to leave (de)compressed_pages on stack if possible")
>> Fixes: 4f05687fd703 ("erofs: introduce struct z_erofs_decompress_backend")
>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>>   fs/erofs/zdata.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>>> index ccf7c55d477f..08e982c77985 100644
>>> --- a/fs/erofs/zdata.c
>>> +++ b/fs/erofs/zdata.c
>>> @@ -1032,12 +1032,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>>       if (!be->decompressed_pages)
>>>           be->decompressed_pages =
>>> -            kvcalloc(be->nr_pages, sizeof(struct page *),
>>> -                 GFP_KERNEL | __GFP_NOFAIL);
>>> +            kcalloc(be->nr_pages, sizeof(struct page *),
>>> +                GFP_KERNEL | __GFP_NOFAIL);
>>>       if (!be->compressed_pages)
>>>           be->compressed_pages =
>>> -            kvcalloc(pclusterpages, sizeof(struct page *),
>>> -                 GFP_KERNEL | __GFP_NOFAIL);
>>> +            kcalloc(pclusterpages, sizeof(struct page *),
>>> +                GFP_KERNEL | __GFP_NOFAIL);
> 
> How about using kfree instead of kvfree for .decompressed_pages and
> .compressed_pages memory release? It's trivial though.

Yeah, thanks for catching! I will send v2 to fix these.

Thanks,
Gao Xiang

> 
> Anyway, feel free to add:
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
>>>       z_erofs_parse_out_bvecs(be);
>>>       err2 = z_erofs_parse_in_bvecs(be, &overlapped);
