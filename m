Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D57199BCFA
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 12:14:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46FvJc2S3DzDrqW
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 20:14:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566641680;
	bh=KhDkD6dPx7khaqI3je0zjeEcZuPEW9953iKvQyThBBk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OeIiM+L9vR1r/w3LYHtI+W4lDuZoMJTaegufiBS1gJ7BTX8WkdggB5GhH8G9lDDJU
	 RfLKMx0JOQbxgKzGAO8+iG4o+bcYAPicgoK5Phsc5NRxD0/0jdhhcUzGVFunwy9sdT
	 9NSRVwnQfsySYwUoHntlbL7i/YoPMA6XsieedfO7yzRMfDWTw4Rf5klXL+PpfzTSEG
	 Ghb8l48GIMV67w4UUt1NtWwhxHZQeGQ/NvYvTIcfHP1526TNU2cWmt6yKK6WQin1PU
	 ZiH6e00w47mrilt2VEB/KoP/IhiOYjtJE4L0k3P6SK4BbJpIqSV+AQ/6NPOT8dVNHK
	 UkNV+wVL96Hsw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.30; helo=sonic310-57.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="oHL7Hlp/"; 
 dkim-atps=neutral
Received: from sonic310-57.consmr.mail.ir2.yahoo.com
 (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FvJS6TxlzDrWV
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 20:14:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566641665; bh=SohK3rQbhac6XtQ5pRj0pQFjQb/zJk248/vBB5KHs+4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=oHL7Hlp/T+SwdfYBylXB5EiEm1akyHzRoPt33WvcC6k4S8wRWcEXeRDFMJY1DxyKJhwt9jPr/o3VA4fWFYOwUC+0LiKOXxhatEnax252H5FpfA/AuIVHIOHwm1z4FhpTzW7a18YQCha9VUxKGa/aTykQpesHP/R7EIMw3q1v9bkzZFA6mRMJh2Rjwdq2w9YGzNDqsZvM1NEfGKdJAKJEDvJ7r1SutOgGDjdIhnPoxK5ld//awmV4KhalhqzXbjt2mUm9XvZ3OMPAy6s+VpbCuTVqGHqA3IeQFuQ7UPFrDoZFWREDuktxC2LtCR4dLwJNp4N9Mem+gtC8XvabGWYa+w==
X-YMail-OSG: PnYKRv8VM1m9bAb8Qr3tU0GHgGSaxMmSFC9y86V1f5bxzttsZSYHkhcQwi1pk8x
 z8OFsU7POdQR7ZEfRfElNPsCZ0EM5J0nIS8Oe1ZhDh5OSzorsz2XeDEpMth5.Dd.97u.axv0isJB
 HhggyWlu6ffqV3wh9RbXfmPPssqvnD4WWtsAGB..K5t1MQS0_MBosGGLEkE83mTCYCqDcgL3rsr3
 4UM5Nu5guJrICqiQiooHmF7YUM_UlDc.ka_5QaOSd.zTmsbTgZ4gVm6S.4UzBcRJG6oNehOheWry
 ubwOUHL.UcLR2RTBB8peNxpFD3r.wdo1zNZWBAEeLjjEfy93usAScZgAoaW8mtXvRwwZ8hsBcYy5
 QBc55bID14oTL6257ci_HexBokuqwicGfTXSxoK1aORzDgKqsKYCQiT_bxvzMjoZ6NBK2MLScvjp
 8b0c_RGmZHxgunQ1Ggz9YaZyZ20PD3gRpbunXD0VPDduPdIB3v_xJWE4WvCNN7RhiH9XjPkhqCl.
 fun_NN2vKamSWbGA5lA7XKo06xOQ1edB8l3VMKwnYdlxp_aQRJb0RWq0Vb_.4rZNfwvAXLPahAFc
 fb4OvhrFw_mvppOMZdtWsOvRuHv0cJCvFxZvwRAP_kMKf_0j1Lh3B_G6bYJJyXhoKjsoOc.hdru.
 0DQnwOoyKYsAzQS6zd5iFmzik5gjpcAVLZgZ8pY.sy9MD3nOBSUvB75KjL0BH72xh624OYaJ25SU
 GLUdKl3_syQnzz4A8.bpgh8KuB7f8cgqRHVfvNpdEW2drK3o_icl4XpntOLm627wu77KllT9IhqN
 ZPOtEW_oLDcJK6U20O2vOvHRZfU0c3KNStvHSF.2xjZQFm5woG1XQEbEw1Um9kZlYH6TrWDuMuu5
 cdC1ShbnjxjAU.hKG58nU4GXgSyhgYT_4Bx3Ke04UDfl8qdcTaZFbVU92uUaMgORhOIeYhcgOmXr
 c4XEPGt5VKF2uJuRoqwbssSofD0krH3HRqV_IMLJm.lvBmZKKLhXN_n8uj_VkROiKaeu0FUL0CiR
 LTZPEJvW2j6Xe6VVC4kpH1nEcfTkLmDL5QkeY2TO84dwNm1FayfjCtessArwFA3cZUQe1JViZgPk
 atiFJJnpe1u.uWhGhReTzmwLkqRv8q3D88cB4elF4xVtp79lhu0wi8RBRlv1ei7ZfPWID1lHrWy2
 0RyD..gl2C3vmlNi0qzsmh8kfdIIaWzvAepscWMPcouT9RTOqP8yhlRwOt3NlIvTX0ADQbZvrU0Q
 dJaxFD6qYkp6_xIfnUSMj_H10kUIHGQrm
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sat, 24 Aug 2019 10:14:25 +0000
Received: by smtp401.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID bfd543b47721ae9bbe6b64dccb1637eb; 
 Sat, 24 Aug 2019 10:14:20 +0000 (UTC)
Date: Sat, 24 Aug 2019 18:14:10 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20190824101409.GA19210@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824074158.16254-1-pratikshinde320@gmail.com>
 <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czQ2kP-z-T-P67CeBxdCnLBVmKtW6h8eOnrEY+FEQTiwSQ@mail.gmail.com>
 <20190824094921.GA18623@hsiangkao-HP-ZHAN-66-Pro-G1>
 <5297cdca-464a-7d52-b69a-96688aa52725@kernel.org>
 <CAGu0czSJVAsBjLoYK-zM2=sA=thYWaOJa0kUXvCSovuaoyjQhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czSJVAsBjLoYK-zM2=sA=thYWaOJa0kUXvCSovuaoyjQhA@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik, and Chao,

On Sat, Aug 24, 2019 at 03:35:40PM +0530, Pratik Shinde wrote:
> Thanks Chao,
> 
> Initially I was of doing the same, but then I thought changing the position
> of cheksum field to either start OR end
> will be much simpler.

To Pratik: erofs layout is almost determined from linux-4.19, and it is fine
           for this chksum field;

> I think I will go with Gao's method. thereby not changing the layout of
> super-block.
> So just to be clear, I will be writing our own crc32c() function correct ?

           Yes, just go with crc32c(). and it's very simple to implement :)

> 
> --Pratik.
> 
> On Sat, Aug 24, 2019 at 3:31 PM Chao Yu <chao@kernel.org> wrote:
> 
> > On 2019-8-24 17:49, Gao Xiang via Linux-erofs wrote:
> > > Hi Pratik,
> > >
> > > On Sat, Aug 24, 2019 at 02:52:31PM +0530, Pratik Shinde wrote:
> > >> Hi Gao,
> > >> Yes I will make the suboption naming similar to that of mk2fs.
> > >
> > > Great! :)
> > >
> > >>
> > >> The reason I changed the position of 'checksum' field :
> > >>
> > >> Since we are calculating the checksum of erofs_super_block structure and
> > >> storing it in the same structure; we cannot include
> > >> this field for actual crc calculations. Keeping it at the end makes it
> > easy
> > >> for me to calculate length of the data of which
> > >> checksum needs to be calculated. I saw similar logic in other
> > filesystems
> > >> like ext4.
> > >
> > > No, that is just they didn't add checksum field at the beginning of its
> > design.
> > > I think you can leave chksum to 0, and calculate chksum and fill it, to
> > be specfic:
> > >
> > > In the erofs-utils,
> > >  1) fill .checksum to 0;
> > >  2) calculate crc32c of the entire erofs_super_block;
> > >  3) fill the real checksum to .checksum;
> > >
> > > In the kernel,
> > >  1) read .checksum to a variable;
> > >  2) fill .checksum to 0;
> > >  3) calculate crc32c of the entire erofs_super_block;
> > >  4) compare the given one and the calculated one;
> >
> > That's one way, FYI, the way used in ext4/f2fs now is:
> > - calc [0, checksum]'s chksum
> > - use above chksum as seed of chksum within range [chksum + chksum_size,
> > end]
> > - fill chksum value in range [checksum, chksum + chksum_size]

To Chao: Yes, I think that's ok as well, but we can do much simple in EROFS,
         and it won't break crc32c pipeline... (calculate in one crc32c function) :)

Thanks,
Gao Xiang

> >
> > Thanks,
> >
> > >
> > > That is all :)
> > >
> > >>
> > >> We can write our own crc32() function. :) There is no problem. I thought
> > >> zlib already provides one & we can use it.
> > >
> > > I think we can use crc32c() since I already wrote comments for erofs in
> > 4.19.
> > >
> > > Looking forward to your next version :)
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > >> anyways , I will write.
> > >>
> > >> --Pratik.
> > >>
> > >> On Sat, Aug 24, 2019 at 2:16 PM Gao Xiang <hsiangkao@gmx.com> wrote:
> > >>
> > >>> Hi Pratik,
> > >>>
> > >>> On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:
> > >>>> Adding code for superblock checksum calculation.
> > >>>>
> > >>>> This patch adds following things:
> > >>>> 1)Handle suboptions('-o') to mkfs utility.
> > >>>
> > >>> Thanks for your patch. :)
> > >>>
> > >>> Can we use "-O feature" instead in order to keep in line with mke2fs?
> > >>>
> > >>>> 2)Add superblock checksum calculation(-o sb_cksum) as suboption.
> > >>>
> > >>> ditto. and I think we can enable sbcrc by default since it is a compat
> > >>> feature,
> > >>> and add "-O nosbcrc" to disable it.
> > >>>
> > >>>> 3)Calculate superblock checksum if feature is enabled.
> > >>>>
> > >>>> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > >>>
> > >>> And could you please also read my following comments and fix them.
> > >>> and I'd like to accept your erofs-utils modification in advance. :)
> > >>>
> > >>>
> > >>> But now you can see we are moving EROFS out of staging now as
> > >>> the "real" part of Linux, this is the fundamental stuff of other
> > >>> new features if we want to develop more actively... So we can wait
> > >>> for the final result and add this new feature to kernel then...
> > >>>
> > >>>> ---
> > >>>>  include/erofs/config.h |  1 +
> > >>>>  include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
> > >>>>  mkfs/main.c            | 53
> > >>> +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >>>>  3 files changed, 76 insertions(+), 18 deletions(-)
> > >>>>
> > >>>> diff --git a/include/erofs/config.h b/include/erofs/config.h
> > >>>> index 05fe6b2..40cd466 100644
> > >>>> --- a/include/erofs/config.h
> > >>>> +++ b/include/erofs/config.h
> > >>>> @@ -22,6 +22,7 @@ struct erofs_configure {
> > >>>>       char *c_src_path;
> > >>>>       char *c_compr_alg_master;
> > >>>>       int c_compr_level_master;
> > >>>> +     int c_feature_flags;
> > >>>
> > >>> we can add this to sbi like requirements...
> > >>>
> > >>>>  };
> > >>>>
> > >>>>  extern struct erofs_configure cfg;
> > >>>> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > >>>> index 601b477..c9ef057 100644
> > >>>> --- a/include/erofs_fs.h
> > >>>> +++ b/include/erofs_fs.h
> > >>>> @@ -20,25 +20,31 @@
> > >>>>  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> > >>>>  #define EROFS_ALL_REQUIREMENTS
> > >>>  EROFS_REQUIREMENT_LZ4_0PADDING
> > >>>>
> > >>>> +/*
> > >>>> + * feature definations.
> > >>>> + */
> > >>>> +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > >>>> +
> > >>>> +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > >>>> +     ( le32_to_cpu((super)->features) & (mask) )
> > >>>> +
> > >>>>  struct erofs_super_block {
> > >>>>  /*  0 */__le32 magic;           /* in the little endian */
> > >>>> -/*  4 */__le32 checksum;        /* crc32c(super_block) */
> > >>>> -/*  8 */__le32 features;        /* (aka. feature_compat) */
> > >>>> -/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE
> > only
> > >>> */
> > >>>> -/* 13 */__u8 reserved;
> > >>>> -
> > >>>> -/* 14 */__le16 root_nid;
> > >>>> -/* 16 */__le64 inos;            /* total valid ino # (== f_files -
> > >>> f_favail) */
> > >>>> -
> > >>>> -/* 24 */__le64 build_time;      /* inode v1 time derivation */
> > >>>> -/* 32 */__le32 build_time_nsec;
> > >>>> -/* 36 */__le32 blocks;          /* used for statfs */
> > >>>> -/* 40 */__le32 meta_blkaddr;
> > >>>> -/* 44 */__le32 xattr_blkaddr;
> > >>>> -/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
> > >>>> -/* 64 */__u8 volume_name[16];   /* volume name */
> > >>>> -/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
> > >>>> -
> > >>>> +/*  4 */__le32 features;        /* (aka. feature_compat) */
> > >>>> +/*  8 */__u8 blkszbits;         /* support block_size == PAGE_SIZE
> > only
> > >>> */
> > >>>> +/*  9 */__u8 reserved;
> > >>>> +
> > >>>> +/* 10 */__le16 root_nid;
> > >>>> +/* 12 */__le64 inos;            /* total valid ino # (== f_files -
> > >>> f_favail) */
> > >>>> +/* 20 */__le64 build_time;      /* inode v1 time derivation */
> > >>>> +/* 28 */__le32 build_time_nsec;
> > >>>> +/* 32 */__le32 blocks;          /* used for statfs */
> > >>>> +/* 36 */__le32 meta_blkaddr;
> > >>>> +/* 40 */__le32 xattr_blkaddr;
> > >>>> +/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
> > >>>> +/* 60 */__u8 volume_name[16];   /* volume name */
> > >>>> +/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
> > >>>> +/* 80 */__le32 checksum;        /* crc32c(super_block) */
> > >>>>  /* 84 */__u8 reserved2[44];
> > >>>
> > >>> Why modifying the above?
> > >>>
> > >>>>  } __packed;                     /* 128 bytes */
> > >>>>
> > >>>> diff --git a/mkfs/main.c b/mkfs/main.c
> > >>>> index f127fe1..26e14a3 100644
> > >>>> --- a/mkfs/main.c
> > >>>> +++ b/mkfs/main.c
> > >>>> @@ -13,12 +13,14 @@
> > >>>>  #include <limits.h>
> > >>>>  #include <libgen.h>
> > >>>>  #include <sys/stat.h>
> > >>>> +#include <zlib.h>
> > >>>
> > >>> I have no idea that we should introduce "zlib" just for crc32c
> > currently...
> > >>> Maybe we can add some independent crc32 function..
> > >>>
> > >>> Thanks,
> > >>> Gao Xiang
> > >>>
> > >>>>  #include "erofs/config.h"
> > >>>>  #include "erofs/print.h"
> > >>>>  #include "erofs/cache.h"
> > >>>>  #include "erofs/inode.h"
> > >>>>  #include "erofs/io.h"
> > >>>>  #include "erofs/compress.h"
> > >>>> +#include "erofs/defs.h"
> > >>>>
> > >>>>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
> > >>> erofs_super_block))
> > >>>>
> > >>>> @@ -31,6 +33,28 @@ static void usage(void)
> > >>>>       fprintf(stderr, " -EX[,...] X=extended options\n");
> > >>>>  }
> > >>>>
> > >>>> +char *feature_opts[] = {
> > >>>> +     "sb_cksum", NULL
> > >>>> +};
> > >>>> +#define O_SB_CKSUM   0
> > >>>> +
> > >>>> +static int parse_feature_subopts(char *opts)
> > >>>> +{
> > >>>> +     char *arg;
> > >>>> +
> > >>>> +     while (*opts != '\0') {
> > >>>> +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > >>>> +             case O_SB_CKSUM:
> > >>>> +                     cfg.c_feature_flags |= EROFS_FEATURE_SB_CHKSUM;
> > >>>> +                     break;
> > >>>> +             default:
> > >>>> +                     erofs_err("incorrect suboption");
> > >>>> +                     return -EINVAL;
> > >>>> +             }
> > >>>> +     }
> > >>>> +     return 0;
> > >>>> +}
> > >>>> +
> > >>>>  static int parse_extended_opts(const char *opts)
> > >>>>  {
> > >>>>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > >>>> @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char
> > >>> *argv[])
> > >>>>  {
> > >>>>       int opt, i;
> > >>>>
> > >>>> -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > >>>> +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> > >>>>               switch (opt) {
> > >>>>               case 'z':
> > >>>>                       if (!optarg) {
> > >>>> @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char
> > >>> *argv[])
> > >>>>                               return opt;
> > >>>>                       break;
> > >>>>
> > >>>> +             case 'o':
> > >>>> +                     opt = parse_feature_subopts(optarg);
> > >>>> +                     if (opt)
> > >>>> +                             return opt;
> > >>>> +                     break;
> > >>>> +
> > >>>>               default: /* '?' */
> > >>>>                       return -EINVAL;
> > >>>>               }
> > >>>> @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char
> > >>> *argv[])
> > >>>>       return 0;
> > >>>>  }
> > >>>>
> > >>>> +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > >>>> +{
> > >>>> +     int offset;
> > >>>> +     u32 crc;
> > >>>> +
> > >>>> +     offset = offsetof(struct erofs_super_block, checksum);
> > >>>> +     if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
> > >>>> +             erofs_err("Invalid offset of checksum field: %d",
> > offset);
> > >>>> +             return -1;
> > >>>> +     }
> > >>>> +     crc = crc32(~0, (const unsigned char *)sb,(size_t)offset);
> > >>>> +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > >>>> +     return 0;
> > >>>> +}
> > >>>> +
> > >>>>  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> > >>>>                                 erofs_nid_t root_nid)
> > >>>>  {
> > >>>> @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct
> > >>> erofs_buffer_head *bh,
> > >>>>               .meta_blkaddr  = sbi.meta_blkaddr,
> > >>>>               .xattr_blkaddr = 0,
> > >>>>               .requirements = cpu_to_le32(sbi.requirements),
> > >>>> +             .features = cpu_to_le32(cfg.c_feature_flags),
> > >>>>       };
> > >>>>       const unsigned int sb_blksize =
> > >>>>               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > >>>> @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct
> > >>> erofs_buffer_head *bh,
> > >>>>       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> > >>>>       sb.root_nid     = cpu_to_le16(root_nid);
> > >>>>
> > >>>> +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > >>>> +             u32 crc = erofs_superblock_checksum(&sb);
> > >>>> +             sb.checksum = cpu_to_le32(crc);
> > >>>> +     }
> > >>>> +
> > >>>>       buf = calloc(sb_blksize, 1);
> > >>>>       if (!buf) {
> > >>>>               erofs_err("Failed to allocate memory for sb: %s",
> > >>>> --
> > >>>> 2.9.3
> > >>>>
> > >>>
> >
