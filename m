Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0016D8ACE
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 00:54:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsKgr74H7z3f8X
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 08:54:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LovyRg/E;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LovyRg/E;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsKgl3pwgz3cfj
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 08:54:11 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 588C86413E;
	Wed,  5 Apr 2023 22:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A6C433EF;
	Wed,  5 Apr 2023 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680735247;
	bh=y5XoOju2yBDL4YDibMiieXpA89mTn+Rteq91AiPxCaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LovyRg/EAV0o26rHWyr3wwdJKBIWeqs2RWTqBiuMA93Uopo6KQP/kuk5d1BnGrKHX
	 eXiQmEFzna6WH31jznXOQEsuU8fCZaqbF53Fy9IDiBzVWVzNlq3Fcms5RC/AHMk3CM
	 OAU4zbey8PXa+toYXE1InTyNADGV791ee94FuTsdJtQmtxfk26JoNlrEZbAnyuI7RM
	 Tdnt072GBeEL29vP8V8lyr806zJWwdzwvcrm09fKje0OdHL52/Fkji9DdhPvGeeRQZ
	 JSFgndGfwhFR5/2N8nLhm2oMnQAOUpmI5ryVtmOxxrkwIl3UfC3Gz24KpM4fDrDRV4
	 EANBOVoAcG1Tg==
Date: Wed, 5 Apr 2023 22:54:06 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <ZC38DkQVPZBuZCZN@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405222646.GR3223426@dread.disaster.area>
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

On Thu, Apr 06, 2023 at 08:26:46AM +1000, Dave Chinner wrote:
> > We could certainly think about moving to a design where fs/verity/ asks the
> > filesystem to just *read* a Merkle tree block, without adding it to a cache, and
> > then fs/verity/ implements the caching itself.  That would require some large
> > changes to each filesystem, though, unless we were to double-cache the Merkle
> > tree blocks which would be inefficient.
> 
> No, that's unnecessary.
> 
> All we need if for fsverity to require filesystems to pass it byte
> addressable data buffers that are externally reference counted. The
> filesystem can take a page reference before mapping the page and
> passing the kaddr to fsverity, then unmap and drop the reference
> when the merkle tree walk is done as per Andrey's new drop callout.
> 
> fsverity doesn't need to care what the buffer is made from, how it
> is cached, what it's life cycle is, etc. The caching mechanism and
> reference counting is entirely controlled by the filesystem callout
> implementations, and fsverity only needs to deal with memory buffers
> that are guaranteed to live for the entire walk of the merkle
> tree....

Sure.  Just a couple notes:

First, fs/verity/ does still need to be able to tell whether the buffer is newly
instantiated or not.

Second, fs/verity/ uses the ahash API to do the hashing.  ahash is a
scatterlist-based API.  Virtual addresses can still be used (see sg_set_buf()),
but the memory cannot be vmalloc'ed memory, since virt_to_page() needs to work.
Does XFS use vmalloc'ed memory for these buffers?

BTW, converting fs/verity/ from ahash to shash is an option; I've really never
been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
this, though, would be that it would remove support for all the hardware crypto
drivers.  That *might* actually be okay, as that approach to crypto acceleration
has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
worry about e.g. someone coming out of the woodwork and saying they need to use
fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
they MUST use their crypto accelerator to get acceptable performance.

- Eric
