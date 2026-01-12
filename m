Return-Path: <linux-erofs+bounces-1823-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C4D119B1
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 10:49:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqSJz2Yjvz2xS2;
	Mon, 12 Jan 2026 20:49:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768211379;
	cv=none; b=Tr06KrtXu8Qil/aNYZ2r+GGXVPhX1feGbhebi2TkMfFVDK0s3deKhm2jBCqSMaxPk8MzzJMgEjR2STmVSurTHs/8KGgcBBIj7uc58P95nusha0S3TcUHzuL5eozdGezMaISMYMdAiJDJ1XTkP4Ylx7kLH6r9NW8dhY5si+iYWh3Ddir5nApV349sUU4TgdLP/KgNRJHUben7+O74Iz5C+TRjXf9ekUzhR6vvF4HC89ZZiZIg5xRRvZy6lr5YSGwHxJss1tcANG7A/oCPqe3kHSoOKwW5YbrmpyoJwWoZHHqUvH9bK+hWsuNIKLXMJ7uTg5CH8kv32EQytjGPbJVtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768211379; c=relaxed/relaxed;
	bh=MfekXN2se1alUjSsCk4xdLnYVKkV19tWJ8Jv/yRkuaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQdibRCmXFxSNZVqNJkIgKd0+Dl4IbhRae4JcxNjpE0PHn+itw86Q8HDLVduVPgZMqn697BHjz5teHIGip5P+sOCtZnSHCxlUPhdBE9BpSjWfZbv9+WW5ARNWd8fG8KrWiR/E8kYPTnAjr9wGshcm3x/SkG6k8ij9le6vAluQgFKZGlb67NcPZRsALlIzKA8xw9PXNEDBQfhaMbzDHNvfAhqDEnrpf109McCEebw17dHdJohXfeFtAokv6fNXAAOWtcNwwII0F4BkN37ACCzCwdqWzjytPN/CDsIthzGcgQjXCRNWuKmD0+A4mlXRQpvjAU2yokdJ24EUqli8Ll0Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kovjAz4K; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kovjAz4K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqSJy42g5z2xHP
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 20:49:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 217D86013A;
	Mon, 12 Jan 2026 09:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD38C116D0;
	Mon, 12 Jan 2026 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768211375;
	bh=m8zAICgnxs6xkW3AmfrwI3a0ispTdY6AQGss0vAXdME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kovjAz4KC5mAD7YrC6t2czYMjBWRcZIetUzNRdlwl4Z1rGgyp9glYOLbnOZypWAbx
	 YcmUJCp6E8w+KmTy2i5WzHpX9fHwe2RpJgFtTNA95cnxyqlkjOQ7JUeU62APvVqkZH
	 Y3/3WTlqh+tsw7Ls6NjRbDo/fUnqsYd/eTTthVLhPJ/V7Q9k3YIeMunOn+RktLYgES
	 ul3EQIBMmxhQ+r6sMjogrCPwB0I4vKTgz3PxtAbmBEyff/p4uJORPrLFe5LDSB0Hni
	 RZIrOX4UDngsOGqfziwhf24VBmArYe5xbo5TLnA7nB4zBdXfiNr6kFAgXt4Ej7biQ5
	 RxoAJIZnapRSw==
Date: Mon, 12 Jan 2026 10:49:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, 
	Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260112-gemeldet-gelitten-7d48bae7ef3f@brauner>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 09, 2026 at 07:52:57PM +0100, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > > Yesterday, I sent patches to fix how directory delegation support is
> > > > handled on filesystems where the should be disabled [1]. That set is
> > > > appropriate for v6.19. For v7.0, I want to make lease support be more
> > > > opt-in, rather than opt-out:
> > > >
> > > > For historical reasons, when ->setlease() file_operation is set to NULL,
> > > > the default is to use the kernel-internal lease implementation. This
> > > > means that if you want to disable them, you need to explicitly set the
> > > > ->setlease() file_operation to simple_nosetlease() or the equivalent.
> > > >
> > > > This has caused a number of problems over the years as some filesystems
> > > > have inadvertantly allowed leases to be acquired simply by having left
> > > > it set to NULL. It would be better if filesystems had to opt-in to lease
> > > > support, particularly with the advent of directory delegations.
> > > >
> > > > This series has sets the ->setlease() operation in a pile of existing
> > > > local filesystems to generic_setlease() and then changes
> > > > kernel_setlease() to return -EINVAL when the setlease() operation is not
> > > > set.
> > > >
> > > > With this change, new filesystems will need to explicitly set the
> > > > ->setlease() operations in order to provide lease and delegation
> > > > support.
> > > >
> > > > I mainly focused on filesystems that are NFS exportable, since NFS and
> > > > SMB are the main users of file leases, and they tend to end up exporting
> > > > the same filesystem types. Let me know if I've missed any.
> > >
> > > So, what about kernfs and fuse? They seem to be exportable and don't have
> > > .setlease set...
> > >
> >
> > Yes, FUSE needs this too. I'll add a patch for that.
> >
> > As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
> > are built on. Do we really expect people to set leases there?
> >
> > I guess it's technically a regression since you could set them on those
> > sorts of files earlier, but people don't usually export kernfs based
> > filesystems via NFS or SMB, and that seems like something that could be
> > used to make mischief.
> >
> > AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
> > commit aa8188253474 ("kernfs: add exportfs operations").
> >
> > One idea: we could add a wrapper around generic_setlease() for
> > filesystems like this that will do a WARN_ONCE() and then call
> > generic_setlease(). That would keep leases working on them but we might
> > get some reports that would tell us who's setting leases on these files
> > and why.
> 
> IMO, you are being too cautious, but whatever.
> 
> It is not accurate that kernfs filesystems are NFS exportable in general.
> Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
> 
> If any application is using leases on cgroup files, it must be some
> very advanced runtime (i.e. systemd), so we should know about the
> regression sooner rather than later.
> 
> There are also the recently added nsfs and pidfs export_operations.
> 
> I have a recollection about wanting to be explicit about not allowing
> those to be exportable to NFS (nsfs specifically), but I can't see where
> and if that restriction was done.
> 
> Christian? Do you remember?

I don't think it does.

