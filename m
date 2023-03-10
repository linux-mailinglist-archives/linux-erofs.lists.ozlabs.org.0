Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0446B34DB
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 04:32:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXs7W4xXvz3cdM
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Mar 2023 14:32:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BlyYntEG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=BlyYntEG;
	dkim-atps=neutral
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXs7R2bv0z3bm6
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Mar 2023 14:32:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5nYji9aiOTPkm277QrYAaIqlTmxJJ+NstcSRT3Yv5A4=; b=BlyYntEGWpWNJHstS6q6njadFa
	P58IUANDyb039xyu+2aDp2c7OzdJYDBxQ5K36A+DuuZuUxMwyf+wQEWfkoOhKX//l4UgaNIAhZroj
	raHHfhXFjHkvEhH5SRgjFwVGqN5H037vB9hI2lc0ttLBBrZkpqsiVlRQ+zDDlDn2nXR/ym7JEaTMj
	k6jnj+0wNV9kTXPfzi28opkBB44CtxTJKx85YoHPGh4jQsUxI800+WVVKUEpFmH/vlz+1X4VI7tC3
	aHldI5fbRXyo7CAXw46+xJ66nAVzuZUZqoth8N05jHB92fCaFVa+cWyRpHY1w0o7SEQpAJUAyFnMg
	lssdi5Fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1paTUM-00FCbC-06;
	Fri, 10 Mar 2023 03:32:14 +0000
Date: Fri, 10 Mar 2023 03:32:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH v3 4/6] ext4: convert to use i_blockmask()
Message-ID: <20230310033213.GG3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-4-frank.li@vivo.com>
 <20230310031940.GE3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310031940.GE3390869@ZenIV>
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

On Fri, Mar 10, 2023 at 03:19:40AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 11:21:25PM +0800, Yangtao Li wrote:
> > Use i_blockmask() to simplify code.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > v3:
> > -none
> > v2:
> > -convert to i_blockmask()
> >  fs/ext4/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index d251d705c276..eec36520e5e9 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2218,7 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> >  {
> >  	struct inode *inode = mpd->inode;
> >  	int err;
> > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > +	ext4_lblk_t blocks = (i_size_read(inode) + i_blockmask(inode))
> >  							>> inode->i_blkbits;
> 
> Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode)) -
> compiler should bloody well be able to figure out that division by (1 << n) is
> shift down by n and it's easier to follow that way...

BTW, here the fact that you are adding the mask is misleading - it's true,
but we are not using it as a mask - it's straight arithmetics.

One can do an equivalent code where it would've been used as a mask, but that
would be harder to read -
	(((i_size_read(inode) - 1) | i_blockmask(inode)) + 1) >> inode->i_blkbits
and I doubt anyone wants that kind of puzzles to stumble upon.
