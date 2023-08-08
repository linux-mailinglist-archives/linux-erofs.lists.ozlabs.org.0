Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB1773952
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 11:25:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ix372cs3;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nz47Gajx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKnpq1hpJz2yt0
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 19:25:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ix372cs3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nz47Gajx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKnph5S3nz2xFm
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 19:25:16 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE16022481;
	Tue,  8 Aug 2023 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1691486712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DEnEiKO284zxT4/+fvA4uuffbMofkDORo642+Wc/io=;
	b=ix372cs3mbIkTWg1MsYpwEmHKxymfpU2fRqMoB3bdsY5L5+d88wTzMILXUNjN2Hey8brqp
	/zdSMsRPF0pQ9mO8VTms56EAKaxrkXcWWBEAdzVrBPrId8dDBBUjH8L2jH5yiaPdY8XiST
	M7jwu5Zs1qGSi0jn9fW7GgGyREZQvck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1691486712;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DEnEiKO284zxT4/+fvA4uuffbMofkDORo642+Wc/io=;
	b=nz47GajxRXd1Kr3p+NB1XcBjrQKYlyuj0q3UvQcQR7hQOVOIMR3ZkrS9KehXlRYW0RhdS3
	rOQzce0ROF9jIWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D531F13451;
	Tue,  8 Aug 2023 09:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id SiMINPcJ0mSNFwAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 08 Aug 2023 09:25:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F488A0769; Tue,  8 Aug 2023 11:25:11 +0200 (CEST)
Date: Tue, 8 Aug 2023 11:25:11 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 03/13] fs: drop the timespec64 arg from
 generic_update_time
Message-ID: <20230808092511.jh4lxer2dztdajpo@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-3-d1dec143a704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-mgctime-v7-3-d1dec143a704@kernel.org>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>,
  Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v
 9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon 07-08-23 15:38:34, Jeff Layton wrote:
> In future patches we're going to change how the ctime is updated
> to keep track of when it has been queried. The way that the update_time
> operation works (and a lot of its callers) make this difficult, since
> they grab a timestamp early and then pass it down to eventually be
> copied into the inode.
> 
> All of the existing update_time callers pass in the result of
> current_time() in some fashion. Drop the "time" parameter from
> generic_update_time, and rework it to fetch its own timestamp.
> 
> This change means that an update_time could fetch a different timestamp
> than was seen in inode_needs_update_time. update_time is only ever
> called with one of two flag combinations: Either S_ATIME is set, or
> S_MTIME|S_CTIME|S_VERSION are set.
> 
> With this change we now treat the flags argument as an indicator that
> some value needed to be updated when last checked, rather than an
> indication to update specific timestamps.
> 
> Rework the logic for updating the timestamps and put it in a new
> inode_update_timestamps helper that other update_time routines can use.
> S_ATIME is as treated as we always have, but if any of the other three
> are set, then we attempt to update all three.
> 
> Also, some callers of generic_update_time need to know what timestamps
> were actually updated. Change it to return an S_* flag mask to indicate
> that and rework the callers to expect it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/inode.c     |  3 +-
>  fs/inode.c          | 84 +++++++++++++++++++++++++++++++++++++++++------------
>  fs/orangefs/inode.c |  3 +-
>  fs/ubifs/file.c     |  6 ++--
>  fs/xfs/xfs_iops.c   |  6 ++--
>  include/linux/fs.h  |  3 +-
>  6 files changed, 80 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 200cabf3b393..f1f04557aa21 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2155,7 +2155,8 @@ static int gfs2_update_time(struct inode *inode, struct timespec64 *time,
>  		if (error)
>  			return error;
>  	}
> -	return generic_update_time(inode, time, flags);
> +	generic_update_time(inode, flags);
> +	return 0;
>  }
>  
>  static const struct inode_operations gfs2_file_iops = {
> diff --git a/fs/inode.c b/fs/inode.c
> index 3fc251bfaf73..e07e45f6cd01 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1881,29 +1881,76 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
>  	return 0;
>  }
>  
> -int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
> +/**
> + * inode_update_timestamps - update the timestamps on the inode
> + * @inode: inode to be updated
> + * @flags: S_* flags that needed to be updated
> + *
> + * The update_time function is called when an inode's timestamps need to be
> + * updated for a read or write operation. This function handles updating the
> + * actual timestamps. It's up to the caller to ensure that the inode is marked
> + * dirty appropriately.
> + *
> + * In the case where any of S_MTIME, S_CTIME, or S_VERSION need to be updated,
> + * attempt to update all three of them. S_ATIME updates can be handled
> + * independently of the rest.
> + *
> + * Returns a set of S_* flags indicating which values changed.
> + */
> +int inode_update_timestamps(struct inode *inode, int flags)
>  {
> -	int dirty_flags = 0;
> +	int updated = 0;
> +	struct timespec64 now;
> +
> +	if (flags & (S_MTIME|S_CTIME|S_VERSION)) {
> +		struct timespec64 ctime = inode_get_ctime(inode);
>  
> -	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -		if (flags & S_ATIME)
> -			inode->i_atime = *time;
> -		if (flags & S_CTIME)
> -			inode_set_ctime_to_ts(inode, *time);
> -		if (flags & S_MTIME)
> -			inode->i_mtime = *time;
> -
> -		if (inode->i_sb->s_flags & SB_LAZYTIME)
> -			dirty_flags |= I_DIRTY_TIME;
> -		else
> -			dirty_flags |= I_DIRTY_SYNC;
> +		now = inode_set_ctime_current(inode);
> +		if (!timespec64_equal(&now, &ctime))
> +			updated |= S_CTIME;
> +		if (!timespec64_equal(&now, &inode->i_mtime)) {
> +			inode->i_mtime = now;
> +			updated |= S_MTIME;
> +		}
> +		if (IS_I_VERSION(inode) && inode_maybe_inc_iversion(inode, updated))
> +			updated |= S_VERSION;
> +	} else {
> +		now = current_time(inode);
>  	}
>  
> -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> -		dirty_flags |= I_DIRTY_SYNC;
> +	if (flags & S_ATIME) {
> +		if (!timespec64_equal(&now, &inode->i_atime)) {
> +			inode->i_atime = now;
> +			updated |= S_ATIME;
> +		}
> +	}
> +	return updated;
> +}
> +EXPORT_SYMBOL(inode_update_timestamps);
> +
> +/**
> + * generic_update_time - update the timestamps on the inode
> + * @inode: inode to be updated
> + * @flags: S_* flags that needed to be updated
> + *
> + * The update_time function is called when an inode's timestamps need to be
> + * updated for a read or write operation. In the case where any of S_MTIME, S_CTIME,
> + * or S_VERSION need to be updated we attempt to update all three of them. S_ATIME
> + * updates can be handled done independently of the rest.
> + *
> + * Returns a S_* mask indicating which fields were updated.
> + */
> +int generic_update_time(struct inode *inode, int flags)
> +{
> +	int updated = inode_update_timestamps(inode, flags);
> +	int dirty_flags = 0;
>  
> +	if (updated & (S_ATIME|S_MTIME|S_CTIME))
> +		dirty_flags = inode->i_sb->s_flags & SB_LAZYTIME ? I_DIRTY_TIME : I_DIRTY_SYNC;
> +	if (updated & S_VERSION)
> +		dirty_flags |= I_DIRTY_SYNC;
>  	__mark_inode_dirty(inode, dirty_flags);
> -	return 0;
> +	return updated;
>  }
>  EXPORT_SYMBOL(generic_update_time);
>  
> @@ -1915,7 +1962,8 @@ int inode_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
>  	if (inode->i_op->update_time)
>  		return inode->i_op->update_time(inode, time, flags);
> -	return generic_update_time(inode, time, flags);
> +	generic_update_time(inode, flags);
> +	return 0;
>  }
>  EXPORT_SYMBOL(inode_update_time);
>  
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index a52c30e80f45..3afa2a69bc63 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -903,9 +903,10 @@ int orangefs_permission(struct mnt_idmap *idmap,
>  int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
>  	struct iattr iattr;
> +
>  	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_update_time: %pU\n",
>  	    get_khandle_from_ino(inode));
> -	generic_update_time(inode, time, flags);
> +	flags = generic_update_time(inode, flags);
>  	memset(&iattr, 0, sizeof iattr);
>          if (flags & S_ATIME)
>  		iattr.ia_valid |= ATTR_ATIME;
> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 436b27d7c58f..df9086b19cd0 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1387,8 +1387,10 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
>  			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
>  	int err, release;
>  
> -	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
> -		return generic_update_time(inode, time, flags);
> +	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT)) {
> +		generic_update_time(inode, flags);
> +		return 0;
> +	}
>  
>  	err = ubifs_budget_space(c, &req);
>  	if (err)
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 3a9363953ef2..731f45391baa 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1042,8 +1042,10 @@ xfs_vn_update_time(
>  
>  	if (inode->i_sb->s_flags & SB_LAZYTIME) {
>  		if (!((flags & S_VERSION) &&
> -		      inode_maybe_inc_iversion(inode, false)))
> -			return generic_update_time(inode, now, flags);
> +		      inode_maybe_inc_iversion(inode, false))) {
> +			generic_update_time(inode, flags);
> +			return 0;
> +		}
>  
>  		/* Capture the iversion update that just occurred */
>  		log_flags |= XFS_ILOG_CORE;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 85977cdeda94..bb3c2c4f871f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2343,7 +2343,8 @@ extern int current_umask(void);
>  
>  extern void ihold(struct inode * inode);
>  extern void iput(struct inode *);
> -extern int generic_update_time(struct inode *, struct timespec64 *, int);
> +int inode_update_timestamps(struct inode *inode, int flags);
> +int generic_update_time(struct inode *, int);
>  
>  /* /sys/fs */
>  extern struct kobject *fs_kobj;
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
