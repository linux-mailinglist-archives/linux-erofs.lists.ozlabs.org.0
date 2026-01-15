Return-Path: <linux-erofs+bounces-1920-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FFD27931
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 19:32:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsWmt45bSz2yFm;
	Fri, 16 Jan 2026 05:32:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768501950;
	cv=none; b=OyhZtDz8EOmM5kIh2dSe/zbo+aYHEEruXoml7ZzCBPmwrhcB9pv+r5SeS+uXd70c87rM+9PPXiX3Wysi5qH+1ndZSVWQJLjdd8dSzqvVEGGn2wAyFmPVcmZrTun6McAMLL+AbkWEFuFxb05u6awGEoy5JI60jEgWA+CNpFY0Qa8n6Ht7VYnMX5pTN9qlvT3f7HUim416WnKPADC+8ooipDoCD245RYrZhdwJrJK0nOcnk/b27/MfePyH2wn+70MdE/vWyu4aV03ZmPQhjp+6CR5wT9W4ogEgxbGnXkMHQ//khRslA5aGJzWcQ35T2qF+tiUqnXJYLCQhYfGlcbm/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768501950; c=relaxed/relaxed;
	bh=mu/jwyuzs1woV3EsPbDGdDC5dwANFYIHrH4NaGlTLGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cKQdvjKRLzeh4N0EzfJgqnc3sTNHG3Nj2SqA7jGeusRZ077CXCEJCxFWJDh3ZFQYiXBKzUrjYltqUBdjSsBxgiz2rhSNJLDjCnp11gdZ+CGHMaf3iDkhNMnTkXcqnRDL2kpdL+1AEuM/OC3eq68d5jwrzihzsMHVLZ7CqkVN5CDqjbgpVRto/LT4TY53xd2xLm5sOyODYD6DfxqplNR3BKvlg6l1DkKPVweLggjntj9EkjTc85oYWSQWbqRZtP2frjAF7UaL+RsGt3jspRD7wYcgBJhuIfN40vB5So6MVTZVD+Nv2LIbobnUlBqSEFRxlQ7zG9rHGzKgsoThbRAIKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G9sGnGZH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=G9sGnGZH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsWms5vvVz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 05:32:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0464344465;
	Thu, 15 Jan 2026 18:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68253C2BC9E;
	Thu, 15 Jan 2026 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768501947;
	bh=mu/jwyuzs1woV3EsPbDGdDC5dwANFYIHrH4NaGlTLGQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=G9sGnGZHrQX8Py4KAlmLNGCj84evUTtPWpI0OS0q9xnBsK6HoqJ9r8k3RoRYPTAcs
	 dKywez4yA4fFtyxHzR0fZNCFuS18YpqsdG+dwnYZYTLrQiMxCX+dFVTuWs4vq+DzQh
	 AH6ncgzpyM5N289efGIGJ9Brgc8HkLGVcxqQ5aWDWAB356igSFZFTtM+DEJ3lJK1S3
	 vBLW+TOFHi4t9uHXSsfiThY58trbJsC6WSdqDTUXWiyWYJ7VHOgEQvJv6FSugBzFBT
	 ch87ZiNjAoI02FRZKay/K5tcBz2P4MFR2uvy8rr1JiNjhQqZylMHcSTEm8NQUjT3QY
	 5WmIIwSvnHsjw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4BF17F40069;
	Thu, 15 Jan 2026 13:32:25 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 13:32:25 -0500
X-ME-Sender: <xms:uTJpaST2S_BQmvIoVXUTG3Uv00CIkT_f-EbDQ1KH8vIlVQcwDXypQQ>
    <xme:uTJpaSn5OoyclbrYS_ARTUh6TEP2VOjUGj53_LG2lxkjeVICq65KK1J-vKaQ4Q1LV
    V04RbrQdCpqL5Mvp67L_2A99E7e0MjEKZHGQg6du4B2aAO0ZSdxuww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeijeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peehtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopegrughilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgt
    rgdprhgtphhtthhopehslhgrvhgrseguuhgsvgihkhhordgtohhmpdhrtghpthhtohepjh
    hlsggvtgesvghvihhlphhlrghnrdhorhhgpdhrtghpthhtohepmhgrrhhksehfrghshhgv
    hhdrtghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegrmhhirh
    ejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehiughrhihomhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehkohhnihhshhhirdhrhihushhukhgvsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:uTJpaX8XlASeI3-hQVJmMxlK8TxdmBSwTtFsbhSoxL3UV4Wvip7VrA>
    <xmx:uTJpaZqkkN3176e2LvdCG3veTiN-GTqcScuGt9t_e1DrtMHWJT3eyA>
    <xmx:uTJpaet8tZs4QdmQ9KbY-CWNsY3QfKFOvT9QPuO68BSRBM5oq_7Zeg>
    <xmx:uTJpaUR2QUA-L1hS5UnoJ8HhY1Uu2p18HC8n7POL1S450zS9m_Kiew>
    <xmx:uTJpaYWzGNFQ6fy0VRVsd1um1FRTenoVzHGzsRuwWHvuFBVbXXDnMbke>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 155C8780070; Thu, 15 Jan 2026 13:32:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: A7-j_yKLHrMN
Date: Thu, 15 Jan 2026 13:31:54 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Tso" <tytso@mit.edu>,
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
Message-Id: <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to nfsd export
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
>>
>> In recent years, a number of filesystems that can't present stable
>> filehandles have grown struct export_operations. They've mostly done
>> this for local use-cases (enabling open_by_handle_at() and the like).
>> Unfortunately, having export_operations is generally sufficient to ma=
ke
>> a filesystem be considered exportable via nfsd, but that requires that
>> the server present stable filehandles.
>
> Where does the term "stable file handles" come from? and what does it =
mean?
> Why not "persistent handles", which is described in NFS and SMB specs?
>
> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> by both Christoph and Christian:
>
> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018=
e93c00c@brauner/
>
> Am I missing anything?

PERSISTENT generally implies that the file handle is saved on
persistent storage. This is not true of tmpfs.

The use of "stable" means that the file handle is stable for
the life of the file. This /is/ true of tmpfs.

--=20
Chuck Lever

