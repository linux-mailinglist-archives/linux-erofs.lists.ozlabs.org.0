Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6980B70
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 17:26:34 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461l9h203jzDqNt
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 01:26:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1564932392;
	bh=vKN1qLQiKkRIYS+GrIg8TFELo/l22iyCx+/EE3/lBMw=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YkoLwebGAOd0ygsKYVCI7znlNLvPkPUKMdnf/ZAGKQgn4jhgmPzn7QXZs3EkZcU28
	 hhQMiMqHmCXVn2oHXEDeNOm3QzgCM5+28l4DqQPc8z/5o1mntswIk/NMNT9gk3Gcrj
	 KCq9XzVDHbt5YvXjo8Tp9Cj78MK8JiIpK8Q5RiFIr8NUEfteavEYA918rZsuYt7Z6I
	 X2tfiqSR+Rc17etlnaQwr2ntqRU1Nl5TqUWIp+gk2ESqYPiUEvw70XQcSfv8RefxDp
	 2N1sSpbXOpNSTbgi902i2gSf8oWrre4TsQOij/N8GNNHB4kD0V/BoBVk4q2NEIjVqL
	 ECoIEoQoUUAcg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.147; helo=sonic301-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="UJiCIV1M"; 
 dkim-atps=neutral
Received: from sonic301-21.consmr.mail.gq1.yahoo.com
 (sonic301-21.consmr.mail.gq1.yahoo.com [98.137.64.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461l9T5p7vzDqMB
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2019 01:26:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1564932365; bh=VHrGLQwpkkC+qRPm4C7GT7PE4S+1ypxNEUM5KWDfP3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=UJiCIV1MG5ZXrb0LpYZZ6Db17PSZwaJNR2xDAru9BZanGQ5XVNd5f44dSHo0TRnDW4nb/FNSBaIwsv0CigV9qLgXslzE0NRHT/ztSMg47MiUrjoR/DasofIdnZL+jexAXSKQzw6u5WH0mKUQFttfn/Nx9Prq3yovtLSXS/0K0K8BOGaAm4KUW5phEpJ7qgZhUa6LPaJONFvTaT0EmY3dRaVGQlSbjmlIlFCLbVITkHd4/PiCll7eQr70rLcQQwQ9DPpiz66Y9YJY4uuoCjBQUBnkLJDMStBzttvPU3DtSelPSN3W7lk1ocUVSSpyc7F3zyBs/1wxzi9VJcuLbobQIA==
X-YMail-OSG: kURIuacVM1mkBlckZnA_TpDB0DJtQWh4mnZg7ZOLXLnD3mOcPfbR5vuFcglScKX
 8KiywEfOZzfNP1hRXBuN_w4b5nKrukgkMbL6KplWEsZyfPgoAvBc8_x6YhWgS29DAydLRsEHsGG0
 o0S3lWvlQ7KooghPYjat4SgYr1jL74c9miUGzWBFPXyk_I_6YpCZXADnbngTrkfZpaO3Llr19WSi
 mprdaH7uIDEQvN4DaPvHS9i_LMngMjVvx1578jBpKibNJ1yJGlzYOgB7EmjUXykhZZQqzYsCLz1B
 5Yb3KKFoO8CmAedqyO1.WocLas7mfiVgvYkyrb5W9cKhab6VVYgsgB5d2z6tR7ruoGY7RK8_paex
 YdApn4wY8y7EKFoJ7jamRBrMHerAngilqXhCGEAwJZuTmSaqXRB6mtFmJ0ocjE3mpkpqnBSkBbeY
 eFmG3ZtbpfE4XWgMzxAj8n8YjjAKNMiq1elIFESJTXVcbmy3Y9Nrce68pz5QwoU0EZo2IdZ47fEl
 bKGYQZBgyjvsbaeHDq29Avj.nf4z9n7U1ZAoC4A1mUt9QLuMMUGsWJEdIYd_bd7hBAZ9.Wep4hnP
 wtvxjexG8AdJGnVRj9HyWnOJnFBg2d_Mf6k9nWGAGcj9KESBdR5lXcQfVvBz8xvUiIOoew4iX3Yp
 sex.VrFfQvdsqGhkli3VKKovAU46LZCe3m2Z2MtBIubYwjy95i2hbr3QKAPYTP73tmqcT2TPt3D3
 kV18cnpNcOGr4FNuoFwItn.y8SQSP5HiUGwH_NgbEXHMCx5tzgcbspmQHrzSIJJ8obqzS6tVbh2l
 rKya8tIp4VWxkfmEA7NQC0ljOMQWaTdf6XogXdC22vPhTEdkmGn.SdDdeQyRAILHZy_zWaoPxmT.
 9SlYyqyaA62wB7.cDmfXraHfzZG.9Y8yZIwypIVLNoy6n.33TdbwnT0wVp9Sqiubu.teeekcOP9c
 DdQTRr0TuFgPsucqSo86S.CGN2tSpmkkMJ4hIYqjBIAXUoJuHzH_2rVOx4PGm4IDZB5xAz1W.rli
 rSD6jQY5e_CNr3mY9jO4CA5qka6yINAcciDlzKde9GS9vPiNNhTvfXKqcmUJuy95dop45mOOo1MO
 QpdUQfsrbx3b9limJqtj5kM.X.T4VxcKcQgrxd3MLq_vlA7IcNmL5sdh9cCZniJAPXnVrfs0LiTB
 6UttCgJIIblLSlDqmmCpeZniwO3AJZmQyGw0l_6m9JjqXW2K9MsvH18WuiC8OdddSz5oH7WS8FJ1
 mri8NLriDIFm7fhwv5P2y6MdTh8EmO3ldhiIEdNgKR0AAQiEQt9zQpiU-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 4 Aug 2019 15:26:05 +0000
Received: by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID aa14dd19feea4a1c6d638004d1c3facb; 
 Sun, 04 Aug 2019 15:26:04 +0000 (UTC)
Date: Sun, 4 Aug 2019 23:25:48 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
 <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:
> Shinde and Gao
>  Does the variable name of debug level use another name ? like d ?
>  The i is usual a temporary increase or decrease self variable.

I think we can use a common varible name in order to avoid
too many temporary variables, maybe `i' is not the best
naming, but `i' also stands for "a integer".

Maybe we can give a better naming? can you name it and
submit another patch? I personally don't like define too
many used-once variables... How do you think?

Thanks,
Gao Xiang

> 
> ?? 2019/8/4 19:39, Pratik Shinde ????:
> > Hi Gao,
> > 
> > I Agree with your suggestion. Thanks for the additional code change. I
> > think thats pretty much our final patch. :)
> > 
> > -Pratik
> > 
> > On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:
> > 
> > > Hi Pratik,
> > > 
> > > On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> > > > Hi Gao,
> > > > 
> > > > I used fprintf here because we are printing this error message in case of
> > > > invalid 'cfg.c_dbg_lvl'. Hence I thought
> > > > we cannot rely on erofs_err().
> > > > e.g
> > > > $ mkfs.erofs -d -1 <erofs image> <directory>
> > > > In this case debug level is '-1' which is invalid.If we try to print the
> > > > error message using erofs_err() with c_dbg_lvl = -1,
> > > > it will not print anything.
> > > 
> > > Yes, so c_dbg_lvl should be kept in default level (0) before
> > > checking its vaildity I think.
> > > 
> > > > While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
> > > > erofs_err() will be able to log the error message.
> > > 
> > > Since there could be some messages already printed with erofs_xxx before
> > > mkfs_parse_options_cfg(), I think we can use default level (0) before
> > > checking its vaildity and switch to the given level after it, as below:
> > > 
> > >                  case 'd':
> > > -                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > +                       i = atoi(optarg);
> > > +                       if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
> > > +                               erofs_err("invalid debug level %d", i);
> > > +                               return -EINVAL;
> > > +                       }
> > > +                       cfg.c_dbg_lvl = i;
> > > 
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
> > > 
> > > Do you agree? :)
> > > 
> > > Thanks,
> > > Gao Xiang
> > > 
> > > > 
> > > > --Pratik.
> > > > 
> > > > 
> > > > On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:
> > > > 
> > > > > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> > > > > > handling the case of incorrect debug level.
> > > > > > Added an enumerated type for supported debug levels.
> > > > > > Using 'atoi' in place of 'parse_num_from_str'.
> > > > > > 
> > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > > ---
> > > > > >   include/erofs/print.h | 18 +++++++++++++-----
> > > > > >   mkfs/main.c           | 19 ++++++++-----------
> > > > > >   2 files changed, 21 insertions(+), 16 deletions(-)
> > > > > > 
> > > > > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > > > > index bc0b8d4..296cbbf 100644
> > > > > > --- a/include/erofs/print.h
> > > > > > +++ b/include/erofs/print.h
> > > > > > @@ -12,6 +12,15 @@
> > > > > >   #include "config.h"
> > > > > >   #include <stdio.h>
> > > > > > 
> > > > > > +enum {
> > > > > > +     EROFS_MSG_MIN = 0,
> > > > > > +     EROFS_ERR     = 0,
> > > > > > +     EROFS_WARN    = 2,
> > > > > > +     EROFS_INFO    = 3,
> > > > > > +     EROFS_DBG     = 7,
> > > > > > +     EROFS_MSG_MAX = 9
> > > > > > +};
> > > > > > +
> > > > > >   #define FUNC_LINE_FMT "%s() Line[%d] "
> > > > > > 
> > > > > >   #ifndef pr_fmt
> > > > > > @@ -19,7 +28,7 @@
> > > > > >   #endif
> > > > > > 
> > > > > >   #define erofs_dbg(fmt, ...) do {                             \
> > > > > > -     if (cfg.c_dbg_lvl >= 7) {                               \
> > > > > > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
> > > > > >                fprintf(stdout,                                 \
> > > > > >                        pr_fmt(fmt),                            \
> > > > > >                        __func__,                               \
> > > > > > @@ -29,7 +38,7 @@
> > > > > >   } while (0)
> > > > > > 
> > > > > >   #define erofs_info(fmt, ...) do {                            \
> > > > > > -     if (cfg.c_dbg_lvl >= 3) {                               \
> > > > > > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
> > > > > >                fprintf(stdout,                                 \
> > > > > >                        pr_fmt(fmt),                            \
> > > > > >                        __func__,                               \
> > > > > > @@ -40,7 +49,7 @@
> > > > > >   } while (0)
> > > > > > 
> > > > > >   #define erofs_warn(fmt, ...) do {                            \
> > > > > > -     if (cfg.c_dbg_lvl >= 2) {                               \
> > > > > > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
> > > > > >                fprintf(stdout,                                 \
> > > > > >                        pr_fmt(fmt),                            \
> > > > > >                        __func__,                               \
> > > > > > @@ -51,7 +60,7 @@
> > > > > >   } while (0)
> > > > > > 
> > > > > >   #define erofs_err(fmt, ...) do {                             \
> > > > > > -     if (cfg.c_dbg_lvl >= 0) {                               \
> > > > > > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
> > > > > >                fprintf(stderr,                                 \
> > > > > >                        "Err: " pr_fmt(fmt),                    \
> > > > > >                        __func__,                               \
> > > > > > @@ -64,4 +73,3 @@
> > > > > > 
> > > > > > 
> > > > > >   #endif
> > > > > > -
> > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > index fdb65fd..d915d00 100644
> > > > > > --- a/mkfs/main.c
> > > > > > +++ b/mkfs/main.c
> > > > > > @@ -30,16 +30,6 @@ static void usage(void)
> > > > > >        fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > >   }
> > > > > > 
> > > > > > -u64 parse_num_from_str(const char *str)
> > > > > > -{
> > > > > > -     u64 num      = 0;
> > > > > > -     char *endptr = NULL;
> > > > > > -
> > > > > > -     num = strtoull(str, &endptr, 10);
> > > > > > -     BUG_ON(num == ULLONG_MAX);
> > > > > > -     return num;
> > > > > > -}
> > > > > > -
> > > > > >   static int parse_extended_opts(const char *opts)
> > > > > >   {
> > > > > >   #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
> > > > > *argv[])
> > > > > >                        break;
> > > > > > 
> > > > > >                case 'd':
> > > > > > -                     cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > > > > +                     cfg.c_dbg_lvl = atoi(optarg);
> > > > > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > > > > +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> > > > > > +                             fprintf(stderr,
> > > > > > +                                     "invalid debug level %d\n",
> > > > > > +                                     cfg.c_dbg_lvl);
> > > > > 
> > > > > How about using erofs_err as my previous patch attached?
> > > > > I wonder if there are some specfic reasons to directly use fprintf
> > > instead?
> > > > > 
> > > > > I will apply it with this minor fixup (no need to resend again), if you
> > > > > have
> > > > > other considerations, reply me in this thread, thanks. :)
> > > > > 
> > > > > Thanks,
> > > > > Gao Xiang
> > > > > 
> > > > > > +                             return -EINVAL;
> > > > > > +                     }
> > > > > >                        break;
> > > > > > 
> > > > > >                case 'E':
> > > > > > --
> > > > > > 2.9.3
> > > > > > 
> > > > > 
> > > 
> > 
