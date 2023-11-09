Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790C7E6B67
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 14:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1699537600;
	bh=R98ykBrFRtC2zkWQqfIPg9G1t5+mTVUQLGfG8W88Kd8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=G+aijG6kqIzfnpx5axI7f47c8VaDdZNu4FbsrjSfcZT8fZK732a5qRQ4h4dl81NOb
	 0HMxvzlWiKZxUGO4EONUXYb7UZjWSMnJ1aw/ZmVbfvdAXOyI+aSxY4vN3kvWn8HXNq
	 5FBe0CJnewXVcqaVI5tEJSUaRfN3jJftIIBsaBzkUyp3o/Rp2YPkv2F+B+Pj6k1qjL
	 kTtMmtcSWjspmxcLEhKTAuxVxQQk5HAs9XZHylhOUYCnXOVdLSNsikOJRstOIxjjCU
	 f/RriOqX18JqM0wSOTLCCAITruQuhIzUa2ROp3bMJq3xxPObS+ZOQBz0kMp0dUC/hE
	 YSYMoaUlM8ORQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SR3CN5bj1z3cBQ
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 00:46:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SR3CF30Vtz300f
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 00:46:28 +1100 (AEDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SR3BC5Qv8zfb1J;
	Thu,  9 Nov 2023 21:45:39 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 21:45:49 +0800
Message-ID: <89069fa4-7347-4364-8793-1ce705a00b92@huawei.com>
Date: Thu, 9 Nov 2023 21:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next V2] erofs: code clean up for function
 erofs_read_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20231109194821.1719430-1-wozizhi@huawei.com>
 <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
In-Reply-To: <4d4202a7-6648-9d2c-3f0b-079a165c2ebf@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



在 2023/11/9 21:14, Gao Xiang 写道:
> Hi,
> 
> On 2023/11/10 03:48, WoZ1zh1 wrote:
>> Because variables "die" and "copied" only appear in case
>> EROFS_INODE_LAYOUT_EXTENDED, move them from the outer space into this
>> case. Also, call "kfree(copied)" earlier to avoid double free in the
>> "error_out" branch. Some cleanups, no logic changes.
>>
>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
> 
> Please help use your real name here...
> 
>> ---
>>   fs/erofs/inode.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index b8ad05b4509d..a388c93eec34 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -19,7 +19,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       erofs_blk_t blkaddr, nblks = 0;
>>       void *kaddr;
>>       struct erofs_inode_compact *dic;
>> -    struct erofs_inode_extended *die, *copied = NULL;
>>       unsigned int ifmt;
>>       int err;
>> @@ -53,6 +52,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       switch (erofs_inode_version(ifmt)) {
>>       case EROFS_INODE_LAYOUT_EXTENDED:
>> +        struct erofs_inode_extended *die, *copied = NULL;
> 
> Thanks for the patch, but in my own opinion:
> 
> 1) It doesn't simplify the code
OK, I'm sorry for the noise(;´༎ຶД༎ຶ`)
> 
> 2) We'd like to avoid defining variables like this (in the
>     switch block), and I even don't think this patch can compile.
I tested this patch with gcc-12.2.1 locally and it compiled
successfully. I'm not sure if this patch will fail in other environment
with different compiler...

> 3) The logic itself is also broken...

Sorry, but I just don't understand why the logic itself is broken, and
can you please explain more?

Thanks,
Zizhi Wo

> Thanks,
> Gao Xiang
> 
>> +
>>           vi->inode_isize = sizeof(struct erofs_inode_extended);
>>           /* check if the extended inode acrosses block boundary */
>>           if (*ofs + vi->inode_isize <= sb->s_blocksize) {
>> @@ -98,6 +99,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>               inode->i_rdev = 0;
>>               break;
>>           default:
>> +            kfree(copied);
>>               goto bogusimode;
>>           }
>>           i_uid_write(inode, le32_to_cpu(die->i_uid));
>> @@ -117,7 +119,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>               /* fill chunked inode summary info */
>>               vi->chunkformat = le16_to_cpu(die->i_u.c.format);
>>           kfree(copied);
>> -        copied = NULL;
>>           break;
>>       case EROFS_INODE_LAYOUT_COMPACT:
>>           vi->inode_isize = sizeof(struct erofs_inode_compact);
>> @@ -197,7 +198,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
>>       err = -EFSCORRUPTED;
>>   err_out:
>>       DBG_BUGON(1);
>> -    kfree(copied);
>>       erofs_put_metabuf(buf);
>>       return ERR_PTR(err);
>>   }
> 
