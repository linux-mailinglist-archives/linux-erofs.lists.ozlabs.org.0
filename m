Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 594903CDC11
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 17:32:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GT5SF21nYz30GR
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 01:32:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=LzM/vCCP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d30;
 helo=mail-io1-xd30.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LzM/vCCP; dkim-atps=neutral
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GT5S90gyLz2yhf
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 01:32:08 +1000 (AEST)
Received: by mail-io1-xd30.google.com with SMTP id z9so20365394iob.8
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jul 2021 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=zCoPhFkD+zAaGzAd+PDtfOcHPP03UMo9Xh9adgd6gSw=;
 b=LzM/vCCPOOvtsTmJDetXjpPpvCkinoXeAZ56eEnBCJqG7Q6+GBs8iuAKY9jKLcK0oV
 K7SjG+5D0f9b+1gfCJSbnjQu9CtDrlsz35hOlrFghqwFAtxYJq1ng61rlyWX2fHu/cNM
 VHVnDZxqbdakaU4zDmHkYu9dV0HmrNi6cTsLTLE733AvOKrMgHW4F8WnPmWifumV5xUY
 vIJqd2ehiO2jK6gssfh5UpzMM8Bcu5BAW1ZEAmQLpNEYZO5VWe27NRwuBz/r65O4k1LK
 oUw9eSnyjYr6w7oRovn4n43hMK9syu0t9PMhCl3DGMiw4P7mrumvkdhc9jWJLI9co2Uw
 zKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=zCoPhFkD+zAaGzAd+PDtfOcHPP03UMo9Xh9adgd6gSw=;
 b=deAeWvt5J2Vzrq4yoFMYAtS7Nz+UHoPQMdFsT7mgejbMSf/+X0rd7huO31rgNXkSc8
 P2Hy7YXZgIgZUmJ8tMBIN0DkZLzzdi25wQ6h7yyesVfqtAs1Fnd+T0jbtUctU9W7tBYY
 zrGP2ZlhG2XtbXDfNnzBWiIRSL4v+7cBbJAwx7neYDbEzEQZB7cNcxrYhbEcfOF81Cx5
 8/orFS1iAqYei/X5uNAuGX8Q9w1rWcEbEhIwViJdKRbiifYJThFu03Z0pU90vIVTLgQ9
 RFzSCyzin5qq58Uf1xQaBVN4nrKOVmwD+Mpwc6UV4aKX7sMF3XY30MU7Kl5CIivaQCb3
 XWxQ==
X-Gm-Message-State: AOAM532OdMpfkkaZin8ZzvLhjJKYCFbCKcbkXCHd1/LXhHUJ0V2A78mL
 8Seluw9Lmb525Pz5PPeRDp93wNKOCCEe1gkzP/g=
X-Google-Smtp-Source: ABdhPJx1VgtuccRfyVyDs5ZIB0RONKxf+mW64rOLbDsAn5cVTSrT1Z9UhRQSuO9JQnSZV+BXxuzpY510s3RjGEolVRw=
X-Received: by 2002:a5d:928f:: with SMTP id s15mr19005278iom.142.1626708724777; 
 Mon, 19 Jul 2021 08:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
 <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
In-Reply-To: <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Mon, 19 Jul 2021 17:31:51 +0200
Message-ID: <CAHpGcM+V+_AxTBwp_eq6R3osH0CMA5N-o8bzBKW3uMsBZY6KWA@mail.gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
To: Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org, 
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <djwong@kernel.org>, 
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
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

Am Mo., 19. Juli 2021 um 17:29 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> > > @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >     unsigned poff, plen;
> > >     sector_t sector;
> > >
> > > -   if (iomap->type == IOMAP_INLINE) {
> > > -           WARN_ON_ONCE(pos);
> > > -           iomap_read_inline_data(inode, page, iomap);
> > > -           return PAGE_SIZE;
> > > -   }
> > > -
> > > -   /* zero post-eof blocks as the page may be mapped */
> > >     iop = iomap_page_create(inode, page);
> > > +   /* needs to skip some leading uptodated blocks */
> > >     iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > >     if (plen == 0)
> > >             goto done;
> > >
> > > +   if (iomap->type == IOMAP_INLINE) {
> > > +           iomap_read_inline_data(inode, page, iomap, pos);
> > > +           plen = PAGE_SIZE - poff;
> > > +           goto done;
> > > +   }
> >
> > This is going to break Andreas' case that he just patched to work.
> > GFS2 needs for there to _not_ be an iop for inline data.  That's
> > why I said we need to sort out when to create an iop before moving
> > the IOMAP_INLINE case below the creation of the iop.
>
> I have no idea how it breaks Andreas' case from the previous commit
> message: "
> iomap: Don't create iomap_page objects for inline files
> In iomap_readpage_actor, don't create iop objects for inline inodes.
> Otherwise, iomap_read_inline_data will set PageUptodate without setting
> iop->uptodate, and iomap_page_release will eventually complain.
>
> To prevent this kind of bug from occurring in the future, make sure the
> page doesn't have private data attached in iomap_read_inline_data.
> "
>
> After this patch, iomap_read_inline_data() will set iop->uptodate with
> iomap_set_range_uptodate() rather than set PageUptodate() directly,
> so iomap_page_release won't complain.

Yes, that actually looks fine.

Thanks,
Andreas
