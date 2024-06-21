Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F153912F54
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 23:19:14 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2j0J7XY;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5Vbb3BSYz3cdM
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jun 2024 07:19:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=C2j0J7XY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5VbT38DSz2ydQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jun 2024 07:19:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B6804CE2D14;
	Fri, 21 Jun 2024 21:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A1AC2BBFC;
	Fri, 21 Jun 2024 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004736;
	bh=sdtBjsr+XiHzFFwJkoRXFeC0FXv2NWldnm0I6mueIIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2j0J7XYnglGPEiEziaR5oJH2YSHKc+/x1SlIkP213F7Ne1JnvVZgZz9tuky+Aasy
	 6MZy17hsxxBt4Ba+DYJAqIhtz2nV+WGetvSA99yPiipqs9cjZNMOxbYaCNY3YcsAG0
	 HiAHxsFtoKEI2Y+6IAExVu2LiF4RYYYqYVlTUskJEAe4ESUa+1W9M2nNkrGtq8huU5
	 KngZUgVIh3zUgw0al2QnLAYMhYAn5jMED5Q0x25hq0a8LUy6zpZhsowQHWaCrSTxOb
	 cM3OxhmkgUB0Xa8k/tYmqM7nB8FdZQtkPANImh5zh6pzmGKxfm6QB5LJGB/XggKl0D
	 ynjuqanOQhjkg==
Date: Fri, 21 Jun 2024 14:18:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 02/22] iomap: Allow filesystems set IO block zeroing
 size
Message-ID: <20240621211855.GY3058325@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-3-john.g.garry@oracle.com>
 <20240612213235.GK2764752@frogsfrogsfrogs>
 <59255aa1-a769-437b-8fbb-71f53fd7920f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59255aa1-a769-437b-8fbb-71f53fd7920f@oracle.com>
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
Cc: ritesh.list@gmail.com, gfs2@lists.linux.dev, mikulas@artax.karlin.mff.cuni.cz, hch@lst.de, agruenba@redhat.com, miklos@szeredi.hu, linux-ext4@vger.kernel.org, catherine.hoang@oracle.com, linux-block@vger.kernel.org, viro@zeniv.linux.org.uk, dchinner@redhat.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, mcgrof@kernel.org, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, chandan.babu@oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 13, 2024 at 11:31:35AM +0100, John Garry wrote:
> On 12/06/2024 22:32, Darrick J. Wong wrote:
> > > unsigned int fs_block_size = i_blocksize(inode), pad;
> > > +	u64 io_block_size = iomap->io_block_size;
> > I wonder, should iomap be nice and not require filesystems to set
> > io_block_size themselves unless they really need it?
> 
> That's what I had in v3, like:
> 
> if (iomap->io_block_size)
> 	io_block_size = iomap->io_block_size;
> else
> 	io_block_size = i_block_size(inode)
> 
> but it was suggested to change that (to like what I have here).

oh, ok.  Ignore that comment, then. :)

> > Anyone working on
> > an iomap port while this patchset is in progress may or may not remember
> > to add this bit if they get their port merged after atomicwrites is
> > merged; and you might not remember to prevent the bitrot if the reverse
> > order happens.
> 
> Sure, I get your point.
> 
> However, OTOH, if we check xfs_bmbt_to_iomap(), it does set all or close to
> all members of struct iomap, so we are just continuing that trend, i.e. it
> is the job of the FS callback to set all these members.
> 
> > 
> > 	u64 io_block_size = iomap->io_block_size ?: i_blocksize(inode);
> > 
> > >   	loff_t length = iomap_length(iter);
> > >   	loff_t pos = iter->pos;
> > >   	blk_opf_t bio_opf;
> > > @@ -287,6 +287,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   	int nr_pages, ret = 0;
> > >   	size_t copied = 0;
> > >   	size_t orig_count;
> > > +	unsigned int pad;
> > >   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > >   	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > > @@ -355,7 +356,14 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   	if (need_zeroout) {
> > >   		/* zero out from the start of the block to the write offset */
> > > -		pad = pos & (fs_block_size - 1);
> > > +		if (is_power_of_2(io_block_size)) {
> > > +			pad = pos & (io_block_size - 1);
> > > +		} else {
> > > +			loff_t _pos = pos;
> > > +
> > > +			pad = do_div(_pos, io_block_size);
> > > +		}
> > Please don't opencode this twice.
> > 
> > static unsigned int offset_in_block(loff_t pos, u64 blocksize)
> > {
> > 	if (likely(is_power_of_2(blocksize)))
> > 		return pos & (blocksize - 1);
> > 	return do_div(pos, blocksize);
> > }
> 
> ok, fine
> 
> > 
> > 		pad = offset_in_block(pos, io_block_size);
> > 		if (pad)
> > 			...
> > 
> > Also, what happens if pos-pad points to a byte before the mapping?
> 
> It's the job of the FS to map in something aligned to io_block_size. Having
> said that, I don't think we are doing that for XFS (which sets io_block_size
> > i_block_size(inode)), so I need to check that.

<nod>  You can only play with the mapping that the fs gave you.
If xfs doesn't give you a big enough mapping, then that's a programming
bug to WARN_ON_ONCE about and return EIO.

I hadn't realized that the ->iomap_begin function is required to
provide mappings that are aligned to io_block_size.

> 
> > 
> > > +
> > >   		if (pad)
> > >   			iomap_dio_zero(iter, dio, pos - pad, pad);
> > >   	}
> > > @@ -429,9 +437,16 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >   	if (need_zeroout ||
> > >   	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
> > >   		/* zero out from the end of the write to the end of the block */
> > > -		pad = pos & (fs_block_size - 1);
> > > +		if (is_power_of_2(io_block_size)) {
> > > +			pad = pos & (io_block_size - 1);
> > > +		} else {
> > > +			loff_t _pos = pos;
> > > +
> > > +			pad = do_div(_pos, io_block_size);
> > > +		}
> > > +
> > >   		if (pad)
> > > -			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
> > > +			iomap_dio_zero(iter, dio, pos, io_block_size - pad);
> > What if pos + io_block_size - pad points to a byte after the end of the
> > mapping?
> 
> as above, we expect this to be mapped in (so ok to zero)
> 
> > 
> > >   	}
> > >   out:
> > >   	/* Undo iter limitation to current extent */
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index 378342673925..ecb4cae88248 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -127,6 +127,7 @@ xfs_bmbt_to_iomap(
> > >   	}
> > >   	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
> > >   	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
> > > +	iomap->io_block_size = i_blocksize(VFS_I(ip));
> > >   	if (mapping_flags & IOMAP_DAX)
> > >   		iomap->dax_dev = target->bt_daxdev;
> > >   	else
> > > diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> > > index 3b103715acc9..bf2cc4bee309 100644
> > > --- a/fs/zonefs/file.c
> > > +++ b/fs/zonefs/file.c
> > > @@ -50,6 +50,7 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
> > >   		iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
> > >   		iomap->length = isize - iomap->offset;
> > >   	}
> > > +	iomap->io_block_size = i_blocksize(inode);
> > >   	mutex_unlock(&zi->i_truncate_mutex);
> > >   	trace_zonefs_iomap_begin(inode, iomap);
> > > @@ -99,6 +100,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
> > >   		iomap->type = IOMAP_MAPPED;
> > >   		iomap->length = isize - iomap->offset;
> > >   	}
> > > +	iomap->io_block_size = i_blocksize(inode);
> > >   	mutex_unlock(&zi->i_truncate_mutex);
> > >   	trace_zonefs_iomap_begin(inode, iomap);
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 6fc1c858013d..d63a35b77907 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -103,6 +103,8 @@ struct iomap {
> > >   	void			*private; /* filesystem private */
> > >   	const struct iomap_folio_ops *folio_ops;
> > >   	u64			validity_cookie; /* used with .iomap_valid() */
> > > +	/* io block zeroing size, not necessarily a power-of-2  */
> > size in bytes?
> > 
> > I'm not sure what "io block zeroing" means.
> 
> Naming is hard. Essentally we are trying to reuse the sub-fs block zeroing
> code for sub-extent granule writes. More below.

Yeah.  For sub-fsblock zeroing we issue (chained) bios to write zeroes
to the sectors surrounding the part we're actually writing, then we're
issuing the write itself, and finally the ioend converts the mapping to
unwritten.

For untorn writes we're doing the same thing, but now on the level of
multiple fsblocks.  I guess this is all going to support a 


<nod> "IO granularity" ?  For untorn writes I guess you want mappings
that are aligned to a supported untorn write granularity; for bs > ps
filesystems I guess the IO granularity is 

> > What are you trying to
> > accomplish here?  Let's say the fsblock size is 4k and the allocation
> > unit (aka the atomic write size) is 16k.
> 
> ok, so I say here that the extent granule is 16k
> 
> > Userspace wants a direct write
> > to file offset 8192-12287, and that space is unwritten:
> > 
> > uuuu
> >    ^
> > 
> > Currently we'd just write the 4k and run the io completion handler, so
> > the final state is:
> > 
> > uuWu
> > 
> > Instead, if the fs sets io_block_size to 16384, does this direct write
> > now amplify into a full 16k write?
> 
> Yes, but only when the extent is newly allocated and we require zeroing.
> 
> > With the end result being:
> > ZZWZ
> 
> Yes
> 
> > 
> > only.... I don't see the unwritten areas being converted to written?
> 
> See xfs_iomap_write_unwritten() change in the next patch
> 
> > I guess for an atomic write you'd require the user to write 0-16383?
> 
> Not exactly
> 
> > 
> > <still confused about why we need to do this, maybe i'll figure it out
> > as I go along>
> 
> This zeroing is just really required for atomic writes. The purpose is to
> zero the extent granule for any write within a newly allocated granule.
> 
> Consider we have uuWu, above. If the user then attempts to write the full
> 16K as an atomic write, the iomap iter code would generate writes for sizes
> 8k, 4k, and 4k, i.e. not a single 16K write. This is not acceptable. So the
> idea is to zero the full extent granule when allocated, so we have ZZWZ
> after the 4k write at offset 8192, above. As such, if we then attempt this
> 16K atomic write, we get a single 16K BIO, i.e. there is no unwritten extent
> conversion.

Wait, are we issuing zeroing writes for 0-8191 and 12288-16383, then
issuing a single atomic write for 0-16383?  That won't work, because all
the bios attached to an iomap_dio are submitted and execute
asynchronously.  I think you need ->iomap_begin to do XFS_BMAPI_ZERO
allocations if the writes aren't aligned to the minimum untorn write
granularity.

> I am not sure if we should be doing this only for atomic writes inodes, or
> also forcealign only or RT.

I think it only applies to untorn writes because the default behavior
everywhere is is that writes can tear.

--D

> Thanks,
> John
> 
> 
> 
