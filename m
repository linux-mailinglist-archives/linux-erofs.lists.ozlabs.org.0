Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9257E6DCE
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 16:42:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SR5n82Wwgz3cHT
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 02:42:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.15; helo=out199-15.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SR5n01xMVz3c13
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 02:42:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vw1KTVn_1699544525;
Received: from 30.25.226.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vw1KTVn_1699544525)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 23:42:06 +0800
Message-ID: <872a459d-449d-c057-625e-98c7c8b697ab@linux.alibaba.com>
Date: Thu, 9 Nov 2023 23:42:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To: Zizhi Wo <wozizhi@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20231109194821.1719430-1-wozizhi@huawei.com>
 <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
 <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
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
Cc: yangerkun@huawei.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/11/9 21:45, Zizhi Wo wrote:
> 
> 
> 在 2023/11/9 21:14, Gao Xiang 写道:
>> Hi,
>>
>> On 2023/11/10 03:48, WoZ1zh1 wrote:
>>> Because variables "die" and "copied" only appear in case
>>> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
>>> case. Also, call "kfree(copied)" earlier to avoid double free in the
>>> "error_out" branch. Some cleanups, no logic changes.
>>>
>>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>>
>> Please help use your real name here...
>>
>>> ---
>>>   fs/erofs/inode.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>> index b8ad05b4509d..a388c93eec34 100644
>>> --- a/fs/erofs/inode.c
>>> +++ b/fs/erofs/inode.c
>>> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>       erofs_blk_t blkaddr, nblks = 0;
>>>       void *kaddr;
>>>       struct erofs_inode_compact *dic;
>>> -    struct erofs_inode_extended *die, *copied = NULL;
>>>       unsigned int ifmt;
>>>       int err;
>>> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>>       switch (erofs_inode_version(ifmt)) {
>>>       case EROFS_INODE_LAYOUT_EXTENDED:
>>> +        struct erofs_inode_extended *die, *copied = NULL;
>>
>> Thanks for the patch, but in my own opinion:
>>
>> 1) It doesn't simplify the code
> OK, I'm sorry for the noise(;´༎ຶД༎ຶ`)
>>
>> 2) We'd like to avoid defining variables like this (in the
>>     switch block), and I even don't think this patch can compile.
> I tested this patch with gcc-12.2.1 locally and it compiled
> successfully. I'm not sure if this patch will fail in other environment
> with different compiler...

For example, it fails as below on gcc 10.2.1:

fs/erofs/inode.c: In function 'erofs_read_inode':
fs/erofs/inode.c:55:3: error: a label can only be part of a statement and a declaration is not a statement
    55 |   struct erofs_inode_extended *die, *copied = NULL;
       |   ^~~~~~

> 
>> 3) The logic itself is also broken...

Maybe I was missing something, but this usage makes
me uneasy...

Thanks,
Gao Xiang

> 
> Sorry, but I just don't understand why the logic itself is broken, and
> can you please explain more?
> 
> Thanks,
> Zizhi Wo
> 
>> Thanks,
>> Gao Xiang
