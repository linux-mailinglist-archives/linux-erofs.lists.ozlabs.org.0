Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918E80AB4
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 13:39:29 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461f7f29cfzDqc1
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 21:39:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aDhCdndn"; 
 dkim-atps=neutral
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461f7Z15lyzDqR7
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 21:39:21 +1000 (AEST)
Received: by mail-ed1-x52a.google.com with SMTP id v15so76247465eds.9
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hqAG+c6O/AZUHNcQmwM7a7OA73/TgySmt5K172URyLg=;
 b=aDhCdndnM9bZqr3AXBcVK32JVQYV5i1ue8UTjwTkaR75MQXV30sakjM0JrNU60LIN9
 +dujBiv6HmzHKm9Ob5v+XTKZODW81SyaK4pH2JPKs1BiE39EiCfSM0Mi7v4gHV/P7O3R
 vv7y5K3tknI82S9ZDiPctU/4g1uJ+AvdgHuav0yiTNUB8QwrAnvxM929VWZI6ZtPbpPm
 WUmBhLMj5qxaB0TJUjiG4pWeZlsLkm1nmq0rXJZv4z1q8fR4xwXwJRr4g4rUW0pfQkjQ
 UQcXG9bnii9HO0McOOL8M90jjZYzAU0I8eKM8PnZDgNaLhN+4NXTh6XdR6e+bZQzftYU
 +ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hqAG+c6O/AZUHNcQmwM7a7OA73/TgySmt5K172URyLg=;
 b=J9HMGLm58OroLDkrlInys9l9hm/SMaCdn5Oez4LzaPmD+P1sB04TN/8FsSd1vTbDRp
 F3vzJ5Kj1VMmIGXKAq9IEf/SUzrxtHEv5EKTDpPBGNJIREUOA9jEITtr7l8KscNZkRV+
 k5cprYadSe6j40LxVTM83UgxJNVOs2K8SNdtQB9mnw2nnIuZebuTiFf9RyVWvTMK3OJZ
 CQHOmYQfcpBHm6/gtbjAY2QAdbOUvaqpqzbUfSAHa9srPjOfLsYh6tptJ2UWW5TzXsl/
 s9e4WPhmEa28j8yDGGVaWQhsrEWwrecntHQt5D7wToHl4sfvYB+6uwUQXQhGszgNmvyI
 NYdg==
X-Gm-Message-State: APjAAAVoHUcZ94SqjY3sT2OcpUQ9VLfNMV5cfNZbtUpoSfXSHDBr4Xcq
 bZfDEUoycGXMN4IyCsjenTRDbYwSVnWRGQyebAI=
X-Google-Smtp-Source: APXvYqz4uUXMw34TI2/MneGNSWkYwf4i8FB5sYTOQqKdkB/9fN6SruJunnSaz0jIDmEreBvkrmJ7n0E/1aMQiiZI4ic=
X-Received: by 2002:a50:9203:: with SMTP id i3mr131341388eda.302.1564918757348; 
 Sun, 04 Aug 2019 04:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sun, 4 Aug 2019 17:09:05 +0530
Message-ID: <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
To: Gao Xiang <hsiangkao@gmx.com>
Content-Type: multipart/alternative; boundary="000000000000a25d5a058f490a94"
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000a25d5a058f490a94
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

I Agree with your suggestion. Thanks for the additional code change. I
think thats pretty much our final patch. :)

-Pratik

On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:

> Hi Pratik,
>
> On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> > Hi Gao,
> >
> > I used fprintf here because we are printing this error message in case of
> > invalid 'cfg.c_dbg_lvl'. Hence I thought
> > we cannot rely on erofs_err().
> > e.g
> > $ mkfs.erofs -d -1 <erofs image> <directory>
> > In this case debug level is '-1' which is invalid.If we try to print the
> > error message using erofs_err() with c_dbg_lvl = -1,
> > it will not print anything.
>
> Yes, so c_dbg_lvl should be kept in default level (0) before
> checking its vaildity I think.
>
> > While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
> > erofs_err() will be able to log the error message.
>
> Since there could be some messages already printed with erofs_xxx before
> mkfs_parse_options_cfg(), I think we can use default level (0) before
> checking its vaildity and switch to the given level after it, as below:
>
>                 case 'd':
> -                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
> +                       i = atoi(optarg);
> +                       if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
> +                               erofs_err("invalid debug level %d", i);
> +                               return -EINVAL;
> +                       }
> +                       cfg.c_dbg_lvl = i;
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
>
> Do you agree? :)
>
> Thanks,
> Gao Xiang
>
> >
> > --Pratik.
> >
> >
> > On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:
> >
> > > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> > > > handling the case of incorrect debug level.
> > > > Added an enumerated type for supported debug levels.
> > > > Using 'atoi' in place of 'parse_num_from_str'.
> > > >
> > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > ---
> > > >  include/erofs/print.h | 18 +++++++++++++-----
> > > >  mkfs/main.c           | 19 ++++++++-----------
> > > >  2 files changed, 21 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > > index bc0b8d4..296cbbf 100644
> > > > --- a/include/erofs/print.h
> > > > +++ b/include/erofs/print.h
> > > > @@ -12,6 +12,15 @@
> > > >  #include "config.h"
> > > >  #include <stdio.h>
> > > >
> > > > +enum {
> > > > +     EROFS_MSG_MIN = 0,
> > > > +     EROFS_ERR     = 0,
> > > > +     EROFS_WARN    = 2,
> > > > +     EROFS_INFO    = 3,
> > > > +     EROFS_DBG     = 7,
> > > > +     EROFS_MSG_MAX = 9
> > > > +};
> > > > +
> > > >  #define FUNC_LINE_FMT "%s() Line[%d] "
> > > >
> > > >  #ifndef pr_fmt
> > > > @@ -19,7 +28,7 @@
> > > >  #endif
> > > >
> > > >  #define erofs_dbg(fmt, ...) do {                             \
> > > > -     if (cfg.c_dbg_lvl >= 7) {                               \
> > > > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
> > > >               fprintf(stdout,                                 \
> > > >                       pr_fmt(fmt),                            \
> > > >                       __func__,                               \
> > > > @@ -29,7 +38,7 @@
> > > >  } while (0)
> > > >
> > > >  #define erofs_info(fmt, ...) do {                            \
> > > > -     if (cfg.c_dbg_lvl >= 3) {                               \
> > > > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
> > > >               fprintf(stdout,                                 \
> > > >                       pr_fmt(fmt),                            \
> > > >                       __func__,                               \
> > > > @@ -40,7 +49,7 @@
> > > >  } while (0)
> > > >
> > > >  #define erofs_warn(fmt, ...) do {                            \
> > > > -     if (cfg.c_dbg_lvl >= 2) {                               \
> > > > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
> > > >               fprintf(stdout,                                 \
> > > >                       pr_fmt(fmt),                            \
> > > >                       __func__,                               \
> > > > @@ -51,7 +60,7 @@
> > > >  } while (0)
> > > >
> > > >  #define erofs_err(fmt, ...) do {                             \
> > > > -     if (cfg.c_dbg_lvl >= 0) {                               \
> > > > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
> > > >               fprintf(stderr,                                 \
> > > >                       "Err: " pr_fmt(fmt),                    \
> > > >                       __func__,                               \
> > > > @@ -64,4 +73,3 @@
> > > >
> > > >
> > > >  #endif
> > > > -
> > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > index fdb65fd..d915d00 100644
> > > > --- a/mkfs/main.c
> > > > +++ b/mkfs/main.c
> > > > @@ -30,16 +30,6 @@ static void usage(void)
> > > >       fprintf(stderr, " -EX[,...] X=extended options\n");
> > > >  }
> > > >
> > > > -u64 parse_num_from_str(const char *str)
> > > > -{
> > > > -     u64 num      = 0;
> > > > -     char *endptr = NULL;
> > > > -
> > > > -     num = strtoull(str, &endptr, 10);
> > > > -     BUG_ON(num == ULLONG_MAX);
> > > > -     return num;
> > > > -}
> > > > -
> > > >  static int parse_extended_opts(const char *opts)
> > > >  {
> > > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
> > > *argv[])
> > > >                       break;
> > > >
> > > >               case 'd':
> > > > -                     cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > > +                     cfg.c_dbg_lvl = atoi(optarg);
> > > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > > +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> > > > +                             fprintf(stderr,
> > > > +                                     "invalid debug level %d\n",
> > > > +                                     cfg.c_dbg_lvl);
> > >
> > > How about using erofs_err as my previous patch attached?
> > > I wonder if there are some specfic reasons to directly use fprintf
> instead?
> > >
> > > I will apply it with this minor fixup (no need to resend again), if you
> > > have
> > > other considerations, reply me in this thread, thanks. :)
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > > +                             return -EINVAL;
> > > > +                     }
> > > >                       break;
> > > >
> > > >               case 'E':
> > > > --
> > > > 2.9.3
> > > >
> > >
>

--000000000000a25d5a058f490a94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">I Ag=
ree with your suggestion. Thanks for the additional code change. I think th=
ats pretty much our final patch. :)=C2=A0</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">-Pratik</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, &lt;=
<a href=3D"mailto:hsiangkao@gmx.com">hsiangkao@gmx.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:<br>
&gt; Hi Gao,<br>
&gt;<br>
&gt; I used fprintf here because we are printing this error message in case=
 of<br>
&gt; invalid &#39;cfg.c_dbg_lvl&#39;. Hence I thought<br>
&gt; we cannot rely on erofs_err().<br>
&gt; e.g<br>
&gt; $ mkfs.erofs -d -1 &lt;erofs image&gt; &lt;directory&gt;<br>
&gt; In this case debug level is &#39;-1&#39; which is invalid.If we try to=
 print the<br>
&gt; error message using erofs_err() with c_dbg_lvl =3D -1,<br>
&gt; it will not print anything.<br>
<br>
Yes, so c_dbg_lvl should be kept in default level (0) before<br>
checking its vaildity I think.<br>
<br>
&gt; While applying the minor fixup, just reset the c_dbg_lvl to 0 , so tha=
t<br>
&gt; erofs_err() will be able to log the error message.<br>
<br>
Since there could be some messages already printed with erofs_xxx before<br=
>
mkfs_parse_options_cfg(), I think we can use default level (0) before<br>
checking its vaildity and switch to the given level after it, as below:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;d&#39;:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cfg.c_dbg_lvl =3D parse_num_from_str(optarg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0i =3D atoi(optarg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (i &lt; EROFS_MSG_MIN || i &gt; EROFS_MSG_MAX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;invalid debug level %=
d&quot;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cfg.c_dbg_lvl =3D i;<br>
<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-util=
s.git/commit/?h=3Ddev&amp;id=3D26097242976cce68e21d8b569dfda63fb68f356c" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://git.kernel.org/pub/sc=
m/linux/kernel/git/xiang/erofs-utils.git/commit/?h=3Ddev&amp;id=3D260972429=
76cce68e21d8b569dfda63fb68f356c</a><br>
<br>
Do you agree? :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt;<br>
&gt; --Pratik.<br>
&gt;<br>
&gt;<br>
&gt; On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang &lt;<a href=3D"mailto:hsiangk=
ao@aol.com" target=3D"_blank" rel=3D"noreferrer">hsiangkao@aol.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; &gt; On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:<br=
>
&gt; &gt; &gt; handling the case of incorrect debug level.<br>
&gt; &gt; &gt; Added an enumerated type for supported debug levels.<br>
&gt; &gt; &gt; Using &#39;atoi&#39; in place of &#39;parse_num_from_str&#39=
;.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshi=
nde320@gmail.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmai=
l.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/erofs/print.h | 18 +++++++++++++-----<br>
&gt; &gt; &gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
19 ++++++++-----------<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 21 insertions(+), 16 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/erofs/print.h b/include/erofs/print.h<b=
r>
&gt; &gt; &gt; index bc0b8d4..296cbbf 100644<br>
&gt; &gt; &gt; --- a/include/erofs/print.h<br>
&gt; &gt; &gt; +++ b/include/erofs/print.h<br>
&gt; &gt; &gt; @@ -12,6 +12,15 @@<br>
&gt; &gt; &gt;=C2=A0 #include &quot;config.h&quot;<br>
&gt; &gt; &gt;=C2=A0 #include &lt;stdio.h&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +enum {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_MSG_MIN =3D 0,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_ERR=C2=A0 =C2=A0 =C2=A0=3D 0,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_WARN=C2=A0 =C2=A0 =3D 2,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_INFO=C2=A0 =C2=A0 =3D 3,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_DBG=C2=A0 =C2=A0 =C2=A0=3D 7,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_MSG_MAX =3D 9<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 #define FUNC_LINE_FMT &quot;%s() Line[%d] &quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #ifndef pr_fmt<br>
&gt; &gt; &gt; @@ -19,7 +28,7 @@<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define erofs_dbg(fmt, ...) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D 7) {=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D EROFS_DBG) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprint=
f(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; @@ -29,7 +38,7 @@<br>
&gt; &gt; &gt;=C2=A0 } while (0)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define erofs_info(fmt, ...) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D 3) {=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D EROFS_INFO) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprint=
f(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; @@ -40,7 +49,7 @@<br>
&gt; &gt; &gt;=C2=A0 } while (0)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define erofs_warn(fmt, ...) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D 2) {=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D EROFS_WARN) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprint=
f(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; @@ -51,7 +60,7 @@<br>
&gt; &gt; &gt;=C2=A0 } while (0)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #define erofs_err(fmt, ...) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D 0) {=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &gt;=3D EROFS_ERR) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprint=
f(stderr,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;Err: &quot; pr_fmt(fmt),=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; @@ -64,4 +73,3 @@<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; &gt; &gt; index fdb65fd..d915d00 100644<br>
&gt; &gt; &gt; --- a/mkfs/main.c<br>
&gt; &gt; &gt; +++ b/mkfs/main.c<br>
&gt; &gt; &gt; @@ -30,16 +30,6 @@ static void usage(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot; -EX[,...] X=
=3Dextended options\n&quot;);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -u64 parse_num_from_str(const char *str)<br>
&gt; &gt; &gt; -{<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0u64 num=C2=A0 =C2=A0 =C2=A0 =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0char *endptr =3D NULL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0num =3D strtoull(str, &amp;endptr, 10);=
<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0BUG_ON(num =3D=3D ULLONG_MAX);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0return num;<br>
&gt; &gt; &gt; -}<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;=C2=A0 static int parse_extended_opts(const char *opts)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 #define MATCH_EXTENTED_OPT(opt, token, keylen) \<br>
&gt; &gt; &gt; @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int ar=
gc, char<br>
&gt; &gt; *argv[])<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &=
#39;d&#39;:<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D parse_num_from_str(optarg);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D atoi(optarg);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &lt; EROFS_MSG_MIN<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| cfg.c_dbg_lvl &gt; EROFS_MSG_MAX) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;invalid debug level %d\n&quot;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cf=
g.c_dbg_lvl);<br>
&gt; &gt;<br>
&gt; &gt; How about using erofs_err as my previous patch attached?<br>
&gt; &gt; I wonder if there are some specfic reasons to directly use fprint=
f instead?<br>
&gt; &gt;<br>
&gt; &gt; I will apply it with this minor fixup (no need to resend again), =
if you<br>
&gt; &gt; have<br>
&gt; &gt; other considerations, reply me in this thread, thanks. :)<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &=
#39;E&#39;:<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.9.3<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000a25d5a058f490a94--
