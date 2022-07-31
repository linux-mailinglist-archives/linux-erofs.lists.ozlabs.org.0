Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B922586061
	for <lists+linux-erofs@lfdr.de>; Sun, 31 Jul 2022 20:41:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lwqpx4Gr6z2yT0
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 04:41:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MReIyQgy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::935; helo=mail-ua1-x935.google.com; envelope-from=sjg@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MReIyQgy;
	dkim-atps=neutral
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lwqpr124fz2xG6
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Aug 2022 04:41:38 +1000 (AEST)
Received: by mail-ua1-x935.google.com with SMTP id q46so3781048uaq.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 31 Jul 2022 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dc7oN2I1BttYd2pALVElfCuh4ip/jkLWH2moxIQf9LU=;
        b=MReIyQgyPgu5WqMcnQwRb12eyKUh7FEhIzqUlWJBFraY0Uc0YWXiwhaTZmxZMPSzpD
         mBsuRLqngz/DMGSF/X+SpoMlv3lftDCbzfLsPdB3L9WOb6mOH+02LfiLADjbqHqOqgRq
         tRuk56UxNnZWl2fDg572VoGTS5JAfy1GSt94g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dc7oN2I1BttYd2pALVElfCuh4ip/jkLWH2moxIQf9LU=;
        b=S2bS9LBZWZps9f/MHLIKtZL6QTSYO9K8sqquMPy8x5Oh1wW6Lh2j+2h/0z1YJ9lLRZ
         986W8aWHAGy5VBrA/OyIhryVkvnOQT5YgUzNP6UP6zlTarH+Cnq8OGUrCfRLRSfBopyt
         Z5TI8I7TGKlmD9Mg8WYBDhZmRv2r3Rr2xIPHVGDHM45yR2X79u3xA/u25/F18AD94cMZ
         eoX4uADWFbwM2/Ly8OQlmrzAQNd4sTiGtvZGuRTTDWUS0fDtvn4iAmbFPcRphCMc7TA1
         h8tadEC1kL/CO+1xXva6sEUiZQdIWfrx7SKLHUF3XUPRi3ok7uwvve11owKrN2QGxyyJ
         r8mg==
X-Gm-Message-State: ACgBeo0gfe4Hyh8b37xyGuqH/o4KcwlDIXarCFRh09YB/27cdgKz94+B
	uqRBku7xLMrclODnV4Lyvg9pItqxE8sz7yKSIJF60A==
X-Google-Smtp-Source: AA6agR6FAvr1z6SpLcAwvEPlz1BV/e+sQ5lfZFY85MU9drkJCC06fswLwYYD5hH+UeER9rDxb1cgZ0nwgJuvVnKjs6k=
X-Received: by 2002:ab0:6890:0:b0:385:7893:d6dc with SMTP id
 t16-20020ab06890000000b003857893d6dcmr4821877uar.54.1659292890943; Sun, 31
 Jul 2022 11:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20220731091006.50073-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Jul 2022 12:41:19 -0600
Message-ID: <CAPnjgZ2mXuT5w5SKSeBnzUvBFvtwfmYqjZGWGutPiJ+4-fi_sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs/erofs: silence erofs_probe()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, 31 Jul 2022 at 03:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> fs_set_blk_dev() probes all file-systems until it finds one that matches
> the volume. We do not expect any console output for non-matching
> file-systems.
>
> Convert error messages in erofs_read_superblock() to debug output.
>
> Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/erofs/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 4cca322b9e..095754dc28 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -65,14 +65,14 @@ int erofs_read_superblock(void)
>
>         ret = erofs_blk_read(data, 0, 1);
>         if (ret < 0) {
> -               erofs_err("cannot read erofs superblock: %d", ret);
> +               erofs_dbg("cannot read erofs superblock: %d", ret);
>                 return -EIO;
>         }
>         dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
>
>         ret = -EINVAL;
>         if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
> -               erofs_err("cannot find valid erofs superblock");
> +               erofs_dbg("cannot find valid erofs superblock");
>                 return ret;
>         }
>
> @@ -81,7 +81,7 @@ int erofs_read_superblock(void)
>         blkszbits = dsb->blkszbits;
>         /* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
>         if (blkszbits != LOG_BLOCK_SIZE) {
> -               erofs_err("blksize %u isn't supported on this platform",
> +               erofs_dbg("blksize %u isn't supported on this platform",
>                           1 << blkszbits);

Does this message appear in normal scanning, or is it a genuine error?

>                 return ret;
>         }

> --
> 2.36.1
>
