Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E84A7CE8
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 09:39:19 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NbLD58LvzDqWN
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 17:39:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NbL85zkCzDqLs
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 17:39:11 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id F40EBA30E87F6D87541D;
 Wed,  4 Sep 2019 15:39:04 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Sep 2019 15:39:04 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 4 Sep 2019 15:39:04 +0800
Date: Wed, 4 Sep 2019 15:38:11 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] erofs: using switch-case while checking the inode type.
Message-ID: <20190904073811.GA37718@architecture4>
References: <20190830095615.10995-1-pratikshinde320@gmail.com>
 <20190830115947.GA10981@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190830142233.GA241393@architecture4>
 <20190904021247.GA65103@architecture4>
 <20190904063134.GA24285@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190904063134.GA24285@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 04, 2019 at 08:31:34AM +0200, Greg KH wrote:
> On Wed, Sep 04, 2019 at 10:12:47AM +0800, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On Fri, Aug 30, 2019 at 10:22:33PM +0800, Gao Xiang wrote:
> > > On Fri, Aug 30, 2019 at 07:59:48PM +0800, Gao Xiang wrote:
> > > > Hi Pratik,
> > > > 
> > > > The subject line could be better as '[PATCH v2] xxxxxx'...
> > > > 
> > > > On Fri, Aug 30, 2019 at 03:26:15PM +0530, Pratik Shinde wrote:
> > > > > while filling the linux inode, using switch-case statement to check
> > > > > the type of inode.
> > > > > switch-case statement looks more clean here.
> > > > > 
> > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > 
> > > > I have no problem of this patch, and I will do a test and reply
> > > > you "Reviewed-by:" in hours (I'm doing another patchset to resolve
> > > > what Christoph suggested again)...
> > > 
> > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > ping.. could you kindly merge this patch, the following patchset
> > has dependency on it...
> 
> Will go do that now, sorry for the delay.

Thanks Greg...

Thanks,
Gao Xiang

> 
> greg k-h
