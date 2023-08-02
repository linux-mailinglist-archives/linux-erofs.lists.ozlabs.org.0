Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FCE76D6B9
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 20:22:04 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lq45skxq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGL0p50G5z3bNq
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Aug 2023 04:22:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lq45skxq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGL0l1G4nz2xpv
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Aug 2023 04:21:59 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1C9E261A88;
	Wed,  2 Aug 2023 18:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C95C433C8;
	Wed,  2 Aug 2023 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691000516;
	bh=ycwx/5PKSOfdsJleD1GrXVU/2tvqnKBKqdlrqiXz2a4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Lq45skxqh7cpBQLhcIe1Gw+lovpqkvSzuzb8uAcyF5FrElk/i/Ef62Ff+U85B0JYe
	 gb5CgOGTY1TKw/GZkOMcRDcxztlWQJmGUpbe2PB0ZZtJhOtSfNtibfRZFTg6XykiV4
	 x4PKksy3wl2+3UvlwVruRvycuEHFr6v641nEPFf7oKydUHdevtCfIP62s3qFywogxs
	 bUSv3T3yZ3RUK3kjfZ3Erjub/WKAY+sdkcU6WTTdHAgJrOMM/i9gdSpZrws8Unwtrq
	 tNeLRJIXs/0bUybd4cEYmTQYz1K0b/J8KC16T4R6xltE9tlCNFzbPuAaxgMh/CIZB5
	 7bXA8nQ4jZd1w==
Message-ID: <16f46a9e6d88582d53d31a320589a7ba9d232e0c.camel@kernel.org>
Subject: Re: [PATCH v6 5/7] xfs: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Wed, 02 Aug 2023 14:21:49 -0400
In-Reply-To: <20230802174853.GC11352@frogsfrogsfrogs>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
	 <20230725-mgctime-v6-5-a794c2b7abca@kernel.org>
	 <20230802174853.GC11352@frogsfrogsfrogs>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.net
 , Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Anthony Iliopoulos <ailiop@suse.com>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, lin
 ux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-08-02 at 10:48 -0700, Darrick J. Wong wrote:
> On Tue, Jul 25, 2023 at 10:58:18AM -0400, Jeff Layton wrote:
> > Enable multigrain timestamps, which should ensure that there is an
> > apparent change to the timestamp whenever it has been written after
> > being actively observed via getattr.
> >=20
> > Also, anytime the mtime changes, the ctime must also change, and those
> > are now the only two options for xfs_trans_ichgtime. Have that function
> > unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> > always set.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_trans_inode.c | 6 +++---
> >  fs/xfs/xfs_iops.c               | 4 ++--
> >  fs/xfs/xfs_super.c              | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_=
inode.c
> > index 6b2296ff248a..ad22656376d3 100644
> > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
> >  	ASSERT(tp);
> >  	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> > =20
> > -	tv =3D current_time(inode);
> > +	/* If the mtime changes, then ctime must also change */
> > +	ASSERT(flags & XFS_ICHGTIME_CHG);
> > =20
> > +	tv =3D inode_set_ctime_current(inode);
> >  	if (flags & XFS_ICHGTIME_MOD)
> >  		inode->i_mtime =3D tv;
> > -	if (flags & XFS_ICHGTIME_CHG)
> > -		inode_set_ctime_to_ts(inode, tv);
> >  	if (flags & XFS_ICHGTIME_CREATE)
> >  		ip->i_crtime =3D tv;
> >  }
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 3a9363953ef2..3f89ef5a2820 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -573,10 +573,10 @@ xfs_vn_getattr(
> >  	stat->gid =3D vfsgid_into_kgid(vfsgid);
> >  	stat->ino =3D ip->i_ino;
> >  	stat->atime =3D inode->i_atime;
> > -	stat->mtime =3D inode->i_mtime;
> > -	stat->ctime =3D inode_get_ctime(inode);
> >  	stat->blocks =3D XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks=
);
> > =20
> > +	fill_mg_cmtime(request_mask, inode, stat);
>=20
> Huh.  I would've thought @stat would come first since that's what we're
> acting upon, but ... eh. :)
>=20
> If everyone else is ok with the fill_mg_cmtime signature,
> Acked-by: Darrick J. Wong <djwong@kernel.org>
>=20
>=20

Good point. We can change the signature. I think xfs is the only caller
outside of the generic vfs right now, and it'd be best to do it now.

Christian, would you prefer that I send an updated series, or patches on
top of vfs.ctime that can be folded in?
=20
--=20
Jeff Layton <jlayton@kernel.org>
