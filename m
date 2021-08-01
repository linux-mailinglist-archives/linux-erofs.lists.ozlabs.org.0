Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1113DCB80
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Aug 2021 14:04:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gd0D05Q94z3069
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Aug 2021 22:04:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5ImG4yA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5ImG4yA;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=f5ImG4yA; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5ImG4yA; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gd0Ct2C6Tz2yYd
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Aug 2021 22:03:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627819429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2Sl+xhZ07fi1CiyZFUc8volC3Ldaw50waFma86MTYk=;
 b=f5ImG4yAjXeocLGvwDEHNlffhjADRXCDWkYFyW8SUvPGEgxunEML8zr/eMtgdgNm+HfA37
 dCSR7vO2QbILYzTOO8xcprOXmBM0gt3EMlnx5ttcPAWTErKNf4eRKUJtgVkmCKROaynEDU
 dCI1C4OZ5lAlAzd2+Q+vwH3+bTp+MZk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627819429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2Sl+xhZ07fi1CiyZFUc8volC3Ldaw50waFma86MTYk=;
 b=f5ImG4yAjXeocLGvwDEHNlffhjADRXCDWkYFyW8SUvPGEgxunEML8zr/eMtgdgNm+HfA37
 dCSR7vO2QbILYzTOO8xcprOXmBM0gt3EMlnx5ttcPAWTErKNf4eRKUJtgVkmCKROaynEDU
 dCI1C4OZ5lAlAzd2+Q+vwH3+bTp+MZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-hrhNvVh_MXCw9-kTAEfyFw-1; Sun, 01 Aug 2021 08:03:45 -0400
X-MC-Unique: hrhNvVh_MXCw9-kTAEfyFw-1
Received: by mail-wm1-f69.google.com with SMTP id
 21-20020a05600c0255b02902571fa93802so2427007wmj.1
 for <linux-erofs@lists.ozlabs.org>; Sun, 01 Aug 2021 05:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R2Sl+xhZ07fi1CiyZFUc8volC3Ldaw50waFma86MTYk=;
 b=Oyxbl4gybKTBMhMG2CA2gSAF84M/1RduHfXO74P4Gzw1tSbmfoFQJ9d+NwL01+A5Va
 exwpknPwJyjUYTkVMMBZot3cL/oTGod8tGEQm/u0MJpMGCfY9PEDI5ZI7f0buvXqKMO3
 6a/Wt5g58p612YtIIKNOfkOGVJbgm/fjwFSGs+uAAk66jPElL00MOeCnyf76MM11pinq
 OqHHiLiWGPi4bguXnWM6e5AWniZ1bqQ7kxSdAF5s+FGq+pwR4zYdyZEZgL9oUpZAnIeg
 9DsrhO0KOhkI50LcwbJjGgVr7Lj3EsowjraUh/lOnl+1Z3hosSU2wOeSTCSN0fJ/S4fE
 CDSw==
X-Gm-Message-State: AOAM530wfc877XjeQ2AJOdisezWxI9KG+izsbMUnxWHJcodBrkfcMBOV
 2NYDvToeXIKL49E+mrGgT0dX4hD/JHL9424DEIGQiMTHG+5PFDH0K9zWaGOE4epor+xCie+3nNt
 J1x3TX1mpVb+Y5HABosGDyxiIqeblhNlRUrobB4/N
X-Received: by 2002:adf:dd07:: with SMTP id a7mr12098470wrm.377.1627819424750; 
 Sun, 01 Aug 2021 05:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxin7fSOKTA/2+6Wli3DPO8r9DTT4yPQtSqbMy0Ofb2InWsVF6RHpk3vh1EWlAKwHFL5ikAFILUBPDJvWbnuWc=
X-Received: by 2002:adf:dd07:: with SMTP id a7mr12098452wrm.377.1627819424528; 
 Sun, 01 Aug 2021 05:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 1 Aug 2021 14:03:33 +0200
Message-ID: <CAHc6FU5x3XOTyu8vooReSZ-hacfTdo3cu7wFJRcQrfTH8NkVeg@mail.gmail.com>
Subject: Re: [PATCH v9] iomap: Support file tail packing
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 27, 2021 at 5:00 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> The existing inline data support only works for cases where the entire
> file is stored as inline data.  For larger files, EROFS stores the
> initial blocks separately and then can pack a small tail adjacent to the
> inode.  Generalise inline data to allow for tail packing.  Tails may not
> cross a page boundary in memory.
>
> We currently have no filesystems that support tail packing and writing,
> so that case is currently disabled (see iomap_write_begin_inline).
>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v8: https://lore.kernel.org/r/20210726145734.214295-1-hsiangkao@linux.alibaba.com
> changes since v8:
>  - update the subject to 'iomap: Support file tail packing' as there
>    are clearly a number of ways to make the inline data support more
>    flexible (Matthew);
>
>  - add one extra safety check (Darrick):
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
>
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++------------
>  fs/iomap/direct-io.c   | 10 ++++++----
>  include/linux/iomap.h  | 18 ++++++++++++++++++
>  3 files changed, 54 insertions(+), 16 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..f429b9d87dbe 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,32 @@ struct iomap_readpage_ctx {
>         struct readahead_control *rac;
>  };
>
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
>                 struct iomap *iomap)
>  {
> -       size_t size = i_size_read(inode);
> +       size_t size = i_size_read(inode) - iomap->offset;
>         void *addr;
>
>         if (PageUptodate(page))
> -               return;
> +               return 0;
>
> -       BUG_ON(page_has_private(page));
> -       BUG_ON(page->index);
> -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline data must start page aligned in the file */
> +       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(size > PAGE_SIZE -
> +                        offset_in_page(iomap->inline_data)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(size > iomap->length))
> +               return -EIO;
> +       if (WARN_ON_ONCE(page_has_private(page)))
> +               return -EIO;
>
>         addr = kmap_atomic(page);
>         memcpy(addr, iomap->inline_data, size);
>         memset(addr + size, 0, PAGE_SIZE - size);
>         kunmap_atomic(addr);
>         SetPageUptodate(page);
> +       return 0;
>  }
>
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -247,8 +254,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         sector_t sector;
>
>         if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
> -               iomap_read_inline_data(inode, page, iomap);
> +               int ret = iomap_read_inline_data(inode, page, iomap);
> +
> +               if (ret)
> +                       return ret;
>                 return PAGE_SIZE;
>         }
>
> @@ -589,6 +598,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>         return 0;
>  }
>
> +static int iomap_write_begin_inline(struct inode *inode,
> +               struct page *page, struct iomap *srcmap)
> +{
> +       /* needs more work for the tailpacking case, disable for now */

Nit: the comma should be a semicolon or period here.

> +       if (WARN_ON_ONCE(srcmap->offset != 0))
> +               return -EIO;
> +       return iomap_read_inline_data(inode, page, srcmap);
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>                 struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>         }
>
>         if (srcmap->type == IOMAP_INLINE)
> -               iomap_read_inline_data(inode, page, srcmap);
> +               status = iomap_write_begin_inline(inode, page, srcmap);
>         else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>         else
> @@ -671,11 +689,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>         void *addr;
>
>         WARN_ON_ONCE(!PageUptodate(page));
> -       BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       BUG_ON(!iomap_inline_data_valid(iomap));
>
>         flush_dcache_page(page);
>         addr = kmap_atomic(page);
> -       memcpy(iomap->inline_data + pos, addr + pos, copied);
> +       memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
>         kunmap_atomic(addr);
>
>         mark_inode_dirty(inode);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..41ccbfc9dc82 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>                 struct iomap_dio *dio, struct iomap *iomap)
>  {
>         struct iov_iter *iter = dio->submit.iter;
> +       void *inline_data = iomap_inline_data(iomap, pos);
>         size_t copied;
>
> -       BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
> +               return -EIO;
>
>         if (dio->flags & IOMAP_DIO_WRITE) {
>                 loff_t size = inode->i_size;
>
>                 if (pos > size)
> -                       memset(iomap->inline_data + size, 0, pos - size);
> -               copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +                       memset(iomap_inline_data(iomap, size), 0, pos - size);
> +               copied = copy_from_iter(inline_data, length, iter);
>                 if (copied) {
>                         if (pos + copied > size)
>                                 i_size_write(inode, pos + copied);
>                         mark_inode_dirty(inode);
>                 }
>         } else {
> -               copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +               copied = copy_to_iter(inline_data, length, iter);
>         }
>         dio->size += copied;
>         return copied;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e221..b8ec145b2975 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>         return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>
> +/*
> + * Returns the inline data pointer for logical offset @pos.
> + */
> +static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
> +{
> +       return iomap->inline_data + pos - iomap->offset;
> +}
> +
> +/*
> + * Check if the mapping's length is within the valid range for inline data.
> + * This is used to guard against accessing data beyond the page inline_data
> + * points at.
> + */
> +static inline bool iomap_inline_data_valid(struct iomap *iomap)
> +{
> +       return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
> +
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>   * and page_done will be called for each page written to.  This only applies to
> --
> 2.24.4
>

Andreas

