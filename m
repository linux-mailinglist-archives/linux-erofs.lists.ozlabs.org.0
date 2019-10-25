Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E94E41F6
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2019 05:09:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zpxv6f3LzDqmd
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2019 14:09:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zpxj3KhpzDqlR
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2019 14:09:44 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 448C9DDE91490327202E;
 Fri, 25 Oct 2019 11:09:39 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 11:09:38 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 25 Oct 2019 11:09:38 +0800
Date: Fri, 25 Oct 2019 11:12:29 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191025031229.GB210047@architecture4>
References: <20191018010846.186484-1-pliard@google.com>
 <20191025004531.89978-1-pliard@google.com>
 <20191025025334.GA210047@architecture4>
 <CABXOdTeQTapfvKqGrqZME8JACeJhaHram_ZWk7ZZX2VWvYORaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABXOdTeQTapfvKqGrqZME8JACeJhaHram_ZWk7ZZX2VWvYORaw@mail.gmail.com>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Philippe Liard <pliard@google.com>, Guenter Roeck <groeck@chromium.org>,
 phillip@squashfs.org.uk, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 24, 2019 at 08:02:14PM -0700, Guenter Roeck wrote:
> On Thu, Oct 24, 2019 at 7:51 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > On Fri, Oct 25, 2019 at 09:45:31AM +0900, Philippe Liard wrote:
> > > > Personally speaking, just for Android related use cases, I'd suggest
> > > > latest EROFS if you care more about system overall performance more
> > > > than compression ratio, even https://lkml.org/lkml/2017/9/22/814 is
> > > > applied (you can do benchmark), we did much efforts 3 years ago.
> > > >
> > > > And that is not only performance but noticable memory overhead (a lot
> > > > of extra memory allocations) and heavy page cache thrashing in low
> > > > memory scenarios (it's very common [1].)
> > >
> > > Thanks for the suggestion. EROFS is on our radar and we will
> > > (re)consider it once it goes out of staging. But we will most likely
> > > stay on squashfs until this happens.
> >
> > EROFS is already out of staging in mainline right now,
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/
> >
> > If you agree on that, I'd suggest you try it right now
> > since it's widely (200+ million devices on the market)
> > deployed for our Android smartphones and fully open source
> > and open community. I think this is not a regrettable
> > attempt and we can response any question.
> >
> > https://lore.kernel.org/r/20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1
> >
> > In my personal opinion, just for Android use cases,
> > I think it is worth taking some time.
> >
> > All well said. The question, though, is if that is a reason to reject
> squashfs performance improvements. I argue that it is not. The decision to
> switch to erofs or not is completely orthogonal to squashfs performance
> improvements, and one doesn't preclude the other.

Note that I have no objection on this patch. And I'm happy to see any
improvements for other compression filesystems. And we are keeping on
boosting up our overall performance as well but I think I can give
some personal suggestions on given specific scenario since we already
did other solutions before. Just FYI to you.

Thanks,
Gao Xiang

> 
> Guenter
