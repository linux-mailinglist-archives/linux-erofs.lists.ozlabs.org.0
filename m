Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8117BC9E
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 11:07:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45z6yZ2K6JzDqLs
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2019 19:07:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45z6yL2qpDzDqcq
 for <linux-erofs@lists.ozlabs.org>; Wed, 31 Jul 2019 19:07:37 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3146AAB0E869606A36E4;
 Wed, 31 Jul 2019 17:07:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 17:07:28 +0800
Subject: Re: [PATCH 16/22] staging: erofs: tidy up decompression frontend
To: Gao Xiang <gaoxiang25@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-17-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b0d5c746-2450-7ad6-5714-de7ec1f20ea0@huawei.com>
Date: Wed, 31 Jul 2019 17:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729065159.62378-17-gaoxiang25@huawei.com>
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
Cc: weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/7/29 14:51, Gao Xiang wrote:
> Although this patch has an amount of changes, it is hard to
> separate into smaller patches.
> 
> Most changes are due to structure renaming for better understand
> and straightforward,
>  z_erofs_vle_workgroup to z_erofs_pcluster
>              since it represents a physical cluster;
>  z_erofs_vle_work to z_erofs_collection
>              since it represents a collection of logical pages;
>  z_erofs_vle_work_builder to z_erofs_collector
>              since it's used to fill z_erofs_{pcluster,collection}.
> 
> struct z_erofs_vle_work_finder has no extra use compared with
> struct z_erofs_collector, delete it.
> 
> FULL_LENGTH bit is integrated into .length of pcluster so that it
> can be updated with the corresponding length change in atomic.
> 
> Minor, add comments for better description.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

I hope I don't miss anything, since this is so huge cleanup...

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
