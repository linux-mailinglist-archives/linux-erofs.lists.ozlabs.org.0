Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCBF7756E6
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 12:11:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SLiD6EwB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLQnF2Dg3z30Db
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 20:11:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SLiD6EwB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLQn71tVpz2xZp
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Aug 2023 20:11:07 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0F082630EB;
	Wed,  9 Aug 2023 10:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD92C433C7;
	Wed,  9 Aug 2023 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691575861;
	bh=3EDdk7dTfHs3Hy9RVE0ybDbynTaUkeq4N9itCD5SIYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SLiD6EwBwAaKjaENOfNjWpIjgTZ7uN7B4ABF6+Bc5uUdhACL29f5ZDgIl8J0BIcLg
	 dmmWF/N3vxvPZnbf7qCfoiMntKQ5KpepxLV423OWizDLKnMdMdTqG2pBQ96c7iVI/q
	 6jxcOzT1tUDuUKredqtZ802zOA9COiRKKjMvkV8B5wrgxL3TdF/tBsrcopqwbxnBca
	 PDqh4/C6S52dVHwYp/5zmkTrm4IUk3O7TYiV8whC/vrlI1m9OAGJxPareUgxFZUC+2
	 I7slyRMFE6wXePxHgLcOI25zOvoPWown/lV3vive98S0wwvTwTzicYt9+73JrhgKdm
	 fHO15Q9CkD8KA==
Message-ID: <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From: Jeff Layton <jlayton@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 09 Aug 2023 06:10:53 -0400
In-Reply-To: <87msz08vc7.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
	 <87msz08vc7.fsf@mail.parknet.co.jp>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, 
 Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@sa
 mba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-08-09 at 17:37 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > Also, it may be that things have changed by the time we get to calling
> > fat_update_time after checking inode_needs_update_time. Ensure that we
> > attempt the i_version bump if any of the S_* flags besides S_ATIME are
> > set.
>=20
> I'm not sure what it meaning though, this is from
> generic_update_time(). Are you going to change generic_update_time()
> too? If so, it doesn't break lazytime feature?
>=20

Yes. generic_update_time is also being changed in a similar fashion.
This shouldn't break the lazytime feature: lazytime is all about how and
when timestamps get written to disk. This work is all about which
clocksource the timestamps originally come from.

> Thanks.
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/fat/misc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index 67006ea08db6..8cab87145d63 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -347,14 +347,14 @@ int fat_update_time(struct inode *inode, struct t=
imespec64 *now, int flags)
> >  		return 0;
> > =20
> >  	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> > -		fat_truncate_time(inode, now, flags);
> > +		fat_truncate_time(inode, NULL, flags);
> >  		if (inode->i_sb->s_flags & SB_LAZYTIME)
> >  			dirty_flags |=3D I_DIRTY_TIME;
> >  		else
> >  			dirty_flags |=3D I_DIRTY_SYNC;
> >  	}
> > =20
> > -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion=
(inode, false))
> >  		dirty_flags |=3D I_DIRTY_SYNC;
> > =20
> >  	__mark_inode_dirty(inode, dirty_flags);
>=20

--=20
Jeff Layton <jlayton@kernel.org>
