Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E47E76CC
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 02:47:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1699580838;
	bh=VViQFbZYCwGWKyG7vJlPpUW1zoc3+u9HttIMozNqhxs=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HYnYq+ypLmShS93djzXfhO+0NWeitbKOUA4Jv9nlRR2FxspAfJPPfEFrEpexq6jCq
	 NQ5qSiMiaw7YI8Mwz9M7p+4yUZii8pb06U/6qgW+iYKro8H0oYT2LMyI7FmsoyXY90
	 i+jIuxfWqDXOlHAJeIieaYIPVv/+nVWOeEN5AjZJig2xqgySQLotrr1NMMN0IkKjxc
	 bvB1uFcdpp28AqwKjZoQbe+x6OayazZ9/3D9Vtrii76m5N+k4y0fohGxQ5WZxhWk8v
	 sKK0+wk5++96O5PhAq7bHl+yyyBobIyZ8k1i1n6GTmQOPMDAiK0cbi+Hg1PCarRL45
	 55OXQr7QgcEAw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRMBt32Zyz3cSQ
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 12:47:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRM4g6RSBz3dLd
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 12:41:55 +1100 (AEDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRM3n51R2zfb83;
	Fri, 10 Nov 2023 09:41:09 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 09:41:20 +0800
Message-ID: <bd728618-222b-43ba-8b47-91e90624b49c@huawei.com>
Date: Fri, 10 Nov 2023 09:41:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20231109194821.1719430-1-wozizhi@huawei.com>
 <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
 <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
 <872a459d-449d-c057-625e-98c7c8b697ab@linux.alibaba.com>
In-Reply-To: <872a459d-449d-c057-625e-98c7c8b697ab@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/11/9 23:42, Gao Xiang 写道:
> 
> 
> On 2023/11/9 21:45, Zizhi Wo wrote:
>>
>>
>> 在 2023/11/9 21:14, Gao Xiang 写道:
>>> Hi,
>>>
>>> On 2023/11/10 03:48, WoZ1zh1 wrote:
>>>> Because variables "die" and "copied" only appear in case
>>>> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
>>>> case. Also, call "kfree(copied)" earlier to avoid double free in the
>>>> "error_out" branch. Some cleanups, no logic changes.
>>>>
>>>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>>>
>>> Please help use your real name here...

Oh, I'm sorry for the confusion I caused you. I have changed my name on
.gitconfig.

>>>
>>>> ---
>>>>   fs/erofs/inode.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>>> index b8ad05b4509d..a388c93eec34 100644
>>>> --- a/fs/erofs/inode.c
>>>> +++ b/fs/erofs/inode.c
>>>> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>>       erofs_blk_t blkaddr, nblks = 0;
>>>>       void *kaddr;
>>>>       struct erofs_inode_compact *dic;
>>>> -    struct erofs_inode_extended *die, *copied = NULL;
>>>>       unsigned int ifmt;
>>>>       int err;
>>>> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>>       switch (erofs_inode_version(ifmt)) {
>>>>       case EROFS_INODE_LAYOUT_EXTENDED:
>>>> +        struct erofs_inode_extended *die, *copied = NULL;
>>>
>>> Thanks for the patch, but in my own opinion:
>>>
>>> 1) It doesn't simplify the code
>> OK, I'm sorry for the noise(;´༎ຶД༎ຶ`)
>>>
>>> 2) We'd like to avoid defining variables like this (in the
>>>     switch block), and I even don't think this patch can compile.
>> I tested this patch with gcc-12.2.1 locally and it compiled
>> successfully. I'm not sure if this patch will fail in other environment
>> with different compiler...
> 
> For example, it fails as below on gcc 10.2.1:
> 
> fs/erofs/inode.c: In function 'erofs_read_inode':
> fs/erofs/inode.c:55:3: error: a label can only be part of a statement 
> and a declaration is not a statement
>     55 |   struct erofs_inode_extended *die, *copied = NULL;
>        |   ^~~~~~
> 
Oh, I'm sorry about that! I still need to learn more. Thank you for your
assistance!

Thanks,
Zizhi Wo
>>
>>> 3) The logic itself is also broken...
> 
> Maybe I was missing something, but this usage makes
> me uneasy...
> 
> Thanks,
> Gao Xiang
> 
>>
>> Sorry, but I just don't understand why the logic itself is broken, and
>> can you please explain more?
>>
>> Thanks,
>> Zizhi Wo
>>
>>> Thanks,
>>> Gao Xiang
> 
