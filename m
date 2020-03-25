Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB419246D
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 10:43:25 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nNTk1yqkzDqjh
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 20:43:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=szeredi.hu (client-ip=2607:f8b0:4864:20::142;
 helo=mail-il1-x142.google.com; envelope-from=miklos@szeredi.hu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=szeredi.hu
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=DMyiJnaz; 
 dkim-atps=neutral
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nNTc0pC0zDqJ1
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 20:43:10 +1100 (AEDT)
Received: by mail-il1-x142.google.com with SMTP id r5so1221355ilq.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WJC80u+Ifj4HCTJaBhCcmeQxlknM9aDMikhj5e78Hk4=;
 b=DMyiJnazMqjl2qfzafo7tIFEtefoZjrSvPvqu5sHfAPRBEZ/A1uRJU7icYztbxoEQB
 g5CF3/s4HPa6oNzbsswDGOeOH6b8cPtSAM9SODfnMoawOYaqGUMD64MMEV4CyYGxaNCK
 u3cNVaqIoy9X6Y4p8jTdkYJcnnoetQuPBsAYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WJC80u+Ifj4HCTJaBhCcmeQxlknM9aDMikhj5e78Hk4=;
 b=qgKrCCzTFekCSPyUFpSrpheWhZlIqPFCh1seIMRzJ32MbZgN+Cvd84bxqvFowKPHxE
 wyYxeLNNb/D8SJme6HryNhICB5dGSILCz0+s/kI+oQ5HYqQTvfox2H12kUTXTYEYhJV6
 NN/QoseUMYkp4AezwYXxW6I8pyA96R9fPjzYC3GfqkCmrl2OSm4a2VvUjqSaRkFmC3Tu
 p9xDY1hWLVckPuzX/zFzjXwOambDWJRceV54+7heH2qNhK6w3ot0wdZEnTDcVe+EM/J0
 a42KdXCO1ySfXtuT6Ll00KvqiVw1MIukPdYwNc+lElUHinpAp0w8nrt991Sq/gwnHNHz
 MHDg==
X-Gm-Message-State: ANhLgQ3YG4lIrCNw6fBbN0gWdgsNZBT3HKgHi9efsZ4U2SRf41Pd3gVD
 bY0PMHZeF7WU6QxJd5nlNzB6LRX4v9dfn4/qgmb3CQ==
X-Google-Smtp-Source: ADFU+vsgfIWqTVfFvZZGiDAww03tclKMezpcFsmTHkThxRNJbwZiwKmblFARFxQj+PxAwoovscn7WyTAXThKOCyBwVE=
X-Received: by 2002:a92:9fd0:: with SMTP id z77mr2593848ilk.257.1585129387289; 
 Wed, 25 Mar 2020 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
In-Reply-To: <20200323202259.13363-25-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Mar 2020 10:42:56 +0100
Message-ID: <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
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

On Mon, Mar 23, 2020 at 9:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in fuse.  Switching away from the
> read_cache_pages() helper gets rid of an implicit call to put_page(),
> so we can get rid of the get_page() call in fuse_readpages_fill().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/fuse/file.c | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a..5749505bcff6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -923,9 +923,8 @@ struct fuse_fill_data {
>         unsigned int max_pages;
>  };
>
> -static int fuse_readpages_fill(void *_data, struct page *page)
> +static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
>  {
> -       struct fuse_fill_data *data = _data;
>         struct fuse_io_args *ia = data->ia;
>         struct fuse_args_pages *ap = &ia->ap;
>         struct inode *inode = data->inode;
> @@ -941,10 +940,8 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>                                         fc->max_pages);
>                 fuse_send_readpages(ia, data->file);
>                 data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
> -               if (!ia) {
> -                       unlock_page(page);
> +               if (!ia)
>                         return -ENOMEM;
> -               }
>                 ap = &ia->ap;
>         }
>
> @@ -954,7 +951,6 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>                 return -EIO;
>         }
>
> -       get_page(page);
>         ap->pages[ap->num_pages] = page;
>         ap->descs[ap->num_pages].length = PAGE_SIZE;
>         ap->num_pages++;
> @@ -962,37 +958,33 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>         return 0;
>  }
>
> -static int fuse_readpages(struct file *file, struct address_space *mapping,
> -                         struct list_head *pages, unsigned nr_pages)
> +static void fuse_readahead(struct readahead_control *rac)
>  {
> -       struct inode *inode = mapping->host;
> +       struct inode *inode = rac->mapping->host;
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_fill_data data;
> -       int err;
> +       struct page *page;
>
> -       err = -EIO;
>         if (is_bad_inode(inode))
> -               goto out;
> +               return;
>
> -       data.file = file;
> +       data.file = rac->file;
>         data.inode = inode;
> -       data.nr_pages = nr_pages;
> -       data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
> -;
> +       data.nr_pages = readahead_count(rac);
> +       data.max_pages = min_t(unsigned int, data.nr_pages, fc->max_pages);
>         data.ia = fuse_io_alloc(NULL, data.max_pages);
> -       err = -ENOMEM;
>         if (!data.ia)
> -               goto out;
> +               return;
>
> -       err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
> -       if (!err) {
> -               if (data.ia->ap.num_pages)
> -                       fuse_send_readpages(data.ia, file);
> -               else
> -                       fuse_io_free(data.ia);
> +       while ((page = readahead_page(rac))) {
> +               if (fuse_readpages_fill(&data, page) != 0)

Shouldn't this unlock + put page on error?

Otherwise looks good.

Thanks,
Miklos
