Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC343F2CFD
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 15:16:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grhx20vpwz3cLQ
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Aug 2021 23:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Mk6efasi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d2c;
 helo=mail-io1-xd2c.google.com; envelope-from=igoreisberg@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Mk6efasi; dkim-atps=neutral
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grhwx1DCJz3bW1
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 23:16:32 +1000 (AEST)
Received: by mail-io1-xd2c.google.com with SMTP id a15so12234821iot.2
 for <linux-erofs@lists.ozlabs.org>; Fri, 20 Aug 2021 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=G2fzAIUozTDrOU+YmcmLj3r8ewsuRnEpOiN6Cab1DSs=;
 b=Mk6efasi9FfBbeFRstsnx/8MZ2mO7DpHLwhBlXA0u9EAmhVtwP5xXMkahiJfdbhk24
 QBPS62r9qzrEtcPw5YngZenwRxMezSblr4IUQ0ody40Egfn7uDsk+BzxBBYQ8IfFwWah
 HXUcKwuMWICexsokQqCaVYqNrspurdd8ymEG3IM8I5gHHFQlFskzKptaSoNqWvkeXNEx
 3FfedUhJ+/pluOgoYk4A1U3tmyrAnC9KHgbxXUnSWXX6bIqtRKQB4pJVUSPER4P+nxwM
 Krpqxo69KeFL4mT3uWGlh+yvI5f8dPSfoDck8DM7ucF2iIuYQzPIW5DwvgOmnN+5Hvpc
 fU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=G2fzAIUozTDrOU+YmcmLj3r8ewsuRnEpOiN6Cab1DSs=;
 b=BSpQVmPbLL3kW5c0ptOPHgDU54iblJL/sduGedF7it+QROweO27pYAW+gVBTptveUj
 38EJyX62qHYumWctKZvNXAN4pyaGf4qhDjs1KcYmKzSFVKFHSCkr/AUTqHKYo64YRIK5
 JmzMQI6Si8SiK/wh3IHJHbOb1EqG48zxun6IvzGNPfjMbLay5j6Vqb7ohXen0YMN9fwK
 zJx3sYW1NvATwsco6xd2E+3HAlY3nHOV2uQBIQ6bNCQ7XSzPH7LgU2PMfnUfL9RTuBgq
 lpHyvIjGSMQUZxj4Fk8hKiSw9CXXDSg5RwYN86XperJX5rBTSOcp5wTn04zjvvMMMXxG
 XfIg==
X-Gm-Message-State: AOAM532/qOAFeEqrQKO+fiWf0UynreMBJMHuSsTUPg3vKQcmTcq7qNmV
 AWnE0nKaA9cLKo5KIhAip4CFqJb41lbkRDfJzXY=
X-Google-Smtp-Source: ABdhPJximaYB8ZH6BR0VISjrzixSER/IUhtLlagFY4lv+fAQHpXpI+JmNJFPVM3UXiMDQUtLcnUkpiBukLDz0CkXyMs=
X-Received: by 2002:a6b:3b8c:: with SMTP id i134mr8903423ioa.29.1629465388939; 
 Fri, 20 Aug 2021 06:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <CABjEcnGniBcadC4DDV4xCio8UmZyhSGWt+_gi_ESbYwoOQ2E0w@mail.gmail.com>
 <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210820124831.GA25021@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Igor Eisberg <igoreisberg@gmail.com>
Date: Fri, 20 Aug 2021 16:16:20 +0300
Message-ID: <CABjEcnEg6TSuCCTfpttXBT+Ue+iGGKv1PWNAn+WrpVE4qEQmfw@mail.gmail.com>
Subject: Re: An issue with erofsfuse
To: Igor Eisberg <igoreisberg@gmail.com>, linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000ae81ba05c9fd799e"
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

--000000000000ae81ba05c9fd799e
Content-Type: text/plain; charset="UTF-8"

You're quicker than expected, thanks for answering.
Not sure how to check if lz4 was builtin, but considering that erofsfuse is
only about 34.5KB (stripped) I would guess not?
Here's the output of erofsfuse -d (it prints this but never exists back to
shell unless I do Ctrl+C):

erofsfuse 1.3
>
> disk: product.img
>
> mountpoint: product-mnt
>
> dbglevel: 7
>
> FUSE library version: 2.9.9
>
> nullpath_ok: 0
>
> nopath: 0
>
> utime_omit_ok: 0
>
> unique: 1, opcode: INIT (26), nodeid: 0, insize: 56, pid: 0
>
> INIT: 7.27
>
> flags=0x003ffffb
>
> max_readahead=0x00020000
>
> EROFS: erofsfuse_init() Line[23] Using FUSE protocol 7.27
>
>    INIT: 7.19
>
>    flags=0x00000011
>
>    max_readahead=0x00020000
>
>    max_write=0x00020000
>
>    max_background=0
>
>    congestion_threshold=0
>
>    unique: 1, success, outsize: 40
>
>
On Fri, 20 Aug 2021 at 15:49, Gao Xiang <xiang@kernel.org> wrote:

> Hi Igor,
>
> On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:
> > Hey there, getting straight to the point.
> > Our team is using Debian 10, in which erofs mounting is not supported and
> > we have no option of updating the kernel, nor do we have sudo permissions
> > on this server.
> >
> > Our only choice is to use erofsfuse to mount an Android image
> (compression
> > was used on that image), for the sole purpose of extracting its contents
> to
> > another folder for processing.
> > Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native
> > mounting is supported), but on all of them I could not copy files which
> are
> > compressed from the mounted image to another location (ext4 file system).
> >
> > The error I'm getting is: "Operation not supported (95)"
> >
>
> Thanks for your feedback.
>
> Could you check if lz4 was built-in when building erofsfuse? I guess
> that is the reason (lack of lz4 support builtin).
>
> If not, could you add -d to erofsfuse when starting up?
>
> Thanks,
> Gao Xiang
>
> > Notes:
> > * Only extremely small (< 1 KB) files which are stored uncompressed are
> > copied successfully.
> > * Copying works perfectly when mounting the image with "sudo mount" on
> the
> > latest Kubuntu, so it has to be something with erofsfuse.
> >
> > Anything you can do to help resolve this?
> >
> > Best,
> > Igor.
>

--000000000000ae81ba05c9fd799e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">You&#39;re quicker than expected, thanks =
for answering.<div>Not sure how to check if lz4 was builtin, but considerin=
g that erofsfuse is only about 34.5KB (stripped) I would guess not?</div><d=
iv>Here&#39;s the output of erofsfuse -d (it prints this but never exists b=
ack to shell unless I do Ctrl+C):</div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">erofsfuse 1.3</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">disk: product.img</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">mountpoint: product-mnt</blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">dbglevel: 7</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">FUSE library version: 2.9.9</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">nullpath_ok: 0</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">nopath: 0</blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">utime_omit_ok: 0</blockquote><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">unique: 1, opcode: INIT (26), nodeid=
: 0, insize: 56, pid: 0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">INIT: 7.27</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">flags=3D0x003ffffb</blockquote><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">max_readahead=3D0x00020000</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">EROFS: erofsfuse_init() Line[23] Using FUS=
E protocol 7.27</blockquote><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">=C2=A0 =C2=A0INIT: 7.19</blockquote><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">=C2=A0 =C2=A0flags=3D0x00000011</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">=C2=A0 =C2=A0max_readahead=3D0x00020000</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0ma=
x_write=3D0x00020000</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">=C2=A0 =C2=A0max_background=3D0</blockquote><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">=C2=A0 =C2=A0congestion_threshold=3D0</blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0unique: 1,=
 success, outsize: 40</blockquote></blockquote></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 20 Aug 2021 =
at 15:49, Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org">xiang@kernel.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Igor,<br>
<br>
On Fri, Aug 20, 2021 at 03:34:05PM +0300, Igor Eisberg wrote:<br>
&gt; Hey there, getting straight to the point.<br>
&gt; Our team is using Debian 10, in which erofs mounting is not supported =
and<br>
&gt; we have no option of updating the kernel, nor do we have sudo permissi=
ons<br>
&gt; on this server.<br>
&gt; <br>
&gt; Our only choice is to use erofsfuse to mount an Android image (compres=
sion<br>
&gt; was used on that image), for the sole purpose of extracting its conten=
ts to<br>
&gt; another folder for processing.<br>
&gt; Tried on Debian 10, pop_OS! and even the latest Kubuntu (where native<=
br>
&gt; mounting is supported), but on all of them I could not copy files whic=
h are<br>
&gt; compressed from the mounted image to another location (ext4 file syste=
m).<br>
&gt; <br>
&gt; The error I&#39;m getting is: &quot;Operation not supported (95)&quot;=
<br>
&gt; <br>
<br>
Thanks for your feedback.<br>
<br>
Could you check if lz4 was built-in when building erofsfuse? I guess<br>
that is the reason (lack of lz4 support builtin).<br>
<br>
If not, could you add -d to erofsfuse when starting up?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; Notes:<br>
&gt; * Only extremely small (&lt; 1 KB) files which are stored uncompressed=
 are<br>
&gt; copied successfully.<br>
&gt; * Copying works perfectly when mounting the image with &quot;sudo moun=
t&quot; on the<br>
&gt; latest Kubuntu, so it has to be something with erofsfuse.<br>
&gt; <br>
&gt; Anything you can do to help resolve this?<br>
&gt; <br>
&gt; Best,<br>
&gt; Igor.<br>
</blockquote></div>

--000000000000ae81ba05c9fd799e--
