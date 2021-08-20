Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F5C3F2D92
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 15:59:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grjst5C59z3cL0
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 23:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=YiBK9xuG;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::129;
 helo=mail-il1-x129.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YiBK9xuG; dkim-atps=neutral
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grjsn1tqtz2xvW
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 23:58:52 +1000 (AEST)
Received: by mail-il1-x129.google.com with SMTP id v2so9622163ilg.12
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=ydDDrw7CNXXOrfgBTvdaJxfxKcA+7e8X9TEeYmuWjfM=;
 b=YiBK9xuGtkXGPGq2k8bEsV+SUmkHu0sAdjYqbXYLfUHF82QCEABzXu+PyravDcdV2G
 tXIAA6sjJHi9cMO5e8ReC+4VYAxPh23nTui1phnfRULwlsdeznii+CRFxLDtAVRT7sFt
 nSYUzTcAS0KSohZwrAix2qvupHM1Jy+ZG2V6+QWCERHeerSUKhbNcSV21oNDR4oeO2zM
 6xZ+0AcongfW2UnJUPz4gKhVDafmRUFaSbLydHw9gpjWDDpO/SnJZoDU8/Ka0jr95MHr
 XpUYFf/zqa/MrcRDhroYiEASrzbcaoYn0kk8TBAYAS0uib493nRpmUsNiPOBeRNAfzcp
 7gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ydDDrw7CNXXOrfgBTvdaJxfxKcA+7e8X9TEeYmuWjfM=;
 b=bTNl+Fyl+qDt1UC5af9X/Ic0FH0ZHHGGBFkqobvVKCV9I0pcAU6Abw6gT/YXGnBDRK
 3IB5/TPucJ7ddJY1T5jcPrQSH6KJ7rEhIB5Sdt5xRshi3lC3v0oU8Nql5vD8l/BWplT1
 E7hTC8nVHMisAPt7Hd8u0r1pq8VnGFtaLxjniunX9/lDRCeO6wi+zJ66ksLKh0MCB+Hx
 K1WC1EqFOZP0FqR8iCQ7cIGtT0apMdHTq4Mb0Gfa+p27gh3aOnDKRE+fRkGcaBN+MEMw
 2uVT+f4YzIc5gR9FXK1Tr6vyUa8evMXzlIOG7AlAa/vt6TQ48FEnNMfiasnGzfDWbO6z
 9lCw==
X-Gm-Message-State: AOAM5331XjVe2uxtHnSDsfTRmmFd1a9GsYtOTfIv1kL3xurpQsoFwBuE
 EuqNclGyHFDoz42zFYA7KQ8kzu7IJAXY/AvK+fo=
X-Google-Smtp-Source: ABdhPJxbJdCmYdIYGiqZ/YEtc7CyOKVUJ5xvgoHN+xft8gR2jU7F0YynxUQerJc7PFGeLvHvbAVd4E55yWZ1feLZ3+s=
X-Received: by 2002:a92:dd12:: with SMTP id n18mr14107436ilm.180.1629467929127; 
 Fri, 20 Aug 2021 06:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
 <20210820132656.GA25885@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CABjEcnFcM+Yib-SzNHBegabTjhoNvv7vH6WAkdZO1Vx13s-9xw@mail.gmail.com>
 <20210820134248.GB25885@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210820134248.GB25885@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 20 Aug 2021 16:58:38 +0300
Message-ID: <CABjEcnFhPRg6unbsprCGSom284bHvnotTLk-s-0K078st_VR5Q@mail.gmail.com>
Subject: Re: An issue with erofsfuse
To: Igor Eisberg <igoreisberg@gmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000016adce05c9fe1128"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000016adce05c9fe1128
Content-Type: text/plain; charset="UTF-8"

Ah yes, silly me, got liblz4-1 confused with liblz4-dev, had to download
the 1.9.3 *.deb packages manually cause apt-get is pushing 1.8.3.
Now everything is working top-notch.

Regarding mkfs.erofs, I know it can take file_contexts, but how should we
handle fs_config, if it's even necessary?

On Fri, 20 Aug 2021 at 16:43, Gao Xiang <xiang@kernel.org> wrote:

> On Fri, Aug 20, 2021 at 04:35:52PM +0300, Igor Eisberg wrote:
> > You're right, this is definitely what's missing:
> >
> > >       linux-vdso.so.1 (0x00007ffeb2163000)
> > >        libfuse.so.2 => /lib/x86_64-linux-gnu/libfuse.so.2
> > > (0x00007ffb2d6b7000)
> > >        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0
> > > (0x00007ffb2d694000)
> > >        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
> (0x00007ffb2d4a3000)
> > >        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2
> (0x00007ffb2d49d000)
> > >        /lib64/ld-linux-x86-64.so.2 (0x00007ffb2d728000)
> > >
> >
> > And actually when running configure, I notice this:
> >
> > > checking lz4.h usability... no
> > > checking lz4.h presence... no
> > > checking for lz4.h... no
> > >
> >
> > Not sure what I'm missing here though...
>
> Maybe "sudo apt install liblz4-dev" for debian.
>
> (Anyway, I may need to add another erofsfuse package for Debian sid,
>  I may seek some time to do this.)
>
> Thanks,
> Gao Xiang
>
> >
> > $ apt list --installed | grep lz4
> > > liblz4-1/now 1.9.3-2 amd64 [installed,local]
> > > lz4/now 1.9.3-2 amd64 [installed,local]
> > >
> >
>

--00000000000016adce05c9fe1128
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Ah yes, silly me, got=C2=
=A0liblz4-1 confused with liblz4-dev, had to download the 1.9.3 *.deb packa=
ges manually cause=C2=A0apt-get is pushing 1.8.3.</div><div dir=3D"ltr">Now=
 everything is working top-notch.</div><div dir=3D"ltr"><br></div><div>Rega=
rding mkfs.erofs, I know it can take file_contexts, but how should we handl=
e fs_config, if it&#39;s even necessary?</div></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Aug 2021 at =
16:43, Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org">xiang@kernel.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Fri, Aug 20, 2021 at 04:35:52PM +0300, Igor Eisberg wrote:<br>
&gt; You&#39;re right, this is definitely what&#39;s missing:<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0linux-vdso.so.1 (0x00007ffeb2163000)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 libfuse.so.2 =3D&gt; /lib/x86_64-linux=
-gnu/libfuse.so.2<br>
&gt; &gt; (0x00007ffb2d6b7000)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 libpthread.so.0 =3D&gt; /lib/x86_64-li=
nux-gnu/libpthread.so.0<br>
&gt; &gt; (0x00007ffb2d694000)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.so.6 =3D&gt; /lib/x86_64-linux-gn=
u/libc.so.6 (0x00007ffb2d4a3000)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 libdl.so.2 =3D&gt; /lib/x86_64-linux-g=
nu/libdl.so.2 (0x00007ffb2d49d000)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /lib64/ld-linux-x86-64.so.2 (0x00007ff=
b2d728000)<br>
&gt; &gt;<br>
&gt; <br>
&gt; And actually when running configure, I notice this:<br>
&gt; <br>
&gt; &gt; checking lz4.h usability... no<br>
&gt; &gt; checking lz4.h presence... no<br>
&gt; &gt; checking for lz4.h... no<br>
&gt; &gt;<br>
&gt; <br>
&gt; Not sure what I&#39;m missing here though...<br>
<br>
Maybe &quot;sudo apt install liblz4-dev&quot; for debian.<br>
<br>
(Anyway, I may need to add another erofsfuse package for Debian sid,<br>
=C2=A0I may seek some time to do this.)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; $ apt list --installed | grep lz4<br>
&gt; &gt; liblz4-1/now 1.9.3-2 amd64 [installed,local]<br>
&gt; &gt; lz4/now 1.9.3-2 amd64 [installed,local]<br>
&gt; &gt;<br>
&gt; <br>
</blockquote></div>

--00000000000016adce05c9fe1128--
