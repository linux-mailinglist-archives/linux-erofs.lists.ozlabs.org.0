Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCE85B830
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 10:51:43 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HdGmA/T8;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TfF6h71s4z3bwj
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Feb 2024 20:51:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HdGmA/T8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TfF6c0B0Sz2yts
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Feb 2024 20:51:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A7ED061134;
	Tue, 20 Feb 2024 09:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F3C433F1;
	Tue, 20 Feb 2024 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422692;
	bh=TPGKN24CaFtGRIE0VeP5mwAzn+ZOxDeAL3aTzRUirss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdGmA/T8Yh36xJUAh9kQ4QRKg7xEAQSuwUEa0iQfBV+TmOCP9i2ysDi55lCEigAVt
	 iMT8PDu6Rsb3s5qii2+KygzOb/oCQ9TYhW7beSNZoJsCyQepfzdtxrVNl6qdJpDfM9
	 ENot3D+ATZi+xZnx9fTxI67SE5FeCahLHb/4spD+As4ZJA9cprBz+57uYMwVLGHLxo
	 dUoQEOj3B16cNb7kuh8ze8i6nhjOtYUO6nOlEpyjUfRbKUX24e7uigjhU/IF3uPzzV
	 3e6/jprnSqfIlqBk7V1r9K0s6hbEbuvieS7jIy8VvBS7T/S/8Pa9u5ZtLGfGibQ3us
	 f9XfJxph4bz1g==
Date: Tue, 20 Feb 2024 10:51:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Message-ID: <20240220-autoteile-enthoben-a9a16739b2b9@brauner>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
 <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Dominique Martinet <asmadeus@codewreck.org>, linux_oss@crudebyte.com, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Christian Brauner <christian@brauner.io>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Feb 19, 2024 at 09:38:33AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 29.01.24 10:49, David Howells wrote:
> > Fix netfs_unbuffered_write_iter() to return immediately if
> > generic_write_checks() returns 0, indicating there's nothing to write.
> > Note that netfs_file_write_iter() already does this.
> > 
> > Also, whilst we're at it, put in checks for the size being zero before we
> > even take the locks.  Note that generic_write_checks() can still reduce the
> > size to zero, so we still need that check.
> > 
> > Without this, a warning similar to the following is logged to dmesg:
> > 
> > 	netfs: Zero-sized write [R=1b6da]
> > 
> > and the syscall fails with EIO, e.g.:
> > 
> > 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> > 
> > This can be reproduced on 9p by:
> > 
> > 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> > 
> > Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> > Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> > Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
> 
> David, thx for fixing Eric's regression, which I'm tracking.
> 
> Christian, just wondering: that patch afaics is sitting in vfs.netfs for
> about three weeks now -- is that intentional or did it maybe fell
> through the cracks somehow?

I've moved it to vfs.fixes now and will send later this week. Thanks for
the reminder!
