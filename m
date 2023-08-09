Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB1776BE9
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 00:07:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jLUEcluJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLkh11FDWz2ypx
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 08:07:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jLUEcluJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLkgw2sn8z2yGg
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 08:07:40 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C164F6142A;
	Wed,  9 Aug 2023 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1FC433C8;
	Wed,  9 Aug 2023 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691618857;
	bh=Sbngo3UIZo2TJfFo7ktsW7U9FXdWGIk5Lt7H9K5XFM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jLUEcluJ8QWu44nwg8FvEto5mxdSD6jhT4hkYGZFSvOuTab/uQF0xUgz8zLDtJscq
	 f+HBUBgdFJj3+Y2ejcBWfM2DahqOuHFBxu+LY+Hv0Ofoq0ohoPPQ6mfudIqZwl+oWN
	 pLNza58hUz5pcfryyZpEKO+0VcHneBut5CYMVVo+IlIVXRYDByI99w4/3LNaQTR8ZH
	 5Tcm+fOwhAMw+LBYRd9XcCm1AD2BTsoO11JuCHNeGAZ3X/S7nnQe6dSMtz75w2+y5t
	 1AyLcsRC7pto0A+XhqMGGaQoyj7sZyZ0q03rK2TphlgLtVEfD926pjyggGNcgTjePk
	 OQw0IGY/USDEA==
Message-ID: <e4cee2590f5cb9a13a8d4445e550e155d551670d.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From: Jeff Layton <jlayton@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Frank Sorenson
	 <sorenson@redhat.com>
Date: Wed, 09 Aug 2023 18:07:29 -0400
In-Reply-To: <87a5v06kij.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
	 <87msz08vc7.fsf@mail.parknet.co.jp>
	 <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
	 <878rak8hia.fsf@mail.parknet.co.jp>
	 <20230809150041.452w7gucjmvjnvbg@quack3>
	 <87v8do6y8q.fsf@mail.parknet.co.jp>
	 <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org>
	 <87leek6rh1.fsf@mail.parknet.co.jp>
	 <ccffe6ca3397c8374352b002fe01d55b09d84ef4.camel@kernel.org>
	 <87h6p86p9z.fsf@mail.parknet.co.jp>
	 <edf8e8ca3b38e56f30e0d24ac7293f848ffee371.camel@kernel.org>
	 <87a5v06kij.fsf@mail.parknet.co.jp>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, 
 Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@sa
 mba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 2023-08-10 at 05:14 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > When you say it "doesn't work the same", what do you mean, specifically=
?
> > I had to make some allowances for the fact that FAT is substantially
> > different in its timestamp handling, and I tried to preserve existing
> > behavior as best I could.
>=20
> Ah, ok. I was misreading some.
>=20
> inode_update_timestamps() checks IS_I_VERSION() now, not S_VERSION.  So,
> if adding the check of IS_I_VERSION() and (S_MTIME|S_CTIME|S_VERSION) to
> FAT?
>=20
> With it, IS_I_VERSION() would be false on FAT, and I'm fine.
>=20
> I.e. something like
>=20
> 	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && IS_I_VERSION(inode)
> 	    && inode_maybe_inc_iversion(inode, false))
>   		dirty_flags |=3D I_DIRTY_SYNC;
>=20
> Thanks.

If you do that then the i_version counter would never be incremented.
But...I think I see what you're getting at.

Most filesystems that support the i_version counter have an on-disk
field for it. FAT obviously has no such thing. I suspect the i_version
bits in fat_update_time were added by mistake. FAT doesn't set
SB_I_VERSION so there's no need to do anything to the i_version field at
all.

Also, given that the mtime and ctime are always kept in sync on FAT,
we're probably fine to have it look something like this:

--------------------8<------------------
int fat_update_time(struct inode *inode, int flags)=20
{=20
        int dirty_flags =3D 0;

        if (inode->i_ino =3D=3D MSDOS_ROOT_INO)=20
                return 0;

        fat_truncate_time(inode, NULL, flags);
        if (inode->i_sb->s_flags & SB_LAZYTIME)
                dirty_flags |=3D I_DIRTY_TIME;
        else
                dirty_flags |=3D I_DIRTY_SYNC;

        __mark_inode_dirty(inode, dirty_flags);
        return 0;
}=20
--------------------8<------------------

...and we should probably do that in a separate patch in advance of the
update_time rework, since it's really a different change.

If you're in agreement, then I'll plan to respin the series with this
fixed and resend.

Thanks for being patient!
--=20
Jeff Layton <jlayton@kernel.org>
