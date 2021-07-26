Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5A3D5420
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 09:23:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYBGk457jz302D
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 17:23:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cinQEXZq;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cinQEXZq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=cinQEXZq; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cinQEXZq; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYBGc2TjBz2yX6
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 17:23:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627284177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeX8qL0FAIQm9lCQlUw2wK9bVyGC91/TUjMa+ErGo/I=;
 b=cinQEXZqUnLxQ4/Wsq6B/Whc1D9OrE6waaQuDN2BQcSmLTy5J/BOk9HE1xiEjPvdOqkMoK
 jdRC/cWq0H9ivqv9KQbOeBrjtbwwqGwmXDuymHUNMtJ9k6OnuOlw2qhdUrNZ+hMjoh93UY
 eZ01IGZ/C7dP8Y5Pn3TzqCPMwelY3lw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627284177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeX8qL0FAIQm9lCQlUw2wK9bVyGC91/TUjMa+ErGo/I=;
 b=cinQEXZqUnLxQ4/Wsq6B/Whc1D9OrE6waaQuDN2BQcSmLTy5J/BOk9HE1xiEjPvdOqkMoK
 jdRC/cWq0H9ivqv9KQbOeBrjtbwwqGwmXDuymHUNMtJ9k6OnuOlw2qhdUrNZ+hMjoh93UY
 eZ01IGZ/C7dP8Y5Pn3TzqCPMwelY3lw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-NdKwTr2lNZKMfNBbq_GXBA-1; Mon, 26 Jul 2021 03:22:53 -0400
X-MC-Unique: NdKwTr2lNZKMfNBbq_GXBA-1
Received: by mail-wr1-f72.google.com with SMTP id
 d10-20020a056000114ab02901537f048363so1142982wrx.8
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=MeX8qL0FAIQm9lCQlUw2wK9bVyGC91/TUjMa+ErGo/I=;
 b=bSLATAxme8x3LR4sVuNDsVH8SrCtm7jwGrq4hqxcTM9f2W6ZKEHR4aHC01+vgwW9cg
 48X+KCo+4C0+VC9hwgMnBkWnFuC/3IgVdgDVJmEw1wBVQFDbydnM5Hz9A7WJFZ1uMkDJ
 l2erU3X5rhgQewO6rIXwlM3VfjsAwAA9y1Og/e3pmnJjvjy4veIN+MeU3th0eN5dPV8y
 MSfXvjNTdAu11WIdAg4asTnlYO+MmkmQI0dGsvqpqgCz/Q28jKC8c+9j1w8KCdLM58Vu
 U/sUzL5SJm0/fWJd2r5UjldBzxsfvTefR+JNobnJY2//KzP4DiSxUtlaVvB6B9KwmGg7
 jfzw==
X-Gm-Message-State: AOAM531CwLljRKiM3ZlyLvZkVPdnta/zgdsFZG31zJyUNn6sbOJy66uX
 amueNAwF9Kp35JgIHgvLMji3SNfiOnFM8A5PsxMkQV4+9G/2tfuFj14i7Vg7ly3xSh4r1ZCXCCq
 stUBB2Sae30FdD5UX5u+9IkUJYROcztV50Fwk11pq
X-Received: by 2002:a05:6000:227:: with SMTP id
 l7mr6209249wrz.289.1627284172762; 
 Mon, 26 Jul 2021 00:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMPTPi7uK/DcXtzBz0a+yMSxtuUyKKbFDoQbZm98a8p/STZCbLR5hh1hXULHMPYI9hzTrryt893dSga4drXhc=
X-Received: by 2002:a05:6000:227:: with SMTP id
 l7mr6209224wrz.289.1627284172598; 
 Mon, 26 Jul 2021 00:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
In-Reply-To: <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jul 2021 09:22:41 +0200
Message-ID: <CAHc6FU7904K4XrUhOoHp8uoBrDN0kyZ+q54anMXrJUBVCNA29A@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: Andreas Gruenbacher <agruenba@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J . Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=agruenba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Mon, Jul 26, 2021 at 4:36 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > Here's a fixed and cleaned up version that passes fstests on gfs2.
> >
> > I see no reason why the combination of tail packing + writing should
> > cause any issues, so in my opinion, the check that disables that
> > combination in iomap_write_begin_inline should still be removed.
>
> Since there is no such fs for tail-packing write, I just do a wild
> guess, for example,
>  1) the tail-end block was not inlined, so iomap_write_end() dirtied
>     the whole page (or buffer) for the page writeback;
>  2) then it was truncated into a tail-packing inline block so the last
>     extent(page) became INLINE but dirty instead;
>  3) during the late page writeback for dirty pages,
>     if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
>     would be triggered in iomap_writepage_map() for such dirty page.
>
> As Matthew pointed out before,
> https://lore.kernel.org/r/YPrms0fWPwEZGNAL@casper.infradead.org/
> currently tail-packing inline won't interact with page writeback, but
> I'm afraid a supported tail-packing write fs needs to reconsider the
> whole stuff how page, inode writeback works and what the pattern is
> with the tail-packing.
>
> >
> > It turns out that returning the number of bytes copied from
> > iomap_read_inline_data is a bit irritating: the function is really used
> > for filling the page, but that's not always the "progress" we're looking
> > for.  In the iomap_readpage case, we actually need to advance by an
> > antire page, but in the iomap_file_buffered_write case, we need to
> > advance by the length parameter of iomap_write_actor or less.  So I've
> > changed that back.
> >
> > I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> > iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> > more useful to me.
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > Subject: [PATCH] iomap: Support tail packing
> >
> > The existing inline data support only works for cases where the entire
> > file is stored as inline data.  For larger files, EROFS stores the
> > initial blocks separately and then can pack a small tail adjacent to the
> > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > cross a page boundary in memory.
> >
> > We currently have no filesystems that support tail packing and writing,
> > so that case is currently disabled (see iomap_write_begin_inline).  I'm
> > not aware of any reason why this code path shouldn't work, however.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  fs/iomap/direct-io.c   | 11 ++++++-----
> >  include/linux/iomap.h  | 22 +++++++++++++++++++++-
> >  3 files changed, 50 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..334bf98fdd4a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
> >       struct readahead_control *rac;
> >  };
> >
> > -static void
> > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >               struct iomap *iomap)
> >  {
> > -     size_t size = i_size_read(inode);
> > +     size_t size = i_size_read(inode) - iomap->offset;
>
> I wonder why you use i_size / iomap->offset here,

This function is supposed to copy the inline or tail data at
iomap->inline_data into the page passed to it. Logically, the inline
data starts at iomap->offset and extends until i_size_read(inode).
Relative to the page, the inline data starts at offset 0 and extends
until i_size_read(inode) - iomap->offset. It's as simple as that.

> and why you completely ignoring iomap->length field returning by fs.

In the iomap_readpage case (iomap_begin with flags == 0),
iomap->length will be the amount of data up to the end of the inode.
In the iomap_file_buffered_write case (iomap_begin with flags ==
IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
(For extending writes, we need to write beyond the current end of
inode.) So iomap->length isn't all that useful for
iomap_read_inline_data.

> Using i_size here instead of iomap->length seems coupling to me in the
> beginning (even currently in practice there is some limitation.)

And what is that?

Thanks,
Andreas

