Return-Path: <linux-erofs+bounces-2115-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCKxK1WjcGlyYgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2115-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 10:58:45 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABD54C9E
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 10:58:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dx05F5qpNz308l;
	Wed, 21 Jan 2026 20:58:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768989521;
	cv=none; b=nnsEWFFRJCosngiwWDvq2nFDli2FOetUKzxqxm/JZORcAeLimzxaJ6dlM3PI3DcDgEoEScstrjzCQ4bXIP9jURvab0wUyASwH20tCxrri5+vJt8YehsHvXgvR5mwl3qEJ9lMq+sLER8dROGQnJShL9gzRLHdic8unRVYXribI6XQH/sjZVf1bea4bir1oeO756sMeS8hnmytNkEtkc1PQMiso+FSESh/AGDwNqwP2+J+M7IhN7tai+ZhvJrtpDiQPUK7lo/Q6xuRDKBk/mHtK+cndH/8xgQt2hlZlA8ZJzGeyjB3E39RF7zdcxgNzRlVOerrmBOFJzVhX06k5XsLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768989521; c=relaxed/relaxed;
	bh=SJFJMNOM7awUTkwMl4hIh6WDIUWbLKvHg9WhRsfaf2c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JRXEu4ST+WbCmLy0msWppC2IZ4jZ1ZBF1YtFQY9cMpHyE4I9/WDWIWzD8Q5JX/J7QBvxWXjlO4yN4k05t0Z9Yl27gT6LKBS12wlYngN5vcLeeSHAtwTEjkzeWUit0pUr6571iemfQ5WhZgvOyggigfC/PISAbNsaQpVGSXmBIp/eQO1vVnau4AII+W3UEw3DTr62DfJq9ah6osscM3i5arXVqIWo4cFGNKn9YLPHL7G1IAo5FLuZiFO++BC06WMcGzr+vFQusqTdLIwFCgVfjQ+cgZAscjmonZ3JVeZIEybqGOR0Ruj+gl7H9G1o6Y1mOkFlLAUbgTkXBPr01eHWPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=u/+XlkNJ; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KsgHoYFP; dkim-atps=neutral; spf=pass (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org) smtp.mailfrom=ownmail.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=u/+XlkNJ;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KsgHoYFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ownmail.net (client-ip=202.12.124.141; helo=flow-b6-smtp.messagingengine.com; envelope-from=neilb@ownmail.net; receiver=lists.ozlabs.org)
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dx05B0dW7z2xm5
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 20:58:37 +1100 (AEDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 451251300E5F;
	Wed, 21 Jan 2026 04:58:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 21 Jan 2026 04:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768989512; x=1768996712; bh=SJFJMNOM7awUTkwMl4hIh6WDIUWbLKvHg9W
	hRsfaf2c=; b=u/+XlkNJ5V8C5rphAsXf4CRGr0/yY85HzlfIyvdWMIOWXjkQsZL
	hepFVBVO1TGy2MoYqvQ7u24GdOhaMOyN4g29b2duuwJtKYPuWULecyd+MTKRrnGd
	bn7kIcDBwiSCpdoLSUnyYvsgKKeCh1a1dboVMEHTkywI3/WnmYN3GCNjLf2VRDaS
	mz10UPqJbOR5v9xAcZGKcH9zcUO4BUeKjYMDUBeMoVj1ZC1ebbxPD9BY7qRT3PmC
	Gwn3pbkB6fVbCnilSsQt/utzs+2skAgouKRc4vJtaZN+evNBodtN4J3cJ2k+j3M7
	oBRpH6fOpkxc7s+UTVvfrzOozmRmPn80CPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768989512; x=
	1768996712; bh=SJFJMNOM7awUTkwMl4hIh6WDIUWbLKvHg9WhRsfaf2c=; b=K
	sgHoYFPnq/EWy/oXN2LK4RtBbAtHJ8+lCm2EZp7IwyvLgqOVBaJq5V/djUpulah9
	UZ0lnTRqDqpfgEWG2bwPTyIhf+OkxtllFSCCXe8SSJx40Mx4bOPORKRjQmxip1hr
	Hb36gWUn1deRpKO7vBAa/3uHu4mrPFLZ6AyHhEPvNlMxLsivck+jYIJfvJxUK3BQ
	GCt+NV5AdMTQ9cbmkjq9uYNtDwzHhARKjkpF8i9scEBGI7u7PYYWuik1qWV+s+zq
	gG23IiKM5UnKmkw6iHYCl3/e/WqQdwf43M3cAuoYqYAcuk/YbwF3Gb61tiHUVMiD
	2n2dL6Sl4cIXHxXek/iYQ==
X-ME-Sender: <xms:Q6NwadpokZr4zUG9s3yceH_yGV-75ZmEqaCw1iMpcdO-7P_bqHmGqA>
    <xme:Q6NwaYq2ihpc8yBbDG1PVuLPaKeWe_7VoQt8GacEUU17dyYTuVoNw4BKpnWFQRT-4
    Xg1led3wwge8NMYQ6_6srDDet02RciO8TD0ld2euMF5b0iDjA>
X-ME-Received: <xmr:Q6NwaW9rCqB8cw6Q2kJ-ijrsI9kO3BQ343rhJ_gbt5YTx-pU0BQLrEVYYLR7F-XOpzmXxNsMMi5DLL_oShZmUtCCtUc08foOiDNqnALDYUDz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Q6NwaXP_r1AtxnebpNkWh0ccYaXxkWUlkdex3I21_ko1xomksZ4zhQ>
    <xmx:Q6Nwadv_3MuYvlxZn64JB2BnqApISdsMFoP98SEqbGk-2TZ7AkLEZw>
    <xmx:Q6NwaZ3nfLV93Vtn6SIHnsAzPzQFUB9XxFmo0He_Kd-2FrGyOzYc5Q>
    <xmx:Q6NwaXZBKV6NDhrR9j2xzoxiBc-32Bgplw5GGYFI5LL9zipce5X4Yg>
    <xmx:SKNwaTXSyiSStct1wtcBjcLkfs8d66i92fMj1g3ySdmDH9qv7jDxxYWO>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 04:58:08 -0500 (EST)
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
In-reply-to: <2ed97731c54ef130ea58861a91c80dacd785de9a.camel@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>,
 <20260119-exportfs-nfsd-v2-1-d93368f903bd@kernel.org>,
 <aW8yV6v8ZDiynOUm@infradead.org>,
 <9b64bed72e43d0bf24e9b1e3bc770c4a87082762.camel@kernel.org>,
 <707f08e114bf603caf7de020bb630d5477e86bca.camel@kernel.org>,
 <2ed97731c54ef130ea58861a91c80dacd785de9a.camel@kernel.org>
Date: Wed, 21 Jan 2026 20:58:06 +1100
Message-id: <176898948697.16766.1729756714812778707@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-2115-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,messagingengine.com:dkim,ownmail.net:dkim]
X-Rspamd-Queue-Id: 66ABD54C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026, Jeff Layton wrote:
> On Tue, 2026-01-20 at 09:12 -0500, Jeff Layton wrote:
> > On Tue, 2026-01-20 at 08:20 -0500, Jeff Layton wrote:
> > > On Mon, 2026-01-19 at 23:44 -0800, Christoph Hellwig wrote:
> > > > On Mon, Jan 19, 2026 at 11:26:18AM -0500, Jeff Layton wrote:
> > > > > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Some
> > > > > +    filesystems cannot properly support file locking as implemente=
d by
> > > > > +    nfsd. A case in point is reexport of NFS itself, which can't b=
e done
> > > > > +    safely without coordinating the grace period handling. Other c=
lustered
> > > > > +    and networked filesystems can be problematic here as well.
> > > >=20
> > > > I'm not sure this is very useful.  It really needs to document what
> > > > locking semantics nfs expects, because otherwise no reader will know
> > > > if they set this or not.
> > >=20
> > > Fair point. I'll see if I can draft something better. Suggestions
> > > welcome.
> >=20
> > How about this?
> >=20
> > +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Filesyste=
ms
> > +    that want to support locking over NFS must support POSIX file locking
> > +    semantics and must handle lock recovery requests from clients after a
> > +    reboot. Most local disk, RAM, or pseudo-filesystems use the generic =
POSIX
> > +    locking support in the kernel and naturally provide this capability.=
 Network
> > +    or clustered filesystems usually need special handling to do this pr=
operly.
>=20
> Even better, I think?
>=20
> +
> +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Filesystems
> +    that want to support locking over NFS must support POSIX file locking
> +    semantics. When the server reboots, the clients will issue requests to
> +    recover their locks, which nfsd will issue to the filesystem as new lo=
ck
> +    requests. Those must succeed in order for lock recovery to work. Most
> +    local disk, RAM, or pseudo-filesystems use the generic POSIX locking
> +    support in the kernel and naturally provide this capability. Network or
> +    clustered filesystems usually need special handling to do this properl=
y.
> +    Set this flag on filesystems that can't guarantee the proper semantics
> +    (e.g. reexported NFS).

I think this is quite thorough, which it good ...  maybe too good :-) It
reminds me that for true NFS compatibility the fs shouldn't allow local
locks (or file opens!) until the grace period has passed.  I don't think
any local filesystems enforce that - it would have to be locks.c that
does I expect.  I doubt there would be much appetite for doing that
though.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

