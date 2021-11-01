Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410A441DD7
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Nov 2021 17:17:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HjdVW0JQRz2y7M
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Nov 2021 03:17:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B7k9y58G;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B7k9y58G;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=snitzer@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=B7k9y58G; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B7k9y58G; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HjdVQ2rCJz2x9c
 for <linux-erofs@lists.ozlabs.org>; Tue,  2 Nov 2021 03:17:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2vxwqlB6wFzeCRM5lLa77O94J13VaOz9ZvoVd+rZG8=;
 b=B7k9y58G4JcIJeeiOMtSuF/pN9PKfe884hWhZsMpBKVicHOLGOaAhA3bkvQohmEfRR30U6
 ZdVJcyY/DGGosjEivx/lAq1oA8SbdNvebn4BSrV8ZNz5rn9Tc0zupJl4VmczztD5x2R0JF
 Ak+B7EQ3PIAaXpM6rGqwJSPquMZgtiQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635783467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2vxwqlB6wFzeCRM5lLa77O94J13VaOz9ZvoVd+rZG8=;
 b=B7k9y58G4JcIJeeiOMtSuF/pN9PKfe884hWhZsMpBKVicHOLGOaAhA3bkvQohmEfRR30U6
 ZdVJcyY/DGGosjEivx/lAq1oA8SbdNvebn4BSrV8ZNz5rn9Tc0zupJl4VmczztD5x2R0JF
 Ak+B7EQ3PIAaXpM6rGqwJSPquMZgtiQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-Eu_wrUTaNA-trlQharG57g-1; Mon, 01 Nov 2021 12:17:46 -0400
X-MC-Unique: Eu_wrUTaNA-trlQharG57g-1
Received: by mail-qv1-f69.google.com with SMTP id
 bu1-20020ad455e1000000b0038529a6d278so16716374qvb.10
 for <linux-erofs@lists.ozlabs.org>; Mon, 01 Nov 2021 09:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F2vxwqlB6wFzeCRM5lLa77O94J13VaOz9ZvoVd+rZG8=;
 b=hutUy2HV6/3eguyjTX7i1OxUDHhg02Sv+7oq2NRwflmI1AMK6Qd02Vfm8+kmgUZNhf
 jwcWKgon7hsSd3CC5piQdqHvzabMpCs/e/3nqo2hwKx+zBKs6NkY+kmFhqP3tAuDFzpl
 tYLRGdaB/QFMImLnUsULlNdJZChLkxVkIUqrKbuhilQbRLkTdynmWJI4PiyAo5C9wJjO
 xDJLlGB5W/hy6sycQs90pHHe4xLVw1jXbRBMHiIHc2h8UATGyGACEOkHHHM1jtBxLUI5
 ayW8OTljBdS6hyYElzzIkE4oqC0Ho/dTwmbuz0VH+ly6M0rMsadEHDgpCghdUIWc2YlE
 oiXw==
X-Gm-Message-State: AOAM531jmABNNnqH9ujmFmXBVZpXD2GME9UZR5MTNc4ZqtfjXEmqtwzf
 KkfrR/9agsojYBg54Pk5c/fS24w2mRjWTnZTleb8HKp8G8zxHlc9B0iTl5ZFW5wJa0KqZfqXyB/
 tbmGjaWRr68+wN5R5czPAm9o=
X-Received: by 2002:a05:622a:1006:: with SMTP id
 d6mr31006255qte.259.1635783465587; 
 Mon, 01 Nov 2021 09:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsvnNj6Smb4Ra96XKXfYd15LiYJibYUWXpiZB6UR51qpyc+daCyIZfeeXzYlbHsOmSJkMTRA==
X-Received: by 2002:a05:622a:1006:: with SMTP id
 d6mr31006216qte.259.1635783465346; 
 Mon, 01 Nov 2021 09:17:45 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id f66sm5772868qkj.76.2021.11.01.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 09:17:44 -0700 (PDT)
Date: Mon, 1 Nov 2021 12:17:43 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 07/11] dax: remove dax_capable
Message-ID: <YYATJ+oDT15TD9Np@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-8-hch@lst.de>
 <CAPcyv4gE8UXjQAe_6=BKFRCyLWNP_9CNxKFH---RpPnYfmBQLg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gE8UXjQAe_6=BKFRCyLWNP_9CNxKFH---RpPnYfmBQLg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Oct 27 2021 at  8:16P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> I am going to change the subject of this patch to:
> 
> dax: remove ->dax_supported()
> 
> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> 
> I'll add a bit more background to help others review this.
> 
> The ->dax_supported() operation arranges for a stack of devices to
> each answer the question "is dax operational". That request routes to
> generic_fsdax_supported() at last level device and that attempted an
> actual dax_direct_access() call and did some sanity checks. However,
> those sanity checks can be validated in other ways and with those
> removed the only question to answer is "has each block device driver
> in the stack performed dax_add_host()". That can be validated without
> a dax_operation. So, just open code the block size and dax_dev == NULL
> checks in the callers, and delete ->dax_supported().
> 
> Mike, let me know if you have any concerns.

Thanks for your additional background, it helped.


> 
> > Just open code the block size and dax_dev == NULL checks in the callers.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/dax/super.c          | 36 ------------------------------------
> >  drivers/md/dm-table.c        | 22 +++++++++++-----------
> >  drivers/md/dm.c              | 21 ---------------------
> >  drivers/md/dm.h              |  4 ----
> >  drivers/nvdimm/pmem.c        |  1 -
> >  drivers/s390/block/dcssblk.c |  1 -
> >  fs/erofs/super.c             | 11 +++++++----
> >  fs/ext2/super.c              |  6 ++++--
> >  fs/ext4/super.c              |  9 ++++++---
> >  fs/xfs/xfs_super.c           | 21 ++++++++-------------
> >  include/linux/dax.h          | 14 --------------
> >  11 files changed, 36 insertions(+), 110 deletions(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 482fe775324a4..803942586d1b6 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -108,42 +108,6 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> >         return dax_dev;
> >  }
> >  EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> > -
> > -bool generic_fsdax_supported(struct dax_device *dax_dev,
> > -               struct block_device *bdev, int blocksize, sector_t start,
> > -               sector_t sectors)
> > -{
> > -       if (blocksize != PAGE_SIZE) {
> > -               pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
> > -               return false;
> > -       }
> > -
> > -       if (!dax_dev) {
> > -               pr_debug("%pg: error: dax unsupported by block device\n", bdev);
> > -               return false;
> > -       }
> > -
> > -       return true;
> > -}
> > -EXPORT_SYMBOL_GPL(generic_fsdax_supported);
> > -
> > -bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> > -               int blocksize, sector_t start, sector_t len)
> > -{
> > -       bool ret = false;
> > -       int id;
> > -
> > -       if (!dax_dev)
> > -               return false;
> > -
> > -       id = dax_read_lock();
> > -       if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
> > -               ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
> > -                                                 start, len);
> > -       dax_read_unlock(id);
> > -       return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(dax_supported);
> >  #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
> >
> >  enum dax_device_flags {
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 1fa4d5582dca5..4ae671c2168ea 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> > @@ -807,12 +807,14 @@ void dm_table_set_type(struct dm_table *t, enum dm_queue_mode type)
> >  EXPORT_SYMBOL_GPL(dm_table_set_type);
> >
> >  /* validate the dax capability of the target device span */
> > -int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
> > +static int device_not_dax_capable(struct dm_target *ti, struct dm_dev *dev,
> >                         sector_t start, sector_t len, void *data)
> >  {
> > -       int blocksize = *(int *) data;
> > +       if (dev->dax_dev)
> > +               return false;
> >
> > -       return !dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
> > +       pr_debug("%pg: error: dax unsupported by block device\n", dev->bdev);

Would prefer the use of DMDEBUG() here (which doesn't need trailing \n)

But otherwise:
Acked-by: Mike Snitzer <snitzer@redhat.com>

