Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D43D5A00
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 15:03:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYKqd0mY9z307J
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Jul 2021 23:03:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VETI/bNI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VETI/bNI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=VETI/bNI; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VETI/bNI; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYKqV2Zh4z3068
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 23:03:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627304608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGNIpIsmHVsxBMU4UuRo09+EWFGkpjab3tHKGtaAqJI=;
 b=VETI/bNIjI+DY1843n+Kr23O9DWk3dNS4wpWIecmIs8A7sIQzUYIj9nKFnNJEqMlaPQbUJ
 SG5Inj38NkYlUJIOIuxhfjoX4xlOelTd+8xyn/WgOLEadm8qgh20NmTkYboN5nl6SArAU9
 lZvf8dvx7bI+316+SAUAqAfiaqR+GKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627304608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGNIpIsmHVsxBMU4UuRo09+EWFGkpjab3tHKGtaAqJI=;
 b=VETI/bNIjI+DY1843n+Kr23O9DWk3dNS4wpWIecmIs8A7sIQzUYIj9nKFnNJEqMlaPQbUJ
 SG5Inj38NkYlUJIOIuxhfjoX4xlOelTd+8xyn/WgOLEadm8qgh20NmTkYboN5nl6SArAU9
 lZvf8dvx7bI+316+SAUAqAfiaqR+GKo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-avtfKP0UOwCR-AvOczsDEg-1; Mon, 26 Jul 2021 09:03:26 -0400
X-MC-Unique: avtfKP0UOwCR-AvOczsDEg-1
Received: by mail-wm1-f69.google.com with SMTP id
 j204-20020a1c23d50000b029024e75a15714so2708778wmj.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Jul 2021 06:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IGNIpIsmHVsxBMU4UuRo09+EWFGkpjab3tHKGtaAqJI=;
 b=BjkMK4UWkgg7FAqKDPpft7bHqPfXKeIfC+5gGV27hrbExz0EXrDDKvpcIjZ20f6T3K
 IyssLWXZw++h91IEZpQ//DRqBjA77vf75t5Ku1pOJQ9HsUztn+TvAUP4Um6Ppz6QmDiy
 7roPqJR79jaaSfgghBidhgMcCJpgun1xplonQ70BDRcQR3CvGyu9x3qEYIDjcyFb3PWI
 D6C5ndzSsYBZXVm93MTtVDJNmxRIqHti2RHrwwOMF80lL1GklQcEnpQTcFWZochKPTZr
 3bKk6r+iO8mQwoAZNgqvs7+YZkftFnh+uiwa4ZvuH9N8TGtc2/Em4PAsBFwwzt3lo8iv
 ggFA==
X-Gm-Message-State: AOAM532aNm6SK8CpeAX46+PSiabgPZz6rvjyWZ8PsXcaQreQDp+GX9aV
 gp+T3aHkJQ1F6GfcPqpDNchqbx2JFJo1zHT69JOozyvKEmhPSPNS+sOvsEr3Qi38Tzgm9b+OkD7
 apX6d4Ru/11Y/Yl8/gVhFzI92OoEq4DtbDdS9kFjW
X-Received: by 2002:a1c:2282:: with SMTP id
 i124mr17049207wmi.166.1627304605650; 
 Mon, 26 Jul 2021 06:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzez+Dg/KjFXB2/t8rmE8mp4VEy7yq4UcgU/E1xnbCT/hQKvCXLclyMSKPeyOlhURK+emV0LZWpNj9vRYVNLFM=
X-Received: by 2002:a1c:2282:: with SMTP id
 i124mr17049182wmi.166.1627304605390; 
 Mon, 26 Jul 2021 06:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <YP6rTi/I3Vd+pbeT@casper.infradead.org>
In-Reply-To: <YP6rTi/I3Vd+pbeT@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 26 Jul 2021 15:03:14 +0200
Message-ID: <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To: Matthew Wilcox <willy@infradead.org>
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
Cc: "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 2:33 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 26, 2021 at 01:06:11PM +0200, Andreas Gruenbacher wrote:
> > @@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> >       void *addr;
> >
> >       WARN_ON_ONCE(!PageUptodate(page));
> > -     BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!iomap_inline_data_size_valid(iomap));
> >
> >       flush_dcache_page(page);
> >       addr = kmap_atomic(page);
> > -     memcpy(iomap->inline_data + pos, addr + pos, copied);
> > +     memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> >       kunmap_atomic(addr);
> >
> >       mark_inode_dirty(inode);
>
> Only tangentially related ... why do we memcpy the data into the tail
> at write_end() time instead of at writepage() time?  I see there's a
> workaround for that in gfs2's page_mkwrite():
>
>         if (gfs2_is_stuffed(ip)) {
>                 err = gfs2_unstuff_dinode(ip);
>
> (an mmap store cannot change the size of the file, so this would be
> unnecessary)

Not sure if an additional __set_page_dirty_nobuffers is needed in that
case, but doing the writeback at writepage time should work just as
well. It's just that gfs2 did it at write time historically. The
un-inlining in gfs2_page_mkwrite() could probably also be removed.

I can give this a try, but I'll unfortunately be AFK for the next
couple of days.

> Something like this ...
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..3aeebe899fc5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -665,9 +665,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>         return copied;
>  }
>
> -static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> -               struct iomap *iomap, loff_t pos, size_t copied)
> +static int iomap_write_inline_data(struct inode *inode, struct page *page,
> +               struct iomap *iomap)
>  {
> +       size_t size = i_size_read(inode) - page_offset(page);

You surely mean inode->i_size - iomap->offset.

>         void *addr;
>
>         WARN_ON_ONCE(!PageUptodate(page));
> @@ -675,11 +676,10 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>
>         flush_dcache_page(page);
>         addr = kmap_atomic(page);
> -       memcpy(iomap->inline_data + pos, addr + pos, copied);
> +       memcpy(iomap->inline_data, addr, size);
>         kunmap_atomic(addr);
>
> -       mark_inode_dirty(inode);
> -       return copied;
> +       return 0;
>  }
>
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> @@ -691,9 +691,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>         loff_t old_size = inode->i_size;
>         size_t ret;
>
> -       if (srcmap->type == IOMAP_INLINE) {
> -               ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> -       } else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> +       if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>                 ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>                                 page, NULL);
>         } else {
> @@ -1314,6 +1312,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>
>         WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>
> +       if (wpc->iomap.type == IOMAP_INLINE)
> +               return iomap_write_inline_data(inode, page, iomap);
> +
>         /*
>          * Walk through the page to find areas to write back. If we run off the
>          * end of the current map or find the current map invalid, grab a new
> @@ -1328,8 +1329,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>                 error = wpc->ops->map_blocks(wpc, inode, file_offset);
>                 if (error)
>                         break;
> -               if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
> -                       continue;
>                 if (wpc->iomap.type == IOMAP_HOLE)
>                         continue;
>                 iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
>

Thanks,
Andreas

