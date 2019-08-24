Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D19BCB9
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 11:22:56 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Ft8s1CC6zDrh6
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 19:22:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1wMMM+C"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Ft8m3blDzDrgc
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 19:22:47 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id g8so17619919edm.6
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5wC3mVx3V/O4MnogEzM7KuLY9iWQkPVn6m4VRP5+/ds=;
 b=N1wMMM+CnIU1skhgoBIycY4qEhXro/5ysrXevOrpZJgUOCgSaRT0RVNa/jkq5yqWrf
 Vqz9nczTEPg/ngiRzH/J2koJidFfxIBEHFkOSCrF3lYde4rsAGQ+rQpBU9XKAVpbrUmS
 c3IpSNLEU90fS7xW6UfTO9pQj/ubpm42hFwStXuUEgc9a1GDGbSXuBY/NxdIiYZihyMK
 ShEJE/w4qe8O4bd+1IFV25eIyJtN2ZrdM5zfAFefhxleO/sRy0ggLs+ec9TwsgnwwuzP
 LQKPGG/FjTdnNvY8/RoIuW97JkzjNrpYlDsJgd72bEswVH/nsbbnjBCpuwwUnalzHIu7
 7GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5wC3mVx3V/O4MnogEzM7KuLY9iWQkPVn6m4VRP5+/ds=;
 b=BeHx06jvYpGOyeHokqxf7ZuAerIz2V08v0WcZ01fHybl9Vfvqj67rL8rOlwk2760+R
 K9zp9w7DdEl7FGBwMbWaDwyCZTmrGgYsXgTJFZjdyU1msJo1buWWwl3Rc+7cP8bC/AqP
 RHaKaLWfy0F7Lw0hiFD1o6KWf++m4qXCyA7UznwPmyxhgMlfYyEsr2voWBu886wws6U+
 Ncp+jymZfAa8tqc5t5YTfcBD7kvoVPacOKohwNFNL2gf/Qgj/5eFBens4vh7auM4SvTV
 piSYqOfNl6FAw1OBTlHISEIgw0huIA4uqVaiu9e3773SKnG5FroUzp2/g0408KAujVZP
 qAug==
X-Gm-Message-State: APjAAAVGChsZfhXiCiJqCImG0JjYQZ5SqEDT3vXWQIZAXYZN/l8wxKji
 QvrqWV8n2kHCaDG4Uzp6K3sztqm8eOOzxo88Bvo=
X-Google-Smtp-Source: APXvYqzkgyb5+losprUhbP2PGHho1C/z3rCSM2TS8ExGsTWVxDUiSRjNOpbnX51KfCLXjbrtUVNEDwqi+vwEqUcE/+k=
X-Received: by 2002:a17:906:4813:: with SMTP id
 w19mr7923837ejq.89.1566638563394; 
 Sat, 24 Aug 2019 02:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190824074158.16254-1-pratikshinde320@gmail.com>
 <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sat, 24 Aug 2019 14:52:31 +0530
Message-ID: <CAGu0czQ2kP-z-T-P67CeBxdCnLBVmKtW6h8eOnrEY+FEQTiwSQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
To: Gao Xiang <hsiangkao@gmx.com>
Content-Type: multipart/alternative; boundary="00000000000010067a0590d9775d"
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

--00000000000010067a0590d9775d
Content-Type: text/plain; charset="UTF-8"

Hi Gao,
Yes I will make the suboption naming similar to that of mk2fs.

The reason I changed the position of 'checksum' field :

Since we are calculating the checksum of erofs_super_block structure and
storing it in the same structure; we cannot include
this field for actual crc calculations. Keeping it at the end makes it easy
for me to calculate length of the data of which
checksum needs to be calculated. I saw similar logic in other filesystems
like ext4.

We can write our own crc32() function. :) There is no problem. I thought
zlib already provides one & we can use it.
anyways , I will write.

--Pratik.

On Sat, Aug 24, 2019 at 2:16 PM Gao Xiang <hsiangkao@gmx.com> wrote:

> Hi Pratik,
>
> On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:
> > Adding code for superblock checksum calculation.
> >
> > This patch adds following things:
> > 1)Handle suboptions('-o') to mkfs utility.
>
> Thanks for your patch. :)
>
> Can we use "-O feature" instead in order to keep in line with mke2fs?
>
> > 2)Add superblock checksum calculation(-o sb_cksum) as suboption.
>
> ditto. and I think we can enable sbcrc by default since it is a compat
> feature,
> and add "-O nosbcrc" to disable it.
>
> > 3)Calculate superblock checksum if feature is enabled.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>
> And could you please also read my following comments and fix them.
> and I'd like to accept your erofs-utils modification in advance. :)
>
>
> But now you can see we are moving EROFS out of staging now as
> the "real" part of Linux, this is the fundamental stuff of other
> new features if we want to develop more actively... So we can wait
> for the final result and add this new feature to kernel then...
>
> > ---
> >  include/erofs/config.h |  1 +
> >  include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
> >  mkfs/main.c            | 53
> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 76 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > index 05fe6b2..40cd466 100644
> > --- a/include/erofs/config.h
> > +++ b/include/erofs/config.h
> > @@ -22,6 +22,7 @@ struct erofs_configure {
> >       char *c_src_path;
> >       char *c_compr_alg_master;
> >       int c_compr_level_master;
> > +     int c_feature_flags;
>
> we can add this to sbi like requirements...
>
> >  };
> >
> >  extern struct erofs_configure cfg;
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 601b477..c9ef057 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -20,25 +20,31 @@
> >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> >  #define EROFS_ALL_REQUIREMENTS
>  EROFS_REQUIREMENT_LZ4_0PADDING
> >
> > +/*
> > + * feature definations.
> > + */
> > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > +
> > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > +     ( le32_to_cpu((super)->features) & (mask) )
> > +
> >  struct erofs_super_block {
> >  /*  0 */__le32 magic;           /* in the little endian */
> > -/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > -/*  8 */__le32 features;        /* (aka. feature_compat) */
> > -/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only
> */
> > -/* 13 */__u8 reserved;
> > -
> > -/* 14 */__le16 root_nid;
> > -/* 16 */__le64 inos;            /* total valid ino # (== f_files -
> f_favail) */
> > -
> > -/* 24 */__le64 build_time;      /* inode v1 time derivation */
> > -/* 32 */__le32 build_time_nsec;
> > -/* 36 */__le32 blocks;          /* used for statfs */
> > -/* 40 */__le32 meta_blkaddr;
> > -/* 44 */__le32 xattr_blkaddr;
> > -/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
> > -/* 64 */__u8 volume_name[16];   /* volume name */
> > -/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> > -
> > +/*  4 */__le32 features;        /* (aka. feature_compat) */
> > +/*  8 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only
> */
> > +/*  9 */__u8 reserved;
> > +
> > +/* 10 */__le16 root_nid;
> > +/* 12 */__le64 inos;            /* total valid ino # (== f_files -
> f_favail) */
> > +/* 20 */__le64 build_time;      /* inode v1 time derivation */
> > +/* 28 */__le32 build_time_nsec;
> > +/* 32 */__le32 blocks;          /* used for statfs */
> > +/* 36 */__le32 meta_blkaddr;
> > +/* 40 */__le32 xattr_blkaddr;
> > +/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
> > +/* 60 */__u8 volume_name[16];   /* volume name */
> > +/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
> > +/* 80 */__le32 checksum;        /* crc32c(super_block) */
> >  /* 84 */__u8 reserved2[44];
>
> Why modifying the above?
>
> >  } __packed;                     /* 128 bytes */
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index f127fe1..26e14a3 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -13,12 +13,14 @@
> >  #include <limits.h>
> >  #include <libgen.h>
> >  #include <sys/stat.h>
> > +#include <zlib.h>
>
> I have no idea that we should introduce "zlib" just for crc32c currently...
> Maybe we can add some independent crc32 function..
>
> Thanks,
> Gao Xiang
>
> >  #include "erofs/config.h"
> >  #include "erofs/print.h"
> >  #include "erofs/cache.h"
> >  #include "erofs/inode.h"
> >  #include "erofs/io.h"
> >  #include "erofs/compress.h"
> > +#include "erofs/defs.h"
> >
> >  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
> erofs_super_block))
> >
> > @@ -31,6 +33,28 @@ static void usage(void)
> >       fprintf(stderr, " -EX[,...] X=extended options\n");
> >  }
> >
> > +char *feature_opts[] = {
> > +     "sb_cksum", NULL
> > +};
> > +#define O_SB_CKSUM   0
> > +
> > +static int parse_feature_subopts(char *opts)
> > +{
> > +     char *arg;
> > +
> > +     while (*opts != '\0') {
> > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > +             case O_SB_CKSUM:
> > +                     cfg.c_feature_flags |= EROFS_FEATURE_SB_CHKSUM;
> > +                     break;
> > +             default:
> > +                     erofs_err("incorrect suboption");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int parse_extended_opts(const char *opts)
> >  {
> >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >  {
> >       int opt, i;
> >
> > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> >               switch (opt) {
> >               case 'z':
> >                       if (!optarg) {
> > @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >                               return opt;
> >                       break;
> >
> > +             case 'o':
> > +                     opt = parse_feature_subopts(optarg);
> > +                     if (opt)
> > +                             return opt;
> > +                     break;
> > +
> >               default: /* '?' */
> >                       return -EINVAL;
> >               }
> > @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >       return 0;
> >  }
> >
> > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > +{
> > +     int offset;
> > +     u32 crc;
> > +
> > +     offset = offsetof(struct erofs_super_block, checksum);
> > +     if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
> > +             erofs_err("Invalid offset of checksum field: %d", offset);
> > +             return -1;
> > +     }
> > +     crc = crc32(~0, (const unsigned char *)sb,(size_t)offset);
> > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > +     return 0;
> > +}
> > +
> >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >                                 erofs_nid_t root_nid)
> >  {
> > @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >               .meta_blkaddr  = sbi.meta_blkaddr,
> >               .xattr_blkaddr = 0,
> >               .requirements = cpu_to_le32(sbi.requirements),
> > +             .features = cpu_to_le32(cfg.c_feature_flags),
> >       };
> >       const unsigned int sb_blksize =
> >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> >       sb.root_nid     = cpu_to_le16(root_nid);
> >
> > +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > +             u32 crc = erofs_superblock_checksum(&sb);
> > +             sb.checksum = cpu_to_le32(crc);
> > +     }
> > +
> >       buf = calloc(sb_blksize, 1);
> >       if (!buf) {
> >               erofs_err("Failed to allocate memory for sb: %s",
> > --
> > 2.9.3
> >
>

--00000000000010067a0590d9775d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div>Yes I will make the suboption namin=
g similar to that of mk2fs.</div><div><br></div><div>The reason I changed t=
he position of &#39;checksum&#39; field :</div><div><br></div><div>Since we=
 are calculating the checksum of erofs_super_block structure and storing it=
 in the same structure; we cannot include <br></div><div>this field for act=
ual crc calculations. Keeping it at the end makes it easy for me to calcula=
te length of the data of which</div><div>checksum needs to be calculated. I=
 saw similar logic in other filesystems like ext4.</div><div><br></div><div=
>We can write our own crc32() function. :) There is no problem. I thought z=
lib already provides one &amp; we can use it.</div><div>anyways , I will wr=
ite.</div><div><br></div><div>--Pratik.<br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 24, 2019 at 2:=
16 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@gmx.com">hsiangkao@gmx.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Pratik,<br>
<br>
On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:<br>
&gt; Adding code for superblock checksum calculation.<br>
&gt;<br>
&gt; This patch adds following things:<br>
&gt; 1)Handle suboptions(&#39;-o&#39;) to mkfs utility.<br>
<br>
Thanks for your patch. :)<br>
<br>
Can we use &quot;-O feature&quot; instead in order to keep in line with mke=
2fs?<br>
<br>
&gt; 2)Add superblock checksum calculation(-o sb_cksum) as suboption.<br>
<br>
ditto. and I think we can enable sbcrc by default since it is a compat feat=
ure,<br>
and add &quot;-O nosbcrc&quot; to disable it.<br>
<br>
&gt; 3)Calculate superblock checksum if feature is enabled.<br>
&gt;<br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
<br>
And could you please also read my following comments and fix them.<br>
and I&#39;d like to accept your erofs-utils modification in advance. :)<br>
<br>
<br>
But now you can see we are moving EROFS out of staging now as<br>
the &quot;real&quot; part of Linux, this is the fundamental stuff of other<=
br>
new features if we want to develop more actively... So we can wait<br>
for the final result and add this new feature to kernel then...<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/config.h |=C2=A0 1 +<br>
&gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0| 40 +++++++++++++++++++++=
----------------<br>
&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 53 ++++++=
+++++++++++++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 3 files changed, 76 insertions(+), 18 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/erofs/config.h b/include/erofs/config.h<br>
&gt; index 05fe6b2..40cd466 100644<br>
&gt; --- a/include/erofs/config.h<br>
&gt; +++ b/include/erofs/config.h<br>
&gt; @@ -22,6 +22,7 @@ struct erofs_configure {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_src_path;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_compr_alg_master;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int c_compr_level_master;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int c_feature_flags;<br>
<br>
we can add this to sbi like requirements...<br>
<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 extern struct erofs_configure cfg;<br>
&gt; diff --git a/include/erofs_fs.h b/include/erofs_fs.h<br>
&gt; index 601b477..c9ef057 100644<br>
&gt; --- a/include/erofs_fs.h<br>
&gt; +++ b/include/erofs_fs.h<br>
&gt; @@ -20,25 +20,31 @@<br>
&gt;=C2=A0 #define EROFS_REQUIREMENT_LZ4_0PADDING=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x00000001<br>
&gt;=C2=A0 #define EROFS_ALL_REQUIREMENTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0EROFS_REQUIREMENT_LZ4_0PADDING<br>
&gt;<br>
&gt; +/*<br>
&gt; + * feature definations.<br>
&gt; + */<br>
&gt; +#define EROFS_FEATURE_SB_CHKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x0001<br>
&gt; +<br>
&gt; +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0( le32_to_cpu((super)-&gt;features) &amp; (mask) =
)<br>
&gt; +<br>
&gt;=C2=A0 struct erofs_super_block {<br>
&gt;=C2=A0 /*=C2=A0 0 */__le32 magic;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* in the little endian */<br>
&gt; -/*=C2=A0 4 */__le32 checksum;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* crc32c(su=
per_block) */<br>
&gt; -/*=C2=A0 8 */__le32 features;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* (aka. fea=
ture_compat) */<br>
&gt; -/* 12 */__u8 blkszbits;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* support b=
lock_size =3D=3D PAGE_SIZE only */<br>
&gt; -/* 13 */__u8 reserved;<br>
&gt; -<br>
&gt; -/* 14 */__le16 root_nid;<br>
&gt; -/* 16 */__le64 inos;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* tota=
l valid ino # (=3D=3D f_files - f_favail) */<br>
&gt; -<br>
&gt; -/* 24 */__le64 build_time;=C2=A0 =C2=A0 =C2=A0 /* inode v1 time deriv=
ation */<br>
&gt; -/* 32 */__le32 build_time_nsec;<br>
&gt; -/* 36 */__le32 blocks;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* used for =
statfs */<br>
&gt; -/* 40 */__le32 meta_blkaddr;<br>
&gt; -/* 44 */__le32 xattr_blkaddr;<br>
&gt; -/* 48 */__u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 128-bit u=
uid for volume */<br>
&gt; -/* 64 */__u8 volume_name[16];=C2=A0 =C2=A0/* volume name */<br>
&gt; -/* 80 */__le32 requirements;=C2=A0 =C2=A0 /* (aka. feature_incompat) =
*/<br>
&gt; -<br>
&gt; +/*=C2=A0 4 */__le32 features;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* (aka. fea=
ture_compat) */<br>
&gt; +/*=C2=A0 8 */__u8 blkszbits;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* supp=
ort block_size =3D=3D PAGE_SIZE only */<br>
&gt; +/*=C2=A0 9 */__u8 reserved;<br>
&gt; +<br>
&gt; +/* 10 */__le16 root_nid;<br>
&gt; +/* 12 */__le64 inos;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* tota=
l valid ino # (=3D=3D f_files - f_favail) */<br>
&gt; +/* 20 */__le64 build_time;=C2=A0 =C2=A0 =C2=A0 /* inode v1 time deriv=
ation */<br>
&gt; +/* 28 */__le32 build_time_nsec;<br>
&gt; +/* 32 */__le32 blocks;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* used for =
statfs */<br>
&gt; +/* 36 */__le32 meta_blkaddr;<br>
&gt; +/* 40 */__le32 xattr_blkaddr;<br>
&gt; +/* 44 */__u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 128-bit u=
uid for volume */<br>
&gt; +/* 60 */__u8 volume_name[16];=C2=A0 =C2=A0/* volume name */<br>
&gt; +/* 76 */__le32 requirements;=C2=A0 =C2=A0 /* (aka. feature_incompat) =
*/<br>
&gt; +/* 80 */__le32 checksum;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* crc32c(super_b=
lock) */<br>
&gt;=C2=A0 /* 84 */__u8 reserved2[44];<br>
<br>
Why modifying the above?<br>
<br>
&gt;=C2=A0 } __packed;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* 128 bytes */<br>
&gt;<br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index f127fe1..26e14a3 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -13,12 +13,14 @@<br>
&gt;=C2=A0 #include &lt;limits.h&gt;<br>
&gt;=C2=A0 #include &lt;libgen.h&gt;<br>
&gt;=C2=A0 #include &lt;sys/stat.h&gt;<br>
&gt; +#include &lt;zlib.h&gt;<br>
<br>
I have no idea that we should introduce &quot;zlib&quot; just for crc32c cu=
rrently...<br>
Maybe we can add some independent crc32 function..<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt;=C2=A0 #include &quot;erofs/config.h&quot;<br>
&gt;=C2=A0 #include &quot;erofs/print.h&quot;<br>
&gt;=C2=A0 #include &quot;erofs/cache.h&quot;<br>
&gt;=C2=A0 #include &quot;erofs/inode.h&quot;<br>
&gt;=C2=A0 #include &quot;erofs/io.h&quot;<br>
&gt;=C2=A0 #include &quot;erofs/compress.h&quot;<br>
&gt; +#include &quot;erofs/defs.h&quot;<br>
&gt;<br>
&gt;=C2=A0 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erof=
s_super_block))<br>
&gt;<br>
&gt; @@ -31,6 +33,28 @@ static void usage(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot; -EX[,...] X=3Dextende=
d options\n&quot;);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +char *feature_opts[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;sb_cksum&quot;, NULL<br>
&gt; +};<br>
&gt; +#define O_SB_CKSUM=C2=A0 =C2=A00<br>
&gt; +<br>
&gt; +static int parse_feature_subopts(char *opts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *arg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (*opts !=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(getsubopt(&amp=
;opts, feature_opts, &amp;arg)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case O_SB_CKSUM:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cfg.c_feature_flags |=3D EROFS_FEATURE_SB_CHKSUM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0erofs_err(&quot;incorrect suboption&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int parse_extended_opts(const char *opts)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 #define MATCH_EXTENTED_OPT(opt, token, keylen) \<br>
&gt; @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int opt, i;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &quot;d:z:E:&q=
uot;)) !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &quot;d:z:E:o:=
&quot;)) !=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (opt) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;z&#39;=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!optarg) {<br>
&gt; @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;o&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0opt =3D parse_feature_subopts(optarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (opt)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default: /* &#39=
;?&#39; */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +u32 erofs_superblock_checksum(struct erofs_super_block *sb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 crc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0offset =3D offsetof(struct erofs_super_block, che=
cksum);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (offset &lt; 0 || offset &gt; sizeof(struct er=
ofs_super_block)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Inval=
id offset of checksum field: %d&quot;, offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crc =3D crc32(~0, (const unsigned char *)sb,(size=
_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;superblock checksum: 0x%x\n&quot=
;, crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t root_nid)<br>
&gt;=C2=A0 {<br>
&gt; @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct erofs_buf=
fer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.meta_blkaddr=C2=
=A0 =3D sbi.meta_blkaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.xattr_blkaddr =
=3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.requirements =
=3D cpu_to_le32(sbi.requirements),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.features =3D cpu_to_=
le32(cfg.c_feature_flags),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int sb_blksize =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0round_up(EROFS_S=
UPER_END, EROFS_BLKSIZ);<br>
&gt; @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct erofs_bu=
ffer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.blocks=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D cpu_=
to_le32(erofs_mapbh(NULL, true));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.root_nid=C2=A0 =C2=A0 =C2=A0=3D cpu_to_le=
16(root_nid);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (EROFS_HAS_COMPAT_FEATURE(&amp;sb, EROFS_FEATU=
RE_SB_CHKSUM)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 crc =3D erofs_sup=
erblock_checksum(&amp;sb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sb.checksum =3D cpu_t=
o_le32(crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D calloc(sb_blksize, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!buf) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;=
Failed to allocate memory for sb: %s&quot;,<br>
&gt; --<br>
&gt; 2.9.3<br>
&gt;<br>
</blockquote></div>

--00000000000010067a0590d9775d--
