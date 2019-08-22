Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3E996C5
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 16:35:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DnBl5dv0zDqD2
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Aug 2019 00:35:43 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DnBJ1GwkzDqD2
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Aug 2019 00:35:17 +1000 (AEST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 8DCA9D90A3DC820CA5CD;
 Thu, 22 Aug 2019 22:35:12 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 22:35:12 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 22:35:11 +0800
Date: Thu, 22 Aug 2019 22:34:32 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822143432.GB195034@architecture4>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
 <20190822142142.GB2730@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190822142142.GB2730@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
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
Cc: Richard Weinberger <richard@nod.at>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Ted,

On Thu, Aug 22, 2019 at 10:21:42AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Aug 22, 2019 at 10:33:01AM +0200, Richard Weinberger wrote:
> > > super block chksum could be a compatible feature right? which means
> > > new kernel can support it (maybe we can add a warning if such image
> > > doesn't have a chksum then when mounting) but old kernel doesn't
> > > care it.
> > 
> > Yes. But you need some why to indicate that the chksum field is now
> > valid and must be used.
> > 
> > The features field can be used for that, but you don't use it right now.
> > I recommend to check it for being 0, 0 means then "no features".
> > If somebody creates in future a erofs with more features this code
> > can refuse to mount because it does not support these features.
> 
> The whole point of "compat" features is that the kernel can go ahead
> and mount the file system even if there is some new "compat" feature
> which it doesn't understand.  So the fact that right now erofs doesn't
> have any "compat" features means it's not surprising, and perfectly
> OK, if it's not referenced by the kernel.
> 
> For ext4, we have some more complex feature bitmasks, "compat",
> "ro_compat" (OK to mount read-only if there are features you don't
> understand) and "incompat" (if there are any bits you don't
> understand, fail the mount).  But since erofs is a read-only file
> system, things are much simpler.
> 
> It might make life easier for other kernel developers if "features"
> was named "compat_features" and "requirements" were named
> "incompat_features", just because of the long-standing use of that in
> ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
> legacy of ext2 and its descendents, and there's no real reason why it
> has to be that way on other file systems.

Thanks for your detailed explanation, thanks a lot!

Thanks,
Gao Xiang

> 
> Cheers,
> 
> 						- Ted
