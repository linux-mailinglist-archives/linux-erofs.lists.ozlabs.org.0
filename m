Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F21A2233
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 19:27:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K8g95xH6zDrp4
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 03:27:01 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K8g54n1hzDrh7
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 03:26:55 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 67FB2820B3EF025C7953;
 Fri, 30 Aug 2019 01:26:51 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 01:26:50 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 01:26:49 +0800
Date: Fri, 30 Aug 2019 01:26:02 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190829172602.GA228414@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
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
Cc: Jan Kara <jack@suse.cz>, Dave
 Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>,
 Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Sterba <dsterba@suse.cz>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joe,

On Thu, Aug 29, 2019 at 08:58:17AM -0700, Joe Perches wrote:
> On Thu, 2019-08-29 at 18:32 +0800, Gao Xiang wrote:
> > Hi Christoph,
> > 
> > On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > > > --- /dev/null
> > > > +++ b/fs/erofs/erofs_fs.h
> > > > @@ -0,0 +1,316 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > > > +/*
> > > > + * linux/fs/erofs/erofs_fs.h
> > > 
> > > Please remove the pointless file names in the comment headers.
> > 
> > Already removed in the latest version.
> > 
> > > > +struct erofs_super_block {
> > > > +/*  0 */__le32 magic;           /* in the little endian */
> > > > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > > > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > > 
> > > Please remove all the byte offset comments.  That is something that can
> > > easily be checked with gdb or pahole.
> > 
> > I have no idea the actual issue here.
> > It will help all developpers better add fields or calculate
> > these offsets in their mind, and with care.
> > 
> > Rather than they didn't run "gdb" or "pahole" and change it by mistake.
> 
> I think Christoph is not right here.
> 
> Using external tools for validation is extra work
> when necessary for understanding the code.
> 
> The expected offset is somewhat valuable, but
> perhaps the form is a bit off given the visual
> run-in to the field types.
> 
> The extra work with this form is manipulating all
> the offsets whenever a structure change occurs.
> 
> The comments might be better with a form more like:

Thanks for your comment.
I will change those places as you suggested, that is fine.

Thanks,
Gao Xiang

> 
> struct erofs_super_block {	/* offset description */
> 	__le32 magic;		/*   0  */
> 	__le32 checksum;	/*   4  crc32c(super_block) */
> 	__le32 features;	/*   8  (aka. feature_compat) */
> 	__u8 blkszbits;		/*  12  support block_size == PAGE_SIZE only */
> 
> 
