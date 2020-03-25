Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01846192D84
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 16:55:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nXkc6dzFzDqd0
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 02:55:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=szeredi.hu (client-ip=2607:f8b0:4864:20::d42;
 helo=mail-io1-xd42.google.com; envelope-from=miklos@szeredi.hu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="key not found in DNS" header.d=szeredi.hu
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=PotvV1Ev; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nXkW6DhjzDqHp
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2020 02:54:56 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id d15so2752837iog.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WUvTsX9+jdPoLTOSHShSbaoohqGvLnmJWJx3goFYuLM=;
 b=PotvV1Ev6OzVSaF6m2X5tC6JwxVWHxAGf6FLW8AjKTGJyK/QJ8dyn6xJiqfkSFaAqz
 OCdtBX9daql7+1gX8+5dT3S5uMqemNZ36FP4ZPoQpwuOHn42a4uh+PVPR7d5d59NuA3a
 t2/cRclIFAps/zNhsd7jyIV2vHIEY2rkQ4dM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WUvTsX9+jdPoLTOSHShSbaoohqGvLnmJWJx3goFYuLM=;
 b=jNHji5hiYo32ZZRigZ23ByVhBlHmFiRMVb0hwNab3svK+SPMrQ6Fw1hmBGZCAiwDUB
 wlzHqtgVhuT78H/i6qonQ/leaAweXpfbRYni7u+rQShp6nYuqCASyWZnK+idtgkAyFBG
 XQIwvMEtBTC1L52aWo4wP9dl53OE0qLs7/seDxHz+haJDaoWoY6eRe2RqrSjfx95G85M
 WHiidlieDZ+XqPNrxDMXN1UinrZm1/jrjDxA0Hv1NWvg5ih6MorkrqpKePs5XfsWfoKV
 64sC5O+9dlpL7MXjWq/T8QirAh35mUIerkEM3zROWEdmIuvIWmx26zAWq8sYUfoMhLu3
 jYFQ==
X-Gm-Message-State: ANhLgQ1Y5kBD2X+IZ3zyW1HwWlkoLgTcS7qMWoRAxv3mUflXcOvEuwCz
 j4aTq+A+80A+Tw33bCDtw27UGujo/OrBv/o1C/pPPA==
X-Google-Smtp-Source: ADFU+vtWPrSX9gO9pLLxpavehCkl/CaKr8w3OI8WID1sZHiGcDBmq2nlMdLwxJGUo5kQXivDvVBrGhSFup9s33zQy+o=
X-Received: by 2002:a5d:9142:: with SMTP id y2mr3418704ioq.185.1585151694868; 
 Wed, 25 Mar 2020 08:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
 <20200325120254.GA22483@bombadil.infradead.org>
 <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
 <20200325153228.GB22483@bombadil.infradead.org>
In-Reply-To: <20200325153228.GB22483@bombadil.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Mar 2020 16:54:43 +0100
Message-ID: <CAJfpegtrhGamoSqD-3Svfj3-iTdAbfD8TP44H_o+HE+g+CAnCA@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 4:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 25, 2020 at 03:43:02PM +0100, Miklos Szeredi wrote:
> > >
> > > -       while ((page = readahead_page(rac))) {
> > > -               if (fuse_readpages_fill(&data, page) != 0)
> > > +               nr_pages = min(readahead_count(rac), fc->max_pages);
> >
> > Missing fc->max_read clamp.
>
> Yeah, I realised that.  I ended up doing ...
>
> +       unsigned int i, max_pages, nr_pages = 0;
> ...
> +       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);
>
> > > +               ia = fuse_io_alloc(NULL, nr_pages);
> > > +               if (!ia)
> > >                         return;
> > > +               ap = &ia->ap;
> > > +               __readahead_batch(rac, ap->pages, nr_pages);
> >
> > nr_pages = __readahead_batch(...)?
>
> That's the other bug ... this was designed for btrfs which has a fixed-size
> buffer.  But you want to dynamically allocate fuse_io_args(), so we need to
> figure out the number of pages beforehand, which is a little awkward.  I've
> settled on this for the moment:
>
>         for (;;) {
>                struct fuse_io_args *ia;
>                 struct fuse_args_pages *ap;
>
>                 nr_pages = readahead_count(rac) - nr_pages;
>                 if (nr_pages > max_pages)
>                         nr_pages = max_pages;
>                 if (nr_pages == 0)
>                         break;
>                 ia = fuse_io_alloc(NULL, nr_pages);
>                 if (!ia)
>                         return;
>                 ap = &ia->ap;
>                 __readahead_batch(rac, ap->pages, nr_pages);
>                 for (i = 0; i < nr_pages; i++) {
>                         fuse_wait_on_page_writeback(inode,
>                                                     readahead_index(rac) + i);
>                         ap->descs[i].length = PAGE_SIZE;
>                 }
>                 ap->num_pages = nr_pages;
>                 fuse_send_readpages(ia, rac->file);
>         }
>
> but I'm not entirely happy with that either.  Pondering better options.

I think that's fine.   Note how the original code possibly
over-allocates the the page array, because it doesn't know the batch
size beforehand.  So this is already better.

>
> > This will give consecutive pages, right?
>
> readpages() was already being called with consecutive pages.  Several
> filesystems had code to cope with the pages being non-consecutive, but
> that wasn't how the core code worked; if there was a discontiguity it
> would send off the pages that were consecutive and start a new batch.
>
> __readahead_batch() can't return fewer than nr_pages, so you don't need
> to check for that.

That's far from obvious.

I'd put a WARN_ON at least to make document the fact.

Thanks,
Miklos
