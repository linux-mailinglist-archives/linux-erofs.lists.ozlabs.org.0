Return-Path: <linux-erofs+bounces-1985-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B3D39FCF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:31:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvhvz70rHz2yDk;
	Mon, 19 Jan 2026 18:31:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.143
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768807871;
	cv=none; b=HDmlcDL0+/Upke5urPlNtKgAuSJs2kfLLd8g/95uoIWfF/TKQVdYV0t68M+j7GOJE9oaTrcDbEbtKrUZtHjkmM2fIzpHUo9dbqxA77cbismM2YKAIhtczhuhKiwhxysS7gGD0AH8dlRhvdqY78X7ysHwItexyiDxQJmqyRVNLMJ4NhrEE66r7dnzLBQeE9JtSWZBEGbNIlqwqZqYKxn71/w8eR/4HGWZritGgBOlF8dG36ZXqRv4Ozy4VKjmXNzJlePV5d1wx48ZZp7f8eWWHKjMBetUnh8XCsOjE6x+DvFPkViG3ZuUsLPilvU7kJnPSqohGhZPfEcy71nVHD4VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768807871; c=relaxed/relaxed;
	bh=l0q9OiSiL57A1oXpVwou+Qazcwu9lF8/fKQyDTZuHuY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=crha+9rYVYcpYvY94l6JdYwLakI+/28lyt58GLGogutg/6aHESFSG0J+pJOG0+lGtHUJxqbwXW0dal/q2f7Y8Vb7T68sT/184BFiT3Rp75KzMWUCZrQvj77T55T4wSf4ApdmKcvte9hnd97chzvrk6epiCrOBTgZmtn/uhYR5FNBu5t5zOkw2xC1z15if8ehJh5cESbY6qviyPSj9NVHUrLUn6vAItWQYNVyEFurgamoqpbIuKABIb3AjWSd0zp7nClGz3JplDRq8rLRGbpfoRMXIDGuTM5FCWbnBVl+fEt99fCD84K47Yyai1+InFbwc57QmwqOHXZuH3L+UxbHeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=irDVjFha; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=K8ltski0; dkim-atps=neutral; spf=pass (client-ip=202.12.124.143; helo=flow-b8-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=irDVjFha;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=K8ltski0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=202.12.124.143; helo=flow-b8-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 477 seconds by postgrey-1.37 at boromir; Mon, 19 Jan 2026 18:31:09 AEDT
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvhvx2kjhz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:31:09 +1100 (AEDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 3219E130103E;
	Mon, 19 Jan 2026 02:23:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Jan 2026 02:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768807386; x=1768814586; bh=l0q9OiSiL57A1oXpVwou+Qazcwu9lF8/fKQ
	yDTZuHuY=; b=irDVjFhaz/K8YtiXzQ31MDOgMGCo+Gz//EwM4OijAM0vOKynyB6
	BpwYFZYCEe3o7Gx5L4V6M4FhbipwQNJV0ujCSLBSc5IHezW/FyB/LWZraYVlaMJu
	YnnpUl4JgVLbrNIec+WcKPTR09keVUJuKuo5IR+gQesu/p0p7PhQm/pf+9OgvKR5
	WdaCaILT5Zm8fqMcKW/PAdv1HxPiIM+Z3QX4jypg1fiENCArP/M8KaRMfJ7uYtgT
	cBjjHOj9Mr9wPQirkQS2BYF8pjwZRelVojFvJtbhrJ5l9QZPmQNMkhdcWIaHKOt+
	ltoa8OTg2UGC53H+WAMXgf82R3jVtEKBVww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768807386; x=
	1768814586; bh=l0q9OiSiL57A1oXpVwou+Qazcwu9lF8/fKQyDTZuHuY=; b=K
	8ltski0YBtBzy6uowaabbff8s5zuRDbtUFWXcDtg931MBwRc16+CKDMRYekaXZHk
	LOnd7mQjODx3F7HVmyPZWvLOv8yjti4w+MIAbxpLRgNDP65uPFl9Gfl058RUJHH+
	Fk6+cJVTq4wuDdMq1Z5W9k1ZuC7iRuYcXx1GwUdvxisFOcHq/jX6VpQCI2oyR0CU
	ZM3JKGGiUVRS4Nbh4KzQMT/wi9djnt+fqIQkRVTwyAKauSyNTqZZcQHWI735MH16
	4XBGsVULicKWqCSMDT9bs+x+/xy/Gu1Q6khze7NDCvAP+QvrXTWLwqj3Y9LKIzDB
	XZKhCr7irnaORckcnoZBQ==
X-ME-Sender: <xms:1tttaQEL1zY-cqjAi3LwisLLYig4vGmVFZGnEWqvFdfPu_1cBx4ryQ>
    <xme:1tttadNPXJyKg4i6N7NiajEYCS_ixBqVWnODY0xDbeIYm-0ddIGPmXX4nPobqTrUH
    FdEox9n77yL1V53kkmfQXZnVrRbAt8y41xmdzHA26xbb4UiNw>
X-ME-Received: <xmr:1tttaX2pXmbQvkTPzq0NQg4Hf4lyVdk2Kt7K2P2YoY0rgkMkSP0qEY7AWJnIFHDorFcLBSqfoL6DkzzzXRH8ujZGIJqMnM5xQhHy1RkjUWf6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtjeertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epudetfefhudevhedvfeeufedvffekveekgfdtfefggfekheejgefhteeihffggfelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1tttabHi5RQs76Xz74nOwWrYIZ47zQ7Zj71gIm-NgtkzokJPtBcMHA>
    <xmx:1tttafzYjiWXRjDGlVz6_k-3h2GeOsbL3CzwIMyCt37eR3PuktBG4w>
    <xmx:1tttaaofGHLgl2z91oIIPm_yXGWHUeCGCqWi64kkrnWVR5nBeLXySA>
    <xmx:1tttaUlKdw4URdR2-6lB_1IM56jb7LL9_P5nu35Q0sPULNdt9mAF_A>
    <xmx:2tttacnPYyzS2rQik0c4UgQtzVVe9-q502rX9-wmNn1taRjPmfmDMIhi>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:22:45 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
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
 linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
In-reply-to: <aW3SAKIr_QsnEE5Q@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>
Date: Mon, 19 Jan 2026 18:22:42 +1100
Message-id: <176880736225.16766.4203157325432990313@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > This was Chuck's suggested name. His point was that STABLE means that
> > > the FH's don't change during the lifetime of the file.
> > > 
> > > I don't much care about the flag name, so if everyone likes PERSISTENT
> > > better I'll roll with that.
> > 
> > I don't like PERSISTENT.
> > I'd rather call a spade a spade.
> > 
> >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > or
> >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > 
> > The issue here is NFS export and indirection doesn't bring any benefits.
> 
> No, it absolutely is not.  And the whole concept of calling something
> after the initial or main use is a recipe for a mess.

We are calling it for it's only use.  If there was ever another use, we
could change the name if that made sense.  It is not a public name, it
is easy to change.

> 
> Pick a name that conveys what the flag is about, and document those
> semantics well.  This flag is about the fact that for a given file,
> as long as that file exists in the file system the handle is stable.
> Both stable and persistent are suitable for that, nfs is everything
> but.

My understanding is that kernfs would not get the flag.
kernfs filehandles do not change as long as the file exist.
But this is not sufficient for the files to be usefully exported.

I suspect kernfs does re-use filehandles relatively soon after the
file/object has been destroyed.  Maybe that is the real problem here:
filehandle reuse, not filehandle stability.

Jeff: could you please give details (and preserve them in future cover
letters) of which filesystems are known to have problems and what
exactly those problems are?

> 
> Remember nfs also support volatile file handles, and other applications
> might rely on this (I know of quite a few user space applications that
> do, but they are kinda hardwired to xfs anyway).

The NFS protocol supports volatile file handles.  knfsd does not.
So maybe
  EXPORT_OP_NOT_NFSD_COMPATIBLE
might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
(I prefer opt-out rather than opt-in because nfsd export was the
original purpose of export_operations, but it isn't something
I would fight for)

NeilBrown

