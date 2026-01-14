Return-Path: <linux-erofs+bounces-1866-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215AD1F8A7
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 15:53:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drpyD2HDtz2xT4;
	Thu, 15 Jan 2026 01:53:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768402388;
	cv=none; b=OUKj5atq4E/7B2w31b8unOiUTSv/jBHjWLFX3g+X7n9zocyKSkqPwxU2co+Yo3XAjMt7p3hBtd+ZlwE7jfk2zf7jTJj/SXHmd4g8PLr2RW2SaJWaLVDQOaEAVrYI39Y+6IsmsbKqoWS7ES4XqOlq86lgICyxe7zVGIKUxbzzPOy3qVfRrnMztk79uz+1FTULw3mpUPYRnOmal3ItZd3lAOptbYB5KYsy3BRuDMJjl+h5gcg1pOf31SPOvdp0H9MIb938wvoMLeCv9b7dtW9nPFTcvdV641MbgnmBiKHW+V0h73G8yKW2j28u49mboFGCNVMLXmB5Uhn+VB9XoBE5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768402388; c=relaxed/relaxed;
	bh=xKp2mRX639Xrl1hAH25cMUgzI8E+8kaOkrWTmDZ9gJI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j6SieaPRxrPA4mSeuq+1Nw5SaS6aRNwf6WtMfCZS5Fl9ZVlP6G200puTTA0s7wHatxl1KdcWIFDaLzdQ/jmbFjJql0jeWeHKpwJl5NDF4BEibZnXw7V8B/mQS27RR/QedOwao7cr4LlTkIYpw0ZA8gRccp0d9joHt0+gfjr9d0TeVgRvZky0+A+P4C/CUGETDiKW6w6N2sI070KpP0HQYZm5BB/k14zQximiWAXRowBlXqZS3nm6u5Ly9apYbhfu79q9l2LQ17m69qgWISJxm3DnnELlx1/m960CKX9leB6oWDFiYpVfs0rIreq8P/W6we7ebUf6rnf3DPQ3eVvBhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DZ4y7792; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DZ4y7792;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drpyC3CRQz2xNg
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 01:53:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B4D05600BB;
	Wed, 14 Jan 2026 14:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22BC4AF0D;
	Wed, 14 Jan 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768402384;
	bh=xKp2mRX639Xrl1hAH25cMUgzI8E+8kaOkrWTmDZ9gJI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DZ4y7792kI2/4eE5VVTlEy1lwDXzIzeNr2iEGyaqqLMYTsvcSbwt8Bo54fNz4FJrn
	 0CjwDI0jj4BZuie48fZ7X8+pogo2m9xuuz5ZkTKqUIWIWMb2aIahe3YDQ1OihTAsyY
	 /kSWP/W66gnEfc8gA/3bKKHjBBbzoJWIQmXxEVECLl86oIEVeZwN3rPLewdZXpBLNQ
	 4fSATB6J5Q9DEK8WPOow5IHJKdW2q5kckZv1zfwvc/Rackn2AgyYEGYSEHyTHq4m0k
	 xzDo6EcWHnQhpPR7xCjV8fvC1tdohxaCsjAOcYPGoYZ1/+HzD4MzDToJBxFdCh/tru
	 OSjQsEWq0CzTg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 336F2F4006C;
	Wed, 14 Jan 2026 09:53:02 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 14 Jan 2026 09:53:02 -0500
X-ME-Sender: <xms:zq1naTL1verRbjv_OWxa5Qc-mm-FLSmJA57qMcDcmimTH1ZvOzAH8Q>
    <xme:zq1naR8m09634GxEfslbvAHAt_pWKVnj5KMHoclqQy7tbEop4pkDoeOLzOlsxhgNB
    mfBJSAWYD5Pvqo039VVHWSbWWy3lMiNKfBSo92wfzMrsG2olMOvAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhesrghlrghrshgvnhdrnhgvthdprhgtphhtthhopegrshhmrgguvghush
    estghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhu
    uggvsgihthgvrdgtohhmpdhrtghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghlseguih
    hlghgvrhdrtggrpdhrtghpthhtohepshhlrghvrgesughusggvhihkohdrtghomhdprhgt
    phhtthhopehjlhgsvggtsegvvhhilhhplhgrnhdrohhrghdprhgtphhtthhopehmrghrkh
    esfhgrshhhvghhrdgtohhmpdhrtghpthhtoheptghlmhesfhgsrdgtohhmpdhrtghpthht
    ohepnhhitghosehflhhugihnihgtrdhnvght
X-ME-Proxy: <xmx:zq1naR4y4iRWBYp2xNnePgUOv-GP1DKdFBDtDf2IC92YRobPvv4XvQ>
    <xmx:zq1nabUvbFcuW5qmkDCHdiOne_rDLza_EAZnBtIjXTs4zRVj0oLKWg>
    <xmx:zq1naXWzKUDfqjQXjvlbqUXobr95Hj_DLjvdFTe0pPxUPWiy4igVFQ>
    <xmx:zq1naQSTIJTSkNqnVd_7fRCRq8sinXvVVU9WAT0_5jXT_tt716hBhQ>
    <xmx:zq1naeeXm4Q-EAh1xMCT3MnzrdKd7lPZzpjsKoHgYV0ycvEqIoQrdgKM>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2C75780070; Wed, 14 Jan 2026 09:53:01 -0500 (EST)
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
X-ThreadId: ArEQL-Tet5yZ
Date: Wed, 14 Jan 2026 09:52:34 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jan Kara" <jack@suse.cz>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Nicolas Pitre" <nico@fluxnic.net>, "Anders Larsen" <al@alarsen.net>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "David Sterba" <dsterba@suse.com>, "Chris Mason" <clm@fb.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Jan Kara" <jack@suse.com>, "Theodore Tso" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>,
 "Dave Kleikamp" <shaggy@kernel.org>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Carlos Maiolino" <cem@kernel.org>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "Xiubo Li" <xiubli@redhat.com>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Hans de Goede" <hansg@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev,
 linux-doc@vger.kernel.org, v9fs@lists.linux.dev,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Message-Id: <5a1730f3-30ff-403c-a460-09a81f9616c5@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
References: <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
 <c40862cd65a059ad45fa88f5473722ea5c5f70a5.camel@kernel.org>
 <CAOQ4uxhDwR7dteLaqURX+9CooGM1hA7PL6KnVmSwX11ZdKxZTA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to lease
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On Wed, Jan 14, 2026, at 9:14 AM, Amir Goldstein wrote:
> On Wed, Jan 14, 2026 at 2:41=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:

> Very well then.
> How about EXPORT_OP_PERSISTENT_HANDLES?
>
> This terminology is from the NFS protocol spec and it is also used
> to describe the same trait in SMB protocol.
>
>> The problem there is that we very much do want to keep tmpfs
>> exportable, but it doesn't have stable handles (per-se).
>
> Thinking out loud -
> It would be misguided to declare tmpfs as
> EXPORT_OP_PERSISTENT_HANDLES
> and regressing exports of tmpfs will surely not go unnoticed.
>
> How about adding an exportfs option "persistent_handles",
> use it as default IFF neither options fsid=3D, uuid=3D are used,
> so that at least when exporting tmpfs, exportfs -v will show
> "no_persistent_handles" explicitly?

I think we need to be careful. tmpfs filehandles align quite
well with the traditional definition of persistent filehandles.
tmpfs filehandles live as long as tmpfs files do, and that is
all that is required to be considered "persistent".


--=20
Chuck Lever

