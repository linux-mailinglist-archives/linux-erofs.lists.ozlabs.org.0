Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE4CB14
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 11:39:36 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Txc53kNDzDr1P
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 19:39:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Txby4ffrzDq6y
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 19:39:26 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F32ABA97709148F9AA04;
 Thu, 20 Jun 2019 17:39:20 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Jun
 2019 17:39:11 +0800
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
To: Yue Hu <zbestahu@gmail.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
 <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
 <20190620172552.000015bd.zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <416ac426-f609-63ab-c0b3-ce0482ed8ca6@huawei.com>
Date: Thu, 20 Jun 2019 17:39:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190620172552.000015bd.zbestahu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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
Cc: gregkh@linuxfoundation.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/20 17:25, Yue Hu wrote:
> On Thu, 20 Jun 2019 16:32:01 +0800
> Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
>> Hi Yue,
>>
>> On 2019/6/20 16:30, Yue Hu wrote:
>>> From: Yue Hu <huyue2@yulong.com>
>>>
>>> erofs_xattr_security_handler is already marked __maybe_unused, no need
>>> to add CONFIG_EROFS_FS_SECURITY condition.
>>>
>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>> ---
>>>  drivers/staging/erofs/xattr.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
>>> index df40654..06024ac 100644
>>> --- a/drivers/staging/erofs/xattr.c
>>> +++ b/drivers/staging/erofs/xattr.c
>>> @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>>>  	.get	= erofs_xattr_generic_get,
>>>  };
>>>  
>>> -#ifdef CONFIG_EROFS_FS_SECURITY
>>>  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
>>>  	.prefix	= XATTR_SECURITY_PREFIX,
>>>  	.flags	= EROFS_XATTR_INDEX_SECURITY,
>>>  	.get	= erofs_xattr_generic_get,
>>>  };
>>> -#endif  
>>
>> Thanks for your patch.
>>
>> In that case...erofs_xattr_security_handler could be compiled into .rodata section?
>> I am not sure...
> 
> Yes, just like erofs_xattr_user_handler as below in System.map.
> 
> ffffffff820ec2a0 R erofs_xattr_security_handler
> ffffffff820ec2e0 R erofs_xattr_trusted_handler
> ffffffff820ec320 R erofs_xattr_user_handler

As a usual practice, CONFIG_{EXT2,EXT4,F2FS,EROFS}_FS_SECURITY are defined as
kernel configuations.

It seems that for ext2/ext4 they leave

const struct xattr_handler ext2_xattr_security_handler = {

in xattr_security.c and the Makefiles are similar as

fs/ext2/Makefile
13:ext2-$(CONFIG_EXT2_FS_SECURITY)       += xattr_security.o

But for f2fs, f2fs_xattr_security_handler is not wrapped with any configuration.

Actually I think that is not a big deal, I'd like to listen Chao and Greg's
idea about this...

Thanks,
Gao Xiang

> 
> Thx.
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>  
>>>  const struct xattr_handler *erofs_xattr_handlers[] = {
>>>  	&erofs_xattr_user_handler,
>>>   
> 
