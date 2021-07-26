Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2ED3D59A0
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 14:34:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYK9P3qrdz307C
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 22:34:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Vlj0nRZF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYK9D1NKBz3062
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 22:33:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YFWxpaZqxwm3Uisf1S7eCNCfuP9P6MiIsZcWVQjD5es=; b=Vlj0nRZFoBgGJTCAFYX0pf7n2P
 W8mf3X1EyUXZhAE5Y8PIPqS4MMsbASu7L47QPuwZmMpS0WTL8AoJlDHGvnMtd6i++65JesPWjxMTi
 W9RehTFzP2FLZxioPe7wc+H8kWbGybSMYUUzdN6sSdWjLjpcUmmmaoIbaFk9AfR395/V19O7o7UF4
 9BrUdDQJCqpEuqL59qyfSihmj+6/RxDu49yyWb9poGx6HYoDNIOh8GABKQM0lm80UZZlACMYHwC1y
 W5Pc2AFdMeGGOfVKsxpS4B+xYEyMYAC1asGQ1YCWieY9c7m+oDeNmLxypOpYZGcaLnxE/Eh0GBAsB
 dCpNlshQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m7zmI-00Dwuk-Lo; Mon, 26 Jul 2021 12:32:34 +0000
Date: Mon, 26 Jul 2021 13:32:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP6rTi/I3Vd+pbeT@casper.infradead.org>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726110611.459173-1-agruenba@redhat.com>
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
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 01:06:11PM +0200, Andreas Gruenbacher wrote:
> @@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  	void *addr;
>  
>  	WARN_ON_ONCE(!PageUptodate(page));
> -	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	BUG_ON(!iomap_inline_data_size_valid(iomap));
>  
>  	flush_dcache_page(page);
>  	addr = kmap_atomic(page);
> -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> +	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
>  	kunmap_atomic(addr);
>  
>  	mark_inode_dirty(inode);

Only tangentially related ... why do we memcpy the data into the tail
at write_end() time instead of at writepage() time?  I see there's a
workaround for that in gfs2's page_mkwrite():

        if (gfs2_is_stuffed(ip)) {
                err = gfs2_unstuff_dinode(ip);

(an mmap store cannot change the size of the file, so this would be
unnecessary)

Something like this ...

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..3aeebe899fc5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -665,9 +665,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, size_t copied)
+static int iomap_write_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
 {
+	size_t size = i_size_read(inode) - page_offset(page);
 	void *addr;
 
 	WARN_ON_ONCE(!PageUptodate(page));
@@ -675,11 +676,10 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 
 	flush_dcache_page(page);
 	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	memcpy(iomap->inline_data, addr, size);
 	kunmap_atomic(addr);
 
-	mark_inode_dirty(inode);
-	return copied;
+	return 0;
 }
 
 /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
@@ -691,9 +691,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	loff_t old_size = inode->i_size;
 	size_t ret;
 
-	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
@@ -1314,6 +1312,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
+	if (wpc->iomap.type == IOMAP_INLINE)
+		return iomap_write_inline_data(inode, page, iomap);
+
 	/*
 	 * Walk through the page to find areas to write back. If we run off the
 	 * end of the current map or find the current map invalid, grab a new
@@ -1328,8 +1329,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		error = wpc->ops->map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
 		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
