Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0D6B3523
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 05:05:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXssT2MlKz3083
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 15:05:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=s4GPi5Xi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=s4GPi5Xi;
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXssN6zzlz3083
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 15:05:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sXO3jdqVtcE9IkmkZO6INMTY092zGfYbJtv9fnxM+sA=; b=s4GPi5XiLpgFxOlwC+NflMG4/X
	5HbPrHSvN06Y/6GM49O0nUugEJWHbzRYk7+EIhVHCxwEJLArUtCzzLmbb/w8xsdE1ryBSkDa4o/UH
	/N3oi9I6KVELpO4jbxOBBgqadEWL8k8Wl3X6o65G0ZkCGO7az4JwtM2Xp0Ugz8+6prxwsSFqzhWjX
	uX2Z+9SprefB8puk0M9v8g355tcJYOHb6tD4sgQOoxH5zYgTMjICW2GSKbf5ZGmTfecoDhGe3HaF4
	TTuzOp2phpd65QIpwrHo9QfKuhFLoKM1nmI+Zh35Eab3siV3m/GriED+HcHPd+vQqeBt2OFkrlOnZ
	M5IC4GPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1paU0C-00FCuh-1q;
	Fri, 10 Mar 2023 04:05:08 +0000
Date: Fri, 10 Mar 2023 04:05:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: erofs: convert to use i_blockmask()
Message-ID: <20230310040508.GN3390869@ZenIV>
References: <20230310031547.GD3390869@ZenIV>
 <20230310035121.56591-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310035121.56591-1-frank.li@vivo.com>
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
Cc: brauner@kernel.org, tytso@mit.edu, agruenba@redhat.com, joseph.qi@linux.alibaba.com, mark@fasheh.com, linux-kernel@vger.kernel.org, cluster-devel@redhat.com, rpeterso@redhat.com, huyue2@coolpad.com, adilger.kernel@dilger.ca, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 10, 2023 at 11:51:21AM +0800, Yangtao Li wrote:
> Hi AI,
> 
> > Umm...  What's the branchpoint for that series?
> > Not the mainline - there we have i_blocksize() open-coded...
> 
> Sorry, I'm based on the latest branch of the erofs repository.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/log/?h=dev-test
> 
> I think I can resend based on mainline.
> 
> > Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))
> > - compiler should bloody well be able to figure out that division by (1 << n)
> > is shift down by n and it's easier to follow that way...
> 
> So it seems better to change to DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))?
> 
> > And the fact that the value will be the same (i.e. that ->i_blkbits is never changed by ocfs2)
> > is worth mentioning in commit message...
> 
> How about the following msg?
> 
> Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
> to return bool type and the fact that the value will be the same
> (i.e. that ->i_blkbits is never changed by ocfs2).
> 
> 
> 
> A small question, whether this series of changes will be merged
> into each fs branch or all merged into vfs?

Depends.  The thing to avoid is conflicts between the trees and
convoluted commit graph.

In cases like that the usual approach is
	* put the helper into never-rebased branch - in vfs tree, in this
case; I've no real objections against the helper in question.
	* let other trees convert to the helper at leisure - merging
that never-rebased branch from vfs.git before they use the helper, of
course.  Or wait until the next cycle, for that matter...

I can pick the stuff in the areas that don't have active development,
but doing that for e.g. ext4 won't help anybody - it would only cause
headache for everyone involved down the road.  And I'd expect the gfs2
to be in the same situation...
