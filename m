Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 32016E716E
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Oct 2019 13:36:34 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 471vNH1mRXzDqhS
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Oct 2019 23:36:31 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 471vN14qLPzDqVj
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Oct 2019 23:36:13 +1100 (AEDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 21712E3E9323C23C9E06;
 Mon, 28 Oct 2019 20:36:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct
 2019 20:36:01 +0800
Subject: Re: [PATCH v4] erofs: support superblock checksum
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
 <20191023084536.GA16289@architecture4>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
Date: Mon, 28 Oct 2019 20:36:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023084536.GA16289@architecture4>
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
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/10/23 16:45, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Oct 23, 2019 at 04:15:29PM +0800, Chao Yu wrote:
>> Hi, Xiang, Pratik,
>>
>> On 2019/10/23 12:05, Gao Xiang wrote:
> 
> <snip>
> 
>>>  }
>>>  
>>> +static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
>>> +{
>>> +	struct erofs_super_block *dsb;
>>> +	u32 expected_crc, nblocks, crc;
>>> +	void *kaddr;
>>> +	struct page *page;
>>> +	int i;
>>> +
>>> +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
>>> +		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
>>> +	if (!dsb)
>>> +		return -ENOMEM;
>>> +
>>> +	expected_crc = le32_to_cpu(dsb->checksum);
>>> +	nblocks = le32_to_cpu(dsb->chksum_blocks);
>>
>> Now, we try to use nblocks's value before checking its validation, I guess fuzz
>> test can easily make the value extreme larger, result in checking latter blocks
>> unnecessarily.
>>
>> IMO, we'd better
>> 1. check validation of superblock to make sure all fields in sb are valid
>> 2. use .nblocks to count and check payload blocks following sb
> 
> That is quite a good point. :-)
> 
> My first thought is to check the following payloads of sb (e.g, some per-fs
> metadata should be checked at mount time together. or for small images, check
> the whole image at the mount time) as well since if we introduce a new feature
> to some kernel version, forward compatibility needs to be considered. So it's
> better to make proper scalability, for this case, we have some choices:
>  1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
>     totally 256M.)
>  2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
>     at all, don't consider any latter scalability.

Xiang, sorry for later reply...

I prefer method 2), let's enable chksum feature only on superblock first,
chksum_blocks feature can be added later.

Thanks,

> 
> Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
> and hold up this feature for the next erofs-utils release, but I think we can
> get it ready for v5.5 since it is not quite complex feature...
> 
> Thanks,
> Gao Xiang
> 
> .
> 
