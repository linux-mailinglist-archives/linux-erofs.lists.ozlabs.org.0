Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3E80C13
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 21:03:20 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461qzn2nTHzDqbg
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 05:03:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/Tbogd1"; 
 dkim-atps=neutral
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461qzc5QvTzDqT3
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2019 05:03:08 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id x19so70807654eda.12
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q8hrhZPL7JZ8xSqaKYK8n3Sz1WHOb3/ie2xBFPICNuw=;
 b=X/Tbogd1/pS9gBryIvUrxaqu4shWmDPVCbMlgcLWtswVQKQN1XoKWSGS8AGGStoy+a
 IsUWuHjv9C/hJX5jrNNM+CsIC9re7GB3qHY+P/aCHUQ/0gdYPNnVuU4dmdkpHpsamBby
 jOb2tCsp9jQD+Gl9QyUaLGIGxfkjjKC3Tis0l2X73P2M322dudjKmjE2bMoUUEExE6Fj
 RquosmIvbrpZNJnW0/62Zl70uIfETCUOgIw6TcYIBnB9MMEp2QKOcDilnOQw70Iw0Ks8
 FybJ5CBZz3ZitIr4D0p15X3bWiiPq0NkA6Y9yMq96+2Jt2bYPfTjwtJMZNulmQKUxvDl
 //Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q8hrhZPL7JZ8xSqaKYK8n3Sz1WHOb3/ie2xBFPICNuw=;
 b=C4d9zPYQO56JAEmC5uK1CzL+R2vQOcYp40QKWOJGPpz8MGPdYmBeNnxJU3YZzdFbHT
 H8+EDdbVBn30/dGDFwRZkchbcjKWPJQk1maMKBgoESxnVRbgB/vFYsRKY2GiiBim18st
 gVj/7UsQLAiUS3CDzON/BovzncXVi0hk9x94ypenRw38QtF1PqxNAL7c1/jhn040rERY
 t9/hYk4frzoaVSiI/7dT50JYK0LIOozpDLTQy90JLkhAE3Dv2s91RflzI+w6NO6oNzGh
 4qGb3Zg1E7owY7gZu+JryJDhZUwgbqh0fdNCnGWlQANW122S6OrY/WLmqSzpt3t6Ua6q
 2KAQ==
X-Gm-Message-State: APjAAAXe/C0DTndUuvZ+UpJINdQqYQPbNa9WEovEAP3KptDq7tcFwxfl
 se6Y+efZQ99erfZZfPHLRSpa5TduuWM5HZHTjcY=
X-Google-Smtp-Source: APXvYqxUal2CUlIbZheuTLDVqq/33eXEc/si1jDBSM7UvVLCfQ9ITsJiLN76ZsQD1IiPrEAVf6xgX230YT/yAST+iNA=
X-Received: by 2002:a50:e619:: with SMTP id
 y25mr129985250edm.247.1564945382299; 
 Sun, 04 Aug 2019 12:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
 <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
 <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
 <08f63a50-105c-d97a-8db1-db486e9616a2@gmail.com>
 <20190804154951.GA7446@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190804154951.GA7446@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 5 Aug 2019 00:32:51 +0530
Message-ID: <CAGu0czTR7JzNT_xtH=uez_ZJ3POCPLvK3E-ry=BfW4=HPBwwfg@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="0000000000009add57058f4f3d03"
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

--0000000000009add57058f4f3d03
Content-Type: text/plain; charset="UTF-8"

Hi Gao & Guifu,

In order to eliminate use of a temp variable, I think we can safely do
following:

    case 'd':
                        cfg.c_dbg_lvl = atoi(optarg);
                        if (cfg.c_dbg_lvl < EROFS_MSG_MIN
                            || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
                                cfg.c_dbg_lvl = 0;      // reset the value
of debug level to '0'
                                erofs_err("invalid debug level %d\n",
                                        atoi(optarg));
                                return -EINVAL;
                        }
                        break;
I found this version much cleaner. Although it involves extra call to
atoi(). but thats trivial.
Let me know your thoughts.



On Sun, Aug 4, 2019 at 9:21 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Guifu,
>
> On Sun, Aug 04, 2019 at 11:41:47PM +0800, Li Guifu wrote:
> > GAO
> >       it's a good suggest, you're right
>
> I know that you don't have outgoing email permission when you are at work.
> I think you need to request this permission from your boss again.
>
> And could you take some spare time off work and review erofs-utils patches?
> That is of great help to erofs community. :)
>
> Thanks,
> Gao Xiang
>
> >
> > ?? 2019/8/4 23:25, Gao Xiang ????:
> > > Hi Guifu,
> > >
> > > On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:
> > > > Shinde and Gao
> > > >   Does the variable name of debug level use another name ? like d ?
> > > >   The i is usual a temporary increase or decrease self variable.
> > >
> > > I think we can use a common varible name in order to avoid
> > > too many temporary variables, maybe `i' is not the best
> > > naming, but `i' also stands for "a integer".
> > >
> > > Maybe we can give a better naming? can you name it and
> > > submit another patch? I personally don't like define too
> > > many used-once variables... How do you think?
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > ?? 2019/8/4 19:39, Pratik Shinde ????:
> > > > > Hi Gao,
> > > > >
> > > > > I Agree with your suggestion. Thanks for the additional code
> change. I
> > > > > think thats pretty much our final patch. :)
> > > > >
> > > > > -Pratik
> > > > >
> > > > > On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:
> > > > >
> > > > > > Hi Pratik,
> > > > > >
> > > > > > On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> > > > > > > Hi Gao,
> > > > > > >
> > > > > > > I used fprintf here because we are printing this error message
> in case of
> > > > > > > invalid 'cfg.c_dbg_lvl'. Hence I thought
> > > > > > > we cannot rely on erofs_err().
> > > > > > > e.g
> > > > > > > $ mkfs.erofs -d -1 <erofs image> <directory>
> > > > > > > In this case debug level is '-1' which is invalid.If we try to
> print the
> > > > > > > error message using erofs_err() with c_dbg_lvl = -1,
> > > > > > > it will not print anything.
> > > > > >
> > > > > > Yes, so c_dbg_lvl should be kept in default level (0) before
> > > > > > checking its vaildity I think.
> > > > > >
> > > > > > > While applying the minor fixup, just reset the c_dbg_lvl to 0
> , so that
> > > > > > > erofs_err() will be able to log the error message.
> > > > > >
> > > > > > Since there could be some messages already printed with
> erofs_xxx before
> > > > > > mkfs_parse_options_cfg(), I think we can use default level (0)
> before
> > > > > > checking its vaildity and switch to the given level after it, as
> below:
> > > > > >
> > > > > >                   case 'd':
> > > > > > -                       cfg.c_dbg_lvl =
> parse_num_from_str(optarg);
> > > > > > +                       i = atoi(optarg);
> > > > > > +                       if (i < EROFS_MSG_MIN || i >
> EROFS_MSG_MAX) {
> > > > > > +                               erofs_err("invalid debug level
> %d", i);
> > > > > > +                               return -EINVAL;
> > > > > > +                       }
> > > > > > +                       cfg.c_dbg_lvl = i;
> > > > > >
> > > > > >
> > > > > >
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
> > > > > >
> > > > > > Do you agree? :)
> > > > > >
> > > > > > Thanks,
> > > > > > Gao Xiang
> > > > > >
> > > > > > >
> > > > > > > --Pratik.
> > > > > > >
> > > > > > >
> > > > > > > On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com>
> wrote:
> > > > > > >
> > > > > > > > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde
> wrote:
> > > > > > > > > handling the case of incorrect debug level.
> > > > > > > > > Added an enumerated type for supported debug levels.
> > > > > > > > > Using 'atoi' in place of 'parse_num_from_str'.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > > > > > ---
> > > > > > > > >    include/erofs/print.h | 18 +++++++++++++-----
> > > > > > > > >    mkfs/main.c           | 19 ++++++++-----------
> > > > > > > > >    2 files changed, 21 insertions(+), 16 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > > > > > > > index bc0b8d4..296cbbf 100644
> > > > > > > > > --- a/include/erofs/print.h
> > > > > > > > > +++ b/include/erofs/print.h
> > > > > > > > > @@ -12,6 +12,15 @@
> > > > > > > > >    #include "config.h"
> > > > > > > > >    #include <stdio.h>
> > > > > > > > >
> > > > > > > > > +enum {
> > > > > > > > > +     EROFS_MSG_MIN = 0,
> > > > > > > > > +     EROFS_ERR     = 0,
> > > > > > > > > +     EROFS_WARN    = 2,
> > > > > > > > > +     EROFS_INFO    = 3,
> > > > > > > > > +     EROFS_DBG     = 7,
> > > > > > > > > +     EROFS_MSG_MAX = 9
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >    #define FUNC_LINE_FMT "%s() Line[%d] "
> > > > > > > > >
> > > > > > > > >    #ifndef pr_fmt
> > > > > > > > > @@ -19,7 +28,7 @@
> > > > > > > > >    #endif
> > > > > > > > >
> > > > > > > > >    #define erofs_dbg(fmt, ...) do {
>      \
> > > > > > > > > -     if (cfg.c_dbg_lvl >= 7) {
>    \
> > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {
>    \
> > > > > > > > >                 fprintf(stdout,
>      \
> > > > > > > > >                         pr_fmt(fmt),
>       \
> > > > > > > > >                         __func__,
>      \
> > > > > > > > > @@ -29,7 +38,7 @@
> > > > > > > > >    } while (0)
> > > > > > > > >
> > > > > > > > >    #define erofs_info(fmt, ...) do {
>       \
> > > > > > > > > -     if (cfg.c_dbg_lvl >= 3) {
>    \
> > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {
>     \
> > > > > > > > >                 fprintf(stdout,
>      \
> > > > > > > > >                         pr_fmt(fmt),
>       \
> > > > > > > > >                         __func__,
>      \
> > > > > > > > > @@ -40,7 +49,7 @@
> > > > > > > > >    } while (0)
> > > > > > > > >
> > > > > > > > >    #define erofs_warn(fmt, ...) do {
>       \
> > > > > > > > > -     if (cfg.c_dbg_lvl >= 2) {
>    \
> > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {
>     \
> > > > > > > > >                 fprintf(stdout,
>      \
> > > > > > > > >                         pr_fmt(fmt),
>       \
> > > > > > > > >                         __func__,
>      \
> > > > > > > > > @@ -51,7 +60,7 @@
> > > > > > > > >    } while (0)
> > > > > > > > >
> > > > > > > > >    #define erofs_err(fmt, ...) do {
>      \
> > > > > > > > > -     if (cfg.c_dbg_lvl >= 0) {
>    \
> > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {
>    \
> > > > > > > > >                 fprintf(stderr,
>      \
> > > > > > > > >                         "Err: " pr_fmt(fmt),
>       \
> > > > > > > > >                         __func__,
>      \
> > > > > > > > > @@ -64,4 +73,3 @@
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >    #endif
> > > > > > > > > -
> > > > > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > > > > index fdb65fd..d915d00 100644
> > > > > > > > > --- a/mkfs/main.c
> > > > > > > > > +++ b/mkfs/main.c
> > > > > > > > > @@ -30,16 +30,6 @@ static void usage(void)
> > > > > > > > >         fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > > > > >    }
> > > > > > > > >
> > > > > > > > > -u64 parse_num_from_str(const char *str)
> > > > > > > > > -{
> > > > > > > > > -     u64 num      = 0;
> > > > > > > > > -     char *endptr = NULL;
> > > > > > > > > -
> > > > > > > > > -     num = strtoull(str, &endptr, 10);
> > > > > > > > > -     BUG_ON(num == ULLONG_MAX);
> > > > > > > > > -     return num;
> > > > > > > > > -}
> > > > > > > > > -
> > > > > > > > >    static int parse_extended_opts(const char *opts)
> > > > > > > > >    {
> > > > > > > > >    #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > > > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int
> argc, char
> > > > > > > > *argv[])
> > > > > > > > >                         break;
> > > > > > > > >
> > > > > > > > >                 case 'd':
> > > > > > > > > -                     cfg.c_dbg_lvl =
> parse_num_from_str(optarg);
> > > > > > > > > +                     cfg.c_dbg_lvl = atoi(optarg);
> > > > > > > > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > > > > > > > +                         || cfg.c_dbg_lvl >
> EROFS_MSG_MAX) {
> > > > > > > > > +                             fprintf(stderr,
> > > > > > > > > +                                     "invalid debug level
> %d\n",
> > > > > > > > > +                                     cfg.c_dbg_lvl);
> > > > > > > >
> > > > > > > > How about using erofs_err as my previous patch attached?
> > > > > > > > I wonder if there are some specfic reasons to directly use
> fprintf
> > > > > > instead?
> > > > > > > >
> > > > > > > > I will apply it with this minor fixup (no need to resend
> again), if you
> > > > > > > > have
> > > > > > > > other considerations, reply me in this thread, thanks. :)
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Gao Xiang
> > > > > > > >
> > > > > > > > > +                             return -EINVAL;
> > > > > > > > > +                     }
> > > > > > > > >                         break;
> > > > > > > > >
> > > > > > > > >                 case 'E':
> > > > > > > > > --
> > > > > > > > > 2.9.3
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > > >
>

--0000000000009add57058f4f3d03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao &amp; Guifu,</div><div><br></div><div>In order=
 to eliminate use of a temp variable, I think we can safely do following:</=
div><div><br></div><div>=C2=A0 =C2=A0 case &#39;d&#39;:<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c=
_dbg_lvl =3D atoi(optarg);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cfg.c_dbg_lvl &lt; EROFS_MSG_MIN=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 || cfg.c_dbg_lvl &gt; EROFS_MSG_MAX) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cfg.c_dbg_lvl =3D 0;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 // reset the value of debug level to &#39;0&#39;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_err(&quot;invalid debug level %d\n&quot;,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 atoi(=
optarg)); <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;<br></div><div>I found this version much cleaner=
. Although it involves extra call to atoi(). but thats trivial.</div><div>L=
et me know your thoughts.</div><div><br></div><div><br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 4,=
 2019 at 9:21 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangk=
ao@aol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Guifu,<br>
<br>
On Sun, Aug 04, 2019 at 11:41:47PM +0800, Li Guifu wrote:<br>
&gt; GAO<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0it&#39;s a good suggest, you&#39;re right<br=
>
<br>
I know that you don&#39;t have outgoing email permission when you are at wo=
rk.<br>
I think you need to request this permission from your boss again.<br>
<br>
And could you take some spare time off work and review erofs-utils patches?=
<br>
That is of great help to erofs community. :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; ?? 2019/8/4 23:25, Gao Xiang ????:<br>
&gt; &gt; Hi Guifu,<br>
&gt; &gt; <br>
&gt; &gt; On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:<br>
&gt; &gt; &gt; Shinde and Gao<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Does the variable name of debug level use anothe=
r name ? like d ?<br>
&gt; &gt; &gt;=C2=A0 =C2=A0The i is usual a temporary increase or decrease =
self variable.<br>
&gt; &gt; <br>
&gt; &gt; I think we can use a common varible name in order to avoid<br>
&gt; &gt; too many temporary variables, maybe `i&#39; is not the best<br>
&gt; &gt; naming, but `i&#39; also stands for &quot;a integer&quot;.<br>
&gt; &gt; <br>
&gt; &gt; Maybe we can give a better naming? can you name it and<br>
&gt; &gt; submit another patch? I personally don&#39;t like define too<br>
&gt; &gt; many used-once variables... How do you think?<br>
&gt; &gt; <br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; ?? 2019/8/4 19:39, Pratik Shinde ????:<br>
&gt; &gt; &gt; &gt; Hi Gao,<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I Agree with your suggestion. Thanks for the additional=
 code change. I<br>
&gt; &gt; &gt; &gt; think thats pretty much our final patch. :)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; -Pratik<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, &lt;<a href=3D"=
mailto:hsiangkao@gmx.com" target=3D"_blank">hsiangkao@gmx.com</a>&gt; wrote=
:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Hi Pratik,<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik S=
hinde wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; Hi Gao,<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; I used fprintf here because we are printing t=
his error message in case of<br>
&gt; &gt; &gt; &gt; &gt; &gt; invalid &#39;cfg.c_dbg_lvl&#39;. Hence I thou=
ght<br>
&gt; &gt; &gt; &gt; &gt; &gt; we cannot rely on erofs_err().<br>
&gt; &gt; &gt; &gt; &gt; &gt; e.g<br>
&gt; &gt; &gt; &gt; &gt; &gt; $ mkfs.erofs -d -1 &lt;erofs image&gt; &lt;di=
rectory&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; In this case debug level is &#39;-1&#39; whic=
h is invalid.If we try to print the<br>
&gt; &gt; &gt; &gt; &gt; &gt; error message using erofs_err() with c_dbg_lv=
l =3D -1,<br>
&gt; &gt; &gt; &gt; &gt; &gt; it will not print anything.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Yes, so c_dbg_lvl should be kept in default level =
(0) before<br>
&gt; &gt; &gt; &gt; &gt; checking its vaildity I think.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; While applying the minor fixup, just reset th=
e c_dbg_lvl to 0 , so that<br>
&gt; &gt; &gt; &gt; &gt; &gt; erofs_err() will be able to log the error mes=
sage.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Since there could be some messages already printed=
 with erofs_xxx before<br>
&gt; &gt; &gt; &gt; &gt; mkfs_parse_options_cfg(), I think we can use defau=
lt level (0) before<br>
&gt; &gt; &gt; &gt; &gt; checking its vaildity and switch to the given leve=
l after it, as below:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0case &#39;d&#39;:<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D parse_num_from_str(opta=
rg);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D atoi(optarg);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &lt; EROFS_MSG_MIN || i &gt; EROFS_=
MSG_MAX) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&qu=
ot;invalid debug level %d&quot;, i);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D i;<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://git.kernel.org/pub/scm/linux/ke=
rnel/git/xiang/erofs-utils.git/commit/?h=3Ddev&amp;id=3D26097242976cce68e21=
d8b569dfda63fb68f356c" rel=3D"noreferrer" target=3D"_blank">https://git.ker=
nel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=3Ddev&amp;=
id=3D26097242976cce68e21d8b569dfda63fb68f356c</a><br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Do you agree? :)<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt; Gao Xiang<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; --Pratik.<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang &lt;=
<a href=3D"mailto:hsiangkao@aol.com" target=3D"_blank">hsiangkao@aol.com</a=
>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Sun, Aug 04, 2019 at 01:49:43PM +0530=
, Pratik Shinde wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; handling the case of incorrect debu=
g level.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Added an enumerated type for suppor=
ted debug levels.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Using &#39;atoi&#39; in place of &#=
39;parse_num_from_str&#39;.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a=
 href=3D"mailto:pratikshinde320@gmail.com" target=3D"_blank">pratikshinde32=
0@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 include/erofs/print.h =
| 18 +++++++++++++-----<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 mkfs/main.c=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 ++++++++-----------<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 2 files changed, 21 in=
sertions(+), 16 deletions(-)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; diff --git a/include/erofs/print.h =
b/include/erofs/print.h<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; index bc0b8d4..296cbbf 100644<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --- a/include/erofs/print.h<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +++ b/include/erofs/print.h<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -12,6 +12,15 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #include &quot;config.=
h&quot;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #include &lt;stdio.h&g=
t;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +enum {<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_MSG_MIN =
=3D 0,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_ERR=C2=
=A0 =C2=A0 =C2=A0=3D 0,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_WARN=C2=
=A0 =C2=A0 =3D 2,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_INFO=C2=
=A0 =C2=A0 =3D 3,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_DBG=C2=
=A0 =C2=A0 =C2=A0=3D 7,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0EROFS_MSG_MAX =
=3D 9<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define FUNC_LINE_FMT =
&quot;%s() Line[%d] &quot;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #ifndef pr_fmt<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -19,7 +28,7 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #endif<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define erofs_dbg(fmt,=
 ...) do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D 7) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D EROFS_DBG) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -29,7 +38,7 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 } while (0)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define erofs_info(fmt=
, ...) do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D 3) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D EROFS_INFO) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -40,7 +49,7 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 } while (0)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define erofs_warn(fmt=
, ...) do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D 2) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D EROFS_WARN) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_fmt(fmt),=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -51,7 +60,7 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 } while (0)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define erofs_err(fmt,=
 ...) do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D 0) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_=
lvl &gt;=3D EROFS_ERR) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Err: &quot; pr=
_fmt(fmt),=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__,=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -64,4 +73,3 @@<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #endif<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; diff --git a/mkfs/main.c b/mkfs/mai=
n.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; index fdb65fd..d915d00 100644<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --- a/mkfs/main.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +++ b/mkfs/main.c<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -30,16 +30,6 @@ static void usag=
e(void)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp=
rintf(stderr, &quot; -EX[,...] X=3Dextended options\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -u64 parse_num_from_str(const char =
*str)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -{<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0u64 num=C2=A0 =
=C2=A0 =C2=A0 =3D 0;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0char *endptr =
=3D NULL;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0num =3D strtou=
ll(str, &amp;endptr, 10);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0BUG_ON(num =3D=
=3D ULLONG_MAX);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0return num;<br=
>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -}<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 static int parse_exten=
ded_opts(const char *opts)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 #define MATCH_EXTENTED=
_OPT(opt, token, keylen) \<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; @@ -108,7 +98,14 @@ static int mkfs=
_parse_options_cfg(int argc, char<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; *argv[])<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;d&#39;:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D parse_num_from_=
str(optarg);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl =3D atoi(optarg);<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfg.c_dbg_lvl &lt; EROFS_MSG_=
MIN<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| cfg.c_dbg_lvl &g=
t; EROFS_MSG_MAX) {<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprin=
tf(stderr,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;invalid debug level %d\n&quot;,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_dbg_lvl);<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; How about using erofs_err as my previous=
 patch attached?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I wonder if there are some specfic reaso=
ns to directly use fprintf<br>
&gt; &gt; &gt; &gt; &gt; instead?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I will apply it with this minor fixup (n=
o need to resend again), if you<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; have<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; other considerations, reply me in this t=
hread, thanks. :)<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Gao Xiang<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -EINVAL;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;E&#39;:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; 2.9.3<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
</blockquote></div>

--0000000000009add57058f4f3d03--
