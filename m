Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D95AA45B24F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 03:56:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQdc5h2Vz2ypj
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 13:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ZodTRA+l;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ZodTRA+l; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQdW6rZXz2yfZ
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 13:56:41 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so3326421pjj.0
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K6aLDxpU5yyseOlKo6rNtA4cugi0ipNPCjlDJmHcgIw=;
 b=ZodTRA+l0cWcfcrO3HjZ5G1YiDvMh60G3gnO10/HB5K3wACoMILqWpq5tyghP5PaAd
 /HwKbMOp519uQpkZTsiaKbJxiO4I4LMxvhZKQ98u2R62HbNgGSXOiBZGNXqPhLpDseTa
 7vzzMoZl4/zH+br0ANjvCl5c9fXM78IWjkNvHtHR5BTyrgEmRWUa/QYkAkFWIBqAi3vh
 b+zNb07awMu9xLTaQ0QBdRnjc+S/g9oqwKglYR/Xxt8j7ck6Lkr6xNcD5O/IUvzABpY5
 Eu59hL+MFPuc5JaG7/+/vAaPPJWsBP2y6puOgx7hXkD43mLwWUFY6ZCNi+QL3gXyrcQM
 vLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K6aLDxpU5yyseOlKo6rNtA4cugi0ipNPCjlDJmHcgIw=;
 b=hJrt9cB3/Qn6SEQMmZl8S+Mh5+jqLuVRYsyhc6BXqriI501oxLGRba/+3i9kKNI+8B
 WeH4gW7QpVACX/T6PQyn+3+7uZPFQHvcVb90m55OlMn0NqU3/woNRkJZT54dzHrre56Q
 yVrrtjUM0csgZJIb/W7UI6drvugWGGywWixbdqRteC/Agk6XuCdxUdybCHqsuqeZT0Cg
 0YfisDt248lDv0E+NNnM6WOlyLL+Us/zAMjczdfxb/HIhSWFUX+6gWBlPqFBULSWgxEr
 Bh9kgR9mvQGaqan8IDe+KW9WM70KM8JosjrWHzOP7mio8kmY4HAab6Z7es7vhU+BsOcg
 2KNA==
X-Gm-Message-State: AOAM530BaqBDM54xYwdwW1bH/zK1x0SnMZheVU3Gigjt6FSXbqUulsPS
 dN8yGxtPG3Lw8aBDOfkJ6NT2U334DEjCVtXopr3hlQ==
X-Google-Smtp-Source: ABdhPJzo6eTnlpQwuRFEtmMj42wpPoH8sJWzIsynA2XekOCtzKT4A4dij0QV0bz7WFLT+916AMzKYpVsKpziQJRycmQ=
X-Received: by 2002:a17:90b:1e07:: with SMTP id
 pg7mr3567015pjb.93.1637722600133; 
 Tue, 23 Nov 2021 18:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-26-hch@lst.de>
In-Reply-To: <20211109083309.584081-26-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:56:29 -0800
Message-ID: <CAPcyv4jtWzd3c_S1_4fYA1SXTJZfBzP_1xk_OwYkeNp0UhxwSg@mail.gmail.com>
Subject: Re: [PATCH 25/29] dax: return the partition offset from
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Prepare from removing the block_device from the DAX I/O path by returning

s/from removing/for the removal of/

> the partition offset from fs_dax_get_by_bdev so that the file systems
> have it at hand for use during I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 9 ++++++---
>  drivers/md/dm.c     | 4 ++--
>  fs/erofs/internal.h | 2 ++
>  fs/erofs/super.c    | 4 ++--
>  fs/ext2/ext2.h      | 1 +
>  fs/ext2/super.c     | 2 +-
>  fs/ext4/ext4.h      | 1 +
>  fs/ext4/super.c     | 2 +-
>  fs/xfs/xfs_buf.c    | 2 +-
>  fs/xfs/xfs_buf.h    | 1 +
>  include/linux/dax.h | 6 ++++--
>  11 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c0910687fbcb2..cc32dcf71c116 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -70,17 +70,20 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @bdev: block device to find a dax_device for
> + * @start_off: returns the byte offset into the dax_device that @bdev starts
>   */
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> +struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
>  {
>         struct dax_device *dax_dev;
> +       u64 part_size;
>         int id;
>
>         if (!blk_queue_dax(bdev->bd_disk->queue))
>                 return NULL;
>
> -       if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> -           (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> +       *start_off = get_start_sect(bdev) * SECTOR_SIZE;
> +       part_size = bdev_nr_sectors(bdev) * SECTOR_SIZE;
> +       if (*start_off % PAGE_SIZE || part_size % PAGE_SIZE) {
>                 pr_info("%pg: error: unaligned partition for dax\n", bdev);
>                 return NULL;
>         }
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 282008afc465f..5ea6115d19bdc 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -637,7 +637,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>                              struct mapped_device *md)
>  {
>         struct block_device *bdev;
> -
> +       u64 part_off;
>         int r;
>
>         BUG_ON(td->dm_dev.bdev);
> @@ -653,7 +653,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
>         }
>
>         td->dm_dev.bdev = bdev;
> -       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
> +       td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);

Perhaps allow NULL as an argument for callers that do not care about
the start offset?


Otherwise, looks good / clever.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
