Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F257A88C3
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 17:45:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gDmHlI6X;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=486eKcFx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrNCj6dGNz3cDd
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 01:45:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=gDmHlI6X;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=486eKcFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1d; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrNCb6ll5z3c53
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 01:45:31 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4BF420267;
	Wed, 20 Sep 2023 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695224727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw0GfkzEv5qjhmPaYmrLrmVLcBgiouetaUVK1NJf9SE=;
	b=gDmHlI6XIITA9cWR7273bMWfTaFm79ZWCKV9DUbgwsMsYlQtttv7ABQywrVa7BRoFxk5Vs
	fY8Ytovd+JgcWaHYYF/cazBOkeQAnuEbAgfy+zWX2EEn3UHUxNv8SLgNC/S16/CAgBAqvG
	jDzYA0P8qRNq8WfC9VqpMNAjW8ajDQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695224727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw0GfkzEv5qjhmPaYmrLrmVLcBgiouetaUVK1NJf9SE=;
	b=486eKcFxONt6Xlrpd7pWWA685BmUhAvAAZoUWjfk3k5wgXtMAG8bbabr8rPv7UJw6UUY7B
	IV+4KbXuBo0SdmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98F9E132C7;
	Wed, 20 Sep 2023 15:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Nk9PJZcTC2VGTwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 15:45:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 33A59A077D; Wed, 20 Sep 2023 17:45:27 +0200 (CEST)
Date: Wed, 20 Sep 2023 17:45:27 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920154527.pkwot4nu2nzrnamd@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
 <20230920124823.ghl6crb5sh4x2pmt@quack3>
 <ca82af4d6a72d7f83223c0ddd74fd9f7bcfa96b1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82af4d6a72d7f83223c0ddd74fd9f7bcfa96b1.camel@kernel.org>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <
 bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Xi Ruoyao <xry111@linuxfromscratch.org>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o
  <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Bruno Haible <bruno@clisp.org>, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed 20-09-23 10:12:03, Jeff Layton wrote:
> On Wed, 2023-09-20 at 14:48 +0200, Jan Kara wrote:
> > On Wed 20-09-23 06:35:18, Jeff Layton wrote:
> > > On Wed, 2023-09-20 at 12:17 +0200, Jan Kara wrote:
> > > > If I were a sysadmin, I'd rather opt for something like
> > > > finegrained timestamps + lazytime (if I needed the finegrained timestamps
> > > > functionality). That should avoid the IO overhead of finegrained timestamps
> > > > as well and I'd know I can have problems with timestamps only after a
> > > > system crash.
> > > 
> > > > I've just got another idea how we could solve the problem: Couldn't we
> > > > always just report coarsegrained timestamp to userspace and provide access
> > > > to finegrained value only to NFS which should know what it's doing?
> > > > 
> > > 
> > > I think that'd be hard. First of all, where would we store the second
> > > timestamp? We can't just truncate the fine-grained ones to come up with
> > > a coarse-grained one. It might also be confusing having nfsd and local
> > > filesystems present different attributes.
> > 
> > So what I had in mind (and I definitely miss all the NFS intricacies so the
> > idea may be bogus) was that inode->i_ctime would be maintained exactly as
> > is now. There will be new (kernel internal at least for now) STATX flag
> > STATX_MULTIGRAIN_TS. fill_mg_cmtime() will return timestamp truncated to
> > sb->s_time_gran unless STATX_MULTIGRAIN_TS is set. Hence unless you set
> > STATX_MULTIGRAIN_TS, there is no difference in the returned timestamps
> > compared to the state before multigrain timestamps were introduced. With
> > STATX_MULTIGRAIN_TS we return full precision timestamp as stored in the
> > inode. Then NFS in fh_fill_pre_attrs() and fh_fill_post_attrs() needs to
> > make sure STATX_MULTIGRAIN_TS is set when calling vfs_getattr() to get
> > multigrain time.
> 
> > I agree nfsd may now be presenting slightly different timestamps than user
> > is able to see with stat(2) directly on the filesystem. But is that a
> > problem? Essentially it is a similar solution as the mgtime mount option
> > but now sysadmin doesn't have to decide on filesystem mount how to report
> > timestamps but the stat caller knowingly opts into possibly inconsistent
> > (among files) but high precision timestamps. And in the particular NFS
> > usecase where stat is called all the time anyway, timestamps will likely
> > even be consistent among files.
> > 
> 
> I like this idea...
> 
> Would we also need to raise sb->s_time_gran to something corresponding
> to HZ on these filesystems?

I was actually confused a bit about how timestamp_truncate() works. The
jiffie granularity is just direct consequence of current_time() using
ktime_get_coarse_real_ts64() and not of timestamp_truncate().
sb->s_time_gran seems to be more about the on-disk format so it doesn't
seem like a great idea to touch it. So probably we can just truncate
timestamps in generic_fillattr() to HZ granularity unconditionally.

> If we truncate the timestamps at a granularity corresponding to HZ before
> presenting them via statx and the like then that should work around the
> problem with programs that compare timestamps between inodes.

Exactly.

> With NFSv4, when a filesystem doesn't report a STATX_CHANGE_COOKIE, nfsd
> will fake one up using the ctime. It's fine for that to use a full fine-
> grained timestamp since we don't expect to be able to compare that value
> with one of a different inode.

Yes.

> I think we'd want nfsd to present the mtime/ctime values as truncated,
> just like we would with a local fs. We could hit the same problem of an
> earlier-looking timestamp with NFS if we try to present the actual fine-
> grained values to the clients. IOW, I'm convinced that we need to avoid
> this behavior in most situations.

I wasn't sure if there's a way to do this within NFS - i.e., if the value
communicated via NFSv3 protocol (I know v4 has a special change cookie
field for it) that gets used for detecting need to revalidate file contents
isn't the one presented to client's userspace as ctime. If there's a way to
do this then great, I'm all for presenting truncated timestamps even for
NFS.

> If we do this, then we technically don't need the mount option either.

Yes, that was my hope.

> We could still add it though, and have it govern whether fill_mg_cmtime
> truncates the timestamps before storing them in the kstat.

Well, if we decide these timestamps are useful for userspace as well, I'd
rather make that a userspace visible STATX flag than a mount option. So
applications aware of the pitfalls can get high precision timestamps
without possibly breaking unaware applications.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
