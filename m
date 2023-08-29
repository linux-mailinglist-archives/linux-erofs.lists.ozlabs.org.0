Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7078CFC2
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 00:59:49 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UJJSRKRH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rb2tq04s9z3by8
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 08:59:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UJJSRKRH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rb2st4jSmz2yTx
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 08:58:58 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C592563D06;
	Tue, 29 Aug 2023 22:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FABC433C7;
	Tue, 29 Aug 2023 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693349935;
	bh=rn2r8LG5beXDEpNUXXmAsWk7K7Z6B0SkbbGrSUfCikA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UJJSRKRH7LTjcnDdUPp7RtBE/dB7QJhjeEB1YQbMKrKaYzMACob4EBI4SsR0sy5Ye
	 mt7wmIqsOOWPvL2AjZ5YQtEhH9AU5fAVtL4UeL7OEXz9q6ZHDNk6+YIdzODX8+wqil
	 jlsqG5Nirzs8oHVVRgwIrBWk+tU4uj4vEMyBjQFrJmh/cCsnnPwHApt0qQlEh4VPoV
	 fx7tHB0NGyHo231wK83vtI9suH/0L3cn9cyGLY9db8p4Yc0AKTTsIBFPHCXTIrOvy6
	 YzP3/2IXTyd/Lvsgr1kAOQEzWJjTRoatnNjA657yXZ2FiJLFoy7sfB1K1HWwMGB4Ek
	 xBWdtuLvgMoog==
Message-ID: <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 29 Aug 2023 18:58:47 -0400
In-Reply-To: <20230829224454.GA461907@ZenIV>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
	 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
	 <20230829224454.GA461907@ZenIV>
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

On Tue, 2023-08-29 at 23:44 +0100, Al Viro wrote:
> On Tue, Jul 25, 2023 at 10:58:14AM -0400, Jeff Layton wrote:
> > generic_fillattr just fills in the entire stat struct indiscriminately
> > today, copying data from the inode. There is at least one attribute
> > (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> > and we're looking at adding more with the addition of multigrain
> > timestamps.
> >=20
> > Add a request_mask argument to generic_fillattr and have most callers
> > just pass in the value that is passed to getattr. Have other callers
> > (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> > STATX_CHANGE_COOKIE into generic_fillattr.
>=20
> Out of curiosity - how much PITA would it be to put request_mask into
> kstat?  Set it in vfs_getattr_nosec() (and those get_file_..._info()
> on smbd side) and don't bother with that kind of propagation boilerplate
> - just have generic_fillattr() pick it there...
>=20
> Reduces the patchset size quite a bit...

It could be done. To do that right, I think we'd want to drop
request_mask from the ->getattr prototype as well and just have
everything use the mask in the kstat.

I don't think it'd reduce the size of the patchset in any meaningful
way, but it might make for a more sensible API over the long haul.
--=20
Jeff Layton <jlayton@kernel.org>
