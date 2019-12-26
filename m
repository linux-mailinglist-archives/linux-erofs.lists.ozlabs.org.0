Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C6712AA71
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2019 07:01:12 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47jzps555YzDqJq
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Dec 2019 17:01:09 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47jzpl3RnFzDqJT
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2019 17:00:57 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B10B442C39B7155CC272
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Dec 2019 14:00:48 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Dec 2019 14:00:46 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 26 Dec 2019 14:00:46 +0800
Date: Thu, 26 Dec 2019 14:00:28 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
Message-ID: <20191226060028.GA89409@architecture4>
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
 <20191224034817.GA164058@architecture4>
 <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
 <20191224100511.GB164058@architecture4>
 <CAGu0czTzBiT_n-13tXohNp22gbJrsdNXdY7kYDvv=WDdn2hZwA@mail.gmail.com>
 <20191224111553.GC164058@architecture4>
 <CAGu0czQzwunpV2pV6EujWknWKt+uALmSHKqCBPjxhxJ=BZY5gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czQzwunpV2pV6EujWknWKt+uALmSHKqCBPjxhxJ=BZY5gQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 26, 2019 at 11:12:09AM +0530, Pratik Shinde wrote:
> Thanks Gao.
> 
> Now I understand the purpose.
> So with i_format we will be able to recognize which path to take. i.e fast
> path (flat mode) or slow path(i.e to search through extent list).
> I am working on it.

Thanks. Yes, that is the original consideration of i_format design and
sorry for some misrepresentations in the previous email such as what
I meant is "old kernel forward compatibility", etc..

But I think the final i_format new mode number is minor for now (I can
also assign a new number based on your patch) because I'd like to
rearrange this field for better scalability as an extra patch in advance
together with your patch.

we can get the main new extent approach in shape first. :-)

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Tue, Dec 24, 2019 at 4:46 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > On Tue, Dec 24, 2019 at 04:15:47PM +0530, Pratik Shinde wrote:
> > > Hi Gao,
> > >
> > > No no. What I am saying is - in the current code (excluding all my
> > changes)
> > > the block lookup will happens in constant time. with only hole list it
> >
> > Not only lookup but other interfaces such as fiemap, that is why called
> > flat mode and fast path.
> >
> > > won't be O(1) time but rather we have to traverse the holes list. (say in
> > > binary search way).
> > > what I don't understand is - what is the purpose of tracking data
> > extents.
> > > hope you get it.
> >
> > Mode plain and inline are called flat modes, which is the most common
> > case of regular and dir files. You can see that's the fastest path for
> > most file accesses (minimum metadata).
> >
> > The reason why don't extend the flat modes but introduce another new
> > sparse mode for 3 main reasons:
> >  1) introduce a complete enhanced new extent table (or later B+-tree);
> >  2) we don't even know how many holes in the file if we only read
> >     inode base metadata, some extra header (no matter extent or hole
> >     header) need to be readed in advance;
> >  3) Old kernel backward compatibility need to be considered, not all
> >     files are sparsed, and we need to get them work properly, and rest
> >     files are sparsed, we need to block such files from accessed by
> >     old kernels;
> >
> > Note that i_format is for such use, so we can introduce sparse mode
> > with some enhanced on-disk representation (but with more metadata
> > read amplification than flat modes).
> >
> > So if files without holes it should be considered as flat modes (fast
> > path), and then considering the slow path --- upcoming sparse mode.
> >
> > The purpose of tracking data extents is we could then use it
> > for deduping, repeated data or data redirect. Hole can only be 0
> > though.
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > --Pratik.
> > >
> >
