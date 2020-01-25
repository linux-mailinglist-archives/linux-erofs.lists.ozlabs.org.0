Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878D14978A
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 20:44:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484mgX2VxHzDqS2
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2020 06:44:56 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=iukevvX9; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484mgS0PSlzDqML
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2020 06:44:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ZMGv3oBke4qgEgEWLJ/O03PCwZbetUWl8MszuyJc3E=; b=iukevvX9wHFfu3JIg1tr6gVc/
 JwJE61o+VY7KxTDz9InYcyVcbamX1y02guAD3rWE2GMFBd6m2M560rZ9H3IdzZ7mREF8HfqjNOxF7
 HlJjW/HzTAr+MQDnqg4+ap4KCIzzg0CvE0iBtGvOYLNOiEVgKse1AFNaAcpAnsLdvzyQ+tS0PerbZ
 t5ty0p/lHmff1/2YUFwEYdYp9wzoQkDc38nEKsZ+jm2E8oJgAiMXjCButFfqjsPdn0CHgtX1TFbzu
 4tuijwgd1IjFP1Dl0+zEUez39wsvlMoBZL+xtptLXo4jcPUPXyt9UU4IzOBc+Dq2WViHshRY6wYB0
 R5QNBIB6A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ivRMP-0004OA-SC; Sat, 25 Jan 2020 19:44:49 +0000
Date: Sat, 25 Jan 2020 11:44:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/12] readahead: Put pages in cache earlier
Message-ID: <20200125194449.GO4675@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-4-willy@infradead.org>
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jan 24, 2020 at 05:35:44PM -0800, Matthew Wilcox wrote:
> @@ -192,8 +194,18 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = page_offset;
> -		list_add(&page->lru, &page_pool);
> +		if (use_list) {
> +			page->index = page_offset;
> +			list_add(&page->lru, &page_pool);
> +		} else if (!add_to_page_cache_lru(page, mapping, page_offset,
> +					gfp_mask)) {
> +			if (nr_pages)
> +				read_pages(mapping, filp, &page_pool,
> +						page_offset - nr_pages,
> +						nr_pages);
> +			nr_pages = 0;

This is missing a call to put_page().

> +			continue;
> +		}
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		nr_pages++;
