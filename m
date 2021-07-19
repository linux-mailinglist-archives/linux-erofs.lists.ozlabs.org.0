Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EB3CD3A8
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 13:21:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GSzv93NgZz30DF
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 21:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=H4yUT9cW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+9026cc9f21ac068c1222+6539+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=H4yUT9cW; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GSzv75h5Tz2yXj
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jul 2021 21:21:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oHvZCvnyWx34050zBCmoBlfirYI9L7hPimae0Gd3np4=; b=H4yUT9cWMYv6PGWGnrxRQtjaqD
 tikdFFkPspmpm9WWHPs2lMO3rgdjm+yD8xfWJ4m8QSvKpK0FmtEvknaMdhjHm32O60PZ7W3ONTuLn
 9JXAac35lG0QVkL8qmcTP6EvkRwAyM0IFklG6p8pq5Cyp/YVAd8uAvbm/I3YMiCnNmBJFp/lj5wjv
 ii3u9rPfSPFUDDkSDCqrwtPepY5ShmRTv4r5H1XKzTdQfGvbvj98RGa21oYlDCxeteU8dV7LRLk5y
 iKZyCZy2iKDHqLpEEKk5BJTJ+7TDna/d7Mk9NuvRNAhfekwXOl3NH24wEJWNvwTJkzBq2jzk3/cac
 1XZtUd7Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m5RJ8-006naF-3J; Mon, 19 Jul 2021 11:19:42 +0000
Date: Mon, 19 Jul 2021 12:19:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPVfxn6/oCPBZpKu@infradead.org>
References: <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPLw0uc1jVKI8uKo@casper.infradead.org>
 <YPL0LqHzEbUY4zY/@B-P7TQMD6M-0146.local>
 <YPMkKfegS+9KzEhK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPMkKfegS+9KzEhK@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Andreas Gr?nbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 17, 2021 at 07:40:41PM +0100, Matthew Wilcox wrote:
> Well, either sense of a WARN_ON is wrong.
> 
> For a file which is PAGE_SIZE + 3 bytes in size, to_iomap_page() will
> be NULL.  For a file which is PAGE_SIZE/2 + 3 bytes in size,
> to_iomap_page() will not be NULL.  (assuming the block size is <=
> PAGE_SIZE / 2).
> 
> I think we need a prep patch that looks something like this:

Something like this is where we should eventually end up, but it
also affects the read from disk case so we need to be careful.
