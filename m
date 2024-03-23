Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE6B8876C2
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 03:52:08 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nCR6YBaX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1kHp2FDdz3cB2
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 13:52:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nCR6YBaX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=jnhuang95@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1kHg5xfXz3bq0
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Mar 2024 13:51:58 +1100 (AEDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-60a104601dcso31504777b3.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 22 Mar 2024 19:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711162315; x=1711767115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXa0hTjNufSMPqol5/vOpgqVAiC+2dURCKMQnVtdpJk=;
        b=nCR6YBaXnW3QMf8jNWTp1MRIl8SqQ7h9Oh1FWOC5HcHs+M2qmHOr+5VZb2NGtAjQey
         N1C4oy3+v9V5gDymn9ROXPTEGtSLUoB3qJUG5NAt+DvfCl64yTyqTJBaPIh4E/AD/wBJ
         nQOQUiUgt2HdfLo2XJm+sXEZYm3ooHJtS3I01Zp6nyGrts16klrBqUBQSVbllTi5UDic
         9V/FgbXQmjrYUkIOU0atLwnf301/cRx3zYvgS0re9egd1glW4RKhEwLvaqn/j7T8DYRo
         y1ZNj7gW9YPPBnwPmrvnLafrPJCobtxq8BGPdwYClunMKjpzRc7FXNq5mCYSwKVkt6hn
         TyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711162315; x=1711767115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXa0hTjNufSMPqol5/vOpgqVAiC+2dURCKMQnVtdpJk=;
        b=AH+UxIT43lcBcVVPbMxxcQ+HeFz+fPjhRcfhuOrUPO2UrTfkHT/fu8MiR7hwdS/dR/
         fTMMNZNdUiIXeCqKWFqrlLfdobeoxzBBC2vqxsygf3pARq5O5ujPeQRdX+brgSd/7Pdp
         sbnUR9qaZwqtdPEtCiJEtUf7nqDng1jL4CLOHZVwmTJ4DzKI90FFTPZCyWG4Yg+XejMK
         USaJM79BGAYRe3OmtVhHMrIdY0wbs4lZwmGI0wjaarzWF/S0Est6wKbHnd1oSv8vWcn3
         MZk4zIvDkwwjXKOYr2GXoj72Y/UZCUVqYds8XiDd3r9207DR8C8DdpJ9ZEh55tlmfT6B
         iBfA==
X-Gm-Message-State: AOJu0YyncOe9dDfefdyEiPJaa+9O/D3E4E72PQjVURFcUurgR0/9EX1O
	pPAg/CH4VJuenFnjfcLatdbeoGE52uzWAsNvDk8GD8DJnIJg1leKZMXJrYS0VgxpVcnKL0MdQN1
	IHTeoKpN/hOmGXrQSIFOfS628L78=
X-Google-Smtp-Source: AGHT+IEB1GlaRkmpVG94JJ3Ri4+l4+Y9gCmUhI8HLWZ6DuFx6TL5TIvuwz331ycZJPugK5vEKfH08AAguGeoZ+dBr6U=
X-Received: by 2002:a25:d0c8:0:b0:dcb:b0f0:23fc with SMTP id
 h191-20020a25d0c8000000b00dcbb0f023fcmr1020858ybg.22.1711162315176; Fri, 22
 Mar 2024 19:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240322102421.3780992-1-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240322102421.3780992-1-zhaoyifan@sjtu.edu.cn>
From: Huang Jianan <jnhuang95@gmail.com>
Date: Sat, 23 Mar 2024 10:51:42 +0800
Message-ID: <CAJfKizp5EW3Jg27pizH85oNhGUD4X=VjppxhH94tn_q9S_h1Tw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] erofs-utils: mkfs: introduce inter-file
 multi-threaded compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
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

Hi, Yifan,

I got some warnings and errors via checkpatch.pl on this patchset. You can
check and fix them since erofs-utils follows kernel coding style.

Thanks,
Jianan

Yifan Zhao <zhaoyifan@sjtu.edu.cn> =E4=BA=8E2024=E5=B9=B43=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=94 18:24=E5=86=99=E9=81=93=EF=BC=9A
>
> change log since v2:
> - erofs_queue =3D> erofs_inode_fifo, defined in inode.c
>
> Yifan Zhao (2):
>   erofs-utils: lib: split function logic in inode.c
>   erofs-utils: mkfs: introduce inter-file multi-threaded compression
>
>  include/erofs/compress.h |  16 ++
>  include/erofs/inode.h    |  17 ++
>  include/erofs/internal.h |   3 +
>  lib/compress.c           | 336 +++++++++++++++++++++------------
>  lib/inode.c              | 399 +++++++++++++++++++++++++++++++++------
>  5 files changed, 593 insertions(+), 178 deletions(-)
>
> --
> 2.44.0
>
