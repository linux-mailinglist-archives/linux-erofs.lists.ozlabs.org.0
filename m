Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 273287888E9
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 15:48:20 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uohLnKnq;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=avw/hNX+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RXLrK6gk6z2yhM
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Aug 2023 23:48:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uohLnKnq;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=avw/hNX+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1c; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RXLr92Kmbz2yV5
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Aug 2023 23:48:08 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49AEC21F79;
	Fri, 25 Aug 2023 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692971277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpzfsfMiRxmg30OdFnKzv1mOgTevyt5wkPNcyneGwG0=;
	b=uohLnKnqtpENx2vCia+CF25VunAvqKNxW8Gl/JZPjm2522sG0QzHP89CKm9gvg5uhIQmJN
	WBEcUX07tygEsfRFeW0MDCmmX2lneinhEWFdq+jYTgqP+tDCYKowqEsMW88igvW28lrojs
	hfcd/30g2Ie/qrM4mt7e3dhBm3c9V28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692971277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpzfsfMiRxmg30OdFnKzv1mOgTevyt5wkPNcyneGwG0=;
	b=avw/hNX+TPhBa6q/Pyjq6dsHiVTX81moNODEW9+kRWtkr4cKF/cxPXXUPquXV79uoK0IL4
	nSbq/d/haJGtPRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28033138F9;
	Fri, 25 Aug 2023 13:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UJRbCQ2x6GQZAwAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 13:47:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A432FA0774; Fri, 25 Aug 2023 15:47:56 +0200 (CEST)
Date: Fri, 25 Aug 2023 15:47:56 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/29] block: Make blkdev_get_by_*() return handle
Message-ID: <20230825134756.o3wpq6bogndukn53@quack3>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230825015843.GB95084@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825015843.GB95084@ZenIV>
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

On Fri 25-08-23 02:58:43, Al Viro wrote:
> On Fri, Aug 11, 2023 at 01:04:31PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > this is a v2 of the patch series which implements the idea of blkdev_get_by_*()
> > calls returning bdev_handle which is then passed to blkdev_put() [1]. This
> > makes the get and put calls for bdevs more obviously matching and allows us to
> > propagate context from get to put without having to modify all the users
> > (again!).  In particular I need to propagate used open flags to blkdev_put() to
> > be able count writeable opens and add support for blocking writes to mounted
> > block devices. I'll send that series separately.
> > 
> > The series is based on Christian's vfs tree as of yesterday as there is quite
> > some overlap. Patches have passed some reasonable testing - I've tested block
> > changes, md, dm, bcache, xfs, btrfs, ext4, swap. This obviously doesn't cover
> > everything so I'd like to ask respective maintainers to review / test their
> > changes. Thanks! I've pushed out the full branch to:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git bdev_handle
> > 
> > to ease review / testing.
> 
> Hmm...  Completely Insane Idea(tm): how about turning that thing inside out and
> having your bdev_open_by... return an actual opened struct file?
> 
> After all, we do that for sockets and pipes just fine and that's a whole lot
> hotter area.
> 
> Suppose we leave blkdev_open()/blkdev_release() as-is.  No need to mess with
> what we have for normal opened files for block devices.  And have block_open_by_dev()
> that would find bdev, etc., same yours does and shove it into anon file.
> 
> Paired with plain fput() - no need to bother with new primitives for closing.
> With a helper returning I_BDEV(bdev_file_inode(file)) to get from those to bdev.
> 
> NOTE: I'm not suggesting replacing ->s_bdev with struct file * if we do that -
> we want that value cached, obviously.  Just store both...
> 
> Not saying it's a good idea, but... might be interesting to look into.
> Comments?

I can see the appeal of not having to introduce the new bdev_handle type
and just using struct file which unifies in-kernel and userspace block
device opens. But I can see downsides too - the last fput() happening from
task work makes me a bit nervous whether it will not break something
somewhere with exclusive bdev opens. Getting from struct file to bdev is
somewhat harder but I guess a helper like F_BDEV() would solve that just
fine.

So besides my last fput() worry about I think this could work and would be
probably a bit nicer than what I have. But before going and redoing the whole
series let me gather some more feedback so that we don't go back and forth.
Christoph, Christian, Jens, any opinion?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
