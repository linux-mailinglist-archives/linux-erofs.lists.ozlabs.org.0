Return-Path: <linux-erofs+bounces-1678-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A90CF0CDD
	for <lists+linux-erofs@lfdr.de>; Sun, 04 Jan 2026 11:02:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dkXzR24HSz2yFc;
	Sun, 04 Jan 2026 21:02:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767520947;
	cv=none; b=aPYOB8w8Ie1ZG7ThNDUGt6PhAVC5DtyFPgA/zUXCcAiqrN4nQuMEaODcD3LMGACvUwGSYiexZ7cx+RjHipCtMpqyfKjDFkK+FnRPSSCAMQhmN84UlcioDH7a3VbBhjI5Uc7+QVetEYZVr7FWz2iihG272sGKXBXsSQN+HsJAhs9x+giqWAvntOkYjSDOOMCMDq+K0XtNeSEOzA3q1dEgNb/K+B+PtfF4DCXqSL+XPnipnXRpEU2EJ00z+m8bwK9Wh/OCyCPE4xdaYPkCnK/6w/ApVXsqlm24vG197wnXYduBLLZrKBjezpDJES5Ic9HBNGMKBZn80+UYl4+t42BEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767520947; c=relaxed/relaxed;
	bh=KOvoKfWmBFL59R8CXOTlXu+UFWImyFk8EogIGG4S0X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4VuX8JqKNzUNZ4MhVcmUVwlnSQ1R246F0UcHmxBezNPsBfmYoa74Jwbi82Pt1fkBZ9NYII8y9aDVWTBz1N28PcBpwC6ztgDpzDSBBNJHSwXoVb/SwHEmIj6HGeKjEFbFl7mXHpELJ+epNhtUl52PsOtH7KmG7i7gXZVHAqA3j0ICd9TxLZn8pbqSFceEMWpa3JV6E0JPd/pAE/vLZ2jHVkdksO3jZVXUkDgKvWdT2TyxL6oqxWmz3mlqlGz1dAn3+Pf9RhTnrqsudelI+4LqXtrW2jZUYGFtNyP78AgmIEZKz1u8vDK0iL4ZrXI9aNs8jH2KNXMHd4BaTKS7XaxGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fnty7e3d; dkim-atps=neutral; spf=pass (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fnty7e3d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.47; helo=mail-ed1-f47.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dkXzP3kWJz2yFW
	for <linux-erofs@lists.ozlabs.org>; Sun, 04 Jan 2026 21:02:24 +1100 (AEDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so16954295a12.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Jan 2026 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767520881; x=1768125681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOvoKfWmBFL59R8CXOTlXu+UFWImyFk8EogIGG4S0X4=;
        b=Fnty7e3duwAf7CzDieLqM0GQeFg7PRhzJGHrqOaLYAcD4i+Wei+freClOSd2pndufw
         2maXdm8kQ/YdhoCelh/AHRU8/SvdAtOYBnPKDadABPoDr0bDVtk3ah9oORg5Go9hq8CR
         cGUzHjbtkSGDOtJZmtTB1i67tu3Y9bUHjGuKpn0BXimduN0s4i+jROUmfttXtxAme/Bh
         COJsBq0im0NeDqceia4sNW+JF048quWXxJ+CZTG+Mai2QnpTsUX1R/bS0DE/3Bt5q0oR
         Zyk0mKHn3DN1BW1ghL3RvjhMeaZeL6UL2R65pHksQWQtD/O7CAb3KWNnv22dezJ2nFpP
         CfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767520881; x=1768125681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOvoKfWmBFL59R8CXOTlXu+UFWImyFk8EogIGG4S0X4=;
        b=eR1WIhB9KojeuCpzRXmO2vVkb96taep5RfOgsNSu7siYI3Wc+xnkHg1o39Jm05Qtch
         t4AhcVst6DURXTjX1/BGautTWox3vHjH1sEapTPJcVDbOQvzyG0OGuXxYCuqgBgSu86q
         pMaFSz07AB2fs6713WK8N6S1bu2oD4HZhu2lnF1IrA/8Zd+s0SxLaPTrfrV8OR9YHXnl
         z2ogd4hbNB6OHbWDJiNPqD5DlkFVuJLPDF7FO07o3WKzdOM4lvixV3cjkOtO/IgMH3DH
         x0VMGCnxNChzZwA36WdVX3Lg8V17WYFRQmhM+p4l8KA2QuVe/581CT6NfuMo5l0nDsPP
         RvKQ==
X-Gm-Message-State: AOJu0YwIkW/dTpIVooVZvB9fEIDUTYXhHGwMMimvi9fnF0vTrbQgnzl6
	+loWsyEZVZQ1L5j7CKyO4N947mmIXCniinHcuyaEH2E0PrvnN2neGm4OZvgAxurerTrg2onOyO2
	aDP2pwZDEMYq7YFmWVeOPzmkOSstqeJw=
X-Gm-Gg: AY/fxX4SwxNrXvg9oAwAwmrHk/AyrzL6pTG3VohSiGB7NfRyRG/lt8wEVpcxvH978w/
	PP1pVj1ZQyND+2SOsa4ptXCvm42wZH6kl7Zn0zIX9sRlhy+wzjWzcuoNElmEzL9zXOosYzk5m8I
	zVaNfBMwBp2h15y2xqofHw9J0iRr2gmS2bReV1MS9KlDA/B2qrMrFG+X9iPTFtZIMyDJX1dnrRU
	NfyMyfeOLTOu7Ml2gXSlMOPtBj5M4VGpAat5l/yCKmVkJ7KTYp6ux5XEErqFEAlu0VF549pfKfX
	YcPK2sZzqJ6e4aP1m1qb7/ya+vP8eQ==
X-Google-Smtp-Source: AGHT+IFgzXIgEP98g9kvRhY6kXLma4/bUa9Q+r4FG55GLzemFHDS/EdI/AClCQ33focw/wX7ISuTbQaMbEjGAaPrPoA=
X-Received: by 2002:a05:6402:34cf:b0:64b:5562:c8f7 with SMTP id
 4fb4d7f45d1cf-64b8e944d82mr44615592a12.5.1767520881147; Sun, 04 Jan 2026
 02:01:21 -0800 (PST)
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
 <CAOQ4uxjjxUHr3Tkxo9PkrBUPcYG1C309cYA9EEvk1-oVGcV_Og@mail.gmail.com> <18246672-2c4f-415e-8667-2f826eb4fe19@linux.alibaba.com>
In-Reply-To: <18246672-2c4f-415e-8667-2f826eb4fe19@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 4 Jan 2026 12:01:10 +0200
X-Gm-Features: AQt7F2r5xH2GYoQ31_IAWJObXo5CyrRbewfZMWvlJuqUu_D8Hz8DAyXP-xiO8pI
Message-ID: <CAOQ4uxgWc7sVwikg3uV0Ey0rrGG+X_a5JLkK-bBFpQSAEeTSVw@mail.gmail.com>
Subject: Re: [PATCH] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

[+fsdevel][+overlayfs]

On Sun, Jan 4, 2026 at 4:56=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Amir,
>
> On 2026/1/1 23:52, Amir Goldstein wrote:
> > On Wed, Dec 31, 2025 at 9:42=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stackin=
g
> >> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> >> stack overflow, but it breaks composefs mounts, which need erofs+ovl^2
> >> sometimes (and such setups are already used in production for quite lo=
ng
> >> time) since `s_stack_depth` can be 3 (i.e., FILESYSTEM_MAX_STACK_DEPTH
> >> needs to change from 2 to 3).
> >>
> >> After a long discussion on GitHub issues [1] about possible solutions,
> >> it seems there is no need to support nesting file-backed mounts as one
> >> conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to 3=
).
> >> So let's disallow this right now, since there is always a way to use
> >> loopback devices as a fallback.
> >>
> >> Then, I started to wonder about an alternative EROFS quick fix to
> >> address the composefs mounts directly for this cycle: since EROFS is t=
he
> >> only fs to support file-backed mounts and other stacked fses will just
> >> bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth`
> >> !=3D 0 and the backing inode is not from EROFS instead.
> >>
> >> At least it works for all known file-backed mount use cases (composefs=
,
> >> containerd, and Android APEX for some Android vendors), and the fix is
> >> self-contained.
> >>
> >> Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.
> >>
> >> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-b=
acked mounts")
> >> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1=
]
> >> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1wt=
YN=3Dz0QXwCpec9sXtg@mail.gmail.com
> >> Cc: Amir Goldstein <amir73il@gmail.com>
> >> Cc: Alexander Larsson <alexl@redhat.com>
> >> Cc: Christian Brauner <brauner@kernel.org>
> >> Cc: Miklos Szeredi <mszeredi@redhat.com>
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
> >
> > But you forgot to include details of the stack usage analysis you ran
> > with erofs+ovl^2 setup.
> >
> > I am guessing people will want to see this information before relaxing
> > s_stack_depth in this case.
>
> Sorry I didn't check emails these days, I'm not sure if posting
> detailed stack traces are useful, how about adding the following
> words:

Didn't mean detailed stack traces, but you did some tests with the
new possible setup and you reached stack usage < 8K so  I think this is
something worth mentioning.

>
> Note: There are some observations while evaluating the erofs + ovl^2
> setup with an XFS backing fs:
>
>   - Regular RW workloads traverse only one overlayfs layer regardless of
>     the value of FILESYSTEM_MAX_STACK_DEPTH, because `upperdir=3D` cannot
>     point to another overlayfs.  Therefore, for pure RW workloads, the
>     typical stack is always just:
>       overlayfs + upper fs + underlay storage
>
>   - For read-only workloads and the copy-up read part (ovl_splice_read),
>     the difference can lie in how many overlays are nested.
>     The stack just looks like either:
>       ovl + ovl [+ erofs] + backing fs + underlay storage
>     or
>       ovl [+ erofs] + ext4/xfs + underlay storage
>
>   - The fs reclaim path should be entered only once, so the writeback
>     path will not re-enter.
>
> Sorry about my English, and I'm not sure if it's enough (e.g. FUSE
> passthrough part).  I will look for your further inputs (and other
> acks) before sending this patch upstream.
>

I think that most people will have problems understanding this
rationale not because of the English, but because of the tech ;)
this is a bit too hand wavy IMO.

> (Also btw, i'm not sure if it's possible to optimize read_iter and
>   splice_read stack usage even further in overlayfs, e.g. just
>   recursive handling real file/path directly in the top overlayfs
>   since the permission check is already done when opening the file.)

Maybe so, but LSM permission to open hook is not the same hook
as permission to read/write.

Thanks,
Amir.

