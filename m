Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED26A94F7
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 11:14:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PSkNd5ngDz3cct
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Mar 2023 21:14:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=CZa+MC3W;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b2a; helo=mail-yb1-xb2a.google.com; envelope-from=asai@sijam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20210112.gappssmtp.com header.i=@sijam-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=CZa+MC3W;
	dkim-atps=neutral
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PSkNZ17Rnz3083
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Mar 2023 21:14:36 +1100 (AEDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t4so1414345ybg.11
        for <linux-erofs@lists.ozlabs.org>; Fri, 03 Mar 2023 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20210112.gappssmtp.com; s=20210112; t=1677838473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8PVL2FQS+gEaqkoEgMfUwQDNhv2XrV7hN+cvYI/yTxw=;
        b=CZa+MC3WRJL5FPHY36nemHJ2D1P9IfWtPGMBhXqvQ30O8qdhzINmwPKd0j3lXSarFb
         9vDghhlgcqaTt02FdmOJK5MmDVb+1MeKvGLLQ0my00NesA3ai1WZKAAgHRDaIhUvpNpm
         URUlpKn2qFw5ldou6ahm/cIRqJ1lQHGzEMB6ZWfUsVQNrWxWODdCKeqyCQ/VkO+ICLYp
         BeZa+EyGRF3Oyh6R0hkAnven04TF6IRnHgOHz9OsgHQ5qEUH8ljvkl3RHxK3blxWztXC
         deGJlFZ5PafyMufAwWynrnbH7POs8sVoDWW/Xs+8EWpIEaeDujnmDogNCEYj6A6snkF+
         vcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677838473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PVL2FQS+gEaqkoEgMfUwQDNhv2XrV7hN+cvYI/yTxw=;
        b=DayZ6STI60JkmHN1SWQfTERpmOcTJneZqHm25sFVgYhQu7iGo4FufQ+A9IiM4fB8Bk
         PKjeZSHHcaSI8ezxN9rmn5tEAMs71+0Qe42TQLOmyf9D7kSYKEySush+gSHUhX32dKwR
         pn734elV1pfhcajeKda55G8Iy/aqrTLKC4rs5rtDvC89OKdjS4F73if/vaTu009iy46N
         vNugYyQyYRiba79H+3cfTJXvVpSz2OZKewes9sJbJCt3FHJR5RdAO5R/tTfY4XPRZgDH
         6x3ZuEKCkEE1ohOHflwS8bNIt3qNrJL+QRoNzJXAQOmLpk2fHM3vdDByvZq5x3c/2aBI
         vTbg==
X-Gm-Message-State: AO0yUKXy3omXUM+T8QGClU3zmUa5PQZFtefeRQifXPGULp0vTTEWkKbX
	pdaZ45cvbumk6JndmqsMFjL9a3j5Lmcpg2xEqv01tg==
X-Google-Smtp-Source: AK7set/qVfU2Bv7JkeGhDt2RhPT0e5Pyiw8PAdmBw8fpZIZGXoRSxu9T/RMlI8L0NgqwVvCODzOFbqggl/ahu0jXlk4=
X-Received: by 2002:a05:6902:2ca:b0:8a3:d147:280b with SMTP id
 w10-20020a05690202ca00b008a3d147280bmr575760ybh.3.1677838473382; Fri, 03 Mar
 2023 02:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20230303075218.675733-1-asai@sijam.com> <20230303174548.00000b0b.zbestahu@gmail.com>
In-Reply-To: <20230303174548.00000b0b.zbestahu@gmail.com>
From: =?UTF-8?B?5rWF5LqV55m7?= <asai@sijam.com>
Date: Fri, 3 Mar 2023 19:14:22 +0900
Message-ID: <CAFoAo-KXGsd08ugJ-+A4dhsH1cxnizXwbcO1HuCOYmO8U6PX3g@mail.gmail.com>
Subject: Re: [PATCH] erofs: avoid useless memory allocation
To: Yue Hu <zbestahu@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000326b2b05f5fc3679"
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000326b2b05f5fc3679
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2023=E5=B9=B43=E6=9C=883=E6=97=A5(=E9=87=91) 18:39 Yue Hu <zbestahu@gmail.c=
om>:

> On Fri,  3 Mar 2023 16:52:18 +0900
> Noboru Asai <asai@sijam.com> wrote:
>
> > The variable 'vi->xattr_shared_count' could be ZERO.
> >
> > Signed-off-by: Noboru Asai <asai@sijam.com>
> > ---
> >  fs/erofs/xattr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> > index 60729b1220b6..5164813a693b 100644
> > --- a/fs/erofs/xattr.c
> > +++ b/fs/erofs/xattr.c
> > @@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)
> >
> >       ih =3D (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
> >       vi->xattr_shared_count =3D ih->h_shared_count;
> > +     if (!vi->xattr_shared_count)
> > +             goto out_unlock;
>
> Questions: ret =3D 0? no need to erofs_put_metabuf?
>

You are right. this patch needs to call erofs_put_metabuf() before goto
out_unlock.


> I think we can keep current since kmalloc_array() will check whether the
> size(->xattr_shared_count) is zero size or not. rt?
>

In case of xattr_shared_count =3D=3D 0, kmalloc_array() return ZERO_SIZE_PT=
R.
And kfree() do noting in this case (safe).

#define ZERO_SIZE_PTR ((void *)16)



> >       vi->xattr_shared_xattrs =3D kmalloc_array(vi->xattr_shared_count,
> >                                               sizeof(uint), GFP_KERNEL)=
;
> >       if (!vi->xattr_shared_xattrs) {
>
>

--000000000000326b2b05f5fc3679
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">2023=E5=B9=B43=E6=9C=883=E6=97=A5(=E9=87=91) =
18:39 Yue Hu &lt;<a href=3D"mailto:zbestahu@gmail.com" target=3D"_blank">zb=
estahu@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri,=C2=A0 3 Mar 2023 16:52:18 +0900<br>
Noboru Asai &lt;<a href=3D"mailto:asai@sijam.com" target=3D"_blank">asai@si=
jam.com</a>&gt; wrote:<br>
<br>
&gt; The variable &#39;vi-&gt;xattr_shared_count&#39; could be ZERO.<br>
&gt; <br>
&gt; Signed-off-by: Noboru Asai &lt;<a href=3D"mailto:asai@sijam.com" targe=
t=3D"_blank">asai@sijam.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 fs/erofs/xattr.c | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c<br>
&gt; index 60729b1220b6..5164813a693b 100644<br>
&gt; --- a/fs/erofs/xattr.c<br>
&gt; +++ b/fs/erofs/xattr.c<br>
&gt; @@ -80,6 +80,8 @@ static int init_inode_xattrs(struct inode *inode)<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ih =3D (struct erofs_xattr_ibody_header *)(i=
t.kaddr + it.ofs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;xattr_shared_count =3D ih-&gt;h_share=
d_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vi-&gt;xattr_shared_count)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unlock;<br>
<br>
Questions: ret =3D 0? no need to <span class=3D"gmail_default" style=3D"fon=
t-family:monospace"></span>erofs_put_metabuf?<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-family:monospace">You are=
 right. this patch needs to call=C2=A0erofs_put_metabuf() before goto out_u=
nlock.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
I think we can keep current since <span class=3D"gmail_default" style=3D"fo=
nt-family:monospace"></span>kmalloc_array() will check whether the<br>
size(-&gt;xattr_shared_count) is zero size or not. rt?<br></blockquote><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-family:monospace=
">In case of xattr_shared_count =3D=3D 0, <span class=3D"gmail_default"></s=
pan><span style=3D"font-family:Arial,Helvetica,sans-serif">kmalloc_array()<=
/span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=A0return=
=C2=A0</span><span style=3D"font-family:Arial,Helvetica,sans-serif">ZERO_SI=
ZE_PTR.=C2=A0</span></div><div class=3D"gmail_default" style=3D"font-family=
:monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">And kfre=
e() do noting=C2=A0in this case (safe).</span></div><div class=3D"gmail_def=
ault" style=3D"font-family:monospace"><br></div></div><div>#define ZERO_SIZ=
E_PTR ((void *)16)<br></div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0vi-&gt;xattr_shared_xattrs =3D kmalloc_array=
(vi-&gt;xattr_shared_count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint), GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vi-&gt;xattr_shared_xattrs) {<br>
<br>
</blockquote></div></div>

--000000000000326b2b05f5fc3679--
