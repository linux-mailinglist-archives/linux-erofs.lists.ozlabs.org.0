Return-Path: <linux-erofs+bounces-2192-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD6UKJ5YcmkpiwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2192-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 18:04:30 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DB6AB0A
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 18:04:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxnV331Q7z2yFm;
	Fri, 23 Jan 2026 04:04:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769101467;
	cv=none; b=G3+apcVYMhL0cbOKvol3NAX2DLiLuvjQNoHU/lLr4+4JFbQbKNCBqYzZi4dm+vo/AW/RL4Ps2xVfpGuujAV9TogkOkgGmRE6qkcFiRfR56Q6yyi5qOV7+Y7cDkCkbgfQxo/xEpIuc0gfoaHuyWty3R0UkW5IPr0b2llcTgFqvaWQpi3LS7zZX92VuvgYeDfrjujZHlQBQK3t5UQdQJxJR/z/6z+NZAzeozdXGtDCjs5jYGvZ+mKf7SSylHhN1U0zNlEdkMSsLawpNlgMri+Po6u3Fj9rr+EatVsIWbduN3dLcJmmsQDgCJ3aRX6qWYzWa0mnKIPrARdZQrO8q6jteA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769101467; c=relaxed/relaxed;
	bh=qs+XaS+FGKy5XGjHxsh2yZR3UAuTtojhMQnjtTVwQfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4ZV5E9nG67Uw+6Qk1cCDZ+856o3E0uGT0MYWypb5CDhpCk83arVDALlVJBsGQVkiivXVtr1BEXi2fdiVIi2sZb/vQG7OQhHcyQu+Gusrdq3M0+ynx3rsac7TlKZU4VkaO3CFQr1O95v1bIKx8LDAgcYdtsurBJDISa4wv3ocmHINtvnlAmVzFn3NnobAkTL0T2zUQfjlKa806neFlDfWjsWG3PAme5E5a8R6ZABK2V8ruAgZRVM50ezYkuInx1+WB8Ry2vuNPCSLRD+Rkb5JuOTNDHPVIT5fELdSC6QwOt7pjKcCuHJCPd9CErBt+Wn/96l1zUrelnqI5q+PWQ4Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ueyMX6oh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ueyMX6oh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxnV24Hstz2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 04:04:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 528AE4099B;
	Thu, 22 Jan 2026 17:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156DAC116C6;
	Thu, 22 Jan 2026 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101464;
	bh=xwFz5Oidq8APQpCp7THEtDpXn9O+NGssd7GC7NPkIXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueyMX6ohlT+V7E4FTnwyr+bckr2XgM0otlsgh+U8+RB7dufNou2jXtRF8/4HiLX1h
	 aiyHG+xAbRXlOpSKYNl+YW1B6es8lJGWyDpCT3G89X8Bn++QSMPHsovt5BRyWj7Z84
	 MiFPflUjkr2UeHtVIt004pQ2LHYESJ6jR9ib6bF3tKB5BvchCfBJcHtl2H7eGV6Hj+
	 XeQh59i2mPbJ0Z07CURTocG8MzgcrhLB0YpqMQ2BX+Q2rUwcSwiRIRCTHIiyBghAen
	 fRki137MnL3p5j+2P7Cc4giyKdLsB0k8xoBASjwbPFk1rE23p0Kg5qRxi8CJQxSLFn
	 VC/vMBqCcUNNQ==
Date: Thu, 22 Jan 2026 09:04:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20260122170423.GU5945@frogsfrogsfrogs>
References: <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <aW8w2SRyFnmA2uqk@infradead.org>
 <176890126683.16766.5241619788613840985@noble.neil.brown.name>
 <aXCg-MqXH0E6IuwS@infradead.org>
 <176899164457.16766.16099772451425825775@noble.neil.brown.name>
 <364d2fd98af52a2e2c32ca286decbdc1fe1c80d3.camel@kernel.org>
 <aXDm8FPPOHs04w9m@infradead.org>
 <3210d04fa2c0b1f4312d10506cac30586cb49a3c.camel@kernel.org>
 <aXHFlF1tef68i2HU@infradead.org>
 <b491335d12e976e1ea1c07b9c14164ac69d22aea.camel@kernel.org>
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
In-Reply-To: <b491335d12e976e1ea1c07b9c14164ac69d22aea.camel@kernel.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2192-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:hch@infradead.org,m:neil@brown.name,m:brauner@kernel.org,m:amir73il@gmail.com,m:viro@zeniv.linux.org.uk,m:chuck.lever@oracle.com,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:akpm@linux-foundation.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:jack@suse.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:cem@kernel.org,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:clm@fb.com,m:dsterba@suse.com,m:luisbg@kernel.org,m:salah.triki@gmail.com,m:phillip@squashfs.org.uk,m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:bharathsm@microsoft.com,m:miklos@szeredi.hu,m:hubcap@omnibond.com,m:martin@omnibond.com,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:almaz.alexandrovich@paragon-software
 .com,m:konishi.ryusuke@gmail.com,m:trondmy@kernel.org,m:anna@kernel.org,m:shaggy@kernel.org,m:dwmw2@infradead.org,m:richard@nod.at,m:jack@suse.cz,m:agruenba@redhat.com,m:hirofumi@mail.parknet.co.jp,m:jaegeuk@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-ext4@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:devel@lists.orangefs.org,m:ocfs2-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-nilfs@vger.kernel.org,m:jfs-discussion@lists.sourceforge.net,m:linux-mtd@lists.infradead.org,m:gfs2@lists.linux.dev,m:linux-f2fs-devel@lists.sourceforge.net,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,brown.name,kernel.org,gmail.com,zeniv.linux.org.uk,oracle.com,redhat.com,talpey.com,google.com,linux.alibaba.com,linux-foundation.org,mit.edu,dilger.ca,suse.com,huawei.com,vivo.com,dubeyko.com,fb.com,squashfs.org.uk,samba.org,manguebit.org,microsoft.com,szeredi.hu,omnibond.com,fasheh.com,evilplan.org,paragon-software.com,nod.at,suse.cz,mail.parknet.co.jp,vger.kernel.org,kvack.org,lists.ozlabs.org,lists.orangefs.org,lists.linux.dev,lists.sourceforge.net,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[73];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: AC8DB6AB0A
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:12:36AM -0500, Jeff Layton wrote:
> On Wed, 2026-01-21 at 22:37 -0800, Christoph Hellwig wrote:
> > On Wed, Jan 21, 2026 at 10:18:00AM -0500, Jeff Layton wrote:
> > > > fat seems to be an exception as far as the 'real' file systems go.
> > > > And it did sound to me like some of the synthetic ones had similar
> > > > issues.
> > > > 
> > > 
> > > Not sure what we can do about FAT without changing the filehandle
> > > format in some fashion. The export ops just use
> > > generic_encode_ino32_fh, and FAT doesn't have stable inode numbers.
> > > The "nostale" ops seem sane enough but it looks like they only work
> > > with the fs in r/o mode.
> > 
> > Yeah.  I guess we need to ignore this because of <history>
> > 
> 
> Yep. This is a case where the handles are not PERSISTENT but I don't
> think we can get away with making FAT unexportable. We're probably
> stuck with it.
> 
> > > > I think Amirs patch would take care of that.  Although userland nfs
> > > > servers or other storage applications using the handle syscalls would
> > > > still see them.  Then again fixing the problem that some handles
> > > > did not fulfill the long standing (but not documented well enough)
> > > > semantics probably is a good fix on it's own.
> > > 
> > > Agreed. We should try to ensure uniqueness and persistence in all
> > > filehandles both for nfsd and userland applications.
> > 
> > Sounds good to me.
> 
> 
> Unfortunately, there are already exceptions. Apparently pidfs and
> cgroupfs handles (at least) can't be extended because of userspace
> expectations:
> 
> https://lore.kernel.org/linux-nfs/20260120-irrelevant-zeilen-b3c40a8e6c30@brauner/

systemd cracking file handles??  Yeesh, I thought userspace was supposed
to treat a file handle as an opaque N-byte blob and nothing more, and
only certain "special" tools (e.g. xfsprogs on XFS) could do more than
that.

--D

> My personal take is that we should try to make handle uniqueness a goal
> for most existing filesystems, but we're going to have some that can't
> achieve that. For them we probably want to be able to flag them so they
> can be id'ed by userland.
> 
> So, we will need an export_operations flag of some sort
> (EXPORT_OP_UNIQUE_HANDLES?). At that point, we'll have to decide
> whether to deny nfsd export based on that flag:
> 
> We could deny export of any fs that doesn't set the flag, but NFSv4
> actually allows the server to advertise that it can't guarantee handle
> uniqueness. There isn't much guidance for the client on how to handle
> that though and the attribute seems to have the scope of the entire NFS
> server.
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

