Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA0B7E7E09
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 18:10:01 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ng7dBymG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRlgW339Hz3cVl
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Nov 2023 04:09:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRlgH23VTz3cBs
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Nov 2023 04:09:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5iIz9LZtzoUA/MUQ6eEhfr6QsbZtT819GM3S7MYEDJM=; b=Ng7dBymG5jMgVsYPsLxyRKew+b
	lU2Xqfa14/vmIzf1LtQxbPXQJO/ngwL7OrxcDp9FV+g6fX+UdG4xcw42fKX6QsFwuCD61MO8rFHUr
	rHsGmhB15MpQEZsO4qmTJar3Ln7u++at4FUy4n1HeSr13wq+2cTCC/zhRDIhiylXVpv/FeOs5nNJN
	V5wPt/4lnoEVBrC4nRKHfmPpArlqc2AaYXpy6ogF/HN6y71eoGj77eift0Hx1YftuJkgDqXkbSj+5
	rs8Er3hQETONDuKWwrCiHT1DcR/qnjxz5xn5zS/BDdA3/AgaFqMl1wa3Xw2mjDTOf6IAdPg3UmjpB
	YKculXXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1V0Z-00EaZj-3C; Fri, 10 Nov 2023 17:09:27 +0000
Date: Fri, 10 Nov 2023 17:09:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
Message-ID: <ZU5jx2QeujE+868t@casper.infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
> On Tue, Nov 7, 2023 at 10:27 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > +static inline void folio_fill_tail(struct folio *folio, size_t offset,
> > +               const char *from, size_t len)
> > +{
> > +       char *to = kmap_local_folio(folio, offset);
> > +
> > +       VM_BUG_ON(offset + len > folio_size(folio));
> > +
> > +       if (folio_test_highmem(folio)) {
> > +               size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +               while (len > max) {
> > +                       memcpy(to, from, max);
> > +                       kunmap_local(to);
> > +                       len -= max;
> > +                       from += max;
> > +                       offset += max;
> > +                       max = PAGE_SIZE;
> > +                       to = kmap_local_folio(folio, offset);
> > +               }
> > +       }
> > +
> > +       memcpy(to, from, len);
> > +       to = folio_zero_tail(folio, offset, to);
> 
> This needs to be:
> 
> to = folio_zero_tail(folio, offset  + len, to + len);

Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
which doesn't exercise this code, not gfs2 or erofs.  Thanks for
fixing this up.

I was wondering about adding the assertion:

	VM_BUG_ON((kaddr - offset) % PAGE_SIZE);

to catch the possible mistake of calling kmap_local_folio(folio, 0)
instead of kmap_local_folio(folio, offset).  But maybe that's
sufficiently unlikely a mistake to bother adding a runtime check for.
