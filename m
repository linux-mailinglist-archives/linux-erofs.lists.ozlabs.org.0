Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A283D59CE
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 14:51:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYKYV50jnz307L
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 22:51:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYKYN4v3cz3019
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 22:51:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R931e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0Uh2wpJ9_1627303860; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uh2wpJ9_1627303860) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 26 Jul 2021 20:51:01 +0800
Date: Mon, 26 Jul 2021 20:50:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP6vs180ThT1A2dO@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?=
 <andreas.gruenbacher@gmail.com>, 
 Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
 <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Andreas, Christoph,

On Mon, Jul 26, 2021 at 02:27:12PM +0200, Andreas Grünbacher wrote:
> Am Mo., 26. Juli 2021 um 14:17 Uhr schrieb Christoph Hellwig <hch@lst.de>:
> >
> > > Subject: iomap: Support tail packing
> >
> > I can't say I like this "tail packing" language here when we have the
> > perfectly fine inline wording.  Same for various comments in the actual
> > code.
> >
> > > +     /* inline and tail-packed data must start page aligned in the file */
> > > +     if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > > +             return -EIO;
> > > +     if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inline_data)))
> > > +             return -EIO;
> >
> > Why can't we use iomap_inline_data_size_valid here?
> 
> We can now. Gao, can you change that?

Thank you all taking so much time on this! much appreciated.

I'm fine to update that.

> 
> > That is how can size be different from iomap->length?
> 
> Quoting from my previous reply,
> 
> "In the iomap_readpage case (iomap_begin with flags == 0),
> iomap->length will be the amount of data up to the end of the inode.

For tail-packing cases, iomap->length is just the length of tail-packing
inline extent.

> In the iomap_file_buffered_write case (iomap_begin with flags ==
> IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> (For extending writes, we need to write beyond the current end of
> inode.) So iomap->length isn't all that useful for
> iomap_read_inline_data."

Ok, now it seems I get your point. For the current gfs2 inline cases:
  iomap_write_begin
    iomap_write_begin_inline
      iomap_read_inline_data

here, gfs2 passes a buffer instead with "iomap->length", maybe it
could be larger than i_size_read(inode) for gfs2. Is that correct?

	loff_t max_size = gfs2_max_stuffed_size(ip);

	iomap->length = max_size;

If that is what gfs2 currently does, I think it makes sense to
temporarily use as this, but IMO, iomap->inline_bufsize is not
iomap->length. These are 2 different concepts.

> 
> > Shouldn't the offset_in_page also go into iomap_inline_data_size_valid,
> > which should probably be called iomap_inline_data_valid then?
> 
> Hmm, not sure what you mean: iomap_inline_data_size_valid does take
> offset_in_page(iomap->inline_data) into account.
> 
> > >       if (iomap->type == IOMAP_INLINE) {
> > > +             int ret = iomap_read_inline_data(inode, page, iomap);
> > > +             return ret ?: PAGE_SIZE;
>
> > The ?: expression without the first leg is really confuing.  Especially
> > if a good old if is much more readable here.
> 
> I'm sure Gao can change this.
> 
> >                 int ret = iomap_read_inline_data(inode, page, iomap);
> >
> >                 if (ret)
> >                         return ret;
> >                 return PAGE_SIZE;

I'm fine to update it if no strong opinion.

> >
> > > +             copied = copy_from_iter(iomap_inline_data(iomap, pos), length, iter);
> >
> >
> > > +             copied = copy_to_iter(iomap_inline_data(iomap, pos), length, iter);
> >
> > Pleae avoid the overly long lines.
> 
> I thought people were okay with 80 character long lines?

Christoph mentioned before as below:
https://lore.kernel.org/linux-fsdevel/YPVe41YqpfGLNsBS@infradead.org/

We also need to take the offset into account for the write side.
I guess it would be nice to have a local variable for the inline
address to not duplicate that calculation multiple times.

Thanks,
Gao Xiang

> 
> Thanks,
> Andreas
