Return-Path: <linux-erofs+bounces-1971-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A115FD39779
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Jan 2026 16:36:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvHk64g2jz2xpt;
	Mon, 19 Jan 2026 02:36:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=116.203.167.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768750574;
	cv=none; b=WPJmiMRVxJH+fJuBqRQUfrn9p3hnddrfhxgjZ1MUJYY6ioG/SUcrpNCghU1RYmugSmPyF0iGNsPYnnllr5XrGAPgmupgkqokFTaOy30e6w8bXSvyrDWUQHyC6Qt30UWq8eW6aIXI4K1nJn1OMJ/BTNqNbbv1yZkgGx+6TKNGZZmwtFfJPHiZnEITY7QPEs0AfKWoVHF8bSMscti9zHhM68UfrWwieKhzoz2GVsq4E1GvIAwi/8KofeCQC1JZv1g9lLnvuZDkUmAl1LwzkpoNJX3PqLVdbN60f5FnKHElI0fAdKV/y2zKNzeEpCyBLVTn7cLsSiW+ip0S43/T/jeBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768750574; c=relaxed/relaxed;
	bh=7o8IJfB7ac3jZiXayX/iEYSCvbbdHx+mVAVSDEiNdGc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mSsT+Z3P/csZvEjNYOMH8OrC0llP51fq8rWgLZHMOSfoWH/dBL1HsKuISeo/KWJl7Gv/boNy1wdNd6WCyPcinpCPlBvZ1Fg++ZVi3YJzUR6Nm9ztvd0tlXySL4LjegMq8Qdw0kDtCbWJ4K5VOt1qqJSrnoW8Tt1FS0tqICL5Lw2QMYC2TTJa1UGYGtBR0gBVbTV5ebgVwWXB07OjphQOjKNAAH/SgkPlurdyNeYSiZ/SB/1oTx9BHm2aUVt3zBA+ahtjyp8KoVhcCblzaiQlDS+j2WpoWX9yrGNUa+vWlAM76h/esptD+z80wtjih2fp6WXDsfY/0rHYbQ6NwNoPNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=permerror (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org) smtp.mailfrom=nod.at
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Unknown mechanism found: ipv4:195.201.40.130) smtp.mailfrom=nod.at (client-ip=116.203.167.152; helo=lithops.sigma-star.at; envelope-from=richard@nod.at; receiver=lists.ozlabs.org)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvHk507tkz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 02:36:11 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5FD812918DC;
	Sun, 18 Jan 2026 16:36:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8m1VPN69EFg3; Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9E0B129859E;
	Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qm1VWoKnABQg; Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 04C202918DC;
	Sun, 18 Jan 2026 16:36:04 +0100 (CET)
Date: Sun, 18 Jan 2026 16:36:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	chuck lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Amir Goldstein <amir73il@gmail.com>, hughd <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, tytso <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, 
	Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, anna <anna@kernel.org>, 
	Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, 
	linux-nfs <linux-nfs@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-erofs <linux-erofs@lists.ozlabs.org>, 
	linux-xfs <linux-xfs@vger.kernel.org>, 
	ceph-devel <ceph-devel@vger.kernel.org>, 
	linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-cifs <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-unionfs <linux-unionfs@vger.kernel.org>, 
	devel <devel@lists.orangefs.org>, 
	ocfs2-devel <ocfs2-devel@lists.linux.dev>, 
	ntfs3 <ntfs3@lists.linux.dev>, 
	linux-nilfs <linux-nilfs@vger.kernel.org>, 
	jfs-discussion <jfs-discussion@lists.sourceforge.net>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	gfs2 <gfs2@lists.linux.dev>, 
	linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <2119146172.135240.1768750563673.JavaMail.zimbra@nod.at>
In-Reply-To: <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org> <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
Subject: Re: [PATCH 23/29] jffs2: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF146 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
Thread-Index: pUsbo+Kg1d9ytlyubsob1wi+Ql8B0A==
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

----- Urspr=C3=BCngliche Mail -----
> Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to indic=
ate
> that this filesystem can be exported via NFS.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/jffs2/super.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

