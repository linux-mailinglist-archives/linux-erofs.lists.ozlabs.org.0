Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34470A6CF
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 11:41:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QNdyc6ltbz3cgv
	for <lists+linux-erofs@lfdr.de>; Sat, 20 May 2023 19:41:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RCKu+qWL;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RCKu+qWL;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QNdyV4J4zz3c9V
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 May 2023 19:41:38 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8412D60B61;
	Sat, 20 May 2023 09:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90607C433EF;
	Sat, 20 May 2023 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684575694;
	bh=Qi34Xt1y6x93U61QykhNqil2JS5d/WED6AUV/H0U3cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCKu+qWLljLQMkOKKE7+IBqPv71gQvySDl07esuV8mxzFnjBimDFbJ+MeTXiImdwi
	 LAo1oAYsycIi6Ngjivs8aWf09Cb9lAvSPT8V2b4vnr52AhA3wOa/eQDFYZZeo1f4LA
	 1dZwCOGQ7U8tRHWFm0WzUOBEiB2QJO1tfY0b2INLx6s4X3yorcUT+1egxyQYM79jmL
	 VEwcuw7Dj4wzdbpCiR3/dZ5jcuQr/CBLIo4+1Q6Z325lA4XAokTZBbKp7ZzDfVTlP3
	 rPhjhxF3vQ/ENd4VZF5WlXEzG14C074CDwifY9/pZY9VpqGP7shdUgTnByBELcVTt2
	 V26DafIYZg3Tg==
Date: Sat, 20 May 2023 11:41:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v21 08/30] splice: Make splice from a DAX file use
 copy_splice_read()
Message-ID: <20230520-gepocht-akzeptabel-b117346c55b6@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-9-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-9-dhowells@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, linux-xfs@vger.kernel.org, David Hildenbrand <david@redhat.com>, linux-erofs@lists.ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>, Jason Gunthorpe <jgg@nvidia.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, May 20, 2023 at 01:00:27AM +0100, David Howells wrote:
> Make a read splice from a DAX file go directly to copy_splice_read() to do
> the reading as filemap_splice_read() is unlikely to find any pagecache to
> splice.
> 
> I think this affects only erofs, Ext2, Ext4, fuse and XFS.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-ext4@vger.kernel.org
> cc: linux-xfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Fwiw, O_DIRECT and DAX could've just been folded into one patch imho.
Reviewed-by: Christian Brauner <brauner@kernel.org>
