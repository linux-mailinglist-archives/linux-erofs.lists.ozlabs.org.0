Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C27A7BFA
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 13:57:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rg4SDYT2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrH7y6ZZVz3c4J
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 21:57:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rg4SDYT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrH7r10LFz3bPM
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 21:56:56 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 877BDB81BEB;
	Wed, 20 Sep 2023 11:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677F3C433CD;
	Wed, 20 Sep 2023 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695211011;
	bh=v+kxoG9eOGJ5xusIWXasOkiwnORCBCOMs4NdoCLCV+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Rg4SDYT2G/5iLIMjOccnvEi1JiFZ6DWISJeHQBkraG1wlEzFngIZ40YiKunM8cbSc
	 +aGiW2BG1XlefCOYsICZDxSIj/cycJoqoVgH21scC+LvhZuM/I7QY33SH4s37GiB3i
	 xx8VoYkq8098drZ1/id4lmBEMu3eQVNXWTxAUaEp2MAhsi3wNH08SmNvjfcYqsJCu1
	 KXrrrvTysK40Yb4V8RFHdyvz2X1AZgX3gj24E21SykmhPZrGV8Spjbs29Y+Wz+E6KX
	 beC0Mxqh0EOjy/WL/hLY5L03MPDQWMARcGn8Qnl4hdNKDEe2Is8D1IwBJNuuGtXBBF
	 rmhEIbbPeuCGA==
Message-ID: <35c28758a9cc28a276a6b4b4ae8a420a1444e711.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Date: Wed, 20 Sep 2023 07:56:43 -0400
In-Reply-To: <20230920-raser-teehaus-029cafd5a6e4@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
	 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
	 <4511209.uG2h0Jr0uP@nimes>
	 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
	 <20230920-leerung-krokodil-52ec6cb44707@brauner>
	 <20230920101731.ym6pahcvkl57guto@quack3>
	 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
	 <20230920-raser-teehaus-029cafd5a6e4@brauner>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, "Darrick
 J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <
 trond.myklebust@hammerspace.com>, Xi Ruoyao <xry111@linuxfromscratch.org>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, lin
 ux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bruno Haible <bruno@clisp.org>, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 2023-09-20 at 13:48 +0200, Christian Brauner wrote:
> > > > While we initially thought we can do this unconditionally it turns =
out
> > > > that this might break existing workloads that rely on timestamps in=
 very
> > > > specific ways and we always knew this was a possibility. Move
> > > > multi-grain timestamps behind a vfs mount option.
> > >=20
> > > Surely this is a safe choice as it moves the responsibility to the sy=
sadmin
> > > and the cases where finegrained timestamps are required. But I kind o=
f
> > > wonder how is the sysadmin going to decide whether mgtime is safe for=
 his
> > > system or not? Because the possible breakage needn't be obvious at th=
e
> > > first sight...
> > >=20
> >=20
> > That's the main reason I really didn't want to go with a mount option.
> > Documenting that may be difficult. While there is some pessimism around
> > it, I may still take a stab at just advancing the coarse clock whenever
> > we fetch a fine-grained timestamp. It'd be nice to remove this option i=
n
> > the future if that turns out to be feasible.
> >=20
> > > If I were a sysadmin, I'd rather opt for something like
> > > finegrained timestamps + lazytime (if I needed the finegrained timest=
amps
> > > functionality). That should avoid the IO overhead of finegrained time=
stamps
> > > as well and I'd know I can have problems with timestamps only after a
> > > system crash.
> >=20
> > > I've just got another idea how we could solve the problem: Couldn't w=
e
> > > always just report coarsegrained timestamp to userspace and provide a=
ccess
> > > to finegrained value only to NFS which should know what it's doing?
> > >=20
> >=20
> > I think that'd be hard. First of all, where would we store the second
> > timestamp? We can't just truncate the fine-grained ones to come up with
> > a coarse-grained one. It might also be confusing having nfsd and local
> > filesystems present different attributes.
>=20
> As far as I can tell we have two options. The first one is to make this
> into a mount option which I really think isn't a big deal and lets us
> avoid this whole problem while allowing filesytems exposed via NFS to
> make use of this feature for change tracking.
>=20
> The second option is that we turn off fine-grained finestamps for v6.6
> and you get to explore other options.
>=20
> It isn't a big deal regressions like this were always to be expected but
> v6.6 needs to stabilize so anything that requires more significant work
> is not an option.

Oh, absolutely.

I wasn't proposing to do that work for v6.6. For that, we absolutely
either need the mount option or to just revert the mgtime conversions.

My plan was to take a stab at doing this for a later kernel release.
This is very much a "back to the drawing board" idea. It may not pan out
after all, but if it does then we could consider removing the mount
option at that point.
--=20
Jeff Layton <jlayton@kernel.org>
