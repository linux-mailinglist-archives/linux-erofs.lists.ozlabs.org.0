Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAD61638ED
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 02:03:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MfcW3YmgzDqdM
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 12:03:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=eAZdgCeC; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MfZX4smGzDqdp
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 12:02:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dmgQq76s5htd6QK1djoTrZsBDESqx9Po29KnZ84sMso=; b=eAZdgCeC8YnlA9szfqlWljjWDh
 UQdArvzLM0oiT5XqIC/Q7h5+HeHL9h7cGk8uQK7lBmcw6zYNiJPBANRy3Kwp44uDdtkV2GwprxPbm
 2qK75Ii01IRiWR/ENG9UpNAtQ6GGFmxoDicA6zhQykS1pxRxOwf5Iqo0m6NjHXkdBzku6LESIgg13
 MNO5VqW3ruk/ciL+0+OSHHUM0uvKmDauMYS1h6HQC5+eUgS66IZUqnL5ZBn4iPhOROjAMtOQnLmUp
 r0l8D5tGUQYLIWt9/cYhYmOOb/1dYr6JEJYp93FoEhbgXTOlcGKNkDzg1ltXOO9ME1PREkt7eWceP
 c68pLuUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j4Dkf-0005UF-KW; Wed, 19 Feb 2020 01:02:09 +0000
Date: Tue, 18 Feb 2020 17:02:09 -0800
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 07/19] mm: Put readahead pages in cache earlier
Message-ID: <20200219010209.GI24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-12-willy@infradead.org>
 <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3671faa-dfb3-ceba-3120-a445b2982a95@nvidia.com>
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 18, 2020 at 04:01:43PM -0800, John Hubbard wrote:
> How about this instead? It uses the "for" loop fully and more naturally,
> and is easier to read. And it does the same thing:
> 
> static inline struct page *readahead_page(struct readahead_control *rac)
> {
> 	struct page *page;
> 
> 	if (!rac->_nr_pages)
> 		return NULL;
> 
> 	page = xa_load(&rac->mapping->i_pages, rac->_start);
> 	VM_BUG_ON_PAGE(!PageLocked(page), page);
> 	rac->_batch_count = hpage_nr_pages(page);
> 
> 	return page;
> }
> 
> static inline struct page *readahead_next(struct readahead_control *rac)
> {
> 	rac->_nr_pages -= rac->_batch_count;
> 	rac->_start += rac->_batch_count;
> 
> 	return readahead_page(rac);
> }
> 
> #define readahead_for_each(rac, page)			\
> 	for (page = readahead_page(rac); page != NULL;	\
> 	     page = readahead_page(rac))

I'm assuming you mean 'page = readahead_next(rac)' on that second line.

If you keep reading all the way to the penultimate patch, it won't work
for iomap ... at least not in the same way.

