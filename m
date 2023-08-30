Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D178D137
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 02:43:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IsIDlNRf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rb5Bs4Q54z30PY
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 10:43:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IsIDlNRf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rb5Bk2XYXz2yV5
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 10:43:42 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2110C61BB9;
	Wed, 30 Aug 2023 00:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A58C433CC;
	Wed, 30 Aug 2023 00:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693356218;
	bh=LyIf2T4m7Z+aGoOTC20QhjEHya5KDco7uKHcToK2QN0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IsIDlNRfFegBQz5apXf9Q9gjAuC8RqtGng+nYfYjX0S5SJxWLKbkP/MogQRo+SLWh
	 08nrxChiobBJGOdvi1cvZ9Cxb2Pii/+6mcjLXiRCfGelk5Fzb7nFOM5cN1DYFxC+lb
	 K0+wyy4lvPV7hwkO6kEPEPBXJN5ToQ7LqZEmRRmYaASuIjGr2KolOsqcxXfv9z9AFT
	 U+YvwKGFpKZQuYKrSPBrKqS32L3Y2d5AV2LqhVdm8HiFMosr5io8ASM2xgBUjx2M+9
	 p73bg3Y2GD+ffVCVZHTAzgHK5yijHsVB4GOG1GW7sSKXaED0tZT4jOsD9cxCZCytpG
	 axe3lD1uk8SPA==
Message-ID: <1005e30582138e203a99f49564e2ef244b8d56aa.camel@kernel.org>
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 29 Aug 2023 20:43:31 -0400
In-Reply-To: <20230830000221.GB3390869@ZenIV>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
	 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
	 <20230829224454.GA461907@ZenIV>
	 <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
	 <20230830000221.GB3390869@ZenIV>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org,
  linux-f2fs-devel@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Anthony Iliopoulos <ailiop@suse.com>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Joel Becker <jlbec@evilplan.org>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba
 -technical@lists.samba.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-08-30 at 01:02 +0100, Al Viro wrote:
> On Tue, Aug 29, 2023 at 06:58:47PM -0400, Jeff Layton wrote:
> > On Tue, 2023-08-29 at 23:44 +0100, Al Viro wrote:
> > > On Tue, Jul 25, 2023 at 10:58:14AM -0400, Jeff Layton wrote:
> > > > generic_fillattr just fills in the entire stat struct indiscriminat=
ely
> > > > today, copying data from the inode. There is at least one attribute
> > > > (STATX_CHANGE_COOKIE) that can have side effects when it is reporte=
d,
> > > > and we're looking at adding more with the addition of multigrain
> > > > timestamps.
> > > >=20
> > > > Add a request_mask argument to generic_fillattr and have most calle=
rs
> > > > just pass in the value that is passed to getattr. Have other caller=
s
> > > > (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting =
of
> > > > STATX_CHANGE_COOKIE into generic_fillattr.
> > >=20
> > > Out of curiosity - how much PITA would it be to put request_mask into
> > > kstat?  Set it in vfs_getattr_nosec() (and those get_file_..._info()
> > > on smbd side) and don't bother with that kind of propagation boilerpl=
ate
> > > - just have generic_fillattr() pick it there...
> > >=20
> > > Reduces the patchset size quite a bit...
> >=20
> > It could be done. To do that right, I think we'd want to drop
> > request_mask from the ->getattr prototype as well and just have
> > everything use the mask in the kstat.
> >=20
> > I don't think it'd reduce the size of the patchset in any meaningful
> > way, but it might make for a more sensible API over the long haul.
>=20
> ->getattr() prototype change would be decoupled from that - for your
> patchset you'd only need the field addition + setting in vfs_getattr_nose=
c()
> (and possibly in ksmbd), with the remainders of both series being
> independent from each other.
>=20
> What I suggest is
>=20
> branchpoint -> field addition (trivial commit) -> argument removal
> 		|
> 		V
> your series, starting with "use stat->request_mask in generic_fillattr()"
>=20
> Total size would be about the same, but it would be easier to follow
> the less trivial part of that.  Nothing in your branch downstream of
> that touches any ->getattr() instances, so it should have no
> conflicts with the argument removal side of things.

The only problem with this plan is that Linus has already merged this.
I've no issue with adding the request_mask to the kstat and removing it
as a separate parameter elsewhere, but I think we'll need to do it on
top of what's already been merged.
--=20
Jeff Layton <jlayton@kernel.org>
