Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C95445A40
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Nov 2021 20:04:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HlY3k3gSQz2yNC
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 06:04:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bv7jKp3Y;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bv7jKp3Y; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlY3f65HTz2xXm
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Nov 2021 06:04:46 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B349D61051;
 Thu,  4 Nov 2021 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636052683;
 bh=6QPcBULZTXdCSGAGAHS0TvJSZvMO/KqkGnLb73dsPBc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bv7jKp3Yw1Rdie9XZDWNK3pIPqQoPNhud+EqCebVCSNFnXX1tJKRugwxgw+L+OWGR
 2MLp/jTRGzvo1NoqGoAE4h9SET6WwR2eC6KxGEbcMshVRiJ3shOzD+v3fRuOlCDV9R
 9G84hJuxDUt0jNPNpbLWG5OuhVHMx1EBgq9VUuR/29TPkJQ2u2B/sSSO0SotyKedJk
 vIVOo9i23NlZDiCmEUONOL1Ve83kSVqtxk9oDKbsfMth7fdhjwVmAa4V9JJhr/fdzN
 4WL/W9RmR5LhAyY6JcVhB45zjOxTxwGLojZm72rrw52Ey6bohVc7ZaZCNnE2bWDg9r
 QNnReKci3yYEQ==
Date: Thu, 4 Nov 2021 12:04:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: futher decouple DAX from block devices
Message-ID: <20211104190443.GK24333@magnolia>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Eric Sandeen <sandeen@sandeen.net>, virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 04, 2021 at 11:10:19AM -0700, Dan Williams wrote:
> On Thu, Nov 4, 2021 at 10:36 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Nov 04, 2021 at 10:34:17AM -0700, Darrick J. Wong wrote:
> > > /me wonders, are block devices going away?  Will mkfs.xfs have to learn
> > > how to talk to certain chardevs?  I guess jffs2 and others already do
> > > that kind of thing... but I suppose I can wait for the real draft to
> > > show up to ramble further. ;)
> >
> > Right now I've mostly been looking into the kernel side.  An no, I
> > do not expect /dev/pmem* to go away as you'll still need it for a
> > not DAX aware file system and/or application (such as mkfs initially).
> >
> > But yes, just pointing mkfs to the chardev should be doable with very
> > little work.  We can point it to a regular file after all.
> 
> Note that I've avoided implementing read/write fops for dax devices
> partly out of concern for not wanting to figure out shared-mmap vs
> write coherence issues, but also because of a bet with Dave Hansen
> that device-dax not grow features like what happened to hugetlbfs. So
> it would seem mkfs would need to switch to mmap I/O, or bite the
> bullet and implement read/write fops in the driver.

That ... would require a fair amount of userspace changes, though at
least e2fsprogs has pluggable io drivers, which would make mmapping a
character device not too awful.

xfsprogs would be another story -- porting the buffer cache mignt not be
too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
Note that xfsprogs explicitly screens out chardevs.

--D
