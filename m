Return-Path: <linux-erofs+bounces-1715-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DDD01D4D
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 10:29:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn03X48jlz2yG7;
	Thu, 08 Jan 2026 20:29:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767864568;
	cv=none; b=PjNKIYfpQY+P/Nx/dd8L+lX0fu3EDTlrmbv/Y1BytGXnx9djFELIFiGJ4Pl7wq4lrHgICSRFEmfFQgdqJSpvllnGAr91bB5v+mg2/0b5EK/4FauRnMSWBQRm9RUvEEGaT+g0NhMhLuu9VvkoZ6QC8EDt3AodDcHEMgj80f870askemID2yfag986/jw1RVdutQS+O2wxjlRt0lcaDl2KvxqMpeSfGmz47YCFBDFdrixHddtgH/5We4Vl4/aZKuBS0GcNmmhHGSnw33fH7J88hzJ3C01ebZ6D21tmCK2GpGC8s92idGm9uaSbOb7QQAlhvL85Y351uE3zH8b4mWj/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767864568; c=relaxed/relaxed;
	bh=VquaFlgo888zFZ/mrAdPrnCm/DE4tEpeWYtftgl80iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2PisnRnqzembMv8ZzSCIppgqmFXTDcbQHbiez0OCvgr2SSkwp6+1Eci+MTU5oeoq7XDnx+PGE+7bOgRa4cJ0bUImbJViAzXIltW2XPnEdlXTj1KwSKru8NAt9XQ2tuUtc0L8UGnW/YgIp8TZpmmdzkgE13GCwtL5267aN+Dx4SVeRDHhfnDeF23OqltL7GM0s43AY3hqtcdXbzy6vFoRlCEF9R2ywL9yJuioM24ix8/S2bZ54d0Raf8LOGBtkLpyRNUAUyBi3v2xe1OltQYklN5GjXx7VyZBnd+aXRUMDX5EmeT+cGypzrcQedc81AmI4XKBBAMGDKT6Zy0vcCwxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TEevC8nQ; dkim-atps=neutral; spf=pass (client-ip=209.85.221.48; helo=mail-wr1-f48.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TEevC8nQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.48; helo=mail-wr1-f48.google.com; envelope-from=niuzhiguo84@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn03W2RLXz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 20:29:27 +1100 (AEDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f3273b92so72754f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864504; x=1768469304; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VquaFlgo888zFZ/mrAdPrnCm/DE4tEpeWYtftgl80iI=;
        b=TEevC8nQ56NrNYUVhDq6oB9reHwi8liqJ2etnX3HsQpOVqstAWC7KUWKA0dHpecPdG
         DK0bmGBuChLtd5T4HqTXxpOaYWLk+uiJWs5XskBZy34mKEQZcVmH3GwPe45whQb8Ha7S
         TNJWF9Rlfg7u73Yq0UgsZhvNZlGZe/qcYJ9UxPeMwhl1r4SU89e5OmUJw0h2x2k52tKa
         f52/X7+iXwzrpx/7hk2vBhDMMbRgAMQ3ENB64xLgTRhHGooPOLfmWWVYafCqhNZdu/em
         mTytSxoqCV7N0Df/ZyO6Zmd+4syA5GhRzAVBXvi/xMHWvPY4jUU46XaNBkXbbw1PZf9s
         VAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864504; x=1768469304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VquaFlgo888zFZ/mrAdPrnCm/DE4tEpeWYtftgl80iI=;
        b=vkxR4BdyeIVAmwhV23cptE1HgIiWW4g9SgGh1oZJgmJ1EAciMGRFtMv2G6s8zd6WLz
         HizJ845B5r6uuipyMkXm6F8xQf8EpEOi1SidYLyWAeC5ImEuQsM7UQCrW2v+7sHEXfz3
         +kCYwQwxwpMl+8ibEEGHkzLOOEuCPsbhboOhiA42k6neFsk3zl3mnm4u359tss7ICkgM
         ZXc4uVNLoe/3eVsbYR6wIJZbw2XOTSesNFlYupevXJ59iIBkbLcvuDVeep9LaH6L/S18
         yY5cgB5yFgqnjAPKwA/t06vMqYKfn8LKEGvRwN7d+tBzlFyiXIH0bfbAV+koGlJQiAxd
         rxEA==
X-Gm-Message-State: AOJu0YzZ5bjnbdW17GbtwGCJzRyp9IEsOnVSv07vJOF1VlS9CSplIRA4
	+dMQrza5CssMZFDLqmoTMTuL5wKGP+n9XCVf/UMCVXCEIG4KWuzPmQfP2OMUXhfF/U4U8cR/Fak
	iH1VacfTCDpdahqw4kBj1F3sXhBhDQVQ=
X-Gm-Gg: AY/fxX4ce7X1ROilRLhwRUPyKBW7D3VGnPER6qaCI3OTJjj/jyKjevsC7/xdpDyopbo
	xCJs9JI92ps7gHtuPSZo/MsNfeaWech4vZlPx6fmmSVPSQSV29bX74nTDvqGSEskfEKkyn50VRT
	qbsgK3MozLQYvtq61Yfs64m+3ArYicMTUncpSwz3eK9HO7UhEj0lQjD+rtG76qT4Qe+oLtdmnYd
	LJkeBA8MWySYUPAMdx1uD8Gb4tz2ypO8YF7goF/luMjRaYNNxffFP1csoszwMUZNiczvEb0vyen
	8LnZB44=
X-Google-Smtp-Source: AGHT+IFxBGDIvKAQDqCu4tFy0rBh9d1EPIGf3v8mEMOIMMFor2CZPGFuumsPbdFh1FIttpjECNN55C7d0N5T0B+FVv0=
X-Received: by 2002:a05:6000:2312:b0:430:f431:c0e0 with SMTP id
 ffacd0b85a97d-432c37bf78dmr4224841f8f.8.1767864503876; Thu, 08 Jan 2026
 01:28:23 -0800 (PST)
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
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com> <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 8 Jan 2026 17:28:12 +0800
X-Gm-Features: AQt7F2qIbpf1nLYZMia2xqWz_GyswXTO8PxjpXWOwik2P1KsOZZD46XvR8aFhag
Message-ID: <CAHJ8P3LMqKYZjmMdSWyKv5EQvWvvycfidJiTi02UUBoEhgtXzQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Sheng Yong <shengyong1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=888=
=E6=97=A5=E5=91=A8=E5=9B=9B 11:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
>
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
>
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
>
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
>
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
>
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
>
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
>
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
>
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-back=
ed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timoth=C3=A9e Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Aleks=C3=A9i Naid=C3=A9nov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1wtYN=
=3Dz0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2->v3 RESEND:
>  - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
>    as pointed out by Sheng Yong (APEX will rely on this);
>
>  - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.
>
>  fs/erofs/super.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..5136cda5972a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *=
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
> +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> +                            !inode->i_sb->s_bdev) ||
> +                           inode->i_sb->s_stack_depth) {
> +                               erofs_err(sb, "file-backed mounts cannot =
be applied to stacked fses");
Hi Xiang
Do we need to print s_stack_depth here to distinguish which specific
problem case it is?
Other LGTM based on my basic test. so

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Thanks=EF=BC=81
>                                 return -ENOTBLK;
>                         }
>                 }
> --
> 2.43.5
>

