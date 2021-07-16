Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98013CB811
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 15:48:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRCJR4qBrz303h
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 23:48:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iPIHtj/j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=iPIHtj/j; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRCJN5p6wz2yNT
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 23:48:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CHBQMIYjF69FA2gIyZaFptHFVKHivJqyTB2HIyMYZO8=; b=iPIHtj/jsfpKa+a4IGnEc3wC1W
 nf64vk+sLr385Zy4w5ggTqtNLDnpNp17NP3Hu+5JZ+Og2mjShh7k2A7KVXyP7HFliWFgYvR3PQFr4
 JCfsVOUqnlyEthAL4yCYvdToxwlG4LiCnx//a4R6oUY3/+bP+DMUGO8d4fftbcUKgQ2aggSPfIoEN
 fakdGJXIVQ2Rr0DyE82l7u7UzyToWSLGZnxkJk4ofSHrSVIVyJ5nkPzLwxt7Noe2uohmtbCOVGnZS
 32hgW7YHhxvtii9Fy9QEWstKrcESRyIfWii69VHIf+KkOq6ZPNchnuZ9+yYrdSp04TvIefuWP3JTY
 on6GKVyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4OBj-004WBk-9H; Fri, 16 Jul 2021 13:47:50 +0000
Date: Fri, 16 Jul 2021 14:47:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGN97vWokqkWSZn@casper.infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPFPDS5ktWJEUKTo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPFPDS5ktWJEUKTo@infradead.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 16, 2021 at 10:19:09AM +0100, Christoph Hellwig wrote:
>  static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> +		struct iomap *iomap, loff_t pos, unsigned int size)
>  {
> -	size_t size = i_size_read(inode);
> +	unsigned int block_aligned_size = round_up(size, i_blocksize(inode));
> +	unsigned int poff = offset_in_page(pos);
>  	void *addr;
>  
> -	if (PageUptodate(page))
> -		return;
> -
> -	BUG_ON(page_has_private(page));
> -	BUG_ON(page->index);
> +	/* make sure that inline_data doesn't cross page boundary */
>  	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	BUG_ON(size != i_size_read(inode) - pos);
>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +	memset(addr + poff + size, 0, block_aligned_size - size);
>  	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> +
> +	iomap_set_range_uptodate(page, poff, block_aligned_size);
>  }

This should be relatively straightforward to port to folios.
I think it looks something like this ...

@@ -211,23 +211,18 @@ struct iomap_readpage_ctx {
 };

 static void iomap_read_inline_data(struct inode *inode, struct folio *folio,
-               struct iomap *iomap)
+               struct iomap *iomap, loff_t pos, size_t size)
 {
-       size_t size = i_size_read(inode);
        void *addr;
+       size_t offset = offset_in_folio(folio, pos);

-       if (folio_test_uptodate(folio))
-               return;
+       BUG_ON(size != i_size_read(inode) - pos);

-       BUG_ON(folio->index);
-       BUG_ON(folio_multi(folio));
-       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
-
-       addr = kmap_local_folio(folio, 0);
+       addr = kmap_local_folio(folio, offset);
        memcpy(addr, iomap->inline_data, size);
        memset(addr + size, 0, PAGE_SIZE - size);
        kunmap_local(addr);
-       folio_mark_uptodate(folio);
+       iomap_set_range_uptodate(folio, to_iomap_page(folio), pos, size);
 }

> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> +	if (iomap->type == IOMAP_INLINE && !pos)
> +		WARN_ON_ONCE(to_iomap_page(page) != NULL);
> +	else
> +		iop = iomap_page_create(inode, page);

This WARN_ON doesn't make sense to me.  If a file contains bytes 0-2047
that are !INLINE and then bytes 2048-2050 that are INLINE, we're going
to trigger it.  Perhaps just make this:

	if (iomap->type != IOMAP_INLINE || pos)
		iop = iomap_page_create(inode, page);

