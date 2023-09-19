Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388A7A68F0
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 18:31:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSgO9mQ/;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqnH12MLCz3btp
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 02:31:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NSgO9mQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqnGw47zWz2xYk
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 02:31:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 8CD0BCE139A;
	Tue, 19 Sep 2023 16:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A27C433CD;
	Tue, 19 Sep 2023 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695141076;
	bh=2YOWI6/JAFOB4t8+Jl1G0UAU2WJNOEKR+ozWrF+wCHw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NSgO9mQ/kogScKOyruXs27QKGb28KeH5iN8518jdQIxYZ9Zq8W5Yeb8HJpLNbIZ40
	 EQDdGtIWCMRwCZr+hkVhSKagEDB2fBTdAzDnNexBTyvRGH8+mWpGC7k4O3oOthSODy
	 kLPJh5RYmd+l51ixbejRXP63ZyU1UyglaFGETEGRw2BGftvafb/kUzhWZeRY/B1ibo
	 Wti21rW2JgdQmcow8/EHQlT7uWQR0pPH/ecD4lkrfORAvjqUH6xcDxBDFUTwISNY24
	 GBmtqEOt9wCW1B2y4/2rn4A5SVB2ofaAjm8Z64p+ka1gu4ZTZ9u3KdunqSf9K8+AlP
	 OJGP0iADrktsQ==
Message-ID: <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From: Jeff Layton <jlayton@kernel.org>
To: Bruno Haible <bruno@clisp.org>, Jan Kara <jack@suse.cz>, Xi Ruoyao
	 <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org
Date: Tue, 19 Sep 2023 12:31:08 -0400
In-Reply-To: <4511209.uG2h0Jr0uP@nimes>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	 <20230919110457.7fnmzo4nqsi43yqq@quack3>
	 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
	 <4511209.uG2h0Jr0uP@nimes>
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

On Tue, 2023-09-19 at 16:52 +0200, Bruno Haible wrote:
> Jeff Layton wrote:
> > I'm not sure what we can do for this test. The nap() function is making
> > an assumption that the timestamp granularity will be constant, and that
> > isn't necessarily the case now.
>=20
> This is only of secondary importance, because the scenario by Jan Kara
> shows a much more fundamental breakage:
>=20
> > > The ultimate problem is that a sequence like:
> > >=20
> > > write(f1)
> > > stat(f2)
> > > write(f2)
> > > stat(f2)
> > > write(f1)
> > > stat(f1)
> > >=20
> > > can result in f1 timestamp to be (slightly) lower than the final f2
> > > timestamp because the second write to f1 didn't bother updating the
> > > timestamp. That can indeed be a bit confusing to programs if they com=
pare
> > > timestamps between two files. Jeff?
> > >=20
> >=20
> > Basically yes.
>=20
> f1 was last written to *after* f2 was last written to. If the timestamp o=
f f1
> is then lower than the timestamp of f2, timestamps are fundamentally brok=
en.
>=20
> Many things in user-space depend on timestamps, such as build system
> centered around 'make', but also 'find ... -newer ...'.
>=20


What does breakage with make look like in this situation? The "fuzz"
here is going to be on the order of a jiffy. The typical case for make
timestamp comparisons is comparing source files vs. a build target. If
those are being written nearly simultaneously, then that could be an
issue, but is that a typical behavior? It seems like it would be hard to
rely on that anyway, esp. given filesystems like NFS that can do lazy
writeback.

One of the operating principles with this series is that timestamps can
be of varying granularity between different files. Note that Linux
already violates this assumption when you're working across filesystems
of different types.

As to potential fixes if this is a real problem:

I don't really want to put this behind a mount or mkfs option (a'la
relatime, etc.), but that is one possibility.

I wonder if it would be feasible to just advance the coarse-grained
current_time whenever we end up updating a ctime with a fine-grained
timestamp? It might produce some inode write amplification. Files that
were written within the same jiffy could see more inode transactions
logged, but that still might not be _too_ awful.

I'll keep thinking about it for now.
--=20
Jeff Layton <jlayton@kernel.org>
