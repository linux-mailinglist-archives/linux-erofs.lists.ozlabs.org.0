Return-Path: <linux-erofs+bounces-1869-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01866D1FB1A
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 16:20:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drqYw62SWz2xT6;
	Thu, 15 Jan 2026 02:20:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404036;
	cv=none; b=D0UWt+tY3OzE4sr8nyEnz+0wpwjU+Elrxetr4qWeiemfys54sqH/r+7MPjtYXuLEYLdHoVOsYh1rMZTbZ7YsXXR2TUujO9yPd8ZaidbdqATANPv5qjDAREG70TyEQz6Ej0x28/bn1dj3QCjZfR0VFOwalgErL5ADj3GEDTLBsD0yVA7SUrPl98N2oER+P+8Xmed/sMPlPhhKBgw1uZJQJlkngnjUSxM46Q353n4xviqMxybDv0W4bjUZsKhrC4dtjiJqMJiOIelZ7s7PdPJzEKSuUui/rV3cVg7H4oiFE0iVCQNyTKeV2yQmQnzfND01iLV0XqZYxlTbwC5q8iAr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404036; c=relaxed/relaxed;
	bh=mM/mGj7mKtWtzR+95sdegxfPi111qb3075OeDVGNDZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itPfiJYZHxmACVnj07rPaDiYUmqIC9ZA92RdliExpDPrb/MI2hNe3PyAt28MLDe1NtGuE64uLaKkGkRi90oIMgLJkqkHg0OOqYULaSNEnuVIUbF1spIhmzgsV1fRtv+tiOteZnUoM4li7wdjtqIMJXuig++inD0zNWtR0LCNqD3Hxey6a8aNqiz3Af9iEOPXzgU+oHjw9vs4P5viG6rmHEKXe3vGGQpcZNcJ0VR+++/OrPIm6jTE9lCLQbw4JFdzcZvBw1xwhQLZ+zCs+HI6aALfpMay5u9Ljq84yGBFM0sY/zQoQtvNW+jTYnSJxzd3M8FHR4vWP/Qrszuqe5NF6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FqipJ8Fc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FqipJ8Fc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqYw0GQVz2xNg
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 02:20:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 353AC443ED;
	Wed, 14 Jan 2026 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C66C4CEF7;
	Wed, 14 Jan 2026 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404032;
	bh=95l5NkW0A/27kpGYcRaUumPREirLPSD0h/i7bikH9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqipJ8Fclg/c7qbEuyuUoO5LnexEwFkZgygpoboZW7ULcYAGY34jzrJax6uIrAgGb
	 FUepiZcAjlgA0R6fvdFVWwhV9jk0Bth6JPV5psDXj3fKzojOCwDT/rEZzcVE5OnNcB
	 fkG5ZlQLelxcsKpIOTgMpMe11bGcKCWvNYmxvgnzxn2ZC8L7s2dKJy1mrpvPNu7Z7A
	 UqZxpjIOgw/V7XPIA/1Y2FN9yOrK13WyoEdrmVdFpCQbw6zTva9Pkh2JqEgk58ngiJ
	 5S6BKkDUQrDweGrzgYJLMr/YFieOsQM7bFBSWWwVpgpU92+aZuVuBVHfvvOSCo18FZ
	 sKemGEnojFw5A==
Date: Wed, 14 Jan 2026 16:20:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
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
Message-ID: <20260114-klarstellen-blamieren-0b7d40182800@brauner>
References: <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
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
In-Reply-To: <aWeUv2UUJ_NdgozS@infradead.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 14, 2026 at 05:06:07AM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 10:34:04AM +0100, Amir Goldstein wrote:
> > On Wed, Jan 14, 2026 at 7:28 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > > > Fair point, but it's not that hard to conceive of a situation where
> > > > someone inadvertantly exports cgroupfs or some similar filesystem:
> > >
> > > Sure.  But how is this worse than accidentally exporting private data
> > > or any other misconfiguration?
> > >
> > 
> > My POV is that it is less about security (as your question implies), and
> > more about correctness.
> 
> I was just replying to Jeff.
> 
> > The special thing about NFS export, as opposed to, say, ksmbd, is
> > open by file handle, IOW, the export_operations.
> > 
> > I perceive this as a very strange and undesired situation when NFS
> > file handles do not behave as persistent file handles.
> 
> That is not just very strange, but actually broken (discounting the
> obscure volatile file handles features not implemented in Linux NFS
> and NFSD).  And the export ops always worked under the assumption
> that these file handles are indeed persistent.  If they're not we
> do have a problem.
> 
> > 
> > cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
> > a known reason, which was NOT NFS export.
> > 
> > If the author of open_by_handle_at() support (i.e. brauner) does not
> > wish to imply that those fs should be exported to NFS, why object?
> 
> Because "want to export" is a stupid category.
> 
> OTOH "NFS exporting doesn't actually properly work because someone
> overloaded export_ops with different semantics" is a valid category.
> 
> > We could have the opt-in/out of NFS export fixes per EXPORT_OP_
> > flags and we could even think of allowing admin to make this decision
> > per vfsmount (e.g. for cgroupfs).
> > 
> > In any case, I fail to see how objecting to the possibility of NFS export
> > opt-out serves anyone.
> 
> You're still think of it the wrong way.  If we do have file systems
> that break the original exportfs semantics we need to fix that, and
> something like a "stable handles" flag will work well for that.  But
> a totally arbitrary "is exportable" flag is total nonsense.

File handles can legitimately be conceptualized independently of
exporting a filesystem. If we wanted to tear those concepts apart
implementation wise we could.

It is complete nonsense to expect the kernel to support exporting any
arbitrary internal filesystem or to not support file handles at all.

How that is achieved is completely irrelevant to that core part of the
argument. The point Jeff and Amir are making that it is sensible to
allow one without the other.

Whether or not some userspace crap allows you to achieve the same thing
is entirely irrelevant and does not at all imply we have to allow the
same crap in the kernel.

