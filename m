Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF695823B
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 11:30:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp41g67jsz2yDt
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 19:29:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::932"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tt4Aep/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp41f0PPMz2xfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 19:29:57 +1000 (AEST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-84300fc9800so1582949241.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146194; x=1724750994; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GU+ib55SwosTEGR00XVxXfPeAl62oZ32kSm5gFZVL0=;
        b=Tt4Aep/XzOgFbn+1WDqCqVw8pKZWkmj05FvVWOsXLZ+mVXXy8IVytfRZunAjvXMnCw
         M9vU9OFtgTwEePEEwOM7FAu7e8GzTlSCqnOIw9HiPs0M8N9e80tg9Sae3LuJphha5g3L
         yjuSDq+0/OCj/gqO4q1wID/JgIBfMPjV21iDsCjt9hUdFv10LlbkdvfXPfNG5LMlq5uZ
         aspUIeMOWqPAVtr8IF4Um6KpHTzcu5ISrL0ThBvvSUn9irwO21r/T6Zo/tpxkoCh/uSS
         o7+ENzph9p+KHkjzVjwx9y3HoCC5LXhkFzWVMiB4XeNp/1q/cw1qKuWnc/1/qPUtjK1W
         C0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146194; x=1724750994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GU+ib55SwosTEGR00XVxXfPeAl62oZ32kSm5gFZVL0=;
        b=FrlKo0+llnAhloSEMV4QAYSXuWqF0wT16/nQZ1OdK9e3bUgsBItn51qA6+TVZGNwMJ
         U4kRngse6I9T5AAGcztiqhFbDinnywLKGhsr+OAouSILnWZAvd9l+gEtckIJwe9dXqU9
         xB8X0t6Bqu1aHe8EN3rQ9uKIry6SuwSJ48cztHfhtQH5qc868r0Z9ZryztI9q2hP4qAE
         KjkMNTBtCWi7bCC32HZFsk/2jA4Va6xV8BDs+756JrFHlpwzPVnKsJXK1V4OBN1oty7H
         4wb6schnWdhQYxKvKDUtcphoiTZ39j67Qm2qPlshMsiMC0R0xJtuI817SFI9cM1mqmVn
         FnWg==
X-Gm-Message-State: AOJu0YyzKD2EzWDrW6NSf+GBlsSEzRRjT23Bk8dMnAngKv8hOc6GE5iO
	43PZ9y8yhvnbyXQ8uRB6zVk0C+28sTfRpQ+4LlO7nmfVmE0jSHNDB5dHxAuPfu7zQm/YfUFH/BQ
	yh5/yOQfLFpM0W2aTJgi+7wdqSbY=
X-Google-Smtp-Source: AGHT+IEIYbRgLp4w1V9OzdXHNdXr1RoUsCm776UbA94uFv0+YtzUMfvMszjilV4jsApA1uQBREkczS90OGqvv9AOBcc=
X-Received: by 2002:a05:6122:c96:b0:4f5:1978:d226 with SMTP id
 71dfb90a1353d-4fc6c5abfe1mr14790348e0c.3.1724146194017; Tue, 20 Aug 2024
 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 21:29:42 +1200
Message-ID: <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: allow large folios for compressed files
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 19, 2024 at 2:52=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
> migrate_pages_batch() on large folios") already landed upstream,
> large folios can be safely enabled for compressed inodes since all
> prerequisites already landed in 6.11-rc1.
>
> Stress tests has been working on my fleet for > 20 days without any
> regression.  Besides, users [1] has requested it for months.  Let's
> allow large folios for EROFS full cases upstream now for wider testing.
>
> [1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMC=
q=3DA2qFcA@mail.gmail.com
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thank you, Xiang! We'll run some tests and update you with our findings.

> ---
>  Documentation/filesystems/erofs.rst |  2 +-
>  fs/erofs/inode.c                    | 18 ++++++++----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesyst=
ems/erofs.rst
> index cc4626d6ee4f..c293f8e37468 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -75,7 +75,7 @@ Here are the main features of EROFS:
>
>   - Support merging tail-end data into a special inode as fragments.
>
> - - Support large folios for uncompressed files.
> + - Support large folios to make use of THPs (Transparent Hugepages);
>
>   - Support direct I/O on uncompressed files to avoid double caching for =
loop
>     devices;
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 43c09aae2afc..419432be3223 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -257,25 +257,23 @@ static int erofs_fill_inode(struct inode *inode)
>                 goto out_unlock;
>         }
>
> +       mapping_set_large_folios(inode->i_mapping);
>         if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
>                           "EXPERIMENTAL EROFS subpage compressed block su=
pport in use. Use at your own risk!");
>                 inode->i_mapping->a_ops =3D &z_erofs_aops;
> -               err =3D 0;
> -               goto out_unlock;
> -#endif
> +#else
>                 err =3D -EOPNOTSUPP;
> -               goto out_unlock;
> -       }
> -       inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
> -       mapping_set_large_folios(inode->i_mapping);
> +#endif
> +       } else {
> +               inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
> -       if (erofs_is_fscache_mode(inode->i_sb))
> -               inode->i_mapping->a_ops =3D &erofs_fscache_access_aops;
> +               if (erofs_is_fscache_mode(inode->i_sb))
> +                       inode->i_mapping->a_ops =3D &erofs_fscache_access=
_aops;
>  #endif
> -
> +       }
>  out_unlock:
>         erofs_put_metabuf(&buf);
>         return err;
> --
> 2.43.5
>

Thanks
Barry
