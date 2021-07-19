Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B23CDD21
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jul 2021 17:37:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GT5Yr6hXBz30Fc
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 01:37:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GT5Yn1wh0z306h
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 01:37:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UgItzbm_1626709003; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UgItzbm_1626709003) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 19 Jul 2021 23:36:45 +0800
Date: Mon, 19 Jul 2021 23:36:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWcC0HYu1ICo3dc@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?=
 <andreas.gruenbacher@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 "Darrick J . Wong" <djwong@kernel.org>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
 <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
 <CAHpGcM+V+_AxTBwp_eq6R3osH0CMA5N-o8bzBKW3uMsBZY6KWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+V+_AxTBwp_eq6R3osH0CMA5N-o8bzBKW3uMsBZY6KWA@mail.gmail.com>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 19, 2021 at 05:31:51PM +0200, Andreas Grünbacher wrote:
> Am Mo., 19. Juli 2021 um 17:29 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> > > > @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > > >     unsigned poff, plen;
> > > >     sector_t sector;
> > > >
> > > > -   if (iomap->type == IOMAP_INLINE) {
> > > > -           WARN_ON_ONCE(pos);
> > > > -           iomap_read_inline_data(inode, page, iomap);
> > > > -           return PAGE_SIZE;
> > > > -   }
> > > > -
> > > > -   /* zero post-eof blocks as the page may be mapped */
> > > >     iop = iomap_page_create(inode, page);
> > > > +   /* needs to skip some leading uptodated blocks */
> > > >     iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > > >     if (plen == 0)
> > > >             goto done;
> > > >
> > > > +   if (iomap->type == IOMAP_INLINE) {
> > > > +           iomap_read_inline_data(inode, page, iomap, pos);
> > > > +           plen = PAGE_SIZE - poff;
> > > > +           goto done;
> > > > +   }
> > >
> > > This is going to break Andreas' case that he just patched to work.
> > > GFS2 needs for there to _not_ be an iop for inline data.  That's
> > > why I said we need to sort out when to create an iop before moving
> > > the IOMAP_INLINE case below the creation of the iop.
> >
> > I have no idea how it breaks Andreas' case from the previous commit
> > message: "
> > iomap: Don't create iomap_page objects for inline files
> > In iomap_readpage_actor, don't create iop objects for inline inodes.
> > Otherwise, iomap_read_inline_data will set PageUptodate without setting
> > iop->uptodate, and iomap_page_release will eventually complain.
> >
> > To prevent this kind of bug from occurring in the future, make sure the
> > page doesn't have private data attached in iomap_read_inline_data.
> > "
> >
> > After this patch, iomap_read_inline_data() will set iop->uptodate with
> > iomap_set_range_uptodate() rather than set PageUptodate() directly,
> > so iomap_page_release won't complain.
> 
> Yes, that actually looks fine.

Yeah, although I admit it looks (maybe) somewhat sub-optimal, but I think
let's make it work correctly first. Then consider how to optimize it even
further (like drop iops or likewise...).

Just my humble suggestion of this from heart....

Thanks,
Gao Xiang

> 
> Thanks,
> Andreas
