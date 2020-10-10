Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05193289EF6
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Oct 2020 09:32:22 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C7c8f3MxCzDqvx
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Oct 2020 18:32:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C7c8X050CzDqvD
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Oct 2020 18:32:07 +1100 (AEDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 92639645EF79D472F6FF;
 Sat, 10 Oct 2020 15:31:57 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 10 Oct
 2020 15:31:47 +0800
Subject: Re: [PATCH v2] AOSP: erofs-utils: add fs_config support
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.lee@aliyun.com>, Li Guifu
 <bluce.liguifu@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20200928213549.17580-1-hsiangkao@aol.com>
 <20200929051302.3324-1-hsiangkao@aol.com>
 <20201007150215.GA30128@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20201009023048.GA16011@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8f2addff-8a46-2cb6-5d72-5a0ba2f96dda@huawei.com>
Date: Sat, 10 Oct 2020 15:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201009023048.GA16011@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/10/9 10:32, Gao Xiang via Linux-erofs wrote:
> On Wed, Oct 07, 2020 at 11:02:18PM +0800, Gao Xiang via Linux-erofs wrote:
>> On Tue, Sep 29, 2020 at 01:13:02PM +0800, Gao Xiang wrote:
>>> So that mkfs can directly generate images with fs_config.
>>> All code for AOSP is wraped up with WITH_ANDROID macro.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
>>> ---
>>> changes since v1:
>>>   - fix compile issues on Android / Linux build;
>>>   - tested with Android system booting;
>>
>> Guifu, some feedback on this?
>> I'd like to merge it for AOSP preparation.
> 
> I will merge this if still no response at the end of this
> week. Since this main logic has already been used by other
> Android vendors for months and I do need to go forward on
> AOSP stuff.

Good job! :)

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
> .
> 
