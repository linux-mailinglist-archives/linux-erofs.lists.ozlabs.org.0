Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3243D8D5
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 03:44:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfpJX5VLPz2yKZ
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 12:44:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NwrWjK1z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=NwrWjK1z; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfpJT5L3xz2xB0
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 12:44:18 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 q2-20020a17090a2e0200b001a0fd4efd49so4367491pjd.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 18:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
 b=NwrWjK1zEgkC/h0OltkWmV8v6U9kycWNkAzFyZ2UqlXn15yubZLd83LVcZWNlLL1f0
 Fv5BW1FJAtxuVzU9kXByXaxfMtmiH5UDaukXhF9R+cJyfOGMfQT6zf04USpHM9TDLMLF
 8zm7+00diA9rU2lDu/DTfvUOEu2zCMioGVYImhjXSkJTydRCIKV9cRbUQapJjcrGiqMK
 QnZf8nIfPhTNHOoqGDCmmZuYu6PaW3nbxj784zhi1I6uIMMPp2z6oTqTZJk+LfG12Qzb
 jA/Y5wJffgH2J2qLufj0bLW03BgfGI/buoZEjp4mtmSwLrMRhWqThDSfNCSg+TsSc0DH
 V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X1wiwLbjvMr0fUU/Ik7bpLL2xq562nKRBks78M/tbQ0=;
 b=0nr6aJNjP9zaFmzuBUsIWjj233VebrY3HZWv55OQj6rv4nNnoDU0KJxvaUT9UtATJ+
 BR+nUGjSguxg87gvPhpqMlnYEsdeVTVJNqxv7/bQiLUL60F/gE3PnpWnSSIefksg9+T/
 5U0NvmbxvK9fgJ2wF6LJaToMVXp+R21+MtrFU0dhAi8nRXuBtB5n046dpXgNOjk++5vP
 gMpsmkhHTxhe2cW7b9eeIjUdZw9Ivqzr12wAnxnmw7/zStA6u68donDhrdoUJ0tQMDHv
 yvZFf0mbdFOVwKZenhNyBlNM+rxGz1sIrhPbm2T9Na5btJ4TntzzqCgmpP5xCsS0H82t
 fuGw==
X-Gm-Message-State: AOAM531sojONAtD2MeoXM9UhTp2++A1zglrdnncly+fd/XUEE7Ovrenu
 dZtAMMA8AbHk1ox40vlUzQqVzk++XBTlyonGsGpt0Q==
X-Google-Smtp-Source: ABdhPJyk8c8xZHfkX0RONmluScnz61A4HGhWerdM4JYgASaD4FzedQ2nCFUwr5W/5xCzT57VlrSOf0tWDKABqHHbWT8=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr1240292plo.4.1635385456643; Wed, 27 Oct
 2021 18:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-12-hch@lst.de>
In-Reply-To: <20211018044054.1779424-12-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Oct 2021 18:44:04 -0700
Message-ID: <CAPcyv4ht6fZOdx4YN9FRCnmD2Wy4zzG7nJPQSdSPAgvZNHxoFw@mail.gmail.com>
Subject: Re: [PATCH 11/11] dax: move bdev_dax_pgoff to fs/dax.c
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
> No functional changet, but this will allow for a tighter integration

s/changet/changes/

> with the iomap code, including possible passing the partition offset

s/possible/possibly/

> in the iomap in the future.  For now it mostly avoids growing more

s/now/now,/

...all of the above fixed up locally.

Other than that, it looks good to me.

> callers outside of fs/dax.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 14 --------------
>  fs/dax.c            | 13 +++++++++++++
>  include/linux/dax.h |  1 -
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 803942586d1b6..c0910687fbcb2 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -67,20 +67,6 @@ void dax_remove_host(struct gendisk *disk)
>  }
>  EXPORT_SYMBOL_GPL(dax_remove_host);
>
> -int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> -               pgoff_t *pgoff)
> -{
> -       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> -       phys_addr_t phys_off = (start_sect + sector) * 512;
> -
> -       if (pgoff)
> -               *pgoff = PHYS_PFN(phys_off);
> -       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> -               return -EINVAL;
> -       return 0;
> -}
> -EXPORT_SYMBOL(bdev_dax_pgoff);
> -
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a916..eb715363fd667 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -709,6 +709,19 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>         return __dax_invalidate_entry(mapping, index, false);
>  }
>
> +static int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> +               pgoff_t *pgoff)
> +{
> +       sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> +       phys_addr_t phys_off = (start_sect + sector) * 512;
> +
> +       if (pgoff)
> +               *pgoff = PHYS_PFN(phys_off);
> +       if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
> +               return -EINVAL;
> +       return 0;
> +}
> +
>  static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
>                              sector_t sector, struct page *to, unsigned long vaddr)
>  {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 439c3c70e347b..324363b798ecd 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -107,7 +107,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>  #endif
>
>  struct writeback_control;
> -int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
>  #if IS_ENABLED(CONFIG_FS_DAX)
>  int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
>  void dax_remove_host(struct gendisk *disk);
> --
> 2.30.2
>
