Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A87377D2DD
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 03:31:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zXnx1jSKzDqnk
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2019 11:31:49 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zXnj5l0HzDqnR
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2019 11:31:36 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E2944ED38F34723C517A;
 Thu,  1 Aug 2019 09:31:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:31:23 +0800
Subject: Re: [PATCH 07/22] staging: erofs: remove redundant #include
 "internal.h"
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-8-gaoxiang25@huawei.com>
 <bae5fc5b-b2e1-0d74-6374-b1ae5835cbb9@huawei.com>
 <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
 <b261d2bf-bdc0-a418-1cac-dc142c7dc467@huawei.com>
 <14ac0fe7-1742-875b-b01a-78b49cae303a@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <efc9e26a-1a01-af2b-0e48-90b255b98348@huawei.com>
Date: Thu, 1 Aug 2019 09:31:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <14ac0fe7-1742-875b-b01a-78b49cae303a@huawei.com>
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

On 2019/7/31 20:54, Gao Xiang wrote:
> 
> 
> On 2019/7/31 20:07, Chao Yu wrote:
>> Hi Xiang,
>>
>> On 2019/7/31 15:08, Gao Xiang wrote:
>>> Hi Chao,
>>>
>>> On 2019/7/31 15:03, Chao Yu wrote:
>>>> On 2019/7/29 14:51, Gao Xiang wrote:
>>>>> Because #include "internal.h" is included in xattr.h
>>>>
>>>> I think it would be better to remove "internal.h" in xattr.h, and include them
>>>> both in .c file in where we need xattr definition.
>>>
>>> It seems that all xattr related source files needing internal.h,
>>> and we need "EROFS_V(inode)", "struct erofs_sb_info", ... stuffs in xattr.h,
>>> which is defined in internal.h...
>>
>> Since I checked f2fs', it looks it's okay to don't include internal.h for
>> xattr.h, if .c needs xattr.h, we can just include interanl.h and xattr.h in the
>> head of it, it's safe.
> 
> I think xattr.h should be used independently (all dependencies of xattr.h should
> be included in xattr.h, most of include files behave like that)... Maybe it is
> not a good way to follow f2fs...

Yes, I've confirmed it's fine to do this, let's go ahead. :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>
>>>> Thanks,
>>>>
>>> .
>>>
> .
> 
