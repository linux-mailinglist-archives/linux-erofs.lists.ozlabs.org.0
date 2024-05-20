Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B38CA1FE
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 20:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1716229514;
	bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dfQUJD2U6VtA5C7C/hCQgxvXcDd+Ln0uTbniJBZW2m4HgmrLb7mUkK/6mrsMwfSA2
	 bttTd4Y4t4oLXq8M8UcdQ5TCRYznhjYn4bKgoYJSb1zrOaoohxjHEY1Fy1qAw3AKMU
	 BIayV+P/6zOrG6EAE8f9D8uuhrxxaC4D/YKWAlr4LLhPiT+SQbZiiPJzU5oEtWK4b7
	 4AW5FUJMPtCNWjognHXg1/ukdK8Ra5Iwm5MZ4Q90xDt582ArqO35fAk2IZWoWROJyh
	 jKXBjr7BpGvVUlRDXnCGWNUnPe6eaCAkjAZDRgbaqBHi0DJWd+yl6B36xo3nUtj0x1
	 jDV5AMGL7msyg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjmFk63f5z3dTN
	for <lists+linux-erofs@lfdr.de>; Tue, 21 May 2024 04:25:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=aOXN5jUs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjmFZ6nDCz3cZx
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 May 2024 04:25:05 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-34da4d6f543so2566890f8f.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 11:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716229498; x=1716834298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdzEvfu1PEpJBwHmOIv154V3jtL1pSQeI6RYwYyKYZk=;
        b=cgEOb2aqR/nurKi7mNC7/lpqTeQ8bk4qXWDVrmcb9JNi9xTTbizlfqfzlN1/caQw6s
         yAJ4yKr6XM9EWj6r7+rTQTvx9ogTBw9bZGnh3MCl/AUoAFMToPAgDMK+0Bi2SZ7n13Gy
         y8FCjNzYDq7uIbEyG96DyoK44PIURAyTJUd/qlwBpf1RFJLR9viNZfLTILk4dRKcb+HO
         t//LP6KbPORm/z1QxWhfXVMX2MAalL8sbWP6QP2yZuHplpyiqP+enpO9zjbs0BKIAHJS
         qJYNdMQEuGZMQByooIc8fM/uivR4q8G1xtny0q/VPg2fUdPvoXWWZzruYDbebNYimcb4
         d8VA==
X-Gm-Message-State: AOJu0YyGfAIrWKykWsl5NYIYto+eL9rnAh00wX1PEH4r6a91/1L6EOjJ
	jO8t/qzhSMHCZQwekkj0J/x0cUi2tZYMvpZwKJLxezPbDkteSe5av1dV7uD+eIj9vUTIDGFccem
	Bw+12c129KIgVBsiz/xbnPjrI9tF2EbbOTuUt
X-Google-Smtp-Source: AGHT+IHip0D1CwulZkUqzgTRHd4h9KDYjqLHoifTqfHumIM8JPr9kA/cIoKnvUx1OIyjr1GSqMOBTklaXEOXcjT5FEw=
X-Received: by 2002:a05:6000:1a8d:b0:351:b882:4e2b with SMTP id
 ffacd0b85a97d-351b8824ef3mr21104096f8f.63.1716229497450; Mon, 20 May 2024
 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240520090106.2898681-1-hsiangkao@linux.alibaba.com>
Date: Mon, 20 May 2024 11:24:44 -0700
Message-ID: <CAB=BE-Qr5mukXPPqqduH2Rr3cBrkP_WUiJ1udhtfmmrHFmObcQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: avoid allocating DEFLATE streams before mounting
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, May 20, 2024 at 2:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Currently, each DEFLATE stream takes one 32 KiB permanent internal
> window buffer even if there is no running instance which uses DEFLATE
> algorithm.
>
> It's unexpected and wasteful on embedded devices with limited resources
> and servers with hundreds of CPU cores if DEFLATE is enabled but unused.
>
> Fixes: ffa09b3bd024 ("erofs: DEFLATE compression support")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

> ---
>  fs/erofs/decompressor_deflate.c | 55 +++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_defl=
ate.c
> index 81e65c453ef0..3a3461561a3c 100644
> --- a/fs/erofs/decompressor_deflate.c
> +++ b/fs/erofs/decompressor_deflate.c
> @@ -46,39 +46,15 @@ int __init z_erofs_deflate_init(void)
>         /* by default, use # of possible CPUs instead */
>         if (!z_erofs_deflate_nstrms)
>                 z_erofs_deflate_nstrms =3D num_possible_cpus();
> -
> -       for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
> -            ++z_erofs_deflate_avail_strms) {
> -               struct z_erofs_deflate *strm;
> -
> -               strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> -               if (!strm)
> -                       goto out_failed;
> -
> -               /* XXX: in-kernel zlib cannot shrink windowbits currently=
 */
> -               strm->z.workspace =3D vmalloc(zlib_inflate_workspacesize(=
));
> -               if (!strm->z.workspace) {
> -                       kfree(strm);
> -                       goto out_failed;
> -               }
> -
> -               spin_lock(&z_erofs_deflate_lock);
> -               strm->next =3D z_erofs_deflate_head;
> -               z_erofs_deflate_head =3D strm;
> -               spin_unlock(&z_erofs_deflate_lock);
> -       }
>         return 0;
> -
> -out_failed:
> -       erofs_err(NULL, "failed to allocate zlib workspace");
> -       z_erofs_deflate_exit();
> -       return -ENOMEM;
>  }
>
>  int z_erofs_load_deflate_config(struct super_block *sb,
>                         struct erofs_super_block *dsb, void *data, int si=
ze)
>  {
>         struct z_erofs_deflate_cfgs *dfl =3D data;
> +       static DEFINE_MUTEX(deflate_resize_mutex);
> +       static bool inited;
>
>         if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
>                 erofs_err(sb, "invalid deflate cfgs, size=3D%u", size);
> @@ -89,9 +65,36 @@ int z_erofs_load_deflate_config(struct super_block *sb=
,
>                 erofs_err(sb, "unsupported windowbits %u", dfl->windowbit=
s);
>                 return -EOPNOTSUPP;
>         }
> +       mutex_lock(&deflate_resize_mutex);
> +       if (!inited) {
> +               for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstr=
ms;
> +                    ++z_erofs_deflate_avail_strms) {
> +                       struct z_erofs_deflate *strm;
> +
> +                       strm =3D kzalloc(sizeof(*strm), GFP_KERNEL);
> +                       if (!strm)
> +                               goto failed;
> +                       /* XXX: in-kernel zlib cannot customize windowbit=
s */
> +                       strm->z.workspace =3D vmalloc(zlib_inflate_worksp=
acesize());
> +                       if (!strm->z.workspace) {
> +                               kfree(strm);
> +                               goto failed;
> +                       }
>
> +                       spin_lock(&z_erofs_deflate_lock);
> +                       strm->next =3D z_erofs_deflate_head;
> +                       z_erofs_deflate_head =3D strm;
> +                       spin_unlock(&z_erofs_deflate_lock);
> +               }
> +               inited =3D true;
> +       }
> +       mutex_unlock(&deflate_resize_mutex);
>         erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your =
own risk!");
>         return 0;
> +failed:
> +       mutex_unlock(&deflate_resize_mutex);
> +       z_erofs_deflate_exit();
> +       return -ENOMEM;
>  }
>
>  int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
> --
> 2.39.3
>
