Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ADB3CF8C2
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 13:24:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTbvN4S52z30Ft
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 21:24:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=HhpzAjl0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132;
 helo=mail-il1-x132.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HhpzAjl0; dkim-atps=neutral
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTbvK0GZYz2xZ3
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 21:23:56 +1000 (AEST)
Received: by mail-il1-x132.google.com with SMTP id p3so18801302ilg.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dVnkGAPBzNUrDjo/vYV+V2SBEEyGsdjuUedWnsOzsis=;
 b=HhpzAjl09BeOsEUIHpVHWdklJxETeRFiANMBco0ll1FiBP/oqIp82Rp0IOuN4qVKf/
 qQnawPRP13Mt3ys+cZH7IYKZctRhluI109OvPpL4CRWr6teTA70+/oNb8BsdxyU63WHT
 hrG0rGLPRP2Jw46212Qk9eKPUTmtXFuZZ4SAmmSOfhJNiT38qdLD2BYccDeS8kZLk/I7
 XGrNwkZYwR4sP84muKsPDF6xLTxQ7OdUNrbC0O3LDULWEYeC2bq54/6iTi8y86jmCK6g
 kaII1t+FF7+XEDeZ8dFoloGAxGDqZxcTXvquESb2qtIbnU94CVRLN5/j5ulZPZU7FwXm
 DP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dVnkGAPBzNUrDjo/vYV+V2SBEEyGsdjuUedWnsOzsis=;
 b=eN6Mj8//Pchm5Ey2JIiVY0E97yS7x6FrbZknf85S93AgOTRJwl5W0kcU/PEZE38xmZ
 EXBSViMg4FJq+DjTGIM8q2LHjXRg5Zwqg4CqawNSliZMjCWam09qRKcug8sImWh17bQW
 P8Ex32ng2PUlUzyk7Uc8t/CnlkpSNQx+jPZSsSehBMO/b5XG2o0aOSCRs9s2ESd8UmMW
 DPT6x92neetEXwPW0jR1SD5j7JZWRS/8J/DEJlOagUv+vENQ1zrYDipUaAdExAoxz3mK
 oqSVjq44cnv+aQAy3XAcYVITIXFBAZbwWqN2gSddU0qwP9Lh5WzhOpOIqL4SXr0tcgk6
 qPeQ==
X-Gm-Message-State: AOAM530HaRBcXG5YUP7nOilui97hvFP4lgTVhhak2EThpo7uVy2+Y1vX
 VP2b4Smt4jv4o+DrqR9l+UD7C4OBbCSze/5KQdM=
X-Google-Smtp-Source: ABdhPJwvarTz9JB1YULDF9dibEw4xDmSKLba/T9RKxu2zqIT7IO1azlWgD4aPruTDh16Glzxq3MtzUk2SIEVDAghRYo=
X-Received: by 2002:a05:6e02:c73:: with SMTP id
 f19mr19729417ilj.291.1626780232988; 
 Tue, 20 Jul 2021 04:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 20 Jul 2021 13:23:41 +0200
Message-ID: <CAHpGcMJ4T6byxqmO6zZF78wuw01twaEvSW5N6s90qWm0q_jCXQ@mail.gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Mo., 19. Juli 2021 um 16:48 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> This tries to add tail packing inline read to iomap, which can support
> several inline tail blocks. Similar to the previous approach, it cleans
> post-EOF in one iteration.
>
> The write path remains untouched since EROFS cannot be used for testing.
> It'd be better to be implemented if upcoming real users care rather than
> leave untested dead code around.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2: https://lore.kernel.org/r/YPLdSja%2F4FBsjss%2F@B-P7TQMD6M-0146.local/
> changes since v2:
>  - update suggestion from Christoph:
>     https://lore.kernel.org/r/YPVe41YqpfGLNsBS@infradead.org/
>
> Hi Andreas,
> would you mind test on the gfs2 side? Thanks in advance!
>
> Thanks,
> Gao Xiang
>
>  fs/iomap/buffered-io.c | 50 ++++++++++++++++++++++++++----------------
>  fs/iomap/direct-io.c   | 11 ++++++----
>  2 files changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..cac8a88660d8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -207,23 +207,22 @@ struct iomap_readpage_ctx {
>
>  static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
> -               struct iomap *iomap)
> +               struct iomap *iomap, loff_t pos)
>  {
> -       size_t size = i_size_read(inode);
> +       unsigned int size, poff = offset_in_page(pos);
>         void *addr;
>
> -       if (PageUptodate(page))
> -               return;
> -
> -       BUG_ON(page_has_private(page));
> -       BUG_ON(page->index);
> -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline source data must be inside a single page */
> +       BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* handle tail-packing blocks cross the current page into the next */
> +       size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> +                    PAGE_SIZE - poff);

Hmm, so EROFS really does multi-page tail packing? This contradicts
the comment and code in iomap_dio_inline_actor.

>         addr = kmap_atomic(page);
> -       memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - size);
> +       memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +       memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
>         kunmap_atomic(addr);
> -       SetPageUptodate(page);
> +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
>  }

It's been said before, but iomap_read_inline_data should return
PAGE_SIZE - poff, and no (void) casting when the return value is
ignored.

>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         unsigned poff, plen;
>         sector_t sector;
>
> -       if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
> -               iomap_read_inline_data(inode, page, iomap);
> -               return PAGE_SIZE;
> -       }
> -
> -       /* zero post-eof blocks as the page may be mapped */
>         iop = iomap_page_create(inode, page);
> +       /* needs to skip some leading uptodated blocks */

"needs to skip some leading uptodate blocks"

>         iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>         if (plen == 0)
>                 goto done;
>
> +       if (iomap->type == IOMAP_INLINE) {
> +               iomap_read_inline_data(inode, page, iomap, pos);
> +               plen = PAGE_SIZE - poff;
> +               goto done;
> +       }
> +
> +       /* zero post-eof blocks as the page may be mapped */
>         if (iomap_block_needs_zeroing(inode, iomap, pos)) {
>                 zero_user(page, poff, plen);
>                 iomap_set_range_uptodate(page, poff, plen);
> @@ -589,6 +589,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>         return 0;
>  }
>
> +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> +               struct page *page, struct iomap *srcmap)
> +{
> +       /* needs more work for the tailpacking case, disable for now */
> +       if (WARN_ON_ONCE(pos != 0))

This should be a WARN_ON_ONCE(srcmap->offset != 0). Otherwise, something like:

  xfs_io -ft -c 'pwrite 1 2'

will fail because pos will be 1.

> +               return -EIO;
> +       if (PageUptodate(page))
> +               return 0;
> +       iomap_read_inline_data(inode, page, srcmap, pos);

The above means that passing pos to iomap_read_inline_data here won't
do the right thing, either.

> +       return 0;
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>                 struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>         }
>
>         if (srcmap->type == IOMAP_INLINE)
> -               iomap_read_inline_data(inode, page, srcmap);
> +               status = iomap_write_begin_inline(inode, pos, page, srcmap);
>         else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>         else
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..ee6309967b77 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -379,22 +379,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  {
>         struct iov_iter *iter = dio->submit.iter;
>         size_t copied;
> +       void *dst = iomap->inline_data + pos - iomap->offset;
>
> -       BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline data must be inside a single page */
> +       BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
>
>         if (dio->flags & IOMAP_DIO_WRITE) {
>                 loff_t size = inode->i_size;
>
>                 if (pos > size)
> -                       memset(iomap->inline_data + size, 0, pos - size);
> -               copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +                       memset(iomap->inline_data + size - iomap->offset,
> +                              0, pos - size);
> +               copied = copy_from_iter(dst, length, iter);
>                 if (copied) {
>                         if (pos + copied > size)
>                                 i_size_write(inode, pos + copied);
>                         mark_inode_dirty(inode);
>                 }
>         } else {
> -               copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +               copied = copy_to_iter(dst, length, iter);
>         }
>         dio->size += copied;
>         return copied;
> --
> 2.24.4
>

Thanks,
Andreas
