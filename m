Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84D49A32
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 09:16:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SfXP10dDzDqg8
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 17:16:53 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SfTK0Wg9zDqRB
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2019 17:14:12 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 57A751F306E6E079F216;
 Tue, 18 Jun 2019 15:14:06 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 15:13:58 +0800
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
 <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
 <20190618054709.GA4271@kroah.com>
 <df18d7f9-f65a-5697-c7c4-edb1ad846c3e@huawei.com>
 <20190618064523.GA6015@kroah.com>
 <2a6abbf9-20a9-c1dd-0091-d8e3009037eb@huawei.com>
 <20190618070503.GB9160@kroah.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <08079e72-3ab5-fc9e-d229-13540badf199@huawei.com>
Date: Tue, 18 Jun 2019 15:13:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190618070503.GB9160@kroah.com>
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/18 15:05, Greg Kroah-Hartman wrote:
> On Tue, Jun 18, 2019 at 02:52:21PM +0800, Gao Xiang wrote:
>>
>>
>> On 2019/6/18 14:45, Greg Kroah-Hartman wrote:
>>> On Tue, Jun 18, 2019 at 02:18:00PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2019/6/18 13:47, Greg Kroah-Hartman wrote:
>>>>> On Tue, Jun 18, 2019 at 09:47:08AM +0800, Gao Xiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
>>>>>>> On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
>>>>>>>> At last, this is RFC patch v1, which means it is not suitable for
>>>>>>>> merging soon... I'm still working on it, testing its stability
>>>>>>>> these days and hope these patches get merged for 5.3 LTS
>>>>>>>> (if 5.3 is a LTS version).
>>>>>>>
>>>>>>> Why would 5.3 be a LTS kernel?
>>>>>>>
>>>>>>> curious as to how you came up with that :)
>>>>>>
>>>>>> My personal thought is about one LTS kernel one year...
>>>>>> Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
>>>>>> which is not suitable for all historical LTSs...just prepare for 5.3...
>>>>>
>>>>> I try to pick the "last" kernel that is released each year, which
>>>>> sometimes is 5 kernels, sometimes 4, sometimes 6, depending on the
>>>>> release cycle.
>>>>>
>>>>> So odds are it will be 5.4 for the next LTS kernel, but we will not know
>>>>> more until it gets closer to release time.
>>>>
>>>> Thanks for kindly explanation :)
>>>>
>>>> Anyway, I will test these patches, land to our commerical products and try the best
>>>> efforts on making it more stable for Linux upstream to merge.
>>>
>>> Sounds great.
>>>
>>> But why do you need to add compression to get this code out of staging?
>>> Why not move it out now and then add compression and other new features
>>> to it then?
>>
>> Move out of staging could be over several linux versions since I'd like to get
>> majority fs people agreed to this.
> 
> You never know until you try :)

Thanks for your encouragement :)
Actually, I personally gave a brief talk on this year LSF/MM 2019 but since I cannot speak
English well so the entire effect is not good enough :(...

I will personally contact with important people ... to get their agreements on this file
system soon.

> 
>> Decompression inplace is an important part of erofs to show its performance
>> benefits over existed compress filesystems and I tend to merge it in advance.
> 
> There is no requirement to show benefits over other filesystems in order
> to get it merged, but I understand the feeling.  That's fine, we can
> wait, we are not going anywhere...

Thanks again. I am just proving that the erofs solution may be one of the best compression
solutions in performance first scenerio :)

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
