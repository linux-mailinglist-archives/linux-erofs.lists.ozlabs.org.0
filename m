Return-Path: <linux-erofs+bounces-1980-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C50D39EC7
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 07:41:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvgps0Ftvz2yql;
	Mon, 19 Jan 2026 17:41:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768804900;
	cv=none; b=AicufFJn5Mv7q+3nm2d+mROEyJ2Uv4zrVXGpMO6HVGByIZnvlxDXAFxTkIMibfZxqwiN4Ciwu0MAK2E/ga3I3jpyZHdnIz0YQI7Ro7otJjTrIlU1ccf19htdIRbGd1RVDtED+7bDgXirh6/GvqRtVSvwL0Prrk59RrpTima6uhidSZT2UertVCHkjNW9dEef8JTpHwtbWhBOVKiLTzFQ+C/XKrJO5/X8/qWo7PxjPiunZX9N8yOMm1Brfe+yhp5bcTEU53dWRtaWs5tg/6Y3NElDFFFTnhF0heYd/aJ4mQztjWZe+bUieSISKd0IyQe/TRFtESv5dNXWLrHSeFunRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768804900; c=relaxed/relaxed;
	bh=SwbeRkUkK9OO/mqWtmzTHxyd7fbhxxJhakqf4s0kNIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6FJxksFClifuD8dolpS3ONiCLSM4QKPVVwVYtKQiwOTiSMADLVFLiBVcUTdVf30EUIPucTeG1ND8D8dx12iEqhK6H98iC/xa9aaEvWKa6QMYVcJKgTGy9WkAYwuQxG5Olv6Gdar4PswaCk+ajY5eSIlYwcabiEqfLOdePQ23Jzbjf7g+boNT4d4crmos0XcGI0KT8IPWiK4+JFEheUi/IbDB6sheY3aF9lID4mJbZt3YxCXlCEQP6Fu18CaUNQp8FGuo2420TIA5fHcKhkwPOCEBsG2XRJnZpzxA+JsQDbngpiNfYTNEPC9QAllda9yqdv+E5D74mhJ1AgLjwnRuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QwGA4hgL; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QwGA4hgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvgpl4Qhpz2yDk
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 17:41:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SwbeRkUkK9OO/mqWtmzTHxyd7fbhxxJhakqf4s0kNIg=; b=QwGA4hgL9aMV6sQTixPK1n3SnR
	Zri8G531dV5x98A84aReqp2G6UaHJpN4nTXf/6+Wnxr1XHLmqM3RDH1HwtqEKXYEuQzraEqef4ifS
	Rfg7JDYGeHeFp5XweYvklrNR0opJLe/tNClTdos3Mg+TXmulpYbbch6WDkxiaD+n25edx4Evpx16K
	chywKYqiRDwlqzijGrTxiZtG1P3yiRHDEqNuPQfZFCJ+hNE2459H6pBY6SMwsK15gU7luCRmdJNqI
	wOQgeUtkH/rzLOhP3JaZKrgna/cZqGj1BqYMwYctab45DTy467HukeFKRPuJN1wnShp9GMgFQxNTY
	QpZdjvWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhiwi-00000001PpP-1B5K;
	Mon, 19 Jan 2026 06:41:04 +0000
Date: Sun, 18 Jan 2026 22:41:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
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
	Jaegeuk Kim <jaegeuk@kernel.org>,
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
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <aW3SAKIr_QsnEE5Q@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
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
In-Reply-To: <176877859306.16766.15009835437490907207@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > This was Chuck's suggested name. His point was that STABLE means that
> > the FH's don't change during the lifetime of the file.
> > 
> > I don't much care about the flag name, so if everyone likes PERSISTENT
> > better I'll roll with that.
> 
> I don't like PERSISTENT.
> I'd rather call a spade a spade.
> 
>   EXPORT_OP_SUPPORTS_NFS_EXPORT
> or
>   EXPORT_OP_NOT_NFS_COMPATIBLE
> 
> The issue here is NFS export and indirection doesn't bring any benefits.

No, it absolutely is not.  And the whole concept of calling something
after the initial or main use is a recipe for a mess.

Pick a name that conveys what the flag is about, and document those
semantics well.  This flag is about the fact that for a given file,
as long as that file exists in the file system the handle is stable.
Both stable and persistent are suitable for that, nfs is everything
but.

Remember nfs also support volatile file handles, and other applications
might rely on this (I know of quite a few user space applications that
do, but they are kinda hardwired to xfs anyway).


