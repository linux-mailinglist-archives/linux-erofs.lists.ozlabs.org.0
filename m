Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801344BE1B
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 10:53:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hq0Xq2KsKz2yYS
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 20:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=CoS79+LE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=CoS79+LE; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hq0Xk584Xz2xsS
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 20:53:26 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so1370505pjc.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 01:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aSRNJO4Le1MVc3lzZUsrRcp2HJtLJ2Ev+XdIkUHX7aM=;
 b=CoS79+LEpu6Hbfd2rek1Zm1RrdDp1nmjMgwC8oBRvii831MbMbDxrpI9SCLBdk4Lxy
 RDfjTKaL64/KF1gp+8s3KamixYgWj6rqDyns4+Uop3BqnNgxADdjw4wj0UyGXXzhDIJx
 Rl1pOuyJn8LoxbFxM5WRmZ6MU9A1bKJwGcmeqexEVen7X1fBRsp4yBrtba46eC0QmrMx
 OusKt/DtCzETasGezh891SvOSFXUslLoQ7VlwTH8siJfajNtMG1vUL02YkbNmz+fs2pT
 D6ku7JChL0vaEKzy/l1DvAI5+/ysX2y0Kf8VpLWF0LMVFJHYsFU5Bc5JMObafPf8EoLz
 Clrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aSRNJO4Le1MVc3lzZUsrRcp2HJtLJ2Ev+XdIkUHX7aM=;
 b=21uVXNgi4qbciP2h+/BA+dyiJDoVHOku/tTzYtWaZ5c3GryJq6L8eGHGT66MBPLWV3
 1rgQYl2wvSbFCR2wviD2u2DpFDMbTKTFxLGvq14RqvoiR5cQuXC3Q3UzxmrB0z+Chti1
 uE8up5+tRI/dkx/NszpFfz0TMzgA9KGs5urZrbkXBIHPY2idhj3aNcuOTtfN+XXj8mpb
 nEVgWlUZOJy7oq7PN+sy6zHwwiPOZuVBrMKttyJhu1l9+eKhh2vlR7xlWkqqQxRhvop7
 CPWNsX1Y8edjno1k85E4pSmcz1kkSQIlfktZQYiq7VNNrQPrZB7zEWZ4aqpqAmWQKJWa
 tSNA==
X-Gm-Message-State: AOAM5319uYAoJZ7ohICqrRhXHN25GCqB9gkRpzTiIZLr3ebsxtBTlgZb
 dZBF0tyUeuCpK1lbM/CW3OQ=
X-Google-Smtp-Source: ABdhPJxxiGgcz1rPbVdavJcHCVvsRbk/iuRnlgvShbFPuG66y0PTWwxKjoH4f3FgR1+ogp2/zzJ3hg==
X-Received: by 2002:a17:90a:a396:: with SMTP id
 x22mr15329506pjp.14.1636538004417; 
 Wed, 10 Nov 2021 01:53:24 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id j15sm22451530pfh.35.2021.11.10.01.53.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Nov 2021 01:53:24 -0800 (PST)
Date: Wed, 10 Nov 2021 17:51:36 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] AOSP: erofs-utils: avoid lzma inclusion when
 liblzma is disabled
Message-ID: <20211110175136.00005c5c.zbestahu@gmail.com>
In-Reply-To: <20211110064931.181727-1-hsiangkao@linux.alibaba.com>
References: <20211110064931.181727-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, Daeho Jeong <daehojeong@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, 10 Nov 2021 14:49:31 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> As Daeho reported [1], erofs-utils will fail to build with the
> current AOSP Android.bp:
> 
> external/erofs-utils/lib/compressor_liblzma.c:8:10: fatal error:
> 'lzma.h' file not found
>          ^~~~~~~~
> 1 error generated.
> 16:13:47 ninja failed with: exit status 1
> 
> compressor_liblzma.c won't be compiled if ENABLE_LIBLZMA is not
> defined according to lib/Makefile.am. Thus it doesn't have an impact
> on non-Android scenarios.
> 
> [1] https://lore.kernel.org/r/CACOAw_wt+DX0D+Ps-K=oF+MgUxtVKbXpamShoZR7n4WwM+wODw@mail.gmail.com
> Reported-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/compressor_liblzma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
> index e9bfcc556c54..40a05efb11dc 100644
> --- a/lib/compressor_liblzma.c
> +++ b/lib/compressor_liblzma.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
>   */
>  #include <stdlib.h>
> +#include "config.h"
> +#ifdef HAVE_LIBLZMA
>  #include <lzma.h>
>  #include "erofs/config.h"
>  #include "erofs/print.h"
> @@ -103,3 +105,4 @@ struct erofs_compressor erofs_compressor_lzma = {
>  	.setlevel = erofs_compressor_liblzma_setlevel,
>  	.compress_destsize = erofs_liblzma_compress_destsize,
>  };
> +#endif

Reviewed-by: Yue Hu <huyue2@yulong.com>

Thanks.

