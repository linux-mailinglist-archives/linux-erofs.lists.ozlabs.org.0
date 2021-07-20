Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4B3CF8E1
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 13:35:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GTc8T1fs7z30HQ
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jul 2021 21:35:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=cJOAjNNO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d36;
 helo=mail-io1-xd36.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cJOAjNNO; dkim-atps=neutral
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GTc8L0L01z2yLl
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 21:35:13 +1000 (AEST)
Received: by mail-io1-xd36.google.com with SMTP id z17so16941473iog.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W00f0ANz3WrZGqMdQysCloQ6vLp/tHXNWmmPd6zJe0U=;
 b=cJOAjNNO+m9zN0XNbTz3X4fk8STUtDi//3Yu/zRLr6C8sZVhauDsSAR/7Ub4rvyg8e
 jhy4l34MkfMVpefHVgeR4mHMHFxMvPJlCW7q/1pzodeUkYNKtIujj4pr6GikeQJ7QBI2
 8MeT0Oqtz/0BN3dYjuN29zqGAELS+8P4IrRdMvM0d9Lcoa3R1OOfl3sdP99sCaU304Y4
 JGVuwd0xjrgK5P3IfbAabKZJ2TxD/WC0uyBm2l+ZMZ95T0dI2aYDYujgZfyWOhe/Pzso
 tcr/XsaBtDcFojAElBHKW5au/54i3gxQVC/ulVrhgs/rtT/ss7xeb4EyoYjE6RZYKZTz
 VfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W00f0ANz3WrZGqMdQysCloQ6vLp/tHXNWmmPd6zJe0U=;
 b=azs91RewUke+pVpAsnawhCZQLHcYkS7uG+VsU0i2/uv0gN7lTA3LszbRJZpnZGAcVz
 Vybi4lAJf349Nse468m0vQjV8jcP3d9U+eYhMQwgz7l+TJrBZLnJVLlch0j57Jgz5+nH
 p0NVmyQf1qVHf+aNjk+b/ZRjM9SHN/VfmpE/AckHWNe65yoTcs9Epkd+7VWRD3k15Bwd
 K0b8owg/yMovjofI38k2Y60VINOJicIQ2ElW1VfTDXqMx7wE9y/qa6qn7C6KZlxvjfSJ
 osKltu8OBhlAFGmPQYqHDsqrYbB2Lssz8BWXTCx45GFXICCC8wSWHaWV7RCNsyMzckwP
 mjvw==
X-Gm-Message-State: AOAM5332ZP3MQHOvO6L8UtXyDXTH37ZoePJLXk2ZYOsWgtvts2cVhr6y
 juRWiLgsFi388uxxTgab624m4g0mt/+e5ry9Rlk=
X-Google-Smtp-Source: ABdhPJwqGEyizwyBwYlBCgp4IlLEfgl+nKlAQzLRY50FX2HkLOEGDEiHWz3+a06/FBfxpHmmcgrQwpjlNja0E3zaDQ8=
X-Received: by 2002:a02:85a5:: with SMTP id d34mr25763258jai.132.1626780909646; 
 Tue, 20 Jul 2021 04:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Tue, 20 Jul 2021 13:34:58 +0200
Message-ID: <CAHpGcM+qhur4C2fLyR-dQx7CvumXVvMAM5NBCCXnL5ve-2qE8w@mail.gmail.com>
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
>
>         addr = kmap_atomic(page);
> -       memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - size);
> +       memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +       memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
>         kunmap_atomic(addr);
> -       SetPageUptodate(page);
> +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
>  }
>
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

We can skip creating the iop when reading the entire page.

> +       /* needs to skip some leading uptodated blocks */
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
> +               return -EIO;
> +       if (PageUptodate(page))
> +               return 0;
> +       iomap_read_inline_data(inode, page, srcmap, pos);
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
