Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC5E6DE976
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 04:33:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Px6G24h0vz3cXl
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Apr 2023 12:33:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ICEWpWIH;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ICEWpWIH;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Px6Fx1qfQz2yNy
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Apr 2023 12:33:25 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2265560FA2;
	Wed, 12 Apr 2023 02:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F370C433D2;
	Wed, 12 Apr 2023 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681266801;
	bh=uWYRkl4H5QxQQyKZRkipfJYb8JT+WBT0+Wf0sQwa8R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICEWpWIHfCvZctrTa23zt5ow0V8NDHh2F1i00eVdXSsHwgqMLrkRT/XlEYlKmjHDc
	 19nDnI8fLxzFqlz2xC7lWzBe/z+FLZQp9I6XnZMJNnBuVmGr4gIcbNqsErYoKb0m7p
	 sxQgr5EWBTLQtP3m6ZbcVg4DVMLneqkbV0LUwwpej+ysbJ8GM6GOmxaIXmht+TVLM5
	 8AoJUx4LJxeAkTKLmK+QxNTrCOzWSGGlTQai0S4osbYt1lIObyZ+GefEjAWZe5ts/v
	 1DVrYg2TcXMS5rnXRentQX9hoIWFgOeiZNMnlongYGP1HyqIKramwdoHwdF+582obz
	 FYYaJGFJaqEvg==
Date: Tue, 11 Apr 2023 19:33:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <20230412023319.GA5105@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <ZDTt8jSdG72/UnXi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDTt8jSdG72/UnXi@infradead.org>
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
Cc: fsverity@lists.linux.dev, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, damien.lemoal@opensource.wdc.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Apr 10, 2023 at 10:19:46PM -0700, Christoph Hellwig wrote:
> Dave is going to hate me for this, but..
> 
> I've been looking over some of the interfaces here, and I'm starting
> to very seriously questioning the design decisions of storing the
> fsverity hashes in xattrs.
> 
> Yes, storing them beyond i_size in the file is a bit of a hack, but
> it allows to reuse a lot of the existing infrastructure, and much
> of fsverity is based around it.  So storing them in an xattrs causes
> a lot of churn in the interface.  And the XFS side with special
> casing xattr indices also seems not exactly nice.

It seems it's really just the Merkle tree caching interface that is causing
problems, as it's currently too closely tied to the page cache?  That is just an
implementation detail that could be reworked along the lines of what is being
discussed.

But anyway, it is up to the XFS folks.  Keep in mind there is also the option of
doing what btrfs is doing, where it stores the Merkle tree separately from the
file data stream, but caches it past i_size in the page cache at runtime.

I guess there is also the issue of encryption, which hasn't come up yet since
we're talking about fsverity support only.  The Merkle tree (including the
fsverity_descriptor) is supposed to be encrypted, just like the file contents
are.  Having it be stored after the file contents accomplishes that easily...
Of course, it doesn't have to be that way; a separate key could be derived, or
the Merkle tree blocks could be encrypted with the file contents key using
indices past i_size, without them physically being stored in the data stream.

- Eric
