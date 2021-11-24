Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B545B244
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 03:52:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQXY3dq1z2ynt
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 13:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=Y7Xkrixb;
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
 header.s=20210112 header.b=Y7Xkrixb; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQXV5RtLz2yPs
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 13:52:25 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id
 gb13-20020a17090b060d00b001a674e2c4a8so1200333pjb.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 18:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
 b=Y7XkrixbrNlS8hQi6+YjpK4PZmxcaZt8IqYEL0x+AbApMNhFV77CzxIm1fpzZJvqGy
 z6D/gHDQ4xlWEfbCz9zV/Nr2rYvjyAJ/qcfvABnWEzU5q3sPzeWrzFiGiQQVw5TF5P/Q
 vGI8iomC/tTJLNOXXKE+qcAeV4HDU/nIHSo9sub+NaaMXbz5ALE5SX90GBKyPNNwTUeM
 U8Wl8gNSrdkT3Uzd5sOv409e3dENQvzi+2J3G8FjskgqDuk0PglVJ0u6ajEy8rV/j0R2
 Kp+xFLo9F8v5ClK8M1g/uaLLpJP0HiqMIi5yPKOPokQDDyomwLUF2ZncL/aMKydNlkDc
 qMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HOfci/mx3akOO+4HmSZ2UPdC5Rli9mLX/eg9lyyjZ30=;
 b=WZDDBmr1xsk/V/xLp2ElzbGzN9snrMepQASWr3PeMktqBveyhXoglQaDO6gY5aI+tA
 26mUrSvfT8YWPc0fN63UhhitFBkIjslOCa/RyCtcGn3yxpL3XnpXjCyqEaNCnai5q1JX
 x4vG5iMfYkA2LUs8TLVxKVqSlrzkidfD/Ts+RcbXZLgtII/Qu4w47qvUa1KA2otnwlvI
 1XtVgXPFhv0DF2MvX8ljguUt3WaVQNDUvsIoC1C5nqv1p4B+x8o/bUXp9Zw9BuaV9pnw
 FCgOmLmlgVbCKy6y4e+GJ/R1ZvzT7GgzQLHiXxxF5ZVZMdoAFUtJlbt60TrGOZ5EdDEs
 1+lA==
X-Gm-Message-State: AOAM5312jIiXvP+OONPSmApoyRiGSldAr2ycJpK1vBUs9kDVT29PFeBu
 42043kOPzDPII6gWRs5H7rUPwOIVsf3YiZRSyzQ1Uw==
X-Google-Smtp-Source: ABdhPJwYJBk3MOCLfOjDzIFwcn3St8lk3aeiUUUrOONNeXpKHHsZfcNKcAaGYukH/G67vklAJOZt7FEQ2h9y1bfGO+A=
X-Received: by 2002:a17:90a:e7ca:: with SMTP id
 kb10mr10191254pjb.8.1637722343903; 
 Tue, 23 Nov 2021 18:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-25-hch@lst.de>
In-Reply-To: <20211109083309.584081-25-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 18:52:13 -0800
Message-ID: <CAPcyv4iRUDaT4rrLYhGrJB-zt9B-bGGoVW3wYoUnePRxx58Fdw@mail.gmail.com>
Subject: Re: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
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
> While the buffered write iomap ops do work due to the fact that zeroing
> never allocates blocks, the DAX zeroing should use the direct ops just
> like actual DAX I/O.
>

I always wondered about this, change looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cef3b68cba78..704292c6ce0c7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1324,7 +1324,7 @@ xfs_zero_range(
>
>         if (IS_DAX(inode))
>                 return dax_zero_range(inode, pos, len, did_zero,
> -                                     &xfs_buffered_write_iomap_ops);
> +                                     &xfs_direct_write_iomap_ops);
>         return iomap_zero_range(inode, pos, len, did_zero,
>                                 &xfs_buffered_write_iomap_ops);
>  }
> @@ -1339,7 +1339,7 @@ xfs_truncate_page(
>
>         if (IS_DAX(inode))
>                 return dax_truncate_page(inode, pos, did_zero,
> -                                       &xfs_buffered_write_iomap_ops);
> +                                       &xfs_direct_write_iomap_ops);
>         return iomap_truncate_page(inode, pos, did_zero,
>                                    &xfs_buffered_write_iomap_ops);
>  }
> --
> 2.30.2
>
