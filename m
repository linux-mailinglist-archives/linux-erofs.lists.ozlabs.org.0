Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA818D63E
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2020 18:51:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kWXj3FRZzF0X5
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2020 04:51:01 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=h1Kzauch; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kWVM2r0LzDrff
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2020 04:48:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=REJDSQBSjlxGvUa9yFvVpoZkbE4uGtyMxtUffkDr/yg=; b=h1KzauchMVn1GcHidDQlLm4NDv
 aK4kqaKyat0c5S0apNaFmVi2M8lBpKqc6HcaPGEx+FFNw4NjYR32w5n0WAiLlaQiNyEfedB+7qoTL
 E/THmbYmMV4oouS6HA97h/6mPTqu5anVComDHxmPW4cHFSSyakaX+gQtXZhMNNfMHvVSjwaoJ0h2L
 OUdg+DUV4zfIM1jYNB9gSyndXuMPQpPpoePO6Xnc1zLjP/inzuV8mvsbNGEKjizrXkCo/5ONaqRd7
 SqjRvCtsua+M1JEUo9eCXIRJNJsizFMS59zha5v/io1cPAKUeptHjpuXzj4A/3UtnQK12YL/XylLS
 RApjCAiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jFLlI-0000w5-Ps; Fri, 20 Mar 2020 17:48:48 +0000
Date: Fri, 20 Mar 2020 10:48:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v9 20/25] ext4: Convert from readpages to readahead
Message-ID: <20200320174848.GC4971@bombadil.infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-21-willy@infradead.org>
 <20200320173734.GD851@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320173734.GD851@sol.localdomain>
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 10:37:34AM -0700, Eric Biggers wrote:
> On Fri, Mar 20, 2020 at 07:22:26AM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Use the new readahead operation in ext4
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > ---
> >  fs/ext4/ext4.h     |  3 +--
> >  fs/ext4/inode.c    | 21 +++++++++------------
> >  fs/ext4/readpage.c | 22 ++++++++--------------
> >  3 files changed, 18 insertions(+), 28 deletions(-)
> > 
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> > +		if (rac) {
> > +			page = readahead_page(rac);
> >  			prefetchw(&page->flags);
> > -			list_del(&page->lru);
> > -			if (add_to_page_cache_lru(page, mapping, page->index,
> > -				  readahead_gfp_mask(mapping)))
> > -				goto next_page;
> >  		}
> 
> Maybe the prefetchw(&page->flags) should be included in readahead_page()?
> Most of the callers do it.

I did notice that a lot of callers do that.  I wonder whether it (still)
helps or whether it's just cargo-cult programming.  It can't possibly
have helped before because we did list_del(&page->lru) as the very next
instruction after prefetchw(), and they're in the same cacheline.  It'd
be interesting to take it out and see what happens to performance.
