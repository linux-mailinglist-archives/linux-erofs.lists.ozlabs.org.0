Return-Path: <linux-erofs+bounces-2080-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9095D3C3E7
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 10:42:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwMmq39VMz2x9M;
	Tue, 20 Jan 2026 20:42:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768902139;
	cv=none; b=TK64jZPleiOnij+oQKZNgmAkwy7cZmDbW5r3zvYPK9mk44qBMVu0QcK4LN0sFbqUnNnsCugYXU4vAnWNV8ZU1HhPhcgJnofS78FYhBCCL8kUey3LK/LTEhd3J1UIq9Ryc2WAhEyWJZlYvGpVyUAmWyBP8zU3pE+/Kaq34GoElOYc2j16FXTvGo2G8RDkMv0DDIa49si1E8o+MJL/2mOvl8bbd7QXzAofC+/hJofCE3h9ezgeAxe91dT/5ymVFlQs+oQZP8M+eGGagRJ2Xm5efuqSfptrvOCi5TbT2yfB6agc7tS2W+/NkFqQOQqfAXjYBjghf9HuplW9H5dAe4bVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768902139; c=relaxed/relaxed;
	bh=8LV/m+2BySRP4UTa8KO6B5ANmTiLCS01qCPx3K33a4E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=d8DzCpzm+8yAagQVk8nRmV3SCFjamh72nWtNmLUT9CjRYnJZsufDA8qyO0xj0/y8o3nZqZfzb/0JtdeRgVx8x5UftoNYbX//QWet1nRcZuWdWtqMFWkMerLwxhsfimGI8I/KHwFTIiOr32hBxhhkKwA1wF83kXMTzm9hgn2ZQR1S7tjMfuzan5WUEYfnIlkcbdcbwuact1qg/GWbzEgitxBpkLEGMPTUGpoQHenwNWnu6TjulsK+ItbulnSyV52nfpQMwp8u6GU3/UDb4ZebCgbcyHsAlc1eUkdNbokmiajrgx1SfUJL+7cFElPzAuwVjn1+DYWsbaikXOKX0zlftA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=QBLgYxDP; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IlJarExe; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=QBLgYxDP;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IlJarExe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwMmn6Txrz2x99
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 20:42:17 +1100 (AEDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 69A65130083C;
	Tue, 20 Jan 2026 04:42:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 04:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768902133; x=1768909333; bh=8LV/m+2BySRP4UTa8KO6B5ANmTiLCS01qCP
	x3K33a4E=; b=QBLgYxDPwqb8F/HKOO4s4mzyuJJ5MMUd1laQIcZ9FLfjSQIHZc+
	1PekC9F5KiYouciRAURW5scRiZfUfVf+lHhWler9vaCX34KwsDgrcH+K5GMcSPhm
	01zfr2TzcAnR+XzN7ZoF4Ce1ogYn2127mD1CbQtGo5JcXSrLM5DudreAqJPMM+d1
	pEZdVLpH1i/ogNehoKQHjAQzn/eGcaPjc942Em7vOAIEwadjFSKz28MGc0I4d8PJ
	d+9coMB/qwxJWZ/EAe0Ypz4WGmhqrnEngeKyp+9XDQoyLvIZ2mymsJ4bkGZ81TV2
	9WZ0ZuIw8lEEQvuro+dbp9T/f1kCrvifu9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768902133; x=
	1768909333; bh=8LV/m+2BySRP4UTa8KO6B5ANmTiLCS01qCPx3K33a4E=; b=I
	lJarExedh8uzTTah/bHx79/YyztFkui/cYw/IFWC48OO9ny2YOytT0/PMAHPrEDb
	AyA1750snwOOTIfNl1On1EDKsnlM6Q77auuvSlGsq3AxJq08dwSFRCRJ1TyTja2v
	+tCSqzwbvZw7q2vVw6dZHjcUAN1pOOX3Zdb9iGaOEaZKjE7VYix7rALrimtuXK4G
	S1EmLbVnF9+emGzsZoKwIU1ZYEvNciORd/LEYYeVM2jaUNvrhdFzl3xvTnxrXXO8
	gSL7ILssNaIMxQAvCboeFOkje0ZJkqebBwPR89zdsWbkDmGoBagFfPVqH96/r7xd
	UUf6p6EbYyj35tCGpABfw==
X-ME-Sender: <xms:801vaS1HQqJTkLN0qOfNxDYR4QEeodh9pOzlm5q1a7-te1bwVk57KQ>
    <xme:801vaY92pFHUjDCZ7ioN3ccEM76jeUEkRPxfdpf9xsPE7OOAmasiRMHpY3FbvAzGy
    Ib4JB5h0uHGt7LJIgiS1xo9p7Tuy3xjN92zLOGtkOHkCRc-bw>
X-ME-Received: <xmr:801vaYkPNCbWybQZ_Z8VogKxTEtLNy5ht-LA6lJgxbV_7j9EyJUyIE6sAp6pW0R92ATQU3P6FFEfKSEQt9nWaYMYiqesHSX-YaV04pjX969V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
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
X-ME-Proxy: <xmx:801vac0dgfcvMTCBXINaH24yiyKEFUIE1Ls5XDW5vogt4-eXS0CHcA>
    <xmx:801vaegrkt6HTpXA0iTS6Ch9yRl9FxpkN1c8EoOi51B2W-NRG0Cc9w>
    <xmx:801vaSZ2kk4EgEdqpha3AierzEi87LlnWdGD9QbopkHA9JEx5vqJWw>
    <xmx:801vaRWFkRpjMuQy6ymBG7IFYgOaPEcaBxpo8w9DagSZ9_XbM_Rmug>
    <xmx:9U1vaQUrUz_-VltF1IDMQy_Zdp8PR5Bulioc2EaRPWdDYTmHji8Q8eiD>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 04:41:53 -0500 (EST)
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
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
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
 "Jaegeuk Kim" <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
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
In-reply-to: <20260120-entmilitarisieren-wanken-afd04b910897@brauner>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>,
 <176885553525.16766.291581709413217562@noble.neil.brown.name>,
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner>
Date: Tue, 20 Jan 2026 20:41:50 +1100
Message-id: <176890211061.16766.16354247063052030403@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, 20 Jan 2026, Christian Brauner wrote:
> On Tue, Jan 20, 2026 at 07:45:35AM +1100, NeilBrown wrote:
> > On Mon, 19 Jan 2026, Christian Brauner wrote:
> > > On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> > > > On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > > > > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > > > > > This was Chuck's suggested name. His point was that STABLE mean=
s that
> > > > > > > the FH's don't change during the lifetime of the file.
> > > > > > >=20
> > > > > > > I don't much care about the flag name, so if everyone likes PER=
SISTENT
> > > > > > > better I'll roll with that.
> > > > > >=20
> > > > > > I don't like PERSISTENT.
> > > > > > I'd rather call a spade a spade.
> > > > > >=20
> > > > > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > > > > or
> > > > > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > > > >=20
> > > > > > The issue here is NFS export and indirection doesn't bring any be=
nefits.
> > > > >=20
> > > > > No, it absolutely is not.  And the whole concept of calling somethi=
ng
> > > > > after the initial or main use is a recipe for a mess.
> > > >=20
> > > > We are calling it for it's only use.  If there was ever another use, =
we
> > > > could change the name if that made sense.  It is not a public name, it
> > > > is easy to change.
> > > >=20
> > > > >=20
> > > > > Pick a name that conveys what the flag is about, and document those
> > > > > semantics well.  This flag is about the fact that for a given file,
> > > > > as long as that file exists in the file system the handle is stable.
> > > > > Both stable and persistent are suitable for that, nfs is everything
> > > > > but.
> > > >=20
> > > > My understanding is that kernfs would not get the flag.
> > > > kernfs filehandles do not change as long as the file exist.
> > > > But this is not sufficient for the files to be usefully exported.
> > > >=20
> > > > I suspect kernfs does re-use filehandles relatively soon after the
> > > > file/object has been destroyed.  Maybe that is the real problem here:
> > > > filehandle reuse, not filehandle stability.
> > > >=20
> > > > Jeff: could you please give details (and preserve them in future cover
> > > > letters) of which filesystems are known to have problems and what
> > > > exactly those problems are?
> > > >=20
> > > > >=20
> > > > > Remember nfs also support volatile file handles, and other applicat=
ions
> > > > > might rely on this (I know of quite a few user space applications t=
hat
> > > > > do, but they are kinda hardwired to xfs anyway).
> > > >=20
> > > > The NFS protocol supports volatile file handles.  knfsd does not.
> > > > So maybe
> > > >   EXPORT_OP_NOT_NFSD_COMPATIBLE
> > > > might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> > > > (I prefer opt-out rather than opt-in because nfsd export was the
> > > > original purpose of export_operations, but it isn't something
> > > > I would fight for)
> > >=20
> > > I prefer one of the variants you proposed here but I don't particularly
> > > care. It's not a hill worth dying on. So if Christoph insists on the
> > > other name then I say let's just go with it.
> > >=20
> >=20
> > This sounds like you are recommending that we give in to bullying.
> > I would rather the decision be made based on the facts of the case, not
> > the opinions that are stated most bluntly.
> >=20
> > I actually think that what Christoph wants is actually quite different
> > from what Jeff wants, and maybe two flags are needed.  But I don't yet
> > have a clear understanding of what Christoph wants, so I cannot be sure.
>=20
> I've tried to indirectly ask whether you would be willing to compromise
> here or whether you want to insist on your alternative name. Apparently
> that didn't come through.

This would be the "not a hill worthy dying on" part of your statement.
I think I see that implication now.
But no, I don't think compromise is relevant.  I think the problem
statement as originally given by Jeff is misleading, and people have
been misled to an incorrect name.

>=20
> I'm unclear what your goal is in suggesting that I recommend "we" give
> into bullying. All it achieved was to further derail this thread.
>=20

The "We" is the same as the "us" in "let's just go with it".


> I also think it's not very helpful at v6 of the discussion to start
> figuring out what the actual key rift between Jeff's and Christoph's
> position is. If you've figured it out and gotten an agreement and this
> is already in, send a follow-up series.

v6?  v2 was posted today.  But maybe you are referring the some other
precursors.

The introductory statement in v2 is

   This patchset adds a flag that indicates whether the filesystem supports
   stable filehandles (i.e. that they don't change over the life of the
   file). It then makes any filesystem that doesn't set that flag
   ineligible for nfsd export.

Nobody else questioned the validity of that.  I do.
No evidence was given that there are *any* filesystems that don't
support stable filehandles.  The only filesystem mentioned is cgroups
and it DOES provide stable filehandles.

NeilBrown

