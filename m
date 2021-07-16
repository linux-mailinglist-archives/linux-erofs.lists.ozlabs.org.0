Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764023CBA21
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jul 2021 17:53:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GRG4T72Gnz303k
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Jul 2021 01:53:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=qUSqXqr/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d30;
 helo=mail-io1-xd30.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=qUSqXqr/; dkim-atps=neutral
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GRG4L6RHbz2yy3
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jul 2021 01:53:37 +1000 (AEST)
Received: by mail-io1-xd30.google.com with SMTP id l5so11139904iok.7
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jul 2021 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=yShQ0w4qzLoVnuPkOVdukVpyIyk/pCo4eKwDcVHu++E=;
 b=qUSqXqr/51Qsk99OqBkZ1bu50pzl443gJ88idV65QHwFQXDybGkypN5TfGy/Xjt+TF
 SBIpZQdWLPm6SgZjqzzpxr/i9Ndcs+9v/AZlRS6UAHPYv+ny132MYHTKvqppqv1ZGjqj
 LPqRT4IhdeHDwAmetkXvhy3xs2PY30ZwdyZECeeoFi5j/Z6A6i5xilImoZjzqkQQRuZF
 GrmTSmI6II7RXQXzoPoSErEAr/3XgxkkBc495fy0rFxPGToiM2JpKB5ErBHSfZjXl4Q3
 R2Rt0oc9uRqLW0zN7mvL3nSUnzfdsZSOZFWNrK+fHL/CrxvrDvRtgkJCuYTMYOC6N7fT
 P/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=yShQ0w4qzLoVnuPkOVdukVpyIyk/pCo4eKwDcVHu++E=;
 b=UQ+7WeqdHKEe9rw2Po4OZuEGGyI2FyV02Z3ADfcNyH0EH0jqOwALxrgoB+UtfH1hWH
 cMq/kPIti3crtDP8Pajp8kExBRr1+yVbXjQkDuwejJivZEqKqz0+U+KeRWpoCe1a0hyp
 If7uyECNkWonBIjSGx3SewshYeuNx6T0gNQuQT7oRtHA5efE6/VjXqq3IVhASegrnJNL
 bldoKvpmwJ6StetO6I5n4MZCewEQe02gtoIwIljDjEXTElSXOT42C3LUA1WgqbW4/RHK
 /7SGSwK3SwNTegVmHy3hWz0u+XMu5XZnCa5/Ph0NjvX+LFLZ0Gaw/0RG7/bpkeOSQKeT
 ewLw==
X-Gm-Message-State: AOAM533XT05ZDDqrvcHMe2ff3USECjLGZ6WeYpBtvNPgIGGrIS/GPMSD
 w91XKE396308s/tKR+07mqCCaUzfq/SIgMFNDiE=
X-Google-Smtp-Source: ABdhPJxXIP3px6bE903QFzXiDL8FsSzF8D/Z+LKnJqHfKwdULQ3dBLvztnF9spyN0ub8f+zFBc2br/Wp1e0jwWWkBpY=
X-Received: by 2002:a6b:c90f:: with SMTP id z15mr7703884iof.183.1626450810983; 
 Fri, 16 Jul 2021 08:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
In-Reply-To: <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 16 Jul 2021 17:53:19 +0200
Message-ID: <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
To: Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org, 
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Chao Yu <chao@kernel.org>, 
 Liu Bo <bo.liu@linux.alibaba.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Liu Jiang <gerry@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Fr., 16. Juli 2021 um 17:03 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> On Fri, Jul 16, 2021 at 03:44:04PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 16, 2021 at 09:56:23PM +0800, Gao Xiang wrote:
> > > Hi Matthew,
> > >
> > > On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> > > > On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > > > > This tries to add tail packing inline read to iomap. Different from
> > > > > the previous approach, it only marks the block range uptodate in the
> > > > > page it covers.
> > > >
> > > > Why?  This path is called under two circumstances: readahead and readpage.
> > > > In both cases, we're trying to bring the entire page uptodate.  The inline
> > > > extent is always the tail of the file, so we may as well zero the part of
> > > > the page past the end of file and mark the entire page uptodate instead
> > > > and leaving the end of the page !uptodate.
> > > >
> > > > I see the case where, eg, we have the first 2048 bytes of the file
> > > > out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> > > > for the head of the file, but then we may as well finish the entire
> > > > PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> > > > as being uptodate and leave the 3072-4095 block for a future iteration.
> > >
> > > Thanks for your comments. Hmm... If I understand the words above correctly,
> > > what I'd like to do is to cover the inline extents (blocks) only
> > > reported by iomap_begin() rather than handling other (maybe)
> > > logical-not-strictly-relevant areas such as post-EOF (even pages
> > > will be finally entirely uptodated), I think such zeroed area should
> > > be handled by from the point of view of the extent itself
> > >
> > >          if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> > >                  zero_user(page, poff, plen);
> > >                  iomap_set_range_uptodate(page, poff, plen);
> > >                  goto done;
> > >          }
> >
> > That does work.  But we already mapped the page to write to it, and
> > we already have to zero to the end of the block.  Why not zero to
> > the end of the page?  It saves an iteration around the loop, it saves
> > a mapping of the page, and it saves a call to flush_dcache_page().
>
> I completely understand your concern, and that's also (sort of) why I
> left iomap_read_inline_page() to make the old !pos behavior as before.
>
> Anyway, I could update Christoph's patch to behave like what you
> suggested. Will do later since I'm now taking some rest...

Looking forward to that for some testing; Christoph's version was
already looking pretty good.

This code is a bit brittle, hopefully less so with the recent iop
fixes on iomap-for-next.

> > > The benefits I can think out are 1) it makes the logic understand
> > > easier and no special cases just for tail-packing handling 2) it can
> > > be then used for any inline extent cases (I mean e.g. in the middle of
> > > the file) rather than just tail-packing inline blocks although currently
> > > there is a BUG_ON to prevent this but it's easier to extend even further.
> > > 3) it can be used as a part for later partial page uptodate logic in
> > > order to match the legacy buffer_head logic (I remember something if my
> > > memory is not broken about this...)
> >
> > Hopefully the legacy buffer_head logic will go away soon.
>
> Hmmm.. I partially agree on this (I agree buffer_head is a legacy stuff
> but...), considering some big PAGE_SIZE like 64kb or bigger, partial
> uptodate can save I/O for random file read pattern in general (not mmap
> read, yes, also considering readahead, but I received some regression
> due to I/O amplification like this when I was at the previous * 2 company).

Thanks,
Andreas
