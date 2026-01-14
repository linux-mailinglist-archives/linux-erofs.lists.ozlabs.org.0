Return-Path: <linux-erofs+bounces-1858-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60335D1D92F
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 10:35:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drgvY3skGz2xPB;
	Wed, 14 Jan 2026 20:35:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768383321;
	cv=none; b=S4YT3xw4Zi0ZQnI8tL2TDOFES9Czi9Zj2800obOX4LDaWKDikpZnyRASVswJtA/Pdz2/8ZyL5GEkMTUlClLfL9N1qJWKRPBDmWc+nYmu5hf9omKO1nI8pX86HUSvJ58qZ0PTJM98FvGsnDIC4uyQZyAxJONbuZWgEhCDEWYmVUj9c/4QBqnjq+PWJAIn8vllhUWlVko/N3bwG2x9nOlCEmI71inFqp8ijZW9go0KEYlJUSBfmYpmd3sBlwDRWgGmlg6pv7JwHpd68o5fkTNZFaVNHHXX3/vd1LUw4UKBHiqhSQeoJ9WDGQfYeMPNHBDC0hPRfAwoeSORYaRkCV4bMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768383321; c=relaxed/relaxed;
	bh=cV5qgJhr5qbvOPleJHxrmxwzjsLTEkwpqcVKyAw90ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf6/W84/MXFCceISkn7wAXmwYsGM6j0XM2+E9AWE4ITh5mtkSMqREhCzQ+Osls535sygtG6JQIFtBJMaWyzpkfKnw8apzzWOyNAj8fOg9aUbjQJmkQauIVFDmTG686TLYYxw64JVcSwmzAAtcr7+wNAEqnjngIHPtMpf7LTSODsZS73YU+TNVBdRyTjDuR7GCa7Wn/k7w/+50/35gfNteIunBt+2vBgsDWxXo1tdgC5LE4KZadnlOog/3lkjilh5Rj1/dfeGJVXpEI6yOglphtTnLh6n390TNFBhJcjVO+RGVdm0MshHiAl55dmb5Mf14O8iK4KZ2b2kM4fNwua68A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NWZpU+KA; dkim-atps=neutral; spf=pass (client-ip=209.85.218.53; helo=mail-ej1-f53.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NWZpU+KA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.218.53; helo=mail-ej1-f53.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drgvX5G4vz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 20:35:20 +1100 (AEDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8765b80a52so72419666b.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768383257; x=1768988057; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV5qgJhr5qbvOPleJHxrmxwzjsLTEkwpqcVKyAw90ng=;
        b=NWZpU+KAs3vJJrAM1hfQY6Jw1IChGx4rgw0g1CahqnuaG75W692zJd/SbiKR876///
         IF9GkazEnXCZplL3/QhqMQUhkqfbiDRFnkYBKN5i02s7g52BXE9e5sDTpOdLXnl1r9C3
         h8qXGLCT6ws2Bjw6tB9Wa3hoLXGyB2AwyuGChCiRfB5Kc94ZCbBonQJNUIi5pXZF5VEW
         p5K6CnIhuDpScsMToWWPIdNwwrauXt7SvSUa2pMk0dgFkiRnpgndKUaFTzUYfyry9nNx
         xvT40MxpGRq3Bz21CEmseAtx10Kp9EXZW9kKWrSlctzgVfsPZEEZbtlYIVbvQ0wP8LYv
         /FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768383257; x=1768988057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cV5qgJhr5qbvOPleJHxrmxwzjsLTEkwpqcVKyAw90ng=;
        b=wkK6wBAW7AYC2CSzyEVHvAshIVMttzuXRvOAGEtzxc6iSd1frjsZXfQ/yWXh7tzFFf
         CANcIQcMcSYfMqR+nB1cehhvA211qmvZlP0Es7PnzQS2lwO7jy9rorWO0qpm3LP6b0g7
         Vc5gyZio+mdOgTs+5DqBRbqgxcFKVa+buw7cTi941pJ+R4SgR80HPu/cabNGF9D/BKEv
         0dZKSh89tK1UMPiQLZgJ7t+SsPJ+tkRqniv6y/jGCjjL5UantezYZYdOt5L+g4jOgCBJ
         Gty+yCiwGcPbAGmOntqjhfnVchf/ADtx/pwUhHuJZVnW/17NAp4zXwpmvbAzRlLL4/BI
         fF3g==
X-Forwarded-Encrypted: i=1; AJvYcCUszuG850Zk/0b/GCyIYzOEaUSXLCPc30g7hecCqdUMXGTlButLisbtkCHXLd6yQ7dT/YfhqrXoCVukHw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyc73rEcY8MK389WWKv96jFsjbYcW5xSSbZZAYLc9eFSACB426X
	qJvOdz4WofWz7Ve82LBn1u9YhSWnrP1j+MNgpYzc5xOC11NAWe2apgv9wCWFIMyeeqsJYTyrI61
	nTjF74WhcooqXnvRQd6n7IFjDFwt4YuQ=
X-Gm-Gg: AY/fxX5mezm9eYtp7ZjEjfQ820IPCm91Hnci0dMsoySTUn6INUDfhRy4EcIKGpnDc0b
	zEVr2/6VCLOynWfT190Tk6MuVrr6NxnoVt2nI4n3JwCFyTkxtukZ0N//cmLrW57CxiYSUm7qRQn
	8f0tQ+wUdEGtukSWP0EciLvwkFRsWdJDb2jpl92qcy6g7daQ76eIMQWSQ4ILbZ3NhFIA+Lqhr4o
	NTYRjxpOUO9CkubeMa9Toko/8OQZuEndfRsJdnvJsPfnnP7VgJlIgTGfRr+V5rxMYbyZPISokhd
	OiuFdJ3KmrPic/479gNMiexsM/melq1TQQYIW9j6
X-Received: by 2002:a17:906:6a02:b0:b87:25a6:a906 with SMTP id
 a640c23a62f3a-b87677e0680mr108491266b.46.1768383255915; Wed, 14 Jan 2026
 01:34:15 -0800 (PST)
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
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com> <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner> <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org> <aWc3mwBNs8LNFN4W@infradead.org>
In-Reply-To: <aWc3mwBNs8LNFN4W@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 10:34:04 +0100
X-Gm-Features: AZwV_QjTKvsgUAM6BTw2rpBHAs0ymZXhE-dNbh6dt2ll27JlZs1InITXkkYC5Xs
Message-ID: <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > Fair point, but it's not that hard to conceive of a situation where
> > someone inadvertantly exports cgroupfs or some similar filesystem:
>
> Sure.  But how is this worse than accidentally exporting private data
> or any other misconfiguration?
>

My POV is that it is less about security (as your question implies), and
more about correctness.

The special thing about NFS export, as opposed to, say, ksmbd, is
open by file handle, IOW, the export_operations.

I perceive this as a very strange and undesired situation when NFS
file handles do not behave as persistent file handles.

FUSE will gladly open a completely different object, sometimes
a different object type from an NFS client request after server restart.

I suppose that the same could happen with tmpfs and probably some
other fs.

This problem is old and welded into the system, but IMO adding more
kernel filesystems, which consciously export file handles that do not
survive server reboot does not serve users interests well.

One could claim that this is a bug that can be fixed by adding boot_id
to said file handles, but why fix something that nobody asked for?

cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
a known reason, which was NOT NFS export.

If the author of open_by_handle_at() support (i.e. brauner) does not
wish to imply that those fs should be exported to NFS, why object?

We could have the opt-in/out of NFS export fixes per EXPORT_OP_
flags and we could even think of allowing admin to make this decision
per vfsmount (e.g. for cgroupfs).

In any case, I fail to see how objecting to the possibility of NFS export
opt-out serves anyone.

Thanks,
Amir.

