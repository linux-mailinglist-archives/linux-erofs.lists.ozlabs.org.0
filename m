Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FDE9BCF0
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 12:06:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Fv6m1LkRzDrqb
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 20:06:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLMLh/kR"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Fv6b5XDhzDrT2
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 20:05:56 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id a21so17758633edt.11
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7DeLAVA4ZtJhsFBTlVgFEWcNIKtBqJQiEDPF9FqBDRU=;
 b=bLMLh/kRpDtrOFjantkr3YGIq1b6y6KEsHdgDHSEBvASuCozayYFRM9obRfVuCR74n
 5A/iPcKRcdQP6kq6/K5Vqg4n5d8EGzOJKrMfiyC5hIHCsObrSbwg6vEo6/jyog0hnCbM
 K8PaR/AqS/cg/bd0CN/IcnC8xm3vswcrJsFNvvDP480SJ2uBbHZVCXj9HOEaSjKLsEvk
 b/eNLnQqvh/7asWMGJQOydWeAaRybCu7fvGZz8m6tNT1b62N2K+yfuVkvNzn7BJ7RCVg
 aWWm57siT/jzx7kWbJoRCjpgqkwJi+4suMtUx7BNwCHGx/0TPYMU0Djo9KkwngG+YTLy
 wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7DeLAVA4ZtJhsFBTlVgFEWcNIKtBqJQiEDPF9FqBDRU=;
 b=V6JpvYm/J25fLSFX3dvTWnCnMIlmOkSkM4VQSHzVNrv2G6dHe9kR8cH3X5hjfeiam6
 oR6dnVp5SIWq3lYyTd8q7zYk6qgROKyN+OT7pgNt5hZG+CqnvSTKedA9a/yFsvVyH567
 U8n2mY4SH7F8q2ywukNuEUs8yxXh47d/LQgoFdIuUjIADoC4hKWOeKjfS25vo9VHjS/k
 SXYDBGd09cJcO2tAXlNph0bq+51uZmrNQnmynXJDYeD9PucE9VrwAH3mo/JbDELu6Umd
 xW+8rs+YcLFkTiKJx7+pKz3662jU3XDvKJzSEM3RMGmXuuADzVNk6qT6E/R3qnIhZ+kk
 2dQQ==
X-Gm-Message-State: APjAAAVl1TJMsTkWZruNDf2Thgonlo1y7uT+z71b+AS4d+wbEYPFXF1g
 ZVnUSt7nrpot1dWuNBVycuulDDb6vDnVi5wYIyw=
X-Google-Smtp-Source: APXvYqwPtAAHIVBRCOgYdggkwpccvOFpT7JZS511z+febxzbKpvPBxcYpawYJZ4TbzVtbPvZFDFfuE4Ze3lG27npI70=
X-Received: by 2002:aa7:ce89:: with SMTP id y9mr8825876edv.135.1566641152507; 
 Sat, 24 Aug 2019 03:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190824074158.16254-1-pratikshinde320@gmail.com>
 <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czQ2kP-z-T-P67CeBxdCnLBVmKtW6h8eOnrEY+FEQTiwSQ@mail.gmail.com>
 <20190824094921.GA18623@hsiangkao-HP-ZHAN-66-Pro-G1>
 <5297cdca-464a-7d52-b69a-96688aa52725@kernel.org>
In-Reply-To: <5297cdca-464a-7d52-b69a-96688aa52725@kernel.org>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sat, 24 Aug 2019 15:35:40 +0530
Message-ID: <CAGu0czSJVAsBjLoYK-zM2=sA=thYWaOJa0kUXvCSovuaoyjQhA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
To: Chao Yu <chao@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000062c17a0590da11bb"
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

--00000000000062c17a0590da11bb
Content-Type: text/plain; charset="UTF-8"

Thanks Chao,

Initially I was of doing the same, but then I thought changing the position
of cheksum field to either start OR end
will be much simpler.
I think I will go with Gao's method. thereby not changing the layout of
super-block.
So just to be clear, I will be writing our own crc32c() function correct ?

--Pratik.

On Sat, Aug 24, 2019 at 3:31 PM Chao Yu <chao@kernel.org> wrote:

> On 2019-8-24 17:49, Gao Xiang via Linux-erofs wrote:
> > Hi Pratik,
> >
> > On Sat, Aug 24, 2019 at 02:52:31PM +0530, Pratik Shinde wrote:
> >> Hi Gao,
> >> Yes I will make the suboption naming similar to that of mk2fs.
> >
> > Great! :)
> >
> >>
> >> The reason I changed the position of 'checksum' field :
> >>
> >> Since we are calculating the checksum of erofs_super_block structure and
> >> storing it in the same structure; we cannot include
> >> this field for actual crc calculations. Keeping it at the end makes it
> easy
> >> for me to calculate length of the data of which
> >> checksum needs to be calculated. I saw similar logic in other
> filesystems
> >> like ext4.
> >
> > No, that is just they didn't add checksum field at the beginning of its
> design.
> > I think you can leave chksum to 0, and calculate chksum and fill it, to
> be specfic:
> >
> > In the erofs-utils,
> >  1) fill .checksum to 0;
> >  2) calculate crc32c of the entire erofs_super_block;
> >  3) fill the real checksum to .checksum;
> >
> > In the kernel,
> >  1) read .checksum to a variable;
> >  2) fill .checksum to 0;
> >  3) calculate crc32c of the entire erofs_super_block;
> >  4) compare the given one and the calculated one;
>
> That's one way, FYI, the way used in ext4/f2fs now is:
> - calc [0, checksum]'s chksum
> - use above chksum as seed of chksum within range [chksum + chksum_size,
> end]
> - fill chksum value in range [checksum, chksum + chksum_size]
>
> Thanks,
>
> >
> > That is all :)
> >
> >>
> >> We can write our own crc32() function. :) There is no problem. I thought
> >> zlib already provides one & we can use it.
> >
> > I think we can use crc32c() since I already wrote comments for erofs in
> 4.19.
> >
> > Looking forward to your next version :)
> >
> > Thanks,
> > Gao Xiang
> >
> >> anyways , I will write.
> >>
> >> --Pratik.
> >>
> >> On Sat, Aug 24, 2019 at 2:16 PM Gao Xiang <hsiangkao@gmx.com> wrote:
> >>
> >>> Hi Pratik,
> >>>
> >>> On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:
> >>>> Adding code for superblock checksum calculation.
> >>>>
> >>>> This patch adds following things:
> >>>> 1)Handle suboptions('-o') to mkfs utility.
> >>>
> >>> Thanks for your patch. :)
> >>>
> >>> Can we use "-O feature" instead in order to keep in line with mke2fs?
> >>>
> >>>> 2)Add superblock checksum calculation(-o sb_cksum) as suboption.
> >>>
> >>> ditto. and I think we can enable sbcrc by default since it is a compat
> >>> feature,
> >>> and add "-O nosbcrc" to disable it.
> >>>
> >>>> 3)Calculate superblock checksum if feature is enabled.
> >>>>
> >>>> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> >>>
> >>> And could you please also read my following comments and fix them.
> >>> and I'd like to accept your erofs-utils modification in advance. :)
> >>>
> >>>
> >>> But now you can see we are moving EROFS out of staging now as
> >>> the "real" part of Linux, this is the fundamental stuff of other
> >>> new features if we want to develop more actively... So we can wait
> >>> for the final result and add this new feature to kernel then...
> >>>
> >>>> ---
> >>>>  include/erofs/config.h |  1 +
> >>>>  include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
> >>>>  mkfs/main.c            | 53
> >>> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>>  3 files changed, 76 insertions(+), 18 deletions(-)
> >>>>
> >>>> diff --git a/include/erofs/config.h b/include/erofs/config.h
> >>>> index 05fe6b2..40cd466 100644
> >>>> --- a/include/erofs/config.h
> >>>> +++ b/include/erofs/config.h
> >>>> @@ -22,6 +22,7 @@ struct erofs_configure {
> >>>>       char *c_src_path;
> >>>>       char *c_compr_alg_master;
> >>>>       int c_compr_level_master;
> >>>> +     int c_feature_flags;
> >>>
> >>> we can add this to sbi like requirements...
> >>>
> >>>>  };
> >>>>
> >>>>  extern struct erofs_configure cfg;
> >>>> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> >>>> index 601b477..c9ef057 100644
> >>>> --- a/include/erofs_fs.h
> >>>> +++ b/include/erofs_fs.h
> >>>> @@ -20,25 +20,31 @@
> >>>>  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> >>>>  #define EROFS_ALL_REQUIREMENTS
> >>>  EROFS_REQUIREMENT_LZ4_0PADDING
> >>>>
> >>>> +/*
> >>>> + * feature definations.
> >>>> + */
> >>>> +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> >>>> +
> >>>> +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> >>>> +     ( le32_to_cpu((super)->features) & (mask) )
> >>>> +
> >>>>  struct erofs_super_block {
> >>>>  /*  0 */__le32 magic;           /* in the little endian */
> >>>> -/*  4 */__le32 checksum;        /* crc32c(super_block) */
> >>>> -/*  8 */__le32 features;        /* (aka. feature_compat) */
> >>>> -/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE
> only
> >>> */
> >>>> -/* 13 */__u8 reserved;
> >>>> -
> >>>> -/* 14 */__le16 root_nid;
> >>>> -/* 16 */__le64 inos;            /* total valid ino # (== f_files -
> >>> f_favail) */
> >>>> -
> >>>> -/* 24 */__le64 build_time;      /* inode v1 time derivation */
> >>>> -/* 32 */__le32 build_time_nsec;
> >>>> -/* 36 */__le32 blocks;          /* used for statfs */
> >>>> -/* 40 */__le32 meta_blkaddr;
> >>>> -/* 44 */__le32 xattr_blkaddr;
> >>>> -/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
> >>>> -/* 64 */__u8 volume_name[16];   /* volume name */
> >>>> -/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> >>>> -
> >>>> +/*  4 */__le32 features;        /* (aka. feature_compat) */
> >>>> +/*  8 */__u8 blkszbits;         /* support block_size == PAGE_SIZE
> only
> >>> */
> >>>> +/*  9 */__u8 reserved;
> >>>> +
> >>>> +/* 10 */__le16 root_nid;
> >>>> +/* 12 */__le64 inos;            /* total valid ino # (== f_files -
> >>> f_favail) */
> >>>> +/* 20 */__le64 build_time;      /* inode v1 time derivation */
> >>>> +/* 28 */__le32 build_time_nsec;
> >>>> +/* 32 */__le32 blocks;          /* used for statfs */
> >>>> +/* 36 */__le32 meta_blkaddr;
> >>>> +/* 40 */__le32 xattr_blkaddr;
> >>>> +/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
> >>>> +/* 60 */__u8 volume_name[16];   /* volume name */
> >>>> +/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
> >>>> +/* 80 */__le32 checksum;        /* crc32c(super_block) */
> >>>>  /* 84 */__u8 reserved2[44];
> >>>
> >>> Why modifying the above?
> >>>
> >>>>  } __packed;                     /* 128 bytes */
> >>>>
> >>>> diff --git a/mkfs/main.c b/mkfs/main.c
> >>>> index f127fe1..26e14a3 100644
> >>>> --- a/mkfs/main.c
> >>>> +++ b/mkfs/main.c
> >>>> @@ -13,12 +13,14 @@
> >>>>  #include <limits.h>
> >>>>  #include <libgen.h>
> >>>>  #include <sys/stat.h>
> >>>> +#include <zlib.h>
> >>>
> >>> I have no idea that we should introduce "zlib" just for crc32c
> currently...
> >>> Maybe we can add some independent crc32 function..
> >>>
> >>> Thanks,
> >>> Gao Xiang
> >>>
> >>>>  #include "erofs/config.h"
> >>>>  #include "erofs/print.h"
> >>>>  #include "erofs/cache.h"
> >>>>  #include "erofs/inode.h"
> >>>>  #include "erofs/io.h"
> >>>>  #include "erofs/compress.h"
> >>>> +#include "erofs/defs.h"
> >>>>
> >>>>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
> >>> erofs_super_block))
> >>>>
> >>>> @@ -31,6 +33,28 @@ static void usage(void)
> >>>>       fprintf(stderr, " -EX[,...] X=extended options\n");
> >>>>  }
> >>>>
> >>>> +char *feature_opts[] = {
> >>>> +     "sb_cksum", NULL
> >>>> +};
> >>>> +#define O_SB_CKSUM   0
> >>>> +
> >>>> +static int parse_feature_subopts(char *opts)
> >>>> +{
> >>>> +     char *arg;
> >>>> +
> >>>> +     while (*opts != '\0') {
> >>>> +             switch(getsubopt(&opts, feature_opts, &arg)) {
> >>>> +             case O_SB_CKSUM:
> >>>> +                     cfg.c_feature_flags |= EROFS_FEATURE_SB_CHKSUM;
> >>>> +                     break;
> >>>> +             default:
> >>>> +                     erofs_err("incorrect suboption");
> >>>> +                     return -EINVAL;
> >>>> +             }
> >>>> +     }
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>>  static int parse_extended_opts(const char *opts)
> >>>>  {
> >>>>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> >>>> @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char
> >>> *argv[])
> >>>>  {
> >>>>       int opt, i;
> >>>>
> >>>> -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> >>>> +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> >>>>               switch (opt) {
> >>>>               case 'z':
> >>>>                       if (!optarg) {
> >>>> @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char
> >>> *argv[])
> >>>>                               return opt;
> >>>>                       break;
> >>>>
> >>>> +             case 'o':
> >>>> +                     opt = parse_feature_subopts(optarg);
> >>>> +                     if (opt)
> >>>> +                             return opt;
> >>>> +                     break;
> >>>> +
> >>>>               default: /* '?' */
> >>>>                       return -EINVAL;
> >>>>               }
> >>>> @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char
> >>> *argv[])
> >>>>       return 0;
> >>>>  }
> >>>>
> >>>> +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> >>>> +{
> >>>> +     int offset;
> >>>> +     u32 crc;
> >>>> +
> >>>> +     offset = offsetof(struct erofs_super_block, checksum);
> >>>> +     if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
> >>>> +             erofs_err("Invalid offset of checksum field: %d",
> offset);
> >>>> +             return -1;
> >>>> +     }
> >>>> +     crc = crc32(~0, (const unsigned char *)sb,(size_t)offset);
> >>>> +     erofs_dump("superblock checksum: 0x%x\n", crc);
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>>  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >>>>                                 erofs_nid_t root_nid)
> >>>>  {
> >>>> @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct
> >>> erofs_buffer_head *bh,
> >>>>               .meta_blkaddr  = sbi.meta_blkaddr,
> >>>>               .xattr_blkaddr = 0,
> >>>>               .requirements = cpu_to_le32(sbi.requirements),
> >>>> +             .features = cpu_to_le32(cfg.c_feature_flags),
> >>>>       };
> >>>>       const unsigned int sb_blksize =
> >>>>               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> >>>> @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct
> >>> erofs_buffer_head *bh,
> >>>>       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> >>>>       sb.root_nid     = cpu_to_le16(root_nid);
> >>>>
> >>>> +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> >>>> +             u32 crc = erofs_superblock_checksum(&sb);
> >>>> +             sb.checksum = cpu_to_le32(crc);
> >>>> +     }
> >>>> +
> >>>>       buf = calloc(sb_blksize, 1);
> >>>>       if (!buf) {
> >>>>               erofs_err("Failed to allocate memory for sb: %s",
> >>>> --
> >>>> 2.9.3
> >>>>
> >>>
>

--00000000000062c17a0590da11bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Chao,</div><div><br></div><div>Initially I was=
 of doing the same, but then I thought changing the position of cheksum fie=
ld to either start OR end <br></div><div>will be much simpler. <br></div><d=
iv>I think I will go with Gao&#39;s method. thereby not changing the layout=
 of super-block.</div><div>So just to be clear, I will be writing our own c=
rc32c() function correct ?</div><div><br></div><div>--Pratik.<br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
at, Aug 24, 2019 at 3:31 PM Chao Yu &lt;<a href=3D"mailto:chao@kernel.org">=
chao@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On 2019-8-24 17:49, Gao Xiang via Linux-erofs wrote:<br>
&gt; Hi Pratik,<br>
&gt; <br>
&gt; On Sat, Aug 24, 2019 at 02:52:31PM +0530, Pratik Shinde wrote:<br>
&gt;&gt; Hi Gao,<br>
&gt;&gt; Yes I will make the suboption naming similar to that of mk2fs.<br>
&gt; <br>
&gt; Great! :)<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; The reason I changed the position of &#39;checksum&#39; field :<br=
>
&gt;&gt;<br>
&gt;&gt; Since we are calculating the checksum of erofs_super_block structu=
re and<br>
&gt;&gt; storing it in the same structure; we cannot include<br>
&gt;&gt; this field for actual crc calculations. Keeping it at the end make=
s it easy<br>
&gt;&gt; for me to calculate length of the data of which<br>
&gt;&gt; checksum needs to be calculated. I saw similar logic in other file=
systems<br>
&gt;&gt; like ext4.<br>
&gt; <br>
&gt; No, that is just they didn&#39;t add checksum field at the beginning o=
f its design.<br>
&gt; I think you can leave chksum to 0, and calculate chksum and fill it, t=
o be specfic:<br>
&gt; <br>
&gt; In the erofs-utils,<br>
&gt;=C2=A0 1) fill .checksum to 0;<br>
&gt;=C2=A0 2) calculate crc32c of the entire erofs_super_block;<br>
&gt;=C2=A0 3) fill the real checksum to .checksum;<br>
&gt; <br>
&gt; In the kernel,<br>
&gt;=C2=A0 1) read .checksum to a variable;<br>
&gt;=C2=A0 2) fill .checksum to 0;<br>
&gt;=C2=A0 3) calculate crc32c of the entire erofs_super_block;<br>
&gt;=C2=A0 4) compare the given one and the calculated one;<br>
<br>
That&#39;s one way, FYI, the way used in ext4/f2fs now is:<br>
- calc [0, checksum]&#39;s chksum<br>
- use above chksum as seed of chksum within range [chksum + chksum_size, en=
d]<br>
- fill chksum value in range [checksum, chksum + chksum_size]<br>
<br>
Thanks,<br>
<br>
&gt; <br>
&gt; That is all :)<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; We can write our own crc32() function. :) There is no problem. I t=
hought<br>
&gt;&gt; zlib already provides one &amp; we can use it.<br>
&gt; <br>
&gt; I think we can use crc32c() since I already wrote comments for erofs i=
n 4.19.<br>
&gt; <br>
&gt; Looking forward to your next version :)<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Gao Xiang<br>
&gt; <br>
&gt;&gt; anyways , I will write.<br>
&gt;&gt;<br>
&gt;&gt; --Pratik.<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Aug 24, 2019 at 2:16 PM Gao Xiang &lt;<a href=3D"mailto:hs=
iangkao@gmx.com" target=3D"_blank">hsiangkao@gmx.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hi Pratik,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:=
<br>
&gt;&gt;&gt;&gt; Adding code for superblock checksum calculation.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This patch adds following things:<br>
&gt;&gt;&gt;&gt; 1)Handle suboptions(&#39;-o&#39;) to mkfs utility.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks for your patch. :)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can we use &quot;-O feature&quot; instead in order to keep in =
line with mke2fs?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 2)Add superblock checksum calculation(-o sb_cksum) as subo=
ption.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ditto. and I think we can enable sbcrc by default since it is =
a compat<br>
&gt;&gt;&gt; feature,<br>
&gt;&gt;&gt; and add &quot;-O nosbcrc&quot; to disable it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 3)Calculate superblock checksum if feature is enabled.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratiks=
hinde320@gmail.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; And could you please also read my following comments and fix t=
hem.<br>
&gt;&gt;&gt; and I&#39;d like to accept your erofs-utils modification in ad=
vance. :)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But now you can see we are moving EROFS out of staging now as<=
br>
&gt;&gt;&gt; the &quot;real&quot; part of Linux, this is the fundamental st=
uff of other<br>
&gt;&gt;&gt; new features if we want to develop more actively... So we can =
wait<br>
&gt;&gt;&gt; for the final result and add this new feature to kernel then..=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 include/erofs/config.h |=C2=A0 1 +<br>
&gt;&gt;&gt;&gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0| 40 +++++++++=
++++++++++++----------------<br>
&gt;&gt;&gt;&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 53<br>
&gt;&gt;&gt; +++++++++++++++++++++++++++++++++++++++++++++++++-<br>
&gt;&gt;&gt;&gt;=C2=A0 3 files changed, 76 insertions(+), 18 deletions(-)<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/include/erofs/config.h b/include/erofs/config=
.h<br>
&gt;&gt;&gt;&gt; index 05fe6b2..40cd466 100644<br>
&gt;&gt;&gt;&gt; --- a/include/erofs/config.h<br>
&gt;&gt;&gt;&gt; +++ b/include/erofs/config.h<br>
&gt;&gt;&gt;&gt; @@ -22,6 +22,7 @@ struct erofs_configure {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_src_path;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_compr_alg_master;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int c_compr_level_master;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int c_feature_flags;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; we can add this to sbi like requirements...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 extern struct erofs_configure cfg;<br>
&gt;&gt;&gt;&gt; diff --git a/include/erofs_fs.h b/include/erofs_fs.h<br>
&gt;&gt;&gt;&gt; index 601b477..c9ef057 100644<br>
&gt;&gt;&gt;&gt; --- a/include/erofs_fs.h<br>
&gt;&gt;&gt;&gt; +++ b/include/erofs_fs.h<br>
&gt;&gt;&gt;&gt; @@ -20,25 +20,31 @@<br>
&gt;&gt;&gt;&gt;=C2=A0 #define EROFS_REQUIREMENT_LZ4_0PADDING=C2=A0 =C2=A0 =
=C2=A0 =C2=A00x00000001<br>
&gt;&gt;&gt;&gt;=C2=A0 #define EROFS_ALL_REQUIREMENTS<br>
&gt;&gt;&gt;=C2=A0 EROFS_REQUIREMENT_LZ4_0PADDING<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt; + * feature definations.<br>
&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt; +#define EROFS_FEATURE_SB_CHKSUM=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x0001<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0( le32_to_cpu((super)-&gt;features) &=
amp; (mask) )<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 struct erofs_super_block {<br>
&gt;&gt;&gt;&gt;=C2=A0 /*=C2=A0 0 */__le32 magic;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* in the little endian */<br>
&gt;&gt;&gt;&gt; -/*=C2=A0 4 */__le32 checksum;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* crc32c(super_block) */<br>
&gt;&gt;&gt;&gt; -/*=C2=A0 8 */__le32 features;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* (aka. feature_compat) */<br>
&gt;&gt;&gt;&gt; -/* 12 */__u8 blkszbits;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* support block_size =3D=3D PAGE_SIZE only<br>
&gt;&gt;&gt; */<br>
&gt;&gt;&gt;&gt; -/* 13 */__u8 reserved;<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -/* 14 */__le16 root_nid;<br>
&gt;&gt;&gt;&gt; -/* 16 */__le64 inos;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* total valid ino # (=3D=3D f_files -<br>
&gt;&gt;&gt; f_favail) */<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; -/* 24 */__le64 build_time;=C2=A0 =C2=A0 =C2=A0 /* inode v=
1 time derivation */<br>
&gt;&gt;&gt;&gt; -/* 32 */__le32 build_time_nsec;<br>
&gt;&gt;&gt;&gt; -/* 36 */__le32 blocks;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* used for statfs */<br>
&gt;&gt;&gt;&gt; -/* 40 */__le32 meta_blkaddr;<br>
&gt;&gt;&gt;&gt; -/* 44 */__le32 xattr_blkaddr;<br>
&gt;&gt;&gt;&gt; -/* 48 */__u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* 128-bit uuid for volume */<br>
&gt;&gt;&gt;&gt; -/* 64 */__u8 volume_name[16];=C2=A0 =C2=A0/* volume name =
*/<br>
&gt;&gt;&gt;&gt; -/* 80 */__le32 requirements;=C2=A0 =C2=A0 /* (aka. featur=
e_incompat) */<br>
&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt; +/*=C2=A0 4 */__le32 features;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* (aka. feature_compat) */<br>
&gt;&gt;&gt;&gt; +/*=C2=A0 8 */__u8 blkszbits;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* support block_size =3D=3D PAGE_SIZE only<br>
&gt;&gt;&gt; */<br>
&gt;&gt;&gt;&gt; +/*=C2=A0 9 */__u8 reserved;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +/* 10 */__le16 root_nid;<br>
&gt;&gt;&gt;&gt; +/* 12 */__le64 inos;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* total valid ino # (=3D=3D f_files -<br>
&gt;&gt;&gt; f_favail) */<br>
&gt;&gt;&gt;&gt; +/* 20 */__le64 build_time;=C2=A0 =C2=A0 =C2=A0 /* inode v=
1 time derivation */<br>
&gt;&gt;&gt;&gt; +/* 28 */__le32 build_time_nsec;<br>
&gt;&gt;&gt;&gt; +/* 32 */__le32 blocks;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* used for statfs */<br>
&gt;&gt;&gt;&gt; +/* 36 */__le32 meta_blkaddr;<br>
&gt;&gt;&gt;&gt; +/* 40 */__le32 xattr_blkaddr;<br>
&gt;&gt;&gt;&gt; +/* 44 */__u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* 128-bit uuid for volume */<br>
&gt;&gt;&gt;&gt; +/* 60 */__u8 volume_name[16];=C2=A0 =C2=A0/* volume name =
*/<br>
&gt;&gt;&gt;&gt; +/* 76 */__le32 requirements;=C2=A0 =C2=A0 /* (aka. featur=
e_incompat) */<br>
&gt;&gt;&gt;&gt; +/* 80 */__le32 checksum;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cr=
c32c(super_block) */<br>
&gt;&gt;&gt;&gt;=C2=A0 /* 84 */__u8 reserved2[44];<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Why modifying the above?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 } __packed;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 128 bytes */<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt;&gt;&gt;&gt; index f127fe1..26e14a3 100644<br>
&gt;&gt;&gt;&gt; --- a/mkfs/main.c<br>
&gt;&gt;&gt;&gt; +++ b/mkfs/main.c<br>
&gt;&gt;&gt;&gt; @@ -13,12 +13,14 @@<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &lt;limits.h&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &lt;libgen.h&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &lt;sys/stat.h&gt;<br>
&gt;&gt;&gt;&gt; +#include &lt;zlib.h&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have no idea that we should introduce &quot;zlib&quot; just =
for crc32c currently...<br>
&gt;&gt;&gt; Maybe we can add some independent crc32 function..<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Gao Xiang<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/config.h&quot;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/print.h&quot;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/cache.h&quot;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/inode.h&quot;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/io.h&quot;<br>
&gt;&gt;&gt;&gt;=C2=A0 #include &quot;erofs/compress.h&quot;<br>
&gt;&gt;&gt;&gt; +#include &quot;erofs/defs.h&quot;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof=
(struct<br>
&gt;&gt;&gt; erofs_super_block))<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -31,6 +33,28 @@ static void usage(void)<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot; -EX[,...]=
 X=3Dextended options\n&quot;);<br>
&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +char *feature_opts[] =3D {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0&quot;sb_cksum&quot;, NULL<br>
&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt; +#define O_SB_CKSUM=C2=A0 =C2=A00<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +static int parse_feature_subopts(char *opts)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0char *arg;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0while (*opts !=3D &#39;\0&#39;) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(ge=
tsubopt(&amp;opts, feature_opts, &amp;arg)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case O_SB=
_CKSUM:<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags |=3D EROFS_FEATURE_SB_CHKSUM;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<=
br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0erofs_err(&quot;incorrect suboption&quot;);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 static int parse_extended_opts(const char *opts)<br>
&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt;=C2=A0 #define MATCH_EXTENTED_OPT(opt, token, keylen) \<br>
&gt;&gt;&gt;&gt; @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int a=
rgc, char<br>
&gt;&gt;&gt; *argv[])<br>
&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int opt, i;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &q=
uot;d:z:E:&quot;)) !=3D -1) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &q=
uot;d:z:E:o:&quot;)) !=3D -1) {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swit=
ch (opt) {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=
 &#39;z&#39;:<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!optarg) {<br>
&gt;&gt;&gt;&gt; @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int=
 argc, char<br>
&gt;&gt;&gt; *argv[])<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39=
;o&#39;:<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0opt =3D parse_feature_subopts(optarg);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (opt)<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defa=
ult: /* &#39;?&#39; */<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt;&gt;&gt;&gt; @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int=
 argc, char<br>
&gt;&gt;&gt; *argv[])<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +u32 erofs_superblock_checksum(struct erofs_super_block *s=
b)<br>
&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0int offset;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0u32 crc;<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0offset =3D offsetof(struct erofs_supe=
r_block, checksum);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (offset &lt; 0 || offset &gt; size=
of(struct erofs_super_block)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err=
(&quot;Invalid offset of checksum field: %d&quot;, offset);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1=
;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0crc =3D crc32(~0, (const unsigned cha=
r *)sb,(size_t)offset);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;superblock checksum:=
 0x%x\n&quot;, crc);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 int erofs_mkfs_update_super_block(struct erofs_buffe=
r_head *bh,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t root=
_nid)<br>
&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt; @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(stru=
ct<br>
&gt;&gt;&gt; erofs_buffer_head *bh,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.met=
a_blkaddr=C2=A0 =3D sbi.meta_blkaddr,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.xat=
tr_blkaddr =3D 0,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.req=
uirements =3D cpu_to_le32(sbi.requirements),<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.features=
 =3D cpu_to_le32(cfg.c_feature_flags),<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int sb_blksize =
=3D<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0roun=
d_up(EROFS_SUPER_END, EROFS_BLKSIZ);<br>
&gt;&gt;&gt;&gt; @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(str=
uct<br>
&gt;&gt;&gt; erofs_buffer_head *bh,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.blocks=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D cpu_to_le32(erofs_mapbh(NULL, true));<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.root_nid=C2=A0 =C2=A0 =C2=A0=
=3D cpu_to_le16(root_nid);<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (EROFS_HAS_COMPAT_FEATURE(&amp;sb,=
 EROFS_FEATURE_SB_CHKSUM)) {<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 crc =
=3D erofs_superblock_checksum(&amp;sb);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sb.checks=
um =3D cpu_to_le32(crc);<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D calloc(sb_blksize, 1);<b=
r>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!buf) {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erof=
s_err(&quot;Failed to allocate memory for sb: %s&quot;,<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; 2.9.3<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
</blockquote></div>

--00000000000062c17a0590da11bb--
