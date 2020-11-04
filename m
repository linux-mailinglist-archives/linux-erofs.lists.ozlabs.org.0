Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 068892A5C21
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 02:45:16 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQqGc6gY4zDqbw
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 12:45:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQqGX0xfhzDqF5
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Nov 2020 12:45:03 +1100 (AEDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQqGJ6pKyz15Qjc;
 Wed,  4 Nov 2020 09:44:56 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 4 Nov 2020
 09:44:56 +0800
Subject: Re: [PATCH 1/4] erofs: fix setting up pcluster for temporary pages
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201022145724.27284-1-hsiangkao.ref@aol.com>
 <20201022145724.27284-1-hsiangkao@aol.com>
 <f1f24a38-97f7-e9cf-03c8-2c95814b98a3@huawei.com>
 <20201104011130.GA982972@xiangao.remote.csb>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <e4cbe373-ca69-5f95-99c7-422375c58e4e@huawei.com>
Date: Wed, 4 Nov 2020 09:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201104011130.GA982972@xiangao.remote.csb>
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
Cc: stable@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/11/4 9:11, Gao Xiang wrote:
> On Wed, Nov 04, 2020 at 09:05:56AM +0800, Chao Yu wrote:
>> On 2020/10/22 22:57, Gao Xiang wrote:
>>> From: Gao Xiang <hsiangkao@redhat.com>
>>>
>>> pcluster should be only set up for all managed pages instead of
>>> temporary pages. Since it currently uses page->mapping to identify,
>>> the impact is minor for now.
>>>
>>> Fixes: 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
>>> Cc: <stable@vger.kernel.org> # 5.5+
>>> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks, I've also added a note to the commit message like this,
> "
> [ Update: Vladimir reported the kernel log becomes polluted
>    because PAGE_FLAGS_CHECK_AT_FREE flag(s) set if the page
>    allocation debug option is enabled. ]
> "
> Will apply all of this to -fixes branch.

Thanks for noticing that, looks fine to me.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
> 
> .
> 
