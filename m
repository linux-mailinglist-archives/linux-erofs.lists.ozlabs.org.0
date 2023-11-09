Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFA7E706D
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 18:38:03 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LTik8qcE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SR8LJ6V1Vz3cJW
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 04:38:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LTik8qcE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SR8L81SZDz3c01
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 04:37:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/zf0lTxBuvebjd5FmP2bSMJ+hk6qswmHlp1nwkj6kdY=; b=LTik8qcEySCdMDCuz34d3k9ufZ
	tIgcA/qhbd4WYY5aZm5G/BJ2NEhNKKXaDkYnnyUJAuigl/iM5tH7dRWI1ba0FvgpOqW7c+UKRpfQO
	RAvQnxfo8z2qPObIHJq1IJUTFhywlpF+wEQWWVRfnLbA9X5PZ5R4vGG5iuNEzgl7f+vo12OLuGXhO
	pe5VQDHRK0lqSD/ljuVimzlylfGVsSxVegB1RP+IXwbzxtIF3T+hEZfu9w1iPpvBgX/zKeVbg2U0w
	3vP9mNvXcffxVjBoGzc7OKfxYwn6qUASlkThQRGRrWJ66Pbuyc7n5VoIx/fr++kivBB8bQPN2Cpqp
	mkWfeIrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r18y9-008YXP-0x; Thu, 09 Nov 2023 17:37:29 +0000
Date: Thu, 9 Nov 2023 17:37:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Message-ID: <ZU0Y2NEMMlkHYcr6@casper.infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
 <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Nov 08, 2023 at 03:06:06PM -0800, Andrew Morton wrote:
> >  
> > +/**
> > + * folio_zero_tail - Zero the tail of a folio.
> > + * @folio: The folio to zero.
> > + * @kaddr: The address the folio is currently mapped to.
> > + * @offset: The byte offset in the folio to start zeroing at.
> 
> That's the argument ordering I would expect.
> 
> > + * If you have already used kmap_local_folio() to map a folio, written
> > + * some data to it and now need to zero the end of the folio (and flush
> > + * the dcache), you can use this function.  If you do not have the
> > + * folio kmapped (eg the folio has been partially populated by DMA),
> > + * use folio_zero_range() or folio_zero_segment() instead.
> > + *
> > + * Return: An address which can be passed to kunmap_local().
> > + */
> > +static inline __must_check void *folio_zero_tail(struct folio *folio,
> > +		size_t offset, void *kaddr)
> 
> While that is not.  addr,len is far more common that len,addr?

But that's not len!  That's offset-in-the-folio.  ie we're doing:

memset(folio_address(folio) + offset, 0, folio_size(folio) - offset);

If we were doing:

memset(folio_address(folio), 0, len);

then yes, your suggestion is the right order.

Indeed, having the arguments in the current order would hopefully make
filesystem authors realise that this _isn't_ "len".
