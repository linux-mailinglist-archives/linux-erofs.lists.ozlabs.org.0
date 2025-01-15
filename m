Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041CA12C9E
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 21:30:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYHgg5Q0jz3bkT
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 07:30:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:a000:7:0:5054:ff:fe1c:15ff"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736973038;
	cv=none; b=G4xzpb9WtfJeoFsDeO6Czs09aXjHsSdywx6P5Y3PmcoY7e2M7zsFqkVmflbuJ7fkWCuz+qA5iUP5zUSU1xN0b4ZNOkjsKruPYZMXMT21po49XSXGZs5K3+/RRHaQlFkWbNnFvjaCsq/nqZNGey9bClIrra3k6wo7mBQKgGNcTHRQ4cL96qWJ4/rgR+Iow+fJgn+ZJOe9JghVK3+wUHwngLFhTgv88kmX5e7dwAZQP5XfpdkatjnSUXivYEC/Na9Lj/jk7GwjijkhRSL9s/QFJhASIbb+e237xpdJhwJML+vX9jQ6bbPy+YWdmCG33pmfXQIJhp8mc0GCkgsVfHIjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736973038; c=relaxed/relaxed;
	bh=iFZH/qrvE9cPwBM5Scsg9nKR3U4eYSNRd+JFXwMnEt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0CkRCG1IBUNSUYa57liJDrbLrbGknBGYCUkHisjIOTd/bHkcosyoaVGzNKZpsuSLCZyNpt4y4ecyjILY+K4BMvW9UCA2+Gy/9OeuISkpgCmF95tQBke2QhOxzwS8rK1IdgMguJi003KEI0BCNO0O9md8oLTrDGzjeHi3SBTnZgfkIUNyJ8BoYk5Q36Q6fyFOl0hY8jK1UDm9FEu9Hh4gqMQej/cS9DngJ0ZEmdlQjjTCBgENN0jpGrinOaIlcFs+yMX9hyRYzcMdLVuY4VL81a0U4kl2NmAWmJefZ1nUMyokMO0GUsFaIAicURvYvjAbn0Ys7MECufj00JsV+6wrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=dz6bki97; dkim-atps=neutral; spf=none (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=dz6bki97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff; helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk; receiver=lists.ozlabs.org)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYHgY0zHdz3bV7
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 07:30:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iFZH/qrvE9cPwBM5Scsg9nKR3U4eYSNRd+JFXwMnEt4=; b=dz6bki97d68QE0+2tK0fyQvi6T
	UuCwtBEDg3PFiWsTtgCfeIFNnoKBtFemjzZ1yEoDMpuI7hNvr0j6e3/m7pib7SUTPYSUd8uiz3NhW
	gS1jF4J/LH9rDfHEd6o3QxerNucNMcLM/VGqUKhpKQtEUjB9J5rYvLV5/Ao7zWkB6f7tOM9w+t1qy
	A3eLliXAQZiBO3g0RK9ANAXkGPnVfp47tApxmQPY2wyn2dxltvijGYd9HgYfztHCbKt7rdZb7/TAc
	FUxMieU2vrxrnULKyZYrK7LobYE4d0UW/yIgd4PwPG4vrw60IBRFMjFLRCxu4nAsAiNVRKmb+q3zh
	k2PTNqaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYA1w-00000001jSo-2cMd;
	Wed, 15 Jan 2025 20:30:24 +0000
Date: Wed, 15 Jan 2025 20:30:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <20250115203024.GB1977892@ZenIV>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
 <Z4gW4wFx__n6fu0e@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4gW4wFx__n6fu0e@dread.disaster.area>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	SPF_HELO_NONE,SPF_NONE autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jan 16, 2025 at 07:13:23AM +1100, Dave Chinner wrote:
> On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/dcache.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index b4d5e9e1e43d..1a01d7a6a7a9 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> >  	/* Make sure we always see the terminating NUL character */
> >  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> >  
> > -	dentry->d_lockref.count = 1;
> >  	dentry->d_flags = 0;
> > -	spin_lock_init(&dentry->d_lock);
> 
> Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...

include/linux/dcache.h:80:#define d_lock  d_lockref.lock
