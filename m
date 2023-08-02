Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3776D73A
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 20:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1691002495;
	bh=LM5dlnWT81GTwNGuf8M3+0tmWSk26IjSyG3XZJNlGxg=;
	h=To:Subject:In-Reply-To:References:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Gq5+zFRHLAxJaKKxtk7lrsAe0+RuSFm4GxfRilWouAyhgTpIvuYk9BeyTDSPF95hy
	 /0WLNlsnysOwIbQ8OeUeYq5Zjk1rq7iGTJxidHF796Ol2f4SdBwH3FPzj92+Px1TFm
	 Sfb/c0LiIDOrjlpNBMUdRwpFPQYU5burRf2D8DRNzwLoOexjlw4RkRKndclErNz8KG
	 2oKH9rLAyA0lRGNXM+fHdDaboZXHOqXBEtHqxQyH9IkB/A0fxqPwmV72R1hjoYolQL
	 fUphdDa6E5YyKwbJLgPCGDLv80GklT3jVjKyG209IqGqeuNQ+W8cx6l1Pk8hRIgOVo
	 M6FyX/J59rAjA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGLkl01pxz3bmj
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Aug 2023 04:54:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=manguebit.com header.i=@manguebit.com header.a=rsa-sha256 header.s=dkim header.b=q+WFWoVw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=manguebit.com (client-ip=2a01:4f8:1c1e:a2ae::2; helo=mx.manguebit.com; envelope-from=pc@manguebit.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 397 seconds by postgrey-1.37 at boromir; Thu, 03 Aug 2023 04:54:49 AEST
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGLkd0L7qz30gF
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Aug 2023 04:54:49 +1000 (AEST)
Message-ID: <471c346601a7daace902428e56b8579b.pc@manguebit.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1691002083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LM5dlnWT81GTwNGuf8M3+0tmWSk26IjSyG3XZJNlGxg=;
	b=AoW9sil2tg15RxkemetVcD0MQH7aqHOPx9s45t6q2mXk4iNoevRltavPuQhHJickRN06JC
	9twitSFZovdSmN54RsIMwcP9LbHZ1K86aCiRYdAMGoHCsXm0u0QTFFXXd8+eXqppmU9Kp1
	Q9pg/HXE5fSlbCGR+84Z036/rAjhvge6A7ij00bIpSGub9bNIOdCFcEgHSqmL5WMnIl1Uf
	VF0itzVid71/SBJv2BhC3GrS7WwIz1UW8ofISSDCmwhyuSGM2Z2MEfKyccU/HDsRsX7g/2
	qop6kKp78QWclngeoV7X+/F2IIcl/qVTZIg1Eck9BzyGSdE1iSwHxnOAmhWl8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1691002083; a=rsa-sha256;
	cv=none;
	b=cp3+mC0OMj7F40WMT7qUHuJDwt5m+4Y0ISygYXiZ4GOzzVuy+cXksXQTjexnbnoHqJnkLv
	A/Xh4iI5m54yLclEpvkUfV+Z5z+yl3bkiSW7DPqp7d3qf2mgApmdG2r6OnrC3HAVdpFkRR
	FGIzkra0rLP1oeUH2LzXYwCEn0h5f1JOcg5inVxvd5FI0X3iaV9zS9fxN8/uoNWsRSS8bg
	YveFBiSbZ9Cz5RuNQ9Dpsxd6wNh4r8y+aIu582+NYrL0UgzojRiCHbVTSN7csXMG8yKhXg
	YDPPznVWXhPSF0A8cu9cmJOJmS32KIv4mwdX1lo6pb8zpon7EJ1dEyaA13ArHw==
To: Jeff Layton <jlayton@kernel.org>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
 <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara
 <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos Szeredi
 <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas
 Gruenbacher <agruenba@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>, Steve French
 <sfrench@samba.org>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Richard Weinberger <richard@nod.at>, Hans de
 Goede <hdegoede@redhat.com>, Hugh Dickins <hughd@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
In-Reply-To: <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
Date: Wed, 02 Aug 2023 15:47:56 -0300
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
From: Paulo Alcantara via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Paulo Alcantara <pc@manguebit.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, devel@lists.orangefs.org, Anthony Iliopoulos <ailiop@suse.com>, ecryptfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> writes:

> generic_fillattr just fills in the entire stat struct indiscriminately
> today, copying data from the inode. There is at least one attribute
> (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> and we're looking at adding more with the addition of multigrain
> timestamps.
>
> Add a request_mask argument to generic_fillattr and have most callers
> just pass in the value that is passed to getattr. Have other callers
> (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> STATX_CHANGE_COOKIE into generic_fillattr.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/9p/vfs_inode.c       |  4 ++--
>  fs/9p/vfs_inode_dotl.c  |  4 ++--
>  fs/afs/inode.c          |  2 +-
>  fs/btrfs/inode.c        |  2 +-
>  fs/ceph/inode.c         |  2 +-
>  fs/coda/inode.c         |  3 ++-
>  fs/ecryptfs/inode.c     |  5 +++--
>  fs/erofs/inode.c        |  2 +-
>  fs/exfat/file.c         |  2 +-
>  fs/ext2/inode.c         |  2 +-
>  fs/ext4/inode.c         |  2 +-
>  fs/f2fs/file.c          |  2 +-
>  fs/fat/file.c           |  2 +-
>  fs/fuse/dir.c           |  2 +-
>  fs/gfs2/inode.c         |  2 +-
>  fs/hfsplus/inode.c      |  2 +-
>  fs/kernfs/inode.c       |  2 +-
>  fs/libfs.c              |  4 ++--
>  fs/minix/inode.c        |  2 +-
>  fs/nfs/inode.c          |  2 +-
>  fs/nfs/namespace.c      |  3 ++-
>  fs/ntfs3/file.c         |  2 +-
>  fs/ocfs2/file.c         |  2 +-
>  fs/orangefs/inode.c     |  2 +-
>  fs/proc/base.c          |  4 ++--
>  fs/proc/fd.c            |  2 +-
>  fs/proc/generic.c       |  2 +-
>  fs/proc/proc_net.c      |  2 +-
>  fs/proc/proc_sysctl.c   |  2 +-
>  fs/proc/root.c          |  3 ++-
>  fs/smb/client/inode.c   |  2 +-
>  fs/smb/server/smb2pdu.c | 22 +++++++++++-----------
>  fs/smb/server/vfs.c     |  3 ++-
>  fs/stat.c               | 18 ++++++++++--------
>  fs/sysv/itree.c         |  3 ++-
>  fs/ubifs/dir.c          |  2 +-
>  fs/udf/symlink.c        |  2 +-
>  fs/vboxsf/utils.c       |  2 +-
>  include/linux/fs.h      |  2 +-
>  mm/shmem.c              |  2 +-
>  40 files changed, 70 insertions(+), 62 deletions(-)
>
> [...]
>
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 218f03dd3f52..93fe43789d7a 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2540,7 +2540,7 @@ int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  			return rc;
>  	}
>  
> -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>  	stat->blksize = cifs_sb->ctx->bsize;
>  	stat->ino = CIFS_I(inode)->uniqueid;

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
