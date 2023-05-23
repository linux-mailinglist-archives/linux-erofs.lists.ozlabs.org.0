Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AAF70D0BB
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 03:58:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QQHXL3Tbrz3c9y
	for <lists+linux-erofs@lfdr.de>; Tue, 23 May 2023 11:58:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Df69KUR/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=Df69KUR/;
	dkim-atps=neutral
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QQHXC5r97z30CT
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 May 2023 11:58:02 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso3684774a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 22 May 2023 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684807080; x=1687399080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5cOI+ye5ZCld7XQmpU4XJbU8qLqZl9B8hKE1Vzf+Mo=;
        b=Df69KUR/emv3GBQ0d2NKF8iX7ImzJ4DRsXufcY46ex6tOGyGYf7azEiy9HtJCZ/PvO
         9GZO8NdjrxGXjenW6c81ItX9NxySJko53/cglIEw3rAky2GBabgM4Cdvq4Sw8dAa23Zk
         cGqhlPYDTkmxcFTUAscDt/F2Vc86dT9Qg54pzk1WqadJgnNp9XRgvyBB/FrLdh9fOdUd
         O4ce34o7yfWo2Mb6/n+kpTSz4iFzhENnDu4jB1M3xm39+Ueh0gtxNQkbkQTNCsbpqYgB
         QEFna13VIjILd72RYzUbZJLhwMaWFc8isEiXB0SmWjvVileDqmu2wyePYImAnd5mOQZO
         U0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807080; x=1687399080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5cOI+ye5ZCld7XQmpU4XJbU8qLqZl9B8hKE1Vzf+Mo=;
        b=TTdgqt3jRhyEi51mNvFPfcSwW8UYNKvBs/COZZHsMCINR++HpmQCIXUtDXBBMf8VhH
         S9K/P4M7CY0S/bsnH7eANscJ16Of5c6FsqeFmFB7iDR42CWtLtbNkzs7yDKlU5vSR1Dl
         5V3VGxig7g9pjnCbFoUkgfhFGTWhEKpYP2Pssw0fi+/R9VV6R4Fy7mkEcVF34DJ1GkuK
         h2mcOxV7S9Z0FRXzGiVwN0m7GOThepgRbIojyYvuSEOAsxhtivQYEW1DR/AUt0ernnzE
         vuy4DNEYAsThCYRR4gp4lBRUKp78q7qCslRA/eFqazMLR1N1ALgKHexqrGJqWTKhthQX
         SJDg==
X-Gm-Message-State: AC+VfDxJyDoHqehsN2vi/cpuUFMem7MdcpGTWSMtXW6ZYiDnUe+yb0QB
	QxqP67NNUAsL6pzgW8a2taE=
X-Google-Smtp-Source: ACHHUZ6jF22XnzOSUIIA6icB6A9EF+a+6SzpMrho2Akf4oa6Lj8jCYVNtqgo2QdNnKruiCqovhesYQ==
X-Received: by 2002:a17:902:a589:b0:1ad:dd21:2691 with SMTP id az9-20020a170902a58900b001addd212691mr14084231plb.10.1684807079951;
        Mon, 22 May 2023 18:57:59 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902bd8a00b001a1a82fc6d3sm5424615pls.268.2023.05.22.18.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 May 2023 18:57:59 -0700 (PDT)
Date: Tue, 23 May 2023 10:05:58 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: use HIPRI by default if per-cpu kthreads are
 enabled
Message-ID: <20230523100558.00007b78.zbestahu@gmail.com>
In-Reply-To: <3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
References: <20230522092141.124290-1-hsiangkao@linux.alibaba.com>
	<20230523085226.00006933.zbestahu@gmail.com>
	<3177581a-2252-04a0-1933-fc4cf100046d@linux.alibaba.com>
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
Cc: zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Sandeep Dhavale <dhavale@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 23 May 2023 09:53:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/23 17:52, Yue Hu wrote:
> > On Mon, 22 May 2023 17:21:41 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> As Sandeep shown [1], high priority RT per-cpu kthreads are
> >> typically helpful for Android scenarios to minimize the scheduling
> >> latencies.
> >>
> >> Switch EROFS_FS_PCPU_KTHREAD_HIPRI on by default if
> >> EROFS_FS_PCPU_KTHREAD is on since it's the typical use cases for
> >> EROFS_FS_PCPU_KTHREAD.
> >>
> >> Also clean up unneeded sched_set_normal().
> >>
> >> [1] https://lore.kernel.org/r/CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com
> >> Cc: Sandeep Dhavale <dhavale@google.com>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >>   fs/erofs/Kconfig | 1 +
> >>   fs/erofs/zdata.c | 2 --
> >>   2 files changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> >> index 704fb59577e0..f259d92c9720 100644
> >> --- a/fs/erofs/Kconfig
> >> +++ b/fs/erofs/Kconfig
> >> @@ -121,6 +121,7 @@ config EROFS_FS_PCPU_KTHREAD
> >>   config EROFS_FS_PCPU_KTHREAD_HIPRI
> >>   	bool "EROFS high priority per-CPU kthread workers"
> >>   	depends on EROFS_FS_ZIP && EROFS_FS_PCPU_KTHREAD
> >> +	default y  
> > 
> > How about removing this config option?  
> 
> I tend to leave it as is.

Okay.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang

