Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B589FEC0
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Apr 2024 19:38:33 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQ6nQCFO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VF96G6h6nz3vcF
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Apr 2024 03:38:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gQ6nQCFO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VF9693w4hz2ykC
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Apr 2024 03:38:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DB927CE2B00;
	Wed, 10 Apr 2024 17:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F7C433C7;
	Wed, 10 Apr 2024 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770702;
	bh=8bk8QbWwBjxogV8sulrsLmw3J8c/0qzWYceZvwMmUOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQ6nQCFOxjCTOgr5FktkEvhBwT+60FB9SznvO+NovCDxX/VDbZy9GldL1pityvO9m
	 RzvIh1Yb9KHL+608nk7G0c8nyN1iHLVZTbiHooVXwZyBBl+UVILDZfCaTMA7y7WuGJ
	 hYRVDbFDPZSh+h3NBoz5DqRO5zF6wap442xwxF/OeoX9BRgHi+LEnorn28rcGC3xL5
	 SEd2FWO0t3xP65ddc+HvYOG+4apVIy0CsGeoyHyd7KXMBPFy9e3zoe7Gue7qZxTwOn
	 oFxukrXWAYyHVkIdv86hSbPooOQQs+Swdk8bG+PThkIevqoOd7KST9sX9vZAS3Df02
	 Dm3soaO/TIdaw==
Date: Wed, 10 Apr 2024 18:38:15 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 26/26] netfs, afs: Use writeback retry to deal with
 alternate keys
Message-ID: <20240410173815.GA514426@kernel.org>
References: <20240401135351.GD26556@kernel.org>
 <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-27-dhowells@redhat.com>
 <3002686.1712046757@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3002686.1712046757@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 02, 2024 at 09:32:37AM +0100, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > > +	op->store.size		= len,
> > 
> > nit: this is probably more intuitively written using len;
> 
> I'm not sure it makes a difference, but switching 'size' to 'len' in kafs is a
> separate thing that doesn't need to be part of this patchset.

Sorry, I meant, using ';' rather than ',' at the end of the line.
