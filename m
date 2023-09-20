Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B87A8857
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 17:30:01 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k1nl+EUm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrMsg3jtkz3cF2
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 01:29:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k1nl+EUm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrMsY72Pbz3byH
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 01:29:53 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id CB0C3CE168E;
	Wed, 20 Sep 2023 15:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E996C433C7;
	Wed, 20 Sep 2023 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695223789;
	bh=shQOY5YSFRPH4MYjqUKwyU+DkSv5sjGrh2VkaY95KB0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k1nl+EUmAYscMk0MAMW2wOdy5tjaXvnpQu2mWSR498aox4xq7L28RDznbIZh6rShu
	 bXVpJ07+Dr4X3NpXfTZ0f+3K8zQ8Zd6GU7TcRKgE2VVsNXC3Y08ZZyb7CwubbNshsl
	 rm6wzJ/+k25k/ioraZ+0GeLOcb5AuV3QTsiMjdD7WPv7IhViBMRoyEFjeAf8ki2Aj8
	 W8ZdClpH4+zgGo/wL79cSK2jQ4cXV/iem14axjymtw8/HBVWpvEmqX0RCWhOZdTah7
	 KQG1SBOFHqTYAzExj0EvSsQ5z8MaqVyH0lewm2ewDy4wd3OYa7pYLYkwfk2fAVqddy
	 kVlr1oQs66e8A==
Message-ID: <4e6b2d3addc34619e5d2e35ccbd798362a1fb95a.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Chuck Lever III
	 <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Date: Wed, 20 Sep 2023 11:29:41 -0400
In-Reply-To: <20230920-keine-eile-c9755b5825db@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
	 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
	 <4511209.uG2h0Jr0uP@nimes>
	 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
	 <20230920-leerung-krokodil-52ec6cb44707@brauner>
	 <20230920101731.ym6pahcvkl57guto@quack3>
	 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
	 <20230920-raser-teehaus-029cafd5a6e4@brauner>
	 <57C103E1-1AD2-4D86-926C-481BC6BDB191@oracle.com>
	 <20230920-keine-eile-c9755b5825db@brauner>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>, "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>
 , "cluster-devel@redhat.com" <cluster-devel@redhat.com>, "coda@cs.cmu.edu" <coda@cs.cmu.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Xi Ruoyao <xry111@linuxfromscratch.org>, Shyam Prasad N <sprasad@microsoft.com>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>, Kees Cook <keescook@chromium.org>, "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Al Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmai
 l.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>, "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, "devel@lists.orangefs.org" <devel@lists.orangefs.org>, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foun
 dation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bruno Haible <bruno@clisp.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-09-20 at 16:53 +0200, Christian Brauner wrote:
> > You could put it behind an EXPERIMENTAL Kconfig option so that the
> > code stays in and can be used by the brave or foolish while it is
> > still being refined.
>=20
> Given that the discussion has now fully gone back to the drawing board
> and this is a regression the honest thing to do is to revert the five
> patches that introduce the infrastructure:
>=20
> ffb6cf19e063 ("fs: add infrastructure for multigrain timestamps")
> d48c33972916 ("tmpfs: add support for multigrain timestamps")
> e44df2664746 ("xfs: switch to multigrain timestamps")
> 0269b585868e ("ext4: switch to multigrain timestamps")
> 50e9ceef1d4f ("btrfs: convert to multigrain timestamps")
>=20
> The conversion to helpers and cleanups are sane and should stay and can
> be used for any solution that gets built on top of it.
>=20
> I'd appreciate a look at the branch here:
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.ctime.rever=
t
>=20
> survives xfstests.

I think that's probably the wisest course of action. I need some time to
ponder the options for this series anyway, and another cycle in next
wouldn't hurt.

The branch itself looks fine, but you might want to reverse the order of
the patches in case someone lands there in the middle of a bisect. IOW,
I think you want to revert the "convert to multigrain" patches before
you revert the infrastructure.=20
--=20
Jeff Layton <jlayton@kernel.org>
