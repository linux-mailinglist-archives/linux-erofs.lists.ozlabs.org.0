Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CD7767E2
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 21:04:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AneNvnqJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLfd43C92z3bcL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 05:04:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AneNvnqJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLfd10QYcz2ywt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 05:04:52 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C947D644DE;
	Wed,  9 Aug 2023 19:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB107C433C7;
	Wed,  9 Aug 2023 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691607890;
	bh=alXrKPD5fHXeJn9UjHKim4LKQU7HoozYjQglaZ1xXaI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AneNvnqJ20CJmKiEgeASfLx4NSIFXV4j2vtzAKGnX32iLsSf9A43S7wAfHVHbYQQP
	 h3ON9dJJ2d4zasDcG0OHa5a1AfenYnO+uoesgXhOt+soOjJtmmxlhUNc5QuXKGuVOg
	 rulv+awus9qyVEIGRttUpq9Lcin2kAZfB093o2LczBjmWrzPbu4HcAMNS3Ib4zj45p
	 3u7x0mQLZuZR6+lN5gsi60S8IiOPzBT4vt1n3+KsBq67CA1z2KjKobM8vv+qdWmPsN
	 ddnXMIFOGmdQH1E3uRbvXBai78DI/EAYz+8n3M9qwxNTsQtwGjIcAPpzsM/ELjqang
	 5ERP9Tcme3DHA==
Message-ID: <edf8e8ca3b38e56f30e0d24ac7293f848ffee371.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From: Jeff Layton <jlayton@kernel.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 09 Aug 2023 15:04:42 -0400
In-Reply-To: <87h6p86p9z.fsf@mail.parknet.co.jp>
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

On Thu, 2023-08-10 at 03:31 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > On Thu, 2023-08-10 at 02:44 +0900, OGAWA Hirofumi wrote:
> > > Jeff Layton <jlayton@kernel.org> writes:
> > >=20
> > That would be wrong. The problem is that we're changing how update_time
> > works:
> >=20
> > Previously, update_time was given a timestamp and a set of S_* flags to
> > indicate which fields should be updated. Now, update_time is not given =
a
> > timestamp. It needs to fetch it itself, but that subtly changes the
> > meaning of the flags field.
> >=20
> > It now means "these fields needed to be updated when I last checked".
> > The timestamp and i_version may now be different from when the flags
> > field was set. This means that if any of S_CTIME/S_MTIME/S_VERSION were
> > set that we need to attempt to update all 3 of them. They may now be
> > different from the timestamp or version that we ultimately end up with.
> >=20
> > The above may look to you like it would always cause I_DIRTY_SYNC to be
> > set on any ctime or mtime update, but inode_maybe_inc_iversion only
> > returns true if it actually updated i_version, and it only does that if
> > someone issued a ->getattr against the file since the last time it was
> > updated.
> >=20
> > So, this shouldn't generate any more DIRTY_SYNC updates than it did
> > before.
>=20
> Again, if you claim so, why generic_update_time() doesn't work same? Why
> only FAT does?
>=20
> Or I'm misreading generic_update_time() patch?
>=20

When you say it "doesn't work the same", what do you mean, specifically?
I had to make some allowances for the fact that FAT is substantially
different in its timestamp handling, and I tried to preserve existing
behavior as best I could.

--=20
Jeff Layton <jlayton@kernel.org>
