Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6643D769
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 01:18:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hfl3W6mzCz3dfm
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 10:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=d6phRBLS;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::1033;
 helo=mail-pj1-x1033.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=d6phRBLS; dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfkqD6M0jz3f3K
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 10:07:20 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id
 k2-20020a17090ac50200b001a218b956aaso3229156pjt.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
 b=d6phRBLSNqEavLbFGa7qsltfCwCXOIkQGNewJdYfiMwINhHDbJ+v3Tvr+m7SXCKglh
 f1Y9JyoYsY7pru2o0qaf9ZrRobsN47Jue96kM8PwOADE6VAIkbXtDJTZy+mzrce1H5ii
 TDWfFC/E9fe8cXOG72hb4HndsLJ5qovtA1WXr8x1UXXNXsg6OU7/y9sWKZsB9Ro8FzaF
 3kotXlCmovzhrPQGnkvqh1aQ4+kBEwqSKMSlKnEz5Ahj4QsLMDMTI4jX5+IsmEJsZDOu
 D4ACx/M3ONMf14xOrt8n/jVyvHMKdyB04vPcp4aB9RBAawLg1e2wm7UXNUEREJEycjA9
 pSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3af0vrDw+XvQKylIm0LDLH9D6xoJ74LhsidYuXkOM7g=;
 b=xS2OKGWDJGi4F6sUp0fe90wc/wZ9LdGNe6bfY4JJ1vhJu81RWchRqzFINHF/5DL9Vt
 rI7O4LM6XJ7NB35ayPUurNzuQS6wBOavkMx8Oum/YgWzcsGPiGGhfC7Y+1DBvABi3mj0
 1DvngP0LcqdOM/Vl/gU8QL3RhJMZ3p12ZhIyto9Qb4wfBjXJ/ZuSWqkqSIPP1U3D4leG
 xbIDd3LeNmO5Kn5JkYR6rkBbYBWkO147rqVVJqUUlG43ijbt6esC2jbbVwaICLewcV5g
 brx8AGeTUcEgNtT07TztPVHxUoTnokElKLAjezACvL9ECS0FHesuUJlrkI7Xqhq30TYX
 MWoA==
X-Gm-Message-State: AOAM5331J0ESCxRGc+M4tgDmLk4tTTF3eo+jw2Vew8dxCwOyevgBxKXU
 u8SanhWWr1WgnYnbbrr59LrydC3A+Ak+77f0Q/v94g==
X-Google-Smtp-Source: ABdhPJxTOfk9fcqxHjqgG3f1vnNsNPlrTHxqnz6/LIE7U1wpYxfkWo7JAy9TqN/B72HDrJA9DjHrJAEIhgWs2Md2+FA=
X-Received: by 2002:a17:90b:350f:: with SMTP id
 ls15mr618659pjb.220.1635376038542; 
 Wed, 27 Oct 2021 16:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-6-hch@lst.de>
In-Reply-To: <20211018044054.1779424-6-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 16:07:07 -0700
Message-ID: <CAPcyv4iqkLQWEyqRYZPaBmA=bXyJy5DR699ch+wfBanY-MKu9g@mail.gmail.com>
Subject: Re: [PATCH 05/11] dax: move the partition alignment check into
 fs_dax_get_by_bdev
To: Christoph Hellwig <hch@lst.de>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> fs_dax_get_by_bdev is the primary interface to find a dax device for a
> block device, so move the partition alignment check there instead of
> wiring it up through ->dax_supported.

Looks good.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 04fc680542e8d..482fe775324a4 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -93,6 +93,12 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
>         if (!blk_queue_dax(bdev->bd_disk->queue))
>                 return NULL;
>
> +       if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> +           (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> +               return NULL;
> +       }
> +
>         id = dax_read_lock();
>         dax_dev = xa_load(&dax_hosts, (unsigned long)bdev->bd_disk);
>         if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
> @@ -107,10 +113,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 struct block_device *bdev, int blocksize, sector_t start,
>                 sector_t sectors)
>  {
> -       pgoff_t pgoff, pgoff_end;
> -       sector_t last_page;
> -       int err;
> -
>         if (blocksize != PAGE_SIZE) {
>                 pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
>                 return false;
> @@ -121,19 +123,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 return false;
>         }
>
> -       err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
> -       last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
> -       err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
> -       if (err) {
> -               pr_info("%pg: error: unaligned partition for dax\n", bdev);
> -               return false;
> -       }
> -
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> --
> 2.30.2
>
