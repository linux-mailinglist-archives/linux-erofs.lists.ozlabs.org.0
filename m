Return-Path: <linux-erofs+bounces-2075-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5AD3C0E1
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 08:50:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwKHw3nlZz2xKh;
	Tue, 20 Jan 2026 18:50:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768895436;
	cv=none; b=iZ+t9vtu/phdWeg7WVJHm4katZiPMvI6Ot5kMIvWVfwBtMSnD4RSuvzzwP1zII5HDGiIN1b/GW7KLhpDCRz8kkMk/CTNRemW5l84bXB28PI8/urVolqfi0xXvBGVG8MRaKpNUIj1mhtif+4UGchmogpw/jJ0BDf++vIdeq9/tmekL/pIQgeipE4tfxn9NcH96c66BSOhX4BaPBq6I14kWikWAWy6VJgAojUr5BNuPWch4GHzsgl5vD7fm2eJkVeydMEbAvWP3y6kn6YGKKqtEuHoAq+QvpoLPpZwW34AVD4lciHgaEv8l0qh3QRg2a7Hqb+59z2oXdCiX6u4Fww+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768895436; c=relaxed/relaxed;
	bh=haSfZvoEvPhBBZDnUW3y3BhJEQ36mgFSvpNiOqhvJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+fOQwvY04Po+7VLj1ki+Bm1Fvgs7Mnsg1ZqXQoaV7j14n8GChlFllCVlserXcS0apwByD29S6nL848i8ovx/n6ABshkD72bVZIyu0HI5pitX4qVkSCleNce2M+xSe1qLJkkx9BC2xf17hRqaDDOb+v10LaUV2lEwS0dOx9/FP4FqeHQtL9+9kFihYmjJ071ndc0e7ZtdEte9EmXGJZTLNXmipyDUVVTwN14Luso8Qa5cm808eHr8rNo4qfefj+pM+z/VSCUZp9OtABIIfGtHKQU3VwQ6Wt6w7auwo1kMWwpeeQFQVPCyLPjLE9irpkOYQPChxConSaxZO3kTOsUUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N18Lfx2l; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f87a82fb8d0462b7f15+8185+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N18Lfx2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f87a82fb8d0462b7f15+8185+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwKHv73C9z2x9M
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 18:50:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=haSfZvoEvPhBBZDnUW3y3BhJEQ36mgFSvpNiOqhvJvI=; b=N18Lfx2l0cTzfa3HEHbSStwRPv
	iyXHar7+IL8UusFL6sjIudxhuirPKAhJMeBNA+7JTaSgRPwHzsN72C9/ED13gd4R3bzZoK6cN15el
	2OOL3ox9rvwKCy+jqAl20MM1KOQeI06m0Nqc7qZlyinWokSDH6OADy7uwk70GRUXw1dKPRbjqr1Mx
	G0x+S1U8gEmAS0uHHMxQqMK+KDGwlJXyI4/nRqaD3y/MPBEQbIe1RJKnMGnpCsJCrYQkezP6l13YD
	Bk/y5So46wc2umpZT0PCIQ7tT9Ms4VQ/Y3zVPPZ8bLDLhE9SURfv9f85/RpFqttM9TA+n04nUeD09
	UJSC4XRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi6VB-00000003NIK-3jXc;
	Tue, 20 Jan 2026 07:50:15 +0000
Date: Mon, 19 Jan 2026 23:50:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Amir Goldstein <amir73il@gmail.com>,
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
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
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
Message-ID: <aW8ztQ-RbhxwzMk7@infradead.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
 <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
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
In-Reply-To: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 11:26:19AM -0500, Jeff Layton wrote:
> +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
> +    stable across the lifetime of a file. This is a hard requirement for export
> +    via nfsd. Any filesystem that is eligible to be exported via nfsd must
> +    indicate this guarantee by setting this flag. Most disk-based filesystems
> +    can do this naturally. Pseudofilesystems that are for local reporting and
> +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.

Suggested rewording, taking some of the ideas from Dave Chinners earlier
comments into account:

  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
    stable across the lifetime of a file.  A file in this context is an
    instantiated inode reachable by one or more file names, or still open after
    the last name has been unlinked.  Reuses of the same on-disk inode structure
    are considered new files and must provide different file handles from the
    previous incarnation.  Most file systems designed to store user data
    naturally provide this capability.  Pseudofilesystems that are for local
    reporting and control (e.g. kernfs, pidfs, nsfs) usually can't support this.

    This flags is a hard requirement for export via nfsd. Any filesystem that
    is eligible to be exported via nfsd must indicate this guarantee by
    setting this flag.


