Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 30935E8976
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Oct 2019 14:29:19 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472XVh2jpmzF36w
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Oct 2019 00:29:16 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 472XVS0RYHzF0hB
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Oct 2019 00:28:59 +1100 (AEDT)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 9511ECAAA1D4E5468C6D;
 Tue, 29 Oct 2019 21:28:52 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 21:28:52 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 29 Oct 2019 21:28:52 +0800
Date: Tue, 29 Oct 2019 21:31:38 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: New things in erofs
Message-ID: <20191029133138.GA114663@architecture4>
References: <CAGu0czSVS4exiJJPg9SL8MpjwQahPRRuTt5Ho5s8Lcc6BK2D7w@mail.gmail.com>
 <20191026112431.GA6326@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czQfmMoSa-Sm9t+ZYf2b_YAfZ2b2-qPyTAbYvYHB5z-hDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czQfmMoSa-Sm9t+ZYf2b_YAfZ2b2-qPyTAbYvYHB5z-hDw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Tue, Oct 29, 2019 at 06:46:56PM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> Thanks.
> I am exploring following things in erofs:
> 1) Sparse file support for uncompressed files.
> 2) erofs.fsck(erofs-utils)
> 
> I hope above items are in the development plan & patches are accepted for
> them :)

Yes, they are definitely in the development plan, it would be appreciated
that you take some time to get them in shape if you have time. :-)

You can post RFC patch at any time, I will help on this as well.
For erofs.fsck (erofs-utils), it's better to share most common code in
"lib/" with mkfs.erofs.

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Sat, Oct 26, 2019 at 4:54 PM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Sat, Oct 26, 2019 at 12:56:10PM +0530, Pratik Shinde wrote:
> > > Hi Gao,
> > >
> > > Are there any new features/enhancements coming in erofs. Something that
> > we
> > > can contribute to?
> > >
> > > P. S. - I saw your erofs roadmap pdf on github.
> >
> > Thanks for your interest. As I mentioned before, I'm currently working on
> > adding a new XZ algorithm to erofs-utils because I'd like to make the
> > decompression framework more powerful and generic...
> >
> > And there are many TODOs in the roadmap pdf, you can pick up something
> > if you have some time or you can raise up some new ideas. It's very
> > helpful to make EROFS better.
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > --Pratik
> >
