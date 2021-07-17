Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FEB3CC3F2
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 17:03:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRrvY3Svhz2yxT
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Jul 2021 01:03:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=RyqOFqwm;
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRrtv09tPz2yNb
 for <linux-erofs@lists.ozlabs.org>; Sun, 18 Jul 2021 01:02:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7Xw1VcuTjgZ49t25zIRxicvryRU564jX2lY4pUY5o3A=; b=RyqOFqwmgDZXOtufkLpg6oCwEA
 juLFgW5sohegVkvt2PoNEwetF9INUp/TQwEtIfRYrlmd857WmaWVYc/IvC4oU+AGgmehR1Ggw3FPX
 nnU6+802ktykPsc9EROMcYW2QcUASskCnC+CDixXS6EPaGr6N+81kHUzTMRoPbAXNSk2FJtQY5vdA
 Qz1Ld4JR5SDFJFqKSyutbJYAhNP0sfjdT3Jyo6vM0jkv+WSGOjPg/xz3hk3X80TWCVjE+13HzSmFX
 35qCT05yvpyQP8eLxR9prjIxoAxDWrf7h0mgtqdWrBvhMZ+Ant9h/e4UHRg7gmD8ZgcIk4iOVmjSU
 e4dvHlRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m4low-005LrJ-Da; Sat, 17 Jul 2021 15:01:49 +0000
Date: Sat, 17 Jul 2021 16:01:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPLw0uc1jVKI8uKo@casper.infradead.org>
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
> Sorry about some late. I've revised a version based on Christoph's
> version and Matthew's thought above. I've preliminary checked with
> EROFS, if it does make sense, please kindly help check on the gfs2
> side as well..

I don't understand how this bit works:

>  	struct page *page = ctx->cur_page;
> -	struct iomap_page *iop;
> +	struct iomap_page *iop = NULL;
>  	bool same_page = false, is_contig = false;
>  	loff_t orig_pos = pos;
>  	unsigned poff, plen;
>  	sector_t sector;
>  
> -	if (iomap->type == IOMAP_INLINE) {
> -		WARN_ON_ONCE(pos);
> -		iomap_read_inline_data(inode, page, iomap);
> -		return PAGE_SIZE;
> -	}
> +	if (iomap->type == IOMAP_INLINE && !pos)
> +		WARN_ON_ONCE(to_iomap_page(page) != NULL);
> +	else
> +		iop = iomap_page_create(inode, page);

Imagine you have a file with bytes 0-2047 in an extent which is !INLINE
and bytes 2048-2051 in the INLINE extent.  When you read the page, first
you create an iop for the !INLINE extent.  Then this function is called
again for the INLINE extent and you'll hit the WARN_ON_ONCE.  No?

