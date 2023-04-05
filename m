Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6686D85C9
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 20:16:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsCW01D2yz3f4b
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 04:16:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=REOOWtLg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=REOOWtLg;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsCVr5Gpnz3chl
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 04:16:04 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC7B63D3A;
	Wed,  5 Apr 2023 18:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710CAC433EF;
	Wed,  5 Apr 2023 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680718561;
	bh=wiJeaBlTTUnHN5dRjU986tMd+hpSmAJjFn5myvsg4zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REOOWtLgQ9JDh9SSF6xoyg94oSouuHFnpL2v3YnQ3T2oBYSI6IMS8Hy8imtRKtDy1
	 cU3K/Iy3e/I3Q2+TSdKRafqsRNXapecZukPc1WANLn9sTP01Li50nyZ7qlCS5TCVJ+
	 3cW7AZM1K/82Q6rN89XufLRWJRxkvNpgVxn/rDB2tRQwEAn32VY0qtyYqIT5Mhljtf
	 O5whuuDDjSKbQwdJKsF8Nl8Wr8dqY9vgtd1lUYNpjci7tFUD9wHH4/61yvdWJlTH+K
	 DtIew2Dd7HkelryBLbZ5MioiFh7yAV2qMaWKrH/687VXslb1Q2GI4zSjEhOMaWMwe0
	 NDlFE8RqYVveQ==
Date: Wed, 5 Apr 2023 18:16:00 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <ZC264FSkDQidOQ4N@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405163847.GG303486@frogsfrogsfrogs>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, hch@infradead.org, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 09:38:47AM -0700, Darrick J. Wong wrote:
> > The merkle tree pages are dropped after verification. When page is
> > dropped xfs_buf is marked as verified. If fs-verity wants to
> > verify again it will get the same verified buffer. If buffer is
> > evicted it won't have verified state.
> > 
> > So, with enough memory pressure buffers will be dropped and need to
> > be reverified.
> 
> Please excuse me if this was discussed and rejected long ago, but
> perhaps fsverity should try to hang on to the merkle tree pages that
> this function returns for as long as possible until reclaim comes for
> them?
> 
> With the merkle tree page lifetimes extended, you then don't need to
> attach the xfs_buf to page->private, nor does xfs have to extend the
> buffer cache to stash XBF_VERITY_CHECKED.

Well, all the other filesystems that support fsverity (ext4, f2fs, and btrfs)
just cache the Merkle tree pages in the inode's page cache.  It's an approach
that I know some people aren't a fan of, but it's efficient and it works.

We could certainly think about moving to a design where fs/verity/ asks the
filesystem to just *read* a Merkle tree block, without adding it to a cache, and
then fs/verity/ implements the caching itself.  That would require some large
changes to each filesystem, though, unless we were to double-cache the Merkle
tree blocks which would be inefficient.

So it feels like continuing to have the filesystem (not fs/verity/) be
responsible for the cache is the best way to allow XFS to do things a bit
differently, without regressing the other filesystems.

I'm interested in hearing any other proposals, though.

- Eric
