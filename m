Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F03D3C26
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jul 2021 17:05:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GWXh32wCyz30DN
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Jul 2021 01:05:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ryUceu+c;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=ryUceu+c; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GWXgw383qz2yX0
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Jul 2021 01:05:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TH+UO+4GlVJPwsICtqlb2GDVZ2D9S2sacJqluLD1cbU=; b=ryUceu+cYHelVxJMnHQDMyfPmq
 1CmyM/LHAHkQgUx4cO8EdjLvKifP61OBPlPyUgIcxSaTkiH+a4dktu+nR+Gs+zi1cyNxG2Yd46ojm
 KxL0i0AytbtSWTbmcpgpLAgCZKlIxwEIKAn6SRJrpA0ZkVBZTAaybsgiyKcmtqYMkV3R2cEOAMa8I
 b9W8adfTMvE8RA61u57/ieX9FkjfJ1LgFRBAdezhXjx8d3AvAMQRJhAkIK1/urYh/4UGodi0SAHjZ
 p/d6loPEz9qZZq7hJPbgZ4M/XQVjZLZs+zMZA2gXsxalO2C5fU/1Q/npBzRRu0DGpsfadyaxZ7dhm
 TbWYshoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m6wjx-00BSns-9o; Fri, 23 Jul 2021 15:05:32 +0000
Date: Fri, 23 Jul 2021 16:05:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6] iomap: support tail packing inline read
Message-ID: <YPrauRjG7+vCw7f9@casper.infradead.org>
References: <20210722031729.51628-1-hsiangkao@linux.alibaba.com>
 <20210722053947.GA28594@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722053947.GA28594@lst.de>
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
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 22, 2021 at 07:39:47AM +0200, Christoph Hellwig wrote:
> @@ -675,7 +676,7 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>  
>  	flush_dcache_page(page);
>  	addr = kmap_atomic(page);
> -	memcpy(iomap->inline_data + pos, addr + pos, copied);
> +	memcpy(iomap_inline_buf(iomap, pos), addr + pos, copied);

This is wrong; pos can be > PAGE_SIZE, so this needs to be
addr + offset_in_page(pos).

