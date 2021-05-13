Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8937F372
	for <lists+linux-erofs@lfdr.de>; Thu, 13 May 2021 09:14:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgjZj4MSJz2yy3
	for <lists+linux-erofs@lfdr.de>; Thu, 13 May 2021 17:14:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
X-Greylist: delayed 1183 seconds by postgrey-1.36 at boromir;
 Thu, 13 May 2021 17:14:18 AEST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgjZf187wz2ym7
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 May 2021 17:14:14 +1000 (AEST)
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fgj2p6QW9z19HC1;
 Thu, 13 May 2021 14:50:10 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 14:54:27 +0800
Subject: Re: [PATCH] erofs: fix 1 lcluster-sized pcluster for big pcluster
To: Gao Xiang <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
References: <20210510064715.29123-1-xiang@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <06a646a0-8436-2fd7-4c1b-1d5ea86c600e@huawei.com>
Date: Thu, 13 May 2021 14:54:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510064715.29123-1-xiang@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/5/10 14:47, Gao Xiang wrote:
> If the 1st NONHEAD lcluster of a pcluster isn't CBLKCNT lcluster type
> rather than a HEAD or PLAIN type instead, which means its pclustersize
> _must_ be 1 lcluster (since its uncompressed size < 2 lclusters),
> as illustrated below:
> 
>         HEAD     HEAD / PLAIN    lcluster type
>     ____________ ____________
>    |_:__________|_________:__|   file data (uncompressed)
>     .                .
>    .____________.
>    |____________|                pcluster data (compressed)
> 
> Such on-disk case was explained before [1] but missed to be handled
> properly in the runtime implementation.
> 
> It can be observed if manually generating 1 lcluster-sized pcluster
> with 2 lclusters (thus CBLKCNT doesn't exist.) Let's fix it now.
> 
> [1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <xiang@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
