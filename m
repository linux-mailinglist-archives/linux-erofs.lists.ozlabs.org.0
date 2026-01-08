Return-Path: <linux-erofs+bounces-1710-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980FD01923
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 09:25:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmydg44Yxz2xcB;
	Thu, 08 Jan 2026 19:25:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767860727;
	cv=none; b=i+c3+aKJY0VG6X1X4oQQ+RE/fXxPX5ZeUkzikBABqSYVr4vgaWAdCutVHi/uYObzhEbmlnz7S8NYW+Uen9rN/y1eAVuynKPwOqdwU26/UqZ1smW4VQZ2bVDZYWeXpwrTC3xlYUcof/wEOK24xEg+j8YC2Uqzxa+UxriELQMBFPn177QoqG7j12bES0854u7bOvCbJgiNQs/6odjTpwEM8RMmAP+czNZ4KBtIDYr1TQbJwzYV/Wie/KTNregWjXpE+8gfK495sYwek9bU2YlN6IP+OEOgsUAdZnmqx6QlO/LGUpUyl+CRsfJaBykFdhfLYymGgtunHReq6amUgqQ7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767860727; c=relaxed/relaxed;
	bh=M0kq/g9rXrnPRB1mSfblx8o9bXq8xp0GPwblM8E2qws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOOn8AVdyL57lNC/n7N9MRXg5sZJiX7Cc/EoySk9grlx79DhYQmg6a28gr3o05WqUobqmkj/DWLO8SxAUbPd0WaEIi5MbLrLxOyRsuxDR98ys75j4t6HcrrffWzkgfvpq21dACD45NOyIZEzs0TnP/KGJZ04kZy8eMCxh4MsseayyEiPyusmtvNxRu8/vZH1yZRAHt+8Hf2FNOPpI1BaJ9zyB31v+t4IiR/UdHpiLN3g6RILFe7TysdppCUAP63Z77VH3Tv1FkN/Ti7lUUgs/HA5uZlJ7mYuGMzpG5zebsCsNeDHFBk78ufBE8sXNUuKv1Ckaa0tSHaItipbTKRz/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C14FzRKo; dkim-atps=neutral; spf=pass (client-ip=209.85.208.53; helo=mail-ed1-f53.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C14FzRKo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.53; helo=mail-ed1-f53.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmydf4w0Hz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 19:25:26 +1100 (AEDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso3191604a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767860663; x=1768465463; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0kq/g9rXrnPRB1mSfblx8o9bXq8xp0GPwblM8E2qws=;
        b=C14FzRKouM9UZcFLsY6wTDtJASbjO9JXsN6/NxPZ3g/H96+AwNMMY8XF5vyF7Hvo7s
         EreD34FmkJYvLkD1Jrvkaz+hzbQls1Z+o5X9SRwAyhMh6paFPiFQ7tnRYiofTecM5Q43
         361nDaEDlojrTgcaJG57d3vN4WHoKI6VRvRcD3bCL+zcDb3Z0P1+JSQaziXV+roPDGgC
         RtkAp6XP+CfF1Ci2/Lsj+Oyw+W2IJ15UBddkfF4KADwVTagwSLHl1em3Vt9G9/qb2Woz
         9R6qQQxLxQEH1kcTeETtfeWqIwIyFO854V7KcXEDgHgtdyZ8BLOFfcsyHZA5Q57uwv+1
         8jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767860663; x=1768465463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0kq/g9rXrnPRB1mSfblx8o9bXq8xp0GPwblM8E2qws=;
        b=FcH16iFHnvrzBhNq+qSey+i8KMCvsDBSLC3xSX70L0AYLNGZV7w1w7KzIq8Kx7L6vT
         7rWKyM9EHhfUSWEymR8kMdJ6KZegUo+3qZ/5nd3O7eF+QTngUrrQtXvZYGNR7NuEm4fx
         ogZrSfdc+g5D3HPSLWItxdnj+UfI7pn58IF06ewuZQh4FyDcF0NuvfiGaGhQFhKOCapT
         LtkQXSdtpqWHD/Z0EBf2Agd63YVOKjYUdxtut4vXGrUX0Q1up+/GSgFaL8Wvv5v9kkFX
         U9xlT+PLq6y5E8LPExWP9aiUcMlXg8mC7oZqFZlhv2BqSnXjTjQmvYZSuXuBmcaEeJSp
         L7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyywMW8s61oJ8vUtg5k7QIQ3dtFtIVnugIsadm3Asy1PjnDGc78fLEIWd0SrO9Sl/nraErjDX7QCo9hw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxg9JakP+Ivx6D3DUrBks3SGxjsP4WgutEVYo49pg7R7Da9h7gd
	0mQFaLX6aJer4z6EUuphWgk3OaAaxFgqoaFXdNRgRZ2ixYzaBvB6XMhyw9CGr0SwBKO45xSRU9I
	WxKjymJOefh2CTilR5kQxRVspoDw3v5Y=
X-Gm-Gg: AY/fxX7hGVxBtNUWghUdMDxZlAMHjEjoPHW8s7vTtdHhNoHKR+Nq0YKC8JR6G6qEAmt
	uUVpE/9t8/sy9qe0Rx30uUtIAUyPLh41JqpHyzgTZGVFt0vtL5lg2ljQkvepiETJg69VOTtqUCG
	LWRu/oHoforNehTYKe9loVM40LmjyigeChygzpsG6zAKy0sNFKkxmZikrHy5C6igYsjswg7MTfl
	reFVoiPbqnH3GWaNdbcCawAA+mzMHx7+zNe7fR/6V2zQISsyPwb1ARvVzGAqUCuhveVycGcRJ2D
	3O//g6Fojf+2HSsmOJduJTRSDhdC4A==
X-Google-Smtp-Source: AGHT+IGoaDJdrNiEO09pR/OORz2MGC83dXHXdXNvH/C4hxxitjeNsDGXBBSuI3R0yPFQlvG//M05OkqNUDp2Cj1iTkE=
X-Received: by 2002:a05:6402:1288:b0:641:88ff:10ad with SMTP id
 4fb4d7f45d1cf-6507c16e5e4mr6233151a12.14.1767860662681; Thu, 08 Jan 2026
 00:24:22 -0800 (PST)
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
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com> <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com> <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
 <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com> <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
In-Reply-To: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Jan 2026 09:24:11 +0100
X-Gm-Features: AQt7F2pT46wOe25cGycGlgDH7NaWTRhLN1cxNTMu4Gtag81pzvR2eU0rUU1V1nU
Message-ID: <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 8, 2026 at 9:05=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Hi Amir,
>
> On 2026/1/8 16:02, Amir Goldstein wrote:
> > On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote:
>
> ...
>
> >>>>
> >>>> Hi, Xiang
> >>>>
> >>>> In Android APEX scenario, apex images formatted as EROFS are packed =
in
> >>>> system.img which is also EROFS format. As a result, it will always f=
ail
> >>>> to do APEX-file-backed mount since `inode->i_sb->s_op =3D=3D &erofs_=
sops'
> >>>> is true.
> >>>> Any thoughts to handle such scenario?
> >>>
> >>> Sorry, I forgot this popular case, I think it can be simply resolved
> >>> by the following diff:
> >>>
> >>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> >>> index 0cf41ed7ced8..e93264034b5d 100644
> >>> --- a/fs/erofs/super.c
> >>> +++ b/fs/erofs/super.c
> >>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block=
 *sb, struct fs_context *fc)
> >>>                    */
> >>>                   if (erofs_is_fileio_mode(sbi)) {
> >>>                           inode =3D file_inode(sbi->dif0.file);
> >>> -                       if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> >>> +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops && =
!sb->s_bdev) ||
> >>
> >> Sorry it should be `!inode->i_sb->s_bdev`, I've
> >> fixed it in v3 RESEND:
> >
> > A RESEND implies no changes since v3, so this is bad practice.
> >
> >> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.ali=
baba.com
> >>
> >
> > Ouch! If the erofs maintainer got this condition wrong... twice...
> > Maybe better using the helper instead of open coding this non trivial c=
heck?
> >
> > if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> >        erofs_is_fileio_mode(EROFS_I_SB(inode)))
>
> I was thought to use that, but it excludes fscache as the
> backing fs.. so I suggest to use !s_bdev directly to
> cover both file-backed mounts and fscache cases directly.

Your fs, your decision.

But what are you actually saying?
Are you saying that reading from file backed fscache has similar
stack usage to reading from file backed erofs?
Isn't filecache doing async file IO?

If we regard fscache an extra unaccounted layer, because of all the
sync operations that it does, then we already allowed this setup a long
time ago, e.g. fscache+nfs+ovl^2.

This could be an argument to support the claim that stack usage of
file+erofs+ovl^2 should also be fine.

Thanks,
Amir.

