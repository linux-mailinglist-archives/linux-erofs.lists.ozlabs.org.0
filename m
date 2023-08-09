Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A1776519
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 18:31:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UPQGy8NQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLbCZ2PW6z30PQ
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 02:31:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UPQGy8NQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLbCW1LXcz2yhL
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 02:31:03 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2611963262;
	Wed,  9 Aug 2023 16:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FEDC433C8;
	Wed,  9 Aug 2023 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691598660;
	bh=Z7n9zJLdl712XVn1Py2iFtPG8LzL7lbCWNuqyD+/A3g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UPQGy8NQtXAAQ4aU3XYZHYnotv5CJersRvEj3UxLTDTNa1yXwNRn0IJiEHo/bl0VP
	 UZsTGWxiaK4MtB7dfslKXsWsCHmiZVr63spdJLnJq8JDgcyekVH5Xc7NL7sGLhreu6
	 x15cmd+UhtlNWpehU4jYdveXB5k/7G4WPmTr0CQ6bDhyChBFc9/xsm+0Rn2qIx7rJs
	 G7MVuLgnF5bvQR49Ipq6cF6+TvuMnXYBCNHAg7UV972mLj2aJnJNB5RVRDI4hEyHex
	 /4cPUAWVkqpnS01ZlGmCOld61C8SWimdxp5ttui+xDqTyf2eAGc7ZrzDWG2FklGBAx
	 JNZznme+soZDw==
Message-ID: <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From: Jeff Layton <jlayton@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Kara <jack@suse.cz>
Date: Wed, 09 Aug 2023 12:30:52 -0400
In-Reply-To: <87v8do6y8q.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
	 <87msz08vc7.fsf@mail.parknet.co.jp>
	 <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
	 <878rak8hia.fsf@mail.parknet.co.jp>
	 <20230809150041.452w7gucjmvjnvbg@quack3>
	 <87v8do6y8q.fsf@mail.parknet.co.jp>
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

On Thu, 2023-08-10 at 00:17 +0900, OGAWA Hirofumi wrote:
> Jan Kara <jack@suse.cz> writes:
>=20
> > Since you are talking past one another with Jeff let me chime in here :=
). I
> > think you are worried about this hunk:
>=20
> Right.
>
> > -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion=
(inode, false))
> >  		dirty_flags |=3D I_DIRTY_SYNC;
> >=20
> > which makes the 'flags' test pass even if we just modified ctime or mti=
me.
> > But do note the second part of the if - inode_maybe_inc_iversion() - so=
 we
> > are going to mark the inode dirty with I_DIRTY_SYNC only if someone que=
ried
> > iversion since the last time we have incremented it.
> >=20
> > So this hunk is not really changing how inode is marked dirty, it only
> > changes how often we check whether iversion needs increment and that sh=
ould
> > be fine (and desirable). Hence lazytime isn't really broken by this in =
any
> > way.
>=20
> OK. However, then it doesn't explain what I asked. This is not same with
> generic_update_time(), only FAT does.
>
> If thinks it is right thing, why generic_update_time() doesn't? I said
> first reply, this was from generic_update_time(). (Or I'm misreading
> updated generic_update_time()?)
>=20

My mistake re: lazytime vs. relatime, but Jan is correct that this
shouldn't break anything there.

The logic in the revised generic_update_time is different because FAT is
is a bit strange. fat_update_time does extra truncation on the timestamp
that it is handed beyond what timestamp_truncate() does.
fat_truncate_time is called in many different places too, so I don't
feel comfortable making big changes to how that works.

In the case of generic_update_time, it calls inode_update_timestamps
which returns a mask that shows which timestamps got updated. It then
marks the dirty_flags appropriately for what was actually changed.

generic_update_time is used across many filesystems so we need to ensure
that it's OK to use even when multigrain timestamps are enabled. Those
haven't been enabled in FAT though, so I didn't bother, and left it to
dirtying the inode in the same way it was before, even though it now
fetches its own timestamps from the clock. Given the way that the mtime
and ctime are smooshed together in FAT, that seemed reasonable.

Is there a particular case or flag combination you're concerned about
here?
--=20
Jeff Layton <jlayton@kernel.org>
