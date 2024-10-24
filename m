Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAF9AEC86
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 18:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729788531;
	bh=LnAWWsM9ROws4/S41bMH0QAvy+icSduZLkiq789YHsQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=muFcj0jM7boyLDBrCsBAIyHBNMzuWamOusg0p/EA3ZHxf52XnNMLzrja4xb4N16ZE
	 fxW+jO6J8Pri8fvaiuBomIv/Xa8jgywfK6EKjJ3jTug0wXCZztnGeE6tVuIBA5+lhr
	 rmQd+GwoK1nfI3/s5U3XqP9FmHn7hvnSxgvnCmmWTktff0sKyF9EZk/tjxZcd1ZoXl
	 ueBUN2Z6dy7VlSbDoShQuG15IxWQmDcA6YNKc904immkVffEogqJm2HX5Xulspd3VP
	 k3KTN1K0MLT79mdwtShgToq2DWzEd7qGa3FVKlEYLnWHSivoAMVtWbMsIISGKSu06g
	 sfx9Kh5yg8b1g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZBh34qw7z3bfK
	for <lists+linux-erofs@lfdr.de>; Fri, 25 Oct 2024 03:48:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729788529;
	cv=none; b=Ei0PVAGQCK9sIFr2zD0cjHKTB9HpirtYO93j7n31bHeDBF7P+s9LjgW2lCwDwR794w4lQK/+BW+u+eRQ/PAn2IbWMs4w+nDB1nqpW0goTEEVWOSZt36W/COuh7GHTCc/Xe4PZ54I6ehRuTvcMXdH2lgzZpM2bBJZZggdB3uX7ZTfeuUOU7UQom2kEOj03pirywGYm/GA6/0cyQt/Qd/r604hR7BdQqlxpZu1LDqeWLFcc4CJLDQa2JJed2Iir0DlRXgShoh1Vi1cJgRy9xsO5mgW+E5QcKAu2xMbLmo6ZSKmao7AzVM+wf8trv8L0WGWOhQpePpicKxxkL0LJtqoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729788529; c=relaxed/relaxed;
	bh=LnAWWsM9ROws4/S41bMH0QAvy+icSduZLkiq789YHsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbj6rmLqhLSutNOTxwNyrfm0crFOIEXF3B8MpIWSLrGjndbIn5h1OFut2Wi4SIm/+bawLmRZrznkXaKmPUOe9k4adTZItQTiQhtQIQuzVNWVkchGwT+0LZiG8rdC8nKBc4045CFzyEQrnQ1/NwZdLx5dhCMUnTFf2y6eEJvqHMhm3UY9tWfiv+HS/ccSQ+0Tle3bUWLgJoivox6YW3ImNBT/qVQVCMxJsh/lMFF0hE4q1nRLnKCKwe86EfAgyTFr0jP2lK4Wm7EyMwe7IDpKG4mwrAqKM5XNM1mpGOCfm2qxl+1SGhTMYWXwMxvwBO7Xx9hzcpL9hlRjd2Pei6MXdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a8d3xtsG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a8d3xtsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZBgz3WjNz2xrJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 25 Oct 2024 03:48:46 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-71e983487a1so841600b3a.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2024 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729788524; x=1730393324; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnAWWsM9ROws4/S41bMH0QAvy+icSduZLkiq789YHsQ=;
        b=a8d3xtsGVs3fQHL1yX2dWndvqvTlttTM0dm7qRKFty+QTvqkWdOSC1AUv3Jr4H/WRL
         P90YXbmi6mtVoG4bSzyDL6c3OrOPjCHhirJIsXsgfoSO1ls7GfD2pCdxzc12MbFgp4Ie
         PxNPLzn/eTkLmXj2ZlHOjKA1h1rzzSHUqu2n2k3XrhcGXR9f58Ep5/+lXnlTRrxwJUmY
         lnyoHenOB1uM6E7/+v+TGi4LTWUqIvsovFyXJilhIHRiWedYTvQRtLetxETSEvXFG2qM
         EJUjhTMkkDZBQV6aoJrUTiXezWXDNADFAaqgqp0xct9JouXtzpI/x1m9BKClgJEReZYr
         swFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788524; x=1730393324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnAWWsM9ROws4/S41bMH0QAvy+icSduZLkiq789YHsQ=;
        b=KIV2t69YCv7jmK3AsjJ5KTTNIZ+KSqFU4N8g3ulG0aRMee/ed40NLwRYYdGOzVBEEL
         CKikPSRx4dloJGQkNqgQ787L8UHvQwQtT9TlU6iC2PDZGN9MvWVtRmsarE4iWYKRgzqr
         tz2e76Ny9KgRNfYJWq2iK5BezJs3Uby7a5jy3PJw6DRIY0xB/MwLgQoxw9B+o/SbWr6j
         L+cv5IldS2aXys9uMo/Edjtr/tH/avpmoovrtnaGpwOwgyn7NyKOgyGkrR62TlAQ7zs2
         vSiP0XU6zbGOR8qvQwnIWEVrsE8MPWd+ApTHqicmy4MlKGvEUgP4gaCaqXIhFMmrZPTp
         8CIQ==
X-Gm-Message-State: AOJu0YxOgsTW7kNOd1W7x/BawN1dogP0OfxOMo0r57vZLou6XGjlgwSN
	M8x80JFAqBzksBlzusuYDWB3dFDCokzxNP1j/pEFL+nDwAwLvRJobrfYSzASCvqegRphe/geZg+
	P+hXJ3Hdght03HoyJlzPkW7AqtC8fLtB0MD4M
X-Google-Smtp-Source: AGHT+IEMs3PCkteq5dd3LXJ4LMS3NMMFJ2SsGVrOyhJLDia9peKcPDH4nCdL0eXigj1vBPmeMv6ZHw2ip8cCfDLFRsw=
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id
 d2e1a72fcca58-72030b992eemr8187192b3a.24.1729788523359; Thu, 24 Oct 2024
 09:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241024094806.634534-1-huangjianan@xiaomi.com>
In-Reply-To: <20241024094806.634534-1-huangjianan@xiaomi.com>
Date: Thu, 24 Oct 2024 09:48:30 -0700
Message-ID: <CAB=BE-QGVZPJizeOceDgjZ-D8JL12AYp8O8Y-qMm2pn+ER-2Jw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: avoid allocating large arrays on the stack
To: Jianan Huang <huangjianan@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: zhaoyifan@sjtu.edu.cn, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Thu, Oct 24, 2024 at 2:49=E2=80=AFAM Jianan Huang via Linux-erofs
<linux-erofs@lists.ozlabs.org> wrote:
>
> The default pthread stack size of bionic is 1M. Use malloc to avoid
> stack overflow.
>
> Signed-off-by: Jianan Huang <huangjianan@xiaomi.com>
> ---
>  lib/compress.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/lib/compress.c b/lib/compress.c
> index cbd4620..47ba662 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -451,31 +451,37 @@ static int z_erofs_fill_inline_data(struct erofs_in=
ode *inode, void *data,
>         return len;
>  }
>
> -static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
> -                                  struct erofs_compress *ec,
> -                                  void *in, unsigned int *insize,
> -                                  void *out, unsigned int *compressedsiz=
e)
> +static int tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
> +                                 struct erofs_compress *ec,
> +                                 void *in, unsigned int *insize,
> +                                 void *out, unsigned int *compressedsize=
)
>  {
>         struct erofs_sb_info *sbi =3D ctx->ictx->inode->sbi;
> -       char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
> +       char *tmp;
>         unsigned int count;
>         int ret =3D *compressedsize;
>
> +       tmp =3D malloc(Z_EROFS_PCLUSTER_MAX_SIZE);
> +       if (!tmp)
> +               return -ENOMEM;
> +
>         /* no need to recompress */
>         if (!(ret & (erofs_blksiz(sbi) - 1)))
> -               return;
> +               return 0;
>
You can move allocation here instead of at the top to avoid malloc
cost if we do not need the tmp.

Also need to free tmp on all the exit paths.

Thanks,
Sandeep.

>         count =3D *insize;
>         ret =3D erofs_compress_destsize(ec, in, &count, (void *)tmp,
>                                       rounddown(ret, erofs_blksiz(sbi)));
>         if (ret <=3D 0 || ret + (*insize - count) >=3D
>                         roundup(*compressedsize, erofs_blksiz(sbi)))
> -               return;
> +               return 0;
>
>         /* replace the original compressed data if any gain */
>         memcpy(out, tmp, ret);
>         *insize =3D count;
>         *compressedsize =3D ret;
> +
> +       return 0;
>  }
>
>  static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx =
*ctx,
> @@ -631,9 +637,14 @@ frag_packing:
>                         goto fix_dedupedfrag;
>                 }
>
> -               if (may_inline && len =3D=3D e->length)
> -                       tryrecompress_trailing(ctx, h, ctx->queue + ctx->=
head,
> -                                       &e->length, dst, &compressedsize)=
;
> +               if (may_inline && len =3D=3D e->length) {
> +                       ret =3D tryrecompress_trailing(ctx, h,
> +                                                    ctx->queue + ctx->he=
ad,
> +                                                    &e->length, dst,
> +                                                    &compressedsize);
> +                       if (ret)
> +                               return ret;
> +               }
>
>                 e->compressedblks =3D BLK_ROUND_UP(sbi, compressedsize);
>                 DBG_BUGON(e->compressedblks * blksz >=3D e->length);
> --
> 2.43.0
>
