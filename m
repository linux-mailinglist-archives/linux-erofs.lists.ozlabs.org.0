Return-Path: <linux-erofs+bounces-2119-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MhIAMKrcGkgZAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2119-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 11:34:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC855467
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 11:34:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dx0tg6TxGz2xqD;
	Wed, 21 Jan 2026 21:34:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768991675;
	cv=none; b=OCrNdRYkw3dS7pcpLI0qGn0F8K5/oO3VTeVEeVNGFjqS9mzUnkhmna7w7IS/WZlhPxNvetb4qgrhtDgas9tBZDlcu6mcsWzKWEEX8cO+3gQ54y7TnxKKLlC9k7IoP1msI29LP6He1vqeIz53KHBE/+tWaGFWWoi91/JhFTa9lP+pWtQ7r0d6sBe1KaZYelLxe1o8wsbrBWA4fv649dyWSu2zSLIn6o7vGQ51gB/j16fNEwtRe6XPo7Xw5/7M8ahIeRtJAgYVIsVWvAYbCdHwVKfJcYbVUDvpFe0VUaCwdI4AXEGf9MjJ1CUil2o/wrTT/Joxe+mjQBRR85rArlfDng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768991675; c=relaxed/relaxed;
	bh=K9j3jhKpFIpiUQJzHWR2x3eEHOIQSB6ye1vrprKdmzg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Pg5MdlckgZYEzoi3cBK+VNCJ5an8DSEPaxmQ2fUC36TVWTcYJBGCdTkUwq3wHWZsKs7x3IGpo4Iu6WUTJqlMWab80k0J1ovn3w3Z/Mn0NolBQNpn3JTBGg5MfpmlrV/zVJnW1T51qaROhkie3jXdueu2TgfPcpEjWZgkCCnnEliqcpYel+td8NbQysIegKqqVSMp7pvyvfdSsRpnEYxwD3iuTFHPxpr5w8ZLShdrBVfToc11Xj/jzElJ6AoWjmmebF0qSAq3/H6eUjrpbpU34WD+PPc1WJekvS1iL6kW5Df37nOucB4fERbDvfg9D4PtmMZr/LmPUCIM3vsrO8tvzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=kv5lmdgw; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o4LwLi0F; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=kv5lmdgw;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o4LwLi0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dx0tf4Ymvz2xm5
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 21:34:34 +1100 (AEDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 14B671300419;
	Wed, 21 Jan 2026 05:34:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 21 Jan 2026 05:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768991669; x=1768998869; bh=K9j3jhKpFIpiUQJzHWR2x3eEHOIQSB6ye1v
	rprKdmzg=; b=kv5lmdgwptpNtolMex40wHyYDtu1zR3kROgUgHa9dV4DF424TII
	xz8dxcyqZv5vn+C5E7je63p/kUX6FA6DJv49ZG4TEvmE9CmQROcNdltD80UCq70F
	67OKAnNM8oyAk8/zKVARKWIUXc/0rwj0A3HsU66MhxNwBVK6BifqALpBS3KNgyjp
	P0XbAYs6phH+mnFqRoXC1mh9pnuNQ+fFEwhXXc1sSnndee26t3rwwjTbJtTESJ9H
	fxgBNTVTQMWx/Tnp/sidQDM5zxfwLw4V6i5O5idHrafun9SF76YRjqhEkQ+5kNcK
	HcmbYYUHLFntzBcrv0lywLVtTimlIcl+nQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768991669; x=
	1768998869; bh=K9j3jhKpFIpiUQJzHWR2x3eEHOIQSB6ye1vrprKdmzg=; b=o
	4LwLi0FQ1jEf8fskqm7+L10I5i+E4UcJvDl06S22E2N6MVzowyCMRqm/bH1M2J1a
	JDwioi/R98Kd4aywyn9uZLSOM7z8MArbO4E7czObG95qdFlOtvQuQeCk3G1ZaKic
	Tehtuqj1UGP3Eb7Ucl15f9362hASG+CEClGzitcQtKQLQ9R6sDLQi76cFZsvhiXR
	ga+keMqdKP1sZXq4AW8N7RVWcf1Wq1jiHpO0YXPueFkCr92lRvi0sx0LsAgnwX8p
	AKZCnY9vD6dcgSVBcblBk6RRY3JRRT1CNgtvJrCkNeFsfbLaIXO8m2mpKZ7xfZXV
	VHjPUcyIoRUMrrAPKWG+w==
X-ME-Sender: <xms:sqtwaejzMMYRFV89Y0xjhbUY2Ux7NPR7lm9XvAv8w1i7kASo3nK0Zw>
    <xme:sqtwacbJbsKb0ZWVMi2Ld61rpE_gwOTUmZUOuIFkObP6qtSchisKdfJNZxw0XqFd2
    dpJMMfqKKl9ncf8qF50uKZThAPLp5_pMzEv9z25paWGdt3g-rQ>
X-ME-Received: <xmr:sqtwabSH-RRobwNx5gak-6jfqjdFsk_YBqmqf4AohoRb2sCX2uoyp4QOYu7NMlajZX_Q1etTmNQaSqmVM8w660ms4W7YiwL8iGuB03vkYszh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeftdehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sqtwaUqa76K57jmkll9tnYEPNFtkwAFRAIOxkmOCTcJg3wPstOKebw>
    <xmx:sqtwafqX8Nkd7EHiHXFk0lbznDX828ETkTyNFowHaBS8I4Kgjb_iRQ>
    <xmx:sqtwaRGfSRcbTn7ju_6NXus6mwh9CX54E07yQqtkZf6nvJqjRrtQ3A>
    <xmx:sqtwaZtU8f1xqg3JxB6L05BW89l7H_7-dfzynjFDw6dcCKuLsBgwHQ>
    <xmx:tatwaYpYIXr04Y4VvYfBrbHTBHEkDGuPdYscX8VKwQ1WEKpEcFWHhm0u>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 05:34:08 -0500 (EST)
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
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
In-reply-to: <aXCg-MqXH0E6IuwS@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>,
 <176885553525.16766.291581709413217562@noble.neil.brown.name>,
 <aW8w2SRyFnmA2uqk@infradead.org>,
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>,
 <aXCg-MqXH0E6IuwS@infradead.org>
Date: Wed, 21 Jan 2026 21:34:04 +1100
Message-id: <176899164457.16766.16099772451425825775@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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
	TAGGED_FROM(0.00)[bounces-2119-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:brauner@kernel.org,m:jlayton@kernel.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:jack@suse.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:cem@kernel.org,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:clm@fb.com,m:dsterba@suse.com,m:luisbg@kernel.org,m:salah.triki@gmail.com,m:phillip@squashfs.org.uk,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:bharathsm@microsoft.com,m:miklos@szeredi.hu,m:hubcap@omnibond.com,m:martin@omnibond.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:almaz.alexandrovich@paragon-software.com,m:konishi.ryu
 suke@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:shaggy@kernel.org,m:dwmw2@infradead.org,m:richard@nod.at,m:jack@suse.cz,m:agruenba@redhat.com,m:hirofumi@mail.parknet.co.jp,m:jaegeuk@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-ext4@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:devel@lists.orangefs.org,m:ocfs2-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-mtd@lists.infradead.org,m:gfs2@lists.linux.dev,m:linux-f2fs-devel@lists.sourceforge.net,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[73];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,noble.neil.brown.name:mid,brown.name:replyto,ownmail.net:dkim]
X-Rspamd-Queue-Id: 8EAC855467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 08:27:46PM +1100, NeilBrown wrote:
> > > If you think NFS actually explains the semantics pretty well, please
> > > explain that too, especially in forms that can be put into
> > > documentation, including for the user ABI.
> > 
> > There are multiple issues here:
> > 
> >  - filehandle stability.  As far as I know all filesystems provide
> >    stable filehandles when the "subtree_check" export option is not used.
> 
> That is news to me, but certainly interesting.  Does this include not
> reusing the file handle for a new incarnation of the same thing?

"stable" and "reuse" are quite distinct concepts in my mind.
"a new incarnation of the same thing" is in my experience a new thing.
  rmdir foo: mkdir foo
on an empty directory will create a new incarnation of the same thing.
But it will appear to be different in various ways.

Names, not file handles, are generally used for new incarnations of the
same thing (again - in my experience).

I cannot 100% guarantee that all fs's provide filehandle stability, but
I am not aware of any, and none have been presented in this discussion.

It is true that the NFSv4 spec claims to allow them but I find the
details provided insufficient.
They might be able to work reliably if the server provided a delegation, but
without it I don't think they can be used reliably.  I'm certainly not
aware of any attempt to support them in Linux client or server.
(I know Trond doesn't like "connectable" file handles).

> 
> >    Certainly cgroupfs does.  So having an EXPORT_OP_STABLE_HANDLES
> >    flag would mean it was set for every filesystem - unless there is
> >    something else I'm not aware of.  That is certainly possible and I
> >    hope someone will let me know if I'm missing something.
> 
> Well, if does not provide stable file handles with the subtree_check
> export option, or more importantly with the CONNECTABLE flag passed
> to encode_fh, which is the level we're operating on, it can't set the
> flag.
> 

Hmmm...  I didn't know that open_by_handle_at() supported CONNECTABLE
requests. That seems relatively recent.

If CONNECTABLE is requested, then only directories get stable
filehandles.
If CONNECTABLE is not requested, then all filehandles should be stable.



> >  - filehandle uniqueness.  This is somewhat important and if a
> >    filesystem doesn't provide it, that should be considered a bug.  In a
> >    different thread Christian has observed that there would be benefit
> >    if pidfs and nsfs provided uniqueness across reboots.  It is quite
> >    easy for a virtual filesystem to generate a 64 bit random number when
> >    the fs is initialised, and include that in file handles.  Having a
> >    EXPORT_OP_REUSES_HANDLES flag could mark filesystems that are still
> >    buggy if that is thought to be useful.
> 
> Yes.
> 
> >  - GETATTR always reporting file size of 0.  This is the only concrete
> >    symptom that Jeff has reported (that I have seen).  This  makes it
> >    impossible to read files over NFS even if they have content.
> >    Would EXPORT_OP_INACCURATE_SIZE be useful?
> 
> i_size = 0 for a regular file sounds like a genuine bug to me.  I'm
> actually surprised anything works with that.

Files in /proc are all size zero.
Files in /sys seem to be all 4096 (or maybe PAGE_SIZE).
Files in /sys/kernel/security are all size zero
Files in /sys/fs/cgroup are all zero

I agree it is weird, but it seems to work ...  though I do have a vague
memory of something not working because it used a library function to
read a file, and it needed to be fixed.  No details come to mind except
that it was probably md related.

As some of these virtual files can be different every time they are
read, there is TOCTOU issue with trying to make the i_size accurately
reflect the result of a subsequent read.  I think the cost of setting an
accurate i_size even when it is possible is not seen as worth while.

> 
> >  - maintainer feature choice.  A maintainer may choose not to support
> >    export over NFS because they feel that there is no value and the
> >    possible support burden would not be worth it.
> 
> The maintainer has no way to disallow exporting through nfs.  They can
> at best disallow exporting using the kernel nfs daemon if we provide
> that facility.  But as I've argued multiple times, making arbitrary,
> selective and very narrow choices about use cases without technical
> backing for them (which then would be expressable as a flag like those
> listed by you above) is really bad software development practice, and
> not something that we usually do in the Linux kernel.

True: once you make files available to people you cannot control what
people will do with them.
So maybe you are saying "what is so special about knfsd that it gets
information that no-one else can get".  I cannot argue against that.

> 
> >    There may be locking
> >    / lease / etc issues that further complicate things.  So it might be
> >    reasonable for a maintainer to choose to forbid NFS export while
> >    allowing local fhandle access. EXPORT_OP_NO_NFS_EXPORT.
> 
> We already have a EXPORT_OP_NOLOCKS flag to deal with this.
> 
> > 
> > It took me a while to sift through the code/patches/comments and come to
> > this understanding and I apologise if I wasn't as clear earlier.  But
> > my intuition was always that file handle stability was never the real
> > issue, and maintainer choice was.  Hence my rejection of the
> > "STABLE_HANDLES" name.
> 
> Why do you keep ignoring the fat that the stable handles are really
> important for anyone wanting to actually use them for their original
> storage purpose, be that for knfsd, a userland nfs damon, or other
> storage applications in userspace despite explaining this countless
> times?
> 

It isn't that I don't think they are important.  It is that I think they
are universally provided (when not connectable).
If we add an EXPORT_OP_STABLE_FILEHANDLES flag, I believe we would need to
set it on every export_operations structure.  So what would be the
point?

Thanks,
NeilBrown

