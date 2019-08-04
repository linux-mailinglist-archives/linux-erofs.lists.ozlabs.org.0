Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B180B8A
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 17:51:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461lkm4D3wzDqc3
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2019 01:51:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1564933904;
	bh=OJQmxDgdVkcpcDEpfc3RFjjX9bc4K4SifXV+TSFZ9Y0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IhoX73lk+2eWUw14d2WNJvY9sKeYRU3w8q7KvvxyVOI/i7UBFaJ6qCd4q1kguPrNp
	 mrSQyUGfzLl1rUU5IZl2iqDOLvyaCHtgyQyxUx2kkrJq3ctR+RQQXUSivUSlPnrBRL
	 j/K1qyazxblQzjKYpTpaAP/M+6DixJ/WOASGpjVODQuGkYbnFdCFgCnQYEOGVQSQkC
	 iVvoBRO5dNzHyiZdhucgFAQrmOCFjHbqdYPzWOqOOTG3RDIPCTpShA6JIY0XxmJF8q
	 ScjjpXVdmxxoZieNbDRGuBHQ7hpg3vafubK8N+sjkURja7J0mt7HgkVSKhNpRnNrPh
	 325KWh7js76eQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.82; helo=sonic305-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="eP2X5ZCW"; 
 dkim-atps=neutral
Received: from sonic305-20.consmr.mail.ir2.yahoo.com
 (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461lkc4th1zDqWq
 for <linux-erofs@lists.ozlabs.org>; Mon,  5 Aug 2019 01:51:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1564933885; bh=Lis9NTxF0WrGUtrF/K7fmrzx/hub2b20+MFvsSpQtDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=eP2X5ZCWpu/FneDyQDVRjZ+SWzWDdOgz33e9/ui62FD4vV8ajPeUUao5u1CLZ+vOo4P1y+HalovUk0HJZGu23w/eYZMAK/5wldiiJ7dX3LwFGLHFgW4Y1SyfD9orG21lbPYNJX3PJdJUk0WbTchijbMUFxYs241xJFPHxN0dluB5c1F42kaA01gYhIBwFjpcNH8dXUJhrMW3AvCNADrl5h3GTZ2bmGySIVl98EQvIVZdGrIm7ois4CXXRUHfRUkG5gtP8EU28s6k/gtk08I0fGZvb/zIJ3OhtAwe0HnqotPOPqNALjDDxQPgLan8gnD7arFtYwvKtF50zfy3d/+qMQ==
X-YMail-OSG: HEOCY_MVM1l1ciLxTu2.1Wt2FVlKzpPnoGT5PJhbK8DesLfqenePldiXPOOqdVq
 V0RXKqB.99sugRH6L60EMc.h9048zUno3AmFmuMRlQmnH3gK61jeAE4JNGqPPDzZM_TxwnpT919x
 YiCEeRxbV_OQ_m2jERNo5nFm31.nYDiaVcU3umq8Wxlg3l2QRJB3x.4h.04eGRw602pQYuFX_85R
 JsBJdyOYsDHLgNES_wV.GYfOZ6qNugvyynS3PK.SNjDwUlQkYTfQYsutnTRz3MjkZlXlGpx_bBHY
 xCDh0QAwTDhM0Edy1ndJdk4rHa6ctkJyhfP_q9HA_IbzKtEH.mYEnxmt9p7f6y9JutmYQQz6xGU7
 25e8EpA.mSMigH4t0lKobO3692jHMpow7BzGZbaqqrbUAVbxkTmz61U9XT2t68ExxlbteYEh1x7I
 zrc2_5r9swl3vhNYAzWkIwDkhYTPz1AO5DC0KDwwotgcHyzWvZDL0ylxWvNCOypnzZtAISTvMzbe
 REssf_19EtQT0I3SuBPlTHtYmnoE1Mr_1CXGKF1GUlFZW6h5mDGsprs8moqNhKZseEEkBaPvdkwp
 yBU.G8_1sbYpE_IRF.4xGQ6066MfYGBSCb.e7Q5P207I6BDJQbefKnEVeXMfbJIgwGHruUot.M6a
 x3f39yMFzumc2miS9twu9z0Hfmu8TmZAl4ZRWNuxptazqxaY30YAXxccgxSn902dsn3ZvWxUCEEN
 UIrFBGqPP29hntHWeZcK9mFVYxUpZ5Te5UTkgBWvy4R4ao.RjQKett6fIWQBvuMD3mAhA7WNAnaz
 c.p41IAlpB38P4_9FaNaF7tWado6Jq8240ffAAaq6etvHa9zHhjXLbv2a.g8BjTEfTC_Lvp6H1_h
 Pzql_e61ZPKO6oNfBaygaQXvB.EgArgP9pH.4OL65QAfCsyST5gAf2P2HZHaNY4KOTffz3r3RKpB
 qDmdWjYWC6871d.t6aHlB3DdjAfFwuazf5dZlcdyDB9o1WOmUXYiLGehTMgG3L8KWS5t3oQioViG
 Px4OBhMBvf4ftZIvCaIwq.RDXYW4NUMQ2NWnDHafn7683we7K5PhxLbxwctIEoKix6e8HMEscBS2
 rf.a7FbRWpiWOpUPW3s_Ks6R5ydV.BKGsUkhcJ1XDG7pAYnBn_YPbw4r0qxSDEnD6xFTzDmSt5j3
 z1h5ErT9gOJsD0nkYtEusb3hPig_qJRNVp1kWpHvW5h9_07q_rYob7JSatRqfx0s_gaZUkY3oucj
 t39giWyuNpMl51hD3_OJAH9_.4YyonRheF8rDYx8tdbXm7aER
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 4 Aug 2019 15:51:25 +0000
Received: by smtp425.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3b160660055229081087d9d56a2fbd34; 
 Sun, 04 Aug 2019 15:51:23 +0000 (UTC)
Date: Sun, 4 Aug 2019 23:51:15 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190804154951.GA7446@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
 <20190804113130.GA3993@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSs3jPuQGqHsravmR9ta0qyQUsP9pah7XieQzjj8Rz5uw@mail.gmail.com>
 <c07418b2-f8d7-8e9a-487b-99ffb1d18ad5@gmail.com>
 <20190804152547.GB6233@hsiangkao-HP-ZHAN-66-Pro-G1>
 <08f63a50-105c-d97a-8db1-db486e9616a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08f63a50-105c-d97a-8db1-db486e9616a2@gmail.com>
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

On Sun, Aug 04, 2019 at 11:41:47PM +0800, Li Guifu wrote:
> GAO
> 	it's a good suggest, you're right

I know that you don't have outgoing email permission when you are at work.
I think you need to request this permission from your boss again.

And could you take some spare time off work and review erofs-utils patches?
That is of great help to erofs community. :)

Thanks,
Gao Xiang

> 
> ?? 2019/8/4 23:25, Gao Xiang ????:
> > Hi Guifu,
> > 
> > On Sun, Aug 04, 2019 at 08:57:58PM +0800, Li Guifu wrote:
> > > Shinde and Gao
> > >   Does the variable name of debug level use another name ? like d ?
> > >   The i is usual a temporary increase or decrease self variable.
> > 
> > I think we can use a common varible name in order to avoid
> > too many temporary variables, maybe `i' is not the best
> > naming, but `i' also stands for "a integer".
> > 
> > Maybe we can give a better naming? can you name it and
> > submit another patch? I personally don't like define too
> > many used-once variables... How do you think?
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > 
> > > ?? 2019/8/4 19:39, Pratik Shinde ????:
> > > > Hi Gao,
> > > > 
> > > > I Agree with your suggestion. Thanks for the additional code change. I
> > > > think thats pretty much our final patch. :)
> > > > 
> > > > -Pratik
> > > > 
> > > > On Sun, 4 Aug, 2019, 5:01 PM Gao Xiang, <hsiangkao@gmx.com> wrote:
> > > > 
> > > > > Hi Pratik,
> > > > > 
> > > > > On Sun, Aug 04, 2019 at 04:03:49PM +0530, Pratik Shinde wrote:
> > > > > > Hi Gao,
> > > > > > 
> > > > > > I used fprintf here because we are printing this error message in case of
> > > > > > invalid 'cfg.c_dbg_lvl'. Hence I thought
> > > > > > we cannot rely on erofs_err().
> > > > > > e.g
> > > > > > $ mkfs.erofs -d -1 <erofs image> <directory>
> > > > > > In this case debug level is '-1' which is invalid.If we try to print the
> > > > > > error message using erofs_err() with c_dbg_lvl = -1,
> > > > > > it will not print anything.
> > > > > 
> > > > > Yes, so c_dbg_lvl should be kept in default level (0) before
> > > > > checking its vaildity I think.
> > > > > 
> > > > > > While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
> > > > > > erofs_err() will be able to log the error message.
> > > > > 
> > > > > Since there could be some messages already printed with erofs_xxx before
> > > > > mkfs_parse_options_cfg(), I think we can use default level (0) before
> > > > > checking its vaildity and switch to the given level after it, as below:
> > > > > 
> > > > >                   case 'd':
> > > > > -                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > > > +                       i = atoi(optarg);
> > > > > +                       if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
> > > > > +                               erofs_err("invalid debug level %d", i);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +                       cfg.c_dbg_lvl = i;
> > > > > 
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=dev&id=26097242976cce68e21d8b569dfda63fb68f356c
> > > > > 
> > > > > Do you agree? :)
> > > > > 
> > > > > Thanks,
> > > > > Gao Xiang
> > > > > 
> > > > > > 
> > > > > > --Pratik.
> > > > > > 
> > > > > > 
> > > > > > On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:
> > > > > > 
> > > > > > > On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> > > > > > > > handling the case of incorrect debug level.
> > > > > > > > Added an enumerated type for supported debug levels.
> > > > > > > > Using 'atoi' in place of 'parse_num_from_str'.
> > > > > > > > 
> > > > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > > > > > ---
> > > > > > > >    include/erofs/print.h | 18 +++++++++++++-----
> > > > > > > >    mkfs/main.c           | 19 ++++++++-----------
> > > > > > > >    2 files changed, 21 insertions(+), 16 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > > > > > > > index bc0b8d4..296cbbf 100644
> > > > > > > > --- a/include/erofs/print.h
> > > > > > > > +++ b/include/erofs/print.h
> > > > > > > > @@ -12,6 +12,15 @@
> > > > > > > >    #include "config.h"
> > > > > > > >    #include <stdio.h>
> > > > > > > > 
> > > > > > > > +enum {
> > > > > > > > +     EROFS_MSG_MIN = 0,
> > > > > > > > +     EROFS_ERR     = 0,
> > > > > > > > +     EROFS_WARN    = 2,
> > > > > > > > +     EROFS_INFO    = 3,
> > > > > > > > +     EROFS_DBG     = 7,
> > > > > > > > +     EROFS_MSG_MAX = 9
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >    #define FUNC_LINE_FMT "%s() Line[%d] "
> > > > > > > > 
> > > > > > > >    #ifndef pr_fmt
> > > > > > > > @@ -19,7 +28,7 @@
> > > > > > > >    #endif
> > > > > > > > 
> > > > > > > >    #define erofs_dbg(fmt, ...) do {                             \
> > > > > > > > -     if (cfg.c_dbg_lvl >= 7) {                               \
> > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
> > > > > > > >                 fprintf(stdout,                                 \
> > > > > > > >                         pr_fmt(fmt),                            \
> > > > > > > >                         __func__,                               \
> > > > > > > > @@ -29,7 +38,7 @@
> > > > > > > >    } while (0)
> > > > > > > > 
> > > > > > > >    #define erofs_info(fmt, ...) do {                            \
> > > > > > > > -     if (cfg.c_dbg_lvl >= 3) {                               \
> > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
> > > > > > > >                 fprintf(stdout,                                 \
> > > > > > > >                         pr_fmt(fmt),                            \
> > > > > > > >                         __func__,                               \
> > > > > > > > @@ -40,7 +49,7 @@
> > > > > > > >    } while (0)
> > > > > > > > 
> > > > > > > >    #define erofs_warn(fmt, ...) do {                            \
> > > > > > > > -     if (cfg.c_dbg_lvl >= 2) {                               \
> > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
> > > > > > > >                 fprintf(stdout,                                 \
> > > > > > > >                         pr_fmt(fmt),                            \
> > > > > > > >                         __func__,                               \
> > > > > > > > @@ -51,7 +60,7 @@
> > > > > > > >    } while (0)
> > > > > > > > 
> > > > > > > >    #define erofs_err(fmt, ...) do {                             \
> > > > > > > > -     if (cfg.c_dbg_lvl >= 0) {                               \
> > > > > > > > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
> > > > > > > >                 fprintf(stderr,                                 \
> > > > > > > >                         "Err: " pr_fmt(fmt),                    \
> > > > > > > >                         __func__,                               \
> > > > > > > > @@ -64,4 +73,3 @@
> > > > > > > > 
> > > > > > > > 
> > > > > > > >    #endif
> > > > > > > > -
> > > > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > > > index fdb65fd..d915d00 100644
> > > > > > > > --- a/mkfs/main.c
> > > > > > > > +++ b/mkfs/main.c
> > > > > > > > @@ -30,16 +30,6 @@ static void usage(void)
> > > > > > > >         fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > > > >    }
> > > > > > > > 
> > > > > > > > -u64 parse_num_from_str(const char *str)
> > > > > > > > -{
> > > > > > > > -     u64 num      = 0;
> > > > > > > > -     char *endptr = NULL;
> > > > > > > > -
> > > > > > > > -     num = strtoull(str, &endptr, 10);
> > > > > > > > -     BUG_ON(num == ULLONG_MAX);
> > > > > > > > -     return num;
> > > > > > > > -}
> > > > > > > > -
> > > > > > > >    static int parse_extended_opts(const char *opts)
> > > > > > > >    {
> > > > > > > >    #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > > > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
> > > > > > > *argv[])
> > > > > > > >                         break;
> > > > > > > > 
> > > > > > > >                 case 'd':
> > > > > > > > -                     cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > > > > > > +                     cfg.c_dbg_lvl = atoi(optarg);
> > > > > > > > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > > > > > > > +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> > > > > > > > +                             fprintf(stderr,
> > > > > > > > +                                     "invalid debug level %d\n",
> > > > > > > > +                                     cfg.c_dbg_lvl);
> > > > > > > 
> > > > > > > How about using erofs_err as my previous patch attached?
> > > > > > > I wonder if there are some specfic reasons to directly use fprintf
> > > > > instead?
> > > > > > > 
> > > > > > > I will apply it with this minor fixup (no need to resend again), if you
> > > > > > > have
> > > > > > > other considerations, reply me in this thread, thanks. :)
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Gao Xiang
> > > > > > > 
> > > > > > > > +                             return -EINVAL;
> > > > > > > > +                     }
> > > > > > > >                         break;
> > > > > > > > 
> > > > > > > >                 case 'E':
> > > > > > > > --
> > > > > > > > 2.9.3
> > > > > > > > 
> > > > > > > 
> > > > > 
> > > > 
