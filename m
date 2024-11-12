Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1809C5AE0
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Nov 2024 15:50:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnq8Z2shbz2yhM
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2024 01:50:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731423020;
	cv=none; b=H1z4yd4e60ZpZKj+DtJOG+/2M8l70wmRW6pXH4MqG6MhEfZUmDfCTRpGsGEA+ki5216bsckuaxCrWf9xYM8onGgmvcyWWlLsV6QkwBranGCbD9GQpx0lSvV7fecFN3VuR/PlhifxRcnX+s8wkofhPJKpzk140xLg3k9YbgiJEXZ07ACw6Hm/Zd6j4E+5fIy07cJn2FsYUgzUpb8dShad7EFzX1xurb3nOSemXw0U0dm19HhljGRocdodHp2TZw7f3Fh61vC6iIUq4Xt1x37/x+yMx784PmYjuIVJWQ/ekSLsRhrk+8ZITJ6dsMFjWbRGrQDDM2hNrxoQJnFI+xtW9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731423020; c=relaxed/relaxed;
	bh=L8rXm4egookxAglYbJMQiEd4Icdu2pbrUEJUbkMn52M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMJatYECemOcT7UAIOb4fXNIPxwO1qYKrpKW31cmNbWQCsDd9+QpLE7P4bu5Cpu4XO4/+tEwaHLc25RLNxmrozuQEhdOs6eYzdFLZkRX82Rnn9QkhDprd4EHHw4pIe/Dzj7E3PZUA5T/ay8RyzXri9czC5JqR7N9Sd78NJQcpsUT4Tx/wvpI7pKvAlkmCBSk9QJEPIMkPpoChqeyolCHM0zwZDrgzZi0Zcdw1TAT74VJff5zYxgA+r1/FTswcFe5N9mjN7BLF/gHHspmYOXTXfszi7HFVfrpAyX1dyfK9hHU4GTuiSReGN2iwuQjEs0ib3p5QLXj+WqYWGcuUTQSXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com; dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=C5kaXrF+; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org) smtp.mailfrom=mbaynton.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=mbaynton.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=C5kaXrF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnq8V413jz2xl6
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2024 01:50:17 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-20c8b557f91so62179985ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 12 Nov 2024 06:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1731423015; x=1732027815; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8rXm4egookxAglYbJMQiEd4Icdu2pbrUEJUbkMn52M=;
        b=C5kaXrF+IJFMVR0wjlCIhIjkdB8WsbskHQRblZj0zRcaOJrvpgqG9yy2/zeNTutb5d
         qvUtqQAlqxT78IA8vITKx1cg8M6+IiI79VGYT4cZgxIWD3CSdmPenxxoANkxjdlRojhZ
         WFrMZ+aey3H6rx5cXSNgK6uWhQ0s31Zx7RdnsgWq4VBae9SDk8HFOF42H5xNLHXqFBQK
         Y4S0U1Jw2oQwGW8+hbpXe7fDwuBQeaWUv4QEdAdhG41tVZErKat6buqvKlIvw335JVQ9
         cJVVsTZSEr7nhFlKe+Jvr+d9xVlBwzSgSgHmG76hYwXl0ZTTFewwfp9ZXKi1Gs1atMlK
         QYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423015; x=1732027815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8rXm4egookxAglYbJMQiEd4Icdu2pbrUEJUbkMn52M=;
        b=QZY/26T2k+WMUbEBu2Eb3UeMgKduRE64ZvOL6Hm/MZI3+TYu5ciQrelRCGthgfcl47
         BJgeMYizDBseKR+sxuRahJRZ40vdxnFeUPhzuTO9rvgtMxQm3xMpBZ5hxD1kytIOpvxn
         CLIxn5uHu46r3U9111okIftkvjwep2GNSd7lMjCAnTHlHv94RufTlgsHdwywqVxGMFWO
         UxRbPmkkBfFE5Hlys+5VqzeN7Ok6A6iFMqx11d73SlsytGJll0IduX3C9WFu1+OiOmPy
         V+0RGpdthA9dWmkBYjP1MchypwivJoGtJwPcrOM+dBFFG70BUxG8dcgivD4ZMlGQ8ADQ
         BT3w==
X-Gm-Message-State: AOJu0Ywq/LGtH7DsvLritaN+MaNtlH+AuQUZghtVaacfjuFbGqTqCwbS
	iglV6PUDEOJ2YEE+faehWYHejNR8f4qMuws33/BFmJnZJv6/SuY0+pDRlt9oBqLf/0DqpclrZIm
	nUVmJIxLoF5jHu2LZ48LqLyloHvPWTMUuh4wAEw==
X-Google-Smtp-Source: AGHT+IHHGxHbyx1w4hh7L9ffBZ1t7/73Nx/PjR8YJL5lKEC+whZdesWsThxWTq/k+FI8MvAHwFofkdKBxtvBh8Pw7ZE=
X-Received: by 2002:a17:90b:1d50:b0:2e2:a6ef:d7a6 with SMTP id
 98e67ed59e1d1-2e9b1792ce4mr20132046a91.36.1731423015570; Tue, 12 Nov 2024
 06:50:15 -0800 (PST)
MIME-Version: 1.0
References: <02a3a22d-782b-434b-b3e6-5138f77ee251@linux.alibaba.com>
 <20241111164819.560567-1-mike@mbaynton.com> <71572068-5a5a-4e5f-a1b4-b7f5ed24244d@linux.alibaba.com>
In-Reply-To: <71572068-5a5a-4e5f-a1b4-b7f5ed24244d@linux.alibaba.com>
From: Mike Baynton <mike@mbaynton.com>
Date: Tue, 12 Nov 2024 08:50:03 -0600
Message-ID: <CAM56kJQpLyGhhGdsnJ2P-xgFbhNqzwdzUT2Qu6bfq=uAxGr0Zg@mail.gmail.com>
Subject: Re: [PATCH v2] mkfs: Fix input offset counting in headerball mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: sam@posit.co, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 11, 2024 at 7:05=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Mike,
>
> I will add "erofs-utils:" prefix to the patch subject but no need
> to add "Co-developed-by" tag.
>
> Btw, if some converter for headerball files from tarballs is
> available in public? It'd be better to get some tests for this
> feature.  `ddtaridx` is designed by some other team in Alibaba
> so I don't have a valid simple generator/converter too...

The converter we've made is in Go, could that be incorporated into your tes=
ts?

>
> Thanks,
> Gao Xiang
>
> >
> >   lib/tar.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/tar.c b/lib/tar.c
> > index b32abd4..990c6cb 100644
> > --- a/lib/tar.c
> > +++ b/lib/tar.c
> > @@ -808,13 +808,14 @@ out_eot:
> >       }
> >
> >       dataoff =3D tar->offset;
> > -     if (!(tar->headeronly_mode || tar->ddtaridx_mode))
> > -             tar->offset +=3D st.st_size;
> > +     tar->offset +=3D st.st_size;
> >       switch(th->typeflag) {
> >       case '0':
> >       case '7':
> >       case '1':
> >               st.st_mode |=3D S_IFREG;
> > +             if (tar->headeronly_mode || tar->ddtaridx_mode)
> > +                     tar->offset -=3D st.st_size;
> >               break;
> >       case '2':
> >               st.st_mode |=3D S_IFLNK;
>
