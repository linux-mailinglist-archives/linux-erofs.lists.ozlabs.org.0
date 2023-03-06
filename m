Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 841406ABAAE
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 11:05:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PVZ2P2lwTz3cFr
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Mar 2023 21:05:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=U3erHKYp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=U3erHKYp;
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PVZ2F6kGqz3bT7
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Mar 2023 21:05:09 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so12655342pjb.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 06 Mar 2023 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678097106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZMN6CbP136S2WMVSasou4M9/SE+Pibn91kNnrQcbOM=;
        b=U3erHKYpOBTgDX4e3XbIqYXnFmJFz6j6t29Iqj5AlsLTwDL1sA6+LUYa7AMgDzn7OE
         4tgXb/V6FESJ2rR5XZP0VnXK0asCU79NsXKRyNnSPCYYPZszSUI4ACY+LMYJulMNFiyG
         RCOhKmyDrNl2CjE+z0+oKvlFu4qBRhMRipqABwM77ObUAwSqjkOQUI3Q8AQrMM9kytJu
         RtwYnjhng89joIlnoCwYx9BwdXcsMlPj+tcho77HUZziYYEW09IkgNrnz3u/LqP1ymIE
         CeQ1nTRo6d1+Fem46TA+7gkYubob5Auj4kG9yX2ObgG5X0XfRXaB7vRIvcECZjLyr7OR
         hgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678097106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZMN6CbP136S2WMVSasou4M9/SE+Pibn91kNnrQcbOM=;
        b=ibvt2Kb8TGB3uDkehrcXLdDT6nD0WbVcLXNAhWroXAQX8tQgMvSUxQdQiiJuEnkyFu
         P8RjujFqMLCCHSlRUrmEPVvz+BVr76Yj8Rze5s6tN8jp/5M5tFYKU/Rr59gMP/ioab2C
         zZyYEXFzDom5/DBi6Yj1JMuf0o8h/VxkRrdKTPdL1+EmUTz5InjETjUx8wsGloDbibKv
         FV4ad/wkocS7Dfk8x8fslCeWjD4k9MS6PfabjoEuIBrk/HWFJcYLO08qywj7H/va/0a7
         nf/PKHy6V+InmXq8qSmdDDtoiJLTZp8zrJ8KfoKrsmZti/cHldNEdnNZLo9RGT5scoWM
         vs0A==
X-Gm-Message-State: AO0yUKUQRVriw+RymI209p1Iysfon4yK5MgCYYrw2JYVLGPmMmIJVVMb
	MxmeQbDY9tWJcmDXUOY4Puw=
X-Google-Smtp-Source: AK7set/NEtbw7EySARdGqsZEPY91ywSOdsomWYy9tiDixtv/jz6Rn/Dpt06GV+9FgWg2Iw3iwPrVUg==
X-Received: by 2002:a17:90b:4b89:b0:234:68d:b8ea with SMTP id lr9-20020a17090b4b8900b00234068db8eamr10773731pjb.39.1678097106111;
        Mon, 06 Mar 2023 02:05:06 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id lx3-20020a17090b4b0300b00233bc4edb77sm7571465pjb.25.2023.03.06.02.05.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Mar 2023 02:05:05 -0800 (PST)
Date: Mon, 6 Mar 2023 18:11:23 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v5 0/2] erofs: set block size to the on-disk block size
Message-ID: <20230306181123.000012ac.zbestahu@gmail.com>
In-Reply-To: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
References: <20230306100200.117684-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon,  6 Mar 2023 18:01:58 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> changes since v4:
> - patch 1: convert several remained call sites of sb->s_blocksize_bits
>   to erofs_blknr() and erofs_pos() (Yue Hu)
> - patch 2: revise comment for blkszbits and dirblkbits (Yue Hu)
> 
> changes since v3:
> - patch 1: remove redundant newline when printing messages (Gao Xiang)
> - patch 2: introduce dirblkbits in on-disk superblock and disable this
>   feature for now, so that the current kernel won't break with the image
>   with this feature enabled later (Gao Xiang)
> 
> 
> v1: https://lore.kernel.org/all/20230216094745.47868-1-jefflexu@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20230217055016.71462-2-jefflexu@linux.alibaba.com/
> v3: https://lore.kernel.org/all/20230220025046.103777-1-jefflexu@linux.alibaba.com/
> v4: https://lore.kernel.org/all/20230302143915.111739-1-jefflexu@linux.alibaba.com/
> 
> 
> 
> Jingbo Xu (2):
>   erofs: avoid hardcoded blocksize for subpage block support
>   erofs: set block size to the on-disk block size
> 
>  fs/erofs/data.c              | 50 ++++++++++++++------------
>  fs/erofs/decompressor.c      |  6 ++--
>  fs/erofs/decompressor_lzma.c |  4 +--
>  fs/erofs/dir.c               | 22 ++++++------
>  fs/erofs/erofs_fs.h          |  5 +--
>  fs/erofs/fscache.c           |  5 +--
>  fs/erofs/inode.c             | 23 ++++++------
>  fs/erofs/internal.h          | 29 +++++----------
>  fs/erofs/namei.c             | 14 ++++----
>  fs/erofs/super.c             | 70 ++++++++++++++++++++++--------------
>  fs/erofs/xattr.c             | 40 ++++++++++-----------
>  fs/erofs/xattr.h             | 10 +++---
>  fs/erofs/zdata.c             | 18 +++++-----
>  fs/erofs/zmap.c              | 29 +++++++--------
>  include/trace/events/erofs.h |  4 +--
>  15 files changed, 170 insertions(+), 159 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>
