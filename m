Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0B3D695F
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 00:20:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYZBJ6kdBz2yfb
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 08:20:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=C8GRDuGg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::129;
 helo=mail-il1-x129.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=C8GRDuGg; dkim-atps=neutral
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYZBC3NPKz2yNr
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 08:20:34 +1000 (AEST)
Received: by mail-il1-x129.google.com with SMTP id c3so10444726ilh.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L9tnwQpyOYaK3h8hc6RpyrCNISHNv7BwiP0E/4vS8L4=;
 b=C8GRDuGg8y7QrQiJsgbNLJ12gw5a1DlLSqP/2I+wKbeisQmr1lP52LYU2FyfEu+DL4
 VVXQjB40uh1M+AoLx2VoFov5Ar4KDLnt5qY15H0P6nCYy0sxuq5ElJCX56HsypKgr/OL
 CvUVoyRHLM64YCfAvIxpr+N9Qch1hHpXEytv/FCy5q/Y4y2bs2wHdDX2EuTmb8Ti2Q14
 Z92oue61GQSuL5mUHLYT/cIFSNn2zbjZPAnS6LPLkzQYASHnFdRs6LexxFH4aE0ympQC
 Bp5iXGQUWqkMk7ouL//4bkXoUX3N1lDuxCQQMUrnPeVz/vfZ4/YV+YTDUBFwaESSttD9
 dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L9tnwQpyOYaK3h8hc6RpyrCNISHNv7BwiP0E/4vS8L4=;
 b=m8eWcp8SLUrrEoxJFAnizcnQc3CGF/4j5qAGQmOhAhaecZL6C7pYBiMkCVdqgy2pbZ
 RS7EISzrIVW2giBQz9I3eMQiiYZpeVAGhmZqyxCqSaUp6aeNLr4TmA7OGBmxneGHzOog
 7i6kddyg3BPMuVl+fs0IhzRURBOcE1eZFkbs/Ogvg1EIr3/q6CWydKhSS4CN+Ml0tgpq
 ubFhpBjXPMvi6N3GvSNqweEwTqL62dTKMcpEB6yYy/5kYyjdxcZxQNHhHamWRHhbAqLB
 f/k3gOn8zxVn9B3F+KirL7T7YjdZl4O6sKdF2KdzeW7sGYAsBDOvgPRg8FgcGsCEJOTW
 03pw==
X-Gm-Message-State: AOAM533ZKV2UXlUXNBitRbJ6SZk2eQmRK15RyZjGKrLnSXpRlbLfxsWa
 B9RGvW2OVcwmNTvsShqoOUynkJSBQ+eIVWIJzbk=
X-Google-Smtp-Source: ABdhPJy9rhfXjOBtfRIGtJGux/mY2OxvsvZwnRhE+838JomJ5zefOfSTLErjsFzuK7czJVSTj/uDH0svNUQRY0aSKO0=
X-Received: by 2002:a92:d451:: with SMTP id r17mr14949910ilm.109.1627338030829; 
 Mon, 26 Jul 2021 15:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
 <CAHc6FU7904K4XrUhOoHp8uoBrDN0kyZ+q54anMXrJUBVCNA29A@mail.gmail.com>
 <20210726213629.GF8572@magnolia>
In-Reply-To: <20210726213629.GF8572@magnolia>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 27 Jul 2021 00:20:18 +0200
Message-ID: <CAHpGcM+oarDjgAC30X1eP4qPkpPP6i1s32t6CPXCYgiySOqVrg@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: "Darrick J. Wong" <djwong@kernel.org>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Mo., 26. Juli 2021 um 23:36 Uhr schrieb Darrick J. Wong <djwong@kernel.org>:
> On Mon, Jul 26, 2021 at 09:22:41AM +0200, Andreas Gruenbacher wrote:
> > On Mon, Jul 26, 2021 at 4:36 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > > > Here's a fixed and cleaned up version that passes fstests on gfs2.
> > > >
> > > > I see no reason why the combination of tail packing + writing should
> > > > cause any issues, so in my opinion, the check that disables that
> > > > combination in iomap_write_begin_inline should still be removed.
> > >
> > > Since there is no such fs for tail-packing write, I just do a wild
> > > guess, for example,
> > >  1) the tail-end block was not inlined, so iomap_write_end() dirtied
> > >     the whole page (or buffer) for the page writeback;
> > >  2) then it was truncated into a tail-packing inline block so the last
> > >     extent(page) became INLINE but dirty instead;
> > >  3) during the late page writeback for dirty pages,
> > >     if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
> > >     would be triggered in iomap_writepage_map() for such dirty page.
> > >
> > > As Matthew pointed out before,
> > > https://lore.kernel.org/r/YPrms0fWPwEZGNAL@casper.infradead.org/
> > > currently tail-packing inline won't interact with page writeback, but
> > > I'm afraid a supported tail-packing write fs needs to reconsider the
> > > whole stuff how page, inode writeback works and what the pattern is
> > > with the tail-packing.
> > >
> > > >
> > > > It turns out that returning the number of bytes copied from
> > > > iomap_read_inline_data is a bit irritating: the function is really used
> > > > for filling the page, but that's not always the "progress" we're looking
> > > > for.  In the iomap_readpage case, we actually need to advance by an
> > > > antire page, but in the iomap_file_buffered_write case, we need to
> > > > advance by the length parameter of iomap_write_actor or less.  So I've
> > > > changed that back.
> > > >
> > > > I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> > > > iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> > > > more useful to me.
> > > >
> > > > Thanks,
> > > > Andreas
> > > >
> > > > --
> > > >
> > > > Subject: [PATCH] iomap: Support tail packing
> > > >
> > > > The existing inline data support only works for cases where the entire
> > > > file is stored as inline data.  For larger files, EROFS stores the
> > > > initial blocks separately and then can pack a small tail adjacent to the
> > > > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > > > cross a page boundary in memory.
> > > >
> > > > We currently have no filesystems that support tail packing and writing,
> > > > so that case is currently disabled (see iomap_write_begin_inline).  I'm
> > > > not aware of any reason why this code path shouldn't work, however.
> > > >
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > > > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > > ---
> > > >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> > > >  fs/iomap/direct-io.c   | 11 ++++++-----
> > > >  include/linux/iomap.h  | 22 +++++++++++++++++++++-
> > > >  3 files changed, 50 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 87ccb3438bec..334bf98fdd4a 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
> > > >       struct readahead_control *rac;
> > > >  };
> > > >
> > > > -static void
> > > > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > > > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> > > >               struct iomap *iomap)
> > > >  {
> > > > -     size_t size = i_size_read(inode);
> > > > +     size_t size = i_size_read(inode) - iomap->offset;
> > >
> > > I wonder why you use i_size / iomap->offset here,
> >
> > This function is supposed to copy the inline or tail data at
> > iomap->inline_data into the page passed to it. Logically, the inline
> > data starts at iomap->offset and extends until i_size_read(inode).
> > Relative to the page, the inline data starts at offset 0 and extends
> > until i_size_read(inode) - iomap->offset. It's as simple as that.
>
> It's only as simple as that because the inline data read code is overfit
> to the single use case (gfs2) that it supports.  So far in its history,
> iomap has never had to support inline data regions that do not coincide
> or overlap with EOF, nor has it had to support regions that do not start
> at pos==0.  That is why it is appropriate to use the memcpy -> memset ->
> return PAGE_SIZE pattern and short-circuit what we do everywhere else in
> iomap.
>
> For a non-inline readpage call, filesystems are allowed to return
> mappings for blocks beyond EOF.  The call to iomap_adjust_read_range
> sets us up to read data from disk through the EOF block, and for the
> remainder of the page we zero the post-eof blocks within that page.
>
> IOWs, for reads, __gfs2_iomap_get probably ought to set iomap->length to
> gfs2_max_stuffed_size() like it does for writes, and we ought to
> generalize iomap_read_inline_data to stop copying after
> min(iomap->length, i_size_read() - iomap->offset) bytes.  If it then
> discovers that it has indeed reached EOF, then we can zero the rest of
> the page and add that quantity to the number of bytes read.

That sounds like a useful improvement. I'll give it a try.

Thanks,
Andreas

> Right now for gfs2 the two arguments to min are always the same so the
> function omits all the bits that would make the zeroing actually
> conditional on whether we really hit EOF, and pass any copied size other
> than PAGE_SIZE back to iomap_readpage_actor.  Given that we still don't
> have any filesystems that require us to support inline regions entirely
> below EOF I'm fine with omitting the general (and hence untestable)
> solution... for now.
>
> (I now think I understand why someone brought up inline data regions in
> the middle of files last week.)
>
> --D
>
> > > and why you completely ignoring iomap->length field returning by fs.
> >
> > In the iomap_readpage case (iomap_begin with flags == 0),
> > iomap->length will be the amount of data up to the end of the inode.
> > In the iomap_file_buffered_write case (iomap_begin with flags ==
> > IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> > (For extending writes, we need to write beyond the current end of
> > inode.) So iomap->length isn't all that useful for
> > iomap_read_inline_data.
> >
> > > Using i_size here instead of iomap->length seems coupling to me in the
> > > beginning (even currently in practice there is some limitation.)
> >
> > And what is that?
> >
> > Thanks,
> > Andreas
> >
