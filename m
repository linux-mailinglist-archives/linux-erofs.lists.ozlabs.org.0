Return-Path: <linux-erofs+bounces-1919-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55FD278AB
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 19:29:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsWjr1XLBz2yFm;
	Fri, 16 Jan 2026 05:29:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768501792;
	cv=none; b=HxPTrBZ3Hn7g7MkDi/qp1DvP3alFVk2pnTfYm8WgjiGnu89El46mQMVK0qYmStsRKtVj+rx9LqLpEPs6znaRL6Acb3oUIo5KHAd8yaB1xB5QjddxrO/lz5M0baPTgdR3hBUS5l8/977y/DPaN4VawEPlngWQ22Nz+Of5V4nj03kEuhJM89G37uObMoz7s63y7Nwz3RfjOikcpFlfDe0vNNkPIzroQyidGSQVbfDc++NfK/Pcom/ptc3IZ1Wz2Pbo6D+37Llb2pklgdNwi4APLRvnZVqXDY6pG3lLnO2nRzACaq3dcrUmpmc8l7zHu1JAdrWaEIiMAFz5f4W6svnHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768501792; c=relaxed/relaxed;
	bh=YJUwpUc45Oiig1PgeO+sGSqGRRsfBtkg12WLTtqgjM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYz7KlO5yA7DNPGSlqmwVpnZECK96rHihkIEv85NPt+StYsz1R9kEG3IqpcvxZT7Piukr+CutmIja1wFBjMnpdGe76pGvsTrNx8FXI6GXs7ZUQF+PKhQpGFZST2eLEH4YohDsjBBn+cGYey29CsGwvGE+twRy4uxGH1W6Hehx3N8jJ0p5XPo4qLLMKrxL9IQoAUk0GF8OZhWAT/xldofI19synGeu2LeOfI/NARrsl61tFDQ2m5I/LW+vPId7+JFYrxikRFMtHyJIpRYdZrdCVWD/9oFK89sgC8MdG3dDBdNQtYXdVBq62sdnJ+3uUsDA1jj62dSOytyTf/ZZoFxUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oD4BqoeH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oD4BqoeH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsWjq2t1Wz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 05:29:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFE4D40206;
	Thu, 15 Jan 2026 18:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52629C19422;
	Thu, 15 Jan 2026 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501788;
	bh=YJUwpUc45Oiig1PgeO+sGSqGRRsfBtkg12WLTtqgjM0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oD4BqoeHcY2D9lGD7DZ3JkRCa0etBfHfBKe+2G2b7u7Qo+C41AyXcw62I2rIzw78K
	 JhB9l/0/J6ilYAa69I8b7fww8XZFEqOir5lBIE2UdSkmpRVv/hXFxiOU+LtDAjFXR6
	 BNE6R8L6dKY0UtY62cDEp8T1NZC6IK+QrzBnhVQPbtXSZ2RbkhJJ5Xlh6Q8pw3shuL
	 6BvYBuNu4w1u+CtSec6A7GYdzxcGnBdiKl2POm27xEPFdCmzt6sqGM5XBC0tQhtIJ6
	 65IfjuFS7GtCyIgOWgwaid7bZE2IFVOd9iIpDkcd3LlTfzzNh/Mb4MwPEBNMh7gQ2D
	 Zad5rVsjaOezQ==
Message-ID: <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, NeilBrown	
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo	
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Hugh Dickins
 <hughd@google.com>,  Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton <akpm@linux-foundation.org>, Theodore Ts'o	 <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Jan Kara	 <jack@suse.com>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu	
 <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale	 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai
 Guo	 <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, Ilya Dryomov	
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav
 Dubeyko	 <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>,  Luis de Bethencourt	 <luisbg@kernel.org>, Salah Triki
 <salah.triki@gmail.com>, Phillip Lougher	 <phillip@squashfs.org.uk>, Steve
 French <sfrench@samba.org>, Paulo Alcantara	 <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N	
 <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, Miklos
 Szeredi	 <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, Martin
 Brandenburg	 <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel
 Becker	 <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>,  Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, David
 Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan
 Kara <jack@suse.cz>,  Andreas Gruenbacher	 <agruenba@redhat.com>, OGAWA
 Hirofumi <hirofumi@mail.parknet.co.jp>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, 	linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, 	jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, 	gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Jan 2026 13:29:41 -0500
In-Reply-To: <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 2026-01-15 at 19:17 +0100, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > In recent years, a number of filesystems that can't present stable
> > filehandles have grown struct export_operations. They've mostly done
> > this for local use-cases (enabling open_by_handle_at() and the like).
> > Unfortunately, having export_operations is generally sufficient to make
> > a filesystem be considered exportable via nfsd, but that requires that
> > the server present stable filehandles.
>=20
> Where does the term "stable file handles" come from? and what does it mea=
n?
> Why not "persistent handles", which is described in NFS and SMB specs?
>=20
> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> by both Christoph and Christian:
>=20
> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93=
c00c@brauner/
>=20
> Am I missing anything?
>=20

This was Chuck's suggested name. His point was that STABLE means that
the FH's don't change during the lifetime of the file.

I don't much care about the flag name, so if everyone likes PERSISTENT
better I'll roll with that.

Also, on the ovl patch: will fix...

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

