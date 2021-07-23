Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B306D3D4102
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 21:41:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWfnv1Y26z30GK
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 05:41:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DUvza/oQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=DUvza/oQ; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWfnl4Ymxz30FR
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 05:41:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wLxpkipMgvxMPaddvglb23fn92nRwXLxVzoe/PF9JSQ=; b=DUvza/oQxDEBXJqJ5qe+4PTwXC
 ChPVxolPzM+XTosRn0XRvWFQ1OexQFajE9Z4o9uitWBobGl7UU32YrNCyj13LnbxrrY7sbjBM5sOR
 jem8Ki3m+t/iECfVFQlshxNX45nc/eyPN3oj8wmvTLfxkTpY33/OiXq+3GtkUPO3QkQoHn9w6nVwp
 uzii5hHtVnIYlPPFUwAKLO3vYU7S7rkj+XqvPCeK8GEQtCKAATVF/wDFqFQwJgz4us0q/h/xs0hY6
 WtG0OT4Y1X0p3fVH2+2M05eariMyo6FgboYSkFr32VXkQ9kHDCOKAkAzitN4xwH7RALnAOMwdwUqX
 gIUnrWJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m712R-00BgWf-O0; Fri, 23 Jul 2021 19:41:00 +0000
Date: Fri, 23 Jul 2021 20:40:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YPsbQzcNz+r4V7P2@casper.infradead.org>
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 24, 2021 at 01:41:31AM +0800, Gao Xiang wrote:
> Add support for reading inline data content into the page cache from
> nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> mode where the last few bytes of the file are stored right after the
> inode.
> 
> The buffered write path remains untouched since EROFS cannot be used
> for testing. It'd be better to be implemented if upcoming real users
> care and provide a real pattern rather than leave untested dead code
> around.

My one complaint with this version is the subject line.  It's a bit vague.
I went with:

iomap: Support file tail packing

I also wrote a changelog entry that reads:
    The existing inline data support only works for cases where the entire
    file is stored as inline data.  For larger files, EROFS stores the
    initial blocks separately and then can pack a small tail adjacent to
    the inode.  Generalise inline data to allow for tail packing.  Tails
    may not cross a page boundary in memory.

... but I'm not sure that's necessarily better than what you've written
here.

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

