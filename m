Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D77880AB3
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 13:37:45 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461f5d5r3rzDqc1
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 21:37:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.com
 (client-ip=212.227.17.21; helo=mout.gmx.net; envelope-from=hsiangkao@gmx.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="QOmSCMG4"; 
 dkim-atps=neutral
X-Greylist: delayed 326 seconds by postgrey-1.36 at bilbo;
 Sun, 04 Aug 2019 21:37:26 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461f5L0HPlzDqR7
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 21:37:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1564918640;
 bh=x+T+8H23/kahoxr6gzecrNhamn/Eg+9f6smUS3mEgII=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QOmSCMG4LxCNBnbILn6MNp8DOVY0+2bs9+0LtIetHXfchQX/ZdEOyW4Lw98G7n+vD
 EPZMpDl7H8qiJVCPSAU0v2Mrx7yksqAriLcO+do+pAng/OJFddZx/mphwIqx6AwrgT
 mcRyhIrWn+tM9jVFIXhHY05nmaW77QfBhJ6vx/VU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([60.177.33.208]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LkCU2-1iUxCC18Uk-00cCQH; Sun, 04 Aug 2019 13:31:39 +0200
Date: Sun, 4 Aug 2019 19:31:31 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:n6V1MUw1B2FyxFSl6a9pAG96hF5g5+YRvf3Cd3V0+jPeLQCFkjj
 eSPYNQYf+yrfZz4tbBICKKFOE7+r0OgmSEt6gx7yCNMZnMXkvsot3t8oqq+8OYv2CjtjNVu
 B2Ba0neLAzV0xkEaach3Z1C8f81Bx2Y5FFrmHhZTdgVCn7rjSi4ssa/IlnOVb6mXVW8Wlug
 56/Vx1XzVR4Q5U70weo5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CxGViIm1lZ8=:dHtwe3Y1tr3CEW44l5lLuG
 l9bWWBrgUtiFArtZWQpphorEvWFQ8K7uXupFWXsRBKWebDuKs02/RAr9hehZIgZ7RGQ4A79q4
 908I8W7UfmZBjL6nx/yti5d456wa3ZXah/EvgwYomyZoauFmm14uVkzKkU/BgzZBfyZrBpj2c
 osnjWZaoTHjMSp5+hYwSbo0X4BE7nKaGA62BjZThhImA2MdnEhSYZF5Tsd7qSgOUiT4BmRykE
 /MnQCuK1sg2K8he92VnfXUT0sjrPOaCIiORcRCFYneCCATO0Cl8N+y/ne9HaxqgT2VlXvpNM/
 Nxz7rE0A2zuz1ffyI5deYNZgjxcOFO9RJ2YyWzbcTwuMW5wFelhqkfvO63l//nxnKXuasHvYV
 mTHcpusNKRwUQe6Cy0GmGvKEHc3lHxsjvNjTjIagVliXI+gGb+tkGrO5bTF6YUu+oSwF+BEDT
 eGaFgrC+IL0weAzAbcwyHFbyhhDW2MA8BbR6Oy1JKnKPCCAlMbJYWT9FaAe4/Gump6YszsUY8
 9jQvC2I6icpquo1icgWGsyybZCvkhObBcG9jPLxmFqBZmVsq/zM3lYglqI7cEueJezWlcms0M
 2870IgbdBqG9ijRFmVpQT1mrcbYTBSO+/Oev12sFJzRjw11ToOY6KsvCOm6rTr+aV7gtTfI93
 gBAueyxxnbNQbPRptCgSrxDtwc2/YKUF1N0WqN/AKQtsrh9FG1KiLhIvmHh9um3FDXO1aQPB3
 N8+rcGPX6kfQwxyxZ1jyucpjdXH5xQJ12X0O/l8eco/wwpUwU4m3hVZtYic90/Skd4l05rc1K
 JSKpaajMYWOodEW4uqlM5SzNvFz9HuGHzJ0kia9nV87vwWR2p8gUdbb/FE/x14UfdFF6d21Z5
 lv1/Xct5tWU50Z5YijxEiq8m9Q/DFdmd0KdiyX5Dmh+rynQXnV0D275hgT5LSvcDCbwW/QcNy
 cF2b/uKNCHxXbu9WiztPFfF7u2KwE9vVXN5gShGwIwqqqRMj7YKjOyhR9m1agXzXzbnarlpq9
 /idqDNHmJ4IbOD3L5qblAKeWqaQ0csJNG6+rBDtbYSM2Y07lKwXXQKTl6Qr878+FtiXzerfwJ
 ost6FjC/SbiDRai69ca0uVRmC6qbBLmAAbCI+Tf7mVrXEwhBEV50y/T8Q==
Content-Transfer-Encoding: quoted-printable
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

Hi Pratik,

On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> Hi Gao,
>
> I used fprintf here because we are printing this error message in case o=
f
> invalid 'cfg.c_dbg_lvl'. Hence I thought
> we cannot rely on erofs_err().
> e.g
> $ mkfs.erofs -d -1 <erofs image> <directory>
> In this case debug level is '-1' which is invalid.If we try to print the
> error message using erofs_err() with c_dbg_lvl =3D -1,
> it will not print anything.

Yes, so c_dbg_lvl should be kept in default level (0) before
checking its vaildity I think.

> While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
> erofs_err() will be able to log the error message.

Since there could be some messages already printed with erofs_xxx before
mkfs_parse_options_cfg(), I think we can use default level (0) before
checking its vaildity and switch to the given level after it, as below:

 		case 'd':
-			cfg.c_dbg_lvl =3D parse_num_from_str(optarg);
+			i =3D atoi(optarg);
+			if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
+				erofs_err("invalid debug level %d", i);
+				return -EINVAL;
+			}
+			cfg.c_dbg_lvl =3D i;

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/comm=
it/?h=3Ddev&id=3D26097242976cce68e21d8b569dfda63fb68f356c

Do you agree? :)

Thanks,
Gao Xiang

>
> --Pratik.
>
>
> On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:
>
> > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> > > handling the case of incorrect debug level.
> > > Added an enumerated type for supported debug levels.
> > > Using 'atoi' in place of 'parse_num_from_str'.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  include/erofs/print.h | 18 +++++++++++++-----
> > >  mkfs/main.c           | 19 ++++++++-----------
> > >  2 files changed, 21 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > index bc0b8d4..296cbbf 100644
> > > --- a/include/erofs/print.h
> > > +++ b/include/erofs/print.h
> > > @@ -12,6 +12,15 @@
> > >  #include "config.h"
> > >  #include <stdio.h>
> > >
> > > +enum {
> > > +     EROFS_MSG_MIN =3D 0,
> > > +     EROFS_ERR     =3D 0,
> > > +     EROFS_WARN    =3D 2,
> > > +     EROFS_INFO    =3D 3,
> > > +     EROFS_DBG     =3D 7,
> > > +     EROFS_MSG_MAX =3D 9
> > > +};
> > > +
> > >  #define FUNC_LINE_FMT "%s() Line[%d] "
> > >
> > >  #ifndef pr_fmt
> > > @@ -19,7 +28,7 @@
> > >  #endif
> > >
> > >  #define erofs_dbg(fmt, ...) do {                             \
> > > -     if (cfg.c_dbg_lvl >=3D 7) {                               \
> > > +     if (cfg.c_dbg_lvl >=3D EROFS_DBG) {                       \
> > >               fprintf(stdout,                                 \
> > >                       pr_fmt(fmt),                            \
> > >                       __func__,                               \
> > > @@ -29,7 +38,7 @@
> > >  } while (0)
> > >
> > >  #define erofs_info(fmt, ...) do {                            \
> > > -     if (cfg.c_dbg_lvl >=3D 3) {                               \
> > > +     if (cfg.c_dbg_lvl >=3D EROFS_INFO) {                      \
> > >               fprintf(stdout,                                 \
> > >                       pr_fmt(fmt),                            \
> > >                       __func__,                               \
> > > @@ -40,7 +49,7 @@
> > >  } while (0)
> > >
> > >  #define erofs_warn(fmt, ...) do {                            \
> > > -     if (cfg.c_dbg_lvl >=3D 2) {                               \
> > > +     if (cfg.c_dbg_lvl >=3D EROFS_WARN) {                      \
> > >               fprintf(stdout,                                 \
> > >                       pr_fmt(fmt),                            \
> > >                       __func__,                               \
> > > @@ -51,7 +60,7 @@
> > >  } while (0)
> > >
> > >  #define erofs_err(fmt, ...) do {                             \
> > > -     if (cfg.c_dbg_lvl >=3D 0) {                               \
> > > +     if (cfg.c_dbg_lvl >=3D EROFS_ERR) {                       \
> > >               fprintf(stderr,                                 \
> > >                       "Err: " pr_fmt(fmt),                    \
> > >                       __func__,                               \
> > > @@ -64,4 +73,3 @@
> > >
> > >
> > >  #endif
> > > -
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index fdb65fd..d915d00 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -30,16 +30,6 @@ static void usage(void)
> > >       fprintf(stderr, " -EX[,...] X=3Dextended options\n");
> > >  }
> > >
> > > -u64 parse_num_from_str(const char *str)
> > > -{
> > > -     u64 num      =3D 0;
> > > -     char *endptr =3D NULL;
> > > -
> > > -     num =3D strtoull(str, &endptr, 10);
> > > -     BUG_ON(num =3D=3D ULLONG_MAX);
> > > -     return num;
> > > -}
> > > -
> > >  static int parse_extended_opts(const char *opts)
> > >  {
> > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
> > *argv[])
> > >                       break;
> > >
> > >               case 'd':
> > > -                     cfg.c_dbg_lvl =3D parse_num_from_str(optarg);
> > > +                     cfg.c_dbg_lvl =3D atoi(optarg);
> > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> > > +                             fprintf(stderr,
> > > +                                     "invalid debug level %d\n",
> > > +                                     cfg.c_dbg_lvl);
> >
> > How about using erofs_err as my previous patch attached?
> > I wonder if there are some specfic reasons to directly use fprintf ins=
tead?
> >
> > I will apply it with this minor fixup (no need to resend again), if yo=
u
> > have
> > other considerations, reply me in this thread, thanks. :)
> >
> > Thanks,
> > Gao Xiang
> >
> > > +                             return -EINVAL;
> > > +                     }
> > >                       break;
> > >
> > >               case 'E':
> > > --
> > > 2.9.3
> > >
> >
