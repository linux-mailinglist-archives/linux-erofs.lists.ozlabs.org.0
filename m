Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34E78B30F
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Aug 2023 16:28:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rbTi8dih;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZCZk5t1sz30gF
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 00:27:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rbTi8dih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b83d16e5cd0c301f07e4+7309+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZCZf6X6Hz2yDD
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 00:27:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uSnxqZdcrAYLPJPn0DfMY9X2iPdkTMayza8iox8Bem8=; b=rbTi8dih1WwPPGr+ioF2zSIKKN
	0mmMd7Mf6Y5CF6A3xbL6k1rG0Eq5PWNYD84YkTP/PYD6I8n7fwj9JtPf3x5xfflk7Of9PmT6yVoWg
	jDUfTlhnUqF1ibZ6C9C5Qp1FAcJBPSA1UYGVoKPgYhWBRS4hFyN/qulLfky0u5g5JfBjJuWo9rAVd
	OmVBPYeBaMmY44rW3+ehZ8vQr36snspggxlo5N+wQ2MnsZOlSw7LhANyJrm+6WDGYJ2q3IlcmhpsD
	alE6KXAxYfEVAogHtFQTNBnQoXb84wJ9x/IDWMwjf/34MizydIM1onWP9QQVyidEc4XNREZoED++f
	uj07NLVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qadDM-009iIb-0l;
	Mon, 28 Aug 2023 14:27:36 +0000
Date: Mon, 28 Aug 2023 07:27:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <ZOyu2FX7Fmzj6JJz@infradead.org>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230825015843.GB95084@ZenIV>
 <20230825134756.o3wpq6bogndukn53@quack3>
 <20230826022852.GO3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826022852.GO3390869@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, Jaegeuk K
 im <jaegeuk@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Aug 26, 2023 at 03:28:52AM +0100, Al Viro wrote:
> I mean, look at claim_swapfile() for example:
>                 p->bdev = blkdev_get_by_dev(inode->i_rdev,
>                                    FMODE_READ | FMODE_WRITE | FMODE_EXCL, p);
>                 if (IS_ERR(p->bdev)) {
>                         error = PTR_ERR(p->bdev);
>                         p->bdev = NULL;
>                         return error;
>                 }
>                 p->old_block_size = block_size(p->bdev);
>                 error = set_blocksize(p->bdev, PAGE_SIZE);
>                 if (error < 0)
>                         return error;
> we already have the file opened, and we keep it opened all the way until
> the swapoff(2); here we have noticed that it's a block device and we
> 	* open the fucker again (by device number), this time claiming
> it with our swap_info_struct as holder, to be closed at swapoff(2) time
> (just before we close the file)

Note that some drivers look at FMODE_EXCL/BLK_OPEN_EXCL in ->open.
These are probably bogus and maybe we want to kill them, but that will
need an audit first.

> BTW, what happens if two threads call ioctl(fd, BLKBSZSET, &n)
> for the same descriptor that happens to have been opened O_EXCL?
> Without O_EXCL they would've been unable to claim the sucker at the same
> time - the holder we are using is the address of a function argument,
> i.e. something that points to kernel stack of the caller.  Those would
> conflict and we either get set_blocksize() calls fully serialized, or
> one of the callers would eat -EBUSY.  Not so in "opened with O_EXCL"
> case - they can very well overlap and IIRC set_blocksize() does *not*
> expect that kind of crap...  It's all under CAP_SYS_ADMIN, so it's not
> as if it was a meaningful security hole anyway, but it does look fishy.

The user get to keep the pieces..  BLKBSZSET is kinda bogus anyway
as the soft blocksize only matters for buffer_head-like I/O, and
there only for file systems.  Not idea why anyone would set it manually.
