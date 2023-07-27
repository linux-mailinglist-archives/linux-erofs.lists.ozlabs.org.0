Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488B7647EA
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 09:09:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBMMC56G6z3c3N
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 17:09:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBMM70cQCz2ymV
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 17:09:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoJgGAy_1690441740;
Received: from 30.97.49.7(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoJgGAy_1690441740)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 15:09:01 +0800
Message-ID: <a0ce89f2-2aa8-4050-3ab6-ef39ad8dae36@linux.alibaba.com>
Date: Thu, 27 Jul 2023 15:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 6/9] erofs-utils: add inode hash helper
To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
 huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
 <20230727045712.45226-6-jefflexu@linux.alibaba.com>
 <decd1dd2-c248-674f-1c1e-1e4922589cb0@linux.alibaba.com>
 <1cb26642-bff7-ad22-b7ec-c1ae924878fd@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1cb26642-bff7-ad22-b7ec-c1ae924878fd@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/27 14:55, Jingbo Xu wrote:
> 
> 
> On 7/27/23 2:12 PM, Gao Xiang wrote:
>>
>>
>> On 2023/7/27 12:57, Jingbo Xu wrote:
>>> Add erofs_insert_ihash() helper inserting inode into inode hash table,
>>> and erofs_cleanup_ihash() helper cleaning up inode hash table.
>>>
>>> Also add prototypes of erofs_iget() and erofs_iget_by_nid() in the
>>> header file.
>>>
>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>    include/erofs/inode.h |  4 ++++
>>>    lib/inode.c           | 22 +++++++++++++++++++---
>>>    2 files changed, 23 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
>>> index e8a5670..aba2a94 100644
>>> --- a/include/erofs/inode.h
>>> +++ b/include/erofs/inode.h
>>> @@ -25,6 +25,10 @@ u32 erofs_new_encode_dev(dev_t dev);
>>>    unsigned char erofs_mode_to_ftype(umode_t mode);
>>>    unsigned char erofs_ftype_to_dtype(unsigned int filetype);
>>>    void erofs_inode_manager_init(void);
>>> +void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t
>>> ino);
>>> +void erofs_cleanup_ihash(void);
>>> +struct erofs_inode *erofs_iget(dev_t dev, ino_t ino);
>>> +struct erofs_inode *erofs_iget_by_nid(erofs_nid_t nid);
>>>    unsigned int erofs_iput(struct erofs_inode *inode);
>>>    erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
>>>    struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
>>> diff --git a/lib/inode.c b/lib/inode.c
>>> index d54f84f..d82ea95 100644
>>> --- a/lib/inode.c
>>> +++ b/lib/inode.c
>>> @@ -75,6 +75,24 @@ void erofs_inode_manager_init(void)
>>>            init_list_head(&inode_hashtable[i]);
>>>    }
>>>    +void erofs_insert_ihash(struct erofs_inode *inode, dev_t dev, ino_t
>>> ino)
>>> +{
>>> +    list_add(&inode->i_hash,
>>> +         &inode_hashtable[(ino ^ dev) % NR_INODE_HASHTABLE]);
>>> +}
>>> +
>>> +void erofs_cleanup_ihash(void)
>>> +{
>>> +    unsigned int i;
>>> +    struct erofs_inode *inode, *n;
>>> +
>>> +    for (i = 0; i < NR_INODE_HASHTABLE; ++i) {
>>> +        list_for_each_entry_safe(inode, n, &inode_hashtable[i], i_hash)
>>
>> Why are there still inodes here?
> 
> The inode hash table is used to detect hardlink file.  In union mode,
> only ino (dev is always 0) comes to play when calculating the hash.
> Thus the inode hash table is built on a per-image basis.  When we have
> finished parsing one input image, erofs_cleanup_ihash() is called to
> clean up the whole inode hash table, otherwise inode (with the same ino)
> from next input image may conflict when hashing.

I guess we'd better to inline the code directly and add comments for
this usage (also you'd better to ensure that hashtable is empty in
the beginning) since it's not a safe way for other use cases.

Thanks,
Gao Xiang
