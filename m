Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86AA5A83
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 17:25:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MYnZ5HWCzDqTZ
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 01:25:54 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MYnR1p4BzDq96
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 01:25:47 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 63347F3EFAF56709ABD5;
 Mon,  2 Sep 2019 23:25:44 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:25:44 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 23:25:43 +0800
Date: Mon, 2 Sep 2019 23:24:52 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902152451.GC179615@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902125109.GA9826@infradead.org>
 <20190902144303.GF2664@architecture4>
 <20190902151910.GA14009@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902151910.GA14009@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Mon, Sep 02, 2019 at 08:19:10AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 10:43:04PM +0800, Gao Xiang wrote:
> > Hi Christoph,
> > > > ...
> > > >  24         __le32 features;        /* (aka. feature_compat) */
> > > > ...
> > > >  38         __le32 requirements;    /* (aka. feature_incompat) */
> > > > ...
> > > >  41 };
> > > 
> > > This is only cosmetic, why not stick to feature_compat and
> > > feature_incompat?
> > 
> > Okay, will fix. (however, in my mind, I'm some confused why
> > "features" could be incompatible...)
> 
> The feature is incompatible if it requires changes to the driver.
> An easy to understand historic example is that ext3 originally did not
> have the file types in the directory entry.  Adding them means old
> file system drivers can not read a file system with this new feature,
> so an incompat flag has to be added.

Got it.

> 
> > > > > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > > > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > > > > +	       sizeof(layout->volume_name));
> > > > > 
> > > > > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > > > > if it is le it should be a guid_t).
> > > > 
> > > > For this case, I have no idea how to deal with...
> > > > I have little knowledge about this uuid stuff, so I just copied
> > > > from f2fs... (Could be no urgent of this field...)
> > > 
> > > Who fills out this field in the on-disk format and how?
> > 
> > mkfs.erofs, but this field leaves 0 for now. Is that reasonable?
> > (using libuuid can generate it easily...)
> 
> If the filed is always zero for now please don't fill it out.  If you
> decide it is worth adding the uuid eventually please add a compat
> feature flag that you have a valid uuid and only fill out the field
> if the file system actualy has a valid uuid.

Okay. Will do that then (as a note here).

Thanks,
Gao Xiang

