Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31C8AD2F
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 05:41:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 466z5c1RX5zDqf0
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Aug 2019 13:41:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466z5P2st2zDq63
 for <linux-erofs@lists.ozlabs.org>; Tue, 13 Aug 2019 13:40:55 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 90EE0B75969977179D59;
 Tue, 13 Aug 2019 11:40:50 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 13 Aug 2019 11:40:49 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 13
 Aug 2019 11:40:49 +0800
Date: Tue, 13 Aug 2019 11:57:57 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] staging: erofs: xattr.c: avoid BUG_ON
Message-ID: <20190813035754.GA23614@138>
References: <20190813023054.73126-1-gaoxiang25@huawei.com>
 <20190813023054.73126-3-gaoxiang25@huawei.com>
 <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84f50ca2-3411-36a6-049a-0d343d8df325@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, Aug 13, 2019 at 11:20:22AM +0800, Chao Yu wrote:
> On 2019/8/13 10:30, Gao Xiang wrote:
> > Kill all the remaining BUG_ON in EROFS:
> >  - one BUG_ON was used to detect xattr on-disk corruption,
> >    proper error handling should be added for it instead;
> >  - the other BUG_ONs are used to detect potential issues,
> >    use DBG_BUGON only in (eng) debugging version.
> 
> BTW, do we need add WARN_ON() into DBG_BUGON() to show some details function or
> call stack in where we encounter the issue?

Thanks for kindly review :)

Agreed, it seems much better. If there are no other considerations
here, I can submit another patch addressing it later or maybe we
can change it in the next linux version since I'd like to focusing
on moving out of staging for this round...

Thanks,
Gao Xiang

> 
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
