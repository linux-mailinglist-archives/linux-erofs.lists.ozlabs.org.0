Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E50690003
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 06:49:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PC5X55QKbz3ch4
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Feb 2023 16:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ITPX0Kdi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ITPX0Kdi;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PC5X06Bjmz3bVr
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Feb 2023 16:48:48 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so5070634pjy.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Feb 2023 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV8ZmgsAYphE9Ak6qoa3ww8DrLbAPBbA8KqiMQ61iko=;
        b=ITPX0KdifT4t2zEMXoze7cwMyaLKjIS0ISyaM6hdc32rMfah2WKcoR+M1IUJnFh8jQ
         /Ya6JP/PPq8ZKM2KjfvNP2NX++mRtmOaUDSlmyPnDwWkEPBFv/H05Nz+kctLvkCOKmZL
         14JTYfWXOlJIutsIyFCZuuV83V4CCGFj6MdZNmk7xBXVUXuRkOEO6AJh7dNtLAa4PeRY
         WrAAUgOk/uugpZiUQIbn5bb801O6NOlx28/Ge91Hhjp6d2gv+GitGvTtMGe6Pssdsz6A
         Yi+tbKLWaCiz5F9Dl1VADtKsZmMyVh9RrtakG7QHxYMFZ2+qr7KLNq8TONQ9v80VBrw3
         lCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV8ZmgsAYphE9Ak6qoa3ww8DrLbAPBbA8KqiMQ61iko=;
        b=BoBJRIq0JqRydW8/lakK9AidJA55tUFlNyrbyxyFYrz2XNUic1DIUE8XO2v2tbRGhV
         5zo456y5mLic+Fowjqrd2b9NGnIR8ANqXzBXthXfQSIzfqgfHAbRL1+e9Egie5xpcnN5
         KGyXh9quaT0kPdUOFg1gU6FxmlK5xPaFpPPFM23ox1niSIBqnNkw3vhLBfvFj0oHXgGF
         SF64aC5QP0j/dKcHFXldjaG5Ta7AZYohid3PK3G2XOjZLmWiNx0Skl2dbpgxnc0zXVIl
         oTvPaI4wdvd2mfobr8x/S6OJtg1cByBeCo/Bw36AQcqsC3JDgFa88Q+gCmB7KjRKe+pK
         W+uQ==
X-Gm-Message-State: AO0yUKWjcVmSvdnhAev16nhIgfvOOwcAUF1QQR4eRJgLtqZ58iNZo9Js
	uf42dw/PmY86cBdHBqU9eN8=
X-Google-Smtp-Source: AK7set9ArzHzgwCO9usoJrgu9l9c7cftrgfe9l//SPMiPYNxamZOXaXX6JZ5smV/nPopFeFSXUGj+w==
X-Received: by 2002:a17:903:32ce:b0:198:fca8:2108 with SMTP id i14-20020a17090332ce00b00198fca82108mr11041958plr.44.1675921725980;
        Wed, 08 Feb 2023 21:48:45 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902a60300b00198e1bc9d83sm441107plq.266.2023.02.08.21.48.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 21:48:45 -0800 (PST)
Date: Thu, 9 Feb 2023 13:54:28 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Thomas =?GB18030?B?V2VpgTCJOHNjaHVo?= <linux@weissschuh.net>
Subject: Re: [PATCH] erofs: make kobj_type structures constant
Message-ID: <20230209135428.00003233.zbestahu@gmail.com>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 09 Feb 2023 03:21:13 +0000
Thomas Weißschuh <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index fd476961f742..435e515c0792 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -179,13 +179,13 @@ static const struct sysfs_ops erofs_attr_ops = {
>  	.store	= erofs_attr_store,
>  };
>  
> -static struct kobj_type erofs_sb_ktype = {
> +static const struct kobj_type erofs_sb_ktype = {
>  	.default_groups = erofs_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  	.release	= erofs_sb_release,
>  };
>  
> -static struct kobj_type erofs_ktype = {
> +static const struct kobj_type erofs_ktype = {
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
>  
> @@ -193,7 +193,7 @@ static struct kset erofs_root = {
>  	.kobj	= {.ktype = &erofs_ktype},
>  };
>  
> -static struct kobj_type erofs_feat_ktype = {
> +static const struct kobj_type erofs_feat_ktype = {
>  	.default_groups = erofs_feat_groups,
>  	.sysfs_ops	= &erofs_attr_ops,
>  };
> 
> ---
> base-commit: 0983f6bf2bfc0789b51ddf7315f644ff4da50acb
> change-id: 20230209-kobj_type-erofs-0f0f4c901045
> 
> Best regards,

