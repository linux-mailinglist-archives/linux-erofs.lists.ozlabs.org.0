Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47B8101F
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 04:03:38 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4621Jl1zYJzDqTm
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 12:03:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4621JZ4FL8zDqSJ
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2019 12:03:26 +1000 (AEST)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 389D25DA92FCD485EA61;
 Mon,  5 Aug 2019 10:03:13 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 5 Aug 2019 10:03:12 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 5
 Aug 2019 10:03:12 +0800
Date: Mon, 5 Aug 2019 10:20:21 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190805022019.GA12919@138>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
 <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
 <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
 <08f63a50-105c-d97a-8db1-db486e9616a2@gmail.com>
 <20190804154951.GA7446@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czTR7JzNT_xtH=uez_ZJ3POCPLvK3E-ry=BfW4=HPBwwfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czTR7JzNT_xtH=uez_ZJ3POCPLvK3E-ry=BfW4=HPBwwfg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Mon, Aug 05, 2019 at 12:32:51AM +0530, Pratik Shinde wrote:
> Hi Gao & Guifu,
> 
> In order to eliminate use of a temp variable, I think we can safely do
> following:
> 
>     case 'd':
>                         cfg.c_dbg_lvl = atoi(optarg);
>                         if (cfg.c_dbg_lvl < EROFS_MSG_MIN
>                             || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
>                                 cfg.c_dbg_lvl = 0;      // reset the value
> of debug level to '0'

The default level is set in erofs_init_configure() in config.c by design,
and no need to reset again (BTW, the default value could not be 0, maybe
9 or even -1 to for silent mode in the future).

Saving the old value before could help, but I think in that way we need
to introduce another temp variable to save old default value.

I think that is minor, if there are better names here, we can rename `i',
or you can submit another patch to introduce another temp variable to
replace `i'.

Thanks,
Gao Xiang

>                                 erofs_err("invalid debug level %d\n",
>                                         atoi(optarg));
>                                 return -EINVAL;
>                         }
>                         break;
> I found this version much cleaner. Although it involves extra call to
> atoi(). but thats trivial.
> Let me know your thoughts.
> 
> 
> 
> On Sun, Aug 4, 2019 at 9:21 PM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > Hi Guifu,
> >
> > On Sun, Aug 04, 2019 at 11:41:47PM +0800, Li Guifu wrote:
> > > GAO
> > >       it's a good suggest, you're right
> >
> > I know that you don't have outgoing email permission when you are at work.
> > I think you need to request this permission from your boss again.
> >
> > And could you take some spare time off work and review erofs-utils patches?
> > That is of great help to erofs community. :)
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > ?? 2019/8/4 23:25, Gao Xiang ????:
> > > > Hi Guifu,
> > > >
> > > > On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:
> > > > > Shinde and Gao
> > > > >   Does the variable name of debug level use another name ? like d ?
> > > > >   The i is usual a temporary increase or decrease self variable.
> > > >
> > > > I think we can use a common varible name in order to avoid
> > > > too many temporary variables, maybe `i' is not the best
> > > > naming, but `i' also stands for "a integer".
> > > >
> > > > Maybe we can give a better naming? can you name it and
> > > > submit another patch? I personally don't like define too
> > > > many used-once variables... How do you think?
> > > >
> > > > Thanks,
> > > > Gao Xiang
> > > >
> > > > >
> > > > > ?? 2019/8/4 19:39, Pratik Shinde ????:
> > > > > > Hi Gao,
> > > > > >
> > > > > > I Agree with your suggestion. Thanks for the additional code
> > change. I
> > > > > > think thats pretty much our final patch. :)
> > > > > >
> > > > > > -Pratik
> > > > > >
> > > > > > On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:
> > > > > >
> > > > > > > Hi Pratik,
> > > > > > >
> > > > > > > On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> > > > > > > > Hi Gao,
> > > > > > > >
> > > > > > > > I used fprintf here because we are printing this error message
> > in case of
> > > > > > > > invalid 'cfg.c_dbg_lvl'. Hence I thought
> > > > > > > > we cannot rely on erofs_err().
> > > > > > > > e.g
> > > > > > > > $ mkfs.erofs -d -1 <erofs image> <directory>
> > > > > > > > In this case debug level is '-1' which is invalid.If we try to
> > print the
> > > > > > > > error message using erofs_err() with c_dbg_lvl = -1,
> > > > > > > > it will not print anything.
> > > > > > >
> > > > > > > Yes, so c_dbg_lvl should be kept in default level (0) before
> > > > > > > checking its vaildity I think.
> > > > > > >
> > > > > > > > While applying the minor fixup, just reset the c_dbg_lvl to 0
> > , so that
> > > > > > > > erofs_err() will be able to log the error message.
> > > > > > >
> > > > > > > Since there could be some messages already printed with
> > erofs_xxx before
> > > > > > > mkfs_parse_options_cfg(), I think we can use default level (0)
> > before
> > > > > > > checking its vaildity and switch to the given level after it, as
> > below:
> > > > > > >
> > > > > > >                   case 'd':
> > > > > > > -                       cfg.c_dbg_lvl =
> > parse_num_from_str(optarg);
> > > > > > > +                       i = atoi(optarg);
> > > > > > > +                       if (i < EROFS_MSG_MIN || i >
> > EROFS_MSG_MAX) {
> > > > > > > +                               erofs_err("invalid debug level
> > %d", i);
> > > > > > > +                               return -EINVAL;
> > > > > > > +                       }
> > > > > > > +                       cfg.c_dbg_lvl = i;
> > > > > > >
> > > > > > >
> > > > > > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
> > > > > > >
> > > > > > > Do you agree? :)
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Gao Xiang
> > > > > > >
> > > > > > > >
> > > > > > > > --Pratik.
> > > > > > > >
> > > > > > > >
> > > > > > > > On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com>
> > wrote:
> > > > > > > >
> > > > > > > > > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde
> > wrote:
> > > > > > > > > > handling the case of incorrect debug level.
> > > > > > > > > > Added an enumerated type for supported debug levels.
> > > > > > > > > > Using 'atoi' in place of 'parse_num_from_str'.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >    include/erofs/print.h | 18 +++++++++++++-----
> > > > > > > > > >    mkfs/main.c           | 19 ++++++++-----------
> > > > > > > > > >    2 files changed, 21 insertions(+), 16 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > > > > > > > > index bc0b8d4..296cbbf 100644
> > > > > > > > > > --- a/include/erofs/print.h
> > > > > > > > > > +++ b/include/erofs/print.h
> > > > > > > > > > @@ -12,6 +12,15 @@
> > > > > > > > > >    #include "config.h"
> > > > > > > > > >    #include <stdio.h>
> > > > > > > > > >
> > > > > > > > > > +enum {
> > > > > > > > > > +     EROFS_MSG_MIN = 0,
> > > > > > > > > > +     EROFS_ERR     = 0,
> > > > > > > > > > +     EROFS_WARN    = 2,
> > > > > > > > > > +     EROFS_INFO    = 3,
> > > > > > > > > > +     EROFS_DBG     = 7,
> > > > > > > > > > +     EROFS_MSG_MAX = 9
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > >    #define FUNC_LINE_FMT "%s() Line[%d] "
> > > > > > > > > >
> > > > > > > > > >    #ifndef pr_fmt
> > > > > > > > > > @@ -19,7 +28,7 @@
> > > > > > > > > >    #endif
> > > > > > > > > >
> > > > > > > > > >    #define erofs_dbg(fmt, ...) do {
> >      \
> > > > > > > > > > -     if (cfg.c_dbg_lvl >= 7) {
> >    \
> > > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {
> >    \
> > > > > > > > > >                 fprintf(stdout,
> >      \
> > > > > > > > > >                         pr_fmt(fmt),
> >       \
> > > > > > > > > >                         __func__,
> >      \
> > > > > > > > > > @@ -29,7 +38,7 @@
> > > > > > > > > >    } while (0)
> > > > > > > > > >
> > > > > > > > > >    #define erofs_info(fmt, ...) do {
> >       \
> > > > > > > > > > -     if (cfg.c_dbg_lvl >= 3) {
> >    \
> > > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {
> >     \
> > > > > > > > > >                 fprintf(stdout,
> >      \
> > > > > > > > > >                         pr_fmt(fmt),
> >       \
> > > > > > > > > >                         __func__,
> >      \
> > > > > > > > > > @@ -40,7 +49,7 @@
> > > > > > > > > >    } while (0)
> > > > > > > > > >
> > > > > > > > > >    #define erofs_warn(fmt, ...) do {
> >       \
> > > > > > > > > > -     if (cfg.c_dbg_lvl >= 2) {
> >    \
> > > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {
> >     \
> > > > > > > > > >                 fprintf(stdout,
> >      \
> > > > > > > > > >                         pr_fmt(fmt),
> >       \
> > > > > > > > > >                         __func__,
> >      \
> > > > > > > > > > @@ -51,7 +60,7 @@
> > > > > > > > > >    } while (0)
> > > > > > > > > >
> > > > > > > > > >    #define erofs_err(fmt, ...) do {
> >      \
> > > > > > > > > > -     if (cfg.c_dbg_lvl >= 0) {
> >    \
> > > > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {
> >    \
> > > > > > > > > >                 fprintf(stderr,
> >      \
> > > > > > > > > >                         "Err: " pr_fmt(fmt),
> >       \
> > > > > > > > > >                         __func__,
> >      \
> > > > > > > > > > @@ -64,4 +73,3 @@
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >    #endif
> > > > > > > > > > -
> > > > > > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > > > > > index fdb65fd..d915d00 100644
> > > > > > > > > > --- a/mkfs/main.c
> > > > > > > > > > +++ b/mkfs/main.c
> > > > > > > > > > @@ -30,16 +30,6 @@ static void usage(void)
> > > > > > > > > >         fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > > > > > >    }
> > > > > > > > > >
> > > > > > > > > > -u64 parse_num_from_str(const char *str)
> > > > > > > > > > -{
> > > > > > > > > > -     u64 num      = 0;
> > > > > > > > > > -     char *endptr = NULL;
> > > > > > > > > > -
> > > > > > > > > > -     num = strtoull(str, &endptr, 10);
> > > > > > > > > > -     BUG_ON(num == ULLONG_MAX);
> > > > > > > > > > -     return num;
> > > > > > > > > > -}
> > > > > > > > > > -
> > > > > > > > > >    static int parse_extended_opts(const char *opts)
> > > > > > > > > >    {
> > > > > > > > > >    #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > > > > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int
> > argc, char
> > > > > > > > > *argv[])
> > > > > > > > > >                         break;
> > > > > > > > > >
> > > > > > > > > >                 case 'd':
> > > > > > > > > > -                     cfg.c_dbg_lvl =
> > parse_num_from_str(optarg);
> > > > > > > > > > +                     cfg.c_dbg_lvl = atoi(optarg);
> > > > > > > > > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > > > > > > > > +                         || cfg.c_dbg_lvl >
> > EROFS_MSG_MAX) {
> > > > > > > > > > +                             fprintf(stderr,
> > > > > > > > > > +                                     "invalid debug level
> > %d\n",
> > > > > > > > > > +                                     cfg.c_dbg_lvl);
> > > > > > > > >
> > > > > > > > > How about using erofs_err as my previous patch attached?
> > > > > > > > > I wonder if there are some specfic reasons to directly use
> > fprintf
> > > > > > > instead?
> > > > > > > > >
> > > > > > > > > I will apply it with this minor fixup (no need to resend
> > again), if you
> > > > > > > > > have
> > > > > > > > > other considerations, reply me in this thread, thanks. :)
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Gao Xiang
> > > > > > > > >
> > > > > > > > > > +                             return -EINVAL;
> > > > > > > > > > +                     }
> > > > > > > > > >                         break;
> > > > > > > > > >
> > > > > > > > > >                 case 'E':
> > > > > > > > > > --
> > > > > > > > > > 2.9.3
> > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > > >
> >
