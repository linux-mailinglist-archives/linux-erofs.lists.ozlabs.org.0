Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3EE72C8
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Oct 2019 14:43:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 471wry66kSzDr9S
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Oct 2019 00:42:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 471wqF263rzDr9P
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Oct 2019 00:41:26 +1100 (AEDT)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 57AF6E9C1175435F54AB;
 Mon, 28 Oct 2019 21:41:19 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 21:41:18 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 28 Oct 2019 21:41:18 +0800
Date: Mon, 28 Oct 2019 21:44:05 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] erofs: support superblock checksum
Message-ID: <20191028134405.GA186556@architecture4>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
 <20191023084536.GA16289@architecture4>
 <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
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

Hi Chao,

On Mon, Oct 28, 2019 at 08:36:00PM +0800, Chao Yu wrote:
> On 2019/10/23 16:45, Gao Xiang wrote:

<snip>

> > That is quite a good point. :-)
> > 
> > My first thought is to check the following payloads of sb (e.g, some per-fs
> > metadata should be checked at mount time together. or for small images, check
> > the whole image at the mount time) as well since if we introduce a new feature
> > to some kernel version, forward compatibility needs to be considered. So it's
> > better to make proper scalability, for this case, we have some choices:
> >  1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
> >     totally 256M.)
> >  2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
> >     at all, don't consider any latter scalability.
> 
> Xiang, sorry for later reply...
> 
> I prefer method 2), let's enable chksum feature only on superblock first,
> chksum_blocks feature can be added later.

Okay, got it. I will resend patch soon.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
> > and hold up this feature for the next erofs-utils release, but I think we can
> > get it ready for v5.5 since it is not quite complex feature...
> > 
> > Thanks,
> > Gao Xiang
> > 
> > .
> > 
