Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6443C80662A
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 05:29:39 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jplQfhOL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SlPZ85zFsz3cWC
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Dec 2023 15:29:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jplQfhOL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com; envelope-from=qkrwngud825@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SlPZ13H11z3cBH
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Dec 2023 15:29:27 +1100 (AEDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1cdeab6b53so71262166b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 05 Dec 2023 20:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701836964; x=1702441764; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhPpGK+lPkbKeXtbzgVltz/h6IKDj4CgDcxBrO+FyXc=;
        b=jplQfhOLhA8yirOCEN041FJQrwoO2RhooX75xeBPFkr1LUCKBNF8Qeg+aJN7YYi4Pi
         tHjFlwTQU/rqDECFmczM3NMSGEL/YJOqTrDYpdEHh+yQJa+7LfoU3NcdQQzZi+z5FE5D
         0dQeOVZtmilXgBGHmTgpocvmvD9JNA/Ea5W9fe5BdMUZIsU3sGZARMAzhrxIs0MjgGPy
         Thp4gbTY0iJj2VW26F1TSKbY4L5R2WYNJhRqKo8SxJ4StSjy4jsBKxh0FfyuZEGptk2F
         8ABbsl5CrcCSXh4AaOfu8xbWYRSGUYyYsj2ZP6cOP2Z+hvXhwMFC7c7Dj8AZySoa7woS
         BlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701836964; x=1702441764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhPpGK+lPkbKeXtbzgVltz/h6IKDj4CgDcxBrO+FyXc=;
        b=cz5nlfP2Tr0MqPb/vO49fbZ/QyZlV2ItsnNmH9E/eu/2XskP0uN5ZI9nfHXi5WUCWo
         e8mJM2PdJwzGjq/wrT8wps2M7prdokEDOjSMYmSmnisGAps7BFZJumhMyQp37brpqqW4
         VUOEc0JHi0IdGu0o5WZpLpvYVah/32c1Ie+xcJWRlCLnMoGlClL4hg8j6hkchH0Xk0V0
         rYsy+Jiy+xEtfbMPWHa2iF+m1GPtPOAsBhyyfplm/gCWS64s0+EgStV53hpNpsyQfmxC
         EGBaZIvmGynD9fOF3LAwJ3XySLKDlNxxYv6r4xMzYwC5mC4wRHDsB6Yr85bjuzd3MyGo
         SsBw==
X-Gm-Message-State: AOJu0YxNjPKiFe9UEajlVuV+diHPzNhyDp0OQNPBbHoCU/LRz7Vklzyk
	uczvVDRSioGDTDIai4f4UcOU72fEDcooERU7LrEZTw76yPRCse9K
X-Google-Smtp-Source: AGHT+IFX+YSnbuG7FTTfPBQfZz/sg5X/GSkr6MDuZC3YcHr33P7XxHyUPBef78iHHJ3VfiiNq+m3FlglSBnVw+5ayNg=
X-Received: by 2002:a17:906:48d5:b0:a1d:6cbc:c22 with SMTP id
 d21-20020a17090648d500b00a1d6cbc0c22mr597600ejt.41.1701836943755; Tue, 05 Dec
 2023 20:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20231206030758.3760521-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20231206030758.3760521-1-hsiangkao@linux.alibaba.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 6 Dec 2023 13:28:52 +0900
Message-ID: <CAD14+f0aQGPXn_gv9b6O84Jx=H-f3df_266ubZVS2TFONp1hag@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix lz4 inplace decompression
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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

Hi Gao,

Thanks for the timely fix.
This also fixes the issue.

Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>

Might wanna add
Cc: stable@vger.kernel.org # 5.4+
but it seems like this doesn't apply cleanly for 5.4, 5.10 and 5.15
also requires some manual conflict resolution. :))

Wrote some nits below:

On Wed, Dec 6, 2023 at 12:08=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Currently EROFS can map another compressed buffer for inplace
> decompression, which was used to handle the cases that some pages of
> compressed data are actually not in-place I/O.
>
> However, like most simple LZ77 algorithms, LZ4 expects the compressed
> data is arranged at the end of the decompressed buffer and it
> explicitly uses memmove() to handle overlapping:
>   __________________________________________________________
>  |_ direction of decompression --> ____ |_ compressed data _|
>
> Although EROFS arranges compressed data like this, it typically map two
> individual virtual buffers so the relative order is uncertain.
> Previously, it was hardly observed since LZ4 only uses memmove() for
> short overlapped literals and x86/arm64 memmove implementations seem to
> completely cover it up so they don't have this issue.  Juhyung reported
> that EROFS data corruption can be found on a new Intel x86 processor.
> After some analysis, it seems that recent x86 processors with the new
> FSRM feature expose this issue with "rep movsb".
>
> Let's strictly use the decompressed buffer for lz4 inplace
> decompression for now.  Later, as an useful improvement, we could try
> to tie up these two buffers together in the correct order.
>
> Reported-by: Juhyung Park <qkrwngud825@gmail.com>
> Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJ=
SmTyd6zSYR2Q@mail.gmail.com
> Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace=
")
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 back=
end")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi Juhyung,
> Please help check if this patch resolves your issue.
> Also, I will test it in various hardware configurations first as well.
>
>  fs/erofs/decompressor.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 5ec11f5024b7..5905d7c4d1db 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -121,11 +121,11 @@ static int z_erofs_lz4_prepare_dstpages(struct z_er=
ofs_lz4_decompress_ctx *ctx,
>  }
>
>  static void *z_erofs_lz4_handle_overlap(struct z_erofs_lz4_decompress_ct=
x *ctx,
> -                       void *inpage, unsigned int *inputmargin, int *map=
type,
> -                       bool may_inplace)
> +                       void *inpage, void *out, unsigned int *inputmargi=
n,
> +                       int *maptype, bool may_inplace)
>  {
>         struct z_erofs_decompress_req *rq =3D ctx->rq;
> -       unsigned int omargin, total, i, j;
> +       unsigned int omargin, total, i;
>         struct page **in;
>         void *src, *tmp;
>
> @@ -135,20 +135,19 @@ static void *z_erofs_lz4_handle_overlap(struct z_er=
ofs_lz4_decompress_ctx *ctx,
>                     omargin < LZ4_DECOMPRESS_INPLACE_MARGIN(rq->inputsize=
))
>                         goto docopy;
>
> -               for (i =3D 0; i < ctx->inpages; ++i) {
> -                       DBG_BUGON(rq->in[i] =3D=3D NULL);
> -                       for (j =3D 0; j < ctx->outpages - ctx->inpages + =
i; ++j)
> -                               if (rq->out[j] =3D=3D rq->in[i])
> -                                       goto docopy;
> -               }
> +               for (i =3D 0; i < ctx->inpages; ++i)
> +                       if (rq->out[ctx->outpages - ctx->inpages + i] !=
=3D
> +                           rq->in[i])
> +                               goto docopy;

Linux kernel coding guideline recommends placing braces on multi-line
nested condition statements.
See https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.6#n225

> +               kunmap_local(inpage);
> +               *maptype =3D 3;
> +               return out + ((ctx->outpages - ctx->inpages) << PAGE_SHIF=
T);
>         }
> -

Unnecessary diff?

>         if (ctx->inpages <=3D 1) {
>                 *maptype =3D 0;
>                 return inpage;
>         }
>         kunmap_local(inpage);
> -       might_sleep();
>         src =3D erofs_vm_map_ram(rq->in, ctx->inpages);
>         if (!src)
>                 return ERR_PTR(-ENOMEM);
> @@ -204,12 +203,12 @@ int z_erofs_fixup_insize(struct z_erofs_decompress_=
req *rq, const char *padbuf,
>  }
>
>  static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx =
*ctx,
> -                                     u8 *out)
> +                                     u8 *dst)
>  {
>         struct z_erofs_decompress_req *rq =3D ctx->rq;
>         bool support_0padding =3D false, may_inplace =3D false;
>         unsigned int inputmargin;
> -       u8 *headpage, *src;
> +       u8 *out =3D dst + rq->pageofs_out, *headpage, *src;

Move this initialization below "/* legacy format could compress extra
data in a pcluster. */" looks better imho.

>         int ret, maptype;
>
>         DBG_BUGON(*rq->in =3D=3D NULL);
> @@ -230,7 +229,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_=
lz4_decompress_ctx *ctx,
>         }
>
>         inputmargin =3D rq->pageofs_in;
> -       src =3D z_erofs_lz4_handle_overlap(ctx, headpage, &inputmargin,
> +       src =3D z_erofs_lz4_handle_overlap(ctx, headpage, dst, &inputmarg=
in,
>                                          &maptype, may_inplace);
>         if (IS_ERR(src))
>                 return PTR_ERR(src);
> @@ -265,7 +264,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_=
lz4_decompress_ctx *ctx,
>                 vm_unmap_ram(src, ctx->inpages);
>         } else if (maptype =3D=3D 2) {
>                 erofs_put_pcpubuf(src);
> -       } else {
> +       } else if (maptype !=3D 3) {
>                 DBG_BUGON(1);
>                 return -EFAULT;
>         }
> @@ -308,7 +307,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_deco=
mpress_req *rq,
>         }
>
>  dstmap_out:
> -       ret =3D z_erofs_lz4_decompress_mem(&ctx, dst + rq->pageofs_out);
> +       ret =3D z_erofs_lz4_decompress_mem(&ctx, dst);
>         if (!dst_maptype)
>                 kunmap_local(dst);
>         else if (dst_maptype =3D=3D 2)
> --
> 2.39.3
>
