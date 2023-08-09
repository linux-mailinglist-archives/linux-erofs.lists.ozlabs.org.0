Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A1D7762D5
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Aug 2023 16:44:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLXrn51f5z2ywL
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 00:44:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=parknet.co.jp (client-ip=210.171.160.6; helo=mail.parknet.co.jp; envelope-from=hirofumi@parknet.co.jp; receiver=lists.ozlabs.org)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLXrg2xfxz2xgp
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 00:44:34 +1000 (AEST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 593222055FA0;
	Wed,  9 Aug 2023 23:44:33 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379EiWdd218003
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 9 Aug 2023 23:44:33 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379EiV6k197737
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 9 Aug 2023 23:44:31 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 379EiQ5o197730;
	Wed, 9 Aug 2023 23:44:26 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
In-Reply-To: <7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org> (Jeff
	Layton's message of "Wed, 09 Aug 2023 10:22:54 -0400")
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
	<20230807-mgctime-v7-5-d1dec143a704@kernel.org>
	<87msz08vc7.fsf@mail.parknet.co.jp>
	<52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
	<878rak8hia.fsf@mail.parknet.co.jp>
	<7edc9239f73022b9c2a1d3f4f946153f85f94739.camel@kernel.org>
Date: Wed, 09 Aug 2023 23:44:26 +0900
Message-ID: <874jl88ed1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.com>, Benjamin Coddington
  <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.d
 ev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> writes:

> I'm a little confused too. Why do you believe this will break
> -o relatime handling? This patch changes two things:
>
> 1/ it has fat_update_time fetch its own timestamp (and ignore the "now"
> parameter). This is in line with the changes in patch #3 of this series,
> which explains the rationale for this in more detail.
>
> 2/ it changes fat_update_time to also update the i_version if any of
> S_CTIME|S_MTIME|S_VERSION are set. relatime is all about the S_ATIME,
> and it is specifically excluded from that set.
>
> The rationale for the second change is is also in patch #3, but
> basically, we can't guarantee that current_time hasn't changed since we
> last checked for inode_needs_update_time, so if any of
> S_CTIME/S_MTIME/S_VERSION have changed, then we need to assume that any
> of them may need to be changed and attempt to update all 3.
>
> That said, I think the logic in fat_update_time isn't quite right. I
> think want something like this on top of this patch to ensure that the
> S_CTIME and S_MTIME get updated, even if the flags only have S_VERSION
> set.
>
> Thoughts?

I'm not talking about "relatime" at all, I'm always talking about
"lazytime".

I_DIRTY_TIME delays to update on disk inode only if changed
timestamp. But you changed it to I_DIRTY_SYNC, i.e. always update on
disk inode by timestamp.

Thanks.

> ---------------------8<-----------------------
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 080a5035483f..313eef02f45c 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -346,15 +346,21 @@ int fat_update_time(struct inode *inode, int flags)
>         if (inode->i_ino == MSDOS_ROOT_INO)
>                 return 0;
>  
> -       if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -               fat_truncate_time(inode, NULL, flags);
> -               if (inode->i_sb->s_flags & SB_LAZYTIME)
> -                       dirty_flags |= I_DIRTY_TIME;
> -               else
> -                       dirty_flags |= I_DIRTY_SYNC;
> -       }
> +       /*
> +        * If any of the flags indicate an expicit change to the file, then we
> +        * need to ensure that we attempt to update all of 3. We do not do
> +        * this in the case of an S_ATIME-only update.
> +        */
> +       if (flags & (S_CTIME | S_MTIME | S_VERSION))
> +               flags |= S_CTIME | S_MTIME | S_VERSION;
> +
> +       fat_truncate_time(inode, NULL, flags);
> +       if (inode->i_sb->s_flags & SB_LAZYTIME)
> +               dirty_flags |= I_DIRTY_TIME;
> +       else
> +               dirty_flags |= I_DIRTY_SYNC;
>  
> -       if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion(inode, false))
> +       if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
>                 dirty_flags |= I_DIRTY_SYNC;
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
