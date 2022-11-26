Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEB63937D
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 03:50:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NJx6y03XSz3f5Z
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Nov 2022 13:50:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NJx6p4fXkz3ccg
	for <linux-erofs@lists.ozlabs.org>; Sat, 26 Nov 2022 13:50:25 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVhKlCy_1669431019;
Received: from 30.15.198.69(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VVhKlCy_1669431019)
          by smtp.aliyun-inc.com;
          Sat, 26 Nov 2022 10:50:20 +0800
Message-ID: <37198439-8d2d-dfb9-38b4-a68091c640cc@linux.alibaba.com>
Date: Sat, 26 Nov 2022 10:50:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] erofs: enable large folio support for non-compressed
 format
Content-Language: en-US
To: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20221126005756.7662-1-jefflexu@linux.alibaba.com>
 <20221126005756.7662-3-jefflexu@linux.alibaba.com> <Y4F3EGk+0najgTco@debian>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <Y4F3EGk+0najgTco@debian>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 11/26/22 10:16 AM, Gao Xiang wrote:
> Hi Jingbo,
> 
> On Sat, Nov 26, 2022 at 08:57:56AM +0800, Jingbo Xu wrote:
>> Enable large folio in both device and fscache mode.  Then the readahead
> 
>          ^ large folios in both iomap and fscache modes.
> 
> I tend to enable iomap/fscache large folios with two patches.
> Also please see dev-test branch.

Got it.


> 
> 
>> routine will pass down large folio containing multiple pages.
>>
>> Enable this feature for non-compressed format for now, until the
>> compression part supports large folio later.
> 
>                             ^ large folios
> 
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/erofs/fscache.c | 1 +
>>  fs/erofs/inode.c   | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 0643b205c7eb..d2dd58ce312b 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -436,6 +436,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
>>  		inode->i_size = OFFSET_MAX;
>>  		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
>>  		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>> +		mapping_set_large_folios(inode->i_mapping);
>>  
> 
> Meta inodes currently doesn't need large folios for now, and
> we don't have readahead policy for these.

Alright, I will fix this in a quick v2.

> 
>>  		ctx->inode = inode;
>>  	}
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index ad2a82f2eb4c..85932086d23f 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -295,6 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
>>  		goto out_unlock;
>>  	}
>>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
>> +	mapping_set_large_folios(inode->i_mapping);
>>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>>  	if (erofs_is_fscache_mode(inode->i_sb))
>>  		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>> -- 
>> 2.19.1.6.gb485710b
>>

-- 
Thanks,
Jingbo
