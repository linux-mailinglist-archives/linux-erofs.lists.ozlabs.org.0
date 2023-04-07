Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEB06DB499
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 21:56:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtTf342lcz3fCt
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 05:56:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=clCdqAdS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=clCdqAdS;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtTf01QfJz3cjN
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 05:56:40 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4B55B65160;
	Fri,  7 Apr 2023 19:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E35C433D2;
	Fri,  7 Apr 2023 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680897397;
	bh=/3ooAeWJ2heTTSe1+fowce2OJCbJkwMvCSSAiGy5dOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clCdqAdSzIuv2Nh0psGWcWmbbwrVRtKcUMCziwd5jIFOLppq8+hvEMy6JY4RJLPMp
	 x59uWAeV4ig4ih4U7jNLyVsnpfqrD7RpPe3yfp1MP72D2FoXdLnTk3xUAdXqNiTo76
	 7873hQHGayV2JBek9f5U/Qb89gRu184TbrlBQn0ysEteLtxdwRM5mb1J34RmFP0nuB
	 8OYIQ3NfXnHpi+fJ2/tbB2xh0PRWi+ynfmrw1NaYWHy7dBecQ4XC5MBSI2cP1pxqcR
	 lMdFOAY4ytF24DuMMy3hoLnO4nDVkkibtBGuHd2D5IXcvpFkh35CRNw0rf+xT87I1L
	 SBA+hcx/gQt+g==
Date: Fri, 7 Apr 2023 19:56:36 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <ZDB1dPVjon4Qthok@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
 <ZC38DkQVPZBuZCZN@gmail.com>
 <20230405233753.GU3223426@dread.disaster.area>
 <20230406004434.GA879@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406004434.GA879@sol.localdomain>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 05:44:36PM -0700, Eric Biggers wrote:
> > Not vmalloc'ed, but vmapped. we allocate the pages individually, but
> > then call vm_map_page() to present the higher level code with a
> > single contiguous memory range if it is a multi-page buffer.
> > 
> > We do have the backing info held in the buffer, and that's what we
> > use for IO. If fsverity needs a page based scatter/gather list
> > for hardware offload, it could ask the filesystem to provide it
> > for that given buffer...
> > 
> > > BTW, converting fs/verity/ from ahash to shash is an option; I've really never
> > > been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
> > > this, though, would be that it would remove support for all the hardware crypto
> > > drivers.
> > >
> > > That *might* actually be okay, as that approach to crypto acceleration
> > > has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
> > > worry about e.g. someone coming out of the woodwork and saying they need to use
> > > fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
> > > they MUST use their crypto accelerator to get acceptable performance.
> > 
> > True, but we are very unlikely to be using XFS on such small
> > systems and I don't think we really care about XFS performance on
> > android sized systems, either.
> > 
> 
> FYI, I've sent an RFC patch that converts fs/verity/ from ahash to shash:
> https://lore.kernel.org/r/20230406003714.94580-1-ebiggers@kernel.org
> 
> It would be great if we could do that.  But I need to get a better sense for
> whether anyone will complain...

FWIW, dm-verity went in the other direction.  It started with shash, and then in
2017 it was switched to ahash by https://git.kernel.org/linus/d1ac3ff008fb9a48
("dm verity: switch to using asynchronous hash crypto API").

I think that was part of my motivation for using ahash in fsverity from the
beginning.

Still, it does seem that ahash is more trouble than it's worth these days...

- Eric
