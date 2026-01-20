Return-Path: <linux-erofs+bounces-2074-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CCD3C0C2
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 08:44:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwK9J3phfz2xKh;
	Tue, 20 Jan 2026 18:44:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768895092;
	cv=none; b=PVRHvOXbBv2r2hMAwG2/3zYhyh09BkdEN31KMba0jPmRwYPJBplojnt0R5tZZIRP6czpc8jPVESgYwlTQPyLAAOfvGWHzshpHLMXhToImlrY8L30pLllDKXmCkAWirsrVdQeUP5UcTkIvo9OQKshE8fvHZ4Ck93VPSxSbYx+RiVoK1cWpC5OUB56EFT5H5TQwrHSK7bBmi/HzKvqJHv/OK35Tk6rgBrEcfbh92AjoGkP9lIlnodKLOgTBthJzgVig3/FEdg2fQXW1CFLzwMJe37Kwsixd+a4Xd7F333k2sPqmJSfjppznBq4lbXgE5so6FhdwXfaLw2ry/6AwtucoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768895092; c=relaxed/relaxed;
	bh=Kid6MiU7s5f8T4gEwmOyT2zu04YSeGDYh8750Mga8iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNVAp1q5Pm5Zj1iM+9FM9YrZYRRC0J7gS7sUGfjIXRLERXKnOjLtxaWF4LFL6L2HVFFBvYRTdve3pOW4+G7N/YLgXV5yWtoRult8+POMSmWfhsYep/Ft/b+P0rLLA86GV4Mj/WdrHGa0S7+5Y/wMrrZXrwDgD7J7May9LA/jWDG4nm1ptwNT07K1ZVhDtMvVKc8mBbaO+DCwa//NXdMJHv+XocL3mx9164q0wQXj25Uj6ceWVfFetGci3AZ31jElaGwoQFfYIbjsUIHhnfslNVfW5N2IQ6sEXBfL0Osh8Sv0y43K9EuCzLMa7v2JklOI0UXzcu+wdcul5nezNeG4Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ilacl4zO; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f87a82fb8d0462b7f15+8185+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ilacl4zO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+6f87a82fb8d0462b7f15+8185+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwK9H57Rmz2x9M
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 18:44:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kid6MiU7s5f8T4gEwmOyT2zu04YSeGDYh8750Mga8iQ=; b=ilacl4zOxBgb/lmdsCZTsr3EBk
	zFj2GyVX/vUj1UlJHTeGnpcPnHJ9j1woWxvFz3xRKDyTqK+wAajiLLU925mQ8gXwhKmyxMR4v1epI
	AOBbpi2btLiLaBkLAx55KwETuAMOToZG4XHJYEOLtQSWNewFbBS0oIkgoS8wa3txVmTRVKzYeS0A3
	V9gH/Lab14QzzebmbPcXNWPVgrikm/JOCo+2HYwEDmDIwtOHHDne6sJtxRZS613O1tl53Srsju7g8
	UT5LyUVPxepeDRdKwUet4llrhStqaMvjEAL5ucvkWWrFbYBz71lqsJk2Pg/Tigf0o/FCqWWyZna9G
	sV+Bbw9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi6PX-00000003MrT-17WL;
	Tue, 20 Jan 2026 07:44:23 +0000
Date: Mon, 19 Jan 2026 23:44:23 -0800
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
Subject: Re: [PATCH v2 01/31] Documentation: document EXPORT_OP_NOLOCKS
Message-ID: <aW8yV6v8ZDiynOUm@infradead.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
 <20260119-exportfs-nfsd-v2-1-d93368f903bd@kernel.org>
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
In-Reply-To: <20260119-exportfs-nfsd-v2-1-d93368f903bd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 11:26:18AM -0500, Jeff Layton wrote:
> +  EXPORT_OP_NOLOCKS - Disable file locking on this filesystem. Some
> +    filesystems cannot properly support file locking as implemented by
> +    nfsd. A case in point is reexport of NFS itself, which can't be done
> +    safely without coordinating the grace period handling. Other clustered
> +    and networked filesystems can be problematic here as well.

I'm not sure this is very useful.  It really needs to document what
locking semantics nfs expects, because otherwise no reader will know
if they set this or not.


