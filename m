Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A85776C51
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 00:38:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLlM64RG3z3bYx
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Aug 2023 08:38:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=parknet.co.jp (client-ip=210.171.160.6; helo=mail.parknet.co.jp; envelope-from=hirofumi@parknet.co.jp; receiver=lists.ozlabs.org)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RLlLy1YCmz30fV
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Aug 2023 08:38:01 +1000 (AEST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 3CD87205DB98;
	Thu, 10 Aug 2023 07:38:00 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379Mbwf6230731
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 07:38:00 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.17.2/8.17.2/Debian-1) with ESMTPS id 379MbwGI248785
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 07:37:58 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.17.2/8.17.2/Submit) id 379MbqTh248778;
	Thu, 10 Aug 2023 07:37:52 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
In-Reply-To: <e4cee2590f5cb9a13a8d4445e550e155d551670d.camel@kernel.org> (Jeff
	Layton's message of "Wed, 09 Aug 2023 18:07:29 -0400")
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
	<edf8e8ca3b38e56f30e0d24ac7293f848ffee371.camel@kernel.org>
	<87a5v06kij.fsf@mail.parknet.co.jp>
	<e4cee2590f5cb9a13a8d4445e550e155d551670d.camel@kernel.org>
Date: Thu, 10 Aug 2023 07:37:52 +0900
Message-ID: <87zg2z3kqn.fsf@mail.parknet.co.jp>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org, Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org, Hugh Dickins <hughd@google.
 com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, codalist@telemann.coda.cs.cmu.edu, Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-erofs@lists.ozlabs.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Frank Sorenson <sorenson@redhat.com>, Greg Kroah-Hart
 man <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> writes:

> If you do that then the i_version counter would never be incremented.
> But...I think I see what you're getting at.
>
> Most filesystems that support the i_version counter have an on-disk
> field for it. FAT obviously has no such thing. I suspect the i_version
> bits in fat_update_time were added by mistake. FAT doesn't set
> SB_I_VERSION so there's no need to do anything to the i_version field at
> all.
>
> Also, given that the mtime and ctime are always kept in sync on FAT,
> we're probably fine to have it look something like this:

Yes.

IIRC, when I wrote, I decided to make it keep similar with generic
function, instead of heavily customize for FAT (for maintenance
reason). It is why. There would be other places with same reason.

E.g. LAZYTIME check is same reason too. (current FAT doesn't support it)

So I personally I would prefer to leave it. But if you want to remove
it, it would be ok too.

Thanks.

> --------------------8<------------------
> int fat_update_time(struct inode *inode, int flags) 
> { 
>         int dirty_flags = 0;
>
>         if (inode->i_ino == MSDOS_ROOT_INO) 
>                 return 0;
>
>         fat_truncate_time(inode, NULL, flags);
>         if (inode->i_sb->s_flags & SB_LAZYTIME)
>                 dirty_flags |= I_DIRTY_TIME;
>         else
>                 dirty_flags |= I_DIRTY_SYNC;
>
>         __mark_inode_dirty(inode, dirty_flags);
>         return 0;
> } 
> --------------------8<------------------
>
> ...and we should probably do that in a separate patch in advance of the
> update_time rework, since it's really a different change.
>
> If you're in agreement, then I'll plan to respin the series with this
> fixed and resend.
>
> Thanks for being patient!
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
