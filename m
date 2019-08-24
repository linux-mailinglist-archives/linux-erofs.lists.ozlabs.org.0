Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7611E9BCE9
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 12:01:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Fv1S2SNlzDrqc
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 20:01:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=chao@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rsQ3c7fv"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Fv1K2B7PzDrSd
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 20:01:24 +1000 (AEST)
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8577820870
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566640882;
 bh=+8BgyLaMYU208sgYXsFS2T18URIDP8wUTYdVX3AII1s=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=rsQ3c7fvcmrPe9bLO36ir8uDgf+aoOUKty+mk9iXjEoMsPJ3eRJPTwUUzb5BfLIjg
 KkjELj1HYjP2jAx7pndvh6gXUUh4RPw2fspTE28+fxmmxkcRwdLa/T4hJNrK4uR5Vm
 5J+iq+cyjFUc7Y2F+WjMNWrl3O4nII6pfg3btVmg=
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
To: linux-erofs@lists.ozlabs.org
References: <20190824074158.16254-1-pratikshinde320@gmail.com>
 <20190824084629.GA16016@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czQ2kP-z-T-P67CeBxdCnLBVmKtW6h8eOnrEY+FEQTiwSQ@mail.gmail.com>
 <20190824094921.GA18623@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Chao Yu <chao@kernel.org>
Message-ID: <5297cdca-464a-7d52-b69a-96688aa52725@kernel.org>
Date: Sat, 24 Aug 2019 18:01:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190824094921.GA18623@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019-8-24 17:49, Gao Xiang via Linux-erofs wrote:
> Hi Pratik,
> 
> On Sat, Aug 24, 2019 at 02:52:31PM +0530, Pratik Shinde wrote:
>> Hi Gao,
>> Yes I will make the suboption naming similar to that of mk2fs.
> 
> Great! :)
> 
>>
>> The reason I changed the position of 'checksum' field :
>>
>> Since we are calculating the checksum of erofs_super_block structure and
>> storing it in the same structure; we cannot include
>> this field for actual crc calculations. Keeping it at the end makes it easy
>> for me to calculate length of the data of which
>> checksum needs to be calculated. I saw similar logic in other filesystems
>> like ext4.
> 
> No, that is just they didn't add checksum field at the beginning of its design.
> I think you can leave chksum to 0, and calculate chksum and fill it, to be specfic:
> 
> In the erofs-utils,
>  1) fill .checksum to 0;
>  2) calculate crc32c of the entire erofs_super_block;
>  3) fill the real checksum to .checksum;
> 
> In the kernel,
>  1) read .checksum to a variable;
>  2) fill .checksum to 0;
>  3) calculate crc32c of the entire erofs_super_block;
>  4) compare the given one and the calculated one;

That's one way, FYI, the way used in ext4/f2fs now is:
- calc [0, checksum]'s chksum
- use above chksum as seed of chksum within range [chksum + chksum_size, end]
- fill chksum value in range [checksum, chksum + chksum_size]

Thanks,

> 
> That is all :)
> 
>>
>> We can write our own crc32() function. :) There is no problem. I thought
>> zlib already provides one & we can use it.
> 
> I think we can use crc32c() since I already wrote comments for erofs in 4.19.
> 
> Looking forward to your next version :)
> 
> Thanks,
> Gao Xiang
> 
>> anyways , I will write.
>>
>> --Pratik.
>>
>> On Sat, Aug 24, 2019 at 2:16 PM Gao Xiang <hsiangkao@gmx.com> wrote:
>>
>>> Hi Pratik,
>>>
>>> On Sat, Aug 24, 2019 at 01:11:58PM +0530, Pratik Shinde wrote:
>>>> Adding code for superblock checksum calculation.
>>>>
>>>> This patch adds following things:
>>>> 1)Handle suboptions('-o') to mkfs utility.
>>>
>>> Thanks for your patch. :)
>>>
>>> Can we use "-O feature" instead in order to keep in line with mke2fs?
>>>
>>>> 2)Add superblock checksum calculation(-o sb_cksum) as suboption.
>>>
>>> ditto. and I think we can enable sbcrc by default since it is a compat
>>> feature,
>>> and add "-O nosbcrc" to disable it.
>>>
>>>> 3)Calculate superblock checksum if feature is enabled.
>>>>
>>>> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>>>
>>> And could you please also read my following comments and fix them.
>>> and I'd like to accept your erofs-utils modification in advance. :)
>>>
>>>
>>> But now you can see we are moving EROFS out of staging now as
>>> the "real" part of Linux, this is the fundamental stuff of other
>>> new features if we want to develop more actively... So we can wait
>>> for the final result and add this new feature to kernel then...
>>>
>>>> ---
>>>>  include/erofs/config.h |  1 +
>>>>  include/erofs_fs.h     | 40 +++++++++++++++++++++----------------
>>>>  mkfs/main.c            | 53
>>> +++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>  3 files changed, 76 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/include/erofs/config.h b/include/erofs/config.h
>>>> index 05fe6b2..40cd466 100644
>>>> --- a/include/erofs/config.h
>>>> +++ b/include/erofs/config.h
>>>> @@ -22,6 +22,7 @@ struct erofs_configure {
>>>>       char *c_src_path;
>>>>       char *c_compr_alg_master;
>>>>       int c_compr_level_master;
>>>> +     int c_feature_flags;
>>>
>>> we can add this to sbi like requirements...
>>>
>>>>  };
>>>>
>>>>  extern struct erofs_configure cfg;
>>>> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
>>>> index 601b477..c9ef057 100644
>>>> --- a/include/erofs_fs.h
>>>> +++ b/include/erofs_fs.h
>>>> @@ -20,25 +20,31 @@
>>>>  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
>>>>  #define EROFS_ALL_REQUIREMENTS
>>>  EROFS_REQUIREMENT_LZ4_0PADDING
>>>>
>>>> +/*
>>>> + * feature definations.
>>>> + */
>>>> +#define EROFS_FEATURE_SB_CHKSUM              0x0001
>>>> +
>>>> +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
>>>> +     ( le32_to_cpu((super)->features) & (mask) )
>>>> +
>>>>  struct erofs_super_block {
>>>>  /*  0 */__le32 magic;           /* in the little endian */
>>>> -/*  4 */__le32 checksum;        /* crc32c(super_block) */
>>>> -/*  8 */__le32 features;        /* (aka. feature_compat) */
>>>> -/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only
>>> */
>>>> -/* 13 */__u8 reserved;
>>>> -
>>>> -/* 14 */__le16 root_nid;
>>>> -/* 16 */__le64 inos;            /* total valid ino # (== f_files -
>>> f_favail) */
>>>> -
>>>> -/* 24 */__le64 build_time;      /* inode v1 time derivation */
>>>> -/* 32 */__le32 build_time_nsec;
>>>> -/* 36 */__le32 blocks;          /* used for statfs */
>>>> -/* 40 */__le32 meta_blkaddr;
>>>> -/* 44 */__le32 xattr_blkaddr;
>>>> -/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
>>>> -/* 64 */__u8 volume_name[16];   /* volume name */
>>>> -/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
>>>> -
>>>> +/*  4 */__le32 features;        /* (aka. feature_compat) */
>>>> +/*  8 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only
>>> */
>>>> +/*  9 */__u8 reserved;
>>>> +
>>>> +/* 10 */__le16 root_nid;
>>>> +/* 12 */__le64 inos;            /* total valid ino # (== f_files -
>>> f_favail) */
>>>> +/* 20 */__le64 build_time;      /* inode v1 time derivation */
>>>> +/* 28 */__le32 build_time_nsec;
>>>> +/* 32 */__le32 blocks;          /* used for statfs */
>>>> +/* 36 */__le32 meta_blkaddr;
>>>> +/* 40 */__le32 xattr_blkaddr;
>>>> +/* 44 */__u8 uuid[16];          /* 128-bit uuid for volume */
>>>> +/* 60 */__u8 volume_name[16];   /* volume name */
>>>> +/* 76 */__le32 requirements;    /* (aka. feature_incompat) */
>>>> +/* 80 */__le32 checksum;        /* crc32c(super_block) */
>>>>  /* 84 */__u8 reserved2[44];
>>>
>>> Why modifying the above?
>>>
>>>>  } __packed;                     /* 128 bytes */
>>>>
>>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>>> index f127fe1..26e14a3 100644
>>>> --- a/mkfs/main.c
>>>> +++ b/mkfs/main.c
>>>> @@ -13,12 +13,14 @@
>>>>  #include <limits.h>
>>>>  #include <libgen.h>
>>>>  #include <sys/stat.h>
>>>> +#include <zlib.h>
>>>
>>> I have no idea that we should introduce "zlib" just for crc32c currently...
>>> Maybe we can add some independent crc32 function..
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>>  #include "erofs/config.h"
>>>>  #include "erofs/print.h"
>>>>  #include "erofs/cache.h"
>>>>  #include "erofs/inode.h"
>>>>  #include "erofs/io.h"
>>>>  #include "erofs/compress.h"
>>>> +#include "erofs/defs.h"
>>>>
>>>>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
>>> erofs_super_block))
>>>>
>>>> @@ -31,6 +33,28 @@ static void usage(void)
>>>>       fprintf(stderr, " -EX[,...] X=extended options\n");
>>>>  }
>>>>
>>>> +char *feature_opts[] = {
>>>> +     "sb_cksum", NULL
>>>> +};
>>>> +#define O_SB_CKSUM   0
>>>> +
>>>> +static int parse_feature_subopts(char *opts)
>>>> +{
>>>> +     char *arg;
>>>> +
>>>> +     while (*opts != '\0') {
>>>> +             switch(getsubopt(&opts, feature_opts, &arg)) {
>>>> +             case O_SB_CKSUM:
>>>> +                     cfg.c_feature_flags |= EROFS_FEATURE_SB_CHKSUM;
>>>> +                     break;
>>>> +             default:
>>>> +                     erofs_err("incorrect suboption");
>>>> +                     return -EINVAL;
>>>> +             }
>>>> +     }
>>>> +     return 0;
>>>> +}
>>>> +
>>>>  static int parse_extended_opts(const char *opts)
>>>>  {
>>>>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
>>>> @@ -79,7 +103,7 @@ static int mkfs_parse_options_cfg(int argc, char
>>> *argv[])
>>>>  {
>>>>       int opt, i;
>>>>
>>>> -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
>>>> +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
>>>>               switch (opt) {
>>>>               case 'z':
>>>>                       if (!optarg) {
>>>> @@ -113,6 +137,12 @@ static int mkfs_parse_options_cfg(int argc, char
>>> *argv[])
>>>>                               return opt;
>>>>                       break;
>>>>
>>>> +             case 'o':
>>>> +                     opt = parse_feature_subopts(optarg);
>>>> +                     if (opt)
>>>> +                             return opt;
>>>> +                     break;
>>>> +
>>>>               default: /* '?' */
>>>>                       return -EINVAL;
>>>>               }
>>>> @@ -144,6 +174,21 @@ static int mkfs_parse_options_cfg(int argc, char
>>> *argv[])
>>>>       return 0;
>>>>  }
>>>>
>>>> +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
>>>> +{
>>>> +     int offset;
>>>> +     u32 crc;
>>>> +
>>>> +     offset = offsetof(struct erofs_super_block, checksum);
>>>> +     if (offset < 0 || offset > sizeof(struct erofs_super_block)) {
>>>> +             erofs_err("Invalid offset of checksum field: %d", offset);
>>>> +             return -1;
>>>> +     }
>>>> +     crc = crc32(~0, (const unsigned char *)sb,(size_t)offset);
>>>> +     erofs_dump("superblock checksum: 0x%x\n", crc);
>>>> +     return 0;
>>>> +}
>>>> +
>>>>  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
>>>>                                 erofs_nid_t root_nid)
>>>>  {
>>>> @@ -155,6 +200,7 @@ int erofs_mkfs_update_super_block(struct
>>> erofs_buffer_head *bh,
>>>>               .meta_blkaddr  = sbi.meta_blkaddr,
>>>>               .xattr_blkaddr = 0,
>>>>               .requirements = cpu_to_le32(sbi.requirements),
>>>> +             .features = cpu_to_le32(cfg.c_feature_flags),
>>>>       };
>>>>       const unsigned int sb_blksize =
>>>>               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
>>>> @@ -169,6 +215,11 @@ int erofs_mkfs_update_super_block(struct
>>> erofs_buffer_head *bh,
>>>>       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
>>>>       sb.root_nid     = cpu_to_le16(root_nid);
>>>>
>>>> +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
>>>> +             u32 crc = erofs_superblock_checksum(&sb);
>>>> +             sb.checksum = cpu_to_le32(crc);
>>>> +     }
>>>> +
>>>>       buf = calloc(sb_blksize, 1);
>>>>       if (!buf) {
>>>>               erofs_err("Failed to allocate memory for sb: %s",
>>>> --
>>>> 2.9.3
>>>>
>>>
