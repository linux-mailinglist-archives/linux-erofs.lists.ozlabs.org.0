Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411D77C725
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 07:37:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ0Q928Cfz30fF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 15:37:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ0Q226h1z2xqB
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 15:36:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VpqSAhf_1692077806;
Received: from 30.97.49.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VpqSAhf_1692077806)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 13:36:50 +0800
Message-ID: <52a561ce-8e57-8f59-c366-c6b3fd9724ba@linux.alibaba.com>
Date: Tue, 15 Aug 2023 13:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write tail
 end in block list
To: Yue Hu <zbestahu@gmail.com>
References: <20230815045525.17990-1-zbestahu@gmail.com>
 <953e0c41-c3a1-9681-b1a4-723596b0f89c@linux.alibaba.com>
 <20230815134010.0000268a.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230815134010.0000268a.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/15 13:40, Yue Hu wrote:
> On Tue, 15 Aug 2023 12:59:56 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> On 2023/8/15 12:55, Yue Hu wrote:
>>> From: Yue Hu <huyue2@coolpad.com>
>>>
>>> We can determine whether the tail block is the first one or not during
>>> the writing process.  Therefore, instead of internally checking the
>>> block number for the tail block map, just simply pass the flag.
>>>
>>> Also, add the missing sbi argument to macro erofs_blknr.
>>
>> Could you submit a patch to fix this issue first?
> 
> ok, will do that.
> 
>>
>>>
>>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
>>> ---
>>> v2: change commit message a bit
>>>
>>>    include/erofs/block_list.h | 4 ++--
>>>    lib/block_list.c           | 5 ++---
>>>    lib/inode.c                | 9 +++++++--
>>>    3 files changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
>>> index 78fab44..e0dced8 100644
>>> --- a/include/erofs/block_list.h
>>> +++ b/include/erofs/block_list.h
>>> @@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
>>>    void erofs_droid_blocklist_write(struct erofs_inode *inode,
>>>    				 erofs_blk_t blk_start, erofs_blk_t nblocks);
>>>    void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
>>> -					  erofs_blk_t blkaddr);
>>> +					  erofs_blk_t blkaddr, bool first_block);
>>
>> I still have no idea why we need this, could you describe the Android
>> block map details for discussion?
> 
> Android block map is just adding file blocks to a range.
> 
> So, the tail block should be needed in this range as well.
> I think one simple way is just appending the tail block address in it as below:
> 
> /`file_path` `block1_address`-`blockn_address` `tail_block_address`

why `tail_block_address` needs a seperate field?

> 
> or
> 
> /`file_path` `tail_block_address`   //only one block

how about recording the previous inode pointer as an internal global variable?
if it's not the same inode, trigger "\n" immediately.

and generate files as:
" `block1_address`-`blockn_address`"  for many blocks;
" `block1_address`" for a single block?

Thanks,
Gao Xiang
