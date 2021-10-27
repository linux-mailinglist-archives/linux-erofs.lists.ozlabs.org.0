Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E943CADC
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 15:41:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfVG46T7wz2yPZ
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 00:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ILKqtnlR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435;
 helo=mail-wr1-x435.google.com; envelope-from=t.i.ivanov@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ILKqtnlR; dkim-atps=neutral
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfVFx1F7bz2y7K
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 00:41:07 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so4233887wrh.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cpB8/v2ixQKySz87e9xrf81v5+WjxH7CHCvUY5EMWLE=;
 b=ILKqtnlRNY+paHHF3ljsOGjyPO3FlYYGqzatBTlB+i/dR8YP2i3/y6REkNsaGeAgQJ
 vGh6F9H+Aw/sWxoO3aHwsvsNSa4nrWYILEvhiwmJJ7iEOz4G9Y+drOd9hvz/T1MHiXD7
 r3BL1HIKYT8MUBJRhCFqbLsmy2q22wTU9PRYJEPyn9OGeB8Ifq2ghTVXFusYMIh3ZdDG
 Vczcq66M3X2f3wyag8kCRhMA3TgSg73UgzRX7REmICiYlKlm1NYeAi61TPGxkduVMXNU
 6Q7GJSkrrplgMXh/a/gYZ6kJPVAizADE39V7WyXepU14yyEQc4CcveVsW1VkPPCaV/0o
 +wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cpB8/v2ixQKySz87e9xrf81v5+WjxH7CHCvUY5EMWLE=;
 b=axzqvCAaO58VPUWIb1u9aFFpGjzUFp8KMl8uiT8QCMOZHfzyi3j+SHdB9aEDFINnOk
 kFigup16eOnBE5zXMERZCA78Ck10H/PCpbHgvxkHhRHfJobeUH+RnIzeJ3WY14XGjLZy
 PQ+NI1jdALfYcpCYIMZJSYslO0g13vCBQQJ+pW+LvrWSNx8z7imKQ0IeiRi6TtQmwCis
 jsypaw+T65zR5SKWRi0UklAMwVOihHdwr0/CzqBQxfZlu8OmaSQt6ZKNPBRo4nNFskzF
 R4GAtMARGTcGvERF6UHX08QRLB3xYxuJ59rOJwMhNQ/WqHWzD2DwSOoCAa8aHom7XZf8
 w8Pw==
X-Gm-Message-State: AOAM531vy+hFkAXyQf99dbtYBq5wNZonAqgiVvS2iojaoFPujkqL+SAr
 KjRCkL02Bo/CXowuwx0/v0A0gnuljXftj48TymS8Yj+LJyQ=
X-Google-Smtp-Source: ABdhPJy6n76Qp+Kdpu4mZaPf31y8Q/Hf3sq2LxyUE6FZs4+Q3dFlpVaIZ7PXj5WIzGUUrDNUkBz2mNwZtOw+Xs2EY/E=
X-Received: by 2002:adf:f202:: with SMTP id p2mr2880285wro.93.1635342054777;
 Wed, 27 Oct 2021 06:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv4OrXs9-4o0JvCdSus=WBjPqUbm+YES_QrsuXkv13dt7SKjQ@mail.gmail.com>
 <YXk3kK1+NLu2h9o1@B-P7TQMD6M-0146.local>
 <CAOv4OrXqGNZMT9=jPVVxUgrcdnRtJnTk3gnufA6cKeoWDkQNvQ@mail.gmail.com>
 <YXk9MYJFAg9BLxrn@B-P7TQMD6M-0146.local>
In-Reply-To: <YXk9MYJFAg9BLxrn@B-P7TQMD6M-0146.local>
From: Todor Ivanov <t.i.ivanov@gmail.com>
Date: Wed, 27 Oct 2021 16:40:28 +0300
Message-ID: <CAOv4OrUhgM0K7mhGbWTh+0himfpf5eW-XvH=uVpY5AhJB3fotA@mail.gmail.com>
Subject: Re: Question about mkfs.erofs and reproducible builds
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="00000000000042e44b05cf55be4e"
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000042e44b05cf55be4e
Content-Type: text/plain; charset="UTF-8"

   Hi, Gao,

   Indeed c_version:[1.3-g9fe440d0], seems to fix the problem :) Thank you
very much for the prompt and accurate feedback! Do you think we can use the
dev branch for our images or is it better until it is merged into master?
What do you think?

Kind regards,
Todor


On Wed, Oct 27, 2021 at 2:51 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> On Wed, Oct 27, 2021 at 02:41:54PM +0300, Todor Ivanov wrote:
> >     Hi, Gao,
> >
> >     This is how I installed mkfs.erofs on debian10:
> >
> > apt-get install pkg-config liblz4-dev gawk
> > wget
> >
> http://ftp.debian.org/debian/pool/main/e/erofs-utils/erofs-utils_1.3.orig.tar.gz
> > tar xvzpf erofs-utils_1.3.orig.tar.gz
> > cd erofs-utils-1.3/
> > ./autogen.sh
> > ./configure
> > make
> > make install
> >
> > Can you tell me where do I clone it from and if build instructions are
> > different?
>
> You could get the latest dev branch from:
> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b dev
>
> We fixed some reproducable build issues recently, I think it might
> be related to
>
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?id=6324fac820c28c6a946f595fa58a0abba0f48eb4
>
> Thanks,
> Gao Xiang
>
> >
> > Kind regards,
> > Todor
> >
> > On Wed, Oct 27, 2021 at 2:27 PM Gao Xiang <hsiangkao@linux.alibaba.com>
> > wrote:
> >
> > > Hi Todor,
> > >
> > > On Wed, Oct 27, 2021 at 02:11:24PM +0300, Todor Ivanov wrote:
> > > >         Hello,
> > > >
> > > >         We are trying to replace squashfs with erofs and face an
> issue
> > > with
> > > > reproducing the build from one and the same source folder. The source
> > > > folder is "/etc" actually taken from an offline ubuntu 20.04 image
> and
> > > > mounted as read-only.
> > > >         I managed to narrow down the scope and it turns out that the
> > > issue
> > > > is when you have a file starting with "." (dot) in this folder. I.e.:
> > > >
> > > > etc/.anyfilename
> > > >
> > > > If I remove this file the erofs image of "etc" is reproducible (-T
> and -U
> > > > are used as well)
> > > >
> > > > The issue is somehow related to the other 76 subfolders of etc and
> this
> > > > file starting with dot. For example if I create such .anyfilename in
> usr
> > > or
> > > > var, there is no issue. Also if I create this file under
> > > > etc/xdg/.anyfilename, this is fine as well.
> > > > I also tried with etc from debian10 and the result is the same.
> Removing
> > > > any file that starts with dot directly under etc, makes the erofs
> build
> > > > reproducible.
> > > > Do you have any advice on this?
> > >
> > > In principle filenames starting with '.' won't impact anything about
> > > reproducible builds...
> > >
> > > Let me investigate it now... But may I ask which erofs-utils version
> > > is used? Does it still happen on the latest dev branch?
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > Regards,
> > > > Todor
> > >
>

--00000000000042e44b05cf55be4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div>=C2=A0=C2=A0 Hi, Gao,</div>=
<div><br></div><div>=C2=A0=C2=A0 Indeed c_version:[1.3-g9fe440d0], seems to=
 fix the problem :) Thank you very much for the prompt and accurate feedbac=
k! Do you think we can use the dev branch for our images or is it better un=
til it is merged into master? What do you think?<br></div><div><br></div><d=
iv>Kind regards,</div><div>Todor<br></div></div></div><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 27, 2=
021 at 2:51 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com"=
>hsiangkao@linux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Wed, Oct 27, 2021 at 02:41:54PM +0300, Todor=
 Ivanov wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi, Gao,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This is how I installed mkfs.erofs on debian10:<br>
&gt; <br>
&gt; apt-get install pkg-config liblz4-dev gawk<br>
&gt; wget<br>
&gt; <a href=3D"http://ftp.debian.org/debian/pool/main/e/erofs-utils/erofs-=
utils_1.3.orig.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://ftp.debi=
an.org/debian/pool/main/e/erofs-utils/erofs-utils_1.3.orig.tar.gz</a><br>
&gt; tar xvzpf erofs-utils_1.3.orig.tar.gz<br>
&gt; cd erofs-utils-1.3/<br>
&gt; ./autogen.sh<br>
&gt; ./configure<br>
&gt; make<br>
&gt; make install<br>
&gt; <br>
&gt; Can you tell me where do I clone it from and if build instructions are=
<br>
&gt; different?<br>
<br>
You could get the latest dev branch from:<br>
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs=
-utils.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/lin=
ux/kernel/git/xiang/erofs-utils.git</a> -b dev<br>
<br>
We fixed some reproducable build issues recently, I think it might<br>
be related to<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-util=
s.git/commit/?id=3D6324fac820c28c6a946f595fa58a0abba0f48eb4" rel=3D"norefer=
rer" target=3D"_blank">https://git.kernel.org/pub/scm/linux/kernel/git/xian=
g/erofs-utils.git/commit/?id=3D6324fac820c28c6a946f595fa58a0abba0f48eb4</a>=
<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Kind regards,<br>
&gt; Todor<br>
&gt; <br>
&gt; On Wed, Oct 27, 2021 at 2:27 PM Gao Xiang &lt;<a href=3D"mailto:hsiang=
kao@linux.alibaba.com" target=3D"_blank">hsiangkao@linux.alibaba.com</a>&gt=
;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Todor,<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Oct 27, 2021 at 02:11:24PM +0300, Todor Ivanov wrote:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hello,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0We are trying to replace sq=
uashfs with erofs and face an issue<br>
&gt; &gt; with<br>
&gt; &gt; &gt; reproducing the build from one and the same source folder. T=
he source<br>
&gt; &gt; &gt; folder is &quot;/etc&quot; actually taken from an offline ub=
untu 20.04 image and<br>
&gt; &gt; &gt; mounted as read-only.<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I managed to narrow down th=
e scope and it turns out that the<br>
&gt; &gt; issue<br>
&gt; &gt; &gt; is when you have a file starting with &quot;.&quot; (dot) in=
 this folder. I.e.:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; etc/.anyfilename<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If I remove this file the erofs image of &quot;etc&quot; is =
reproducible (-T and -U<br>
&gt; &gt; &gt; are used as well)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The issue is somehow related to the other 76 subfolders of e=
tc and this<br>
&gt; &gt; &gt; file starting with dot. For example if I create such .anyfil=
ename in usr<br>
&gt; &gt; or<br>
&gt; &gt; &gt; var, there is no issue. Also if I create this file under<br>
&gt; &gt; &gt; etc/xdg/.anyfilename, this is fine as well.<br>
&gt; &gt; &gt; I also tried with etc from debian10 and the result is the sa=
me. Removing<br>
&gt; &gt; &gt; any file that starts with dot directly under etc, makes the =
erofs build<br>
&gt; &gt; &gt; reproducible.<br>
&gt; &gt; &gt; Do you have any advice on this?<br>
&gt; &gt;<br>
&gt; &gt; In principle filenames starting with &#39;.&#39; won&#39;t impact=
 anything about<br>
&gt; &gt; reproducible builds...<br>
&gt; &gt;<br>
&gt; &gt; Let me investigate it now... But may I ask which erofs-utils vers=
ion<br>
&gt; &gt; is used? Does it still happen on the latest dev branch?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Todor<br>
&gt; &gt;<br>
</blockquote></div>

--00000000000042e44b05cf55be4e--
