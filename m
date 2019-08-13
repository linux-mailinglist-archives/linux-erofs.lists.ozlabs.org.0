Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1B8AF4F
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 08:11:01 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4672QV6048zDqZF
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 16:10:58 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4672QJ2Cj4zDqSG
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 16:10:45 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 48E537F3B8CC13C0C464;
 Tue, 13 Aug 2019 14:10:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 14:10:32 +0800
Subject: Re: [PATCH 3/3] staging: erofs: xattr.c: avoid BUG_ON
To: Gao Xiang <gaoxiang25@huawei.com>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
 <20190813023054.73126-3-gaoxiang25@huawei.com>
 <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
 <20190813035754.GA23614@138>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <aa7660a6-b8a9-f22f-2616-f51c45dd52ac@huawei.com>
Date: Tue, 13 Aug 2019 14:10:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190813035754.GA23614@138>
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
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On 2019/8/13 11:57, Gao Xiang wrote:
> Hi Chao,
> 
> On Tue, Aug 13, 2019 at 11:20:22AM +0800, Chao Yu wrote:
>> On 2019/8/13 10:30, Gao Xiang wrote:
>>> Kill all the remaining BUG_ON in EROFS:
>>>  - one BUG_ON was used to detect xattr on-disk corruption,
>>>    proper error handling should be added for it instead;
>>>  - the other BUG_ONs are used to detect potential issues,
>>>    use DBG_BUGON only in (eng) debugging version.
>>
>> BTW, do we need add WARN_ON() into DBG_BUGON() to show some details function or
>> call stack in where we encounter the issue?
> 
> Thanks for kindly review :)
> 
> Agreed, it seems much better. If there are no other considerations
> here, I can submit another patch addressing it later or maybe we
> can change it in the next linux version since I'd like to focusing
> on moving out of staging for this round...

No problem, we can change it in a proper time.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
> .
> 
