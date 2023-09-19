Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B87A6C79
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 22:46:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q9KdgZu9;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rqtxb4YBTz3byH
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 06:46:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q9KdgZu9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqtxT5gvKz30NP
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 06:46:37 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F2E59617B9;
	Tue, 19 Sep 2023 20:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819FC433C9;
	Tue, 19 Sep 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695156393;
	bh=BmRXQZIEgC13FrkspW8zNhSJjLbclay0bgLqEV3Rrl8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=q9KdgZu946MZfw7DxJLZIxiiIbHL9p62pycuILxZHzw8MqP3sd2qzr3E/ZkzfhbEv
	 Sv560WUNQE0HlwP/5rEqpm3bw7jCmrV5akvxgau1zBqN4rLOK+/ZjoboBONeleNI+5
	 6SP6lExUu15oD0xQisxQolfz9bgwYx59X/D7X0LTGvi5p2a+XVoY+oMnByTr4quQRa
	 dZXyYP7t6FAFej2yuwhu+Ce8pxPjyRxtNPk1CXlFaDLgBYYr9H9mjHCggTcasxMD+A
	 UZV+ik47sNRSAwVomJhe40/Ndx/tHAngLhTIM40zYtZFnzpPzdTJ314IhHsCYJFhNI
	 PFuADp6gLFx9g==
Message-ID: <6e6da8a875a0defec1a0f58314995a6a12dca74e.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Paul Eggert <eggert@cs.ucla.edu>, Bruno Haible <bruno@clisp.org>, Jan
 Kara <jack@suse.cz>, Xi Ruoyao <xry111@linuxfromscratch.org>,
 bug-gnulib@gnu.org
Date: Tue, 19 Sep 2023 16:46:25 -0400
In-Reply-To: <c8315110-4684-9b83-d6c5-751647037623@cs.ucla.edu>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
	 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
	 <4511209.uG2h0Jr0uP@nimes>
	 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
	 <c8315110-4684-9b83-d6c5-751647037623@cs.ucla.edu>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Tr
 ond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey 
 Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 2023-09-19 at 13:10 -0700, Paul Eggert wrote:
> On 2023-09-19 09:31, Jeff Layton wrote:
> > The typical case for make
> > timestamp comparisons is comparing source files vs. a build target. If
> > those are being written nearly simultaneously, then that could be an
> > issue, but is that a typical behavior?
>=20
> I vaguely remember running into problems with 'make' a while ago=20
> (perhaps with a BSDish system) when filesystem timestamps were=20
> arbitrarily truncated in some cases but not others. These files would=20
> look older than they really were, so 'make' would think they were=20
> up-to-date when they weren't, and 'make' would omit actions that it=20
> should have done, thus screwing up the build.
>=20
> File timestamps can be close together with 'make -j' on fast hosts.=20
> Sometimes a shell script (or 'make' itself) will run 'make', then modify=
=20
> a file F, then immediately run 'make' again; the latter 'make' won't=20
> work if F's timestamp is mistakenly older than targets that depend on it.
>=20
> Although 'make'-like apps are the biggest canaries in this coal mine,=20
> the issue also affects 'find -newer' (as Bruno mentioned), 'rsync -u',=
=20
> 'mv -u', 'tar -u', Emacs file-newer-than-file-p, and surely many other=
=20
> places. For example, any app that creates a timestamp file, then backs=
=20
> up all files newer than that file, would be at risk.
>=20
>=20
> > I wonder if it would be feasible to just advance the coarse-grained
> > current_time whenever we end up updating a ctime with a fine-grained
> > timestamp?
>=20
> Wouldn't this need to be done globally, that is, not just on a per-file=
=20
> or per-filesystem basis? If so, I don't see how we'd avoid locking=20
> performance issues.
>=20

Maybe. Another idea might be to introduce a new timekeeper for
multigrain filesystems, but all of those would likely have to share the
same coarse-grained clock source.

So yeah, if you stat an inode and then update it, any inode written on a
multigrain filesystem within the same jiffy-sized window would have to
log an extra transaction to write out the inode. That's what I meant
when I was talking about write amplification.

>=20
> PS. Although I'm no expert in the Linux inode code I hope you don't mind=
=20
> my asking a question about this part of inode_set_ctime_current:
>=20
> 	/*
> 	 * If we've recently updated with a fine-grained timestamp,
> 	 * then the coarse-grained one may still be earlier than the
> 	 * existing ctime. Just keep the existing value if so.
> 	 */
> 	ctime.tv_sec =3D inode->__i_ctime.tv_sec;
> 	if (timespec64_compare(&ctime, &now) > 0)
> 		return ctime;
>=20
> Suppose root used clock_settime to set the clock backwards. Won't this=
=20
> code incorrectly refuse to update the file's timestamp afterwards? That=
=20
> is, shouldn't the last line be "goto fine_grained;" rather than "return=
=20
> ctime;", with the comment changed from "keep the existing value" to "use=
=20
> a fine-grained value"?

It is a problem, and Linus pointed that out yesterday, which is why I
sent this earlier today:

https://lore.kernel.org/linux-fsdevel/20230919-ctime-v1-1-97b3da92f504@kern=
el.org/T/#u

Bear in mind that we're not dealing with a situation where the value has
not been queried since its last update, so we don't need to use a fine
grained timestamp there (and really, it's preferable not to do so). A
coarse one should be fine in this case.
--=20
Jeff Layton <jlayton@kernel.org>
