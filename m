Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 933531B0720
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2020 13:14:42 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495PH35WyvzDqdp
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2020 21:14:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=szeredi.hu (client-ip=2a00:1450:4864:20::641;
 helo=mail-ej1-x641.google.com; envelope-from=miklos@szeredi.hu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=szeredi.hu
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=IDveWlOS; 
 dkim-atps=neutral
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495PGz4mcTzDqdZ
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2020 21:14:32 +1000 (AEST)
Received: by mail-ej1-x641.google.com with SMTP id s3so7582884eji.6
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2020 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=okPBkG9vtS/wVdJh/KDIc+hdg6krV+bND5agW6vUaRM=;
 b=IDveWlOS7Tzhrdb36+hZpTST6wjOAPrAj2jj5uib3vbWbabqwzW9IWuAtw8h4eTBNA
 9a9lkdgEJOm6Eb3fwCtOVTxrVmphaH2PGWy9bhlS9QBo4VsFK/CUgj6vV9uyCovU0arA
 5Kj1tMT4D5sNr37XYcPWFQo9UnIzxN1guBg1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=okPBkG9vtS/wVdJh/KDIc+hdg6krV+bND5agW6vUaRM=;
 b=bcics6QPPoFsskz5pcvP0/HrbTqI9EKR6RHwB1qk5Rmgugnstc8RElHkgk91Sjp7pl
 dnMNLVz5p9YzePmDqNJu7x7Zx02SQISlf3i7abGfefLDxuJUmvEkimQ8zJ2jfNsa/KOH
 uwDx9FE9gQeXXodhRDah0NqWqxO2qtTmjp71kU02/pUXdW5pNsuEkZkxdwzU90+a1bon
 VO6XHEWPKaUzWEaXTv6OmzWOup8a9SDpVw2irzgLKI2LrZ76ZmIPF0Fa0V5Zzw/CGVmJ
 kq8wNPGWTuytgnJjGfeYkxTO7D4Dn7jKR70DRIXn/GW53tb2+nE48ywzwoFRTw3jV8+v
 Y0gw==
X-Gm-Message-State: AGi0PuY78UH1GRocWwZDv6f16dA4gQTQ82D/IOqqHmSpT3n82cOio5+o
 7XAZUKdvkXYMzIgY7uZrROF13MfASujzZ/qPp02bHQ==
X-Google-Smtp-Source: APiQypIVhtjPPYqBEymAM1SkD4SYcU1V6bmTKvyt+63wSYT0tOjvuXxym8edoJZS6GcpMs4Nq+7PF2DextVY/K9Ax1g=
X-Received: by 2002:a17:906:841a:: with SMTP id
 n26mr16038100ejx.43.1587381268754; 
 Mon, 20 Apr 2020 04:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-25-willy@infradead.org>
In-Reply-To: <20200414150233.24495-25-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Apr 2020 13:14:17 +0200
Message-ID: <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com>
Subject: Re: [PATCH v11 24/25] fuse: Convert from readpages to readahead
To: Matthew Wilcox <willy@infradead.org>
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
Cc: linux-xfs <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Apr 14, 2020 at 5:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Implement the new readahead operation in fuse by using __readahead_batch()
> to fill the array of pages in fuse_args_pages directly.  This lets us
> inline fuse_readpages_fill() into fuse_readahead().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/fuse/file.c | 99 ++++++++++++++------------------------------------
>  1 file changed, 27 insertions(+), 72 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a..db82fb29dd39 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -915,84 +915,39 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>         fuse_readpages_end(fc, &ap->args, err);
>  }
>
> -struct fuse_fill_data {
> -       struct fuse_io_args *ia;
> -       struct file *file;
> -       struct inode *inode;
> -       unsigned int nr_pages;
> -       unsigned int max_pages;
> -};
> -
> -static int fuse_readpages_fill(void *_data, struct page *page)
> +static void fuse_readahead(struct readahead_control *rac)
>  {
> -       struct fuse_fill_data *data = _data;
> -       struct fuse_io_args *ia = data->ia;
> -       struct fuse_args_pages *ap = &ia->ap;
> -       struct inode *inode = data->inode;
> +       struct inode *inode = rac->mapping->host;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> +       unsigned int i, max_pages, nr_pages = 0;
>
> -       fuse_wait_on_page_writeback(inode, page->index);
> -
> -       if (ap->num_pages &&
> -           (ap->num_pages == fc->max_pages ||
> -            (ap->num_pages + 1) * PAGE_SIZE > fc->max_read ||
> -            ap->pages[ap->num_pages - 1]->index + 1 != page->index)) {
> -               data->max_pages = min_t(unsigned int, data->nr_pages,
> -                                       fc->max_pages);
> -               fuse_send_readpages(ia, data->file);
> -               data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
> -               if (!ia) {
> -                       unlock_page(page);
> -                       return -ENOMEM;
> -               }
> -               ap = &ia->ap;
> -       }
> -
> -       if (WARN_ON(ap->num_pages >= data->max_pages)) {
> -               unlock_page(page);
> -               fuse_io_free(ia);
> -               return -EIO;
> -       }
> -
> -       get_page(page);
> -       ap->pages[ap->num_pages] = page;
> -       ap->descs[ap->num_pages].length = PAGE_SIZE;
> -       ap->num_pages++;
> -       data->nr_pages--;
> -       return 0;
> -}
> -
> -static int fuse_readpages(struct file *file, struct address_space *mapping,
> -                         struct list_head *pages, unsigned nr_pages)
> -{
> -       struct inode *inode = mapping->host;
> -       struct fuse_conn *fc = get_fuse_conn(inode);
> -       struct fuse_fill_data data;
> -       int err;
> -
> -       err = -EIO;
>         if (is_bad_inode(inode))
> -               goto out;
> +               return;
>
> -       data.file = file;
> -       data.inode = inode;
> -       data.nr_pages = nr_pages;
> -       data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
> -;
> -       data.ia = fuse_io_alloc(NULL, data.max_pages);
> -       err = -ENOMEM;
> -       if (!data.ia)
> -               goto out;
> +       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);
>
> -       err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
> -       if (!err) {
> -               if (data.ia->ap.num_pages)
> -                       fuse_send_readpages(data.ia, file);
> -               else
> -                       fuse_io_free(data.ia);
> +       for (;;) {
> +               struct fuse_io_args *ia;
> +               struct fuse_args_pages *ap;
> +
> +               nr_pages = readahead_count(rac) - nr_pages;

Hmm.  I see what's going on here, but it's confusing.   Why is
__readahead_batch() decrementing the readahead count at the start,
rather than at the end?

At the very least it needs a comment about why nr_pages is calculated this way.

> +               if (nr_pages > max_pages)
> +                       nr_pages = max_pages;
> +               if (nr_pages == 0)
> +                       break;
> +               ia = fuse_io_alloc(NULL, nr_pages);
> +               if (!ia)
> +                       return;
> +               ap = &ia->ap;
> +               nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> +               for (i = 0; i < nr_pages; i++) {
> +                       fuse_wait_on_page_writeback(inode,
> +                                                   readahead_index(rac) + i);

What's wrong with ap->pages[i]->index?  Are we trying to wean off using ->index?

Thanks,
Miklos
