Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D07D8B1909
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 04:48:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Gp3tO7Hr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VQ0fs0fwYz3d42
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Apr 2024 12:48:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Gp3tO7Hr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b2f; helo=mail-yb1-xb2f.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VQ0fl5ZH7z3cgk
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Apr 2024 12:48:46 +1000 (AEST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-de56d4bb72bso630415276.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1714013324; x=1714618124; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0uVHoorN+j2eB+OLfGCY/voveCGSZaKvdKTatXKctI=;
        b=Gp3tO7Hr/wKnB7pjfqeVWKDlk+GjHZrh++WnbUCLAH7LWP52c60la2Oo1Q1fQYuCyi
         AVqc+nF3oOvr2RV372pQuUIRwm4tRyWRf1cU6VUGAOX3AcTos3G9TRFynbhRpY/GcWuO
         qC8MstcABQsPMJ2qWUrBIkXzaNcplhOCXs4tEC/XIn+k95eSGAcXz6fLbhAh7Sl03WSp
         FQE914oTfhmRtVeEQYQ8G/jaGvGBL+/TLajj15e+a2wYTebUUVOwVNOsUGm4z1OzTFGY
         /PXWP+bCWiZUXfskXge2IrFHLA9lEoq2CooUFz/2xKSS8H8qIFLfBsQ1z985kTgjYmqa
         3+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714013324; x=1714618124;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0uVHoorN+j2eB+OLfGCY/voveCGSZaKvdKTatXKctI=;
        b=K4xI/nzTL49eFe1S/D6kB7I3KWuW5L9zk+VpCXbTYUHh2yO2qAsmriuKNc1pJtvTUx
         NiWFDRFoucv1VXMZaJDI5oBm7+iX5al/pB4S0a8SVUKC9pxMw0OriXtSH37YSsiJDFAV
         HaCtbmq0Ao0yYnrH+A2hJW8mGzhOov37xqbyXB1V4DVNFPMON4OpeJDwvAqHbd0VxH3j
         6MqmEy9GvGR2tVVc0Mn+TZkbfn5+Ywo922L0EXNpc75pAZoixnhfoQYEvq99fooVf+eG
         BSRx1VlTIxWjvS6wHYspWDRCXBtuhPEkmeGbUTjNbhXwaiAuvVbIb1C9OrIhKi41lnd4
         vfCg==
X-Forwarded-Encrypted: i=1; AJvYcCWqpo3w/5m67NxtGZPzoCW4ByFKR2HVt8V2FQEzsCzkV1CttwhUtzocijiJvgqmgbTI0enkyR16z0cnU3XqXvfd1htv4xcvRbmBQZkw
X-Gm-Message-State: AOJu0Yw62UthVc6rxmD9R0uTuWns3yuKjcrh6Z60uF4r+kEvibrNM2Ch
	pNKnXt/4FuFZ35eT3f2wyuoz8C5M5/w1NvrZVRAqufWIsZRGjeGEZET4yPWtHNytaf8x/lQPdbr
	UTfhlODcNv252bHTwdk8wo2rNko8vmfpoWmrtPg==
X-Google-Smtp-Source: AGHT+IG+TQZWbmROmUuvsGBWm+rjKBmwldm3wkHakx0mK1CGc/Wz5JiHdqTdR7brEr1x+ImIdTDIJU9/DSOz0lKKnZE=
X-Received: by 2002:a25:db02:0:b0:dd1:3909:bdd with SMTP id
 g2-20020a25db02000000b00dd139090bddmr3723670ybf.65.1714013324301; Wed, 24 Apr
 2024 19:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240424055923.107209-1-asai@sijam.com> <288873a1-f594-4f5b-b3a1-881ad7ced1cf@linux.alibaba.com>
 <ZijhA4IJFSO7FYUy@debian>
In-Reply-To: <ZijhA4IJFSO7FYUy@debian>
From: Noboru Asai <asai@sijam.com>
Date: Thu, 25 Apr 2024 11:48:33 +0900
Message-ID: <CAFoAo-JvXBe39dLuWVPqb6OTwFMKJOfeqcZ=3QsYCusKsR4-tA@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: add missing block counting
To: Noboru Asai <asai@sijam.com>, linux-erofs@lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

Oh, sorry.
I knew to access i_blkaddr on uncompressed file, but it didn't occur
on the file system for testing, so I overlooked it.
 I needed to be careful.

2024=E5=B9=B44=E6=9C=8824=E6=97=A5(=E6=B0=B4) 19:38 Gao Xiang <xiang@kernel=
.org>:
>
> On Wed, Apr 24, 2024 at 02:15:58PM +0800, Gao Xiang wrote:
> >
> >
> > On 2024/4/24 13:59, Noboru Asai wrote:
> > > Add missing block counting when the data to be inlined is not inlined=
.
> > >
> > > ---
> > > v2:
> > > - move from erofs_write_tail_end() to erofs_prepare_tail_block()
> > >
> > > Signed-off-by: Noboru Asai <asai@sijam.com>
> >
> > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > Thanks,
> > Gao Xiang
>
> I applied the following version since v2 caused CI failure:
> https://github.com/erofs/erofsnightly/actions/runs/8812585654
>
>
> From 89e76dda5fd4956709bbb88b76063ef165fa3882 Mon Sep 17 00:00:00 2001
> From: Noboru Asai <asai@sijam.com>
> Date: Wed, 24 Apr 2024 14:59:23 +0900
> Subject: [PATCH] erofs-utils: add missing block counting
>
> Add missing block counting when the data to be inlined is not inlined.
>
> Signed-off-by: Noboru Asai <asai@sijam.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index 7508c74..896a257 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -664,6 +664,8 @@ static int erofs_prepare_tail_block(struct erofs_inod=
e *inode)
>         } else {
>                 inode->lazy_tailblock =3D true;
>         }
> +       if (is_inode_layout_compression(inode))
> +               inode->u.i_blocks +=3D 1;
>         return 0;
>  }
>
> --
> 2.30.2
>
