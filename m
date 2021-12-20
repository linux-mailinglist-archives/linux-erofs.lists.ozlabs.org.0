Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D59447AEF3
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Dec 2021 16:06:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JHjbt01K3z2ym7
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Dec 2021 02:06:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1640012810;
	bh=b1su5NbJWaQ/GlSaCBDfVipnbL0fV7rsz98JBxrvBds=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EgsFokcxpqu5eWr9Ovg8nIWTNXAxIcDtzPMXOuG+rxVhSTtdSvrOUSUMhg0xxWBuk
	 R847H6Qw8eU5ZdluevobuLGYOgBDcudoxiDU3/tRQpDMp8oSZ0Mil5l05gRINfMnOp
	 b+dqlR0WAMjxUtuZU8Qc/tfklGhKIzSpzPJPSi2Lb3SXxVCNJnKWyvCFKJNEflRKFY
	 MQ2qPYUU3x0cjd5iyLMaF9MkJN86r4WybZpVStl6GxJ4QkJiNKpLY1kU0rTJmcqDjU
	 ankWMScO0VX+XdNZWq3Fmm/TqZb++3xUZZPFQFre5+CzQIV3Pc6Ecw8szey8FpKqBO
	 Ie0KEKeG59svg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Hj7AKw9m; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JHjbq5Lw1z2xtF
 for <linux-erofs@lists.ozlabs.org>; Tue, 21 Dec 2021 02:06:47 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id fq10so1070224qvb.10
 for <linux-erofs@lists.ozlabs.org>; Mon, 20 Dec 2021 07:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b1su5NbJWaQ/GlSaCBDfVipnbL0fV7rsz98JBxrvBds=;
 b=L0lbVjbiIQ8p4IsbQWZiFFyV6m90v/5oIQSl9Kc/MFbglCdOkbhe78m4N8bDcidLBF
 PKsmJ3eMJiLFpNsFl/IVkAv9OcUbhBGAWzM8+nNlD6/COoF2+pv6Jhlui94PJHo09IkF
 dzCMIaViMIWAbKClanoIKPS2jUTU9ImFkL1rVO5WieuWLHBaaF5jBJ7CN0VY4lKyqfgq
 f7MqSkt8n5gEBegbckojZCYI7Coc3RyCOyE2ayCK5TVKpUGLxy74CiEuMrHTJPlEKVjQ
 w9CXKd44zsgT3+Pa0a2XUJtfFV2opauOn5osUS9vPLLFpge101bOh6BUFfyMNi7L4eED
 Uz6g==
X-Gm-Message-State: AOAM530zzfA24DwWLCTvMZqkTI2A8d3A0VRI6EU+ShtB15rVXLlbftzi
 c2gYXmZp+HCSPrlsf8YryG9XkaJY1un49GoIQ2NOu4N6f1o=
X-Google-Smtp-Source: ABdhPJyW0mNwQIS9slUxPk7fW5gyFbx/2YuBvEPzC4YMSiKL3Ce4OUiW32uGRs4H2XU5z7+g1fwBdEBFe6RFsoRr7Zs=
X-Received: by 2002:a05:6214:b62:: with SMTP id
 ey2mr12841230qvb.0.1640012803868; 
 Mon, 20 Dec 2021 07:06:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOSmRzhPk4ykswcUTnK0bj2LdmJ9iwcNuzDpgPQj20d2_rf4Dw@mail.gmail.com>
 <YcCY1tmskGMy+QxV@B-P7TQMD6M-0146.local>
 <YcCbcngdf1jfh0bk@B-P7TQMD6M-0146.local>
In-Reply-To: <YcCbcngdf1jfh0bk@B-P7TQMD6M-0146.local>
Date: Mon, 20 Dec 2021 10:06:33 -0500
Message-ID: <CAOSmRzgca2U148_3QaTYsPxojY59X49-1tdOCRZZuBvv+sCEvA@mail.gmail.com>
Subject: Re: Practical Limit on EROFS lcluster size
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000009a617405d3953c6b"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000009a617405d3953c6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks=E2=80=A6 Another thing, I=E2=80=99m happy to help writing English do=
cumentation for
EROFS if you have a Chinese version.

On Mon, Dec 20, 2021 at 10:04 Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:

> On Mon, Dec 20, 2021 at 10:53:10PM +0800, Gao Xiang wrote:
> > Hi Kelvin,
> >
> > On Mon, Dec 20, 2021 at 08:45:42AM -0500, Kelvin Zhang wrote:
> > > Hi Gao,
> > >     I was playing with large pcluster sizes recently, I noticed a
> > > quirk about EROFS. In summary, logical cluster size has a practical
> > > limit of 8MB. Here's why:
> > >
> > >    Looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tre=
e/lib/compress.c?h=3Dexperimental&id=3D564adb0a852b38a1790db20516862fc31bca=
314d#n92
> > > , line 92, we see the following code:
> > >
> > > if (d0 =3D=3D 1 && erofs_sb_has_big_pcluster()) {
> > >         type =3D Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> > >         di.di_u.delta[0] =3D cpu_to_le16(ctx->compressedblks |
> > >                 Z_EROFS_VLE_DI_D0_CBLKCNT); // This line
> > >         di.di_u.delta[1] =3D cpu_to_le16(d1);
> > > } else if (d0) {
> > >         type =3D Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD;
> > >
> > >         di.di_u.delta[0] =3D cpu_to_le16(d0);  // and this line
> > >         di.di_u.delta[1] =3D cpu_to_le16(d1);
> > > }
> > >
> > > When a compressed index has type NOHEAD, delta[0] stores d0(distance
> > > to head block). But The 11th bit of d0 is also used as a flag bit to
> > > indicate that d0 stores the pcluster size. This means d0 cannot excee=
d
> > > Z_EROFS_VLE_DI_D0_CBLKCNT(2048), or else the parser will incorrectly
> > > interpret d0 as pcluster size, rather than distance to head block.
> > >     Is this an intentional design choice? It's not necessarily bad,
> > > but it's something I think is worth documenting in code.
> >
> > Thanks for this great insight! Actually on-disk EROFS format doesn't
> > have such limitation by design, since if it looks back to the delta0
> > lcluster and it's still a NONHEAD lcluster, it will look back with
> > new delta0 again until finding the final HEAD lcluster.
> >
> > But I'm not sure if mkfs code can handle > 8MiB lcluster properly yet,
> > without modification since lcluster size is strictly limited with
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tre=
e/include/erofs/compress.h#n14
> > EROFS_CONFIG_COMPR_MAX_SZ * 2
> >
> > Yeah, I have to admit the current document might not be so detailed,
> > partially due to my somewhat bad English written speed, and limited
> > time...
>
> By the way, I'd like to correct some concepts here (sorry I didn't use
> them correctly in my previous email).
>
> A lcluster includes a HEAD or NONHEAD lcluster, currently only 4KiB
> is supported.
> A pcluster contains arbitrary compressed blocks, which can be
> decompressed independently.
> A compressed extent matches a pcluster, and several lclusters (maybe
> partially).
>
> So strictly speaking is "practical Limit on EROFS compressed extent
> size"...
>
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > >
> > > --
> > > Sincerely,
> > >
> > > Kelvin Zhang
>
--=20
Sincerely,

Kelvin Zhang

--0000000000009a617405d3953c6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks=E2=80=A6 Another thing, I=E2=80=99m happy to help =
writing English documentation for EROFS if you have a Chinese version.</div=
><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Dec 20, 2021 at 10:04 Gao Xiang &lt;<a href=3D"mailto:hsiangkao@lin=
ux.alibaba.com">hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,=
204,204)">On Mon, Dec 20, 2021 at 10:53:10PM +0800, Gao Xiang wrote:<br>
&gt; Hi Kelvin,<br>
&gt; <br>
&gt; On Mon, Dec 20, 2021 at 08:45:42AM -0500, Kelvin Zhang wrote:<br>
&gt; &gt; Hi Gao,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0I was playing with large pcluster sizes recent=
ly, I noticed a<br>
&gt; &gt; quirk about EROFS. In summary, logical cluster size has a practic=
al<br>
&gt; &gt; limit of 8MB. Here&#39;s why:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 Looking at <a href=3D"https://git.kernel.org/pub/scm=
/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compress.c?h=3Dexperimenta=
l&amp;id=3D564adb0a852b38a1790db20516862fc31bca314d#n92" rel=3D"noreferrer"=
 target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/xiang/er=
ofs-utils.git/tree/lib/compress.c?h=3Dexperimental&amp;id=3D564adb0a852b38a=
1790db20516862fc31bca314d#n92</a><br>
&gt; &gt; , line 92, we see the following code:<br>
&gt; &gt; <br>
&gt; &gt; if (d0 =3D=3D 1 &amp;&amp; erofs_sb_has_big_pcluster()) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D Z_EROFS_VLE_CLUSTER_TYP=
E_NONHEAD;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di.di_u.delta[0] =3D cpu_to_le16=
(ctx-&gt;compressedblks |<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Z_ER=
OFS_VLE_DI_D0_CBLKCNT); // This line<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di.di_u.delta[1] =3D cpu_to_le16=
(d1);<br>
&gt; &gt; } else if (d0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D Z_EROFS_VLE_CLUSTER_TYP=
E_NONHEAD;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di.di_u.delta[0] =3D cpu_to_le16=
(d0);=C2=A0 // and this line<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di.di_u.delta[1] =3D cpu_to_le16=
(d1);<br>
&gt; &gt; }<br>
&gt; &gt; <br>
&gt; &gt; When a compressed index has type NOHEAD, delta[0] stores d0(dista=
nce<br>
&gt; &gt; to head block). But The 11th bit of d0 is also used as a flag bit=
 to<br>
&gt; &gt; indicate that d0 stores the pcluster size. This means d0 cannot e=
xceed<br>
&gt; &gt; Z_EROFS_VLE_DI_D0_CBLKCNT(2048), or else the parser will incorrec=
tly<br>
&gt; &gt; interpret d0 as pcluster size, rather than distance to head block=
.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Is this an intentional design choice? It&#39;s=
 not necessarily bad,<br>
&gt; &gt; but it&#39;s something I think is worth documenting in code.<br>
&gt; <br>
&gt; Thanks for this great insight! Actually on-disk EROFS format doesn&#39=
;t<br>
&gt; have such limitation by design, since if it looks back to the delta0<b=
r>
&gt; lcluster and it&#39;s still a NONHEAD lcluster, it will look back with=
<br>
&gt; new delta0 again until finding the final HEAD lcluster.<br>
&gt; <br>
&gt; But I&#39;m not sure if mkfs code can handle &gt; 8MiB lcluster proper=
ly yet,<br>
&gt; without modification since lcluster size is strictly limited with<br>
&gt; <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs=
-utils.git/tree/include/erofs/compress.h#n14" rel=3D"noreferrer" target=3D"=
_blank">https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.g=
it/tree/include/erofs/compress.h#n14</a><br>
&gt; EROFS_CONFIG_COMPR_MAX_SZ * 2<br>
&gt; <br>
&gt; Yeah, I have to admit the current document might not be so detailed,<b=
r>
&gt; partially due to my somewhat bad English written speed, and limited<br=
>
&gt; time...<br>
<br>
By the way, I&#39;d like to correct some concepts here (sorry I didn&#39;t =
use<br>
them correctly in my previous email).<br>
<br>
A lcluster includes a HEAD or NONHEAD lcluster, currently only 4KiB<br>
is supported.<br>
A pcluster contains arbitrary compressed blocks, which can be<br>
decompressed independently.<br>
A compressed extent matches a pcluster, and several lclusters (maybe<br>
partially).<br>
<br>
So strictly speaking is &quot;practical Limit on EROFS compressed extent<br=
>
size&quot;...<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; -- <br>
&gt; &gt; Sincerely,<br>
&gt; &gt; <br>
&gt; &gt; Kelvin Zhang<br>
</blockquote></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" =
data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></di=
v><div>Kelvin Zhang</div></div></div>

--0000000000009a617405d3953c6b--
