Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5E7EC5B
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 07:57:49 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460GfK5F18zDqtl
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 15:57:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460Gf92ZXrzDqsp
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 15:57:33 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A67886568AB8AA797730
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 13:57:27 +0800 (CST)
Received: from 138 (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 13:57:17 +0800
Date: Fri, 2 Aug 2019 14:14:30 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: error handling for incorrect dbg lvl &
 compression algorithm
Message-ID: <20190802061430.GA11313@138>
References: <20190801191809.13675-1-pratikshinde320@gmail.com>
 <20190802014323.GA3911@138>
 <CAGu0czT-HLnhAKQV6OhtgNu83fGDdHKu7+NZK15m-K7md3zVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czT-HLnhAKQV6OhtgNu83fGDdHKu7+NZK15m-K7md3zVUQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
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

[maybe better to add linux-erofs to record all the discusssions...]

On Fri, Aug 02, 2019 at 10:53:12AM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> I think you misunderstood, the code change is for 'debug level' and not
> 'compressor level'. whose valid range is 0-9.
> otherwise erofs_err() will not print anything.

Sorry... You are right and I think it is useful, but could you use another way
rather than hard-coded "0-9" directly? maybe we need to update
include/erofs/print.h as well to avoid hard-coded "such cfg.c_dbg_lvl >= 7"...

maybe it could be
enum {
	EROFS_ERR = 0,
	....
	EROFS_DEBUG = 9,
};

> Regarding the check for compressor algorithm name: the current code has no
> problem, I just thought it will be good
> valid it in mkfs_parse_options_cfg() itself. In the current code, its
> detected after we allocate entire super-block buffer.
> thats the reason why I mentioned  'early check'.

Hmmm... I think there are little difference, if it really needs,
how about adding a callback in compressor call .show_name()
to avoid hard-code as well...

(IMO, I think there is little difference checking in
z_erofs_compress_init() later, rare prople care about buffer init :)...)

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Fri, Aug 2, 2019 at 7:13 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > Hi Pratik,
> >
> > On Fri, Aug 02, 2019 at 12:48:09AM +0530, Pratik Shinde wrote:
> > > handling the case of incorrect debug level.
> > > also, an early check for valid compression algorithm.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  mkfs/main.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index fdb65fd..4231d13 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -105,10 +105,22 @@ static int mkfs_parse_options_cfg(int argc, char
> > *argv[])
> > >                               }
> > >                       }
> > >                       cfg.c_compr_alg_master = strndup(optarg, i);
> > > +                     if (strcmp(cfg.c_compr_alg_master, "lz4")
> > > +                         && strcmp(cfg.c_compr_alg_master, "lz4hc")) {
> > > +                             erofs_err("invalid compressor algorithm
> > %s",
> > > +                                       cfg.c_comprz_erofs_compress_init_alg_master);
> > > +                             return -EINVAL;
> > > +                     }
> >
> > It should be do in the compressors, and we have:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compressor.c?h=dev#n74
> >
> > I'd like to know if some problems are out with the above code...
> >
> > >                       break;
> > >
> > >               case 'd':
> > >                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > > +                     if (cfg.c_dbg_lvl < 0 || cfg.c_dbg_lvl > 9) {
> >
> > I think we cannot directly do like the above since
> > not all compression algorithm levels are 0~9 (and the default level could
> > be -1).
> > take a look at struct erofs_compressor and it has
> >         int default_level;
> >         int best_level;
> > I think maybe we have to define "worst_level" as well, and
> > it could be better do the above check in "int z_erofs_compress_init(void)"
> >
> > Thanks,
> > Gao Xiang
> >
> > > +                             fprintf(stderr,
> > > +                                     "invalid debug level %d\n",
> > > +                                     cfg.c_dbg_lvl);
> > > +                             return -EINVAL;
> > > +                     }
> > >                       break;
> > >
> > >               case 'E':
> > > --
> > > 2.9.3
> > >
> >
