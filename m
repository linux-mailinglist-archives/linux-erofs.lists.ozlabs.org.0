Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6DC91CC9
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 07:52:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Bjjx1NwWzDr0B
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 15:52:05 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Bjjs031hzDqkm
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 15:51:59 +1000 (AEST)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 83A1CB25DEFF370E1043;
 Mon, 19 Aug 2019 13:51:55 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 13:51:54 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Aug 2019 13:51:54 +0800
Date: Mon, 19 Aug 2019 14:08:58 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] erofs: Use common kernel logging style
Message-ID: <20190819060858.GC30459@138>
References: <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818092839.GA18975@hsiangkao-HP-ZHAN-66-Pro-G1>
 <52e4e3a7f160f5d2825bec04a3bc4eb4b0d1165a.camel@perches.com>
 <20190819055243.GB30459@138>
 <31cb3e54fe532630b45bb74ba4fc688eb86eab1f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31cb3e54fe532630b45bb74ba4fc688eb86eab1f.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
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
Cc: devel <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joe,

On Sun, Aug 18, 2019 at 10:47:17PM -0700, Joe Perches wrote:
> On Mon, 2019-08-19 at 13:52 +0800, Gao Xiang wrote:
> > Hi Joe,
> 
> Hello.
> 
> > On Sun, Aug 18, 2019 at 10:28:41PM -0700, Joe Perches wrote:
> > > Rename errln, infoln, and debugln to the typical pr_<level> uses
> > > to the typical kernel styles of pr_<level>
> > 
> > How about using erofs_err / ... to instead that?
> 
> <shrug>  I've no opinion.
> It seems most fs/*/* filesystems actually do use pr_<level>
> sed works well if you want that.

Sorry, I mainly refer to ext4, ext2, xfs and f2fs...
I didn't notice the other filesystems, you are right.

Okay, I have no opinion as well (maybe we could turn back later to
introduce sb parameter...)

> 
> >  - I can hardly see directly use pr_<level> for those filesystems in fs/...
> 
> just fyi:
> 
> There was this one existing pr_<level> use in erofs

That is just because the following piece of code was taken from fs/mpage.c,
I tend to replace it with iomap in the later version after tail-end packing inline is done.

Thanks,
Gao Xiang

> 
> drivers/staging/erofs/data.c:366:                               pr_err("%s, readahead error at page %lu of nid %llu\n",
> drivers/staging/erofs/data.c-367-                                      __func__, page->index,
> drivers/staging/erofs/data.c-368-                                      EROFS_V(mapping->host)->nid);
> 
> 
> 
