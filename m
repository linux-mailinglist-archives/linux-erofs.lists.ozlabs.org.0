Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A494359F
	for <lists+linux-erofs@lfdr.de>; Wed, 31 Jul 2024 20:28:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MZlGIhPW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WZ0vt23prz3dBb
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Aug 2024 04:28:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MZlGIhPW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WZ0vj1Hzwz3cQf
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Aug 2024 04:27:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2aQ3rRiMo1IoChPaDuXxMICwK1el9B3aObPku20ECy0=; b=MZlGIhPWm+5MqV3NCZjMvK1Eyt
	SJW+CBGVOK1/5nzx80u7GwPqY8cA5ktrqaOPJycf0j7FzvzhAX3tmK4YLhsN9gJaLNfjnVMaY3u7N
	1kf2XpjBprBVE+GAsWCxzKWivZNd/rm0VfuI6rcudIEXhxD2kAAi09L1DUTIBc+yGep1QSrWRy3Il
	qSsYW3h6gnip6dR1GRx4oC8/PvfBB2ZlbdRVP+HVdhzi4HytIyRmgF9b8L6pQcI2MlqG2Fy1Ayt36
	60ogFustoI6RtKw2UEdG3tVz/tDITmZcjWXsQKec93zG3KVOTlr5x4ROPuyWhEigFhcfXxYARC6Kc
	yHWZXuzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZE35-0000000GQvH-2dAj;
	Wed, 31 Jul 2024 18:27:43 +0000
Date: Wed, 31 Jul 2024 19:27:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <ZqqCH0wvHjpVrsQl@casper.infradead.org>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
 <20240724133009.6st3vmk5ondigbj7@quack3>
 <20240729-gespickt-negativ-c1ce987e3c07@brauner>
 <20240731181657.dprkkq5jxgatgx2v@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731181657.dprkkq5jxgatgx2v@quack3>
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
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 31, 2024 at 08:16:57PM +0200, Jan Kara wrote:
> To fix this, either we'd have to keep the lower cache filesystem private to
> cachefiles (but I don't think that works with the usecases) or we have to
> somehow untangle this mmap_lock knot. This "page fault does quite some fs
> locking under mmap_lock" problem is not causing filesystems headaches for
> the first time. I would *love* to be able to always drop mmap_lock in the
> page fault handler, fill the data into the page cache and then retry the
> fault (so that filemap_map_pages() would then handle the fault without
> filesystem involvement). It would make many things in filesystem locking
> simpler. As far as I'm checking there are now not that many places that
> could not handle dropping of mmap_lock during fault (traditionally the
> problem is with get_user_pages() / pin_user_pages() users). So maybe this
> dream would be feasible after all.

The traditional problem was the array of VMAs which was removed in
commit b2cac248191b -- if we dropped the mmap_lock, any previous
entries in that array would become invalid.  Now that array is gone,
do we have any remaining dependencies on the VMAs remaining valid?
