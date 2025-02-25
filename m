Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BDA44A01
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Feb 2025 19:18:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Qp726smz3bkb
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Feb 2025 05:18:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740507501;
	cv=none; b=Oj98ThtyyM8AKr4VheGZBkHrl1+8sPWigm5SOG2SfpSqwHUwxiFaYPhb2bTlsmGAT2ZKatUzxql8cQ0QaGTEKy1Csne8QAT+idiggkuYY7xAu8cPKJ6tKq903qkMG/kKIgbh8L0wSZsXQKbFqcBBmSeNwPbDsNlnIs0lek8PWdBU55v3RatZlHWVW69rRHnkTwNV0uGTgU4ixCrJ9ecBMpJ8z3Xl8eNo5AjlgiQVrCnDKb58DUKmgoi0iROku7myHtqNJ/80IywnuXP86m64W7Sk3DCoHe7X68IDpG61Ts0fAV+jCgbRf4Pq/QKqmj7ETvkyC6sS3rCqPc6+/5NF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740507501; c=relaxed/relaxed;
	bh=mmwS2AkQSbqBck5DcD/kPL98u8U+cAdcaPfJ+vFuQC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF8lvRfaTmgfhnksnSVSzOpz8XT5wM6+hfulZWA1qS99IEAlADb4GNxufcfERNVd9UGIdYLiaW8FMyoDoFauISd/2eZ+eofV2H8DoFATyn5u/Ufg6O1TOieLCy52bO29NL/hIFLFr0xqTALxgeVQjiO2dFKF3FqpENTwx2Ihz4U3BD+4VnsfT7zp08kFdhoTxhNFdf0vclI3t+5KBHBRUzAK7g1lyX1U+l1UqyXMv2InHXhlyJkZKguTIyw5m+SEdoIq48as2kEzjQVuwhkHc2zRrhon3NVpiox69vhSilz3963DP5JoT6wgdmuJu2XVVDnTat86HOsxfeaFoPQZhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SGoFW9S9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SGoFW9S9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com; envelope-from=jonathanbaror@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2Qp45bM7z2yvl
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Feb 2025 05:18:20 +1100 (AEDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4bfb4853a5dso1621455137.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 25 Feb 2025 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507497; x=1741112297; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmwS2AkQSbqBck5DcD/kPL98u8U+cAdcaPfJ+vFuQC0=;
        b=SGoFW9S9Gg1rMsLcSsbNfwDZKVYSikyzkfQh3M2tuS0L7WxuAq4i1c2/AijtjLbbHJ
         HR3uuG8f02yRHCuX11EVJ6R8W0qjHqSZrfao+V32J54zeud2yeo/vxPmE8fPKGuz4ujM
         rInRZfOkB2eAlOgCryYS/G3Kg6lUGL/M+kRv7Go/44U4ikFxE8+n8gZEY+cMO4zGHc/o
         wgjqT7cpg6wm9UUuZXqjyOofaGMvn6mF73pvGljkjA+kL84Cue/gn4Pp2oEmbWdHRydm
         1jK7p8RI6Yonrjgif1eFZQ3n2pmwD1otpdBn8T7E03avog9fJAnz4ltBXWnmu5pfUp5I
         YxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507497; x=1741112297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmwS2AkQSbqBck5DcD/kPL98u8U+cAdcaPfJ+vFuQC0=;
        b=Z3giYODemcp6ImaiTx1K/2jDk7hPbRrbk6FK6FXjivQ/QDDUOKZgi3h9MVwGqSEhH/
         2MHmMcVQa+WNIHbOnfuZ3246S4e8NmqwNBxA06/vx4jdicIPIm/lJCbAmjPNa/4WHHq8
         zrcbq7w2/t8C9jiBCdM80yO+PT0aMd7xUGS9WdfVuVfxFyOBy49MdF9cCeBmd0uMbe/r
         rTXNnYojYKtj00OxLAg1uUBzKJlZ0nMX0JTDUKnVtd0vVr1d2v66evyi3kwE/vCege4D
         xUQScpELlWgVYtJ0yaWWyKHLwA/a7BHfFHK1AYfsECisSsb2/PnMk8mSWLH4O8H8uuqD
         U/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWWoMc9KUV92s6GHWHuMok7AQKZpDTgvA+iqc22hFFDVfPhTIpGnlT9fRY+Scg3xKXwbBTXhwMJbxYYag==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzbDV9dFz3nXMFCe7aXe1wHIuhRzm9P8ZgytmOUDU5UIZA6T0Uj
	nBPyU8zWJ93S8PGFQ/l+G3h7tdD92A2di70U0W8D/DpLaI5NgY6020A0ktyOrfjjxEaYlIdh9qt
	A0hyzXjK2vRD09eJjfdk2Wet1ng8=
X-Gm-Gg: ASbGncvS7GDfhYLC6YPMH8u2v2Zbbz+p4bu5pfwguvhn74SjkquuUwg0Ap1RQIMsje2
	sHBTsGxcCF1jZcUCuQwDufdFKWF3wDp0S0H6PwI7V3mNWe5/DLQq0hI77E6b9CSKfEwUE0abQyM
	+ncoKq9Ssiu/cOO1DgnK+C1Eiwdwj9UHDWXj0A
X-Google-Smtp-Source: AGHT+IGdVZPzAjvIPrpUHJMFObAoP7915Ib/5ZeV8XkqWoteqSHyRAp5B8xR2CpjEX1rS8BiZz9lKwGHdxc5xj0shyo=
X-Received: by 2002:a05:6102:a48:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4c01e2fa034mr183842137.25.1740507497609; Tue, 25 Feb 2025
 10:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20250207155048.GX1233568@bill-the-cat> <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat> <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat> <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
 <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
 <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com> <20250225175918.GQ1233568@bill-the-cat>
In-Reply-To: <20250225175918.GQ1233568@bill-the-cat>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 25 Feb 2025 10:18:06 -0800
X-Gm-Features: AQ5f1JozKP8s1krTh-yyiWCUjRRD4jXvWfTY-N6OgYhiH7MBQSOwMksWfr1KoMc
Message-ID: <CABMsoEE-WD00LDKVrk9+JcEz09LPEBn=VLut4kziaWPExejdcQ@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>
Content-Type: multipart/alternative; boundary="0000000000001fc183062efb7be6"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
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
Cc: u-boot@lists.denx.de, Joao Marcos Costa <jmcosta944@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000001fc183062efb7be6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Awesome, thanks for the update!

On Tue, Feb 25, 2025, 9:59=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote:

> On Sat, Feb 22, 2025 at 12:47:45PM -0800, Jonathan Bar Or wrote:
>
> > Hello Tom and team,
> >
> > Looks like all of the issues were fixed and merged - am I correct?
> > I intend to make a public disclosure March 19th, is that okay?
>
> Yes, I've merged all of the patches I'm aware of at this point.
>
> >
> > Best,
> >        Jonathan
> >
> > On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@=
gmail.com>
> wrote:
> > >
> > > Please disregard the previous message, those are the actual CVE
> numbers:
> > >
> > > - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> > > - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> > > - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> > > - CVE-2025-26729: EroFS symlink resolution buffer overflow.
> > >
> > > Best regards,
> > >            Jonathan
> > >
> > >
> > > On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <
> jonathanbaror@gmail.com> wrote:
> > > >
> > > > Hi folks.
> > > >
> > > > Here are the CVEs assigned by MITRE:
> > > > - CVE-2025-26721: buffer overflow in the persistent storage for fil=
e
> creation
> > > > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > > > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > > > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > > > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> > > >
> > > > Best regards,
> > > >            Jonathan
> > > >
> > > > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > > > <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > Hello Tom,
> > > > >
> > > > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com>
> wrote:
> > > > >
> > > > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote=
:
> > > > > >> Hi Tom and the rest of the team,
> > > > > >>
> > > > > >> Please let me know about fix time, whether this is acknowledge=
d
> and
> > > > > >> whether you're going to request CVE IDs for those or if I
> should do
> > > > > >> it.
> > > > > >> The reason is that I found similar issues in other bootloaders=
,
> so I'm
> > > > > >> trying to synchronize all of them. For what it's worth, Barebo=
x
> has
> > > > > >> similar issues and are currently fixing.
> > > > > >
> > > > > > Yes, these seem valid. We don't have a CVE requesting authority
> so if
> > > > > > you want them, go ahead and request them. You saw Gao Xiang's
> response
> > > > > > for erofs, and I'm hoping one of the squashfs maintainers will
> chime
> > > > > > in.
> > > > >
> > > > > Either Jo=C3=A3o or me, we will have a look.
> > > > >
> > > > > Thanks,
> > > > > Miqu=C3=A8l
>
> --
> Tom
>

--0000000000001fc183062efb7be6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Awesome, thanks for the update!</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Feb 25, 2025, 9:59=E2=80=AFAM Tom Rini &lt;<a href=
=3D"mailto:trini@konsulko.com">trini@konsulko.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">On Sat, Feb 22, 2025 at 12:47:45PM -0800, Jon=
athan Bar Or wrote:<br>
<br>
&gt; Hello Tom and team,<br>
&gt; <br>
&gt; Looks like all of the issues were fixed and merged - am I correct?<br>
&gt; I intend to make a public disclosure March 19th, is that okay?<br>
<br>
Yes, I&#39;ve merged all of the patches I&#39;m aware of at this point.<br>
<br>
&gt; <br>
&gt; Best,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Jonathan<br>
&gt; <br>
&gt; On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or &lt;<a href=3D=
"mailto:jonathanbaror@gmail.com" target=3D"_blank" rel=3D"noreferrer">jonat=
hanbaror@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Please disregard the previous message, those are the actual CVE n=
umbers:<br>
&gt; &gt;<br>
&gt; &gt; - CVE-2025-26726 :SquashFS directory table parsing buffer overflo=
w<br>
&gt; &gt; - CVE-2025-26727: SquashFS inode parsing buffer overflow.<br>
&gt; &gt; - CVE-2025-26728: SquashFS nested file reading buffer overflow.<b=
r>
&gt; &gt; - CVE-2025-26729: EroFS symlink resolution buffer overflow.<br>
&gt; &gt;<br>
&gt; &gt; Best regards,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Jonathan<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or &lt;<a hr=
ef=3D"mailto:jonathanbaror@gmail.com" target=3D"_blank" rel=3D"noreferrer">=
jonathanbaror@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi folks.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Here are the CVEs assigned by MITRE:<br>
&gt; &gt; &gt; - CVE-2025-26721: buffer overflow in the persistent storage =
for file creation<br>
&gt; &gt; &gt; - CVE-2025-26722: buffer overflow in SquashFS symlink resolu=
tion<br>
&gt; &gt; &gt; - CVE-2025-26723: buffer overflow in EXT4 symlink resolution=
<br>
&gt; &gt; &gt; - CVE-2025-26724: buffer overflow in CramFS symlink resoluti=
on<br>
&gt; &gt; &gt; - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Best regards,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Jonathan<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:miquel.raynal@bootlin.com" target=3D"_=
blank" rel=3D"noreferrer">miquel.raynal@bootlin.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hello Tom,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On 11/02/2025 at 15:29:09 -06, Tom Rini &lt;<a href=3D"=
mailto:trini@konsulko.com" target=3D"_blank" rel=3D"noreferrer">trini@konsu=
lko.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan=
 Bar Or wrote:<br>
&gt; &gt; &gt; &gt; &gt;&gt; Hi Tom and the rest of the team,<br>
&gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt;&gt; Please let me know about fix time, whether thi=
s is acknowledged and<br>
&gt; &gt; &gt; &gt; &gt;&gt; whether you&#39;re going to request CVE IDs fo=
r those or if I should do<br>
&gt; &gt; &gt; &gt; &gt;&gt; it.<br>
&gt; &gt; &gt; &gt; &gt;&gt; The reason is that I found similar issues in o=
ther bootloaders, so I&#39;m<br>
&gt; &gt; &gt; &gt; &gt;&gt; trying to synchronize all of them. For what it=
&#39;s worth, Barebox has<br>
&gt; &gt; &gt; &gt; &gt;&gt; similar issues and are currently fixing.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Yes, these seem valid. We don&#39;t have a CVE req=
uesting authority so if<br>
&gt; &gt; &gt; &gt; &gt; you want them, go ahead and request them. You saw =
Gao Xiang&#39;s response<br>
&gt; &gt; &gt; &gt; &gt; for erofs, and I&#39;m hoping one of the squashfs =
maintainers will chime<br>
&gt; &gt; &gt; &gt; &gt; in.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Either Jo=C3=A3o or me, we will have a look.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; Miqu=C3=A8l<br>
<br>
-- <br>
Tom<br>
</blockquote></div>

--0000000000001fc183062efb7be6--
