Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 514973CD3A4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 13:20:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GSzsM0ZV6z30Fn
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 21:20:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=h1qdBi0F;
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
 header.s=casper.20170209 header.b=h1qdBi0F; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GSzsB32lXz2yY9
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jul 2021 21:19:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XRraZAxjHWHOmKDHLSEsZ8UjvPxlwYc6y4fq7IIgfIQ=; b=h1qdBi0FWIlit/z9Kr+XrqBsI2
 8zGpF3RiZW81r65EUD8AOdCS5gMjNpuAwM5GfsuJnGIBIdlO6ajbmKyu0YlZhjoGpxIWvovLGulb0
 +ngRKmWAGi5Q4LL5rkDiAgHGqvtNsCI+o4aUgF7Lom+mJNC5Uco8q6X0cyT9KBR+/lLHZbg0/B1D2
 ZlxsXcHG+QEqLhO/LnIVys+tZHfQWPJDZJO4stCWDkyvftKpCdBWHr4dvnn6kdep4sZfZxcpiMbpU
 7G80OcHXKGajF53erZ23RAJfv2Dcmm66BZxo/dlPrZCBNvnj+tORfSn7/vRYFcGMO+C70MH7S3AqU
 SLckoFZw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m5RFT-006nL5-Qf; Mon, 19 Jul 2021 11:15:56 +0000
Date: Mon, 19 Jul 2021 12:15:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gr??nbacher <andreas.gruenbacher@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPVe41YqpfGLNsBS@infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> >From 62f367245492e389711bcebbf7da5adae586299f Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 16 Jul 2021 10:52:48 +0200
> Subject: [PATCH] iomap: support tail packing inline read

I'd still credit this to you as you did all the hard work.

> +	/* inline source data must be inside a single page */
> +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* handle tail-packing blocks cross the current page into the next */
> +	if (size > PAGE_SIZE - poff)
> +		size = PAGE_SIZE - poff;

This should probably use min or min_t.

>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> +	flush_dcache_page(page);

The flush_dcache_page addition should be a separate patch.

>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		loff_t size = inode->i_size;
> @@ -394,7 +395,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  			mark_inode_dirty(inode);
>  		}
>  	} else {
> -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
> +				length, iter);

We also need to take the offset into account for the write side.
I guess it would be nice to have a local variable for the inline
address to not duplicate that calculation multiple times.
