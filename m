Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F83DA350
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 14:44:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gb9G64Nfdz3cHY
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 22:44:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=RfbLkQxt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=RfbLkQxt; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gb9Fz4MSZz2xy3
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jul 2021 22:44:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oXjfFtKgZLjjaAkzD2PYOYGbcbwNVkJ85WUcW9/1HD4=; b=RfbLkQxt9bCyHjwLuYtsMauUSs
 C+CniNsToHGBjSsNwlyhNVDil642ogszADSQfSv4ZvwBevCwcYKh7k6UlMg9YVq818h0Zwzx8YaFv
 Rv/sElD/Q/kvgtA1SX8WczlfQg2HmYinoL3vfM/WOWEFDpccPoN6cTqbDgz6Z8Kk8CHrA69DZ+bfm
 WbBh0S+WDzdv3Jd2EiIwuEjeCwEQOMiec+8NdM7Vz0gISeOZfF0d8woDoTefJmzdla5oBOU/ZW+e5
 inGzfg3Af+ODmxTk78F0DwU5cxoiAfb9Cvr5UNVhZKzAELQiGBrmTAeAlTsYmSm7oiW63g/z5EhaV
 quV2JE6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m95Ny-00H3ig-G4; Thu, 29 Jul 2021 12:43:47 +0000
Date: Thu, 29 Jul 2021 13:43:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v2] iomap: Support inline data with block size < page size
Message-ID: <YQKiekbn8wbKklzU@casper.infradead.org>
References: <20210729032344.3975412-1-willy@infradead.org>
 <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 29, 2021 at 05:54:56AM +0200, Andreas Gruenbacher wrote:
> > -       /* inline data must start page aligned in the file */
> > -       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > -               return -EIO;
> 
> Maybe add a WARN_ON_ONCE(size > PAGE_SIZE - poff) here?

Sure!

> >         if (WARN_ON_ONCE(size > PAGE_SIZE -
> >                          offset_in_page(iomap->inline_data)))
> >                 return -EIO;
> >         if (WARN_ON_ONCE(size > iomap->length))
> >                 return -EIO;
> > -       if (WARN_ON_ONCE(page_has_private(page)))
> > -               return -EIO;
> > +       if (poff > 0)
> > +               iomap_page_create(inode, page);
> >
> > -       addr = kmap_atomic(page);
> > +       addr = kmap_atomic(page) + poff;
> 
> Maybe kmap_local_page?

Heh, I do that later when I convert to folios (there is no
kmap_atomic_folio(), only kmap_local_folio()).  But I can throw that
in here too.

