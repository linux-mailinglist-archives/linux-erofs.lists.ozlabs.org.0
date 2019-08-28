Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D29FDB6
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 10:58:40 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JKR13PVSzDqpq
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2019 18:58:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::b43; helo=mail-yb1-xb43.google.com;
 envelope-from=amir73il@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/7IxRS5"; 
 dkim-atps=neutral
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JKQv3LNqzDqkg
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 18:58:28 +1000 (AEST)
Received: by mail-yb1-xb43.google.com with SMTP id u68so556155ybg.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2019 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZkpFpnYPlZJ9QcxAWETe0exvhhGufV9GcXx8KPl75dQ=;
 b=c/7IxRS5bV7/Y1D6aqVDN4h5XY8CLwleVTKbXnD1xvkPuYpdCL6KG1pUCZedAgswVL
 jl/Y/H3TL3Y7v26WGEvK2/K7kQDXltg3Gh1B2bsEXgA+f3ZfuZKs0Owowo137ADQO4O+
 cpzdYN/uTyuwxI00FWQlSRJrDeSiVoypEr2jK5PPgACNzrThi9kqlMgnjpNIbvs06isz
 sSk1xx9N3A6v0UgaCkxeg+WxsqAscnJ0NMP/ilLoKpdluNCBKsgYaS4spNoOe+kfNZNB
 7XBDgWqpy6pn08EBwgtZBm+9GjktdL94w9YatMNYYgi1jW7re8aGyyVgQPga7XhLViSE
 j9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZkpFpnYPlZJ9QcxAWETe0exvhhGufV9GcXx8KPl75dQ=;
 b=CfiTdKSC0Q8kQ4lzvtme4CCjqgx8PQGnQ7zb5JhWT8550I/adEAgDmAb/54NrTQzbj
 oMJT6gucPwg5MZSkROiwMF3iefNrTGHbl89ctplniqbWBEoYPwOlEPxHITyUwh2qiYUD
 6pz3uWgPbHiVwb0Ly5nB5wBYCUowf5hqZCMnuGNaxwgOYkJ0ontf6FpDCKdzU3hjzJN5
 i293uaamC0GHTLnWccWVBFxYBHeTXvPT6d8pkt9TdFE+cKJdwZEH/72C/DoEeK5Q9Z5n
 U8UMDovD0OBCDMMysKvGYLNc129Oi9uJo0BhOdoA7oT+CJc4iP6KknbjIJYTtrz7vULH
 5b4Q==
X-Gm-Message-State: APjAAAVDAKfiS7BtinYXqXd9bx7hQ4kwvT0D36nTFYJcx8QYsXE6O7+8
 6VTj5R6rU966EwDlHtjjlmjFVqbbxbwJ3UqfD8E=
X-Google-Smtp-Source: APXvYqzSub2GIlA5tBXI/WsJGtSH+6zioYqDGzlUhxxxj30lJtRuCO2Hlbsd4xVOf5z0HjodsXgoZMdYp6cwy9sWUoQ=
X-Received: by 2002:a25:c486:: with SMTP id u128mr2051352ybf.428.1566982703595; 
 Wed, 28 Aug 2019 01:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190820180716.129882-1-salyzyn@android.com>
 <20190827141952.GB10098@quack2.suse.cz>
In-Reply-To: <20190827141952.GB10098@quack2.suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Aug 2019 11:58:12 +0300
Message-ID: <CAOQ4uxgVWyiEV2s3KNT40jkUjEkn_v2MN5Z--HW=LoA_aZwNOw@mail.gmail.com>
Subject: Re: [PATCH v7] Add flags option to get xattr method paired to
 __vfs_getxattr
To: Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Eric Sandeen <sandeen@sandeen.net>,
 Mike Marshall <hubcap@omnibond.com>, linux-xfs <linux-xfs@vger.kernel.org>,
 James Morris <jmorris@namei.org>, devel@lists.orangefs.org,
 Eric Van Hensbergen <ericvh@gmail.com>, Joel Becker <jlbec@evilplan.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Kleikamp <shaggy@kernel.org>,
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 CIFS <linux-cifs@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, Hugh Dickins <hughd@google.com>,
 kernel-team@android.com, selinux@vger.kernel.org,
 Brian Foster <bfoster@redhat.com>, reiserfs-devel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-f2fs-devel@lists.sourceforge.net,
 Benjamin Coddington <bcodding@redhat.com>,
 linux-integrity <linux-integrity@vger.kernel.org>,
 Martin Brandenburg <martin@omnibond.com>, Chris Mason <clm@fb.com>,
 linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Vyacheslav Dubeyko <slava@dubeyko.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, Ext4 <linux-ext4@vger.kernel.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>,
 Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 samba-technical <samba-technical@lists.samba.org>,
 Steve French <sfrench@samba.org>, Bob Peterson <rpeterso@redhat.com>,
 Tejun Heo <tj@kernel.org>, linux-erofs@lists.ozlabs.org,
 Anna Schumaker <anna.schumaker@netapp.com>, ocfs2-devel@oss.oracle.com,
 jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 Eric Biggers <ebiggers@google.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Jeff Mahoney <jeffm@suse.com>,
 Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, devel@driverdev.osuosl.org,
 "J. Bruce Fields" <bfields@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Sage Weil <sage@redhat.com>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>,
 cluster-devel@redhat.com, v9fs-developer@lists.sourceforge.net,
 Bharath Vedartham <linux.bhar@gmail.com>, Jann Horn <jannh@google.com>,
 ecryptfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Dave Chinner <dchinner@redhat.com>, David Sterba <dsterba@suse.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Netdev <netdev@vger.kernel.org>,
 overlayfs <linux-unionfs@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Tyler Hicks <tyhicks@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 David Woodhouse <dwmw2@infradead.org>,
 Linux Btrfs <linux-btrfs@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 28, 2019 at 11:15 AM Jan Kara via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> On Tue 20-08-19 11:06:48, Mark Salyzyn wrote:
> > diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
> > index 204dd3ea36bb..e2687f21c7d6 100644
> > --- a/Documentation/filesystems/Locking
> > +++ b/Documentation/filesystems/Locking
> > @@ -101,12 +101,10 @@ of the locking scheme for directory operations.
> >  ----------------------- xattr_handler operations -----------------------
> >  prototypes:
> >       bool (*list)(struct dentry *dentry);
> > -     int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
> > -                struct inode *inode, const char *name, void *buffer,
> > -                size_t size);
> > -     int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
> > -                struct inode *inode, const char *name, const void *buffer,
> > -                size_t size, int flags);
> > +     int (*get)(const struct xattr_handler *handler,
> > +                struct xattr_gs_flags);
> > +     int (*set)(const struct xattr_handler *handler,
> > +                struct xattr_gs_flags);
>
> The prototype here is really "struct xattr_gs_flags *args", isn't it?
> Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> for the ext2, ext4, ocfs2, reiserfs, and the generic fs/* bits.
>
>                                                                 Honza

Mark,

That's some CC list you got there... but I never got any of your
patches because they did not
reach fsdevel list.

Did you get a rejection message from ML server?

Thanks,
Amir.
