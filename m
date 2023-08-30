Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB56178D0D9
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 02:03:57 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=Bog5SZG0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rb4Jp5h3Rz30Nr
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 10:03:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=Bog5SZG0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rb4Jh6KNcz2yD4
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 10:03:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mhHf9bnOddbdauFdwTiNvB2pCJGntgXJjGP69XrW3To=; b=Bog5SZG0TYg0s2MQQfbUs9uVXk
	XdtKROAwAGEUaoPB8IuJVEXbl9mZlm0jEhEk3H4E+vKRQyFUUSOp4nTdUWPuxI7Hp4HjDNA443+/y
	/0fOLJMKC2WIb2tS4b+Rt+QMGMmK7PEfbf7jtUs42sJFP5+vBQdLHF+vLX+GuQ5QG1n3CXTQMflpP
	3DlTErG3FOwEjKOWr7tFZ3fPuvJ3DhE+vRtnrlv2iBll7kd62LGwN6s1l2hycllZ+6XxX/OrWlMoY
	fxqTZRWZnCLTwYTWHz4AyRowlDGrc1MtyEFAz5FrKLMLieuTK/6uE/WBBD7mLUNv8cYmrCXKVybDc
	uCQ9Bpgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qb8f7-001xNh-0Q;
	Wed, 30 Aug 2023 00:02:21 +0000
Date: Wed, 30 Aug 2023 01:02:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
Message-ID: <20230830000221.GB3390869@ZenIV>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
 <20230829224454.GA461907@ZenIV>
 <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org,
  linux-f2fs-devel@lists.sourceforge.net, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Anthony Iliopoulos <ailiop@suse.com>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Joel Becker <jlbec@evilplan.org>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba
 -technical@lists.samba.org, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 29, 2023 at 06:58:47PM -0400, Jeff Layton wrote:
> On Tue, 2023-08-29 at 23:44 +0100, Al Viro wrote:
> > On Tue, Jul 25, 2023 at 10:58:14AM -0400, Jeff Layton wrote:
> > > generic_fillattr just fills in the entire stat struct indiscriminately
> > > today, copying data from the inode. There is at least one attribute
> > > (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> > > and we're looking at adding more with the addition of multigrain
> > > timestamps.
> > > 
> > > Add a request_mask argument to generic_fillattr and have most callers
> > > just pass in the value that is passed to getattr. Have other callers
> > > (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> > > STATX_CHANGE_COOKIE into generic_fillattr.
> > 
> > Out of curiosity - how much PITA would it be to put request_mask into
> > kstat?  Set it in vfs_getattr_nosec() (and those get_file_..._info()
> > on smbd side) and don't bother with that kind of propagation boilerplate
> > - just have generic_fillattr() pick it there...
> > 
> > Reduces the patchset size quite a bit...
> 
> It could be done. To do that right, I think we'd want to drop
> request_mask from the ->getattr prototype as well and just have
> everything use the mask in the kstat.
> 
> I don't think it'd reduce the size of the patchset in any meaningful
> way, but it might make for a more sensible API over the long haul.

->getattr() prototype change would be decoupled from that - for your
patchset you'd only need the field addition + setting in vfs_getattr_nosec()
(and possibly in ksmbd), with the remainders of both series being
independent from each other.

What I suggest is

branchpoint -> field addition (trivial commit) -> argument removal
		|
		V
your series, starting with "use stat->request_mask in generic_fillattr()"

Total size would be about the same, but it would be easier to follow
the less trivial part of that.  Nothing in your branch downstream of
that touches any ->getattr() instances, so it should have no
conflicts with the argument removal side of things.
