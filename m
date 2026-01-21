Return-Path: <linux-erofs+bounces-2127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CwaI7VXcWkNEwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 23:48:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70605F061
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 23:48:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxK9F3hqgz2xs1;
	Thu, 22 Jan 2026 09:48:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769035697;
	cv=none; b=BrPyzC77Yg+jIp2NTmJ+fAsHTeAYYuF/rWk4Ln2SmxNSMHL0WY0+/hQVxwK1wtOkLEuRcq9n/tMEjsFX0JSLf1oS8+TwFmJYqxt4igbdXOO7dEgf86wVmb8s5EslKkq7Wd5qSGjoczCcmqkbNovdU3fKvrJ1LOaqwjw3+Gh1z16+sUEW6ijXchp4st+YrbRLrFbDeDh8CMBAec92CQWSZ+vb51ipy1z3BDDh02wp2RtHJYPZ9Jeo9y4p9YIEriB1bSVmDNk+08Qnk1Yk4AUDcBtw548JCQMBx9B9pYNcwxxYKOBzGJItA9bnazQkeegLfKkGVsFA0Cs2//T2KwmOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769035697; c=relaxed/relaxed;
	bh=5coOyJl4iosEMxvKLf9pz/D+NbUu48dkiDD9Y2kxJME=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kIGzixeHHw41YJ0HXGD5t0Jfc6QM+4rJ3XtBqPCbQiB/AQCXhIDdjrgp4AOotFNFa7lBn+GS1yC8xucbg0KdtzjGxNfuu24Sqc1lOwF0kmVNsL7VQ7ZzV3dI3ac47A+utVQmRDMqaj4pJTPGOM2gnvC6RbdwyH7mmzsJVp732Zr0y6t50Ly2Y807xtuHB5NDF2WIi9OZwfhN0MlzAm1vmz4Rc8RzpE3+KnLCa23in56QnifOSPByX3nr1kz51HaER8SCQbz96xBcBkFGpymtkTuPQDxwTK6fp4EzdhzOpi6niaSVko20+oazaEmx596+dWFDKP1fDDKJyIRLWtBEgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=GuovOWXR; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GQln8ftB; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=GuovOWXR;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GQln8ftB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxK9B5XNDz2xl0
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 09:48:14 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 8D6A31300F24;
	Wed, 21 Jan 2026 17:48:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 17:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1769035688; x=1769042888; bh=5coOyJl4iosEMxvKLf9pz/D+NbUu48dkiDD
	9Y2kxJME=; b=GuovOWXRBLUE5OJcSyLnE/2eveX/36uTx36j9P93zjQcQRBZQL2
	hrnzBjQOgzs/f0q+zVSV1tWHCGJeldpGO5tNxzbNYGAmGERTI/74rC4AhDEcwnbN
	3EK+IxK9Da7qBxTZ0cL7/5RdElCmK5xx1WEmeVCQTAdbEDCJzhvLIyYH/VUBXRn2
	h49SQEqoXX9n4peKNOiWNTGeGPiK9qsGhIMzVRsfQ8nV0r0CSHnLs3nYhgIfpNL3
	aRQdXpKb6VS0ww0j3QddijYoBo1Kwrkcj+Ox1b+DG22Mrte7SY069e+GdbfIhnlj
	3VqqpOkLrd4aGQop2LrD926E4486pl+anPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035688; x=
	1769042888; bh=5coOyJl4iosEMxvKLf9pz/D+NbUu48dkiDD9Y2kxJME=; b=G
	Qln8ftBpavKFAA+sJNEPaaNr8oKurXmo3q4BaVp9GwaWB1fm8C563yxGcgYW93DS
	2xtNzCjbtolaXD67qz6Qutqe5geB5bsD8Ugeg6j/LWjxuo9XwZj1mmfo4drLgUP2
	yKqhpGLcalZ4u5NUgfoc97greSYLp54DwzSB4S6wHw4u2msQsbGk5ZA8IJMGNIbQ
	ngZ+8m6ZYaIowc/dHLMNgP5a1uqvjsJX/qkbUxNoCKOD6a2oW1oaQNc62xAi1nw9
	1ilzAzJcDO41rfb5T7w8GgYR5Vyc6IoiPl6WjnE4pmvyLFxhbYKi59Pm07XkqffD
	MH3MYMODbYPIXIIlLoSWg==
X-ME-Sender: <xms:o1dxaZ-cMFc_o0d43ug7z0kzLEBmcLr7-qnETyPvdBZuqqtXE2bH3w>
    <xme:o1dxaWu_cgJpAPDvXRifHWGeBvpSKMc12f7rFBgOoG_tMemlpn3xQTXYgCwgfa7tz
    OXDCzuK93xla979oqbjqOFhStCl3Vabm505SJATmkmL4XzdyA>
X-ME-Received: <xmr:o1dxaTxZPCOrm1mlblqPiWzOX285XPSCGpXm-fKvOvS9y7eJCkfR7O9aWP_lCWxHfYgXgfjqf3Vws4y9gRuwORW00qGz0381O1TtjVlRJXe1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o1dxabxtlAdkhpwCkINTEBpxmOYNyzwJPUiM41SluU32_hzzNA9XZQ>
    <xmx:o1dxafCKgd9STI3lGSZvVjQToHTy1h7liCKSrmU9waffzwMuC1NFUA>
    <xmx:o1dxaY793FR_a6LdPfr_ZHshxnAh_1jwBDA6jddarcyZMxIXycacjw>
    <xmx:o1dxaRMf9cXehnUejISjAclfFWLd7Zsy6-U0xLPbufXx8cPynQ1yZw>
    <xmx:qFdxaSd_vulaCSCn1gwPqzAJtzBUIYK-Pjhk-xVuA_6gzPYpL8lA2saQ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:47:43 -0500 (EST)
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Hugh Dickins" <hughd@google.com>,
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
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "David Laight" <david.laight.linux@gmail.com>,
 "Dave Chinner" <david@fromorbit.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/31] Documentation: document EXPORT_OP_NOLOCKS
In-reply-to: <d8d68d1df6838c382799ce58345cfb5366585a8f.camel@kernel.org>
References: <>, <d8d68d1df6838c382799ce58345cfb5366585a8f.camel@kernel.org>
Date: Thu, 22 Jan 2026 09:47:41 +1100
Message-id: <176903566115.16766.12892778448343562390@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2127-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:hch@infradead.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:amir73il@gmail.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:jack@suse.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:cem@kernel.org,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:clm@fb.com,m:dsterba@suse.com,m:luisbg@kernel.org,m:salah.triki@gmail.com,m:phillip@squashfs.org.uk,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:bharathsm@microsoft.com,m:miklos@szeredi.hu,m:hubcap@omnibond.com,m:martin@omnibond.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:almaz.alexandrovich@paragon-software.com,m:konishi.ryu
 suke@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:shaggy@kernel.org,m:dwmw2@infradead.org,m:richard@nod.at,m:jack@suse.cz,m:agruenba@redhat.com,m:hirofumi@mail.parknet.co.jp,m:jaegeuk@kernel.org,m:corbet@lwn.net,m:david.laight.linux@gmail.com,m:david@fromorbit.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-ext4@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-unionfs@vger.kernel.org,m:devel@lists.orangefs.org,m:ocfs2-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-mtd@lists.infradead.org,m:gfs2@lists.linux.dev,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,gmail.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,lwn.net,fromorbit.com,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.samba.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[77];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,ownmail.net:dkim,noble.neil.brown.name:mid,brown.name:replyto,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E70605F061
X-Rspamd-Action: no action

On Wed, 21 Jan 2026, Jeff Layton wrote:
> On Wed, 2026-01-21 at 20:58 +1100, NeilBrown wrote:
> > On Wed, 21 Jan 2026, Jeff Layton wrote:
> > > On Tue, 2026-01-20 at 09:12 -0500, Jeff Layton wrote:
> > > > On Tue, 2026-01-20 at 08:20 -0500, Jeff Layton wrote:
> > > > > On Mon, 2026-01-19 at 23:44 -0800, Christoph Hellwig wrote:
> > > > > > On Mon, Jan 19, 2026 at 11:26:18AM -0500, Jeff Layton wrote:
> > > > > > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem.=
 Some
> > > > > > > +    filesystems cannot properly support file locking as implem=
ented by
> > > > > > > +    nfsd. A case in point is reexport of NFS itself, which can=
't be done
> > > > > > > +    safely without coordinating the grace period handling. Oth=
er clustered
> > > > > > > +    and networked filesystems can be problematic here as well.
> > > > > >=20
> > > > > > I'm not sure this is very useful.  It really needs to document wh=
at
> > > > > > locking semantics nfs expects, because otherwise no reader will k=
now
> > > > > > if they set this or not.
> > > > >=20
> > > > > Fair point. I'll see if I can draft something better. Suggestions
> > > > > welcome.
> > > >=20
> > > > How about this?
> > > >=20
> > > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Files=
ystems
> > > > +    that want to support locking over NFS must support POSIX file lo=
cking
> > > > +    semantics and must handle lock recovery requests from clients af=
ter a
> > > > +    reboot. Most local disk, RAM, or pseudo-filesystems use the gene=
ric POSIX
> > > > +    locking support in the kernel and naturally provide this capabil=
ity. Network
> > > > +    or clustered filesystems usually need special handling to do thi=
s properly.
> > >=20
> > > Even better, I think?
> > >=20
> > > +
> > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Filesys=
tems
> > > +    that want to support locking over NFS must support POSIX file lock=
ing
> > > +    semantics. When the server reboots, the clients will issue request=
s to
> > > +    recover their locks, which nfsd will issue to the filesystem as ne=
w lock
> > > +    requests. Those must succeed in order for lock recovery to work. M=
ost
> > > +    local disk, RAM, or pseudo-filesystems use the generic POSIX locki=
ng
> > > +    support in the kernel and naturally provide this capability. Netwo=
rk or
> > > +    clustered filesystems usually need special handling to do this pro=
perly.
> > > +    Set this flag on filesystems that can't guarantee the proper seman=
tics
> > > +    (e.g. reexported NFS).
> >=20
> > I think this is quite thorough, which it good ...  maybe too good :-) It
> > reminds me that for true NFS compatibility the fs shouldn't allow local
> > locks (or file opens!) until the grace period has passed.  I don't think
> > any local filesystems enforce that - it would have to be locks.c that
> > does I expect.  I doubt there would be much appetite for doing that
> > though.
> >=20
>=20
> Yeah, I don't see us ever doing that. It'd be a tricky chicken-and-egg
> problem, given the demand-driven way that the mountd upcalls work
> today. We don't even know that anything is exported until something
> asks for it.

statd keeps state in /var/lib/nfs/sm, and nfsd keeps v4 state elsewhere
in /var/lib/nfs.  This state effectively records if any NFS client might
try to recover a lock.
I think the v4 state is granular enough to identify the filesystem.
lockd could be enhanced to use the same state I suspect.

We would need to generalise that state and load it at mount time and
block new state creation accordingly.

i.e. this would have to be a vfs-level thing which nfsd makes use of.

Possibly, but there are other things better worth our time.

NeilBrown


