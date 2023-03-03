Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29A6A94D6
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 11:06:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSkCN56fGz3ccv
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 21:06:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSkCH5pzcz3083
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 21:06:34 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vd.0kmQ_1677837988;
Received: from 30.97.48.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd.0kmQ_1677837988)
          by smtp.aliyun-inc.com;
          Fri, 03 Mar 2023 18:06:29 +0800
Message-ID: <2a497224-aef4-1884-d4c2-3796142c616b@linux.alibaba.com>
Date: Fri, 3 Mar 2023 18:06:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: avoid useless memory allocation
To: Yue Hu <zbestahu@gmail.com>, Noboru Asai <asai@sijam.com>
References: <20230303075218.675733-1-asai@sijam.com>
 <20230303174548.00000b0b.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230303174548.00000b0b.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/3/3 17:45, Yue Hu wrote:
> On Fri,  3 Mar 2023 16:52:18 +0900
> Noboru Asai <asai@sijam.com> wrote:
> 
>> The variable 'vi->xattr_shared_count' could be ZERO.
>>
>> Signed-off-by: Noboru Asai <asai@sijam.com>
>> ---
>>   fs/erofs/xattr.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 60729b1220b6..5164813a693b 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)
>>   
>>   	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
>>   	vi->xattr_shared_count = ih->h_shared_count;
>> +	if (!vi->xattr_shared_count)
>> +		goto out_unlock;
> 
> Questions: ret = 0? no need to erofs_put_metabuf?
> 
> I think we can keep current since kmalloc_array() will check whether the
> size(->xattr_shared_count) is zero size or not. rt?

Personally I'd like to avoid 0-sized kmalloc, but you're right,
we have to do erofs_put_metabuf() here and it needs to be fixed.

> 
>>   	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
>>   						sizeof(uint), GFP_KERNEL);
>>   	if (!vi->xattr_shared_xattrs) {
