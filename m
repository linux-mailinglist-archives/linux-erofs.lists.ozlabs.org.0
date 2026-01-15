Return-Path: <linux-erofs+bounces-1883-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC0D230A2
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 09:14:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsG3t2RVnz2xrC;
	Thu, 15 Jan 2026 19:14:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768464874;
	cv=none; b=Q5UUJFmq7V1KzGkzkwvTQZZ+CRm2Bz7BLWCuBnMFVUa5fy/owOHWuxoDym2EgRmSeXGtvqi+9LEE9XdprjTU5Z2OzCzWAGbrSmopWynWUCeY30d+hmP6s4NASvBV2DbIP7IPW5s1FP609ip+9ezTIAb676t0d35MfV3X3mFVyuxpBu9HcSJkJAHYTz6v8xs4n/ENqRZsrRzHHrzUb1pMjzJpShp3SlYJ6PNjKIRpw7OYNnKh20CNEqUTHKyFcoKffZfjevj0oIYPgir/XXFsHxpG2Wb5TnFcUYYwZz9bKvB1VC883bes3NOgJ3uaJVFdj2ilox4e0ANBYDl7I2Zouw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768464874; c=relaxed/relaxed;
	bh=FXFHeU8QpH/lQamvGnH1b8chwcMeSz98NW19o+yr6yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StjS2q/SZMFYz/ZNsrhvHTHiguICgzusSyWlFGzMJiA8bjJnt0cBEyrGt83wlAxt7dRnkTW5aztHzoVCV12JI+KPcyqQJeMLOieTU+RLpznPr2YZrhrguvCXAcUvjqzAaMPuH7bLNnLAWbJRznGBZxyPi36TISOKLjY3JOShMZZmYMkeXiVHptyj6VM9WHPr4DrhGwxFhtue4ELr+xY0kssFVQrRsSm5obxMyZVviMWR4So4SJZ/4Yh1XJ77+6cSVIvY3mFFY5ZSRg/Xkvu3qW0wyoTOoJUo5Eqe0NXf14Y5ULJznNn99KF89Zm+/QYQyTsxgWqKRXulirnnLsx/vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XnbS2cfp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XnbS2cfp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsG3s2y0Cz2xqj
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jan 2026 19:14:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DB4B406A8;
	Thu, 15 Jan 2026 08:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64986C116D0;
	Thu, 15 Jan 2026 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768464870;
	bh=WiSNn2zvCUvnX3icYjakRozNqyZdq45DKgsu3cHWUEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnbS2cfpntTwX4GFJAoawDW2AeA5ZSsT+/PONrd75H6dIfGkNvM5vgeSHaOAPv8dM
	 FrUnVk8caQ2ZgKDdkW59pGpZdLQn5pXMBsCnewkG8ZRPBAs5NmgswKQgR2jlXOGTLH
	 1XC97DnUwAHpyZvcxc/R/9ANrCDd89hPll0MVVz035TWRgfHi07Ohy3FXm8Oi6cHMd
	 K1B5BtZtQ3crjd06l/WXb42A7DNOvPmKTEyhkbAB9zRLk0VcQ62qYkO65llb6ehby+
	 4dGtOQAqLPZ8prbPHH4nyrrHNN5EkPlne7JgZK52gq0fyn0vzFLiAfA69H2k4JHDn4
	 iObH+Pt4IvcIg==
Date: Thu, 15 Jan 2026 09:14:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Dave Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, gfs2@lists.linux.dev, 
	linux-doc@vger.kernel.org, v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260115-inspektion-kochbuch-505d8f94829e@brauner>
References: <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
 <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
 <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
 <aWc3mwBNs8LNFN4W@infradead.org>
 <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
 <aWeUv2UUJ_NdgozS@infradead.org>
 <20260114-klarstellen-blamieren-0b7d40182800@brauner>
 <aWiMaMwI6nYGX9Bq@infradead.org>
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
Content-Disposition: inline
In-Reply-To: <aWiMaMwI6nYGX9Bq@infradead.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jan 14, 2026 at 10:42:48PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 14, 2026 at 04:20:13PM +0100, Christian Brauner wrote:
> > > You're still think of it the wrong way.  If we do have file systems
> > > that break the original exportfs semantics we need to fix that, and
> > > something like a "stable handles" flag will work well for that.  But
> > > a totally arbitrary "is exportable" flag is total nonsense.
> > 
> > File handles can legitimately be conceptualized independently of
> > exporting a filesystem. If we wanted to tear those concepts apart
> > implementation wise we could.
> > 
> > It is complete nonsense to expect the kernel to support exporting any
> > arbitrary internal filesystem or to not support file handles at all.
> 
> You are going even further down the path of entirely missing the point
> (or the two points by now).

You're arguing for the sake of arguing imho. You're getting exactly what
we're all saying as evidenced by the last paragraph in your mail: it is
entirely what this whole thing is about.

> If a file systems meets all technical requirements of being nfsd
> exportable and the users asks for it, it is not our job to make an
> arbitrary policy decision to say no.

This is an entirely irrelevant point because we're talking about
cgroupfs, nsfs, and pidfs. And they don't meet this criteria. cgroupfs
is a _local resource management filesystem_ why would we ever want to
support exporting it over the network. It allows to break the local
delegation model as I've explained. cgroupfs shows _local processes_. So
a server will see completely nonsensical PID identifiers listed in
cgroup files and it can fsck around with processes in a remote system.
Hard NAK. Entirely irrelevant if that filesystem meets the theoretical
standards.

> If it does not meet the technical requirements it obviously should
> not be exportable.  And it seems like the spread of file handles
> beyond nfs exporting created some ambiguity here, which we need to
> fix.

We are all in agreement here.

