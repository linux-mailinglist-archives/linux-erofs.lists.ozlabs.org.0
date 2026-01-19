Return-Path: <linux-erofs+bounces-1982-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C9D39FAE
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:26:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvhp91rkxz2xjb;
	Mon, 19 Jan 2026 18:26:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768807569;
	cv=none; b=oTEefc5m3+CYr5DwGQyRnnShAb/rZIjLMdin2/+fRJ1j5N2Lb+9JCK4EGABJbUreM6Ldg+BrAk3guBzxj74Ilbyz12UKw52aOCFBy9KVWXx8YVYHCj7AwIBbiM6l+hINV3MGDV53TbwawNFr17nYC3b4MAPo0K1ZHy63PLUzLfXG5kWy5n94tWojUK/94CNEapZ26oiBayou2eg0bo+e3SxGwNPNRnSoXPPeO18c8s2EU+U1J2p68hRnddLi2BSkAZ4fZrJZSoM/kbjEALemul7SmCMeTrknV/0Y+uPCYEUhQG/to9t762xcUjEX7XEUL3V0ftSYF6OJo1TrytI7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768807569; c=relaxed/relaxed;
	bh=SdeGvwbQpxlPUYjWclzPmRx+IQVLHu58bH+XT7BFy/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsOYleZAGv0gxkRrVL9VCZVid68NcUbR/FbwUZeN+x50rmX5SRsvQtXcs2mi7wcUrS083kysMPWG+BvNTEnvakLC4dzceaMgLpbaguqff3M0Lg0tyfsl5b0+D8/OULbtwCzNXmT5wvhQ30vwbp0Ovv2DGAycV1DpmRgBhLjmZfFmXs7I+NWBgKuUlPslDP0/sPNSoH/k5NLik00A+R9ysj/Zz0qvbTa5nk4quzkQ3eL99Fo75mGvk4AnoupuydjY0NsgVNmhlZWjVXoMZ7HNzZArcNRK/LCjct5VDiFScjXtD1wEuKeV5X6/AmWpJcvJo0pkEPG84HyEbcikvxDkyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vpeslnKs; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vpeslnKs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvhp771Dbz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:26:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdeGvwbQpxlPUYjWclzPmRx+IQVLHu58bH+XT7BFy/E=; b=vpeslnKs0kEtVQxLv6zNmfQJ5G
	TvTugN4T4j8RD3Vs0BnXZN1QzZqnB4D7uOdAA11Ur0t3FPPWnxyfuuCAHPZbZ+6wIUcEefsFQ32co
	+vCvtBifSMAf02TAMYGbQKi4iMCQo3oLC4QmJQRv4nD92QhZOq3i1XdBiPArAxd6H9i8+Z32A6WcT
	whFYQHvPf8xiWhPRik6EgKL+Wg7G7BqYPvWQS48IfwmdgkkGq1lEXE54n/opOEWpDoa7k0Gy5BYqw
	v/Urt+eLDpkqilIUEQG+hJ24VWsryY+AhaXCJ6FiWwFl73fxmpKewmcmsKet/MLlOupEIGvPesfBt
	nMXlmQbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjdu-00000001TQi-3A8r;
	Mon, 19 Jan 2026 07:25:42 +0000
Date: Sun, 18 Jan 2026 23:25:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
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
Message-ID: <aW3cdlSjcXqcV1VO@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176880736225.16766.4203157325432990313@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> We are calling it for it's only use.  If there was ever another use, we
> could change the name if that made sense.  It is not a public name, it
> is easy to change.

No, it is not the only use.  This flag needs to be propagate to
userspace through statx or the file attrs.  As I said before there
is plenty of code in userspace that does rely on the traditional
file handle semantics.

> > Remember nfs also support volatile file handles, and other applications
> > might rely on this (I know of quite a few user space applications that
> > do, but they are kinda hardwired to xfs anyway).
> 
> The NFS protocol supports volatile file handles.  knfsd does not.
> So maybe
>   EXPORT_OP_NOT_NFSD_COMPATIBLE
> might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> (I prefer opt-out rather than opt-in because nfsd export was the
> original purpose of export_operations, but it isn't something
> I would fight for)

Again, stop trying to name things of the initial user.  Flag needs to
describe smenatics, not users.


