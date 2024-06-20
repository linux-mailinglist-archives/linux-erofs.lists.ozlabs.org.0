Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CB91146A
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2024 23:24:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FlQZkEWX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4tlx2DGBz3cY5
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 07:24:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FlQZkEWX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4tlr5zWFz3cWN
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 07:24:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF130620DD;
	Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C8C2BD10;
	Thu, 20 Jun 2024 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718918642;
	bh=J2GqEQCdBgJeMDsHOUD3ggS0L8MaxCNWl/BVWnLRCW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlQZkEWXuYjG3lBPD+CbeqHswxAsU7y4iss7QjmrwwSkTw2iU3E6o6btinmhwPHrD
	 lSF/mb5wOLfVwxtjYYm93dMIUn1hfwPO7/uvnuUvaMGfIVTVH8Kn/kMXsydRkfKkKk
	 +q9uKCYgckPzfqcC2uHLzy4ZEe1BFH/G9Q8G00qfYW4ZlnjgKp1D8f5mbTBTzHet3f
	 KJRe02ZO01MDudREL9gtQdj64PgKYAVNDPPdkW0hXvesX4jdchaliSxKMN5OssSrSq
	 Ecnj4xZ09k4NozRYTQARzo3zXOkrOETiUmVHdKRiMwF75ak/8AVeIkVdoL0kbhtqfE
	 xzqtOujZzBqdw==
Date: Thu, 20 Jun 2024 14:24:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4 01/22] fs: Add generic_atomic_write_valid_size()
Message-ID: <20240620212401.GA3058325@frogsfrogsfrogs>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
 <20240607143919.2622319-2-john.g.garry@oracle.com>
 <20240612211040.GJ2764752@frogsfrogsfrogs>
 <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a123946e-1df2-48da-b120-67b50c3aa9f5@oracle.com>
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

On Thu, Jun 13, 2024 at 08:35:53AM +0100, John Garry wrote:
> On 12/06/2024 22:10, Darrick J. Wong wrote:
> > On Fri, Jun 07, 2024 at 02:38:58PM +0000, John Garry wrote:
> > > Add a generic helper for FSes to validate that an atomic write is
> > > appropriately sized (along with the other checks).
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   include/linux/fs.h | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 069cbab62700..e13d34f8c24e 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -3645,4 +3645,16 @@ bool generic_atomic_write_valid(loff_t pos, struct iov_iter *iter)
> > >   	return true;
> > >   }
> > > +static inline
> > > +bool generic_atomic_write_valid_size(loff_t pos, struct iov_iter *iter,
> > > +				unsigned int unit_min, unsigned int unit_max)
> > > +{
> > > +	size_t len = iov_iter_count(iter);
> > > +
> > > +	if (len < unit_min || len > unit_max)
> > > +		return false;
> > > +
> > > +	return generic_atomic_write_valid(pos, iter);
> > > +}
> > 
> > Now that I look back at "fs: Initial atomic write support" I wonder why
> > not pass the iocb and the iov_iter instead of pos and the iov_iter?
> 
> The original user of generic_atomic_write_valid() [blkdev_dio_unaligned() or
> blkdev_dio_invalid() with the rename] used these same args, so I just went
> with that.

Don't let the parameter types of static blockdev helpers determine the
VFS API that filesystems need to implement untorn writes.

In the block layer enablement patch, this could easily be:

bool generic_atomic_write_valid(const struct kiocb *iocb,
				const struct iov_iter *iter)
{
	size_t len = iov_iter_count(iter);

	if (!iter_is_ubuf(iter))
		return false;

	if (!is_power_of_2(len))
		return false;

	if (!IS_ALIGNED(iocb->ki_pos, len))
		return false;

	return true;
}

Then this becomes:

bool generic_atomic_write_valid_size(const struct kiocb *iocb,
				     const struct iov_iter *iter,
				     unsigned int unit_min,
				     unsigned int unit_max)
{
	size_t len = iov_iter_count(iter);

	if (len < unit_min || len > unit_max)
		return false;

	return generic_atomic_write_valid(iocb, iter);
}

Yes, that means you have to rearrange the calling conventions of
blkdev_dio_invalid a little bit, but the first two arguments match
->read_iter and ->write_iter.  Filesystem writers can see that the first
two arguments are the first two parameters to foofs_write_iter() and
focus on the hard part, which is figuring out unit_{min,max}.

static ssize_t
xfs_file_dio_write(
	struct kiocb		*iocb,
	struct iov_iter		*from)
{
...
	if ((iocb->ki_flags & IOCB_ATOMIC) &&
	    !generic_atomic_write_valid_size(iocb, from,
			i_blocksize(inode),
			XFS_FSB_TO_B(mp, ip->i_extsize)))
		return -EINVAL;
	}


> > And can these be collapsed into a single generic_atomic_write_checks()
> > function?
> 
> bdev file operations would then need to use
> generic_atomic_write_valid_size(), and there is no unit_min and unit_max
> size there, apart from bdev awu min and max. And if I checked them, we would
> be duplicating checks (of awu min and max) in the block layer.

Fair enough, I concede this point.

--D

> 
> Cheers,
> John
> 
