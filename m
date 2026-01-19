Return-Path: <linux-erofs+bounces-1987-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FAFD3A0C6
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 08:57:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvjTz2vkFz2xjb;
	Mon, 19 Jan 2026 18:57:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768809431;
	cv=none; b=fnN/ApNXFFLKQSbiyUYzfe2anVaB5UdOGOr/9rXL0UwoA2uVCpxCMF8BWXHkZ/MBJgsYkatv+JCNvdp2kp5qIxf9S9VAunutvPkqFV3hNsGgVfopMcYdZooIpE+kD7s9TtaO0bwKbRgIhKklzZ85BIJjKrLSVLbH3iLfsOt6x1SJYm37mTFSlD56Q5lCyaUWRcHlZjIdU2JFzOH9UXAfMlSJyvFo5m1GsJM6lunBZelWsQs0DlcfHJqew+PbH0HQAUIk2AhTDIx7iCcABGxDB0ga2k8xaZgTlWjtUW2T7J2rop4OSH7qCDNEh5n9uxzk0MbhlzqMkXI56Ybxf47jWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768809431; c=relaxed/relaxed;
	bh=Dkq9dFVnQ02ADyLqi7RRrcu9zIfz19y2EpNLAEqzuhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyyBwWhIN3lnLh33J+DnYO3pEG/9risUnZR6vXDAcvKGVQ9vze6BH18xF4db7zHueP1ft++JkVYYoqJCF6dK+JC2sU0ZrRlMtfyyxTz6MwScpadB3SxCH5NtyclC0wegjz04T5rvKMFf69zgfYAzmvQMwWbpMLPXW+RNmsutPgXoh56J5XM3PNEei9zJZQgUS2eQoSaKzaAW9S0EqjkJzMwyOnmYUZ1q+Hcx9zBRFG9CXUyyPApyQ966Aa0TZL1mwPtxp/iFYXLUpTBmGWh9xxETsZNSLik9/x+YoscIcl7Ln1kZ11uk6RSJFS3hxoTmi7FgQUH0bHt5K9Pt7gq3dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dSF1IFL+; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dSF1IFL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+f4f5ba1b7319529cbc9c+8184+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvjTx4kQkz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 18:57:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dkq9dFVnQ02ADyLqi7RRrcu9zIfz19y2EpNLAEqzuhU=; b=dSF1IFL+VEbufi9323VoWF6NEa
	USB2BXBiaW7TjezbApRts+YAG9RNRYfhPamD4lev/bOGd62WvFVIL6sSe70b84ri0HQwV2wQR3fie
	NHQfWzjRaVOmQbjja6GffvX4ybd0IoBxLkxlZm0WDdh5PD1BKJEEZN2XmKjJt0U9yUpYOoLXyNoKl
	otc3GgIv/kotdkVdSchAlA4Bqh/5N1QYuwvhjeDy3jpLtEfduOvglzvDFa82EF8VLL3CFeM6qtHx/
	hFOG9hVRMecn6BOFZagcxLAIBWCAy/KYZmHunHQQXYX+w/fhRGaYWCtIXaohApqoDtQ5t9IT0ZpBl
	498p8SdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhk7V-00000001Wju-0c1a;
	Mon, 19 Jan 2026 07:56:17 +0000
Date: Sun, 18 Jan 2026 23:56:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Chuck Lever <cel@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
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
Message-ID: <aW3joQQvz2t6xkzh@infradead.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
 <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
 <aWlXfBImnC_jhTw4@dread.disaster.area>
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
In-Reply-To: <aWlXfBImnC_jhTw4@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, Jan 16, 2026 at 08:09:16AM +1100, Dave Chinner wrote:
> > I think we can be a lot more precise about the guarantee: The file
> > handle does not change for the life of the inode it represents. It
> 
> <pedantic mode engaged>
> 
> File handles most definitely change over the life of a /physical/
> inode. Unlinking a file does not require ending the life of the
> physical object that provides the persistent data store for the
> file.

> i.e. a free inode is still an -allocated, indexed inode- in the
> filesystem, and until we physically remove it from the filesystem
> the inode life cycle has not ended.

For other file systems like ext4 that have statically allocated
inodes that is even more so the case.

> IOWs, the physical (persistent) inode lifetime can span the lifetime
> of -many- files. However, the filesystem guarantees that the handle
> generated for that inode is different for each file it represents
> over the whole inode life time.
> 
> Hence I think that file handle stability/persistence needs to be
> defined in terms of -file lifetimes-, not the lifetimes of the
> filesystem objects implement the file's persistent data store.

Agreed, although I bet that is what most folks think of for the
inode - not a physical place on disk, but an object that gets
invalidated on the last close after unlink.  Either way, that rules
do need to be written down clearly.


