Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0B7A6154
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 13:33:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tQh6lksL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rqfgf4s6Kz3bVS
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 21:33:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tQh6lksL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqfgW6X7Qz2xpd
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Sep 2023 21:33:43 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D45C8B815DD;
	Tue, 19 Sep 2023 11:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D159EC433C8;
	Tue, 19 Sep 2023 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695123213;
	bh=3M0d3dD3pzePraPqdY5Lb/FSgSUINN1vw73+jr5dq7Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tQh6lksLqcIOBj/Ff0JXOKys/7/S9IytLOiF0JDIywzjJVGnvZkHN89m5sE62mpoB
	 B3YDCwOOxX1gnLmVWc3ePStHNAbvbDg9jgbpVAv5wDbDdw2Vl89GZwZ9qNlNxra4Fg
	 kiXuONNyEoPOCmaTk9QAiioZqeXDdQ8Od2dvXiPB2jbqabD8+vET4rWht6VUqialFl
	 kMESlGGKraI/mfEF5XUwwnyQC7enBkaOr88DrXpjQxZ8vzJOm87lLPeOk13Z2jZZWP
	 +DF8dMCw1HMweouCpDWHzR5OF6xSCTUQlXvt6hjtZ1K1zZoSy0NQYp4mHOMzF7pFix
	 96Omsq9cDaYdg==
Message-ID: <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Xi Ruoyao <xry111@linuxfromscratch.org>
Date: Tue, 19 Sep 2023 07:33:25 -0400
In-Reply-To: <20230919110457.7fnmzo4nqsi43yqq@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
	 <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <b
 codding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@lin
 uxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 2023-09-19 at 13:04 +0200, Jan Kara wrote:
> On Tue 19-09-23 15:05:24, Xi Ruoyao wrote:
> > On Mon, 2023-08-07 at 15:38 -0400, Jeff Layton wrote:
> > > Enable multigrain timestamps, which should ensure that there is an
> > > apparent change to the timestamp whenever it has been written after
> > > being actively observed via getattr.
> > >=20
> > > For ext4, we only need to enable the FS_MGTIME flag.
> >=20
> > Hi Jeff,
> >=20
> > This patch causes a gnulib test failure:
> >=20
> > $ ~/sources/lfs/grep-3.11/gnulib-tests/test-stat-time
> > test-stat-time.c:141: assertion 'statinfo[0].st_mtime < statinfo[2].st_=
mtime || (statinfo[0].st_mtime =3D=3D statinfo[2].st_mtime && (get_stat_mti=
me_ns (&statinfo[0]) < get_stat_mtime_ns (&statinfo[2])))' failed
> > Aborted (core dumped)
> >=20
> > The source code of the test:
> > https://git.savannah.gnu.org/cgit/gnulib.git/tree/tests/test-stat-time.=
c
> >=20
> > Is this an expected change?
>=20
> Kind of yes. The test first tries to estimate filesystem timestamp
> granularity in nap() function - due to this patch, the detected granulari=
ty
> will likely be 1 ns so effectively all the test calls will happen
> immediately one after another. But we don't bother setting the timestamps
> with more than 1 jiffy (usually 4 ms) precision unless we think someone i=
s
> watching. So as a result timestamps of all stamp1 and stamp2 files are
> going to be equal which makes the test fail.
>=20

That was my take too. The multigrain ctime changes are probably causing
nap() to settle on too small a time delta.

> The ultimate problem is that a sequence like:
>=20
> write(f1)
> stat(f2)
> write(f2)
> stat(f2)
> write(f1)
> stat(f1)
>
> can result in f1 timestamp to be (slightly) lower than the final f2
> timestamp because the second write to f1 didn't bother updating the
> timestamp. That can indeed be a bit confusing to programs if they compare
> timestamps between two files. Jeff?
>=20

Basically yes. When there is no stat() call issued on the file in
between writes, the kernel will use coarse-grained timestamps when
updating it (since no one is watching).


I'm not sure what we can do for this test. The nap() function is making
an assumption that the timestamp granularity will be constant, and that
isn't necessarily the case now.

--=20
Jeff Layton <jlayton@kernel.org>
