Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DC4C0EB1
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 09:59:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K3VMx4YvRz3bVy
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Feb 2022 19:59:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Ioq3fZdQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034;
 helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Ioq3fZdQ; dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K3VMt2ZqFz3bP4
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Feb 2022 19:59:20 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id
 j10-20020a17090a94ca00b001bc2a9596f6so2076853pjw.5
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Feb 2022 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w2to3BP7Hk9Rhn4a/m99kEi4zOalhc4jbVth64Ox8bo=;
 b=Ioq3fZdQL5Go7nNoKOTcI6UkzVDslzikWseU5l/a6xLGDiYT2bcUe9ivpcNzD7K1Tv
 T03nES8J7htJdgJBrqq8sXjU3Qmx0RE90QkgNxV5QBgzUXXkQGndMG2n/ZDtTN39AUjc
 uBBxrkCjdwZrFE6qaODTqqvrTGXRaRD6i4/DzHhc/Rt+0VqiiyE/v3g4p8KIj1cL1ovV
 atI3/aEzA0lHOAWLTfrPiPQEEow8/gm+sCOAg7/HxWsTPJdWswhCLoj+zhReCoEgBbeC
 lla/EdI7SfKzDSHpVuUgdIOr18CcF3E51B/+tPq+GO8XUdrjEaaL821NGrzPGBPaKcUJ
 qMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w2to3BP7Hk9Rhn4a/m99kEi4zOalhc4jbVth64Ox8bo=;
 b=RVLkvIH1faUxem6pI4ndkpmlYoUWt2x4pp6A2nIGQtfRMWQ+R5ELax6EUuUKFSypAC
 iQsJFfp+YKEjxVuJ2hc5LILM3ilhtFCKqltdt5Usxdln/N9meQCNrmdlgZkX1OaHxcc9
 T+sztg8Gycydq7JcG1WWvSILXNmtccBHAnsMopKbjADwX5tAaiHhTj3dqxCfTgVujHvn
 AZzw2V3O1OLNcCL6dNI3flr9QVO0jLJtd0q241W08/9HlTCYa+1QwzstM2Gty3TWrsh0
 HYAbZLtLVk2EAn1umJRax7O2UcFXg5Xd/fOWbAl6NEkHgV4NuCffoEDknMwlR9l6Ayy8
 oQVg==
X-Gm-Message-State: AOAM533GnucgzVmeBqM7Nz45UpblwW5gKUoGYKMWk8FYUGngLTyRKcz9
 vQbGzI7Io+96tPT6rgt/2QjnjpGSfLs=
X-Google-Smtp-Source: ABdhPJxEbCWZhD20rDjbo+ruunHnyo4end5hE45bLbvCFRkuf+jTx5gSE41diVYb+XaE7XFzcnTTMw==
X-Received: by 2002:a17:902:ea02:b0:14f:fd0e:e433 with SMTP id
 s2-20020a170902ea0200b0014ffd0ee433mr1073572plg.24.1645606756292; 
 Wed, 23 Feb 2022 00:59:16 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id u17sm16834351pfi.99.2022.02.23.00.59.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Feb 2022 00:59:15 -0800 (PST)
Date: Wed, 23 Feb 2022 16:57:40 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix ztailpacking on > 4GiB filesystems
Message-ID: <20220223165740.0000067a.zbestahu@gmail.com>
In-Reply-To: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
References: <20220222033118.20540-1-hsiangkao@linux.alibaba.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com,
 Yue Hu <huyue2@yulong.com>, linux-erofs@lists.ozlabs.org,
 shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 22 Feb 2022 11:31:18 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> z_idataoff here is an absolute physical offset, so it should use
> erofs_off_t (64 bits at least). Otherwise, it'll get trimmed and
> cause the decompresion failure.
> 
> Fixes: ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index b8272fb95fd6..5aa2cf2c2f80 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -325,7 +325,7 @@ struct erofs_inode {
>  			unsigned char  z_algorithmtype[2];
>  			unsigned char  z_logical_clusterbits;
>  			unsigned long  z_tailextent_headlcn;
> -			unsigned int   z_idataoff;
> +			erofs_off_t    z_idataoff;
>  			unsigned short z_idata_size;
>  		};
>  #endif	/* CONFIG_EROFS_FS_ZIP */

Reviewed-by: Yue Hu <huyue2@yulong.com>
