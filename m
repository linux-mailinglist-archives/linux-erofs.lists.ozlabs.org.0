Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE83D5A31
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 15:18:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYL8k6tSlz307L
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 23:18:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYL8d0pDkz3069
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 23:18:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0Uh2wVP4_1627305165; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uh2wVP4_1627305165) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 26 Jul 2021 21:12:46 +0800
Date: Mon, 26 Jul 2021 21:12:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP60zLP13Hqi5iL+@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas Gruenbacher <agruenba@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <YP6rTi/I3Vd+pbeT@casper.infradead.org>
 <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 03:03:14PM +0200, Andreas Gruenbacher wrote:
> On Mon, Jul 26, 2021 at 2:33 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Jul 26, 2021 at 01:06:11PM +0200, Andreas Gruenbacher wrote:
> > > @@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> > >       void *addr;
> > >
> > >       WARN_ON_ONCE(!PageUptodate(page));
> > > -     BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > +     BUG_ON(!iomap_inline_data_size_valid(iomap));
> > >
> > >       flush_dcache_page(page);
> > >       addr = kmap_atomic(page);
> > > -     memcpy(iomap->inline_data + pos, addr + pos, copied);
> > > +     memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> > >       kunmap_atomic(addr);
> > >
> > >       mark_inode_dirty(inode);
> >
> > Only tangentially related ... why do we memcpy the data into the tail
> > at write_end() time instead of at writepage() time?  I see there's a
> > workaround for that in gfs2's page_mkwrite():
> >
> >         if (gfs2_is_stuffed(ip)) {
> >                 err = gfs2_unstuff_dinode(ip);
> >
> > (an mmap store cannot change the size of the file, so this would be
> > unnecessary)
> 
> Not sure if an additional __set_page_dirty_nobuffers is needed in that
> case, but doing the writeback at writepage time should work just as
> well. It's just that gfs2 did it at write time historically. The
> un-inlining in gfs2_page_mkwrite() could probably also be removed.
> 
> I can give this a try, but I'll unfortunately be AFK for the next
> couple of days.

I tend to leave it as another new story and can be resolved with
another patch to improve it (or I will stuck in this, I need to do
my own development stuff instead of spinning with this iomap patch
since I can see this already work well for gfs2 and erofs), I will
update the patch Andreas posted with Christoph's comments.

Thanks,
Gao Xiang
