Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BD22E4CB57
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 11:52:57 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45TxvW1cvRzDr3t
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 19:52:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45TxvQ64Q8zDq5n
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Jun 2019 19:52:50 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 0B32ECE455B2C6F9B038;
 Thu, 20 Jun 2019 17:52:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Jun
 2019 17:52:40 +0800
Subject: Re: [PATCH] staging: erofs: remove needless CONFIG_EROFS_FS_SECURITY
To: Yue Hu <zbestahu@gmail.com>
References: <20190620083004.2488-1-zbestahu@gmail.com>
 <8a45f678-15cc-be9a-282f-49b251f127a9@huawei.com>
 <fdc23da6-90eb-e3f0-448a-5df1494f4190@huawei.com>
 <20190620172955.00000e7a.zbestahu@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <80310b8c-88fd-5350-71a4-9131b712731a@huawei.com>
Date: Thu, 20 Jun 2019 17:52:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620172955.00000e7a.zbestahu@gmail.com>
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
Cc: gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/6/20 17:29, Yue Hu wrote:
> On Thu, 20 Jun 2019 17:22:48 +0800
> Chao Yu <yuchao0@huawei.com> wrote:
> 
>> On 2019/6/20 16:32, Gao Xiang wrote:
>>> Hi Yue,
>>>
>>> On 2019/6/20 16:30, Yue Hu wrote:  
>>>> From: Yue Hu <huyue2@yulong.com>
>>>>
>>>> erofs_xattr_security_handler is already marked __maybe_unused, no need
>>>> to add CONFIG_EROFS_FS_SECURITY condition.  
>>
>> CONFIG_EROFS_FS_SECURITY is used as a control switch of erofs security labels
>> feature, but __maybe_unused is to avoid unneeded compiler warning on unused
>> variable, so I think we can't remove it.
> 
> However, erofs_xattr_security_handler will not unused under CONFIG_EROFS_FS_SECURITY
> condition, right?

Yes, we will referred it in erofs_xattr_handlers anyway, so, maybe we can remove
__maybe_unused instead?

Thanks,

> 
> Thx.
> 
>>
>> Thanks,
>>
>>>>
>>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>>> ---
>>>>  drivers/staging/erofs/xattr.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
>>>> index df40654..06024ac 100644
>>>> --- a/drivers/staging/erofs/xattr.c
>>>> +++ b/drivers/staging/erofs/xattr.c
>>>> @@ -499,13 +499,11 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
>>>>  	.get	= erofs_xattr_generic_get,
>>>>  };
>>>>  
>>>> -#ifdef CONFIG_EROFS_FS_SECURITY
>>>>  const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
>>>>  	.prefix	= XATTR_SECURITY_PREFIX,
>>>>  	.flags	= EROFS_XATTR_INDEX_SECURITY,
>>>>  	.get	= erofs_xattr_generic_get,
>>>>  };
>>>> -#endif  
>>>
>>> Thanks for your patch.
>>>
>>> In that case...erofs_xattr_security_handler could be compiled into .rodata section?
>>> I am not sure...
>>>
>>> Thanks,
>>> Gao Xiang
>>>   
>>>>  
>>>>  const struct xattr_handler *erofs_xattr_handlers[] = {
>>>>  	&erofs_xattr_user_handler,
>>>>  
>>> .
>>>   
> 
> .
> 
