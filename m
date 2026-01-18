Return-Path: <linux-erofs+bounces-1972-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E035D39B6D
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 00:31:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvVG83zgCz2xpt;
	Mon, 19 Jan 2026 10:31:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.137
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768779072;
	cv=none; b=o21yJ/z0pPhftRFjDs3/SXzLwNn7abIMBawZhmWn0NGcsctdLYwGed1quA+o/M6yluiAcq3WAn3JZoxXZhUXos3U4myL+gSMJz6G4cBaezSWbRb3AI2fKpwwKYlFaf/IwScKmSnPiQJe1igdv0XpK1AFBVTgzU+yURO3PQ6C4rokZWGva8K2de4jEAwRKiBzgy4ujUnuGhyQ7ueF1BBYt48xPpsdkGF/qpuo5uJ0UKAq1cQ4cNJklAQize0QesX+3bgLN1a9P7mRFAPnGlmTaK1TksX3Q1ECov6g4qWjosHFIyH3R11LJf7w+JJ4qGNkduAiZeOOpfpdYcMOGVKLAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768779072; c=relaxed/relaxed;
	bh=cLWfoPH86LevLJ5dEarcfR/PsriG4IfSU/3wyLJz+qM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZRvbYUkCW2j74rJWKl8FJ+W+fFx7BN2FIt/+JeU1gUQR3rMuGHMUf9DkuFJZ4Xsmy2Pm9VhE9KoVsw1kSfXgMSOwB/qKh9X/zxjPJB1W1rVVLpss6omv+bHpBx6QSBURStG6HPy6pfUyypHjQZkwcxtLTIW6zIgL3o1j6FxqQ5c9EpM+Cze/MM10gfIKFFeEw2PcL2Wp2PIE8xjyKbaS7+0YnZyg8aSRBCkCsrNhlSM+uHPkqx/FsOVEo/iD13jo0pYLcNrrCuzoawGMClrh0TwpFgmBFi2m/3UjUbXFGF07wQ3VnD8Ph4BW7kFiN1zzmg1zBDB0dwag2glicLQuPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Dmw+pxT+; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IGTmerXN; dkim-atps=neutral; spf=pass (client-ip=103.168.172.137; helo=flow-a2-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Dmw+pxT+;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IGTmerXN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=103.168.172.137; helo=flow-a2-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 449 seconds by postgrey-1.37 at boromir; Mon, 19 Jan 2026 10:31:09 AEDT
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvVG50p7Cz2xnj
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 10:31:08 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 044C21380091;
	Sun, 18 Jan 2026 18:23:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 18 Jan 2026 18:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768778616; x=1768785816; bh=cLWfoPH86LevLJ5dEarcfR/PsriG4IfSU/3
	wyLJz+qM=; b=Dmw+pxT+mC6s44HDc9ViDXhGQeEmMpmNYRhtbA86QNG09PG/Ljt
	hV85ad3/pbmWWoao3arxAaxDpjTC5inzso+nDbFp9L/ocC8FvAlBD0K6BSqaNtKf
	C3km6dpzlK9Qvfbi4RlAOZVQRcgXUx6BbC4NNZXExiSaEBKuKkrscbvke30TKEj0
	X3c26YUO2IvjIKJetsMrJSw+w98guonRsqk3c5wy7tRYCBiBKWCThYgKRu77I56g
	W/jQbAZlq9qtSmpdQFd+C0/rLGEaY2+/6NIHoLbGsxK4GkDCFlahWHWTEoSSJrS/
	k5ZW9JDwUgtzyYMplQwMaStWlBzRHOxECQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768778616; x=
	1768785816; bh=cLWfoPH86LevLJ5dEarcfR/PsriG4IfSU/3wyLJz+qM=; b=I
	GTmerXNj37QbHVnwq2oYiiWRj3dNMRiwAfGv/vxfYmuPEFFfJjUyW8ruiPn+ZUTw
	y96Ysjc5jkE+PfgCaUfHrNzF77vJ+CHZGj8ZZyFQniCqqNBHAWqccBt7S/bU1BV3
	Xnstc4VvhfH6RZxhRpoHiUxWSmJT21A47932/vgOnE5bxUOTfBJmpqxFnE86OITm
	uIg7MLSy3DGOcBFTzEd5fbzcCQYBFRkQDDO9qGFEXh5IfaJ//ctGtwtYx+/A3prw
	KJ8U8PGheh+G3smkjCFKvnDL2ddcVu2iicAyBab5Q6myVEkn0CxZuzyjCejBBwJF
	S/bm6s4tkRpP23BkNvcHg==
X-ME-Sender: <xms:dGttaT6YTMF6Fa6OlzcaAnM6fKqB4-4u0PRgZNSqPeyFmRns3uNnWw>
    <xme:dGttaZPm2B1Iaa5cFSjo7JQ9nDmVsbYtDSTRFdNHBicQ-lkECLbL66rkbZK2MZehf
    _rCs8HRq47ygqgxsOGTs2CMA0vWt7_AzG555MqfdnDHw6XZXQ>
X-ME-Received: <xmr:dGttaV5f0odFoTqo9Cm-3bXwUWdDQe8OS_nESoDmZC33EUUTmsf8jTlPE6SJiNhWOG4bTHrmA205RC8BAhr3cbUxrYEQhQL_108cgTPUPoLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeitddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhose
    iivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehguhhotghhuhhnhhgr
    ihesvhhivhhordgtohhmpdhrtghpthhtoheplhhinhhugidqgihfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhilhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dGttaek4FCMZRAxWF6ejfvNQASS42yuMJmNL6Qr_VSzT2alP2kiMEQ>
    <xmx:dGttacMnrF3MIVkqtagaBM_OFbr4viUT9Quj4YPA_rDrR6FZMQe15g>
    <xmx:dGttaRUgcJhZGcX_B2l09umj3yAF-qAbVHXccqpyubd6rn2m6D7nYA>
    <xmx:dGttaVutjkDk_cSqIw9p5HdrWWt8-J_WTU_-yJ8LgZsJLx3q9gD8ew>
    <xmx:eGttab3JlD-dDEAYvGFUDpoqKXPgn7EN1IPurNldS43-2K0UKJSizYjm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 18:23:15 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
In-reply-to: <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
Date: Mon, 19 Jan 2026 10:23:13 +1100
Message-id: <176877859306.16766.15009835437490907207@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, 16 Jan 2026, Jeff Layton wrote:
> On Thu, 2026-01-15 at 19:17 +0100, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> > >=20
> > > In recent years, a number of filesystems that can't present stable
> > > filehandles have grown struct export_operations. They've mostly done
> > > this for local use-cases (enabling open_by_handle_at() and the like).
> > > Unfortunately, having export_operations is generally sufficient to make
> > > a filesystem be considered exportable via nfsd, but that requires that
> > > the server present stable filehandles.
> >=20
> > Where does the term "stable file handles" come from? and what does it mea=
n?
> > Why not "persistent handles", which is described in NFS and SMB specs?
> >=20
> > Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> > by both Christoph and Christian:
> >=20
> > https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93=
c00c@brauner/
> >=20
> > Am I missing anything?
> >=20
>=20
> This was Chuck's suggested name. His point was that STABLE means that
> the FH's don't change during the lifetime of the file.
>=20
> I don't much care about the flag name, so if everyone likes PERSISTENT
> better I'll roll with that.

I don't like PERSISTENT.
I'd rather call a spade a spade.

  EXPORT_OP_SUPPORTS_NFS_EXPORT
or
  EXPORT_OP_NOT_NFS_COMPATIBLE

The issue here is NFS export and indirection doesn't bring any benefits.

NeilBrown


>=20
> Also, on the ovl patch: will fix...
>=20
> Thanks for the review!
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


