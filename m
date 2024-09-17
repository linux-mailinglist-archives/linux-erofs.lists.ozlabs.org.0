Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E656697AB0E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 07:34:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X79TG54r8z2yMt
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2024 15:34:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726551281;
	cv=none; b=jjp8TZCj2X1mshfMceWaYpuDGyzEFYYG1NMlhVGLvmY8nDOz0K9aRe+Ix8l5mpOWt583RxufczY+ELunZCKQ6SOOa/ZGFZsimeL17Jxq/dm0y1Mdfsq0ibGddtxEkdVldpR9FdgQZrmoaxVACbciHy+AXsQ3k/2Uli0sMQHU1Q0y/33LWdNld+BqUNBca1MQlZkXq6l5op4dNmGpUKnulK0t1E4F0/pmKNcYfuGZauZ5GiPiB8Uc/C3m4VtZo3FKtJ3SUTyugCjYgkVcLVDp2v93hbI+JuZLayKrgn7g1Q3k8Azb3pq7AmjJJ0pazTrC3PbwP4uC3LGUFa+zCeYVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726551281; c=relaxed/relaxed;
	bh=ylLwiAepwwfef7mUQTrbdZ6pS65cPGUyfXXtjM8vUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itqRPuCsL/69G79rLt5Z0jgEu+bMlFKmMounmZAN4FncOPa+4gU1wYRXBQl9zFxeDKsvNUyLnqhU3ybY4Z8ZhoEz6fTy/xRHwikaYq2lTII/h3Kb/7zA4m9DLjq/6CCMGye+MP6ItVi4z9kEx1t4vCgE445ycnjiksvb47IUlGSF+7+kX5S36cOtkXnvIXgQxVCUIiGIv1zlNYwtqDX2zRJqCVHXfOy6dIauorEGrZ1RaVWWO5384ei5+0MEBGgVlSPNZ9mo2C28SfBG/0qVZ+LX8bgtwqB/sP7rIGPA0rHZ7l/bMkSfvHEEbv7b7fmck0LCtdTuOu/KQ7/L6Lff4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n0SLIoxA; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=n0SLIoxA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X79TD2RPZz2xY6
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2024 15:34:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2E95A5C01DB;
	Tue, 17 Sep 2024 05:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEECC4CEC6;
	Tue, 17 Sep 2024 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726551276;
	bh=2PPXsB99Wx7DXtoG9gyiqOc62XsvddUP7aAxrHGWr1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0SLIoxAk1LOnU11qV51emCyj0yH4TToCO1jWU7PNuQPY5iL5s/5ORtjFFQ7UMIVw
	 EFgRsxoauY9XRIBdJObT15tzs5Yt/b82/dt6mL5rhppovHTdizgQWg9VHoitDBxPGM
	 x6d3BY5xW/AQ4h8lfp4QqhfLSDvtfcJ8ibO4UnUU=
Date: Tue, 17 Sep 2024 07:34:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <2024091702-easiest-prelude-7d4f@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
 <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 17, 2024 at 08:18:06AM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2024/9/17 01:55, Greg KH wrote:
> > On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> > > diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> > > new file mode 100644
> > > index 000000000000..0f1400175fc2
> > > --- /dev/null
> > > +++ b/fs/erofs/rust/erofs_sys.rs
> > > @@ -0,0 +1,22 @@
> > > +#![allow(dead_code)]
> > > +// Copyright 2024 Yiyang Wu
> > > +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> > 
> > Sorry, but I have to ask, why a dual license here?  You are only linking
> > to GPL-2.0-only code, so why the different license?  Especially if you
> > used the GPL-2.0-only code to "translate" from.
> > 
> > If you REALLY REALLY want to use a dual license, please get your
> > lawyers to document why this is needed and put it in the changelog for
> > the next time you submit this series when adding files with dual
> > licenses so I don't have to ask again :)
> 
> As a new Rust kernel developper, Yiyang is working on EROFS Rust
> userspace implementation too.
> 
> I think he just would like to share the common Rust logic between
> kernel and userspace.

Is that actually possible here?  This is very kernel-specific code from
what I can tell, and again, it's based on the existing GPL-v2 code, so
you are kind of changing the license in the transformation to a
different language, right?

> Since for the userspace side, Apache-2.0
> or even MIT is more friendly for 3rd applications (especially
> cloud-native applications). So the dual license is proposed here,
> if you don't have strong opinion, I will ask Yiyang document this
> in the next version.  Or we're fine to drop MIT too.

If you do not have explicit reasons to do this, AND legal approval with
the understanding of how to do dual license kernel code properly, I
would not do it at all as it's a lot of extra work.  Again, talk to your
lawyers about this please.  And if you come up with the "we really want
to do this," great, just document it properly as to what is going on
here and why this decision is made.

thanks,

greg k-h
