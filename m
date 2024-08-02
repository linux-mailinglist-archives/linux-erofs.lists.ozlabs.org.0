Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D5945F96
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 16:44:24 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzIfzPbq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wb7rj6kBbz3dXP
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 00:44:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzIfzPbq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wb7rc6mrkz3dRP
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2024 00:44:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D0BDDCE11E0;
	Fri,  2 Aug 2024 14:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55967C32782;
	Fri,  2 Aug 2024 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722609851;
	bh=x8gmfjyvWGUc0bCINyn9NBAMXGuzcpTpCIJEd8Maaqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzIfzPbqeWDSXjHiBgkEJnEtvR/x00pI80yfMOPspsqu8FySfDHUqzDYaUa33dMPa
	 9VuWj+8Sla/wxa6LgFUP4mUw5Uqld7oPO/Rc7VTvnZTkP4QUsX0WNIBJRfMKEbOm5E
	 0O3SbfpH6tCZjpWaiiD1fNODTiZvR3ChGvm1WdEivsVrn36vxh5q5dSLX0Bq7q6TW/
	 ZIfiaLlaRb/QTv1p8yRpvlyNCDsCx+PAndbRntFM/P58FfzqAwLyMhP9mXUnvR6Pti
	 auvyf2mCECPYJDUbbakovkI3Q9PN8/kFR339yvIkgqaDOFi20gDtMTllo/pWmelP5F
	 gBuJs50KKDLcA==
Date: Fri, 2 Aug 2024 15:44:05 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Message-ID: <20240802144405.GD2504122@kernel.org>
References: <20240731190742.GS1967603@kernel.org>
 <20240729162002.3436763-1-dhowells@redhat.com>
 <20240729162002.3436763-19-dhowells@redhat.com>
 <117846.1722608282@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117846.1722608282@warthog.procyon.org.uk>
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 02, 2024 at 03:18:02PM +0100, David Howells wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
> > If the code ever reaches this line, then slice will be used
> > uninitialised below.
> 
> It can't actually happen (or, at least, it shouldn't).  There are only three
> ways of obtaining data: downloading from the server
> (NETFS_DOWNLOAD_FROM_SERVER), reading from the cache (NETFS_READ_FROM_CACHE)
> and just clearing space (NETFS_FILL_WITH_ZEROES); each of those has its own
> if-statement that will set 'slice' or will switch the source to a different
> type that will set 'slice'.
> 
> The problem is that the compiler doesn't know this.
> 
> The check for NETFS_INVALID_READ is there just in case.  Possibly:
> 
> 		if (source == NETFS_INVALID_READ)
> 			break;
> 
> could be replaced with a WARN_ON_ONCE() and an unconditional break.

Thanks, I think that should make the compiler happy without
significantly altering the flow or readability of the code.
