Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC88A905D
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 03:09:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kBFTKp9L;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VKfnf3pk4z3cRt
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Apr 2024 11:09:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kBFTKp9L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VKfnY4hWWz3cNQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Apr 2024 11:09:37 +1000 (AEST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-617f8a59a24so2683317b3.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1713402573; x=1714007373; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoXdVN0/O9LFpnc8OiMEwQuJa6xf8yALBMBa/gVZvq4=;
        b=kBFTKp9LvW2YndeRpv5oFK55vCy3g38Fyp550aHFcnHvppmkzlu1w2iREFkDq4e68Y
         wcxBUJ1zxgIkhgWikX1yxjy35vII736siUfiYM9QZp5xSU/JeHYX9PEsqm1/Zes4MSDk
         KL7JkyTM0DeVGEaWoIRT3AVzChvhznodM1hqkKvYasSiTmlPW0xqYIvqA3Z2uKkk0fDn
         yrbhW/odsgMdu3qSyJlKNDE0brnGBgFeTjE1LgL6XhyEZ/9y5Qz6at8TZ1IQBVmd0FTw
         3GlmMh8Ce9lqF7JW5iX2ojvR/kiq2bxbFMmZ3YdAj6shrs5ARrFJl8d+2ao1BQXOY1GH
         jNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402573; x=1714007373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoXdVN0/O9LFpnc8OiMEwQuJa6xf8yALBMBa/gVZvq4=;
        b=LrGzUOUL1bk+HlIYSefMKk2Cg4P71KSy3m7UU/GGaqzOOFsZiUChmrkJvvIRhehkQP
         sQhq3UyrII9x5+yEsXJnE+lUsHX8i2oeJ60qGCDD7w9ilOTeADSDKyICZITVhY3FRNIK
         1340qsWIacbq/MMWE7cwCLzHuHU8bIK/DdWRiNE/LZ9OPzQVJfziGPtwIx3au6trgWEz
         RScYl3wSo/D1Kbq58lPqksBDCF7z/V56ZT3gNEMdC/RAD00kjTIhZ6bzNuYfiHzEqRhw
         oWO/v0yV4crRg7DEUiRa2kGTr/QKQxVycS2T2atyMq9KjxVq709dMSaklXbneyDmxR0f
         DcAQ==
X-Gm-Message-State: AOJu0Yz6+YUALKKkLX4Rxrl+1lSSDvt08wgkMo+nEOybcdR6noz26SSW
	mKbKUTrHYav+z6GvbxV9rHqBvrjOvOllT7wrxTwcz6FhqyTM0UYYm6yAQbibg72g1qyeoyxJAMc
	teBjpjS3C8aTk5LzOw7eLBJ6Ia81lYpVzu4Wzkg==
X-Google-Smtp-Source: AGHT+IFPiBN0WGe9h9FgYJHXsp/VRcU8Hppblv++Ty1jGZHe+d/fAZQ1f+LnY4+aFXnGsUVDyKu6/QGC7PI70a/Ykm4=
X-Received: by 2002:a05:690c:fc7:b0:611:7132:e6ba with SMTP id
 dg7-20020a05690c0fc700b006117132e6bamr1175309ywb.40.1713402572995; Wed, 17
 Apr 2024 18:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240417144251.1845355-1-zhaoyifan@sjtu.edu.cn>
From: Noboru Asai <asai@sijam.com>
Date: Thu, 18 Apr 2024 10:09:22 +0900
Message-ID: <CAFoAo-KboSBKuna87DWQMjphVPorgnYiMMEAf5PPwEhD4hZv=w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: skip the redundant write for
 ztailpacking block
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In this patch, the value of blkaddr in z_erofs_lcluster_index
corresponding to the ztailpacking block in the extent list
is invalid value. It looks that the linux kernel doesn't refer to this
value, but what value is correct?
0 or -1 (EROFS_NULL_ADDR) or don't care?

2024=E5=B9=B44=E6=9C=8817=E6=97=A5(=E6=B0=B4) 23:43 Yifan Zhao <zhaoyifan@s=
jtu.edu.cn>:
>
> z_erofs_merge_segment() doesn't consider the ztailpacking block in the
> extent list and unnecessarily writes it back to the disk. This patch
> fixes this issue by introducing a new `inlined` field in the struct
> `z_erofs_inmem_extent`.
>
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>  include/erofs/dedupe.h | 2 +-
>  lib/compress.c         | 8 ++++++++
>  lib/dedupe.c           | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/erofs/dedupe.h b/include/erofs/dedupe.h
> index 153bd4c..4cbfb2c 100644
> --- a/include/erofs/dedupe.h
> +++ b/include/erofs/dedupe.h
> @@ -16,7 +16,7 @@ struct z_erofs_inmem_extent {
>         erofs_blk_t blkaddr;
>         unsigned int compressedblks;
>         unsigned int length;
> -       bool raw, partial;
> +       bool raw, partial, inlined;
>  };
>
>  struct z_erofs_dedupe_ctx {
> diff --git a/lib/compress.c b/lib/compress.c
> index 74c5707..41628e7 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -572,6 +572,7 @@ nocompression:
>                  */
>                 e->compressedblks =3D 1;
>                 e->raw =3D true;
> +               e->inlined =3D false;
>         } else if (may_packing && len =3D=3D e->length &&
>                    compressedsize < ctx->pclustersize &&
>                    (!inode->fragment_size || ictx->fix_dedupedfrag)) {
> @@ -582,6 +583,7 @@ frag_packing:
>                         return ret;
>                 e->compressedblks =3D 0; /* indicate a fragment */
>                 e->raw =3D false;
> +               e->inlined =3D false;
>                 ictx->fragemitted =3D true;
>         /* tailpcluster should be less than 1 block */
>         } else if (may_inline && len =3D=3D e->length && compressedsize <=
 blksz) {
> @@ -600,6 +602,7 @@ frag_packing:
>                         return ret;
>                 e->compressedblks =3D 1;
>                 e->raw =3D false;
> +               e->inlined =3D true;
>         } else {
>                 unsigned int tailused, padding;
>
> @@ -652,6 +655,7 @@ frag_packing:
>                                 return ret;
>                 }
>                 e->raw =3D false;
> +               e->inlined =3D false;
>                 may_inline =3D false;
>                 may_packing =3D false;
>         }
> @@ -1151,6 +1155,9 @@ int z_erofs_merge_segment(struct z_erofs_compress_i=
ctx *ictx,
>                 ei->e.blkaddr =3D sctx->blkaddr;
>                 sctx->blkaddr +=3D ei->e.compressedblks;
>
> +               if (ei->e.inlined)
> +                       continue;
> +
>                 ret2 =3D blk_write(sbi, sctx->membuf + blkoff * erofs_blk=
siz(sbi),
>                                  ei->e.blkaddr, ei->e.compressedblks);
>                 blkoff +=3D ei->e.compressedblks;
> @@ -1374,6 +1381,7 @@ int erofs_write_compressed_file(struct erofs_inode =
*inode, int fd, u64 fpos)
>                         .compressedblks =3D 0,
>                         .raw =3D false,
>                         .partial =3D false,
> +                       .inlined =3D false,
>                         .blkaddr =3D sctx.blkaddr,
>                 };
>                 init_list_head(&ei->list);
> diff --git a/lib/dedupe.c b/lib/dedupe.c
> index 19a1c8d..aaaccb5 100644
> --- a/lib/dedupe.c
> +++ b/lib/dedupe.c
> @@ -138,6 +138,7 @@ int z_erofs_dedupe_match(struct z_erofs_dedupe_ctx *c=
tx)
>                 ctx->e.partial =3D e->partial ||
>                         (window_size + extra < e->original_length);
>                 ctx->e.raw =3D e->raw;
> +               ctx->e.inlined =3D false;
>                 ctx->e.blkaddr =3D e->compressed_blkaddr;
>                 ctx->e.compressedblks =3D e->compressed_blks;
>                 return 0;
> --
> 2.44.0
>
