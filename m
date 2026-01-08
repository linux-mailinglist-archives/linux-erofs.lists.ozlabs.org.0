Return-Path: <linux-erofs+bounces-1718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE4D028B2
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 13:10:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn3cl6RqRz2yGL;
	Thu, 08 Jan 2026 23:09:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767874199;
	cv=none; b=PMwhGgq05yUCNPsTm/VbUGKJo8hCpYE7dAjRAKVAqemsYypSYASzw0NAIqRlvk2HOThj2WuXBTHkU0/43xr/8naPdpZnOL65yomHSaEetpBAilw8IqpLZKFgJj30nePblCBC5kU4dgaaKjA9NjgGxllvdpHcN6x7rjy6Y6w18Evz0xUyHmUmGl3PrYV/65RCoUSwGgPtXA4TOoFCZQcYxQ2SkjVtnEhfNuxglg+Sx2yWR+2MgqoppKPxpaKOX8VxMNPKKuwO+T7MNBYnxDAGHSJtpAOFcfVXBEOgVtSB3TLqvL9jgmg+NYTM0xb1AWFBBIVZcY1L/j1qJaug4NNBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767874199; c=relaxed/relaxed;
	bh=xWXsVjPSBACvOUrTWUoZ6i3cfhSX/bnB+GsdyHt4Nog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im84spNag4UKqVk0GAkbLJKtW+vgwHbd27Cw/RXSvhb39sTOObERmPUF+h1Wc/02QYEgwcD96OAIE2US1a3eCZScpy4a3PnsZfeSMRtShGw/uF5wza+xZOZ7makhfXG+g9X6JUVZHE5nnYPTbnR/pBZIbjYTh3+g6o88+gRdJAJhs5Gmg985UKYB3e3bdvukGgs6RRq6PyiIu9bgfRAvxIWtZkN3J7exzyNybVj0zj/6MQNMA73H9KGbZlkMxXGG+eNUqa7J625FssTtZl3A9Jec+wRVGQhgi8btNVWStaycQKwUqnHM8oOlTVW23Dkr3CeOhrYJw8uJ69665Gk7eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LchZbn4q; dkim-atps=neutral; spf=pass (client-ip=209.85.208.181; helo=mail-lj1-f181.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LchZbn4q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.181; helo=mail-lj1-f181.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn3cj6nn9z2xjN
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 23:09:56 +1100 (AEDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-382fb535b73so18356151fa.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767874132; x=1768478932; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWXsVjPSBACvOUrTWUoZ6i3cfhSX/bnB+GsdyHt4Nog=;
        b=LchZbn4qfXu+3OP8oR762xHFEVS4/FOy7n7XOWNxm0kd/JT7bL601VwD4KDOxMN/82
         WSS4ZQZrgFcCTMwjdR2eHIHnQQhx1ORZpzIwWptoOIz9YEEH6FZTWwGmyfFG400U9aN5
         PKhlyWl0Ao40qSXliNiMJDVcCYSC2zTPPlC+B1Ug/9tso2Zfbr3+IyfAL5CWdULL4h+i
         pk3xZcaTSh/hDLE0USQobisJxMAvc07ynb41VrrcCoPXzLnvFxTLJ0vhSXe9/LzdmSbb
         3ngkE4dLLzAL2GcoHDf5seki6Nr9bG71MpS06LZVGkc9Q0nSzaW7GukGrOxFq3K+3wxr
         uKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767874132; x=1768478932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWXsVjPSBACvOUrTWUoZ6i3cfhSX/bnB+GsdyHt4Nog=;
        b=USyPoBPrQ3UdmxFinP2ONKQXzi5uENk87AK+y756YUViCZL6+E7NJ+TrkuvIt1QO5g
         vUgfKdIpxyCEckNc7mG73uQe7VX1J+bFm+v8byokz8oQSKSwTFxwjWF2SOMgc0CggwMu
         zJ83GcJ0/06iNdC7N91/9JoH02ItR6XLSMvHFJ6YtTs/ZCVoZPrYYvh+s1O19VGPbsV9
         qabUxU0WwOITItbOiiPx9YxYNJB8FVdp8+tb9b961LX9aJ4c+0tF+OrtyfBaeFPnieA8
         S20UQ98p2Yuq7QXoQGVUOlePw6fHvYX1OkrQj03dzXuNjT8fiUkfDNgv1fJ3AOk9F+zZ
         U14w==
X-Forwarded-Encrypted: i=1; AJvYcCVPsnkrlMPA+CTl5U2gJXB7YVhmzrjrNn3Ez7HR+LNYA0y119COWw9d27a8EaETTXPbymPPz8ONVpsd7Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFMjnpzu85C07MoD+fBzT0GWBZUvKWaFuwcOa/R/1i1+4d3szH
	h8GzinF1MNOD3QfzPfNu3lhwdf7TElufUa8TyyY3F36JyclutswDUtY0wWvjTg==
X-Gm-Gg: AY/fxX4h+pI8hm3RbiD2CxDZpna2AIRxQricYjH0qMJLGYKTvbGH0ujgN5FXYvEbPDZ
	5MP56CzUCN791i6F3sIuU8dMEdKkoMdCI0/7xiQ1jlblaGV/dsritowpAsdRYguCeAWAqtZ9whk
	DizFU3P/wKVJMui0HVlfBT/CraaPc/RuXzBDUN80h7XNBvkahO6wC5V99bj7wMGILHAo+jGGJvm
	ocsfAcfpRPhR505uJu41BMtEdLklyEQMrtE2DwBcO89oq9u7qJUiuvC+z255hSOcB+JhBpopblw
	O9TRITrAnsbqjz8gyjrN95QjlLxCzbUa2mwdZwJMVme1gORHjnNFxwwMNVAceXlbJ4HpBOAjS/p
	YZ+6pygr47yP2ndlxWlAX0FJGbLeCZLr5TVt39o/x2U47GSpwDLwTmeqENb4v2/pm6C8HuV4R+q
	cBqpH9xqyiQLcLzzrHqt2fWVGEKVWSdrxAmXkgdB85/WwGl95GN9Ql
X-Google-Smtp-Source: AGHT+IFmC/s2zmdOBadT/g4NYT+5EdU6A/sY6V1s9b9j38zaQ6W1AyyE0nBMoGSOz8ZyH3UraVUgxg==
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-47d84b3860fmr58019005e9.25.1767867978798;
        Thu, 08 Jan 2026 02:26:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm15478511f8f.36.2026.01.08.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:18 -0800 (PST)
Date: Thu, 8 Jan 2026 10:26:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Sheng Yong
 <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe
 <dusty@dustymabe.com>, =?UTF-8?B?VGltb3Row6ll?= Ravier <tim@siosm.fr>,
 =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, Alexander Larsson
 <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong1@xiaomi.com, linux-erofs mailing list
 <linux-erofs@lists.ozlabs.org>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing
 for now
Message-ID: <20260108102613.33bbc6d4@pumpkin>
In-Reply-To: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
	<20260106170504.674070-1-hsiangkao@linux.alibaba.com>
	<3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
	<41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
	<121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
	<CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
	<4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 8 Jan 2026 16:05:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Amir,
>=20
> On 2026/1/8 16:02, Amir Goldstein wrote:
> > On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.aliba=
ba.com> wrote: =20
>=20
> ...
>=20
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
> >>>> Any thoughts to handle such scenario? =20
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
!sb->s_bdev) || =20
> >>
> >> Sorry it should be `!inode->i_sb->s_bdev`, I've
> >> fixed it in v3 RESEND: =20
> >=20
> > A RESEND implies no changes since v3, so this is bad practice.
> >  =20
> >> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.ali=
baba.com
> >> =20
> >=20
> > Ouch! If the erofs maintainer got this condition wrong... twice...
> > Maybe better using the helper instead of open coding this non trivial c=
heck?
> >=20
> > if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> >        erofs_is_fileio_mode(EROFS_I_SB(inode))) =20
>=20
> I was thought to use that, but it excludes fscache as the
> backing fs.. so I suggest to use !s_bdev directly to
> cover both file-backed mounts and fscache cases directly.

Is it worth just allocating each fs a 'stack needed' value and then
allowing the mount if the total is low enough.
This is equivalent to counting the recursion depth, but lets erofs only
add (say) 0.5.
Ideally you'd want to do static analysis to find the value to add,
but 'inspired guesswork' is probably good enough.

Isn't there also a big difference between recursive mounts (which need
to do read/write on the underlying file) and overlay mounts (which just
pass the request onto the lower filesystem).

	David

>=20
> Thanks,
> Gao Xiang
>=20
> >=20
> > Thanks,
> > Amir. =20
>=20
>=20


