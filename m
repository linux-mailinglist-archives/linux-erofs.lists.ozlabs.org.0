Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 090525F6A8
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 12:32:04 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fZ672m7YzDqY5
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jul 2019 20:31:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fZ634DntzDqW5
 for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jul 2019 20:31:53 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F1DF11997EE06086CD30;
 Thu,  4 Jul 2019 18:31:45 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 18:31:38 +0800
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
To: Yue Hu <zbestahu@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <20190702025601.7976-1-zbestahu@gmail.com>
 <20190703162038.GA31307@kroah.com>
 <20190704095903.0000565e.zbestahu@gmail.com>
 <20190704052649.GA7454@kroah.com>
 <20190704180207.0000374e.zbestahu@gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fd781a85-10f9-9cbb-9e14-1757153bb9ff@huawei.com>
Date: Thu, 4 Jul 2019 18:31:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190704180207.0000374e.zbestahu@gmail.com>
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
Cc: devel@driverdev.osuosl.org, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/4 18:02, Yue Hu wrote:
> On Thu, 4 Jul 2019 07:26:49 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Thu, Jul 04, 2019 at 09:59:03AM +0800, Yue Hu wrote:
>>> On Wed, 3 Jul 2019 18:20:38 +0200
>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>   
>>>> On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:  
>>>>> From: Yue Hu <huyue2@yulong.com>
>>>>>
>>>>> Already check if ->datamode is supported in read_inode(), no need to check
>>>>> again in the next fill_inline_data() only called by fill_inode().
>>>>>
>>>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>>>> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
>>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>> ---
>>>>> no change
>>>>>
>>>>>  drivers/staging/erofs/inode.c | 2 --
>>>>>  1 file changed, 2 deletions(-)    
>>>>
>>>> This is already in my tree, right?  
>>>
>>> Seems not, i have received notes about other 2 patches below mergerd:
>>>
>>> ```note1
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     staging: erofs: don't check special inode layout
>>>
>>> to my staging git tree which can be found at
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>>> in the staging-next branch.
>>> ```
>>>
>>> ```note2
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     staging: erofs: return the error value if fill_inline_data() fails
>>>
>>> to my staging git tree which can be found at
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>>> in the staging-next branch.
>>> ```
>>>
>>> No this patch in below link checked:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/drivers/staging/erofs?h=staging-testing  
>>
>> Then if it is not present, it needs to be rebased as it does not apply.
>>
>> Please do so and resend it.
> 
> Hm, no need to resend since it's included in another patch below.
> 
> ec8c244 staging: erofs: add compacted ondisk compression indexes.

Yes, it seems it was modified by the following patch occasionally months ago.
https://lore.kernel.org/lkml/20190614181619.64905-2-gaoxiang25@huawei.com/

Anyway, thanks for your patch. :)

Thanks,
Gao Xiang

> 
> Thanks.
> 
>>
>> thanks,
>>
>> greg k-h
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
> 
