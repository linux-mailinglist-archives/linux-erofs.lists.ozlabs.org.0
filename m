Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A239B5A9A0
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jun 2019 10:40:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45bRsR5NQyzDqty
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Jun 2019 18:40:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45bRqw1PHnzDqwy
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Jun 2019 18:38:51 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 41C8D1123E9AD6730A49;
 Sat, 29 Jun 2019 16:38:46 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 29 Jun
 2019 16:38:39 +0800
Subject: Re: [PATCH] staging: erofs: don't check special inode layout
To: Yue Hu <zbestahu@gmail.com>, Gao Xiang <gaoxiang25@huawei.com>
References: <20190628034234.8832-1-zbestahu@gmail.com>
 <276837dc-b18a-6f20-fc33-d988dff5ae9f@huawei.com>
 <20190628121952.000028fc.zbestahu@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a3743d00-a5c8-6e2a-7b1b-f5111ca59009@huawei.com>
Date: Sat, 29 Jun 2019 16:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190628121952.000028fc.zbestahu@gmail.com>
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
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@yulong.com,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/6/28 12:19, Yue Hu wrote:
> On Fri, 28 Jun 2019 11:50:21 +0800
> Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
>> Hi Yue,
>>
>> On 2019/6/28 11:42, Yue Hu wrote:
>>> From: Yue Hu <huyue2@yulong.com>
>>>
>>> Currently, we will check if inode layout is compression or inline if
>>> the inode is special in fill_inode(). Also set ->i_mapping->a_ops for
>>> it. That is pointless since the both modes won't be set for special
>>> inode when creating EROFS filesystem image. So, let's avoid it.
>>>
>>> Signed-off-by: Yue Hu <huyue2@yulong.com>  
>>
>> Have you test this patch with some actual image with legacy mkfs since
>> new mkfs framework have not supported special inode...
> 
> Hi Xiang,
> 
> I'm studying the testing :)
> 
> However, already check the code handling for special inode in leagcy mkfs as below:
> 
> ```c
>                 break;
>         case EROFS_FT_BLKDEV:
>         case EROFS_FT_CHRDEV:
>         case EROFS_FT_FIFO:
>         case EROFS_FT_SOCK:
>                 mkfs_rank_inode(d);
>                 break;
> 
>         default:
>                 erofs_err("inode[%s] file_type error =%d",
>                           d->i_fullpath,
> ```
> 
> No special inode layout operations, so this change should be fine.
> 
> Thx.
> 
>>
>> I think that is fine in priciple, however, in case to introduce some potential
>> issues, I will test this patch later. I will give a Reviewed-by tag after I tested
>> this patch.

This patch looks good to me, if this won't fail any tests from Xiang, you can add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks.
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>> ---
>>>  drivers/staging/erofs/inode.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>>> index 1433f25..2fe0f6d 100644
>>> --- a/drivers/staging/erofs/inode.c
>>> +++ b/drivers/staging/erofs/inode.c
>>> @@ -205,6 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
>>>  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>>>  			inode->i_op = &erofs_generic_iops;
>>>  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
>>> +			goto out_unlock;
>>>  		} else {
>>>  			err = -EIO;
>>>  			goto out_unlock;
>>>   
> 
> .
> 
