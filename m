Return-Path: <linux-erofs+bounces-1800-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F78D0BF69
	for <lists+linux-erofs@lfdr.de>; Fri, 09 Jan 2026 19:54:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnrXn0ML7z2xc8;
	Sat, 10 Jan 2026 05:54:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767984856;
	cv=none; b=iWE503vFGzHOoOgKep0IXmhRd1pWyVtnt5yoOaURl8gnmnOFKonE1E5s7qqdjmDmH0X2WoQQ7xubAaGBWR71AKRBGuCOg885z+M1YqpFMzOxu1im91FUcXBfKLsT+YUjG28SmaIhOgk7PD8VH79QuEuBNalmfrjhrDhqG4GOoQthM7r31Qqdrik+S+Cky2AQg/RruaXmKulXSe6AhSH2gXLBLJ3Y24COgb8MQ8QY8ezyawBfVBfDpXCz3RkhsK1tq/s8aKra1b5lCBESvhz2Jzbf6n/56oqJFCcPCo8zX92QBVMhZC5mXKUfmyFFvZwQzGKb2WrxGNoICrDijDCWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767984856; c=relaxed/relaxed;
	bh=PEO8wbSaGOwwRv5UKfYcgXejOCV3Kmi4mBiob/Mhc5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQIB13UmjUaqUmMyD5rGfAdNbuGFtEzJB+6p3N8w78Zy3klfIJ2Lq69rWVCXJGQcbBiGXCAtaxEGtvdBKxPMY56vWajOGjWs+mSTPhLwONyPUlQiwwC34YPZWa8YxVSuemzunxHEDpCyzHLV8WRK5EW/Tl4V+pqahhfGcZ0ydsun0OhisFdNYSLlwIQENrgsXIdSusAHGLGq8P0+mGLENkTxHy9IKGS8Z8KqEfmRdaFIyZ+/hITr+NNORgd2KpkExVbx0OT6S30xl6YU7a1hypEMNhCJjDtKCKssnzrbsH1ijX6U3xJCXQvDzPhctKbFPh6CKW7TUc1m5C7S73nsZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IBiQv60l; dkim-atps=neutral; spf=pass (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IBiQv60l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnrXl0YKXz2xHP
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 05:54:13 +1100 (AEDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so7347706a12.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767984790; x=1768589590; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEO8wbSaGOwwRv5UKfYcgXejOCV3Kmi4mBiob/Mhc5w=;
        b=IBiQv60lqnabrvAuWkStUu7d8Jn7QJ8uMsEaBI9SfdMgnh+YpVMDb6cqXAl5aFLRvR
         H3D+6629gN55/HyCqKlo98nCPNtS1uH5rXXy6RXPqydQfM6Q6tlVqOGXj2iAXo0GneeP
         MWflOBlIwyTSzYann7fuy7y3t20gyRm0S4LiTWNR2PO3FkrCpvZHMYj4YL2FRq5S8xjj
         rb9y2X1clN1aY3Mjjyx7p9ldVx0E9stZCM15IXK/Bfj0pdpoEt8qCLLmZVjr0FnO4l4P
         YadV79t8WM0NjIgRnN0klXQXImOGjY5jhZIQtf8FhOlUMTyEndhSFXwcERx15RNxPO4/
         WiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984790; x=1768589590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PEO8wbSaGOwwRv5UKfYcgXejOCV3Kmi4mBiob/Mhc5w=;
        b=bNWkAd0vBthn8bg6GZcSCRsAOKYu3jWsXwlRWkbkku/oXajhe877GkVg8MQaReMMaC
         hD65wJ+vOakEo5AQ/et/YYBd8xFNLf+whHJgVmrItgVSjbn1fdAk6SyvQqiGym31SjJc
         MQiN7BUvb8TolnxtFqMpnbmkhJeW1N4hPL3ijnPDqVwanXMeU2McsHV5bm4lztM7F1T3
         fVHTmcHCqsDoDW4tZG9oTh+t7rBy0XHW5YbeGQRtWMM8TZkWxbgN6ZhMQiwtXQxtmqQ4
         4SadzB+HoqjoykIUIYDxZM0lXEozIMhTpAAOb2ZHbYqEQs9rdoo0xhbPpwdOnF9AcKey
         sQnA==
X-Forwarded-Encrypted: i=1; AJvYcCX8BoThvGsCf6Gdsq3l/piTvBeoYYaNH5PNibNhyNB+VNHARkXsJhe9eDxWLnF7+Vj23YO5io7N5KctEw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaiEEvpn0qMCgxGnI0relfbWh29UcF2iKt4c5bAFY8rhOZm0Kj
	pzQlDisghSe4q0yADh9vxCf5HOjQsujLI/6+vwbVcEzDrG1iDwDuXCEZbuG9VLlXqphg98pmCMf
	W9KukOqL1QinNGsq5aU1+wWqvANG5Iq0=
X-Gm-Gg: AY/fxX7oY18BBi03Atle7MXPAReWrS2XwcQHyf5kNhU556Kwnv49/88bQ48lzOyv+uG
	ifug6lf3z4DHryTj4LMiQO88SKSPIsVMbzKa9CajXEXCqiuhiwmrwyricWhvX0CapCO8LiqFLsZ
	sC9Xa6TMyOkQ97BU4feW3IbZByNyb+eJtOpxQyGWE6m2j1aTZIn6hdR13pSrfzFGJwE60y3uOHX
	ZtLm9DhqiGzMY3QI/FrgqeMoXAF7Lwy7sQW5jJKFqCebE5NZxzPfgQTujxNR53dvYqMQ7lqV2Gx
	RyOk3+C+cYs32QGBggsuTufLLhZVtq/VU996XqgB
X-Google-Smtp-Source: AGHT+IFY7MBbUL67We039/hTqFQidfYCDXoLMKl5hH4eJeY3RDGzxdromP5L0kMZXOGuaChoBhGE8PO55vilYs9+TsQ=
X-Received: by 2002:a05:6402:278f:b0:64b:4333:1ece with SMTP id
 4fb4d7f45d1cf-65097e88af5mr10672063a12.34.1767984790069; Fri, 09 Jan 2026
 10:53:10 -0800 (PST)
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
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4> <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
In-Reply-To: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Jan 2026 19:52:57 +0100
X-Gm-Features: AQt7F2pw3gC6snSxmHIFjd46zJk7oZ4nEXaveS8flAw1hsLI4KglAqmZVf1WWIg
Message-ID: <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 8, 2026 at 7:57=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > Yesterday, I sent patches to fix how directory delegation support is
> > > handled on filesystems where the should be disabled [1]. That set is
> > > appropriate for v6.19. For v7.0, I want to make lease support be more
> > > opt-in, rather than opt-out:
> > >
> > > For historical reasons, when ->setlease() file_operation is set to NU=
LL,
> > > the default is to use the kernel-internal lease implementation. This
> > > means that if you want to disable them, you need to explicitly set th=
e
> > > ->setlease() file_operation to simple_nosetlease() or the equivalent.
> > >
> > > This has caused a number of problems over the years as some filesyste=
ms
> > > have inadvertantly allowed leases to be acquired simply by having lef=
t
> > > it set to NULL. It would be better if filesystems had to opt-in to le=
ase
> > > support, particularly with the advent of directory delegations.
> > >
> > > This series has sets the ->setlease() operation in a pile of existing
> > > local filesystems to generic_setlease() and then changes
> > > kernel_setlease() to return -EINVAL when the setlease() operation is =
not
> > > set.
> > >
> > > With this change, new filesystems will need to explicitly set the
> > > ->setlease() operations in order to provide lease and delegation
> > > support.
> > >
> > > I mainly focused on filesystems that are NFS exportable, since NFS an=
d
> > > SMB are the main users of file leases, and they tend to end up export=
ing
> > > the same filesystem types. Let me know if I've missed any.
> >
> > So, what about kernfs and fuse? They seem to be exportable and don't ha=
ve
> > .setlease set...
> >
>
> Yes, FUSE needs this too. I'll add a patch for that.
>
> As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
> are built on. Do we really expect people to set leases there?
>
> I guess it's technically a regression since you could set them on those
> sorts of files earlier, but people don't usually export kernfs based
> filesystems via NFS or SMB, and that seems like something that could be
> used to make mischief.
>
> AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
> commit aa8188253474 ("kernfs: add exportfs operations").
>
> One idea: we could add a wrapper around generic_setlease() for
> filesystems like this that will do a WARN_ONCE() and then call
> generic_setlease(). That would keep leases working on them but we might
> get some reports that would tell us who's setting leases on these files
> and why.

IMO, you are being too cautious, but whatever.

It is not accurate that kernfs filesystems are NFS exportable in general.
Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.

If any application is using leases on cgroup files, it must be some
very advanced runtime (i.e. systemd), so we should know about the
regression sooner rather than later.

There are also the recently added nsfs and pidfs export_operations.

I have a recollection about wanting to be explicit about not allowing
those to be exportable to NFS (nsfs specifically), but I can't see where
and if that restriction was done.

Christian? Do you remember?

Thanks,
Amir.

