Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533C71FA20
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 08:31:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXY7L67t2z3dy3
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 16:31:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fmvauw7D;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=fmvauw7D;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXY7D0RYNz3dwD
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 16:31:33 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b18474cbb6so10499535ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jun 2023 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685687490; x=1688279490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6MtzZnj1Q/JouhrJdG0rUybk5lL9m4qR0mzD08zfjc=;
        b=fmvauw7D+oHP0YomKi7O5iV8roUBztozKZ78JNL/XEZlesQZ6l02IVXreDgPzmEJ/w
         xgXAVCv45FPamAYZkKmMBQCTpHllPRFGruapJwJxL3cDPVYsUoWSp+ACIarcUJOvc1Aq
         H7eZhxM/FyAwQrsnoyCfRI80FUBKAWfX27RgVbTWYNjyfM7yQzHgQzkW9JfC1l0n+III
         j8hda6HBpEwQcO2QPXUV1lAPiHRz9gX7AZmegnsQgmolitCb7J2Q6wwn2qgFNMzPGw7B
         XyFNuIpM0QMOBDTJC5D9YlhhS9FFmwnnxY+KvD72gZKQgD64j5zijYjeZ5RAbO99uDJi
         e+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685687490; x=1688279490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6MtzZnj1Q/JouhrJdG0rUybk5lL9m4qR0mzD08zfjc=;
        b=MuKGfs3KvprjslivQan1lysmWdk2GYALt3idN1fGD6dtuNkvPWReo0dg8+HeTJZ7Fj
         KRe2PE7SxCV+sM5BgxRinCjkICOy5KC9HKWTA+hh6yOqClg7+b1fdO9B5CRqYplBGpz6
         2MTLSdZVwhZkpZVGQND9MIm+wT/w3/vhidN4FckeJkikoOPn1rgSSy8q2GAQ2N5BZmy5
         ztvdjZkxDtdSWc9XFkY5j3lv60fzZ1Vwoc2v+K8ds+e8vfrrARxoHiY7WDg4QxG+KONC
         0IQt04zVS9S3tTvENLBCWC0s7RetVQIme8DVR66e7h9lkTTxO5dDMmUqVRhiycugWili
         T7eg==
X-Gm-Message-State: AC+VfDzMpTXNxnHcF1sCvDNGOQaF+WIejzTvXA+CsMQmC0MtCGnZ6YFy
	Oe5wRUzNilnnN24b51ylltZZgf42rzg=
X-Google-Smtp-Source: ACHHUZ6khm8cdqvngwj1ivnrxs4FEQePQ2PjaH145kWt0GIU0sJ1loPCZ5bv36CO6EwkIug6rYSlOQ==
X-Received: by 2002:a17:902:a986:b0:1b1:9968:53be with SMTP id bh6-20020a170902a98600b001b1996853bemr787519plb.64.1685687490346;
        Thu, 01 Jun 2023 23:31:30 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae4e8e8edasm504754plj.18.2023.06.01.23.31.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Jun 2023 23:31:30 -0700 (PDT)
Date: Fri, 2 Jun 2023 14:39:39 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Noboru Asai <asai@sijam.com>
Subject: Re: [PATCH] erofs-utils: limit pclustersize in
 z_erofs_fixup_deduped_fragment()
Message-ID: <20230602143939.00003b58.zbestahu@gmail.com>
In-Reply-To: <20230602052039.615632-1-asai@sijam.com>
References: <20230602052039.615632-1-asai@sijam.com>
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri,  2 Jun 2023 14:20:39 +0900
Noboru Asai <asai@sijam.com> wrote:

> The variable 'ctx->pclustersize' could be larger than max pclustersize.
> 
> Signed-off-by: Noboru Asai <asai@sijam.com>
> ---
>  lib/compress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 2e1dfb3..e943056 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -359,8 +359,9 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_vle_compress_ctx *ctx,
>  
>  	/* try to fix again if it gets larger (should be rare) */
>  	if (inode->fragment_size < newsize) {
> -		ctx->pclustersize = roundup(newsize - inode->fragment_size,
> -					    erofs_blksiz());
> +		ctx->pclustersize = min(z_erofs_get_max_pclusterblks(inode) * erofs_blksiz(),
> +					roundup(newsize - inode->fragment_size,
> +						erofs_blksiz()));

Looks good to me.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

>  		return false;
>  	}
>  

