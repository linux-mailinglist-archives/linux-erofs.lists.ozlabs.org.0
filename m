Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A845B230
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 03:47:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQQj555wz2yHS
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 13:47:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=v+mOAcq/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=v+mOAcq/; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQQg27nCz2ymc
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 13:47:22 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id l190so780155pge.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QDkzPn+vIexNrKZKKgoJ7mQpee2ZSq2mCl3rdYSyZRs=;
 b=v+mOAcq/SMKI/6q1YGZhpUVRcKk3Bw1T+5aGwwKv9mK2S2/X3/d4jBb8CtZv2zYTwr
 Pg1AqI7Z4Z4TlelZDn+KthnTvqDSRv6A+lCI2+ceJjR1FEDifVcdUwxhPiddV3WPjYrv
 lC+zURcqUQmJYR3vyh6zvz4VGUf4KNwKq0in9nWSpYOBf6f6zXAokmgGs5Cq/v3LtIph
 O7RhU1t8NRctmET5Lo+hqoJpyIArJ0ylytKPnuKYBx+d5J1szUdYJ5z55Dp/Qo4PGCAg
 Moyefg0QnBnsCQDIz9YLw+w9C+cvtilKMUc0ArCtcauRumPts8w7o0gMvfkEEACUlRsr
 KeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QDkzPn+vIexNrKZKKgoJ7mQpee2ZSq2mCl3rdYSyZRs=;
 b=0RVXlYvF/2I/m2qs5m+P2+ct4KY+sD5Dy5lhKKHoNbdi0QZP54Yf/nHYO682pZSoA5
 559+ylh15nd5iUMX6Mp318EBcNNaMtu4abrTSv+s+G4w0oZsyvcCcnf4+uFwIJwLtuV/
 VRFh6ZZ4NBpa9v4dzEQGRlPxvZanJXg4+R69hnvwxdZTAlQwB9zPEF+M1fg2sgbvcKi9
 WMfI/0cmhPvw3b++89NnSt/j8zNFf6pBBM1w9I7XA9PA0ioFOky6jMHStkjTp0llw3Qu
 T2TGPZ6kqLngNPoJp6Wxx/plRm8whj3QE4UyfUptkA8umxhcF2RJoY+PpdVzudeTI0zA
 maxw==
X-Gm-Message-State: AOAM5302hAAW0lus7yEYFNtM4+wHCBMxQ0KO3k3LHXICJPMqY7BMl5UV
 YAsR3q8BCvbTaWFQzCquwx1nodGrp4g7xwWGmL086yDT+fA=
X-Google-Smtp-Source: ABdhPJwhulY7o10L5eF793HT2VpAfIjkz05UxjHV38L6J4vJZLIxSbRiUXQ9JXqnOQ3P5Me+Dt5jaZMn/7VokxocR94=
X-Received: by 2002:a63:8141:: with SMTP id t62mr5500508pgd.5.1637722040536;
 Tue, 23 Nov 2021 18:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-23-hch@lst.de>
In-Reply-To: <20211109083309.584081-23-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:47:10 -0800
Message-ID: <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
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
> Add a flag so that the file system can easily detect DAX operations.

Looks ok, but I would have preferred a quick note about the rationale
here before needing to read other patches to figure that out.

If you add that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c              | 7 ++++---
>  include/linux/iomap.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b52b878124ac..0bd6cdcbacfc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>                 .inode          = inode,
>                 .pos            = pos,
>                 .len            = len,
> -               .flags          = IOMAP_ZERO,
> +               .flags          = IOMAP_DAX | IOMAP_ZERO,
>         };
>         int ret;
>
> @@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>                 .inode          = iocb->ki_filp->f_mapping->host,
>                 .pos            = iocb->ki_pos,
>                 .len            = iov_iter_count(iter),
> +               .flags          = IOMAP_DAX,
>         };
>         loff_t done = 0;
>         int ret;
> @@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>                 .inode          = mapping->host,
>                 .pos            = (loff_t)vmf->pgoff << PAGE_SHIFT,
>                 .len            = PAGE_SIZE,
> -               .flags          = IOMAP_FAULT,
> +               .flags          = IOMAP_DAX | IOMAP_FAULT,
>         };
>         vm_fault_t ret = 0;
>         void *entry;
> @@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>         struct iomap_iter iter = {
>                 .inode          = mapping->host,
>                 .len            = PMD_SIZE,
> -               .flags          = IOMAP_FAULT,
> +               .flags          = IOMAP_DAX | IOMAP_FAULT,
>         };
>         vm_fault_t ret = VM_FAULT_FALLBACK;
>         pgoff_t max_pgoff;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6d1b08d0ae930..146a7e3e3ea11 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -141,6 +141,7 @@ struct iomap_page_ops {
>  #define IOMAP_NOWAIT           (1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY   (1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE          (1 << 7) /* unshare_file_range */
> +#define IOMAP_DAX              (1 << 8) /* DAX mapping */
>
>  struct iomap_ops {
>         /*
> --
> 2.30.2
>
