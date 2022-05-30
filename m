Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC25376A5
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 10:48:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LBTZy35q1z308b
	for <lists+linux-erofs@lfdr.de>; Mon, 30 May 2022 18:48:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LNETF7Lx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LNETF7Lx;
	dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LBTZt1vQ9z2yph
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 18:48:20 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d22so9733457plr.9
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 May 2022 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feOMts/VuZSIeHiNfKMOMQaa2Lngj60rb3I4zPEV1nE=;
        b=LNETF7LxgwnA/JC0t0tE+Sqvi1bNtFJcfgCIdBpT5U7ElyPh/T0bXNGprsfa3V8DSt
         7Tub5LKllSyqzBTT6AuAdxpPkDLQbz79+uGOB8jMfe9/7ZWjiAYYoJIz4IBSpx762vij
         MgWxGEBT48SAuapEwntW/SUnMj54L9QUVITD7jvIME8pg0yvSnug2sVhYDtQlMyCLIRR
         oRkQXQy2GwH5Kq7RnF3l6xGwsOExEbkwE2gbil9tDR4ksW65hUToiUEBS1GUEr6Kmj8U
         gfHcqUhzgdoALSe550NiGZ/CZNFbSBO6lOmmWTDKrVPxTGAEw9f/wd1QzenBg0J/gbuL
         QkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feOMts/VuZSIeHiNfKMOMQaa2Lngj60rb3I4zPEV1nE=;
        b=vEndaZI+EYMFGmqKrkT5IpLLDb1n9aCEjpWPEKJyj/xJfNmSTgJYIbhjlqAZzSdQKC
         C1n5sHtUku62S4xZbTdWxku5KeX5TjUygQ62SbY4LjCIbtR66Lpve0eU5qQ5Q8f2L1zc
         hzpDPYcmFpkdS7eYGRCEIvu1miO1KYKgZEzx4D/NR81IqmSFzQ3Lb1TZW0aITgBAgsz7
         PyVsgCpzgw4Bs4tN/yajudqdqRfY3iyQGOwwY/dluEfecmyuTVHiovcYewyee1rs5/xS
         DS6dIarWwBaSNQ+BvGT/MFcNch11977SDtSb1rjSZISfOPUDo21bHXx02Lws8tF7bhX8
         /CvQ==
X-Gm-Message-State: AOAM531FsVkjwtcZWTdeeAG9uLA5c102jg9yQ1QZ9wx8naiQ2WDbCLWU
	orAQoMQp+Toe6qgOBRw++fQ=
X-Google-Smtp-Source: ABdhPJxIwH4c5C0ZLb6rha+vdwojSirx7a3+VcyQmS6YlhYPt2JMS1+sU1SJOlQ41vMAnvpIGxNzLg==
X-Received: by 2002:a17:90b:17c6:b0:1e2:ab17:a8f9 with SMTP id me6-20020a17090b17c600b001e2ab17a8f9mr10709855pjb.68.1653900497365;
        Mon, 30 May 2022 01:48:17 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k184-20020a6324c1000000b003c14af50615sm8122929pgk.45.2022.05.30.01.48.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 May 2022 01:48:16 -0700 (PDT)
Date: Mon, 30 May 2022 16:48:43 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Message-ID: <20220530164843.00002283.zbestahu@gmail.com>
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
References: <20220530075114.918874-1-o451686892@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 30 May 2022 15:51:14 +0800
Weizhao Ouyang <o451686892@gmail.com> wrote:

> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Good catch.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 95efc127b2ba..94d2cb970644 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = COLLECT_PRIMARY_FOLLOWED }
> +	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
>  
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);

