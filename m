Return-Path: <linux-erofs+bounces-1673-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C84ACCED238
	for <lists+linux-erofs@lfdr.de>; Thu, 01 Jan 2026 16:53:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dhrwD1Mf5z2xpk;
	Fri, 02 Jan 2026 02:53:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767282828;
	cv=none; b=MP2dbIH2bUos8T1rt1KrID0XBvqc0fIHJlilErL2xC975NdmBjxuMuvykSMZShtCOxtOZJw1usMt63v7MwXMqEngeQk3VQA7pJRuH8joLQUNAuuhKfYKo1VuHEt6qsaWAgn0jvPF1Mev76TCpSR1fS8SdtJqnyw6zmivPoNLjzwMB2xybnLVzZI1Kyv7ZR8qqS/pjtu06vQ6gp2IfPrDZ5gRFBmybhAwY1+Evb2HnXMGqKZfEBgLD/e0THvUo9S+AhfGRh4bhPu40gbM2mSLIWaa17MsZHN6FLO4yHyYlnjqON5JGA1c3C1tB/IhLo2LYWTZO7sJ0mAnP9RNEUzgug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767282828; c=relaxed/relaxed;
	bh=wNa6g6o2Bf6XzDSHoHhD5WSpJ8zD5+hrW9p/MI2WNas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii+7ELvkBvZ8/8tvzKm0O2j8II3kQ2cCOLo+UUZdqX4J9b7ttgqMgBx3BdLoJGZ954GzFAU8h2ZXkdzV5uVq0ymnwPoKwQzf+sPHNhqdyDIAUuO7YkOITlIvgFdxYY5z3ZkY7in76y3YF7WNMaliOu8ASA5L2iIYCoy2zaATb9PKUBnjmbydyUTtOvWEHAcVHJ5YUGHJXktq/lGk6O506MHslb1msoszb+Izuov1qQZjXaoAhYR8K6JYJztVNL2H3RHRIBnvrSmDsLzEhI2+/v9ma1eJwgAisoW9DWDwHmlcqDenHbk2oiBqzl6zEEW78ESSMtjfl812finOaBRSFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=REosRfCr; dkim-atps=neutral; spf=pass (client-ip=209.85.208.51; helo=mail-ed1-f51.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=REosRfCr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.51; helo=mail-ed1-f51.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dhrwB2qwTz2xjK
	for <linux-erofs@lists.ozlabs.org>; Fri, 02 Jan 2026 02:53:45 +1100 (AEDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64e48264e56so6549264a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Jan 2026 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767282757; x=1767887557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNa6g6o2Bf6XzDSHoHhD5WSpJ8zD5+hrW9p/MI2WNas=;
        b=REosRfCrw/lcBgJhglPivfS5SJYFTXjQcJ5U/+njxeJYOhactFHDi8YfMGNIBWR9+L
         3SlNYkAIKdeFgh+qqtcRy/9/TFkEUti/y1DYrp/mxVtVRAYBPKsqCeuwxBVuwweGYbfZ
         JEik600pTdZaQatmaG0P0hUq2qWhi28VhQn9IKolYrVZvfyI/Ogqoe5VzVBVxFpRHfKE
         IlnyHU1MsSptI2+FXwZv5hoVpOquOci8s+E39g2YwdCGt93e0gJCinfn4rYzzBHDW+EV
         ZThRYknLZFhGNmnJ98myiB3z7UwN2l+j0mZbbvzOFZOcaO6NdjiI+YRp5/ZnymqsEqaA
         pC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767282757; x=1767887557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wNa6g6o2Bf6XzDSHoHhD5WSpJ8zD5+hrW9p/MI2WNas=;
        b=a6so3JA3NUtSOjhDIj5/7fEecHke5qcPM9OieiFeBoQm+ceYqwXujdEyi1x+kwkQPs
         hV+gvxVEeA1BtcWP0JxXwTu3E5yvd+5KCHiu4GvTHm3tcGPn8UaC1dSiwGTkH34tqS7Z
         SYYaeo8BdmQNgKZCXn1s6u2JTcwAwpJpUXdv0lOz3+7k7g+XDaJJDRapaPTfk4A/8ms4
         CRLJWmUe7enbjGOXdCo5Z12XByc9y/w6veC+PwbxQhicZSopkCxn1yD1OPRgqwuw7Y1R
         R3dBqQktXeUUNdEDAtYpFoRmuLtkPLe+Plrm7Z5eSQ0m0Kq/PlYQ4S5IAEuw5y88nY7F
         CnNQ==
X-Gm-Message-State: AOJu0Yz4kVdtUu/2pxs47l2H3dtmWQkQju5bVI0QuEEf2ons7AZcsIu7
	4jpPRYsq44kp7YxVGu3NhzhSlm74R76B4WLYbZXnAqH88xsKPu51FvinDX4zwGSoFltgocVQ+gU
	G/GrlPWGmOMREtlloGH+nt/M/8mekXGs=
X-Gm-Gg: AY/fxX7vI7rLSVOAgWfncM3DSvXYT8Fl5KQWHna8q0S2pws70VfrAiXgYAuJZrHFQ6S
	vb0w7X12uXBNxxSGOa01H1syRim6Z6BGTZqS13/+QLMlkn3CAYaPJFJvmKL7M93XidXrNoGjkGF
	j2HftEJKHG1xLxI9QV4OYw76kJxhdbpakKAdk/nOusCGUC3aIkOyjJmpAKfPqsa3v5X3m53jwgW
	NS2+FfVWj5KXI/5NmVOJrJ+KwPXCr0zNQwDhbt68A9lAS/sjRYU3ps4kCOV+MiErjZJz64lZ11c
	yuXvXvhiKsieEPPLIWAQeDAsGtf9QQ==
X-Google-Smtp-Source: AGHT+IEfiXI2P7Siyhhq//GT8CjB17ar3qbneYXy60BY4e/gfgHp7z6KiEP7cK6VTbtnniVQs3YWVDt9ym/wkskLbEI=
X-Received: by 2002:a05:6402:3491:b0:649:9159:2432 with SMTP id
 4fb4d7f45d1cf-64b8e94767emr39515958a12.3.1767282756670; Thu, 01 Jan 2026
 07:52:36 -0800 (PST)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Jan 2026 17:52:25 +0200
X-Gm-Features: AQt7F2ozbnadfmX1TwYeWwvNOWZ9lIycsqY_gO2zj2EqRbMEaYOFOCwC4MLvge0
Message-ID: <CAOQ4uxjjxUHr3Tkxo9PkrBUPcYG1C309cYA9EEvk1-oVGcV_Og@mail.gmail.com>
Subject: Re: [PATCH] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Dec 31, 2025 at 9:42=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow, but it breaks composefs mounts, which need erofs+ovl^2
> sometimes (and such setups are already used in production for quite long
> time) since `s_stack_depth` can be 3 (i.e., FILESYSTEM_MAX_STACK_DEPTH
> needs to change from 2 to 3).
>
> After a long discussion on GitHub issues [1] about possible solutions,
> it seems there is no need to support nesting file-backed mounts as one
> conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to 3).
> So let's disallow this right now, since there is always a way to use
> loopback devices as a fallback.
>
> Then, I started to wonder about an alternative EROFS quick fix to
> address the composefs mounts directly for this cycle: since EROFS is the
> only fs to support file-backed mounts and other stacked fses will just
> bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth`
> !=3D 0 and the backing inode is not from EROFS instead.
>
> At least it works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
>
> Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.
>
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-back=
ed mounts")
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1wtYN=
=3Dz0QXwCpec9sXtg@mail.gmail.com
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Acked-by: Amir Goldstein <amir73il@gmail.com>

But you forgot to include details of the stack usage analysis you ran
with erofs+ovl^2 setup.

I am guessing people will want to see this information before relaxing
s_stack_depth in this case.

Thanks,
Amir.

>  fs/erofs/super.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..0cf41ed7ced8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>                  * fs contexts (including its own) due to self-controlled=
 RO
>                  * accesses/contexts and no side-effect changes that need=
 to
>                  * context save & restore so it can reuse the current thr=
ead
> -                * context.  However, it still needs to bump `s_stack_dep=
th` to
> -                * avoid kernel stack overflow from nested filesystems.
> +                * context.
> +                * However, we still need to prevent kernel stack overflo=
w due
> +                * to filesystem nesting: just ensure that s_stack_depth =
is 0
> +                * to disallow mounting EROFS on stacked filesystems.
> +                * Note: s_stack_depth is not incremented here for now, s=
ince
> +                * EROFS is the only fs supporting file-backed mounts for=
 now.
> +                * It MUST change if another fs plans to support them, wh=
ich
> +                * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>                  */
>                 if (erofs_is_fileio_mode(sbi)) {
> -                       sb->s_stack_depth =3D
> -                               file_inode(sbi->dif0.file)->i_sb->s_stack=
_depth + 1;
> -                       if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPT=
H) {
> -                               erofs_err(sb, "maximum fs stacking depth =
exceeded");
> +                       inode =3D file_inode(sbi->dif0.file);
> +                       if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> +                           inode->i_sb->s_stack_depth) {
> +                               erofs_err(sb, "file-backed mounts cannot =
be applied to stacked fses");
>                                 return -ENOTBLK;
>                         }
>                 }
> --
> 2.43.5
>

