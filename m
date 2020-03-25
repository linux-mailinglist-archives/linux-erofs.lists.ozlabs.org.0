Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFC192B63
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2020 15:43:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nW7x2PcFzDqft
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2020 01:43:25 +1100 (AEDT)
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
 header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=YUccMzib; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nW7p6FV1zDqdp
 for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2020 01:43:15 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id d15so2476106iog.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2020 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BYoi0GgKGrZ5Iy05aE5oc1zP5UUaQTjapju/izAR4hI=;
 b=YUccMzib2IwajwEuyLBHygiEi2x+yWevlxfsequqpaIt/Mza/TxUmFkitS3U4FkfKx
 P1XwXxBJ8Cx5HEmhYoBLdWFHhmr6xou5YR2utppkELKcqyaDd4EOavtJNBW3boLnPkzx
 WgZmdQ9YRsyheNZWEZrba/miSYKYdDAaziYyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BYoi0GgKGrZ5Iy05aE5oc1zP5UUaQTjapju/izAR4hI=;
 b=AifaeMG3DI3GBjOtiD1JygCr3IXcbS+IJfakO3t7eLmi/eS1KUbHTLCYRZyEnsDkx3
 8pv3YeQVQ2BwNeFWOWRow7R0eL1RbZTLIgrJnex3tE79Q+r1w1LJRez2cWRw9UYXYygw
 wBFFru50f31EYF8nszkN3L07/4Yo8L02v0LY8PHrq9w9ri4JtZCtq1xucI2iIRDdIwZT
 5dR3dkO5A67Tl6IKKTrL+y8GE9drYO+yjmDnEWZQ+qZrBMvDJfrd+TcnG/fOP4b1lGfN
 dBt5dYfNdqcVPE+VBcjB/5wF5PS7XIK7ukDB7o1rL9LgTDpRTHL8sPF4uwB9UBYu/UJe
 4DLA==
X-Gm-Message-State: ANhLgQ2i3tJ3WscdCukpwtd8JcvYDykqDR/Kq474GRn/2IecEwmeTRrN
 zTboec5e6qmAKUkHxzyeQ7C7cxUFV4Jm5V0u5+DrYQ==
X-Google-Smtp-Source: ADFU+vsgMMqodCZqPGFNfCT+HdNRTtLLlUdy5AMnDcVBoatxWj+vZY48emoAVNd+HvHliFjTkg/kdF6pmkOGcZxuC6s=
X-Received: by 2002:a6b:3a07:: with SMTP id h7mr3235359ioa.191.1585147393572; 
 Wed, 25 Mar 2020 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
 <20200325120254.GA22483@bombadil.infradead.org>
In-Reply-To: <20200325120254.GA22483@bombadil.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Mar 2020 15:43:02 +0100
Message-ID: <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 1:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 25, 2020 at 10:42:56AM +0100, Miklos Szeredi wrote:
> > > +       while ((page = readahead_page(rac))) {
> > > +               if (fuse_readpages_fill(&data, page) != 0)
> >
> > Shouldn't this unlock + put page on error?
>
> We're certainly inconsistent between the two error exits from
> fuse_readpages_fill().  But I think we can simplify the whole thing
> ... how does this look to you?

Nice, overall.

>
> -       while ((page = readahead_page(rac))) {
> -               if (fuse_readpages_fill(&data, page) != 0)
> +               nr_pages = min(readahead_count(rac), fc->max_pages);

Missing fc->max_read clamp.

> +               ia = fuse_io_alloc(NULL, nr_pages);
> +               if (!ia)
>                         return;
> +               ap = &ia->ap;
> +               __readahead_batch(rac, ap->pages, nr_pages);

nr_pages = __readahead_batch(...)?

This will give consecutive pages, right?

Thanks,
Miklos
