Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668263CB7A9
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 15:04:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRBJV17Tkz301t
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 23:03:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JSAv+m6Z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=JSAv+m6Z; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRBJL2FPNz2yPB
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 23:03:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZnncS7EMVgffQsq6qFPh/18HhJ7accRmRlB/yo0s+qU=; b=JSAv+m6ZpKT/OgpPZ5INhBHanu
 QVyPEIr/P4R+CJu/yBbb24MkyFoVlRsOhkblNsYi+CBUoalGt+yQLUtQ3PMNxYtPDBRBGc6LB62jU
 XOcXv8JP7Htt4hYsHDeeBN0ZeqGwM3MouwXrhVMkRVQWeztziQ9eNQR8T/xZe8KGTqXMWdv8JePdu
 snYUMYkPAdRMiWJmWnBasals+i5LGXq8PACRz1efviUrq1ahXYxCVgcsla2P+zXpN3vMBS61C4gri
 DntZyk/SJXTLoCRkKaDzsL0L0vswEtdBFgClxONP/qIEs0NSlGCSz1TUhIrHRt34N1SahOCOpvtGs
 XjGd69zQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4NU5-004URh-SL; Fri, 16 Jul 2021 13:02:44 +0000
Date: Fri, 16 Jul 2021 14:02:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGDZYT9OxdgNYf2@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Bo <bo.liu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> This tries to add tail packing inline read to iomap. Different from
> the previous approach, it only marks the block range uptodate in the
> page it covers.

Why?  This path is called under two circumstances: readahead and readpage.
In both cases, we're trying to bring the entire page uptodate.  The inline
extent is always the tail of the file, so we may as well zero the part of
the page past the end of file and mark the entire page uptodate instead
and leaving the end of the page !uptodate.

I see the case where, eg, we have the first 2048 bytes of the file
out-of-inode and then 20 bytes in the inode.  So we'll create the iop
for the head of the file, but then we may as well finish the entire
PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
as being uptodate and leave the 3072-4095 block for a future iteration.

