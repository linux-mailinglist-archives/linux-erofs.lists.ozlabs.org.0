Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD2BA2046
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 18:02:01 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K6n31WjPzDr7p
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 02:01:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.81; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0081.hostedemail.com
 [216.40.44.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K6j206vFzDsFZ
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 01:58:28 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 22F09182251AF;
 Thu, 29 Aug 2019 15:58:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::::::::::::::::::::::::::::,
 RULES_HIT:41:355:379:599:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3874:4321:4605:5007:6119:6742:6743:7903:10004:10400:10848:11026:11232:11657:11658:11914:12296:12297:12740:12760:12895:13069:13138:13161:13229:13231:13311:13357:13439:14096:14097:14180:14659:14721:21060:21080:21611:21627:21740:30012:30030:30054:30069:30070:30090:30091,
 0,
 RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:24,
 LUA_SUMMARY:none
X-HE-Tag: cub88_2b93c88708b5f
X-Filterd-Recvd-Size: 3480
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Thu, 29 Aug 2019 15:58:19 +0000 (UTC)
Message-ID: <67d6efbbc9ac6db23215660cb970b7ef29dc0c1d.camel@perches.com>
Subject: Re: [PATCH v6 01/24] erofs: add on-disk layout
From: Joe Perches <joe@perches.com>
To: Gao Xiang <gaoxiang25@huawei.com>, Christoph Hellwig <hch@infradead.org>
Date: Thu, 29 Aug 2019 08:58:17 -0700
In-Reply-To: <20190829103252.GA64893@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-2-gaoxiang25@huawei.com>
 <20190829095954.GB20598@infradead.org>
 <20190829103252.GA64893@architecture4>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, Pavel Machek <pavel@denx.de>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2019-08-29 at 18:32 +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Thu, Aug 29, 2019 at 02:59:54AM -0700, Christoph Hellwig wrote:
> > > --- /dev/null
> > > +++ b/fs/erofs/erofs_fs.h
> > > @@ -0,0 +1,316 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> > > +/*
> > > + * linux/fs/erofs/erofs_fs.h
> > 
> > Please remove the pointless file names in the comment headers.
> 
> Already removed in the latest version.
> 
> > > +struct erofs_super_block {
> > > +/*  0 */__le32 magic;           /* in the little endian */
> > > +/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > +/*  8 */__le32 features;        /* (aka. feature_compat) */
> > > +/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
> > 
> > Please remove all the byte offset comments.  That is something that can
> > easily be checked with gdb or pahole.
> 
> I have no idea the actual issue here.
> It will help all developpers better add fields or calculate
> these offsets in their mind, and with care.
> 
> Rather than they didn't run "gdb" or "pahole" and change it by mistake.

I think Christoph is not right here.

Using external tools for validation is extra work
when necessary for understanding the code.

The expected offset is somewhat valuable, but
perhaps the form is a bit off given the visual
run-in to the field types.

The extra work with this form is manipulating all
the offsets whenever a structure change occurs.

The comments might be better with a form more like:

struct erofs_super_block {	/* offset description */
	__le32 magic;		/*   0  */
	__le32 checksum;	/*   4  crc32c(super_block) */
	__le32 features;	/*   8  (aka. feature_compat) */
	__u8 blkszbits;		/*  12  support block_size == PAGE_SIZE only */


