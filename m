Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 59114775387
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 09:07:02 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bD7f0dTI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLLhh1k4Gz300C
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 17:07:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bD7f0dTI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RLLhd3cYhz2xFm
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Aug 2023 17:06:57 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9B61A62FBF;
	Wed,  9 Aug 2023 07:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BD8C433C7;
	Wed,  9 Aug 2023 07:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691564812;
	bh=LyptcIlHZJMPRLgCQdT8M5vqzNKCvVA2tglx+SSzKhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bD7f0dTITrbaEv4ks9HGhx0VVGQl2go0/eu1op4nP82j4N7TgX5btWqWiaSGoe8jp
	 i6+z7Q/Jk2DuDRVzKbPo4bN2rJnb7ZSAdXE4Z0xYd+h6nr/dULJQsuanMXc8U/mPWC
	 durewToMDZYiugVbqFDpM/vlNxIknI7IjiKj4iWyBj6wWmzWhg0/t+ygbJ1TK6LZ+2
	 DAg/4gaYUGbCnyrWc2K3wnSswvzR8b++oY6In8hF21Owe2spxR27o2A1Ew8ijOuuN3
	 Wo+4rLZHSLxhk9EzIXmcSquBg+Bnp2nKOE70h2bjG7fT6iPfQRAHqxOjlzas9G4WAl
	 a1bfUfvPCKxNg==
Date: Wed, 9 Aug 2023 09:06:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v7 06/13] ubifs: have ubifs_update_time use
 inode_update_timestamps
Message-ID: <20230809-handreichung-umgearbeitet-951eebed4d61@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-6-d1dec143a704@kernel.org>
 <20230808093701.ggyj7tyqonivl7tb@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808093701.ggyj7tyqonivl7tb@quack3>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, samba-technical@lists.samba.org, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin 
 Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@lin
 uxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 08, 2023 at 11:37:01AM +0200, Jan Kara wrote:
> On Mon 07-08-23 15:38:37, Jeff Layton wrote:
> > In later patches, we're going to drop the "now" parameter from the
> > update_time operation. Prepare ubifs for this, by having it use the new
> > inode_update_timestamps helper.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> One comment below:
> 
> > diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> > index df9086b19cd0..2d0178922e19 100644
> > --- a/fs/ubifs/file.c
> > +++ b/fs/ubifs/file.c
> > @@ -1397,15 +1397,9 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
> >  		return err;
> >  
> >  	mutex_lock(&ui->ui_mutex);
> > -	if (flags & S_ATIME)
> > -		inode->i_atime = *time;
> > -	if (flags & S_CTIME)
> > -		inode_set_ctime_to_ts(inode, *time);
> > -	if (flags & S_MTIME)
> > -		inode->i_mtime = *time;
> > -
> > -	release = ui->dirty;
> > +	inode_update_timestamps(inode, flags);
> >  	__mark_inode_dirty(inode, I_DIRTY_SYNC);
> > +	release = ui->dirty;
> >  	mutex_unlock(&ui->ui_mutex);
> 
> I think this is wrong. You need to keep sampling ui->dirty before calling
> __mark_inode_dirty(). Otherwise you could release budget for inode update
> you really need...

Fixed in-tree.
