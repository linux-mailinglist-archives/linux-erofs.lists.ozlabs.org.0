Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2BA592B
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 16:20:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MXLM0RlnzDqfs
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2019 00:20:42 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MXKy4xQSzDqf9
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2019 00:20:21 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id AB78EAD4E;
 Mon,  2 Sep 2019 14:20:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 080BADA796; Mon,  2 Sep 2019 16:20:37 +0200 (CEST)
Date: Mon, 2 Sep 2019 16:20:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
Message-ID: <20190902142037.GW2752@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Chao Yu <chao@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Gao Xiang <gaoxiang25@huawei.com>, linux-fsdevel@vger.kernel.org,
 devel@driverdev.osuosl.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 Amir Goldstein <amir73il@gmail.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Dave Chinner <david@fromorbit.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
 Richard Weinberger <richard@nod.at>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Miao Xie <miaoxie@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Fang Wei <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org>
 <20190902130644.GT2752@suse.cz>
 <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
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
 Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dsterba@suse.cz,
 Pavel Machek <pavel@denx.de>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2019 at 09:51:59PM +0800, Chao Yu wrote:
> On 2019-9-2 21:06, David Sterba wrote:
> > On Mon, Sep 02, 2019 at 05:57:11AM -0700, Christoph Hellwig wrote:
> >>> +config EROFS_FS_XATTR
> >>> +	bool "EROFS extended attributes"
> >>> +	depends on EROFS_FS
> >>> +	default y
> >>> +	help
> >>> +	  Extended attributes are name:value pairs associated with inodes by
> >>> +	  the kernel or by users (see the attr(5) manual page, or visit
> >>> +	  <http://acl.bestbits.at/> for details).
> >>> +
> >>> +	  If unsure, say N.
> >>> +
> >>> +config EROFS_FS_POSIX_ACL
> >>> +	bool "EROFS Access Control Lists"
> >>> +	depends on EROFS_FS_XATTR
> >>> +	select FS_POSIX_ACL
> >>> +	default y
> >>
> >> Is there any good reason to make these optional these days?
> > 
> > I objected against adding so many config options, not to say for the
> > standard features. The various cache strategies or other implementation
> > details have been removed but I agree that making xattr/acl configurable
> > is not necessary as well.
> 
> I can see similar *_ACL option in btrfs/ext4/xfs, should we remove them as well
> due to the same reason?

Oh right, I think the reasons are historical and that we can remove the
options nowadays. From the compatibility POV this should be safe, with
ACLs compiled out, no tool would use them, and no harm done when the
code is present but not used.

There were some efforts by embedded guys to make parts of kernel more
configurable to allow removing subsystems to reduce the final image
size. In this case I don't think it would make any noticeable
difference, eg. the size of fs/btrfs/acl.o on release config is 1.6KiB,
while the whole module is over 1.3MiB.
