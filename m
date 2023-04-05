Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5E6D8588
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 20:02:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsCCf2GMhz3cjY
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 04:02:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bDpmWKsJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bDpmWKsJ;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsCCb15V2z3cLT
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 04:02:51 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 163C063D9B;
	Wed,  5 Apr 2023 18:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE1C433D2;
	Wed,  5 Apr 2023 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680717768;
	bh=3aMW3YLQCtQtlrkIbSPGZmnQ0yHQUxiJ9ttklW4hHxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDpmWKsJVZ3ckZA2xplbSRbcINv1TpMxisrITW5MrlmHOMQ3fien87NPN4a9AJA/B
	 x/QThFLx1SwGIWFo7Yx4Ag15CHnoj5bQhPU74Lr9NnQzQAppm4KDtyjgnjuKzJLhfa
	 7HyOovstmSkofw3kQLFfw9x5/h+8yFRSKEbXd3TFBt1w7lWOvtRr56+nYgTgBGNR50
	 Ljh42NAKmGC04mDXzBLfWEnfodDd6BPXzXQouL4wP0Gh16p95effEXjNlRYp8rj8tc
	 QM6XfbnPOu9Rc95DaJV9yZ5Z6e/fRetGpCm+o4wsNTx7fpv6ZZEpQM7h1h3nHBzDie
	 nZaAvfwaMjd3A==
Date: Wed, 5 Apr 2023 18:02:47 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <ZC23x22bxItnsANI@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
 <ZC2YsgYRsvBejGYY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2YsgYRsvBejGYY@infradead.org>
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
Cc: fsverity@lists.linux.dev, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, agruenba@redhat.com, "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 05, 2023 at 08:50:10AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 05, 2023 at 08:09:27AM -0700, Darrick J. Wong wrote:
> > Thinking about this a little more -- I suppose we shouldn't just go
> > breaking directio reads from a verity file if we can help it.  Is there
> > a way to ask fsverity to perform its validation against some arbitrary
> > memory buffer that happens to be fs-block aligned?

You could certainly add such a function that wraps around verify_data_block().
The minimal function prototype needed (without supporting readahead or reusing
the ahash_request) would be something like the following, I think:

    bool fsverity_verify_blocks_dio(struct inode *inode, u64 pos,
                                    struct folio *folio,
                                    size_t len, size_t offset);

And I really hope that you don't want to do DIO to the *Merkle tree*, as that
would make the problem significantly harder.  I think DIO for the data, but
handling the Merkle tree in the usual way, would be okay?

> 
> That would be my preference as well.  But maybe Eric know a good reason
> why this hasn't been done yet.
> 

I believe it would be possible, especially if DIO to the Merkle tree is not in
scope.  There just hasn't been a reason to the work yet.  And ext4 and f2fs
already fall back to buffer I/O for other filesystem features, so there was
precedent for not bothering with DIO, at least in the initial version.

- Eric
