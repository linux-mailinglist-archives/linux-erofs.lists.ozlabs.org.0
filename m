Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C99777A
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 12:45:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46D47D0QGpzDr2h
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 20:45:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566384312;
	bh=nynNIK55zcm/ZBeNLT5pJbYVtTeC0v1eOJ8QgDMwzUw=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ae3/buQPm4w4kUiP9x4aTcsrRCCjPyo0RkuLh72T+wofMEhkDG8RKXDcV9DvQK6x2
	 wOI7HI0Pxcb/k9VU+nbD4EZtIlgFZhrSAKDFHwSgaYt4j1Xz+5TxAeaCjMMJ4iJjNN
	 LyLxec+yBSMbohKto6Xhq3aqVM6s5UD1O+FD7MvDrvJ2doOFYtG09nEJz8ypkO4+CO
	 H76Fhtv5SMwsiWiCiZ+qGfRIYKjl1N3XluFyWZC9V1bVrsHBNeW386MLlWu64AmeJm
	 w8dbmid95MIUjLqRIXT8OqRos6hvq83Lv8V8sPA8V4GxTaeXJYccyGHK79Fz6nT7g6
	 w0VCXSufRxMSg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=salyzyn@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="oSqpzwl1"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4696nv6KLKzDrRq
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Aug 2019 01:34:52 +1000 (AEST)
Received: by mail-lj1-x244.google.com with SMTP id l14so5659884ljj.9
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sFDmvnIg34l9OYQkL855herqEvUCSPQiLiPYgKs7/QA=;
 b=oSqpzwl1XvNCmLufLUHe5DPdXqdMH7z/SPugYzl4UyvuHqK8XIwx3qK+zAUMdR02MF
 o7LPdQK4JpgfP/yvmRuuxdrzD/RryKxdVxrPjpHBktbBvNGwY6zDxVkunN/5wbX/IILa
 L9TpJqZf8VSvuP5WyFyf/k0BNGsIT3RT/asmRBLoLqHJZzTL/SGc+Gefi+PT9ydEZT4a
 3nqF3qZBg3qH2m6r99+Z3NCIXudEYM02IBsVGhb816uQR+fapktDOBW2W4MdIUJ6QIfB
 KH5jEixcQyMR6i5NN1op8ONN+1LlqtBZcSgsm/uj4tWo3phO8qC/gqpcJojqPOFTdlpn
 EFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sFDmvnIg34l9OYQkL855herqEvUCSPQiLiPYgKs7/QA=;
 b=K9ytzh/Z28VNmDeBC3ZOhzEudwlzaGv/FgZn5Xp2ggVkZmi2sCk9n5IziT4L7D15Zx
 fstLiUjorJ4ddCePqc+uPIZ8hsqK+xzbFKtPkLvQyvF1IXa6zQXTbRFOe8ZS+8nRKlrR
 yoqXLHK7QDxo8gZnxU8EB9Fn5eN9e7WDlL6pDp32El3o5/ZkQnqfbtsnbRrePmlsOZ/J
 xK2rIvJWIP65eKqV/21xkFuGjnoVl8WWV5mYGPbKNMGnpZdERzZgojKVpGyP/cox2mVh
 d1/R5fSMDu+2roIxiKrVSnA7+1Av02AU0y0iOgrVCrGaqpPiFaJDkoRP2zfu4aymxmr4
 UQUw==
X-Gm-Message-State: APjAAAWggJfsrJvPDaP3+pcXe4A5mag94f9HNcrLAYCFcQNb6AGvNEDe
 Gr2lDOOOCgEuwgtBwqh5Nl796g8XTs8ucKrKa0K2wg==
X-Google-Smtp-Source: APXvYqxl19MXu+/6Ybirt0ZFeqtseIweGLOoOjqv7Kwg7aMHJ29uK0Ew9wsq7sbSXmFNPBc7eTNPFlEGC5/LByMB+B8=
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr5577005lja.163.1565969686146; 
 Fri, 16 Aug 2019 08:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190815155019.229988-1-salyzyn@android.com>
 <20190816151111.GC3041@quack2.suse.cz>
In-Reply-To: <20190816151111.GC3041@quack2.suse.cz>
Date: Fri, 16 Aug 2019 08:34:33 -0700
Message-ID: <CAMx4XWt-0jvAuJvofNXnc2DzYYF0xac=THLCADe5ZA0RstrfmA@mail.gmail.com>
Subject: Re: [PATCH v4] Add flags option to get xattr method paired to
 __vfs_getxattr
To: Jan Kara <jack@suse.cz>
Content-Type: multipart/alternative; boundary="000000000000df9f7505903dba31"
X-Mailman-Approved-At: Wed, 21 Aug 2019 20:45:04 +1000
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
From: Mark Salyzyn via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Mark Salyzyn <salyzyn@google.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Dave Kleikamp <shaggy@kernel.org>,
 jfs-discussion@lists.sourceforge.net, linux-integrity@vger.kernel.org,
 Martin Brandenburg <martin@omnibond.com>, samba-technical@lists.samba.org,
 Dominique Martinet <asmadeus@codewreck.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>,
 Chris Mason <clm@fb.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Eric Paris <eparis@parisplace.org>,
 netdev@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
 linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>,
 devel@driverdev.osuosl.org, linux-xfs@vger.kernel.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>,
 Mark Fasheh <mark@fasheh.com>, linux-unionfs@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>,
 cluster-devel@redhat.com, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Vyacheslav Dubeyko <slava@dubeyko.com>,
 Casey Schaufler <casey@schaufler-ca.com>, v9fs-developer@lists.sourceforge.net,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 Android Kernel Team <kernel-team@android.com>, linux-mm@kvack.org,
 devel@lists.orangefs.org, Serge Hallyn <serge@hallyn.com>,
 =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>,
 linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@gmail.com>,
 ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Josef Bacik <josef@toxicpanda.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, reiserfs-devel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Joel Becker <jlbec@evilplan.org>,
 linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 selinux@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>,
 linux-fsdevel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Artem Bityutskiy <dedekind1@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
 Steve French <sfrench@samba.org>, linux-security-module@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, Jan Kara <jack@suse.com>,
 Bob Peterson <rpeterso@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Anna Schumaker <anna.schumaker@netapp.com>, linux-btrfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000df9f7505903dba31
Content-Type: text/plain; charset="UTF-8"

I will redo the manual audit, perhaps I need to not be so scared of
allconfig build ;-} (currently my runtime & buildtime test platform is
android 4.19 kernel, my bad).

I am going through and exploring/changing/testing everything to deal with
GregKH/jmorris wanting a single xattr_gs_args structure reference where the
flags argument is stowed, rather than YA adding a flags argument. It is
doubling the (mechanical) codebase impact but decreases the future
maintenance and _large_ set of stakeholders (+75 at last count).

-- Mark

On Fri, Aug 16, 2019 at 8:11 AM Jan Kara <jack@suse.cz> wrote:

> On Thu 15-08-19 08:49:58, Mark Salyzyn wrote:
> > Add a flag option to get xattr method that could have a bit flag of
> > XATTR_NOSECURITY passed to it.  XATTR_NOSECURITY is generally then
> > set in the __vfs_getxattr path.
> >
> > This handles the case of a union filesystem driver that is being
> > requested by the security layer to report back the xattr data.
> >
> > For the use case where access is to be blocked by the security layer.
> >
> > The path then could be security(dentry) ->
> > __vfs_getxattr(dentry...XATTR_NOSECUIRTY) ->
> > handler->get(dentry...XATTR_NOSECURITY) ->
> > __vfs_getxattr(lower_dentry...XATTR_NOSECUIRTY) ->
> > lower_handler->get(lower_dentry...XATTR_NOSECUIRTY)
> > which would report back through the chain data and success as
> > expected, the logging security layer at the top would have the
> > data to determine the access permissions and report back the target
> > context that was blocked.
> >
> > Without the get handler flag, the path on a union filesystem would be
> > the errant security(dentry) -> __vfs_getxattr(dentry) ->
> > handler->get(dentry) -> vfs_getxattr(lower_dentry) -> nested ->
> > security(lower_dentry, log off) -> lower_handler->get(lower_dentry)
> > which would report back through the chain no data, and -EACCES.
> >
> > For selinux for both cases, this would translate to a correctly
> > determined blocked access. In the first case with this change a correct
> avc
> > log would be reported, in the second legacy case an incorrect avc log
> > would be reported against an uninitialized u:object_r:unlabeled:s0
> > context making the logs cosmetically useless for audit2allow.
> >
> > This patch series is inert and is the wide-spread addition of the
> > flags option for xattr functions, and a replacement of _vfs_getxattr
> > with __vfs_getxattr(...XATTR_NOSECURITY).
> >
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kernel-team@android.com
> > Cc: linux-security-module@vger.kernel.org
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: stable@vger.kernel.org # 4.4, 4.9, 4.14 & 4.19
>
> The patch looks good to me. I can see you've missed conversion of one place
> in ext2 which 0-day spotted so that will need fixing. Otherwise feel free
> to add:
>
> Acked-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
> > ---
> > v4:
> > - ifdef __KERNEL__ around XATTR_NOSECURITY to
> >   keep it colocated in uapi headers.
> >
> > v3:
> > - poor aim on ubifs not ubifs_xattr_get, but static xattr_get
> >
> > v2:
> > - Missed a spot: ubifs, erofs and afs.
> >
> > v1:
> > - Removed from an overlayfs patch set, and made independent.
> >   Expect this to be the basis of some security improvements.
> > ---
> >  drivers/staging/erofs/xattr.c     |  3 ++-
> >  fs/9p/acl.c                       |  3 ++-
> >  fs/9p/xattr.c                     |  3 ++-
> >  fs/afs/xattr.c                    |  8 +++----
> >  fs/btrfs/xattr.c                  |  3 ++-
> >  fs/ceph/xattr.c                   |  3 ++-
> >  fs/cifs/xattr.c                   |  2 +-
> >  fs/ecryptfs/inode.c               |  6 ++++--
> >  fs/ecryptfs/mmap.c                |  2 +-
> >  fs/ext2/xattr_trusted.c           |  2 +-
> >  fs/ext2/xattr_user.c              |  2 +-
> >  fs/ext4/xattr_security.c          |  2 +-
> >  fs/ext4/xattr_trusted.c           |  2 +-
> >  fs/ext4/xattr_user.c              |  2 +-
> >  fs/f2fs/xattr.c                   |  4 ++--
> >  fs/fuse/xattr.c                   |  4 ++--
> >  fs/gfs2/xattr.c                   |  3 ++-
> >  fs/hfs/attr.c                     |  2 +-
> >  fs/hfsplus/xattr.c                |  3 ++-
> >  fs/hfsplus/xattr_trusted.c        |  3 ++-
> >  fs/hfsplus/xattr_user.c           |  3 ++-
> >  fs/jffs2/security.c               |  3 ++-
> >  fs/jffs2/xattr_trusted.c          |  3 ++-
> >  fs/jffs2/xattr_user.c             |  3 ++-
> >  fs/jfs/xattr.c                    |  5 +++--
> >  fs/kernfs/inode.c                 |  3 ++-
> >  fs/nfs/nfs4proc.c                 |  6 ++++--
> >  fs/ocfs2/xattr.c                  |  9 +++++---
> >  fs/orangefs/xattr.c               |  3 ++-
> >  fs/overlayfs/super.c              |  8 ++++---
> >  fs/posix_acl.c                    |  2 +-
> >  fs/reiserfs/xattr_security.c      |  3 ++-
> >  fs/reiserfs/xattr_trusted.c       |  3 ++-
> >  fs/reiserfs/xattr_user.c          |  3 ++-
> >  fs/squashfs/xattr.c               |  2 +-
> >  fs/ubifs/xattr.c                  |  3 ++-
> >  fs/xattr.c                        | 36 +++++++++++++++----------------
> >  fs/xfs/xfs_xattr.c                |  3 ++-
> >  include/linux/xattr.h             |  9 ++++----
> >  include/uapi/linux/xattr.h        |  7 ++++--
> >  mm/shmem.c                        |  3 ++-
> >  net/socket.c                      |  3 ++-
> >  security/commoncap.c              |  6 ++++--
> >  security/integrity/evm/evm_main.c |  3 ++-
> >  security/selinux/hooks.c          | 11 ++++++----
> >  security/smack/smack_lsm.c        |  5 +++--
> >  46 files changed, 126 insertions(+), 84 deletions(-)
> >
> > diff --git a/drivers/staging/erofs/xattr.c
> b/drivers/staging/erofs/xattr.c
> > index df40654b9fbb..69440065432c 100644
> > --- a/drivers/staging/erofs/xattr.c
> > +++ b/drivers/staging/erofs/xattr.c
> > @@ -463,7 +463,8 @@ int erofs_getxattr(struct inode *inode, int index,
> >
> >  static int erofs_xattr_generic_get(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *name, void *buffer, size_t
> size)
> > +                                const char *name, void *buffer, size_t
> size,
> > +                                int flags)
> >  {
> >       struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> >
> > diff --git a/fs/9p/acl.c b/fs/9p/acl.c
> > index 6261719f6f2a..cb14e8b312bc 100644
> > --- a/fs/9p/acl.c
> > +++ b/fs/9p/acl.c
> > @@ -214,7 +214,8 @@ int v9fs_acl_mode(struct inode *dir, umode_t *modep,
> >
> >  static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
> >                             struct dentry *dentry, struct inode *inode,
> > -                           const char *name, void *buffer, size_t size)
> > +                           const char *name, void *buffer, size_t size,
> > +                           int flags)
> >  {
> >       struct v9fs_session_info *v9ses;
> >       struct posix_acl *acl;
> > diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> > index ac8ff8ca4c11..5cfa772452fd 100644
> > --- a/fs/9p/xattr.c
> > +++ b/fs/9p/xattr.c
> > @@ -139,7 +139,8 @@ ssize_t v9fs_listxattr(struct dentry *dentry, char
> *buffer, size_t buffer_size)
> >
> >  static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
> >                                 struct dentry *dentry, struct inode
> *inode,
> > -                               const char *name, void *buffer, size_t
> size)
> > +                               const char *name, void *buffer, size_t
> size,
> > +                               int flags)
> >  {
> >       const char *full_name = xattr_full_name(handler, name);
> >
> > diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
> > index 5552d034090a..7e2d97653f5a 100644
> > --- a/fs/afs/xattr.c
> > +++ b/fs/afs/xattr.c
> > @@ -163,7 +163,7 @@ static const struct xattr_handler
> afs_xattr_afs_acl_handler = {
> >  static int afs_xattr_get_yfs(const struct xattr_handler *handler,
> >                            struct dentry *dentry,
> >                            struct inode *inode, const char *name,
> > -                          void *buffer, size_t size)
> > +                          void *buffer, size_t size, int flags)
> >  {
> >       struct afs_fs_cursor fc;
> >       struct afs_status_cb *scb;
> > @@ -334,7 +334,7 @@ static const struct xattr_handler
> afs_xattr_yfs_handler = {
> >  static int afs_xattr_get_cell(const struct xattr_handler *handler,
> >                             struct dentry *dentry,
> >                             struct inode *inode, const char *name,
> > -                           void *buffer, size_t size)
> > +                           void *buffer, size_t size, int flags)
> >  {
> >       struct afs_vnode *vnode = AFS_FS_I(inode);
> >       struct afs_cell *cell = vnode->volume->cell;
> > @@ -361,7 +361,7 @@ static const struct xattr_handler
> afs_xattr_afs_cell_handler = {
> >  static int afs_xattr_get_fid(const struct xattr_handler *handler,
> >                            struct dentry *dentry,
> >                            struct inode *inode, const char *name,
> > -                          void *buffer, size_t size)
> > +                          void *buffer, size_t size, int flags)
> >  {
> >       struct afs_vnode *vnode = AFS_FS_I(inode);
> >       char text[16 + 1 + 24 + 1 + 8 + 1];
> > @@ -397,7 +397,7 @@ static const struct xattr_handler
> afs_xattr_afs_fid_handler = {
> >  static int afs_xattr_get_volume(const struct xattr_handler *handler,
> >                             struct dentry *dentry,
> >                             struct inode *inode, const char *name,
> > -                           void *buffer, size_t size)
> > +                           void *buffer, size_t size, int flags)
> >  {
> >       struct afs_vnode *vnode = AFS_FS_I(inode);
> >       const char *volname = vnode->volume->name;
> > diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> > index 95d9aebff2c4..1e522e145344 100644
> > --- a/fs/btrfs/xattr.c
> > +++ b/fs/btrfs/xattr.c
> > @@ -353,7 +353,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char
> *buffer, size_t size)
> >
> >  static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *name, void *buffer, size_t
> size)
> > +                                const char *name, void *buffer, size_t
> size,
> > +                                int flags)
> >  {
> >       name = xattr_full_name(handler, name);
> >       return btrfs_getxattr(inode, name, buffer, size);
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 37b458a9af3a..edb7eb9ae83e 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -1171,7 +1171,8 @@ int __ceph_setxattr(struct inode *inode, const
> char *name,
> >
> >  static int ceph_get_xattr_handler(const struct xattr_handler *handler,
> >                                 struct dentry *dentry, struct inode
> *inode,
> > -                               const char *name, void *value, size_t
> size)
> > +                               const char *name, void *value, size_t
> size,
> > +                               int flags)
> >  {
> >       if (!ceph_is_valid_xattr(name))
> >               return -EOPNOTSUPP;
> > diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
> > index 9076150758d8..7f71c06ce631 100644
> > --- a/fs/cifs/xattr.c
> > +++ b/fs/cifs/xattr.c
> > @@ -199,7 +199,7 @@ static int cifs_creation_time_get(struct dentry
> *dentry, struct inode *inode,
> >
> >  static int cifs_xattr_get(const struct xattr_handler *handler,
> >                         struct dentry *dentry, struct inode *inode,
> > -                       const char *name, void *value, size_t size)
> > +                       const char *name, void *value, size_t size, int
> flags)
> >  {
> >       ssize_t rc = -EOPNOTSUPP;
> >       unsigned int xid;
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index 18426f4855f1..c710c7533729 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -1018,7 +1018,8 @@ ecryptfs_getxattr_lower(struct dentry
> *lower_dentry, struct inode *lower_inode,
> >               goto out;
> >       }
> >       inode_lock(lower_inode);
> > -     rc = __vfs_getxattr(lower_dentry, lower_inode, name, value, size);
> > +     rc = __vfs_getxattr(lower_dentry, lower_inode, name, value, size,
> > +                         XATTR_NOSECURITY);
> >       inode_unlock(lower_inode);
> >  out:
> >       return rc;
> > @@ -1103,7 +1104,8 @@ const struct inode_operations ecryptfs_main_iops =
> {
> >
> >  static int ecryptfs_xattr_get(const struct xattr_handler *handler,
> >                             struct dentry *dentry, struct inode *inode,
> > -                           const char *name, void *buffer, size_t size)
> > +                           const char *name, void *buffer, size_t size,
> > +                           int flags)
> >  {
> >       return ecryptfs_getxattr(dentry, inode, name, buffer, size);
> >  }
> > diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
> > index cffa0c1ec829..2362be3e3b4d 100644
> > --- a/fs/ecryptfs/mmap.c
> > +++ b/fs/ecryptfs/mmap.c
> > @@ -422,7 +422,7 @@ static int ecryptfs_write_inode_size_to_xattr(struct
> inode *ecryptfs_inode)
> >       }
> >       inode_lock(lower_inode);
> >       size = __vfs_getxattr(lower_dentry, lower_inode,
> ECRYPTFS_XATTR_NAME,
> > -                           xattr_virt, PAGE_SIZE);
> > +                           xattr_virt, PAGE_SIZE, XATTR_NOSECURITY);
> >       if (size < 0)
> >               size = 8;
> >       put_unaligned_be64(i_size_read(ecryptfs_inode), xattr_virt);
> > diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
> > index 49add1107850..8d313664f0fa 100644
> > --- a/fs/ext2/xattr_trusted.c
> > +++ b/fs/ext2/xattr_trusted.c
> > @@ -18,7 +18,7 @@ ext2_xattr_trusted_list(struct dentry *dentry)
> >  static int
> >  ext2_xattr_trusted_get(const struct xattr_handler *handler,
> >                      struct dentry *unused, struct inode *inode,
> > -                    const char *name, void *buffer, size_t size)
> > +                    const char *name, void *buffer, size_t size, int
> flags)
> >  {
> >       return ext2_xattr_get(inode, EXT2_XATTR_INDEX_TRUSTED, name,
> >                             buffer, size);
> > diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
> > index c243a3b4d69d..712b7c95cc64 100644
> > --- a/fs/ext2/xattr_user.c
> > +++ b/fs/ext2/xattr_user.c
> > @@ -20,7 +20,7 @@ ext2_xattr_user_list(struct dentry *dentry)
> >  static int
> >  ext2_xattr_user_get(const struct xattr_handler *handler,
> >                   struct dentry *unused, struct inode *inode,
> > -                 const char *name, void *buffer, size_t size)
> > +                 const char *name, void *buffer, size_t size, int flags)
> >  {
> >       if (!test_opt(inode->i_sb, XATTR_USER))
> >               return -EOPNOTSUPP;
> > diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
> > index 197a9d8a15ef..50fb71393fb6 100644
> > --- a/fs/ext4/xattr_security.c
> > +++ b/fs/ext4/xattr_security.c
> > @@ -15,7 +15,7 @@
> >  static int
> >  ext4_xattr_security_get(const struct xattr_handler *handler,
> >                       struct dentry *unused, struct inode *inode,
> > -                     const char *name, void *buffer, size_t size)
> > +                     const char *name, void *buffer, size_t size, int
> flags)
> >  {
> >       return ext4_xattr_get(inode, EXT4_XATTR_INDEX_SECURITY,
> >                             name, buffer, size);
> > diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
> > index e9389e5d75c3..64bd8f86c1f1 100644
> > --- a/fs/ext4/xattr_trusted.c
> > +++ b/fs/ext4/xattr_trusted.c
> > @@ -22,7 +22,7 @@ ext4_xattr_trusted_list(struct dentry *dentry)
> >  static int
> >  ext4_xattr_trusted_get(const struct xattr_handler *handler,
> >                      struct dentry *unused, struct inode *inode,
> > -                    const char *name, void *buffer, size_t size)
> > +                    const char *name, void *buffer, size_t size, int
> flags)
> >  {
> >       return ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
> >                             name, buffer, size);
> > diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
> > index d4546184b34b..b7301373820e 100644
> > --- a/fs/ext4/xattr_user.c
> > +++ b/fs/ext4/xattr_user.c
> > @@ -21,7 +21,7 @@ ext4_xattr_user_list(struct dentry *dentry)
> >  static int
> >  ext4_xattr_user_get(const struct xattr_handler *handler,
> >                   struct dentry *unused, struct inode *inode,
> > -                 const char *name, void *buffer, size_t size)
> > +                 const char *name, void *buffer, size_t size, int flags)
> >  {
> >       if (!test_opt(inode->i_sb, XATTR_USER))
> >               return -EOPNOTSUPP;
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> > index b32c45621679..76559da8dfba 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -24,7 +24,7 @@
> >
> >  static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
> >               struct dentry *unused, struct inode *inode,
> > -             const char *name, void *buffer, size_t size)
> > +             const char *name, void *buffer, size_t size, int flags)
> >  {
> >       struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> >
> > @@ -79,7 +79,7 @@ static bool f2fs_xattr_trusted_list(struct dentry
> *dentry)
> >
> >  static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
> >               struct dentry *unused, struct inode *inode,
> > -             const char *name, void *buffer, size_t size)
> > +             const char *name, void *buffer, size_t size, int flags)
> >  {
> >       if (buffer)
> >               *((char *)buffer) = F2FS_I(inode)->i_advise;
> > diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
> > index 433717640f78..d1ef7808304e 100644
> > --- a/fs/fuse/xattr.c
> > +++ b/fs/fuse/xattr.c
> > @@ -176,7 +176,7 @@ int fuse_removexattr(struct inode *inode, const char
> *name)
> >
> >  static int fuse_xattr_get(const struct xattr_handler *handler,
> >                        struct dentry *dentry, struct inode *inode,
> > -                      const char *name, void *value, size_t size)
> > +                      const char *name, void *value, size_t size, int
> flags)
> >  {
> >       return fuse_getxattr(inode, name, value, size);
> >  }
> > @@ -199,7 +199,7 @@ static bool no_xattr_list(struct dentry *dentry)
> >
> >  static int no_xattr_get(const struct xattr_handler *handler,
> >                       struct dentry *dentry, struct inode *inode,
> > -                     const char *name, void *value, size_t size)
> > +                     const char *name, void *value, size_t size, int
> flags)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
> > index bbe593d16bea..a9db067a99c1 100644
> > --- a/fs/gfs2/xattr.c
> > +++ b/fs/gfs2/xattr.c
> > @@ -588,7 +588,8 @@ static int __gfs2_xattr_get(struct inode *inode,
> const char *name,
> >
> >  static int gfs2_xattr_get(const struct xattr_handler *handler,
> >                         struct dentry *unused, struct inode *inode,
> > -                       const char *name, void *buffer, size_t size)
> > +                       const char *name, void *buffer, size_t size,
> > +                       int flags)
> >  {
> >       struct gfs2_inode *ip = GFS2_I(inode);
> >       struct gfs2_holder gh;
> > diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
> > index 74fa62643136..08222a9c5d31 100644
> > --- a/fs/hfs/attr.c
> > +++ b/fs/hfs/attr.c
> > @@ -115,7 +115,7 @@ static ssize_t __hfs_getxattr(struct inode *inode,
> enum hfs_xattr_type type,
> >
> >  static int hfs_xattr_get(const struct xattr_handler *handler,
> >                        struct dentry *unused, struct inode *inode,
> > -                      const char *name, void *value, size_t size)
> > +                      const char *name, void *value, size_t size, int
> flags)
> >  {
> >       return __hfs_getxattr(inode, handler->flags, value, size);
> >  }
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index bb0b27d88e50..381c2aaedbc8 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -839,7 +839,8 @@ static int hfsplus_removexattr(struct inode *inode,
> const char *name)
> >
> >  static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
> >                               struct dentry *unused, struct inode *inode,
> > -                             const char *name, void *buffer, size_t
> size)
> > +                             const char *name, void *buffer, size_t
> size,
> > +                             int flags)
> >  {
> >       /*
> >        * Don't allow retrieving properly prefixed attributes
> > diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
> > index fbad91e1dada..54d926314f8c 100644
> > --- a/fs/hfsplus/xattr_trusted.c
> > +++ b/fs/hfsplus/xattr_trusted.c
> > @@ -14,7 +14,8 @@
> >
> >  static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
> >                                   struct dentry *unused, struct inode
> *inode,
> > -                                 const char *name, void *buffer, size_t
> size)
> > +                                 const char *name, void *buffer,
> > +                                 size_t size, int flags)
> >  {
> >       return hfsplus_getxattr(inode, name, buffer, size,
> >                               XATTR_TRUSTED_PREFIX,
> > diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
> > index 74d19faf255e..4d2b1ffff887 100644
> > --- a/fs/hfsplus/xattr_user.c
> > +++ b/fs/hfsplus/xattr_user.c
> > @@ -14,7 +14,8 @@
> >
> >  static int hfsplus_user_getxattr(const struct xattr_handler *handler,
> >                                struct dentry *unused, struct inode
> *inode,
> > -                              const char *name, void *buffer, size_t
> size)
> > +                              const char *name, void *buffer, size_t
> size,
> > +                              int flags)
> >  {
> >
> >       return hfsplus_getxattr(inode, name, buffer, size,
> > diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
> > index c2332e30f218..e6f42fe435af 100644
> > --- a/fs/jffs2/security.c
> > +++ b/fs/jffs2/security.c
> > @@ -50,7 +50,8 @@ int jffs2_init_security(struct inode *inode, struct
> inode *dir,
> >  /* ---- XATTR Handler for "security.*" ----------------- */
> >  static int jffs2_security_getxattr(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *name, void *buffer, size_t
> size)
> > +                                const char *name, void *buffer, size_t
> size,
> > +                                int flags)
> >  {
> >       return do_jffs2_getxattr(inode, JFFS2_XPREFIX_SECURITY,
> >                                name, buffer, size);
> > diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
> > index 5d6030826c52..9dccaae549f5 100644
> > --- a/fs/jffs2/xattr_trusted.c
> > +++ b/fs/jffs2/xattr_trusted.c
> > @@ -18,7 +18,8 @@
> >
> >  static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
> >                                 struct dentry *unused, struct inode
> *inode,
> > -                               const char *name, void *buffer, size_t
> size)
> > +                               const char *name, void *buffer, size_t
> size,
> > +                               int flags)
> >  {
> >       return do_jffs2_getxattr(inode, JFFS2_XPREFIX_TRUSTED,
> >                                name, buffer, size);
> > diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
> > index 9d027b4abcf9..c0983a3e810b 100644
> > --- a/fs/jffs2/xattr_user.c
> > +++ b/fs/jffs2/xattr_user.c
> > @@ -18,7 +18,8 @@
> >
> >  static int jffs2_user_getxattr(const struct xattr_handler *handler,
> >                              struct dentry *unused, struct inode *inode,
> > -                            const char *name, void *buffer, size_t size)
> > +                            const char *name, void *buffer, size_t size,
> > +                            int flags)
> >  {
> >       return do_jffs2_getxattr(inode, JFFS2_XPREFIX_USER,
> >                                name, buffer, size);
> > diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> > index db41e7803163..5c79a35bf62f 100644
> > --- a/fs/jfs/xattr.c
> > +++ b/fs/jfs/xattr.c
> > @@ -925,7 +925,7 @@ static int __jfs_xattr_set(struct inode *inode,
> const char *name,
> >
> >  static int jfs_xattr_get(const struct xattr_handler *handler,
> >                        struct dentry *unused, struct inode *inode,
> > -                      const char *name, void *value, size_t size)
> > +                      const char *name, void *value, size_t size, int
> flags)
> >  {
> >       name = xattr_full_name(handler, name);
> >       return __jfs_getxattr(inode, name, value, size);
> > @@ -942,7 +942,8 @@ static int jfs_xattr_set(const struct xattr_handler
> *handler,
> >
> >  static int jfs_xattr_get_os2(const struct xattr_handler *handler,
> >                            struct dentry *unused, struct inode *inode,
> > -                          const char *name, void *value, size_t size)
> > +                          const char *name, void *value, size_t size,
> > +                          int flags)
> >  {
> >       if (is_known_namespace(name))
> >               return -EOPNOTSUPP;
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index f3f3984cce80..89db24ce644e 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -309,7 +309,8 @@ int kernfs_xattr_set(struct kernfs_node *kn, const
> char *name,
> >
> >  static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
> >                               struct dentry *unused, struct inode *inode,
> > -                             const char *suffix, void *value, size_t
> size)
> > +                             const char *suffix, void *value, size_t
> size,
> > +                             int flags)
> >  {
> >       const char *name = xattr_full_name(handler, suffix);
> >       struct kernfs_node *kn = inode->i_private;
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 1406858bae6c..1905597f86fb 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -7218,7 +7218,8 @@ static int nfs4_xattr_set_nfs4_acl(const struct
> xattr_handler *handler,
> >
> >  static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *key, void *buf, size_t
> buflen)
> > +                                const char *key, void *buf, size_t
> buflen,
> > +                                int flags)
> >  {
> >       return nfs4_proc_get_acl(inode, buf, buflen);
> >  }
> > @@ -7243,7 +7244,8 @@ static int nfs4_xattr_set_nfs4_label(const struct
> xattr_handler *handler,
> >
> >  static int nfs4_xattr_get_nfs4_label(const struct xattr_handler
> *handler,
> >                                    struct dentry *unused, struct inode
> *inode,
> > -                                  const char *key, void *buf, size_t
> buflen)
> > +                                  const char *key, void *buf, size_t
> buflen,
> > +                                  int flags)
> >  {
> >       if (security_ismaclabel(key))
> >               return nfs4_get_security_label(inode, buf, buflen);
> > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > index 90c830e3758e..525835807c86 100644
> > --- a/fs/ocfs2/xattr.c
> > +++ b/fs/ocfs2/xattr.c
> > @@ -7242,7 +7242,8 @@ int ocfs2_init_security_and_acl(struct inode *dir,
> >   */
> >  static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
> >                                   struct dentry *unused, struct inode
> *inode,
> > -                                 const char *name, void *buffer, size_t
> size)
> > +                                 const char *name, void *buffer, size_t
> size,
> > +                                 int flags)
> >  {
> >       return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_SECURITY,
> >                              name, buffer, size);
> > @@ -7314,7 +7315,8 @@ const struct xattr_handler
> ocfs2_xattr_security_handler = {
> >   */
> >  static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *name, void *buffer, size_t
> size)
> > +                                const char *name, void *buffer, size_t
> size,
> > +                                int flags)
> >  {
> >       return ocfs2_xattr_get(inode, OCFS2_XATTR_INDEX_TRUSTED,
> >                              name, buffer, size);
> > @@ -7340,7 +7342,8 @@ const struct xattr_handler
> ocfs2_xattr_trusted_handler = {
> >   */
> >  static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
> >                               struct dentry *unused, struct inode *inode,
> > -                             const char *name, void *buffer, size_t
> size)
> > +                             const char *name, void *buffer, size_t
> size,
> > +                             int flags)
> >  {
> >       struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
> >
> > diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
> > index bdc285aea360..ef4180bff7bb 100644
> > --- a/fs/orangefs/xattr.c
> > +++ b/fs/orangefs/xattr.c
> > @@ -541,7 +541,8 @@ static int orangefs_xattr_get_default(const struct
> xattr_handler *handler,
> >                                     struct inode *inode,
> >                                     const char *name,
> >                                     void *buffer,
> > -                                   size_t size)
> > +                                   size_t size,
> > +                                   int flags)
> >  {
> >       return orangefs_inode_getxattr(inode, name, buffer, size);
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index b368e2e102fa..a7b21f2ea2dd 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -854,7 +854,7 @@ static unsigned int ovl_split_lowerdirs(char *str)
> >  static int __maybe_unused
> >  ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
> >                       struct dentry *dentry, struct inode *inode,
> > -                     const char *name, void *buffer, size_t size)
> > +                     const char *name, void *buffer, size_t size, int
> flags)
> >  {
> >       return ovl_xattr_get(dentry, inode, handler->name, buffer, size);
> >  }
> > @@ -919,7 +919,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler
> *handler,
> >
> >  static int ovl_own_xattr_get(const struct xattr_handler *handler,
> >                            struct dentry *dentry, struct inode *inode,
> > -                          const char *name, void *buffer, size_t size)
> > +                          const char *name, void *buffer, size_t size,
> > +                          int flags)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > @@ -934,7 +935,8 @@ static int ovl_own_xattr_set(const struct
> xattr_handler *handler,
> >
> >  static int ovl_other_xattr_get(const struct xattr_handler *handler,
> >                              struct dentry *dentry, struct inode *inode,
> > -                            const char *name, void *buffer, size_t size)
> > +                            const char *name, void *buffer, size_t size,
> > +                            int flags)
> >  {
> >       return ovl_xattr_get(dentry, inode, name, buffer, size);
> >  }
> > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > index 84ad1c90d535..cd55621e570b 100644
> > --- a/fs/posix_acl.c
> > +++ b/fs/posix_acl.c
> > @@ -832,7 +832,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);
> >  static int
> >  posix_acl_xattr_get(const struct xattr_handler *handler,
> >                   struct dentry *unused, struct inode *inode,
> > -                 const char *name, void *value, size_t size)
> > +                 const char *name, void *value, size_t size, int flags)
> >  {
> >       struct posix_acl *acl;
> >       int error;
> > diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> > index 20be9a0e5870..eedfa07a4fd0 100644
> > --- a/fs/reiserfs/xattr_security.c
> > +++ b/fs/reiserfs/xattr_security.c
> > @@ -11,7 +11,8 @@
> >
> >  static int
> >  security_get(const struct xattr_handler *handler, struct dentry *unused,
> > -          struct inode *inode, const char *name, void *buffer, size_t
> size)
> > +          struct inode *inode, const char *name, void *buffer, size_t
> size,
> > +          int flags)
> >  {
> >       if (IS_PRIVATE(inode))
> >               return -EPERM;
> > diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
> > index 5ed48da3d02b..2d11d98605dd 100644
> > --- a/fs/reiserfs/xattr_trusted.c
> > +++ b/fs/reiserfs/xattr_trusted.c
> > @@ -10,7 +10,8 @@
> >
> >  static int
> >  trusted_get(const struct xattr_handler *handler, struct dentry *unused,
> > -         struct inode *inode, const char *name, void *buffer, size_t
> size)
> > +         struct inode *inode, const char *name, void *buffer, size_t
> size,
> > +         int flags)
> >  {
> >       if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(inode))
> >               return -EPERM;
> > diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
> > index a573ca45bacc..2a59d85c69c9 100644
> > --- a/fs/reiserfs/xattr_user.c
> > +++ b/fs/reiserfs/xattr_user.c
> > @@ -9,7 +9,8 @@
> >
> >  static int
> >  user_get(const struct xattr_handler *handler, struct dentry *unused,
> > -      struct inode *inode, const char *name, void *buffer, size_t size)
> > +      struct inode *inode, const char *name, void *buffer, size_t size,
> > +      int flags)
> >  {
> >       if (!reiserfs_xattrs_user(inode->i_sb))
> >               return -EOPNOTSUPP;
> > diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
> > index e1e3f3dd5a06..d8d58c990652 100644
> > --- a/fs/squashfs/xattr.c
> > +++ b/fs/squashfs/xattr.c
> > @@ -204,7 +204,7 @@ static int squashfs_xattr_handler_get(const struct
> xattr_handler *handler,
> >                                     struct dentry *unused,
> >                                     struct inode *inode,
> >                                     const char *name,
> > -                                   void *buffer, size_t size)
> > +                                   void *buffer, size_t size, int flags)
> >  {
> >       return squashfs_xattr_get(inode, handler->flags, name,
> >               buffer, size);
> > diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> > index 9aefbb60074f..26e1a74f178e 100644
> > --- a/fs/ubifs/xattr.c
> > +++ b/fs/ubifs/xattr.c
> > @@ -669,7 +669,8 @@ int ubifs_init_security(struct inode *dentry, struct
> inode *inode,
> >
> >  static int xattr_get(const struct xattr_handler *handler,
> >                          struct dentry *dentry, struct inode *inode,
> > -                        const char *name, void *buffer, size_t size)
> > +                        const char *name, void *buffer, size_t size,
> > +                        int flags)
> >  {
> >       dbg_gen("xattr '%s', ino %lu ('%pd'), buf size %zd", name,
> >               inode->i_ino, dentry, size);
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 90dd78f0eb27..71f887518d6f 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -281,7 +281,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const char
> *name, char **xattr_value,
> >               return PTR_ERR(handler);
> >       if (!handler->get)
> >               return -EOPNOTSUPP;
> > -     error = handler->get(handler, dentry, inode, name, NULL, 0);
> > +     error = handler->get(handler, dentry, inode, name, NULL, 0, 0);
> >       if (error < 0)
> >               return error;
> >
> > @@ -292,32 +292,20 @@ vfs_getxattr_alloc(struct dentry *dentry, const
> char *name, char **xattr_value,
> >               memset(value, 0, error + 1);
> >       }
> >
> > -     error = handler->get(handler, dentry, inode, name, value, error);
> > +     error = handler->get(handler, dentry, inode, name, value, error,
> 0);
> >       *xattr_value = value;
> >       return error;
> >  }
> >
> >  ssize_t
> >  __vfs_getxattr(struct dentry *dentry, struct inode *inode, const char
> *name,
> > -            void *value, size_t size)
> > +            void *value, size_t size, int flags)
> >  {
> >       const struct xattr_handler *handler;
> > -
> > -     handler = xattr_resolve_name(inode, &name);
> > -     if (IS_ERR(handler))
> > -             return PTR_ERR(handler);
> > -     if (!handler->get)
> > -             return -EOPNOTSUPP;
> > -     return handler->get(handler, dentry, inode, name, value, size);
> > -}
> > -EXPORT_SYMBOL(__vfs_getxattr);
> > -
> > -ssize_t
> > -vfs_getxattr(struct dentry *dentry, const char *name, void *value,
> size_t size)
> > -{
> > -     struct inode *inode = dentry->d_inode;
> >       int error;
> >
> > +     if (flags & XATTR_NOSECURITY)
> > +             goto nolsm;
> >       error = xattr_permission(inode, name, MAY_READ);
> >       if (error)
> >               return error;
> > @@ -339,7 +327,19 @@ vfs_getxattr(struct dentry *dentry, const char
> *name, void *value, size_t size)
> >               return ret;
> >       }
> >  nolsm:
> > -     return __vfs_getxattr(dentry, inode, name, value, size);
> > +     handler = xattr_resolve_name(inode, &name);
> > +     if (IS_ERR(handler))
> > +             return PTR_ERR(handler);
> > +     if (!handler->get)
> > +             return -EOPNOTSUPP;
> > +     return handler->get(handler, dentry, inode, name, value, size,
> flags);
> > +}
> > +EXPORT_SYMBOL(__vfs_getxattr);
> > +
> > +ssize_t
> > +vfs_getxattr(struct dentry *dentry, const char *name, void *value,
> size_t size)
> > +{
> > +     return __vfs_getxattr(dentry, dentry->d_inode, name, value, size,
> 0);
> >  }
> >  EXPORT_SYMBOL_GPL(vfs_getxattr);
> >
> > diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> > index 3123b5aaad2a..cafc99c48e20 100644
> > --- a/fs/xfs/xfs_xattr.c
> > +++ b/fs/xfs/xfs_xattr.c
> > @@ -18,7 +18,8 @@
> >
> >  static int
> >  xfs_xattr_get(const struct xattr_handler *handler, struct dentry
> *unused,
> > -             struct inode *inode, const char *name, void *value, size_t
> size)
> > +             struct inode *inode, const char *name, void *value, size_t
> size,
> > +             int flags)
> >  {
> >       int xflags = handler->flags;
> >       struct xfs_inode *ip = XFS_I(inode);
> > diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> > index 6dad031be3c2..4df9dcdc48c5 100644
> > --- a/include/linux/xattr.h
> > +++ b/include/linux/xattr.h
> > @@ -30,10 +30,10 @@ struct xattr_handler {
> >       const char *prefix;
> >       int flags;      /* fs private flags */
> >       bool (*list)(struct dentry *dentry);
> > -     int (*get)(const struct xattr_handler *, struct dentry *dentry,
> > +     int (*get)(const struct xattr_handler *handler, struct dentry
> *dentry,
> >                  struct inode *inode, const char *name, void *buffer,
> > -                size_t size);
> > -     int (*set)(const struct xattr_handler *, struct dentry *dentry,
> > +                size_t size, int flags);
> > +     int (*set)(const struct xattr_handler *handler, struct dentry
> *dentry,
> >                  struct inode *inode, const char *name, const void
> *buffer,
> >                  size_t size, int flags);
> >  };
> > @@ -46,7 +46,8 @@ struct xattr {
> >       size_t value_len;
> >  };
> >
> > -ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *,
> void *, size_t);
> > +ssize_t __vfs_getxattr(struct dentry *dentry, struct inode *inode,
> > +                    const char *name, void *buffer, size_t size, int
> flags);
> >  ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
> >  ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
> >  int __vfs_setxattr(struct dentry *, struct inode *, const char *, const
> void *, size_t, int);
> > diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> > index c1395b5bd432..1eba02616274 100644
> > --- a/include/uapi/linux/xattr.h
> > +++ b/include/uapi/linux/xattr.h
> > @@ -17,8 +17,11 @@
> >  #if __UAPI_DEF_XATTR
> >  #define __USE_KERNEL_XATTR_DEFS
> >
> > -#define XATTR_CREATE 0x1     /* set value, fail if attr already exists
> */
> > -#define XATTR_REPLACE        0x2     /* set value, fail if attr does
> not exist */
> > +#define XATTR_CREATE  0x1    /* set value, fail if attr already exists
> */
> > +#define XATTR_REPLACE         0x2    /* set value, fail if attr does
> not exist */
> > +#ifdef __KERNEL__ /* following is kernel internal, colocated for
> maintenance */
> > +#define XATTR_NOSECURITY 0x4 /* get value, do not involve security
> check */
> > +#endif
> >  #endif
> >
> >  /* Namespaces */
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 2bed4761f279..1013fcbd0a94 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -3206,7 +3206,8 @@ static int shmem_initxattrs(struct inode *inode,
> >
> >  static int shmem_xattr_handler_get(const struct xattr_handler *handler,
> >                                  struct dentry *unused, struct inode
> *inode,
> > -                                const char *name, void *buffer, size_t
> size)
> > +                                const char *name, void *buffer, size_t
> size,
> > +                                int flags)
> >  {
> >       struct shmem_inode_info *info = SHMEM_I(inode);
> >
> > diff --git a/net/socket.c b/net/socket.c
> > index 6a9ab7a8b1d2..6b0fea92dd02 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -300,7 +300,8 @@ static const struct dentry_operations
> sockfs_dentry_operations = {
> >
> >  static int sockfs_xattr_get(const struct xattr_handler *handler,
> >                           struct dentry *dentry, struct inode *inode,
> > -                         const char *suffix, void *value, size_t size)
> > +                         const char *suffix, void *value, size_t size,
> > +                         int flags)
> >  {
> >       if (value) {
> >               if (dentry->d_name.len + 1 > size)
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index f4ee0ae106b2..378a2f66a73d 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -297,7 +297,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)
> >       struct inode *inode = d_backing_inode(dentry);
> >       int error;
> >
> > -     error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > +     error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0,
> > +                            XATTR_NOSECURITY);
> >       return error > 0;
> >  }
> >
> > @@ -586,7 +587,8 @@ int get_vfs_caps_from_disk(const struct dentry
> *dentry, struct cpu_vfs_cap_data
> >
> >       fs_ns = inode->i_sb->s_user_ns;
> >       size = __vfs_getxattr((struct dentry *)dentry, inode,
> > -                           XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
> > +                           XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ,
> > +                           XATTR_NOSECURITY);
> >       if (size == -ENODATA || size == -EOPNOTSUPP)
> >               /* no data, that's ok */
> >               return -ENODATA;
> > diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> > index f9a81b187fae..921c8f2afcaf 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -100,7 +100,8 @@ static int evm_find_protected_xattrs(struct dentry
> *dentry)
> >               return -EOPNOTSUPP;
> >
> >       list_for_each_entry_rcu(xattr, &evm_config_xattrnames, list) {
> > -             error = __vfs_getxattr(dentry, inode, xattr->name, NULL,
> 0);
> > +             error = __vfs_getxattr(dentry, inode, xattr->name, NULL, 0,
> > +                                    XATTR_NOSECURITY);
> >               if (error < 0) {
> >                       if (error == -ENODATA)
> >                               continue;
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 74dd46de01b6..b0822da0658f 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -552,7 +552,8 @@ static int sb_finish_set_opts(struct super_block *sb)
> >                       goto out;
> >               }
> >
> > -             rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX,
> NULL, 0);
> > +             rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX,
> NULL,
> > +                                 0, XATTR_NOSECURITY);
> >               if (rc < 0 && rc != -ENODATA) {
> >                       if (rc == -EOPNOTSUPP)
> >                               pr_warn("SELinux: (dev %s, type "
> > @@ -1378,12 +1379,14 @@ static int inode_doinit_use_xattr(struct inode
> *inode, struct dentry *dentry,
> >               return -ENOMEM;
> >
> >       context[len] = '\0';
> > -     rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context,
> len);
> > +     rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX, context,
> len,
> > +                         XATTR_NOSECURITY);
> >       if (rc == -ERANGE) {
> >               kfree(context);
> >
> >               /* Need a larger buffer.  Query for the right size. */
> > -             rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> NULL, 0);
> > +             rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> NULL, 0,
> > +                                 XATTR_NOSECURITY);
> >               if (rc < 0)
> >                       return rc;
> >
> > @@ -1394,7 +1397,7 @@ static int inode_doinit_use_xattr(struct inode
> *inode, struct dentry *dentry,
> >
> >               context[len] = '\0';
> >               rc = __vfs_getxattr(dentry, inode, XATTR_NAME_SELINUX,
> > -                                 context, len);
> > +                                 context, len, XATTR_NOSECURITY);
> >       }
> >       if (rc < 0) {
> >               kfree(context);
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 4c5e5a438f8b..158b35772be1 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -292,7 +292,8 @@ static struct smack_known *smk_fetch(const char
> *name, struct inode *ip,
> >       if (buffer == NULL)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     rc = __vfs_getxattr(dp, ip, name, buffer, SMK_LONGLABEL);
> > +     rc = __vfs_getxattr(dp, ip, name, buffer, SMK_LONGLABEL,
> > +                         XATTR_NOSECURITY);
> >       if (rc < 0)
> >               skp = ERR_PTR(rc);
> >       else if (rc == 0)
> > @@ -3442,7 +3443,7 @@ static void smack_d_instantiate(struct dentry
> *opt_dentry, struct inode *inode)
> >                       } else {
> >                               rc = __vfs_getxattr(dp, inode,
> >                                       XATTR_NAME_SMACKTRANSMUTE, trattr,
> > -                                     TRANS_TRUE_SIZE);
> > +                                     TRANS_TRUE_SIZE, XATTR_NOSECURITY);
> >                               if (rc >= 0 && strncmp(trattr, TRANS_TRUE,
> >                                                      TRANS_TRUE_SIZE) !=
> 0)
> >                                       rc = -EINVAL;
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an
> email to kernel-team+unsubscribe@android.com.
>
>

--000000000000df9f7505903dba31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will redo the manual audit, perhaps I need to not be so =
scared of allconfig=C2=A0build ;-} (currently my runtime &amp; buildtime te=
st platform is android 4.19 kernel, my bad).<div><br></div><div>I am going=
=C2=A0through and exploring/changing/testing everything to deal with GregKH=
/jmorris wanting a single xattr_gs_args structure reference where the flags=
 argument is stowed, rather than YA adding a flags argument. It is doubling=
 the (mechanical) codebase impact but decreases the future maintenance and =
_large_ set of stakeholders (+75 at last count).</div><div><br></div><div>-=
- Mark</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, Aug 16, 2019 at 8:11 AM Jan Kara &lt;<a href=3D"mailto:=
jack@suse.cz">jack@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Thu 15-08-19 08:49:58, Mark Salyzyn wrote:<br>
&gt; Add a flag option to get xattr method that could have a bit flag of<br=
>
&gt; XATTR_NOSECURITY passed to it.=C2=A0 XATTR_NOSECURITY is generally the=
n<br>
&gt; set in the __vfs_getxattr path.<br>
&gt; <br>
&gt; This handles the case of a union filesystem driver that is being<br>
&gt; requested by the security layer to report back the xattr data.<br>
&gt; <br>
&gt; For the use case where access is to be blocked by the security layer.<=
br>
&gt; <br>
&gt; The path then could be security(dentry) -&gt;<br>
&gt; __vfs_getxattr(dentry...XATTR_NOSECUIRTY) -&gt;<br>
&gt; handler-&gt;get(dentry...XATTR_NOSECURITY) -&gt;<br>
&gt; __vfs_getxattr(lower_dentry...XATTR_NOSECUIRTY) -&gt;<br>
&gt; lower_handler-&gt;get(lower_dentry...XATTR_NOSECUIRTY)<br>
&gt; which would report back through the chain data and success as<br>
&gt; expected, the logging security layer at the top would have the<br>
&gt; data to determine the access permissions and report back the target<br=
>
&gt; context that was blocked.<br>
&gt; <br>
&gt; Without the get handler flag, the path on a union filesystem would be<=
br>
&gt; the errant security(dentry) -&gt; __vfs_getxattr(dentry) -&gt;<br>
&gt; handler-&gt;get(dentry) -&gt; vfs_getxattr(lower_dentry) -&gt; nested =
-&gt;<br>
&gt; security(lower_dentry, log off) -&gt; lower_handler-&gt;get(lower_dent=
ry)<br>
&gt; which would report back through the chain no data, and -EACCES.<br>
&gt; <br>
&gt; For selinux for both cases, this would translate to a correctly<br>
&gt; determined blocked access. In the first case with this change a correc=
t avc<br>
&gt; log would be reported, in the second legacy case an incorrect avc log<=
br>
&gt; would be reported against an uninitialized u:object_r:unlabeled:s0<br>
&gt; context making the logs cosmetically useless for audit2allow.<br>
&gt; <br>
&gt; This patch series is inert and is the wide-spread addition of the<br>
&gt; flags option for xattr functions, and a replacement of _vfs_getxattr<b=
r>
&gt; with __vfs_getxattr(...XATTR_NOSECURITY).<br>
&gt; <br>
&gt; Signed-off-by: Mark Salyzyn &lt;<a href=3D"mailto:salyzyn@android.com"=
 target=3D"_blank">salyzyn@android.com</a>&gt;<br>
&gt; Cc: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D=
"_blank">sds@tycho.nsa.gov</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">=
linux-kernel@vger.kernel.org</a><br>
&gt; Cc: <a href=3D"mailto:kernel-team@android.com" target=3D"_blank">kerne=
l-team@android.com</a><br>
&gt; Cc: <a href=3D"mailto:linux-security-module@vger.kernel.org" target=3D=
"_blank">linux-security-module@vger.kernel.org</a><br>
&gt; Cc: Jan Kara &lt;<a href=3D"mailto:jack@suse.cz" target=3D"_blank">jac=
k@suse.cz</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a> # 4.4, 4.9, 4.14 &amp; 4.19<br>
<br>
The patch looks good to me. I can see you&#39;ve missed conversion of one p=
lace<br>
in ext2 which 0-day spotted so that will need fixing. Otherwise feel free<b=
r>
to add:<br>
<br>
Acked-by: Jan Kara &lt;<a href=3D"mailto:jack@suse.cz" target=3D"_blank">ja=
ck@suse.cz</a>&gt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Honza<br>
&gt; ---<br>
&gt; v4:<br>
&gt; - ifdef __KERNEL__ around XATTR_NOSECURITY to<br>
&gt;=C2=A0 =C2=A0keep it colocated in uapi headers.<br>
&gt; <br>
&gt; v3:<br>
&gt; - poor aim on ubifs not ubifs_xattr_get, but static xattr_get<br>
&gt; <br>
&gt; v2:<br>
&gt; - Missed a spot: ubifs, erofs and afs.<br>
&gt; <br>
&gt; v1:<br>
&gt; - Removed from an overlayfs patch set, and made independent.<br>
&gt;=C2=A0 =C2=A0Expect this to be the basis of some security improvements.=
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/xattr.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<b=
r>
&gt;=C2=A0 fs/9p/acl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/9p/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/afs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++----<br>
&gt;=C2=A0 fs/btrfs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/ceph/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/cifs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ecryptfs/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 ++++--<br>
&gt;=C2=A0 fs/ecryptfs/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ext2/xattr_trusted.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ext2/xattr_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ext4/xattr_security.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;=C2=A0 fs/ext4/xattr_trusted.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ext4/xattr_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 fs/f2fs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 fs/fuse/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++--<br>
&gt;=C2=A0 fs/gfs2/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/hfs/attr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 fs/hfsplus/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/hfsplus/xattr_trusted.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 =
++-<br>
&gt;=C2=A0 fs/hfsplus/xattr_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/jffs2/security.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/jffs2/xattr_trusted.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 3 ++-<br>
&gt;=C2=A0 fs/jffs2/xattr_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/jfs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--<br>
&gt;=C2=A0 fs/kernfs/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/nfs/nfs4proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++--<br>
&gt;=C2=A0 fs/ocfs2/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 9 +++++---<br>
&gt;=C2=A0 fs/orangefs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/overlayfs/super.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 8 ++++---<br>
&gt;=C2=A0 fs/posix_acl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;=C2=A0 fs/reiserfs/xattr_security.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<b=
r>
&gt;=C2=A0 fs/reiserfs/xattr_trusted.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 =
++-<br>
&gt;=C2=A0 fs/reiserfs/xattr_user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 3 ++-<br>
&gt;=C2=A0 fs/squashfs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 fs/ubifs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 +++++++++++++++----------------<br>
&gt;=C2=A0 fs/xfs/xfs_xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 include/linux/xattr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 9 ++++----<br>
&gt;=C2=A0 include/uapi/linux/xattr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 =
++++--<br>
&gt;=C2=A0 mm/shmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 net/socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;=C2=A0 security/commoncap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 6 ++++--<br>
&gt;=C2=A0 security/integrity/evm/evm_main.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 security/selinux/hooks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 =
++++++----<br>
&gt;=C2=A0 security/smack/smack_lsm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 =
+++--<br>
&gt;=C2=A0 46 files changed, 126 insertions(+), 84 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xat=
tr.c<br>
&gt; index df40654b9fbb..69440065432c 100644<br>
&gt; --- a/drivers/staging/erofs/xattr.c<br>
&gt; +++ b/drivers/staging/erofs/xattr.c<br>
&gt; @@ -463,7 +463,8 @@ int erofs_getxattr(struct inode *inode, int index,=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int erofs_xattr_generic_get(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_sb_info *const sbi =3D EROFS_I_=
SB(inode);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/9p/acl.c b/fs/9p/acl.c<br>
&gt; index 6261719f6f2a..cb14e8b312bc 100644<br>
&gt; --- a/fs/9p/acl.c<br>
&gt; +++ b/fs/9p/acl.c<br>
&gt; @@ -214,7 +214,8 @@ int v9fs_acl_mode(struct inode *dir, umode_t *mode=
p,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int v9fs_xattr_get_acl(const struct xattr_handler *handle=
r,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry, struct inode *inod=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t size)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t size,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct v9fs_session_info *v9ses;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct posix_acl *acl;<br>
&gt; diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c<br>
&gt; index ac8ff8ca4c11..5cfa772452fd 100644<br>
&gt; --- a/fs/9p/xattr.c<br>
&gt; +++ b/fs/9p/xattr.c<br>
&gt; @@ -139,7 +139,8 @@ ssize_t v9fs_listxattr(struct dentry *dentry, char=
 *buffer, size_t buffer_size)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int v9fs_xattr_handler_get(const struct xattr_handler *ha=
ndler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry, stru=
ct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, s=
ize_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, s=
ize_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *full_name =3D xattr_full_name(ha=
ndler, name);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c<br>
&gt; index 5552d034090a..7e2d97653f5a 100644<br>
&gt; --- a/fs/afs/xattr.c<br>
&gt; +++ b/fs/afs/xattr.c<br>
&gt; @@ -163,7 +163,7 @@ static const struct xattr_handler afs_xattr_afs_ac=
l_handler =3D {<br>
&gt;=C2=A0 static int afs_xattr_get_yfs(const struct xattr_handler *handler=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *name,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_fs_cursor fc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_status_cb *scb;<br>
&gt; @@ -334,7 +334,7 @@ static const struct xattr_handler afs_xattr_yfs_ha=
ndler =3D {<br>
&gt;=C2=A0 static int afs_xattr_get_cell(const struct xattr_handler *handle=
r,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, const char *name,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_vnode *vnode =3D AFS_FS_I(inode);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_cell *cell =3D vnode-&gt;volume-&=
gt;cell;<br>
&gt; @@ -361,7 +361,7 @@ static const struct xattr_handler afs_xattr_afs_ce=
ll_handler =3D {<br>
&gt;=C2=A0 static int afs_xattr_get_fid(const struct xattr_handler *handler=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *name,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_vnode *vnode =3D AFS_FS_I(inode);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char text[16 + 1 + 24 + 1 + 8 + 1];<br>
&gt; @@ -397,7 +397,7 @@ static const struct xattr_handler afs_xattr_afs_fi=
d_handler =3D {<br>
&gt;=C2=A0 static int afs_xattr_get_volume(const struct xattr_handler *hand=
ler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, const char *name,<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct afs_vnode *vnode =3D AFS_FS_I(inode);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *volname =3D vnode-&gt;volume-&gt=
;name;<br>
&gt; diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c<br>
&gt; index 95d9aebff2c4..1e522e145344 100644<br>
&gt; --- a/fs/btrfs/xattr.c<br>
&gt; +++ b/fs/btrfs/xattr.c<br>
&gt; @@ -353,7 +353,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, cha=
r *buffer, size_t size)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int btrfs_xattr_handler_get(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D xattr_full_name(handler, name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return btrfs_getxattr(inode, name, buffer, s=
ize);<br>
&gt; diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c<br>
&gt; index 37b458a9af3a..edb7eb9ae83e 100644<br>
&gt; --- a/fs/ceph/xattr.c<br>
&gt; +++ b/fs/ceph/xattr.c<br>
&gt; @@ -1171,7 +1171,8 @@ int __ceph_setxattr(struct inode *inode, const c=
har *name,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int ceph_get_xattr_handler(const struct xattr_handler *ha=
ndler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry, stru=
ct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *value, si=
ze_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *value, si=
ze_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ceph_is_valid_xattr(name))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c<br>
&gt; index 9076150758d8..7f71c06ce631 100644<br>
&gt; --- a/fs/cifs/xattr.c<br>
&gt; +++ b/fs/cifs/xattr.c<br>
&gt; @@ -199,7 +199,7 @@ static int cifs_creation_time_get(struct dentry *d=
entry, struct inode *inode,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int cifs_xattr_get(const struct xattr_handler *handler,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t rc =3D -EOPNOTSUPP;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xid;<br>
&gt; diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c<br>
&gt; index 18426f4855f1..c710c7533729 100644<br>
&gt; --- a/fs/ecryptfs/inode.c<br>
&gt; +++ b/fs/ecryptfs/inode.c<br>
&gt; @@ -1018,7 +1018,8 @@ ecryptfs_getxattr_lower(struct dentry *lower_den=
try, struct inode *lower_inode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode_lock(lower_inode);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(lower_dentry, lower_inode, =
name, value, size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(lower_dentry, lower_inode, =
name, value, size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode_unlock(lower_inode);<br>
&gt;=C2=A0 out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt; @@ -1103,7 +1104,8 @@ const struct inode_operations ecryptfs_main_iops=
 =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int ecryptfs_xattr_get(const struct xattr_handler *handle=
r,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry, struct inode *inod=
e,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t size)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t size,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ecryptfs_getxattr(dentry, inode, name=
, buffer, size);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c<br>
&gt; index cffa0c1ec829..2362be3e3b4d 100644<br>
&gt; --- a/fs/ecryptfs/mmap.c<br>
&gt; +++ b/fs/ecryptfs/mmap.c<br>
&gt; @@ -422,7 +422,7 @@ static int ecryptfs_write_inode_size_to_xattr(stru=
ct inode *ecryptfs_inode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode_lock(lower_inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D __vfs_getxattr(lower_dentry, lower_=
inode, ECRYPTFS_XATTR_NAME,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0xattr_virt, PAGE_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0xattr_virt, PAGE_SIZE, XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D 8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0put_unaligned_be64(i_size_read(ecryptfs_inod=
e), xattr_virt);<br>
&gt; diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c<br>
&gt; index 49add1107850..8d313664f0fa 100644<br>
&gt; --- a/fs/ext2/xattr_trusted.c<br>
&gt; +++ b/fs/ext2/xattr_trusted.c<br>
&gt; @@ -18,7 +18,7 @@ ext2_xattr_trusted_list(struct dentry *dentry)<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 ext2_xattr_trusted_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ext2_xattr_get(inode, EXT2_XATTR_INDE=
X_TRUSTED, name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer, size);<br>
&gt; diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c<br>
&gt; index c243a3b4d69d..712b7c95cc64 100644<br>
&gt; --- a/fs/ext2/xattr_user.c<br>
&gt; +++ b/fs/ext2/xattr_user.c<br>
&gt; @@ -20,7 +20,7 @@ ext2_xattr_user_list(struct dentry *dentry)<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 ext2_xattr_user_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_opt(inode-&gt;i_sb, XATTR_USER))<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c<br>
&gt; index 197a9d8a15ef..50fb71393fb6 100644<br>
&gt; --- a/fs/ext4/xattr_security.c<br>
&gt; +++ b/fs/ext4/xattr_security.c<br>
&gt; @@ -15,7 +15,7 @@<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 ext4_xattr_security_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ext4_xattr_get(inode, EXT4_XATTR_INDE=
X_SECURITY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, buffer, size);<br>
&gt; diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c<br>
&gt; index e9389e5d75c3..64bd8f86c1f1 100644<br>
&gt; --- a/fs/ext4/xattr_trusted.c<br>
&gt; +++ b/fs/ext4/xattr_trusted.c<br>
&gt; @@ -22,7 +22,7 @@ ext4_xattr_trusted_list(struct dentry *dentry)<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 ext4_xattr_trusted_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ext4_xattr_get(inode, EXT4_XATTR_INDE=
X_TRUSTED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name, buffer, size);<br>
&gt; diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c<br>
&gt; index d4546184b34b..b7301373820e 100644<br>
&gt; --- a/fs/ext4/xattr_user.c<br>
&gt; +++ b/fs/ext4/xattr_user.c<br>
&gt; @@ -21,7 +21,7 @@ ext4_xattr_user_list(struct dentry *dentry)<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 ext4_xattr_user_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!test_opt(inode-&gt;i_sb, XATTR_USER))<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c<br>
&gt; index b32c45621679..76559da8dfba 100644<br>
&gt; --- a/fs/f2fs/xattr.c<br>
&gt; +++ b/fs/f2fs/xattr.c<br>
&gt; @@ -24,7 +24,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int f2fs_xattr_generic_get(const struct xattr_handler *ha=
ndler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *u=
nused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, voi=
d *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, voi=
d *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct f2fs_sb_info *sbi =3D F2FS_SB(inode-&=
gt;i_sb);<br>
&gt;=C2=A0 <br>
&gt; @@ -79,7 +79,7 @@ static bool f2fs_xattr_trusted_list(struct dentry *d=
entry)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int f2fs_xattr_advise_get(const struct xattr_handler *han=
dler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *u=
nused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, voi=
d *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, voi=
d *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (buffer)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*((char *)buffer=
) =3D F2FS_I(inode)-&gt;i_advise;<br>
&gt; diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c<br>
&gt; index 433717640f78..d1ef7808304e 100644<br>
&gt; --- a/fs/fuse/xattr.c<br>
&gt; +++ b/fs/fuse/xattr.c<br>
&gt; @@ -176,7 +176,7 @@ int fuse_removexattr(struct inode *inode, const ch=
ar *name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int fuse_xattr_get(const struct xattr_handler *handler,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return fuse_getxattr(inode, name, value, siz=
e);<br>
&gt;=C2=A0 }<br>
&gt; @@ -199,7 +199,7 @@ static bool no_xattr_list(struct dentry *dentry)<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int no_xattr_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c<br>
&gt; index bbe593d16bea..a9db067a99c1 100644<br>
&gt; --- a/fs/gfs2/xattr.c<br>
&gt; +++ b/fs/gfs2/xattr.c<br>
&gt; @@ -588,7 +588,8 @@ static int __gfs2_xattr_get(struct inode *inode, c=
onst char *name,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int gfs2_xattr_get(const struct xattr_handler *handler,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, void *buffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gfs2_inode *ip =3D GFS2_I(inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct gfs2_holder gh;<br>
&gt; diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c<br>
&gt; index 74fa62643136..08222a9c5d31 100644<br>
&gt; --- a/fs/hfs/attr.c<br>
&gt; +++ b/fs/hfs/attr.c<br>
&gt; @@ -115,7 +115,7 @@ static ssize_t __hfs_getxattr(struct inode *inode,=
 enum hfs_xattr_type type,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int hfs_xattr_get(const struct xattr_handler *handler,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return __hfs_getxattr(inode, handler-&gt;fla=
gs, value, size);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c<br>
&gt; index bb0b27d88e50..381c2aaedbc8 100644<br>
&gt; --- a/fs/hfsplus/xattr.c<br>
&gt; +++ b/fs/hfsplus/xattr.c<br>
&gt; @@ -839,7 +839,8 @@ static int hfsplus_removexattr(struct inode *inode=
, const char *name)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int hfsplus_osx_getxattr(const struct xattr_handler *hand=
ler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unused, struct inod=
e *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t s=
ize)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t s=
ize,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Don&#39;t allow retrieving properly prefi=
xed attributes<br>
&gt; diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c<b=
r>
&gt; index fbad91e1dada..54d926314f8c 100644<br>
&gt; --- a/fs/hfsplus/xattr_trusted.c<br>
&gt; +++ b/fs/hfsplus/xattr_trusted.c<br>
&gt; @@ -14,7 +14,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int hfsplus_trusted_getxattr(const struct xattr_handler *=
handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unuse=
d, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *bu=
ffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *bu=
ffer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size, int flags)<br=
>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return hfsplus_getxattr(inode, name, buffer,=
 size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_TRUSTED_PREFIX,<br>
&gt; diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c<br>
&gt; index 74d19faf255e..4d2b1ffff887 100644<br>
&gt; --- a/fs/hfsplus/xattr_user.c<br>
&gt; +++ b/fs/hfsplus/xattr_user.c<br>
&gt; @@ -14,7 +14,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int hfsplus_user_getxattr(const struct xattr_handler *han=
dler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, struct ino=
de *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t =
size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t =
size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return hfsplus_getxattr(inode, name, buffer,=
 size,<br>
&gt; diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c<br>
&gt; index c2332e30f218..e6f42fe435af 100644<br>
&gt; --- a/fs/jffs2/security.c<br>
&gt; +++ b/fs/jffs2/security.c<br>
&gt; @@ -50,7 +50,8 @@ int jffs2_init_security(struct inode *inode, struct =
inode *dir,<br>
&gt;=C2=A0 /* ---- XATTR Handler for &quot;security.*&quot; ---------------=
-- */<br>
&gt;=C2=A0 static int jffs2_security_getxattr(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return do_jffs2_getxattr(inode, JFFS2_XPREFI=
X_SECURITY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, buffer, size);<br>
&gt; diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c<br>
&gt; index 5d6030826c52..9dccaae549f5 100644<br>
&gt; --- a/fs/jffs2/xattr_trusted.c<br>
&gt; +++ b/fs/jffs2/xattr_trusted.c<br>
&gt; @@ -18,7 +18,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int jffs2_trusted_getxattr(const struct xattr_handler *ha=
ndler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unused, stru=
ct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, s=
ize_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, s=
ize_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return do_jffs2_getxattr(inode, JFFS2_XPREFI=
X_TRUSTED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, buffer, size);<br>
&gt; diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c<br>
&gt; index 9d027b4abcf9..c0983a3e810b 100644<br>
&gt; --- a/fs/jffs2/xattr_user.c<br>
&gt; +++ b/fs/jffs2/xattr_user.c<br>
&gt; @@ -18,7 +18,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int jffs2_user_getxattr(const struct xattr_handler *handl=
er,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, struct inode *ino=
de,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return do_jffs2_getxattr(inode, JFFS2_XPREFI=
X_USER,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, buffer, size);<br>
&gt; diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c<br>
&gt; index db41e7803163..5c79a35bf62f 100644<br>
&gt; --- a/fs/jfs/xattr.c<br>
&gt; +++ b/fs/jfs/xattr.c<br>
&gt; @@ -925,7 +925,7 @@ static int __jfs_xattr_set(struct inode *inode, co=
nst char *name,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int jfs_xattr_get(const struct xattr_handler *handler,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D xattr_full_name(handler, name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return __jfs_getxattr(inode, name, value, si=
ze);<br>
&gt; @@ -942,7 +942,8 @@ static int jfs_xattr_set(const struct xattr_handle=
r *handler,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int jfs_xattr_get_os2(const struct xattr_handler *handler=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const char *name, void *value, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_known_namespace(name))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c<br>
&gt; index f3f3984cce80..89db24ce644e 100644<br>
&gt; --- a/fs/kernfs/inode.c<br>
&gt; +++ b/fs/kernfs/inode.c<br>
&gt; @@ -309,7 +309,8 @@ int kernfs_xattr_set(struct kernfs_node *kn, const=
 char *name,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int kernfs_vfs_xattr_get(const struct xattr_handler *hand=
ler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unused, struct inod=
e *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *suffix, void *value, size_t =
size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *suffix, void *value, size_t =
size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name =3D xattr_full_name(handler=
, suffix);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kernfs_node *kn =3D inode-&gt;i_priva=
te;<br>
&gt; diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c<br>
&gt; index 1406858bae6c..1905597f86fb 100644<br>
&gt; --- a/fs/nfs/nfs4proc.c<br>
&gt; +++ b/fs/nfs/nfs4proc.c<br>
&gt; @@ -7218,7 +7218,8 @@ static int nfs4_xattr_set_nfs4_acl(const struct =
xattr_handler *handler,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key, void *buf, size=
_t buflen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key, void *buf, size=
_t buflen,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return nfs4_proc_get_acl(inode, buf, buflen)=
;<br>
&gt;=C2=A0 }<br>
&gt; @@ -7243,7 +7244,8 @@ static int nfs4_xattr_set_nfs4_label(const struc=
t xattr_handler *handler,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int nfs4_xattr_get_nfs4_label(const struct xattr_handler =
*handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unus=
ed, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key, void *bu=
f, size_t buflen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key, void *bu=
f, size_t buflen,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (security_ismaclabel(key))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nfs4_get_=
security_label(inode, buf, buflen);<br>
&gt; diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c<br>
&gt; index 90c830e3758e..525835807c86 100644<br>
&gt; --- a/fs/ocfs2/xattr.c<br>
&gt; +++ b/fs/ocfs2/xattr.c<br>
&gt; @@ -7242,7 +7242,8 @@ int ocfs2_init_security_and_acl(struct inode *di=
r,<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static int ocfs2_xattr_security_get(const struct xattr_handler *=
handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unuse=
d, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *bu=
ffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *bu=
ffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ocfs2_xattr_get(inode, OCFS2_XATTR_IN=
DEX_SECURITY,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, buffer, size);<br>
&gt; @@ -7314,7 +7315,8 @@ const struct xattr_handler ocfs2_xattr_security_=
handler =3D {<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static int ocfs2_xattr_trusted_get(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ocfs2_xattr_get(inode, OCFS2_XATTR_IN=
DEX_TRUSTED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, buffer, size);<br>
&gt; @@ -7340,7 +7342,8 @@ const struct xattr_handler ocfs2_xattr_trusted_h=
andler =3D {<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 static int ocfs2_xattr_user_get(const struct xattr_handler *hand=
ler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *unused, struct inod=
e *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t s=
ize)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name, void *buffer, size_t s=
ize,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ocfs2_super *osb =3D OCFS2_SB(inode-&=
gt;i_sb);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c<br>
&gt; index bdc285aea360..ef4180bff7bb 100644<br>
&gt; --- a/fs/orangefs/xattr.c<br>
&gt; +++ b/fs/orangefs/xattr.c<br>
&gt; @@ -541,7 +541,8 @@ static int orangefs_xattr_get_default(const struct=
 xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode =
*inode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *n=
ame,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer,=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return orangefs_inode_getxattr(inode, name, =
buffer, size);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c<br>
&gt; index b368e2e102fa..a7b21f2ea2dd 100644<br>
&gt; --- a/fs/overlayfs/super.c<br>
&gt; +++ b/fs/overlayfs/super.c<br>
&gt; @@ -854,7 +854,7 @@ static unsigned int ovl_split_lowerdirs(char *str)=
<br>
&gt;=C2=A0 static int __maybe_unused<br>
&gt;=C2=A0 ovl_posix_acl_xattr_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const char *name, void *buffer, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ovl_xattr_get(dentry, inode, handler-=
&gt;name, buffer, size);<br>
&gt;=C2=A0 }<br>
&gt; @@ -919,7 +919,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler=
 *handler,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int ovl_own_xattr_get(const struct xattr_handler *handler=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<br>
&gt;=C2=A0 }<br>
&gt; @@ -934,7 +935,8 @@ static int ovl_own_xattr_set(const struct xattr_ha=
ndler *handler,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int ovl_other_xattr_get(const struct xattr_handler *handl=
er,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *dentry, struct inode *ino=
de,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ovl_xattr_get(dentry, inode, name, bu=
ffer, size);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/fs/posix_acl.c b/fs/posix_acl.c<br>
&gt; index 84ad1c90d535..cd55621e570b 100644<br>
&gt; --- a/fs/posix_acl.c<br>
&gt; +++ b/fs/posix_acl.c<br>
&gt; @@ -832,7 +832,7 @@ EXPORT_SYMBOL (posix_acl_to_xattr);<br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 posix_acl_xattr_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ruct dentry *unused, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const c=
har *name, void *value, size_t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct posix_acl *acl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int error;<br>
&gt; diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security=
.c<br>
&gt; index 20be9a0e5870..eedfa07a4fd0 100644<br>
&gt; --- a/fs/reiserfs/xattr_security.c<br>
&gt; +++ b/fs/reiserfs/xattr_security.c<br>
&gt; @@ -11,7 +11,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 security_get(const struct xattr_handler *handler, struct dentry =
*unused,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *n=
ame, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *n=
ame, void *buffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_PRIVATE(inode))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<b=
r>
&gt; diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c=
<br>
&gt; index 5ed48da3d02b..2d11d98605dd 100644<br>
&gt; --- a/fs/reiserfs/xattr_trusted.c<br>
&gt; +++ b/fs/reiserfs/xattr_trusted.c<br>
&gt; @@ -10,7 +10,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 trusted_get(const struct xattr_handler *handler, struct dentry *=
unused,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, const char *na=
me, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, const char *na=
me, void *buffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!capable(CAP_SYS_ADMIN) || IS_PRIVATE(in=
ode))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<b=
r>
&gt; diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c<br>
&gt; index a573ca45bacc..2a59d85c69c9 100644<br>
&gt; --- a/fs/reiserfs/xattr_user.c<br>
&gt; +++ b/fs/reiserfs/xattr_user.c<br>
&gt; @@ -9,7 +9,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 user_get(const struct xattr_handler *handler, struct dentry *unu=
sed,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *name, void *buf=
fer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 struct inode *inode, const char *name, void *buf=
fer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!reiserfs_xattrs_user(inode-&gt;i_sb))<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c<br>
&gt; index e1e3f3dd5a06..d8d58c990652 100644<br>
&gt; --- a/fs/squashfs/xattr.c<br>
&gt; +++ b/fs/squashfs/xattr.c<br>
&gt; @@ -204,7 +204,7 @@ static int squashfs_xattr_handler_get(const struct=
 xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry=
 *unused,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode =
*inode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *n=
ame,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_=
t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *buffer, size_=
t size, int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return squashfs_xattr_get(inode, handler-&gt=
;flags, name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer, size);<b=
r>
&gt; diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c<br>
&gt; index 9aefbb60074f..26e1a74f178e 100644<br>
&gt; --- a/fs/ubifs/xattr.c<br>
&gt; +++ b/fs/ubifs/xattr.c<br>
&gt; @@ -669,7 +669,8 @@ int ubifs_init_security(struct inode *dentry, stru=
ct inode *inode,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int xattr_get(const struct xattr_handler *handler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 const char *name, void *buffer, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dbg_gen(&quot;xattr &#39;%s&#39;, ino %lu (&=
#39;%pd&#39;), buf size %zd&quot;, name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;i_ino,=
 dentry, size);<br>
&gt; diff --git a/fs/xattr.c b/fs/xattr.c<br>
&gt; index 90dd78f0eb27..71f887518d6f 100644<br>
&gt; --- a/fs/xattr.c<br>
&gt; +++ b/fs/xattr.c<br>
&gt; @@ -281,7 +281,7 @@ vfs_getxattr_alloc(struct dentry *dentry, const ch=
ar *name, char **xattr_value,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(h=
andler);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!handler-&gt;get)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0error =3D handler-&gt;get(handler, dentry, inode,=
 name, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D handler-&gt;get(handler, dentry, inode,=
 name, NULL, 0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error;<br=
>
&gt;=C2=A0 <br>
&gt; @@ -292,32 +292,20 @@ vfs_getxattr_alloc(struct dentry *dentry, const =
char *name, char **xattr_value,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(value, 0,=
 error + 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0error =3D handler-&gt;get(handler, dentry, inode,=
 name, value, error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D handler-&gt;get(handler, dentry, inode,=
 name, value, error, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*xattr_value =3D value;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return error;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ssize_t<br>
&gt;=C2=A0 __vfs_getxattr(struct dentry *dentry, struct inode *inode, const=
 char *name,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *value, size_t size)<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *value, size_t size, i=
nt flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct xattr_handler *handler;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0handler =3D xattr_resolve_name(inode, &amp;name);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (IS_ERR(handler))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(handle=
r);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!handler-&gt;get)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0return handler-&gt;get(handler, dentry, inode, na=
me, value, size);<br>
&gt; -}<br>
&gt; -EXPORT_SYMBOL(__vfs_getxattr);<br>
&gt; -<br>
&gt; -ssize_t<br>
&gt; -vfs_getxattr(struct dentry *dentry, const char *name, void *value, si=
ze_t size)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct inode *inode =3D dentry-&gt;d_inode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int error;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (flags &amp; XATTR_NOSECURITY)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto nolsm;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D xattr_permission(inode, name, MAY_=
READ);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (error)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error;<br=
>
&gt; @@ -339,7 +327,19 @@ vfs_getxattr(struct dentry *dentry, const char *n=
ame, void *value, size_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 nolsm:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return __vfs_getxattr(dentry, inode, name, value,=
 size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0handler =3D xattr_resolve_name(inode, &amp;name);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(handler))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(handle=
r);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!handler-&gt;get)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSUPP;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0return handler-&gt;get(handler, dentry, inode, na=
me, value, size, flags);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(__vfs_getxattr);<br>
&gt; +<br>
&gt; +ssize_t<br>
&gt; +vfs_getxattr(struct dentry *dentry, const char *name, void *value, si=
ze_t size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return __vfs_getxattr(dentry, dentry-&gt;d_inode,=
 name, value, size, 0);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 EXPORT_SYMBOL_GPL(vfs_getxattr);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c<br>
&gt; index 3123b5aaad2a..cafc99c48e20 100644<br>
&gt; --- a/fs/xfs/xfs_xattr.c<br>
&gt; +++ b/fs/xfs/xfs_xattr.c<br>
&gt; @@ -18,7 +18,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 xfs_xattr_get(const struct xattr_handler *handler, struct dentry=
 *unused,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, =
const char *name, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode, =
const char *name, void *value, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int xflags =3D handler-&gt;flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct xfs_inode *ip =3D XFS_I(inode);<br>
&gt; diff --git a/include/linux/xattr.h b/include/linux/xattr.h<br>
&gt; index 6dad031be3c2..4df9dcdc48c5 100644<br>
&gt; --- a/include/linux/xattr.h<br>
&gt; +++ b/include/linux/xattr.h<br>
&gt; @@ -30,10 +30,10 @@ struct xattr_handler {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *prefix;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int flags;=C2=A0 =C2=A0 =C2=A0 /* fs private=
 flags */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool (*list)(struct dentry *dentry);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int (*get)(const struct xattr_handler *, struct d=
entry *dentry,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int (*get)(const struct xattr_handler *handler, s=
truct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i=
node *inode, const char *name, void *buffer,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int (*set)(const struct xattr_handler *, struct d=
entry *dentry,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size, =
int flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int (*set)(const struct xattr_handler *handler, s=
truct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i=
node *inode, const char *name, const void *buffer,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t s=
ize, int flags);<br>
&gt;=C2=A0 };<br>
&gt; @@ -46,7 +46,8 @@ struct xattr {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t value_len;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -ssize_t __vfs_getxattr(struct dentry *, struct inode *, const char *,=
 void *, size_t);<br>
&gt; +ssize_t __vfs_getxattr(struct dentry *dentry, struct inode *inode,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const char *name, void *buffer, size_t size, int flags);<br>
&gt;=C2=A0 ssize_t vfs_getxattr(struct dentry *, const char *, void *, size=
_t);<br>
&gt;=C2=A0 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size)=
;<br>
&gt;=C2=A0 int __vfs_setxattr(struct dentry *, struct inode *, const char *=
, const void *, size_t, int);<br>
&gt; diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h<b=
r>
&gt; index c1395b5bd432..1eba02616274 100644<br>
&gt; --- a/include/uapi/linux/xattr.h<br>
&gt; +++ b/include/uapi/linux/xattr.h<br>
&gt; @@ -17,8 +17,11 @@<br>
&gt;=C2=A0 #if __UAPI_DEF_XATTR<br>
&gt;=C2=A0 #define __USE_KERNEL_XATTR_DEFS<br>
&gt;=C2=A0 <br>
&gt; -#define XATTR_CREATE 0x1=C2=A0 =C2=A0 =C2=A0/* set value, fail if att=
r already exists */<br>
&gt; -#define XATTR_REPLACE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2=C2=A0 =C2=A0 =C2=
=A0/* set value, fail if attr does not exist */<br>
&gt; +#define XATTR_CREATE=C2=A0 0x1=C2=A0 =C2=A0 /* set value, fail if att=
r already exists */<br>
&gt; +#define XATTR_REPLACE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2=C2=A0 =C2=
=A0 /* set value, fail if attr does not exist */<br>
&gt; +#ifdef __KERNEL__ /* following is kernel internal, colocated for main=
tenance */<br>
&gt; +#define XATTR_NOSECURITY 0x4 /* get value, do not involve security ch=
eck */<br>
&gt; +#endif<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Namespaces */<br>
&gt; diff --git a/mm/shmem.c b/mm/shmem.c<br>
&gt; index 2bed4761f279..1013fcbd0a94 100644<br>
&gt; --- a/mm/shmem.c<br>
&gt; +++ b/mm/shmem.c<br>
&gt; @@ -3206,7 +3206,8 @@ static int shmem_initxattrs(struct inode *inode,=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int shmem_xattr_handler_get(const struct xattr_handler *h=
andler,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *unused, str=
uct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, void *buffer, =
size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct shmem_inode_info *info =3D SHMEM_I(in=
ode);<br>
&gt;=C2=A0 <br>
&gt; diff --git a/net/socket.c b/net/socket.c<br>
&gt; index 6a9ab7a8b1d2..6b0fea92dd02 100644<br>
&gt; --- a/net/socket.c<br>
&gt; +++ b/net/socket.c<br>
&gt; @@ -300,7 +300,8 @@ static const struct dentry_operations sockfs_dentr=
y_operations =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int sockfs_xattr_get(const struct xattr_handler *handler,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry *dentry, struct inode *inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const char *suffix, void *value, size_t size)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const char *suffix, void *value, size_t size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int flags)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (value) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dentry-&gt;d=
_name.len + 1 &gt; size)<br>
&gt; diff --git a/security/commoncap.c b/security/commoncap.c<br>
&gt; index f4ee0ae106b2..378a2f66a73d 100644<br>
&gt; --- a/security/commoncap.c<br>
&gt; +++ b/security/commoncap.c<br>
&gt; @@ -297,7 +297,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode =3D d_backing_inode(dent=
ry);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int error;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0error =3D __vfs_getxattr(dentry, inode, XATTR_NAM=
E_CAPS, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0error =3D __vfs_getxattr(dentry, inode, XATTR_NAM=
E_CAPS, NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return error &gt; 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -586,7 +587,8 @@ int get_vfs_caps_from_disk(const struct dentry *de=
ntry, struct cpu_vfs_cap_data<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fs_ns =3D inode-&gt;i_sb-&gt;s_user_ns;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D __vfs_getxattr((struct dentry *)den=
try, inode,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_NAME_CAPS, &amp;data, XATTR_CAPS_SZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_NAME_CAPS, &amp;data, XATTR_CAPS_SZ,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size =3D=3D -ENODATA || size =3D=3D -EOP=
NOTSUPP)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* no data, that=
&#39;s ok */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODATA;=
<br>
&gt; diff --git a/security/integrity/evm/evm_main.c b/security/integrity/ev=
m/evm_main.c<br>
&gt; index f9a81b187fae..921c8f2afcaf 100644<br>
&gt; --- a/security/integrity/evm/evm_main.c<br>
&gt; +++ b/security/integrity/evm/evm_main.c<br>
&gt; @@ -100,7 +100,8 @@ static int evm_find_protected_xattrs(struct dentry=
 *dentry)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EOPNOTSU=
PP;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each_entry_rcu(xattr, &amp;evm_conf=
ig_xattrnames, list) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D __vfs_getxa=
ttr(dentry, inode, xattr-&gt;name, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D __vfs_getxa=
ttr(dentry, inode, xattr-&gt;name, NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 XATTR_NOSECURITY);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (error &lt; 0=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (error =3D=3D -ENODATA)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt; diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c<br>
&gt; index 74dd46de01b6..b0822da0658f 100644<br>
&gt; --- a/security/selinux/hooks.c<br>
&gt; +++ b/security/selinux/hooks.c<br>
&gt; @@ -552,7 +552,8 @@ static int sb_finish_set_opts(struct super_block *=
sb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr=
(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr=
(root, root_inode, XATTR_NAME_SELINUX, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0 &a=
mp;&amp; rc !=3D -ENODATA) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (rc =3D=3D -EOPNOTSUPP)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_warn(&quot;SELinux: (dev %s, ty=
pe &quot;<br>
&gt; @@ -1378,12 +1379,14 @@ static int inode_doinit_use_xattr(struct inode=
 *inode, struct dentry *dentry,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0context[len] =3D &#39;\0&#39;;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(dentry, inode, XATTR_NAME_S=
ELINUX, context, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(dentry, inode, XATTR_NAME_S=
ELINUX, context, len,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc =3D=3D -ERANGE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(context);<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Need a larger=
 buffer.=C2=A0 Query for the right size. */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr=
(dentry, inode, XATTR_NAME_SELINUX, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr=
(dentry, inode, XATTR_NAME_SELINUX, NULL, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 <br>
&gt; @@ -1394,7 +1397,7 @@ static int inode_doinit_use_xattr(struct inode *=
inode, struct dentry *dentry,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context[len] =3D=
 &#39;\0&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_get=
xattr(dentry, inode, XATTR_NAME_SELINUX,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0context, len, XATTR_NOSECU=
RITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(context);<=
br>
&gt; diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c<b=
r>
&gt; index 4c5e5a438f8b..158b35772be1 100644<br>
&gt; --- a/security/smack/smack_lsm.c<br>
&gt; +++ b/security/smack/smack_lsm.c<br>
&gt; @@ -292,7 +292,8 @@ static struct smack_known *smk_fetch(const char *n=
ame, struct inode *ip,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (buffer =3D=3D NULL)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-=
ENOMEM);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(dp, ip, name, buffer, SMK_L=
ONGLABEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(dp, ip, name, buffer, SMK_L=
ONGLABEL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0skp =3D ERR_PTR(=
rc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (rc =3D=3D 0)<br>
&gt; @@ -3442,7 +3443,7 @@ static void smack_d_instantiate(struct dentry *o=
pt_dentry, struct inode *inode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D __vfs_getxattr(dp, inode,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XATTR_=
NAME_SMACKTRANSMUTE, trattr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRANS_TRUE_S=
IZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRANS_TRUE_S=
IZE, XATTR_NOSECURITY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &gt;=3D 0 &amp;&amp; strncm=
p(trattr, TRANS_TRUE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRANS_TRUE_SIZE) !=3D 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D=
 -EINVAL;<br>
&gt; -- <br>
&gt; 2.23.0.rc1.153.gdeed80330f-goog<br>
&gt; <br>
-- <br>
Jan Kara &lt;<a href=3D"mailto:jack@suse.com" target=3D"_blank">jack@suse.c=
om</a>&gt;<br>
SUSE Labs, CR<br>
<br>
-- <br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:kernel-team%2Bunsubscribe@android.com" target=3D"=
_blank">kernel-team+unsubscribe@android.com</a>.<br>
<br>
</blockquote></div>

--000000000000df9f7505903dba31--
