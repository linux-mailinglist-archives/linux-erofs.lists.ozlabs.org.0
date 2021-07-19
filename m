Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619683CD8A4
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 17:05:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GT4rw0zZfz30D9
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 01:05:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BYSV7Ndo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=BYSV7Ndo; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GT4rm1KSZz2ylk
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 01:04:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ELJ0z2aDXla8iuVKhbEh0uG66iZXIkBu/r64UbziHV8=; b=BYSV7NdoWNUqr1E4SGKE2LA2nX
 CMURjH+NbrSvI1kKwda4DItB17PJEdXwbrPXPvprFW8SzUZGMzOlHzBUqwK3R0soimpYF/pW6cphG
 3oKs7+0EEnmN16KZ4oa6KJdUmnP2H7XHwC2WUShMu7fQjID2ijfkME8tnBkSY57Z7zKAKD3G8ATUC
 L8xNsVlPCmHPmd8CrIjvbcQpOSWppIN0B6xgCupALXjo/IqXTj1ohVQKamJSB0AqztiO/aULV+UN5
 dZxf8CWXMZcPwWHYiI1Jf+e6bp/fJOFpXUaWLs9zIr0CIcZqCUo+LGXk3yOoMJqWQmWIA+tHf+0jE
 pamPMvPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m5Ums-006xWQ-IK; Mon, 19 Jul 2021 15:03:10 +0000
Date: Mon, 19 Jul 2021 16:02:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWUBhxhoaEp8Frn@casper.infradead.org>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
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

On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> -
> -	/* zero post-eof blocks as the page may be mapped */
>  	iop = iomap_page_create(inode, page);
> +	/* needs to skip some leading uptodated blocks */
>  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>  	if (plen == 0)
>  		goto done;
>  
> +	if (iomap->type == IOMAP_INLINE) {
> +		iomap_read_inline_data(inode, page, iomap, pos);
> +		plen = PAGE_SIZE - poff;
> +		goto done;
> +	}

This is going to break Andreas' case that he just patched to work.
GFS2 needs for there to _not_ be an iop for inline data.  That's
why I said we need to sort out when to create an iop before moving
the IOMAP_INLINE case below the creation of the iop.

If we're not going to do that first, then I recommend leaving the
IOMAP_INLINE case where it is and changing it to ...

	if (iomap->type == IOMAP_INLINE)
		return iomap_read_inline_data(inode, page, iomap, pos);

... and have iomap_read_inline_data() return the number of bytes that
it copied + zeroed (ie PAGE_SIZE - poff).

