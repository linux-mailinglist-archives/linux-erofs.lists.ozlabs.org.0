Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184F3D9C6A
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 05:55:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZxWb18vjz30DH
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jul 2021 13:55:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ar04ruK8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ar04ruK8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ar04ruK8; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ar04ruK8; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZxWT0X0Wz2ypn
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jul 2021 13:55:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627530910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uC1FHB6Ltwg9aVPHNYZs7xQhWoFRsts5ruZx40NQ+EI=;
 b=ar04ruK8NJdtw+cHgyMLruRMdwBt75eSzHSTu5f0/yd4r+bjaKDYbSynr6f7FzuKX7Ld21
 dJ+1RbCSQeGymab9eg7Mn+fOFYE4iD26aoyz6y11Nx1GVF9VP5+gyHYPPtdtTK+WxYE/m/
 jW/2qH5TQzYoGNTEYvNT8AOQUM3tDEA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627530910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uC1FHB6Ltwg9aVPHNYZs7xQhWoFRsts5ruZx40NQ+EI=;
 b=ar04ruK8NJdtw+cHgyMLruRMdwBt75eSzHSTu5f0/yd4r+bjaKDYbSynr6f7FzuKX7Ld21
 dJ+1RbCSQeGymab9eg7Mn+fOFYE4iD26aoyz6y11Nx1GVF9VP5+gyHYPPtdtTK+WxYE/m/
 jW/2qH5TQzYoGNTEYvNT8AOQUM3tDEA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-OZfOzPrvPrK1Z3XsaXZp7g-1; Wed, 28 Jul 2021 23:55:08 -0400
X-MC-Unique: OZfOzPrvPrK1Z3XsaXZp7g-1
Received: by mail-wr1-f70.google.com with SMTP id
 n6-20020a5d67c60000b0290153b1422916so1726867wrw.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jul 2021 20:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uC1FHB6Ltwg9aVPHNYZs7xQhWoFRsts5ruZx40NQ+EI=;
 b=so57IekUUCoMObCJBYT8ZgVC0mFmkknHJPzGzFuaRJs28Mn5P5yFRUP5Usqm8lm/Ww
 jVl3xwoo9D3PWwCY/8W9fxSBUhclGgSWYKF517UG843rFsacjE9hYy5adng7PI4Eb+eV
 +UiV6rBQdez+ppJwRyMpZheWjOMqHMAG4Zhb/FBE61RJf9tPOASfXSSB/nwse+RkPFWM
 WeNyUOpWGkE3cdAF2iglaQZhIWUT46A2tU5b2tJZttWl+82LHWsrYhSynraOOAT2Aa5l
 Rz/lII+gqo/IuoH1OW9cEuNAjU/c06TIaHDjTM9LdYTXs4crqJgBryNrU6F8DDVazV1e
 uelw==
X-Gm-Message-State: AOAM5315Rt+ZpGWaess5/jkHBmf2MXplnJMkdaN8s0WOnxulHA0IhqOR
 2FBJhqrpDAC7zPLIA3tCRYWoH/I+k74fGRpIPx5zV1or/jET/FmhzunR87kdJZ/yhMgxVH5An/V
 90k2QG44zUDaUFsVsrcsf8TEIuJOTX5qOg4Bd27eI
X-Received: by 2002:a5d:5286:: with SMTP id c6mr2341666wrv.357.1627530907743; 
 Wed, 28 Jul 2021 20:55:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyByMIX137ZLqJJiCVTQnxk6c1FnVSkm2nYKBkgw1Xej+SqUPl31fRTeEFWaBx/7Iuv8c60B/3IRkYVbRouDJo=
X-Received: by 2002:a5d:5286:: with SMTP id c6mr2341654wrv.357.1627530907583; 
 Wed, 28 Jul 2021 20:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729032344.3975412-1-willy@infradead.org>
In-Reply-To: <20210729032344.3975412-1-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Jul 2021 05:54:56 +0200
Message-ID: <CAHc6FU5E9AdiH7SnfADteOVdttNFGO1EN0PoiYYVyaftCJ1Mqw@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: Support inline data with block size < page size
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jul 29, 2021 at 5:25 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Remove the restriction that inline data must start on a page boundary
> in a file.  This allows, for example, the first 2KiB to be stored out
> of line and the trailing 30 bytes to be stored inline.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2:
>  - Rebase on top of iomap: Support file tail packing v9
>
>  fs/iomap/buffered-io.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 66b733537c46..50f18985ed13 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -209,28 +209,26 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
>                 struct iomap *iomap)
>  {
>         size_t size = i_size_read(inode) - iomap->offset;
> +       size_t poff = offset_in_page(iomap->offset);
>         void *addr;
>
>         if (PageUptodate(page))
> -               return 0;
> +               return PAGE_SIZE - poff;
>
> -       /* inline data must start page aligned in the file */
> -       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> -               return -EIO;

Maybe add a WARN_ON_ONCE(size > PAGE_SIZE - poff) here?

>         if (WARN_ON_ONCE(size > PAGE_SIZE -
>                          offset_in_page(iomap->inline_data)))
>                 return -EIO;
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
> -       if (WARN_ON_ONCE(page_has_private(page)))
> -               return -EIO;
> +       if (poff > 0)
> +               iomap_page_create(inode, page);
>
> -       addr = kmap_atomic(page);
> +       addr = kmap_atomic(page) + poff;

Maybe kmap_local_page?

>         memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - size);
> +       memset(addr + size, 0, PAGE_SIZE - poff - size);
>         kunmap_atomic(addr);
> -       SetPageUptodate(page);
> -       return 0;
> +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> +       return PAGE_SIZE - poff;
>  }
>
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -252,13 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         unsigned poff, plen;
>         sector_t sector;
>
> -       if (iomap->type == IOMAP_INLINE) {
> -               int ret = iomap_read_inline_data(inode, page, iomap);
> -
> -               if (ret)
> -                       return ret;
> -               return PAGE_SIZE;
> -       }
> +       if (iomap->type == IOMAP_INLINE)
> +               return iomap_read_inline_data(inode, page, iomap);
>
>         /* zero post-eof blocks as the page may be mapped */
>         iop = iomap_page_create(inode, page);
> @@ -593,10 +586,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>  static int iomap_write_begin_inline(struct inode *inode,
>                 struct page *page, struct iomap *srcmap)
>  {
> +       int ret;
> +
>         /* needs more work for the tailpacking case, disable for now */
>         if (WARN_ON_ONCE(srcmap->offset != 0))
>                 return -EIO;
> -       return iomap_read_inline_data(inode, page, srcmap);
> +       ret = iomap_read_inline_data(inode, page, srcmap);
> +       if (ret < 0)
> +               return ret;
> +       return 0;
>  }
>
>  static int
> --
> 2.30.2
>

Thanks,
Andreas

