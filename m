Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31A773989
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 12:06:07 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RYwrn0fd;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3BwMkd6c;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RKpjm6lQwz2ytp
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Aug 2023 20:06:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RYwrn0fd;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3BwMkd6c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=softfail (domain owner discourages use of this host) smtp.mailfrom=suse.cz (client-ip=2001:67c:2178:6::1d; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RKpjj2Vt2z2xwG
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Aug 2023 20:06:01 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48E552031C;
	Tue,  8 Aug 2023 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1691489158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOTJYjkBLnwjV/lxEVtUyReuFAMisDvl/3KW3rcsa80=;
	b=RYwrn0fdjwhhRR7l27SfhU6sEIZlfDKsRmqY6BlBC/mbMQlEPGtvhbIdRr7h8egn/oN8yh
	Oz6U9UuTleHENrCE1avR3NSOn0guqcLSLu7iBXijjb70nxn/BQDxhjUWhk7QvvA5/v4PB8
	VNLrqst7KIs78O2ejOjXiqcNSNVttFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1691489158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOTJYjkBLnwjV/lxEVtUyReuFAMisDvl/3KW3rcsa80=;
	b=3BwMkd6c3zAZ5/EGX3xW7irKJimW+k7SoacxDa/XvD8/WW5BAqfXsGAeW7PnSgHdphBpnB
	7inqEIuyeW8nM7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CBE0139E9;
	Tue,  8 Aug 2023 10:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id riV+CoYT0mRzKwAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 08 Aug 2023 10:05:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F18AA0769; Tue,  8 Aug 2023 12:05:57 +0200 (CEST)
Date: Tue, 8 Aug 2023 12:05:57 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 13/13] btrfs: convert to multigrain timestamps
Message-ID: <20230808100557.dowlxz2destpseqr@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-13-d1dec143a704@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-mgctime-v7-13-d1dec143a704@kernel.org>
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

On Mon 07-08-23 15:38:44, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Beyond enabling the FS_MGTIME flag, this patch eliminates
> update_time_for_write, which goes to great pains to avoid in-memory
> stores. Just have it overwrite the timestamps unconditionally.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: David Sterba <dsterba@suse.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/btrfs/file.c  | 24 ++++--------------------
>  fs/btrfs/super.c |  5 +++--
>  2 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d7a9ece7a40b..b9e75c9f95ac 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1106,25 +1106,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>  	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>  }
>  
> -static void update_time_for_write(struct inode *inode)
> -{
> -	struct timespec64 now, ctime;
> -
> -	if (IS_NOCMTIME(inode))
> -		return;
> -
> -	now = current_time(inode);
> -	if (!timespec64_equal(&inode->i_mtime, &now))
> -		inode->i_mtime = now;
> -
> -	ctime = inode_get_ctime(inode);
> -	if (!timespec64_equal(&ctime, &now))
> -		inode_set_ctime_to_ts(inode, now);
> -
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> -}
> -
>  static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  			     size_t count)
>  {
> @@ -1156,7 +1137,10 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  	 * need to start yet another transaction to update the inode as we will
>  	 * update the inode when we finish writing whatever data we write.
>  	 */
> -	update_time_for_write(inode);
> +	if (!IS_NOCMTIME(inode)) {
> +		inode->i_mtime = inode_set_ctime_current(inode);
> +		inode_inc_iversion(inode);
> +	}
>  
>  	start_pos = round_down(pos, fs_info->sectorsize);
>  	oldsize = i_size_read(inode);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f1dd172d8d5b..8eda51b095c9 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2144,7 +2144,7 @@ static struct file_system_type btrfs_fs_type = {
>  	.name		= "btrfs",
>  	.mount		= btrfs_mount,
>  	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
> +	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MGTIME,
>  };
>  
>  static struct file_system_type btrfs_root_fs_type = {
> @@ -2152,7 +2152,8 @@ static struct file_system_type btrfs_root_fs_type = {
>  	.name		= "btrfs",
>  	.mount		= btrfs_mount_root,
>  	.kill_sb	= btrfs_kill_super,
> -	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
> +	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
> +			  FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  
>  MODULE_ALIAS_FS("btrfs");
> 
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
