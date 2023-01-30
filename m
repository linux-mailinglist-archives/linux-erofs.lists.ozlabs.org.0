Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D93680AB8
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 11:23:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P545n0Ln4z3cL0
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jan 2023 21:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JN3lXwEW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JN3lXwEW;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P545c0zfHz3c4w
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jan 2023 21:23:32 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB75C60EE8;
	Mon, 30 Jan 2023 10:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848BCC433EF;
	Mon, 30 Jan 2023 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675074209;
	bh=JNTyAwdnYzLmCEymJc/ZUWnk+Q8qvEe4IQT1QMUZUUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JN3lXwEWVDPGXUGplDwCOYjrW8++AmiuyWsKytBrUAmwH5pYzbdpE0vlm5QMheggM
	 NBh8TxCmRl0oiVPGeH0p588WtzUGa4Dhxdj47urWqRw5C3YGCL7sEtEpljLyqeU2qK
	 hZMY3SfpZs4a7G1hzx2PjWG4oBFdjJLdjf/CAOLVLdkBRxoWDtbAN1LxJYt5Pv5/uW
	 JiIhf6J6BcQzCzFwiWHxFBJvn0+sgbTbzFveW5be89tbifEA4YoFlo/yhqSIZATMj0
	 cya32Nkc883EMLF+aa2JEWlyaIljfcXui3HQsRaEUKig3vqEj5vhHo9pWtvCv6EINs
	 lzNgfo6NIXgGw==
Date: Mon, 30 Jan 2023 11:23:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/12] acl: remove remaining posix acl handlers
Message-ID: <20230130102322.kkq5u72skrmykilh@wittgenstein>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
 <20230130091052.72zglqecqvom7hin@wittgenstein>
 <20230130091615.GB5178@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130091615.GB5178@lst.de>
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
Cc: reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com, Seth Forshee <sforshee@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jan 30, 2023 at 10:16:15AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 10:10:52AM +0100, Christian Brauner wrote:
> > However, a few filesystems still rely on the ->list() method of the
> > generix POSIX ACL xattr handlers in their ->listxattr() inode operation.
> > This is a very limited set of filesystems. For most of them there is no
> > dependence on the generic POSIX ACL xattr handler in any way.
> > 
> > In addition, during inode initalization in inode_init_always() the
> > registered xattr handlers in sb->s_xattr are used to raise IOP_XATTR in
> > inode->i_opflags.
> > 
> > With the incoming removal of the legacy POSIX ACL handlers it is at
> > least possible for a filesystem to only implement POSIX ACLs but no
> > other xattrs. If that were to happen we would miss to raise IOP_XATTR
> > because sb->s_xattr would be NULL. While there currently is no such
> > filesystem we should still make sure that this just works should it ever
> > happen in the future.
> 
> Now the real questions is: do we care?  Once Posix ACLs use an
> entirely separate path, nothing should rely on IOP_XATTR for them.
> So instead I think we're better off auditing all users of IOP_XATTR
> and making sure that nothing relies on them for ACLs, as we've very
> much split the VFS concept of ACLs from that from xattrs otherwise.

I had a patch like that but some filesystems create inodes that
explicitly remove IOP_XATTR to prevent any xattrs from being set on
specific inodes. I remember this for at least reiserfs and btrfs.

So we would probably need IOP_NOACL that can be raised by a filesystem
to explicitly opt out of them for specific inodes. That's probably fine
and avoids having to introduce something like SB_I_XATTR.
