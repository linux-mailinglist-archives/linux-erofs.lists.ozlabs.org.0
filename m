Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 824AF445EA8
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 04:33:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HlmLT387qz2yYx
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Nov 2021 14:33:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GDZA848H;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=GDZA848H; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HlmLJ1D8Bz2xtw
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Nov 2021 14:33:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vYTj4+Qj7wwu4cVg0DWamUnt0bl+yIq5bTcfsNjRRqw=; b=GDZA848HxP31gXPJrbJb1hsEqw
 0f4xGgqaPeTYr/jnGmCuCwIDm9/vBUN70m1anN1+xf4jYdLKo8bnkpv98Tz/4LSFfutV+5RUbsHcn
 xvpui7RzzIwOqB9/ri4wv9GDDtkkShT1u8edH0UBE2oBmmJEo1CNw0G0wxCGXXKlubAjOM2Ro/Ehs
 bQ0RTb1mP+goFvBzd5NdSO+UkHqegStEbVRdq3ZH+RO1ssVK/8iJEk/+Yic/9NxIG4O8ZIrUL3aQU
 GV3eG6t1cGKVIkDmU4bZ62AO0lzIYsinGEt5zLBc3KGEkXCrJ55GrQMAElwFrvICgT/tM4n5HS7z3
 Ew1FygLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mipvv-006JD0-HF; Fri, 05 Nov 2021 03:30:39 +0000
Date: Fri, 5 Nov 2021 03:30:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Subject: Re: futher decouple DAX from block devices
Message-ID: <YYSlU48wcKt4qixx@casper.infradead.org>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de> <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
 <20211104190443.GK24333@magnolia> <YYSgX9FI0kaGLeR0@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYSgX9FI0kaGLeR0@mit.edu>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, linux-erofs@lists.ozlabs.org,
 Mike Snitzer <snitzer@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 04, 2021 at 11:09:19PM -0400, Theodore Ts'o wrote:
> On Thu, Nov 04, 2021 at 12:04:43PM -0700, Darrick J. Wong wrote:
> > > Note that I've avoided implementing read/write fops for dax devices
> > > partly out of concern for not wanting to figure out shared-mmap vs
> > > write coherence issues, but also because of a bet with Dave Hansen
> > > that device-dax not grow features like what happened to hugetlbfs. So
> > > it would seem mkfs would need to switch to mmap I/O, or bite the
> > > bullet and implement read/write fops in the driver.
> > 
> > That ... would require a fair amount of userspace changes, though at
> > least e2fsprogs has pluggable io drivers, which would make mmapping a
> > character device not too awful.
> > 
> > xfsprogs would be another story -- porting the buffer cache mignt not be
> > too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
> > Note that xfsprogs explicitly screens out chardevs.
> 
> It's not just e2fsprogs and xfsprogs.  There's also udev, blkid,
> potententially systemd unit generators to kick off fsck runs, etc.
> There are probably any number of user scripts which assume that file
> systems are mounted on block devices --- for example, by looking at
> the output of lsblk, etc.
> 
> Also note that block devices have O_EXCL support to provide locking
> against attempts to run mkfs on a mounted file system.  If you move
> dax file systems to be mounted on a character mode device, that would
> have to be replicated as well, etc.  So I suspect that a large number
> of subtle things would break, and I'd strongly recommend against going
> down that path.

Agreed.  There were reasons we decided to present pmem as "block
device with extra functionality" rather than try to cram all the block
layer functionality (eg submitting BIOs for filesystem metadata) into a
character device.  Some of those assumptions might be worth re-examining,
but I haven't seen anything that makes me say "this is obviously better
than what we did at the time".
