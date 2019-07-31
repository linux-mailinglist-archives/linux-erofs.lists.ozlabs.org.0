Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1547C3DD
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 15:44:25 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zF5f216zzDq9L
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 23:44:22 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zC1n56JvzDqY2
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2019 22:10:53 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 1A25B41E2D691E92CF1D;
 Wed, 31 Jul 2019 20:10:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 20:10:40 +0800
Subject: Re: [PATCH 08/22] staging: erofs: kill CONFIG_EROFS_FS_IO_MAX_RETRIES
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-9-gaoxiang25@huawei.com>
 <1c979e3f-54ec-cce8-650c-39e060e72169@huawei.com>
 <2d7abbad-61d0-df2b-6a42-26f2606d775a@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <985b3ca7-afee-006e-a367-98a865995246@huawei.com>
Date: Wed, 31 Jul 2019 20:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2d7abbad-61d0-df2b-6a42-26f2606d775a@huawei.com>
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2019/7/31 15:11, Gao Xiang wrote:
> Hi Chao,
> 
> On 2019/7/31 15:05, Chao Yu wrote:
>> On 2019/7/29 14:51, Gao Xiang wrote:
>>> CONFIG_EROFS_FS_IO_MAX_RETRIES seems a runtime setting
>>> and users have no idea about the change in behaviour.
>>>
>>> Let's remove the setting currently and fold it into code,
>>> turn it into a module parameter if it's really needed.
>>>
>>> Suggested-by: David Sterba <dsterba@suse.cz>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>
>> It's fine to me, but I'd like to suggest to add this as a sys entry which can be
>> more flexible for user to change.
> 
> I think it can be added in the later version, the original view
> from David is that he had question how users using this option.
> 
> Maybe we can use the default value and leave it to users who
> really need to modify this value (real requirement).

I think we need to decide it in this version, otherwise it may face backward
compatibility issue if we change module argument to sys entry later.

Maybe just leave it as an fixed macro is fine, since there is actually no
requirement on this.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks
>>
> .
> 
