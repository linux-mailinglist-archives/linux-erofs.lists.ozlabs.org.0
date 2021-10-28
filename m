Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F143D8BF
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 03:41:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfpF90kTqz2yLg
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 12:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=GwABTqD6;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=GwABTqD6; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfpF53f6Cz2xg3
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 12:41:28 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id gn3so3509464pjb.0
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
 b=GwABTqD6Tkvmyhn2eav2yJwtbW1tJceyJOpR55oElF8Cpl62Tl7fpwDRJSoK85tktg
 WcSZzYI1J3gqZuBvcpDIMaP3fjxWgAXp2/71GNnfMTHJUKsW82nQtl3PxcHMw5XB0BGj
 ol0Z6vrOct/ohRKJEQ4971tC4ghv27sixDbbqgpjArwG9QA0di/1K6lcnuWx54KE2Iv0
 PlLdrGzgfAPZa89z4zZVquTUHRBE3n1XFA2eZslunyTMpQ/h+DaZ/H5bzksM/u3SBYyF
 eGC2TY3oTZ8dh7yBcSfW5yNsChH5J+OrCKaL/dFJg1o9GeZbeU8dYWzE/mMch4zQe8Vr
 Evvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
 b=T7Wx2i/9g4mBknDN/FCaOBgGd6OkzmiQnePFLEI6PV2+dJ/ED0569kTMlVhIVpe82h
 9XjjWL+QBCGeP1EEjiLVvIuT9FSIUotpwxuzDIxn05r+LKeYVP8Mr3q+Jdz5vW5GnpYA
 WDXWFgU7VilVUGhu0f76lpvftcOObWBKCixB72m4H+Vnjb4alJa5qUNtz+PG02ldqYqK
 fMxfssH/6LE2cUsoOqwrd7bWW1It3mbWhpTIdLoRKZAW38VjHj6oQ7JizRhCB1akw1pH
 1SG8nOn0l1peNRyEMSFj4rg6kOvq3zUpnHpmivbIpZ6LRmjuXJaAHTfLoDJYY9pXRRQC
 vjEA==
X-Gm-Message-State: AOAM530xQdXTknROpMF+WCJawV10qdFSnkzvOi7VQn2rpWHsaPlbQSje
 sT/3GwIy9n19pZ5ZJ+gHupk3CNU/ltif7INu4pqAaw==
X-Google-Smtp-Source: ABdhPJy+l4+hDjjFqjiYrNzY24jHwGCV82yPyLMD7+lqHF6GqMdOIsbo6sHeOhaMgqSlqL4IZjgKI/J2hsCPQtYDPIA=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr995386plb.89.1635385285322; Wed, 27
 Oct 2021 18:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-11-hch@lst.de>
In-Reply-To: <20211018044054.1779424-11-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 18:41:13 -0700
Message-ID: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
To: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
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
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.

Again, looks good. Kind of embarrassing when the open-coded version is
less LOC than using the helper.

Mike, ack?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-stripe.c | 63 ++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index f084607220293..50dba3f39274c 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -301,83 +301,50 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
>  }
>
>  #if IS_ENABLED(CONFIG_FS_DAX)
> -static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
>         struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
>         struct block_device *bdev;
> +       sector_t dev_sector;
>         uint32_t stripe;
> -       long ret;
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> +       stripe_map_sector(sc, *pgoff * PAGE_SECTORS, &stripe, &dev_sector);
>         dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
>         bdev = sc->stripe[stripe].dev->bdev;
>
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
> -       if (ret)
> -               return ret;
> +       *pgoff = (get_start_sect(bdev) + dev_sector) >> PAGE_SECTORS_SHIFT;
> +       return sc->stripe[stripe].dev->dax_dev;
> +}
> +
> +static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> +               long nr_pages, void **kaddr, pfn_t *pfn)
> +{
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
> +
>         return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
>  }
>
>  static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
>                                       size_t nr_pages)
>  {
> -       int ret;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> -
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> -       if (ret)
> -               return ret;
>         return dax_zero_page_range(dax_dev, pgoff, nr_pages);
>  }
>
> --
> 2.30.2
>
