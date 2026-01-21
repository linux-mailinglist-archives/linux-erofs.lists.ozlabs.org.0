Return-Path: <linux-erofs+bounces-2106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLUcLAdPcGlvXQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 04:59:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6372E50B50
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 04:59:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwr6C5N96z2yDY;
	Wed, 21 Jan 2026 14:58:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768967939;
	cv=none; b=lg3y5WV8HwJl7aZcGs8IsD9QRhkC4MEziPfDqZkh1MRIg3ro1OnWQKhgW4gnAhPP+PIVFS4e1LDZIW6J5DBrn+A3PUb/O4YhCMkqRidDZOFNGbvgb3icPnMQmXyx6xV0Omo7rhRSNsnAX/Mb3oPnqP7rSTYtsZja1S6eHN+V/ulrk86YIR9AecYE3PVdONaVje/Esohr2F06Bx+RQCpTZ6nIYdSuDFYZJpjtOPrFhxowE2gvo9gA5LzF8E2JmM5nbh/XkEzNRYvLugTfSxztwyXpUVLeeAPchvc/XCb84QbsndEW27IUWexcu+OvRRbo24M7BVpou6S+8D29x8hmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768967939; c=relaxed/relaxed;
	bh=HPgiNusZcZTF/ZTl66piD/9BsmWo5Gc2+jAKaL+zbjo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=brb0zYiIvceImgqQqnP77W64cL3i52G28Ig4uPkde916NciL0COeDORvKZI9sphPFgHYSTZfDxSmhVNLV2hUcXNo0q6owXMGRTu58tCGiWLWyY4677yrA5v/50jPc4mEAWapBulC7JzgIOf7ilKB10HZx/6l7f/R+zfOVDK+TwTNnUXsuXShJdiFt+q7nousAhgWy/mY3lnBdv15a11Rqx2fWiH4ZLh6/0jqJBTAznWZk8Oa5Az8HZ9JnnwspdFtX+DMv5yJMWYBWMsU9M4kC+iNw7oiVj1DNthzrZjMJN/vd7yMF4+Vqi67Icsyqez/be2EONVbqfOujCtA+msE6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=YYEr2VjW; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y4kSyYfn; dkim-atps=neutral; spf=pass (client-ip=103.168.172.138; helo=flow-a3-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=YYEr2VjW;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y4kSyYfn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=103.168.172.138; helo=flow-a3-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwr676PgTz2xqD
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 14:58:54 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 59F6C1380787;
	Tue, 20 Jan 2026 22:58:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 22:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768967931; x=1768975131; bh=HPgiNusZcZTF/ZTl66piD/9BsmWo5Gc2+jA
	KaL+zbjo=; b=YYEr2VjWIaKtDqIQ9vfEWExooQB7WdoWCHPbIyCUEJI6BAxeQcQ
	Lbk8vsbd4GXH0kYHJaGcChinGdfj9GfFjBP2dVOEb1g7c0vP40XWPDTq6qbmdX+f
	q8U4adtBeg5EFoL6E5HUF62j7hOUy4j8XFCT0i4fYg4se8kZH51qgrZqOSAUlTga
	rl7CFzO8J+PeDJ7M2JSUWHisN0sDH8S0NMXRz8qdtkwm9W98zD3C3gklDbkWIXrK
	vRegxtY4BxrRjprMIjBdoVNMCKrXQqfmvm/+rjsgzuPUZ23gzBTcc6UXYC33cLAY
	vFj8n0R7qJgD5zcyYlJT/0wZ8oNx4to8Sng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768967931; x=
	1768975131; bh=HPgiNusZcZTF/ZTl66piD/9BsmWo5Gc2+jAKaL+zbjo=; b=Y
	4kSyYfnUGNoNeVLU3ka40YnKW2sl+45SitUqyg7vTCZpQcxFqZev1sh8sHAo4DzB
	LJJuIPm7kr1a2T2O/jCPPqyfpx1RyAZnMeJxrzQuzh0MJ2v9HwC0x1U/ypjUALTY
	LkBS/sHDc8LkvX0vZjnTUcBNoleBEEaONsgjyNXSYbPCsyTNNhNqwnjeRYEYWhC0
	Keyf4hXJLJ2uIP8nM1JZTI64DK90fYZcMdZmLKhtCiDOLF6zK0pOuLIFL3efcAnh
	U7QNK8cCXtqL4iHqmwf38GI0o4feHmUs9gVmK1fgy3LCnOLy087fTAjf+2UjG0tL
	Zxk2nmIhddHGej/ASyZkw==
X-ME-Sender: <xms:9k5waa6xGMlhNWG7OiNFHfIpLvabWA1DAPtyEn94taKAb8B-mUoW7w>
    <xme:9k5waRR7ItrMgf6WBso9qWSvOzTjS1gqDa4US3nP2_YPOGpBhCwjdwQRddvH-EWFV
    V57p5_-4xzEl4CNusEssTAjoVs4ZFelbrYFxoXbJ50yHbQn>
X-ME-Received: <xmr:9k5waeoZsLXtAC9WGWMpKfuL6jcuFf0eBU9OKagBSlfpxrmBa-z1UpdKQRgAi22TvEjMRNRptGtFkHbPbhda8VF8Vv99_8wlEjUQv-qrj4y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvvdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9k5waUhf0LUODlL_PQYsCPf5h1Hz9YtKoS8AL4OAL0YUoX9vGv32rg>
    <xmx:905waSCsyLL7f6fuPyvb6LM-a8AMULf8pIsT5TNPUcN888plxn2vJQ>
    <xmx:905waT9XbBSmLAgfzGT6kRdfvn_ApgSn62i1cNhe3-zAYtSYAOgBDQ>
    <xmx:905waTEUm6W92v2m08NAsDI3Dm--lHbflm-x_CKDQ7Y36cOw-DiEBA>
    <xmx:-05waa7eNM5AFWgAvsYRXTN-gn5rTHGxvGEPMtNHM76v4SM6_x2afNUS>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 22:58:29 -0500 (EST)
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
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
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
In-reply-to: <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>,
 <176885553525.16766.291581709413217562@noble.neil.brown.name>,
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner>,
 <176890211061.16766.16354247063052030403@noble.neil.brown.name>,
 <20260120-hacken-revision-88209121ac2c@brauner>,
 <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
Date: Wed, 21 Jan 2026 14:58:25 +1100
Message-id: <176896790525.16766.11792073987699294594@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2106-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:brauner@kernel.org,m:hch@infradead.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:jack@suse.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:cem@kernel.org,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:clm@fb.com,m:dsterba@suse.com,m:luisbg@kernel.org,m:salah.triki@gmail.com,m:phillip@squashfs.org.uk,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:bharathsm@microsoft.com,m:miklos@szeredi.hu,m:hubcap@omnibond.com,m:martin@omnibond.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:almaz.alexandrovich@paragon-software.com,m:konishi.ryu
 suke@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:shaggy@kernel.org,m:dwmw2@infradead.org,m:richard@nod.at,m:jack@suse.cz,m:agruenba@redhat.com,m:hirofumi@mail.parknet.co.jp,m:jaegeuk@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-ext4@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:devel@lists.orangefs.org,m:ocfs2-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-mtd@lists.infradead.org,m:gfs2@lists.linux.dev,m:linux-f2fs-devel@lists.sourceforge.net,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[72];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 6372E50B50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026, Jeff Layton wrote:
> On Tue, 2026-01-20 at 11:31 +0100, Christian Brauner wrote:
> > On Tue, Jan 20, 2026 at 08:41:50PM +1100, NeilBrown wrote:
> > > On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > > On Tue, Jan 20, 2026 at 07:45:35AM +1100, NeilBrown wrote:
> > > > > On Mon, 19 Jan 2026, Christian Brauner wrote:
> > > > > > On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> > > > > > > On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > > > > > > > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > > > > > > > > This was Chuck's suggested name. His point was that STABL=
E means that
> > > > > > > > > > the FH's don't change during the lifetime of the file.
> > > > > > > > > >=20
> > > > > > > > > > I don't much care about the flag name, so if everyone lik=
es PERSISTENT
> > > > > > > > > > better I'll roll with that.
> > > > > > > > >=20
> > > > > > > > > I don't like PERSISTENT.
> > > > > > > > > I'd rather call a spade a spade.
> > > > > > > > >=20
> > > > > > > > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > > > > > > > or
> > > > > > > > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > > > > > > >=20
> > > > > > > > > The issue here is NFS export and indirection doesn't bring =
any benefits.
> > > > > > > >=20
> > > > > > > > No, it absolutely is not.  And the whole concept of calling s=
omething
> > > > > > > > after the initial or main use is a recipe for a mess.
> > > > > > >=20
> > > > > > > We are calling it for it's only use.  If there was ever another=
 use, we
> > > > > > > could change the name if that made sense.  It is not a public n=
ame, it
> > > > > > > is easy to change.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Pick a name that conveys what the flag is about, and document=
 those
> > > > > > > > semantics well.  This flag is about the fact that for a given=
 file,
> > > > > > > > as long as that file exists in the file system the handle is =
stable.
> > > > > > > > Both stable and persistent are suitable for that, nfs is ever=
ything
> > > > > > > > but.
> > > > > > >=20
> > > > > > > My understanding is that kernfs would not get the flag.
> > > > > > > kernfs filehandles do not change as long as the file exist.
> > > > > > > But this is not sufficient for the files to be usefully exporte=
d.
> > > > > > >=20
> > > > > > > I suspect kernfs does re-use filehandles relatively soon after =
the
> > > > > > > file/object has been destroyed.  Maybe that is the real problem=
 here:
> > > > > > > filehandle reuse, not filehandle stability.
> > > > > > >=20
> > > > > > > Jeff: could you please give details (and preserve them in futur=
e cover
> > > > > > > letters) of which filesystems are known to have problems and wh=
at
> > > > > > > exactly those problems are?
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > Remember nfs also support volatile file handles, and other ap=
plications
> > > > > > > > might rely on this (I know of quite a few user space applicat=
ions that
> > > > > > > > do, but they are kinda hardwired to xfs anyway).
> > > > > > >=20
> > > > > > > The NFS protocol supports volatile file handles.  knfsd does no=
t.
> > > > > > > So maybe
> > > > > > >   EXPORT_OP_NOT_NFSD_COMPATIBLE
> > > > > > > might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> > > > > > > (I prefer opt-out rather than opt-in because nfsd export was the
> > > > > > > original purpose of export_operations, but it isn't something
> > > > > > > I would fight for)
> > > > > >=20
> > > > > > I prefer one of the variants you proposed here but I don't partic=
ularly
> > > > > > care. It's not a hill worth dying on. So if Christoph insists on =
the
> > > > > > other name then I say let's just go with it.
> > > > > >=20
> > > > >=20
> > > > > This sounds like you are recommending that we give in to bullying.
> > > > > I would rather the decision be made based on the facts of the case,=
 not
> > > > > the opinions that are stated most bluntly.
> > > > >=20
> > > > > I actually think that what Christoph wants is actually quite differ=
ent
> > > > > from what Jeff wants, and maybe two flags are needed.  But I don't =
yet
> > > > > have a clear understanding of what Christoph wants, so I cannot be =
sure.
> > > >=20
> > > > I've tried to indirectly ask whether you would be willing to compromi=
se
> > > > here or whether you want to insist on your alternative name. Apparent=
ly
> > > > that didn't come through.
> > >=20
> > > This would be the "not a hill worthy dying on" part of your statement.
> > > I think I see that implication now.
> > > But no, I don't think compromise is relevant.  I think the problem
> > > statement as originally given by Jeff is misleading, and people have
> > > been misled to an incorrect name.
> > >=20
> > > >=20
> > > > I'm unclear what your goal is in suggesting that I recommend "we" give
> > > > into bullying. All it achieved was to further derail this thread.
> > > >=20
> > >=20
> > > The "We" is the same as the "us" in "let's just go with it".
> > >=20
> > >=20
> > > > I also think it's not very helpful at v6 of the discussion to start
> > > > figuring out what the actual key rift between Jeff's and Christoph's
> > > > position is. If you've figured it out and gotten an agreement and this
> > > > is already in, send a follow-up series.
> > >=20
> > > v6?  v2 was posted today.  But maybe you are referring the some other
> > > precursors.
> > >=20
> > > The introductory statement in v2 is
> > >=20
> > >    This patchset adds a flag that indicates whether the filesystem supp=
orts
> > >    stable filehandles (i.e. that they don't change over the life of the
> > >    file). It then makes any filesystem that doesn't set that flag
> > >    ineligible for nfsd export.
> > >=20
> > > Nobody else questioned the validity of that.  I do.
> > > No evidence was given that there are *any* filesystems that don't
> > > support stable filehandles.  The only filesystem mentioned is cgroups
> > > and it DOES provide stable filehandles.
> >=20
>=20
> Across reboot? Not really.

Across reboot all the files are deleted and then new ones are created.
So there is nothing that needs to be stable.

>=20
> It's quite possible that we may end up with the same "id" numbers in
> cgroupfs on a new incarnation of the filesystem after a reboot. The
> files in there are not the same ones as the ones before, but their
> filehandles may match because kernfs doesn't factor in an i_generation
> number.

That is is about filehandle re-use, not about filehandle stability.

>=20
> Could we fix it by adding a random i_generation value or something?
> Possibly, but there really isn't a good use-case that I can see for
> allowing cgroupfs to be exported via nfsd. Best to disallow it until
> someone comes up with one.

100% agree.

>=20
> > Oh yes we did. And this is a merry-go-round.
> >=20
> > It is very much fine for a filesystems to support file handles without
> > wanting to support exporting via NFS. That is especially true for
> > in-kernel pseudo filesystems.
> >=20
> > As I've said before multiple times I want a way to allow filesystems
> > such as pidfs and nsfs to use file handles without supporting export.
> > Whatever that fscking flag is called at this point I fundamentally don't
> > care. And we are reliving the same arguments over and over.
> >=20
> > I will _hard NAK_ anything that starts mandating that export of
> > filesystems must be allowed simply because their file handles fit export
> > criteria. I do not care whether pidfs or nsfs file handles fit the bill.
> > They will not be exported.
>=20
> I don't really care what we call the flag. I do care a little about
> what its semantics are, but the effect should be to ensure that fs
> maintainers make a conscious decision about whether nfsd export should
> be allowed on the filesystem.=C2=A0

Why do you need a conscious decision so much that you want to try to
force it.
Of course we want conscious decisions and hope they are always made, but
trying to manipulate people to doing things often fails.  How sure are
you that fs developers won't just copy-paste some other implementation
and not think about the implications of the flag?

What is the down side?  What is the harm from allowing export (should the
admin attempt it)?
If there were serious security concerns - then sure, make it harder to
do the dangerous thing.
But if it is just "it doesn't make sense", then there is no harm in
letting people get away with not reading the documentation, and fixing
things later as complaints arrive.  That is generally how the process
works.

But if you really really want to set this new flag on almost every
export_operations, can I ask that you please set it on EVERY export
operations, then allow maintainers to remove it as they see fit.
I think that approach would be much easier to review.

With your current series it is non-trivial to determine which
export_operations you have chosen not to set the flag on.  If you had
one patch that set it everywhere, then individual patches to remove it,
that would be a lot easier to review.

Thanks,
NeilBrown


>=20
> At this point, maybe we should just go with Neil's=20
> EXPORT_OP_SUPPORTS_NFS_EXPORT or something. It's much more arbitrary,
> than trying to base this on criteria about filehandle stability, but it
> would give us the effect we want.
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


