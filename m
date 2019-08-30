Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58BA3644
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 14:07:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KdWW1RXzzDqw6
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 22:07:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KdWR3DF2zDqvL
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 22:06:57 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0B3E4B662;
 Fri, 30 Aug 2019 12:06:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 4079DDA809; Fri, 30 Aug 2019 14:07:14 +0200 (CEST)
Date: Fri, 30 Aug 2019 14:07:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
Message-ID: <20190830120714.GN2752@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Joe Perches <joe@perches.com>,
 Gao Xiang <gaoxiang25@huawei.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 Amir Goldstein <amir73il@gmail.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Dave Chinner <david@fromorbit.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
 <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
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

The advantage of using the external tools that the information about
offsets is provably correct ...

> The expected offset is somewhat valuable, but
> perhaps the form is a bit off given the visual
> run-in to the field types.
> 
> The extra work with this form is manipulating all
> the offsets whenever a structure change occurs.

... while this is error prone.

> The comments might be better with a form more like:
> 
> struct erofs_super_block {	/* offset description */
> 	__le32 magic;		/*   0  */
> 	__le32 checksum;	/*   4  crc32c(super_block) */
> 	__le32 features;	/*   8  (aka. feature_compat) */
> 	__u8 blkszbits;		/*  12  support block_size == PAGE_SIZE only */
