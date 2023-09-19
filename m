Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B302E7A609F
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 13:05:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cJr+PwvU;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=meYxUUYP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rqf2h3sQRz3bTn
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 21:05:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cJr+PwvU;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=meYxUUYP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1d; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rqf2Y3tN0z2yTN
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 Sep 2023 21:05:07 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5342D1FE31;
	Tue, 19 Sep 2023 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1695121498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a6e2yyPMgqeI3y+2Rnc2fZeeo+kgiK2m70Hco9fnr4=;
	b=cJr+PwvUYyZH2t3upcBw0eryf4DE/LlFfn7Ufm2eAWd1VY02qygFmTzBIaJahVSz94O4Vb
	yGqIOI0jCW0Ip0Sk2rToBmP3VAYVKS3al3oLycPIe7d7v/sSOaNYyizpxk5ZIrSJFN93/P
	SUBM4OkiK17iPKtzTKMO612fqmtdvLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1695121498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a6e2yyPMgqeI3y+2Rnc2fZeeo+kgiK2m70Hco9fnr4=;
	b=meYxUUYPlIj0HPS4xS8OLRDZWnsHTMsdExQo9ACa74+dnEYe0U3v8eAO6qjvM08RQNmwM8
	rVywJglnBJnDHgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A0D613A49;
	Tue, 19 Sep 2023 11:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wCZPAFqACWVOYAAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 11:04:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11C86A0759; Tue, 19 Sep 2023 13:04:57 +0200 (CEST)
Date: Tue, 19 Sep 2023 13:04:57 +0200
From: Jan Kara <jack@suse.cz>
To: Xi Ruoyao <xry111@linuxfromscratch.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230919110457.7fnmzo4nqsi43yqq@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
 <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, samba-technical@lists.samba.org, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, bug-gnulib@gnu.org, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com
 >, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <jo
 seph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue 19-09-23 15:05:24, Xi Ruoyao wrote:
> On Mon, 2023-08-07 at 15:38 -0400, Jeff Layton wrote:
> > Enable multigrain timestamps, which should ensure that there is an
> > apparent change to the timestamp whenever it has been written after
> > being actively observed via getattr.
> > 
> > For ext4, we only need to enable the FS_MGTIME flag.
> 
> Hi Jeff,
> 
> This patch causes a gnulib test failure:
> 
> $ ~/sources/lfs/grep-3.11/gnulib-tests/test-stat-time
> test-stat-time.c:141: assertion 'statinfo[0].st_mtime < statinfo[2].st_mtime || (statinfo[0].st_mtime == statinfo[2].st_mtime && (get_stat_mtime_ns (&statinfo[0]) < get_stat_mtime_ns (&statinfo[2])))' failed
> Aborted (core dumped)
> 
> The source code of the test:
> https://git.savannah.gnu.org/cgit/gnulib.git/tree/tests/test-stat-time.c
> 
> Is this an expected change?

Kind of yes. The test first tries to estimate filesystem timestamp
granularity in nap() function - due to this patch, the detected granularity
will likely be 1 ns so effectively all the test calls will happen
immediately one after another. But we don't bother setting the timestamps
with more than 1 jiffy (usually 4 ms) precision unless we think someone is
watching. So as a result timestamps of all stamp1 and stamp2 files are
going to be equal which makes the test fail.

The ultimate problem is that a sequence like:

write(f1)
stat(f2)
write(f2)
stat(f2)
write(f1)
stat(f1)

can result in f1 timestamp to be (slightly) lower than the final f2
timestamp because the second write to f1 didn't bother updating the
timestamp. That can indeed be a bit confusing to programs if they compare
timestamps between two files. Jeff?

								Honza


> > Acked-by: Theodore Ts'o <tytso@mit.edu>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ext4/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b54c70e1a74e..cb1ff47af156 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -7279,7 +7279,7 @@ static struct file_system_type ext4_fs_type = {
> >  	.init_fs_context	= ext4_init_fs_context,
> >  	.parameters		= ext4_param_specs,
> >  	.kill_sb		= kill_block_super,
> > -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP |
> > FS_MGTIME,
> >  };
> >  MODULE_ALIAS_FS("ext4");
> >  
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
