Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B507E6A6D7E
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Mar 2023 14:54:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PRbLp3mvWz3cFN
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Mar 2023 00:54:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BLZA9X59;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=BLZA9X59;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PRbLh2gKLz301F
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Mar 2023 00:54:02 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so13190949plf.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Mar 2023 05:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677678839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO0fsd+qVnJ+SxEOcQoft+6sPRi8qs63fOYYcr8hwoo=;
        b=BLZA9X59NabmWOD+NfYPCbLrJF5k//RWRGQIscS2e1VYKAw4712k2zp78DJfgc7jyH
         YU+bszy3Z+AoQM8EK8RGg2eKALBrZV2hDmgTRuHyEilkF8ZUakiJ60mgcSzp2zGaLQTH
         YrMpGXuTHDhIYys2X41u+KSDscdkOXBqkh/is66VtxzW2hth4UM8RTuq6qBuGQMt21ME
         2wOwU6ucJ/zIc2n++gSSze9t0R82YNWaCUnTiNJ0VmXvsRHtoi7Oa82Qn3aH1aWfCOZl
         uRRLgAvP+MQWC/GvokxgeO1dFp+BLqxul1rYhGBp7MckfHDiROOWbczCue9BFEEGL93Y
         BQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677678839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO0fsd+qVnJ+SxEOcQoft+6sPRi8qs63fOYYcr8hwoo=;
        b=fvONyrY60tcYW3aiSupgFlA4JgU1oGesHuggTscHDh1VQmDEEmPBcqCtBxr/X/Yp9I
         CC0VLUhdK69O+L5bv48h7LT3Bt6Lxo2l5Ptb0F2DgzZwGNtApDY5bW5h6xCoMdLRQXoT
         aY/2SI54GISx96bq2yq3xyTG464Euaejrw00vEOS1WyivLihgZo+9ZAhDpTaw7AiNz1M
         rLlLuZy/vMs3A9v7NmTk4Tr2XZiL5SyfyEDn65EKfGmY81YBZqa4nSpkqQx2OpLF5xRm
         IN9r188tUP/psgE5LJDUXuEKXXnE2Au/j2AJH3ESfXvWVHTKcQ5Fv1Akx9olpbK2nJRs
         /grw==
X-Gm-Message-State: AO0yUKV8zpKWkK1u0yu/ClIVpocBYp5dqPI6vkhezJ8khPCldlferyRT
	RKM8q3TylAmp+kX//7A+vlKANGZmCT4=
X-Google-Smtp-Source: AK7set/vi2B2weFsBjPMk1nSSU45zHjJfHmenayqYQVZFaOObcebrN4ODvQtC69f9l5y4WS7o+3P1A==
X-Received: by 2002:a17:902:c94f:b0:19c:d663:a31b with SMTP id i15-20020a170902c94f00b0019cd663a31bmr7291788pla.24.1677678839158;
        Wed, 01 Mar 2023 05:53:59 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id ix1-20020a170902f80100b0019ab58f47a6sm8533004plb.105.2023.03.01.05.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Mar 2023 05:53:58 -0800 (PST)
Date: Wed, 1 Mar 2023 22:00:06 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 2/3] erofs-utils: use compressed pclusters to mark
 fragments
Message-ID: <20230301220006.00007467.zbestahu@gmail.com>
In-Reply-To: <20230228185459.117762-2-hsiangkao@linux.alibaba.com>
References: <20230228185459.117762-1-hsiangkao@linux.alibaba.com>
	<20230228185459.117762-2-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed,  1 Mar 2023 02:54:58 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> The decoded lengths of uncompressed pclusters should be
> strictly no more than encoded lengths.
> 
> Fixes: 9fa9b017f773 ("erofs-utils: mkfs: support fragments")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  lib/compress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index 0aaec30..8169990 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -95,7 +95,7 @@ static void z_erofs_write_indexes(struct z_erofs_vle_compress_ctx *ctx)
>  		 * A lcluster cannot have three parts with the middle one which
>  		 * is well-compressed for !ztailpacking cases.
>  		 */
> -		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking);
> +		DBG_BUGON(!ctx->e.raw && !cfg.c_ztailpacking && !cfg.c_fragments);
>  		DBG_BUGON(ctx->e.partial);
>  		type = ctx->e.raw ? Z_EROFS_VLE_CLUSTER_TYPE_PLAIN :
>  			Z_EROFS_VLE_CLUSTER_TYPE_HEAD;
> @@ -457,7 +457,7 @@ frag_packing:
>  			if (ret < 0)
>  				return ret;
>  			ctx->e.compressedblks = 0; /* indicate a fragment */
> -			ctx->e.raw = true;
> +			ctx->e.raw = false;
>  			ctx->fragemitted = true;
>  			fix_dedupedfrag = false;
>  		/* tailpcluster should be less than 1 block */
> @@ -928,7 +928,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
>  		z_erofs_write_indexes(&ctx);
>  		ctx.e.length = inode->fragment_size;
>  		ctx.e.compressedblks = 0;
> -		ctx.e.raw = true;
> +		ctx.e.raw = false;
>  		ctx.e.partial = false;
>  		ctx.e.blkaddr = ctx.blkaddr;
>  	}

