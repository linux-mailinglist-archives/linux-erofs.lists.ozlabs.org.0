Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 26885D07AE
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 08:54:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46p4hZ2sfWzDqKr
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 17:54:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46p4hS6vqBzDqJk
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2019 17:54:30 +1100 (AEDT)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 944FB54EF14B64FA65E4;
 Wed,  9 Oct 2019 14:54:25 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 9 Oct 2019 14:54:24 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 9 Oct 2019 14:54:24 +0800
Date: Wed, 9 Oct 2019 14:57:31 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20191009065728.GA118670@architecture4>
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
 <20191006053914.GA25306@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czStB-4eraf_b-YvzzF_2E=c3bBvK0DGc031M=vyvLaeWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czStB-4eraf_b-YvzzF_2E=c3bBvK0DGc031M=vyvLaeWQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
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

On Wed, Oct 09, 2019 at 11:59:01AM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> Yes I can work on it. Sorry I missed this mail. I think your approach is
> good. Let me go through it one more time and reply back.

Thanks for your reply and interest :)
I think we can complete all pending features together
if you have some time on this stuff. (fsdebug utility is
on the way as well...)

BTW, I'm now investigating new high CR algorithm (very likely
XZ) as well, it will be likely a RFC version in this round for
wider scenarios and later decompression subsystem.

Preliminary TODO lists will be discussed in this year China
Linux Storage & Filesystem workshop (next week) and will be
posted to mailing lists for further wider discussion (if more
folks have interest in developing it) as well. :)

Thanks,
Gao Xiang

> 
> --Pratik
> 
> On Sun, 6 Oct, 2019, 11:09 AM Gao Xiang, <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:
> > > Hi Gao,
> > >
> > > I completely understand your concern.You can drop this patch for now.
> > > Once erofs makes it 'fs/' please do reconsider implementing it.
> >
> > I think we can work on this pending feature for v5.5 now.
> > My idea is to add an extra field in erofs_super_block to
> > indicate the number of blocks (4k) for checking.
> >
> > So for small images, this feature can checksum the whole image at mount
> > time,
> > and for large images, this feature can be used to checksum the super block
> > only
> > (and then use verficiation subsystem to verify on-the-fly in the future...)
> >
> > The following workflow is for erofs-utils, I think it's
> >  1) erofs_mkfs_update_super_block with checksum = 0
> >  2) erofs_bflush(NULL)
> >  3) reread the corresponding blocks and calculate checksum;
> >  4) write checksum to erofs_super_block;
> >
> > Does it sound reasonable? and do you still have interest and
> > time for this? Looking forword to your reply...
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > One more thing, can we still send non feature patches?
> > >
> > > --Pratik
> > >
> > >
> > > On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, <hsiangkao@aol.com> wrote:
> > >
> > > > Hi Pratik,
> > > >
> > > > On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > > > > Adding code for superblock checksum calculation.
> > > > >
> > > > > incorporated the changes suggested in previous patch.
> > > > >
> > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > >
> > > > Thanks for your v2 patch.
> > > >
> > > > Actually, I have some concern about the length of checksum,
> > > > sizeof(struct erofs_super_block) could be changed in the
> > > > later version, it's bad for EROFS future scalablity.
> > > >
> > > > And I tend not to add another on-disk field to record
> > > > the size of erofs_super_block as well, because the old
> > > > Linux kernel cannot handle more about the new size,
> > > > so it has little use except for checksum calculation.
> > > >
> > > > Few hours ago, I discussed with Chao about this concern,
> > > > I think this feature can be changed to do multiple-block
> > > > checksum at the mount time, e.g:
> > > >  - for small images, we can check the whole image once
> > > >    at the mount time;
> > > >  - for the large image, we can check the superblock
> > > >    at the mount time, the rest can be handled by
> > > >    block-based verification layer.
> > > >
> > > > But we agreed that don't add this for this round
> > > > since it's quite a new feature.
> > > >
> > > > All in all, it's a new feature since we are addressing moving
> > > > out of staging for this round. I tend to postpone this feature
> > > > for now. I understand that you are very interested in EROFS.
> > > > Considering EROFS current staging status, it's not such a place
> > > > to add new features at all! I have marked your patch down and
> > > > I will work with you later. Hope to get your understanding...
> > > >
> > > > Thanks,
> > > > Gao Xiang
> > > >
> > > > > ---
> > > > >  include/erofs/config.h |  1 +
> > > > >  include/erofs_fs.h     | 10 ++++++++
> > > > >  mkfs/main.c            | 64
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  3 files changed, 74 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > > > > index 05fe6b2..40cd466 100644
> > > > > --- a/include/erofs/config.h
> > > > > +++ b/include/erofs/config.h
> > > > > @@ -22,6 +22,7 @@ struct erofs_configure {
> > > > >       char *c_src_path;
> > > > >       char *c_compr_alg_master;
> > > > >       int c_compr_level_master;
> > > > > +     int c_feature_flags;
> > > > >  };
> > > > >
> > > > >  extern struct erofs_configure cfg;
> > > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > > index 601b477..9ac2635 100644
> > > > > --- a/include/erofs_fs.h
> > > > > +++ b/include/erofs_fs.h
> > > > > @@ -20,6 +20,16 @@
> > > > >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> > > > >  #define EROFS_ALL_REQUIREMENTS
> > > >  EROFS_REQUIREMENT_LZ4_0PADDING
> > > > >
> > > > > +/*
> > > > > + * feature definations.
> > > > > + */
> > > > > +#define EROFS_DEFAULT_FEATURES               EROFS_FEATURE_SB_CHKSUM
> > > > > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > > > > +
> > > > > +
> > > > > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > > > > +     ( le32_to_cpu((super)->features) & (mask) )
> > > > > +
> > > > >  struct erofs_super_block {
> > > > >  /*  0 */__le32 magic;           /* in the little endian */
> > > > >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > index f127fe1..355fd2c 100644
> > > > > --- a/mkfs/main.c
> > > > > +++ b/mkfs/main.c
> > > > > @@ -31,6 +31,45 @@ static void usage(void)
> > > > >       fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > >  }
> > > > >
> > > > > +#define CRCPOLY      0x82F63B78
> > > > > +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t
> > len)
> > > > > +{
> > > > > +     int i;
> > > > > +     u32 crc = seed;
> > > > > +
> > > > > +     while (len--) {
> > > > > +             crc ^= *in++;
> > > > > +             for (i = 0; i < 8; i++) {
> > > > > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> > > > > +             }
> > > > > +     }
> > > > > +     erofs_dump("calculated crc: 0x%x\n", crc);
> > > > > +     return crc;
> > > > > +}
> > > > > +
> > > > > +char *feature_opts[] = {
> > > > > +     "nosbcrc", NULL
> > > > > +};
> > > > > +#define O_SB_CKSUM   0
> > > > > +
> > > > > +static int parse_feature_subopts(char *opts)
> > > > > +{
> > > > > +     char *arg;
> > > > > +
> > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > +     while (*opts != '\0') {
> > > > > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > > > > +             case O_SB_CKSUM:
> > > > > +                     cfg.c_feature_flags |=
> > (~EROFS_FEATURE_SB_CHKSUM);
> > > > > +                     break;
> > > > > +             default:
> > > > > +                     erofs_err("incorrect suboption");
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >  static int parse_extended_opts(const char *opts)
> > > > >  {
> > > > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char
> > > > *argv[])
> > > > >  {
> > > > >       int opt, i;
> > > > >
> > > > > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> > > > >               switch (opt) {
> > > > >               case 'z':
> > > > >                       if (!optarg) {
> > > > > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char
> > > > *argv[])
> > > > >                               return opt;
> > > > >                       break;
> > > > >
> > > > > +             case 'O':
> > > > > +                     opt = parse_feature_subopts(optarg);
> > > > > +                     if (opt)
> > > > > +                             return opt;
> > > > > +                     break;
> > > > > +
> > > > >               default: /* '?' */
> > > > >                       return -EINVAL;
> > > > >               }
> > > > > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char
> > > > *argv[])
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > > > > +{
> > > > > +     u32 crc;
> > > > > +     crc = crc32c(~0, (const unsigned char *)sb,
> > > > > +                 sizeof(struct erofs_super_block));
> > > > > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > > > > +     return crc;
> > > > > +}
> > > > > +
> > > > >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> > > > >                                 erofs_nid_t root_nid)
> > > > >  {
> > > > > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct
> > > > erofs_buffer_head *bh,
> > > > >               .meta_blkaddr  = sbi.meta_blkaddr,
> > > > >               .xattr_blkaddr = 0,
> > > > >               .requirements = cpu_to_le32(sbi.requirements),
> > > > > +             .features = cpu_to_le32(cfg.c_feature_flags),
> > > > >       };
> > > > >       const unsigned int sb_blksize =
> > > > >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > > > > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct
> > > > erofs_buffer_head *bh,
> > > > >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> > > > >       sb.root_nid     = cpu_to_le16(root_nid);
> > > > >
> > > > > +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > > > > +             sb.checksum = 0;
> > > > > +             u32 crc = erofs_superblock_checksum(&sb);
> > > > > +             sb.checksum = cpu_to_le32(crc);
> > > > > +     }
> > > > > +
> > > > >       buf = calloc(sb_blksize, 1);
> > > > >       if (!buf) {
> > > > >               erofs_err("Failed to allocate memory for sb: %s",
> > > > > --
> > > > > 2.9.3
> > > > >
> > > >
> >
