Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE85A1EA4
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 17:14:56 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K5kj33JvzDrq8
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 01:14:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K5kZ06KvzDrgn
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 01:14:44 +1000 (AEST)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id C23A7307FB9537182FB3;
 Thu, 29 Aug 2019 23:14:40 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 23:14:40 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 23:14:39 +0800
Date: Thu, 29 Aug 2019 23:13:53 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: erofs: using switch-case while checking the
 inode type.
Message-ID: <20190829151352.GA100055@architecture4>
References: <20190829130813.11721-1-pratikshinde320@gmail.com>
 <20190829135607.GA195010@architecture4>
 <CAGu0czRasWHj53uF5zAoDRjbxU2sgN6HtazN_9Y-mkK6NjO-LQ@mail.gmail.com>
 <20190829141522.GA15562@architecture4>
 <20190829150436.GI23584@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829150436.GI23584@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dan,

On Thu, Aug 29, 2019 at 06:04:36PM +0300, Dan Carpenter wrote:
> On Thu, Aug 29, 2019 at 10:15:22PM +0800, Gao Xiang wrote:
> > I am very happy that you send a patch about this, but we have
> > to take care of handling "fall through" properly at least,
> > and I don't want to introduce some extra compile warnings
> > instead at this time.
> 
> I can't apply the patch so I maybe missed something.  I don't see
> a fall through issue.  We have the code so you could use ^^^^^^^^ to
> indicate which lines have a fall through problem.
> 
> > 
> > EROFS is sensitive for now and I have no idea what the "real"
> > point is.
> 
> What does "sensitive" mean here?  Now that it's out of staging we
> aren't applying clean up patches?

Of course not, I mean we should avoid "fall through" problem
but I have no time to verify this patch since I am fixing what
hch said as well.

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
