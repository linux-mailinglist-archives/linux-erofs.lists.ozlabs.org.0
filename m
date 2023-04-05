Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 624526D81A3
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 17:22:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps7f12523z3fRv
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 01:22:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eaui7DNs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eaui7DNs;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps7MZ53g9z3fXH
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 01:09:30 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D0FA2626EA;
	Wed,  5 Apr 2023 15:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353F3C433EF;
	Wed,  5 Apr 2023 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680707368;
	bh=+aefmgXHXWQivw0zE6f7l8O069i+hkWlRKpgwCfgkhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eaui7DNs5zR82qFwoJqlHJGtdjxtNEKuV49OBzaU1JlhtGdDYmTgoB7Cg2oP8kuF6
	 llkjHDUdha3QByAfdxqMYc98qQ+8ePQOOGLfMYXv7iryNRKikleW4/Rv2KpJZ+dG+R
	 hqqk2yOgcJkfZwcFmwaxyL/C4cW8DC4atYXvjSG94RQwISX4hL8V8dC7qMnS2GbmwG
	 xxCnzKlA3g+4SzfCaBYH98ENyrqmXYnLMN9ZwmfOIOHAYdZ2+3ckQ45BzFODINTzEK
	 guTSkMAP9TBQ1TjgYouk94BaRFrPHtC5b2sMJBCMYjozrgR384v+W/44ayI8qoH62X
	 9Z0ZXiDNSLnow==
Date: Wed, 5 Apr 2023 08:09:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230405150927.GD303486@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 05:01:42PM +0200, Andrey Albershteyn wrote:
> On Tue, Apr 04, 2023 at 09:10:47AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> > > The direct path is not supported on verity files. Attempts to use direct
> > > I/O path on such files should fall back to buffered I/O path.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 947b5c436172..9e072e82f6c1 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -244,7 +244,8 @@ xfs_file_dax_read(
> > >  	struct kiocb		*iocb,
> > >  	struct iov_iter		*to)
> > >  {
> > > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > >  	ssize_t			ret = 0;
> > >  
> > >  	trace_xfs_file_dax_read(iocb, to);
> > > @@ -297,10 +298,17 @@ xfs_file_read_iter(
> > >  
> > >  	if (IS_DAX(inode))
> > >  		ret = xfs_file_dax_read(iocb, to);
> > > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> > >  		ret = xfs_file_dio_read(iocb, to);
> > > -	else
> > > +	else {
> > > +		/*
> > > +		 * In case fs-verity is enabled, we also fallback to the
> > > +		 * buffered read from the direct read path. Therefore,
> > > +		 * IOCB_DIRECT is set and need to be cleared
> > > +		 */
> > > +		iocb->ki_flags &= ~IOCB_DIRECT;
> > >  		ret = xfs_file_buffered_read(iocb, to);
> > 
> > XFS doesn't usually allow directio fallback to the pagecache. Why
> > would fsverity be any different?
> 
> Didn't know that, this is what happens on ext4 so I did the same.
> Then it probably make sense to just error on DIRECT on verity
> sealed file.

Thinking about this a little more -- I suppose we shouldn't just go
breaking directio reads from a verity file if we can help it.  Is there
a way to ask fsverity to perform its validation against some arbitrary
memory buffer that happens to be fs-block aligned?  In which case we
could support fsblock-aligned directio reads without falling back to the
page cache?

--D

> > 
> > --D
> > 
> > > +	}
> > >  
> > >  	if (ret > 0)
> > >  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> > > -- 
> > > 2.38.4
> > > 
> > 
> 
> -- 
> - Andrey
> 
