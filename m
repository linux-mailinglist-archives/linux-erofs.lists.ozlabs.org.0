Return-Path: <linux-erofs+bounces-1864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E6D1F549
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 15:14:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drp5n5xl3z2xNT;
	Thu, 15 Jan 2026 01:14:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768400077;
	cv=none; b=giuNWM9mDqrAdXH/O+dDfCoIFCE9JvWrLz0JSZ/KYrFU3ZAl4rEWqTifZKNbGx/vRZNSFXZDKWLnFgBNeDTDFOUZ9RGx4u04KEsWhaErVPvitgmhGbiA8RRhHJO6qs8pFO5nmjkRGxY7H5YsPg7IL5TFif6EKtrmPDS9KRwReDUU1j3tyE1sLDTF9VKfdGzc9c/VLBkXFibygn49VGXpM6+EXwGEFWjn0USSnTs2BgnRKdOvw3MlOXnDkk+hj+3Gq+PbkrP2gOcapJ1DHsDw+1sT6qVDpTr0gIYMyr4dvwbo4OzzN/YTEsDEaYumapHT2Vs9+PNEKxJy6fRznwLrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768400077; c=relaxed/relaxed;
	bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQG0Kzhy+B2gyluHhB60g3CQ8BnppTFQaQW/m+832F5Arfs1MqwEeWEuRirQ4I9Npsw4WFp3ctVXcmwyfvp7ZhpPINFag6wUhHhFrQUzd5N2ZflOnNSQ6BRtOB4YW0bmjthp1Tss5XbNeZYQJWsvOn6xI0pvZyi+gw6LFcfR4fwJ2gy8yREQF+xOuGtD1M/YHNxh2UXUrqcuRvNGEj/kkDZFyPsKTDxdbrDyV6H2libMte2URP/2DsWDgJCy931+fhuDwDq84mRg8h12QHUSXUdej1yYPKlB5C+0kHABiQU2bLYx5hcMW+wuF/xsJ+CZr+lvxCYvyCBz0tG1gwW3eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KualsImy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KualsImy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drp5m0Tkxz2xMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 01:14:34 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so12669065a12.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768400067; x=1769004867; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=KualsImy2dFvP78xk0Fws3F2YgNs7p+EVub68SdHeMeZGg0NZSTeWPXvrGa+Hcty44
         zO0xNbwcV5h62WpwCloAKIZeAljOZnGe1xLPoblm06f3DRHu4bNjqoBNf99G5oCNQSxR
         k+Aagrel8QYfMYMnUMEI80oLSyKahm2lD/gzNB4dWEIOpBtshK/qxXwCCpbJDn1aA5/b
         Byb+Zb6t6jW9DjCYgFSZhTaD/FC4ZD8dFNZrMFDrB4zmuWlPici2lNPEB6Nyvlwb8X9p
         OeJheHL+dQnOAhHTNqvetAT3PNLOD2ykDeCGtTEtGwLb3u+d8VizldHVn8VgwFf/hHcM
         cMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400067; x=1769004867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LXI/JsxBbKF9LcEy7WQN83dkdhDN53l6d1BjVlfpBx8=;
        b=iw6CKeD/d3jH8nAio7ynNc8grEuBh+IQl0qHA1+I185Yn/2slaS5FIUF5hXa7gU0JC
         EAktL9KfwDTQ6DBNJAVOcCNGsf9tjKcDBrTTE5STkfIy431kcfasujcSTGhW0htm9fMf
         qFlIbNHRzgEuBIr8EmLsVYuWhVrhwx4x0wnMWlbC3TdvFh1LJ+OTRSV6XVvQqM/5eyJM
         U4FShn3r5WqVUmwDIxeGmjIpOl1PlPam7qtfKpEoQ6FFSMG0a301g2vTGH2iP83l2XVC
         O9/xRUfS/bC/UFGJC9alYTaGevlNuq1WjICW8Emso2nq0ZePVZaslb4cxwMPklVyxSQM
         M0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCX5JgObQM61tnoDXRynu4XW32CXB2X1LpfJe+c+GpFpjCrr3szjsaOGY2igSF4S+1q0LDcO0lSiDbgLWQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzXCeq+/M4raMZAhazVQsWp2qJmEcnzFNoHEtnD3l2fwMTUMPKz
	7L5G+SKtmPAAGW5kwjhXLtZ89xO+fWYd1UGj/3bTHto8oaiHvOz81eXRMJdC5SUEfhWvZPhtX85
	53SmD+W964kscoPo4GM8EWCSiPSaSjnM=
X-Gm-Gg: AY/fxX7R+7Ic/Zr8dXCyp6hihoXs6tPNTZUZFg8kDQ11VMOscKwCCejNrWXCnjK+MOC
	X+Piat16M5wPIo7rq/fZUrPZynptKB8WWMNJG6TezQ2RMY2BQCWSAMot4mz7K1a3LgLWBMBWwFF
	hLVZ1gaXy/ZSskx6icoMmGZ7DHqnnYxuv4+ObMJOYFobTBrECvqNLgwbn76oIak+K7AMgDXDAlw
	BX6MzFyg/edPAAjY3fJJyyYWsKXCbj32YLP9KUkfc+fKye10IWni5lxSn4O2S54UJl5C3+pf6Cb
	03iJWT6r7QvneNtlhHxupi2yF/WWKQ==
X-Received: by 2002:a05:6402:210c:b0:64b:42a6:3946 with SMTP id
 4fb4d7f45d1cf-653ec10b2c1mr2391600a12.7.1768400066360; Wed, 14 Jan 2026
 06:14:26 -0800 (PST)
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
References: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com> <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner> <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org> <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org> <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
In-Reply-To: <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 15:14:13 +0100
X-Gm-Features: AZwV_QgcgdaBnds1gv_V4-TD2P8OEmx8uWYCKQoKmrAoITMmwNZxXsYhEeLI48A
Message-ID: <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
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
	Yuezhang Mo <yuezhang.mo@sony.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
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
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 14, 2026 at 2:41=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2026-01-14 at 05:06 -0800, Christoph Hellwig wrote:
> > On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > > On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> > > >
> > > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > > Fair point, but it's not that hard to conceive of a situation whe=
re
> > > > > someone inadvertantly exports cgroupfs or some similar filesystem=
:
> > > >
> > > > Sure.  But how is this worse than accidentally exporting private da=
ta
> > > > or any other misconfiguration?
> > > >
> > >
> > > My POV is that it is less about security (as your question implies), =
and
> > > more about correctness.
> >
> > I was just replying to Jeff.
> >
> > > The special thing about NFS export, as opposed to, say, ksmbd, is
> > > open by file handle, IOW, the export_operations.
> > >
> > > I perceive this as a very strange and undesired situation when NFS
> > > file handles do not behave as persistent file handles.
> >
> > That is not just very strange, but actually broken (discounting the
> > obscure volatile file handles features not implemented in Linux NFS
> > and NFSD).  And the export ops always worked under the assumption
> > that these file handles are indeed persistent.  If they're not we
> > do have a problem.
> >
> > >
> > > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > > a known reason, which was NOT NFS export.
> > >
> > > If the author of open_by_handle_at() support (i.e. brauner) does not
> > > wish to imply that those fs should be exported to NFS, why object?
> >
> > Because "want to export" is a stupid category.
> >
> > OTOH "NFS exporting doesn't actually properly work because someone
> > overloaded export_ops with different semantics" is a valid category.
> >
>
> cgroupfs definitely doesn't behave as expected when exported via NFS.
> The files aren't readable, at least. I'd also be surprised if the
> filehandles were stable across a reboot, which is sort of necessary for
> proper operation. I didn't test writing, but who knows whether that
> might also just not work, crash the box, or do something else entirely.
>
> I imagine this is the case for all sorts of filesystems like /proc,
> /sys, etc. Those aren't exportable today (to my knowledge), but we're
> growing export_operations across a wide range of fs's these days.
>
> I'd prefer that we require someone to take the deliberate step to say
> "yes, allow nfsd to access this type of filesystem".
>
> > > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > > flags and we could even think of allowing admin to make this decision
> > > per vfsmount (e.g. for cgroupfs).
> > >
> > > In any case, I fail to see how objecting to the possibility of NFS ex=
port
> > > opt-out serves anyone.
> >
> > You're still think of it the wrong way.  If we do have file systems
> > that break the original exportfs semantics we need to fix that, and
> > something like a "stable handles" flag will work well for that.  But
> > a totally arbitrary "is exportable" flag is total nonsense.
>

Very well then.
How about EXPORT_OP_PERSISTENT_HANDLES?

This terminology is from the NFS protocol spec and it is also used
to describe the same trait in SMB protocol.

> The problem there is that we very much do want to keep tmpfs
> exportable, but it doesn't have stable handles (per-se).

Thinking out loud -
It would be misguided to declare tmpfs as
EXPORT_OP_PERSISTENT_HANDLES
and regressing exports of tmpfs will surely not go unnoticed.

How about adding an exportfs option "persistent_handles",
use it as default IFF neither options fsid=3D, uuid=3D are used,
so that at least when exporting tmpfs, exportfs -v will show
"no_persistent_handles" explicitly?

Thanks,
Amir.

