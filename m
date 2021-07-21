Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7AF3D08F3
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 08:33:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GV5QF4PCsz308Q
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 16:33:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=tQ8qIzLK;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22b;
 helo=mail-lj1-x22b.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tQ8qIzLK; dkim-atps=neutral
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GV5Q72gFpz2xb8
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 16:33:50 +1000 (AEST)
Received: by mail-lj1-x22b.google.com with SMTP id b16so322515ljq.9
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vgZ3yjomTzlMCFEBY2QOLzdcWRgyC4eVhW9WC+FWjOI=;
 b=tQ8qIzLK6bqfVALG6GEQIfaZ1m2r/Tt4OX9AAorqyfmfoAwESt4rRHHYH0nAgWXreX
 E2KEoOx7x+Rhh2FpIqFlWiShWxY4PF6BxxXHhR9FWt5NADi5LtM0j7RSYef6HUAWrQ0A
 yAUdS0e4zRfrVDi97stCd4s35iRLaQriRr4i6hBE3DRw0TTgVFYLqnitHUsAIgjpJo6d
 aYobLw59ffWcESJoaSaBgyc7RfHLWj11PRqyhEXU/trsyv9lY2wSEzmPraBWS65tsnAR
 V9L+Ayhxlw/BOSY1QCg5YVU4EQKvYx8vtXYW0PiySFH21XLCgRlI/6hDVYtOS1uB8NyO
 KktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vgZ3yjomTzlMCFEBY2QOLzdcWRgyC4eVhW9WC+FWjOI=;
 b=FIBE9Bb/shoGxIhhDotNJmb579ph3DM3vmebHlBhtNsi05ix2ogAu6TOairvWgGB5+
 FTB8s2zDT74AP21IEeeO+emGUbgYYaa1DeBG6sWkT6FHsxOni8JVyGtOJw14i1zFleNA
 845f0Atv5ECbdW89IcwxQ51DwQEmuzfCIUWhotKeKPvyyLh6ovOk4c8Y5WKbU/XLJKeq
 wEy4tGtvInZ/NyqWO3pVgRIj/qzKRVy2HDEIow7xs0DVxx9Qy5xeHnuJGFgqbKIOyctN
 +CsSQL92ntlkMReuCsVi0OIklVCo5ygRp6r6QRmCklwaVaxY+jFLz+9DIhloDKFOJ0nQ
 HNTQ==
X-Gm-Message-State: AOAM531QKHx1BEJPdMVnzs36O3zM+XaK+BjTJD+FeF0x6+CUrWQvJWLe
 kOMcA6o4F+qJ4oB5bVO5/SltHUyOztlaOamdaMs=
X-Google-Smtp-Source: ABdhPJy8FqL1N/64ODDDPq+8rZqX7KUcnsar0gsoAGKviKNVxsjmkj4HPXdXyveyZFbgQ4idXyq8IYk94UXyBJ7iC28=
X-Received: by 2002:a2e:a5c6:: with SMTP id n6mr29681111ljp.204.1626849222792; 
 Tue, 20 Jul 2021 23:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
In-Reply-To: <YPc9viRAKm6cf2Ey@casper.infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 21 Jul 2021 08:33:30 +0200
Message-ID: <CAHpGcMJ-E5LYz1E7Qf9=LQES=jB0V-Pjq1rSg=7GxXwJ1mh2Gw@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Di., 20. Juli 2021 um 23:19 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> On Tue, Jul 20, 2021 at 01:42:24PM -0700, Darrick J. Wong wrote:
> > > -   BUG_ON(page_has_private(page));
> > > -   BUG_ON(page->index);
> > > -   BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +   /* inline source data must be inside a single page */
> > > +   BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> >
> > Can we reduce the strength of these checks to a warning and an -EIO
> > return?

Yes, we could do that.

> I'm not entirely sure that we need this check, tbh.

I wanted to make sure the memcpy / memset won't corrupt random kernel
memory when the filesystem gets the iomap_begin wrong.

> > > +   /* handle tail-packing blocks cross the current page into the next */
> > > +   size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > > +                PAGE_SIZE - poff);
> > >
> > >     addr = kmap_atomic(page);
> > > -   memcpy(addr, iomap->inline_data, size);
> > > -   memset(addr + size, 0, PAGE_SIZE - size);
> > > +   memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > > +   memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> >
> > Hmm, so I guess the point of this is to support reading data from a
> > tail-packing block, where each file gets some arbitrary byte range
> > within the tp-block, and the range isn't aligned to an fs block?  Hence
> > you have to use the inline data code to read the relevant bytes and copy
> > them into the pagecache?
>
> I think there are two distinct cases for IOMAP_INLINE.  One is
> where the tail of the file is literally embedded into the inode.
> Like ext4 fast symbolic links.  Taking the ext4 i_blocks layout
> as an example, you could have a 4kB block stored in i_block[0]
> and then store bytes 4096-4151 in i_block[1-14] (although reading
> https://www.kernel.org/doc/html/latest/filesystems/ext4/dynamic.html
> makes me think that ext4 only supports storing 0-59 in the i_blocks;
> it doesn't support 0-4095 in i_block[0] and then 4096-4151 in i_blocks)
>
> The other is what I think erofs is doing where, for example, you'd
> specify in i_block[1] the block which contains the tail and then in
> i_block[2] what offset of the block the tail starts at.

Andreas
