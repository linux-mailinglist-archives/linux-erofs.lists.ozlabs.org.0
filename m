Return-Path: <linux-erofs+bounces-85-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06499A6785C
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Mar 2025 16:51:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHGYH3pVQz2yrn;
	Wed, 19 Mar 2025 02:51:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742313107;
	cv=none; b=BuK9+7Cx6rfdaAZRhXDGpMhb/FuYMHSSb8LYr8fiFQsPXsP8b1INCHZ+S2CsC0rOK7tYsHaVM5dO8e6Q/9k0MhBCCNhRQ8dve2BUjh7FSCQFgTMiR8KED3Y+hIX7nZfaM7mblbY9YeDTK2a0raM2PfznFoeNkbMKP3I1ZfixNz2GKPEM/RhRKdTKKwF8xDu5qn1lQDB45oA2ptwAUkkCEE/Trzjx4xX21D7JiV4nr2LvBXFByg1NWt1Zr4n3eRdUos050Fdw+34sc9AFoTVaec3fGOjUADr2o+iYpXUJaztgapop8HE3fBuCERrWdOgcWOusPQd9H5jdAZaPHZK29g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742313107; c=relaxed/relaxed;
	bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FN9STZ+xKlbxLFTff4fcj+efAOCdPGfDjicWJ7vxtoSg7YbGwsRcFTsSjsI0QuEGPZZXxB8mIKyE/+6sXM8Xr8wGuvYc9GYlrGB31uieGDPGA8klT/zc7ET1HB0Phwid1Cuk/BoMrr7Pi09dTRdTdXl9bTMMvOEo4iORVezp/EkRVPd/VLht+NdRZLPJ2kA3NPGEDMoaXYVxYmDqF/TB5PPJeAYK7g8UmtynFWScJ7+7KmwJH5hqfqsRxNV9Aov5ARsl3Ot9QWMnsfQUByvDI/LmBfOfK+PT+Ech7wlykVyEp9PkebOUNj+1OFQc/MYLRpj1zG1hN/VymWGyxEaReA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WTuBX3XW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WTuBX3XW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=mjguzik@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHGYG1tD2z2yrl
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 02:51:44 +1100 (AEDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so544968166b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 18 Mar 2025 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742313100; x=1742917900; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=WTuBX3XWwND1d85mH10e9YB/1RrdXo/AQE2e+T+cLPNN5d3rxSxTw+GA1o69guCivs
         N/j/7yEeB+M3lQqFu0s9DliacaEhnSbNTIfybRuKRfCzlRV54JYCz3Ywj1nE3Oq3KX+9
         l6iN5cKhIH1Lzk+ENceIvWDRhrb+nJ9G7oLGCF9OzvMISCYPBEVNViI+l2ak+230Qqdj
         WxvzolE5eFspxf14b6dHyhu9B8z+f0tV1jMqxroAe99fw/3J/9IfDVcAl64m0+TrXBTX
         ZZYNoUJSePeruQbUqFgj/J2voORFVmIogH4GC5ReMimC1FVcG6TzRA8ncjlMPuCqRDmd
         6MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313100; x=1742917900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQsfpXrf/4c4YQpb8eNn6gMWmckTaNQ66mxt9z5Ef4E=;
        b=kh3BiArAjPXsxhwGGK64h885h/TmspCBH/2a1rMOhhYOL0/psPMlwqQ1l6gqppWH2Y
         iEpmHuygvfJ8enxMByWejWvbsNPZbVmWwWRXEObOGUc4YuswnzipakNr9br8jjNPC2ju
         siWFPk3IYycz/X2JrvGOebOzP3bYM5O2pKOmad9VLMYf6ypv4iHtAAp7Ej3jI8X39UvG
         Hc0T7fvuS1nHbjdv8EGZYS5PjaAy7i4XI/2/c7gzc2/1Ln4lNq4Gk4snP/UJByK/onBc
         hR3G/RIfbyK4ElbVF8Lv2Yqelo8A47ZTb0gq/66xzI2cPKocHHb6bXjXfIcKrq9+Bghh
         9r6A==
X-Forwarded-Encrypted: i=1; AJvYcCWaWh2lAmStDqOjbEzTDAZ9ocfSFtjRQW3Bi22w86LD2eQ5SI1ciCsNFhYsMY+a/MCY8X/6zOkGsLBKGQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhqHn0y4qHEzwYbBEtnMpqRZMOlcCNu4BmPhkkCQPNdHRL2N7p
	9whS4H32KIoVa+QsuO0Fzn8SflZF9nSEXu9tExPYOdU4in8UY/m4mpre6o8hX4od3J4rJR4Xoes
	oA1QeUBOcaZ3DnrdCTMYLqhvZfRY=
X-Gm-Gg: ASbGncsWKO8WJstOc6pN/OQURku+0DmEbdnwDBIZznpkjkRTAx1IbaT2ljKKS+dFiii
	SuF1ZLXawrixhFuCb5G3OWM5iOhdWDgiuj/vLP6stHunnxzzbAr4Af6v6Caf4LmqI6O8AYbvNWQ
	DI3bMiFK3MpqboT/Fx+LagTRVrhA==
X-Google-Smtp-Source: AGHT+IFjG8edwwuf2mEVeTcyHLZb3BYe7dhVljkptYUqPN1fOMiWWxKawFj8Wyt+UhG++lSQFRDFKNY1P6+HUcVXn7o=
X-Received: by 2002:a17:907:d92:b0:ac1:da09:5d32 with SMTP id
 a640c23a62f3a-ac3301d979bmr1912910866b.6.1742313099481; Tue, 18 Mar 2025
 08:51:39 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
In-Reply-To: <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 18 Mar 2025 16:51:27 +0100
X-Gm-Features: AQ5f1JoIV3Ekgoa3AyaPQZviu6xh4y3D7_TilsaK7QfN_pG3EjUXa6A87nuBb0M
Message-ID: <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Mar 18, 2025 at 4:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Jan 15, 2025 at 10:46:39AM +0100, Christoph Hellwig wrote:
> > Replace int used as bool with the actual bool type for return values th=
at
> > can only be true or false.
> >
> [snip]
>
> > -int lockref_get_not_zero(struct lockref *lockref)
> > +bool lockref_get_not_zero(struct lockref *lockref)
> >  {
> > -     int retval;
> > +     bool retval =3D false;
> >
> >       CMPXCHG_LOOP(
> >               new.count++;
> >               if (old.count <=3D 0)
> > -                     return 0;
> > +                     return false;
> >       ,
> > -             return 1;
> > +             return true;
> >       );
> >
> >       spin_lock(&lockref->lock);
> > -     retval =3D 0;
> >       if (lockref->count > 0) {
> >               lockref->count++;
> > -             retval =3D 1;
> > +             retval =3D true;
> >       }
> >       spin_unlock(&lockref->lock);
> >       return retval;
>
> While this looks perfectly sane, it worsens codegen around the atomic
> on x86-64 at least with gcc 13.3.0. It bisected to this commit and
> confirmed top of next-20250318 with this reverted undoes it.
>
> The expected state looks like this:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        75 0e                   jne    ffffffff81b33626 <lockref_get_not_d=
ead+0x46>
>
> However, with the above patch I see:
>        f0 48 0f b1 13          lock cmpxchg %rdx,(%rbx)
>        40 0f 94 c5             sete   %bpl
>        40 84 ed                test   %bpl,%bpl
>        74 09                   je     ffffffff81b33636 <lockref_get_not_d=
ead+0x46>
>
> This is not the end of the world, but also really does not need to be
> there.
>
> Given that the patch is merely a cosmetic change, I would suggest I gets
> dropped.

fwiw I confirmed clang does *not* have the problem, I don't know about gcc =
14.

Maybe I'll get around to testing it, but first I'm gonna need to carve
out the custom asm into a standalone testcase.

Regardless, 13 suffering the problem is imo a good enough reason to
whack the change.

--=20
Mateusz Guzik <mjguzik gmail.com>

