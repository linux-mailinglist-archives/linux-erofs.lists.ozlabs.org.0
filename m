Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF58CFAD
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 11:32:52 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467kry0kPJzDqJc
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 19:32:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467krr4wv8zDq7g
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 19:32:42 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 8C0962FE565903BFDD72;
 Wed, 14 Aug 2019 17:32:35 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 17:32:35 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 14
 Aug 2019 17:32:34 +0800
Date: Wed, 14 Aug 2019 17:49:43 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RESEND 2/2] staging: erofs: differentiate unsupported
 on-disk format
Message-ID: <20190814094943.GA17960@138>
References: <20190814042525.4925-2-gaoxiang25@huawei.com>
 <20190814043208.15591-1-gaoxiang25@huawei.com>
 <20190814043208.15591-2-gaoxiang25@huawei.com>
 <108ee2f9-75dd-b8ab-8da7-b81c17bafbf6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <108ee2f9-75dd-b8ab-8da7-b81c17bafbf6@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
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
Cc: devel@driverdev.osuosl.org, Pavel Machek <pavel@denx.de>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Wed, Aug 14, 2019 at 05:25:51PM +0800, Chao Yu wrote:
> On 2019/8/14 12:32, Gao Xiang wrote:
> > For some specific fields, use ENOTSUPP instead of EIO
> > for values which look sane but aren't supported right now.
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> > +		return -ENOTSUPP;
> 
> A little bit confused about when we need to use ENOTSUPP or EOPNOTSUPP, I
> checked several manual of syscall, it looks EOPNOTSUPP is widely used.

It seems that you are right, I didn't notice this.
Let me resend this patchset to fix them all...

Thanks,
Gao Xiang

> 
> Thanks,
