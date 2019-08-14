Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19B8C5BB
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 03:56:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467XkB1nJNzDqM1
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 11:56:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467Xk63qhGzDqRy
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 11:56:13 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B77759B7A0E52C4F5EDB;
 Wed, 14 Aug 2019 09:56:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 14 Aug
 2019 09:55:58 +0800
Subject: Re: [PATCH] staging: erofs: removing an extra call to iloc() in
 fill_inode()
To: Gao Xiang <gaoxiang25@huawei.com>, Pratik Shinde
 <pratikshinde320@gmail.com>
References: <20190813203840.13782-1-pratikshinde320@gmail.com>
 <20190814015944.GA11254@138>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <418907b6-0b6b-3b08-c6fd-939a206f061f@huawei.com>
Date: Wed, 14 Aug 2019 09:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190814015944.GA11254@138>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/8/14 9:59, Gao Xiang wrote:
> Hi Pratik,
> 
> On Wed, Aug 14, 2019 at 02:08:40AM +0530, Pratik Shinde wrote:
>> in fill_inode() we call iloc() twice.Avoiding the extra call by
>> storing the result.
>>
>> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> 
> I have no objection of this patch, but I'd like to
> hear Chao/Greg's idea about this...

It looks more clean. :)

Nitpick, maybe change 'inode_loc' to shorter 'iloc' will be better.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>  drivers/staging/erofs/inode.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>> index 4c3d8bf..d82ba6c 100644
>> --- a/drivers/staging/erofs/inode.c
>> +++ b/drivers/staging/erofs/inode.c
>> @@ -167,11 +167,12 @@ static int fill_inode(struct inode *inode, int isdir)
>>  	int err;
>>  	erofs_blk_t blkaddr;
>>  	unsigned int ofs;
>> +	erofs_off_t inode_loc;
>>  
>>  	trace_erofs_fill_inode(inode, isdir);
>> -
>> -	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
>> -	ofs = erofs_blkoff(iloc(sbi, vi->nid));
>> +	inode_loc = iloc(sbi, vi->nid);
>> +	blkaddr = erofs_blknr(inode_loc);
>> +	ofs = erofs_blkoff(inode_loc);
>>  
>>  	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
>>  		__func__, vi->nid, ofs, blkaddr);
>> -- 
>> 2.9.3
>>
> .
> 
