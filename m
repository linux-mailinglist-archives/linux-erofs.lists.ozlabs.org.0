Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E807767EC
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 21:05:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gEyeaJZ4;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLfdp5mQyz3bcL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 05:05:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gEyeaJZ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLfdl5s2Sz2ywt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 05:05:31 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1E99E6446B;
	Wed,  9 Aug 2023 19:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CFC433C8;
	Wed,  9 Aug 2023 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691607929;
	bh=4GKDaia1VeW/OijfJXE9UHIufNesebWNQDy9LU2whYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gEyeaJZ4RUWChIryvRrKWbHk6CbM8eHu0rqtHvzvba6SSDpBpPtag+D6BMw4GFw2n
	 hFXK4OEbm0L9R1B4K8eNiaiBDtquinDOVTFyiDIMSP6pKYqwvVgkMBHyc14BMMGMP8
	 zAV3KdTeX3lKcSKjE5oKnAjO29eKsnCAgTvUvEsF/+3xUpWxGZvbyls48Ed9vXaSwV
	 DcuV4QvGf703nsP6BpmM4kVysUgEr6LDinf8/zizcxdQ20sie+EHfzuPrXj/APOCtH
	 91Mo4Dg4M0l0SApVPB8n1GBtVl5sn3TKwCbUSa9ZQiDyJiArJw0iRB7MWozIYejid0
	 q+2d4Xd9I1nbw==
Message-ID: <cbc98eb171d6ccacb24213af7d0ae91094d39780.camel@kernel.org>
Subject: Re: [PATCH v7 08/13] fs: drop the timespec64 argument from
 update_time
From: Jeff Layton <jlayton@kernel.org>
To: Mike Marshall <hubcap@omnibond.com>, Christian Brauner
 <brauner@kernel.org>
Date: Wed, 09 Aug 2023 15:05:21 -0400
In-Reply-To: <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-8-d1dec143a704@kernel.org>
	 <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
	 <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, clus
 ter-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-
 technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Yes. It's in Christian's vfs.ctime branch:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs.ct=
ime

On Wed, 2023-08-09 at 14:38 -0400, Mike Marshall wrote:
> I've been following this patch on fsdevel... is there a
> remote I could fetch with a branch that has this in it?
>=20
> -Mike
>=20
> On Wed, Aug 9, 2023 at 8:32=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >=20
> > On Mon, Aug 07, 2023 at 03:38:39PM -0400, Jeff Layton wrote:
> > > Now that all of the update_time operations are prepared for it, we ca=
n
> > > drop the timespec64 argument from the update_time operation. Do that =
and
> > > remove it from some associated functions like inode_update_time and
> > > inode_needs_update_time.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/bad_inode.c           |  3 +--
> > >  fs/btrfs/inode.c         |  3 +--
> > >  fs/btrfs/volumes.c       |  4 +---
> > >  fs/fat/fat.h             |  3 +--
> > >  fs/fat/misc.c            |  2 +-
> > >  fs/gfs2/inode.c          |  3 +--
> > >  fs/inode.c               | 30 +++++++++++++-----------------
> > >  fs/overlayfs/inode.c     |  2 +-
> > >  fs/overlayfs/overlayfs.h |  2 +-
> > >  fs/ubifs/file.c          |  3 +--
> > >  fs/ubifs/ubifs.h         |  2 +-
> > >  fs/xfs/xfs_iops.c        |  1 -
> > >  include/linux/fs.h       |  4 ++--
> >=20
> > This was missing the conversion of fs/orangefs orangefs_update_time()
> > causing the build to fail. So at some point kbuild will yell here.
> > Fwiw, I've fixed that up in-tree.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
