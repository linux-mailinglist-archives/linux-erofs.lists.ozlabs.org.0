Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E014975C
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Jan 2020 20:10:11 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 484lvM68z0zDqSG
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Jan 2020 06:10:07 +1100 (AEDT)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=fFmYgDNN; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 484lv94NbrzDqRw
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Jan 2020 06:09:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=My5//NJQysYMT+Wea8KLUdQ/Ww11h9Uv4t+v7jFecDU=; b=fFmYgDNNvt77kQV4xKWYDlosj
 tCRnFy39irUUteCkoPzUlBM/Wm5FkejDjX1gLGOh1AOSU9xWtasFCl6Yk4gnJp6YHhDtEnfffUKLF
 EBp2IlTESitbhAv7sRphU+1LFGbjMg61Nw3xVl/bb+yYBk+izXwb/6w33+zt3U0xxf/W/ggVQJ07u
 C+r9ejvmR76/vpb7qv/B3UnJlBSOjzyCBm6eBaw8FGfOYR0uAYkhizpzn61a5zTykX2GN2qAM6O8x
 MUsWC+f6ZstKPT6dK6hp2fpwysNavccb6La+1kyQ4NeJT5uZiEB2XGltOcYtJtuxj3lzmJR+FTww1
 4eL0GLFtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ivQoZ-00036i-67; Sat, 25 Jan 2020 19:09:51 +0000
Date: Sat, 25 Jan 2020 11:09:51 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200125190951.GN4675@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
 <20200125015323.GA9918@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125015323.GA9918@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Jan 25, 2020 at 09:53:29AM +0800, Gao Xiang wrote:
> > +		/* all the page errors are ignored when readahead */
> > +		if (IS_ERR(bio)) {
> > +			pr_err("%s, readahead error at page %lu of nid %llu\n",
> > +			       __func__, page->index,
> > +			       EROFS_I(mapping->host)->nid);
> >  
> > -				bio = NULL;
> > -			}
> > +			bio = NULL;
> > +			put_page(page);
> 
> Out of curiously, some little question... Why we need put_page(page) twice
> if erofs_read_raw_page returns with error...
> 
> One put_page(page) is used as a temporary reference count for this request,
> we could put_page(page) in advance since pages are still locked before endio.
> 
> Another put_page(page) is used for page cache xarray. I think in this case
> the page has been successfully inserted to the page cache anyway, after erroring
> out it will trigger .readpage again... so probably we need to keep this
> refcount count for page cache xarray?
> 
> If I'm missing something, kindly correct me if I'm wrong....

You're quite right.  After readahead has completed, the page should have
a refcount of 1 and be unlocked.  If we hit an error, the page should
be !uptodate.  It doesn't matter whether we set PageError or not in this
case; filemap_fault() will ClearPageError() before retrying if the page
is !uptodate.  This extra put_page() is wrong, and I'll remove it from
the next version.  Thanks!
