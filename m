Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3C43D768
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 01:17:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hfl3T2g1Yz3dfm
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 10:17:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=REyhBK6t;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::1030;
 helo=mail-pj1-x1030.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=REyhBK6t; dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hfkjs0vZ4z3clL
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 10:02:38 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id
 na16-20020a17090b4c1000b0019f5bb661f9so3256269pjb.0
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TIqjtDMduKwUTBKX+tBygnWIDjEpMEr2bhy/yT20mZY=;
 b=REyhBK6tQZDsAnyKckv+GTqli7ewznlsn87vyBbY5f9febMQ9OwtuAQWJhdicQr38K
 K1RmGd24wmhycGjPGNyFLV1NcRjXV0YOMJgCvWwD1u2op9FVS5Ne01Ma8I3/7N/vKG+L
 Nf/tcy6ZTKg9EdZlESmgy/KdDpwwSItb4MeferFvOhl0fHKDs4iLoNdhifCWx1/jKI7k
 we4R1sn71TU5C2vgTscBN2f7yTZYEbFO4nfi+2G6AAM+9u32OYSh0jX2w1H4FzdcM3Ry
 12G6L2JWGDbLkKio2wNGWYlGKXiSVAEj+xqYbUihB4TpfsaefQ6c0TKQ0AY7vxbKpFnC
 uryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TIqjtDMduKwUTBKX+tBygnWIDjEpMEr2bhy/yT20mZY=;
 b=smBe3cYQp360H0U3UtgHKpFBkg/D1E1/abHcKN4GqvJhltHY6zhO3iOLdUPE4VkhLQ
 hb34B41Tl0rUYBlqwAjGws3JuHDMUMZ5k1iLY1ZxtoC9+oqYXdPLtJqF61E8+mrOL4Y4
 QpzdDYqkkKHihA0qtsf/yENG4rYS7s7okLLpq5IIMk9ylPVUS7nQsgY1541Jar2mv1u7
 ziCHRM+5dbdxswhPx4wxEeqK23WE2N4qBK5C8mlmgkfVqylqUzPAR2GcA8E6ahSWv+tN
 0qB28ySmp/koeWllqtUnH3CZp+G7h8JfltZq727BA6puhgu2iY3cuW4DZT8pNy/yDu/1
 FZCg==
X-Gm-Message-State: AOAM532MvCli1M8Vvi65yAOIa8YaA8egD5pzCdUheVU9+BFnn06x2/ot
 h/cNfq7LhGq+hZMOPbd0Rr5ODKqrJ12b4IvW+bjTjA==
X-Google-Smtp-Source: ABdhPJxUwYpsZPDBKuNiovYR0U6XMhxIiDSjLBJJ1e6zz5gkWe8hCvGUK6ph3bxfDtcB6AFtR1bn5v1MGpOhiVcMhIY=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr8858216pjp.8.1635375753946; 
 Wed, 27 Oct 2021 16:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-5-hch@lst.de>
In-Reply-To: <20211018044054.1779424-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 16:02:22 -0700
Message-ID: <CAPcyv4gUU1D25XSY32oDEbpLXRCvQ_q34sL86xmQ_cH0q5PjZQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] dax: remove the pgmap sanity checks in
 generic_fsdax_supported
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
> Drivers that register a dax_dev should make sure it works, no need
> to double check from the file system.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 49 +--------------------------------------------
>  1 file changed, 1 insertion(+), 48 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 9383c11b21853..04fc680542e8d 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -107,13 +107,9 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 struct block_device *bdev, int blocksize, sector_t start,
>                 sector_t sectors)
>  {
> -       bool dax_enabled = false;
>         pgoff_t pgoff, pgoff_end;
> -       void *kaddr, *end_kaddr;
> -       pfn_t pfn, end_pfn;
>         sector_t last_page;
> -       long len, len2;
> -       int err, id;
> +       int err;
>
>         if (blocksize != PAGE_SIZE) {
>                 pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
> @@ -138,49 +134,6 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
>                 return false;
>         }
>
> -       id = dax_read_lock();
> -       len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
> -       len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
> -
> -       if (len < 1 || len2 < 1) {
> -               pr_info("%pg: error: dax access failed (%ld)\n",
> -                               bdev, len < 1 ? len : len2);
> -               dax_read_unlock(id);
> -               return false;
> -       }
> -
> -       if (IS_ENABLED(CONFIG_FS_DAX_LIMITED) && pfn_t_special(pfn)) {
> -               /*
> -                * An arch that has enabled the pmem api should also
> -                * have its drivers support pfn_t_devmap()
> -                *
> -                * This is a developer warning and should not trigger in
> -                * production. dax_flush() will crash since it depends
> -                * on being able to do (page_address(pfn_to_page())).
> -                */
> -               WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
> -               dax_enabled = true;
> -       } else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
> -               struct dev_pagemap *pgmap, *end_pgmap;
> -
> -               pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
> -               end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> -               if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
> -                               && pfn_t_to_page(pfn)->pgmap == pgmap
> -                               && pfn_t_to_page(end_pfn)->pgmap == pgmap
> -                               && pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
> -                               && pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))

This is effectively a self-test for a regression that was found while
manipulating the 'struct page' memmap metadata reservation for PMEM
namespaces.

I guess it's just serving as a security-blanket now and I should find
a way to move it out to a self-test. I'll take a look.

> -                       dax_enabled = true;
> -               put_dev_pagemap(pgmap);
> -               put_dev_pagemap(end_pgmap);
> -
> -       }
> -       dax_read_unlock(id);
> -
> -       if (!dax_enabled) {
> -               pr_info("%pg: error: dax support not enabled\n", bdev);
> -               return false;
> -       }
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> --
> 2.30.2
>
