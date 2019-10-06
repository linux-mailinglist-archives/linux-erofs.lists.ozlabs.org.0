Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E62CCED0
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 07:40:07 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46mC9w3xWPzDqS0
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 16:40:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570340404;
	bh=YpsdklCbOAxhow8VSINf8oelFs4uv4xbEmT2lEPKb8o=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KlowUryis6tK/IulK31y6RyiQYvg1ccu9NrvwEXHggLk5M1eJ8SVv5aOD9nn2C6O2
	 inVcT3vkUVJUHOQ2b5wyMN4QnXhDnTLgsLkbVHRF+o9KMwR7TdJLzNv5tWmW5UV2gl
	 aw0EvAHW9P5w/ILF5iHvlY8vftsfRMdlTxzh15mGva5+m9QQa1Tj3vTQ7+QsP6cuS9
	 kVkdAlf/iHvaZ8R2aIc5LSagdP1FPOj3M3mKc/gGvELDc0Zc/s/va/2L664X/fLs/f
	 b7Vj3wNNgflVfSxvYM/2uqAzS22dYmC5kiNUUThjqfBiCMpQ0B2ZpmI3+Bg+gYlT5/
	 RbC1PK4bhos9A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.81; helo=sonic305-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="kZBJKgdO"; 
 dkim-atps=neutral
Received: from sonic305-19.consmr.mail.ir2.yahoo.com
 (sonic305-19.consmr.mail.ir2.yahoo.com [77.238.177.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46mC9k0Cs5zDqQt
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 16:39:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570340383; bh=twDQM0qdczKsbOF/K3XYv//IVT9mhSuGU5t0oDUoWO4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=kZBJKgdOkNPyYKgIzuCgU0zCueJXkFlb0D2jWmsHaa26pmtGHY6Kmqehxfup9kCeKCUuAwYUZVAwTK2dUTGWR06osMEmDpeIZbYPjUXKxU9M6ut0Ft+zSVjBTfbgf8MTywyi2NJBRPMPMsXaMgRp75u1jyWVIKsQjQPERPlzjoAhS2vGti22ultMtL2gdq9YxI8TLAEdiTEPxzJRyKvXgz+AKrlI/PGUH8lkF3I9cXTUuYAgxKGTDXH0hB+GjkzxLLo36N8WWyEORxB+z+bE4T0GDG6MrHpsg63l5oo9o7gBfj3nrnyCK04/X1CebJEMsrGesyIxDYd8xBgRMGF8vQ==
X-YMail-OSG: 6rDRLycVM1my6_HOjMyV_1842_bFkFcBuU2_C_Zmm2ZLgkxkojGDLTOvJBxbFVd
 5p0.s3AhgHbwfiI8ErI0.gfFZiaM2_s5fcW9p4tH.MfFGlnFV1plbf1rEpHsLb08ABDZ71vEcauY
 BkDccn1kZ60Uo9tgSWaCv7sgmwWslPfuU2oYV0pZC955mnoC1beNvKcoyxAyNMneJ_rXemsUS0xX
 KwBVBFQ_B3nFxmmL8mWhCqOschWoGDsd.whlQ0uadbbaVRnXn_UPjkcg4NKCEhiB3ivFvx2ZXma4
 dPBZzDly7YCc.y4yD_MmWR32Eu1l3j54T3fTdqLzErQ5tUvpsURK9ycc.EHASgxgkbmeyXoN6mj7
 bTIsUlSR1I84BFwCWJbM4cYsAQ.VAafTjK3aiFrSajop86_yDxpodX.vpBSz0l42iNvZSqeusWov
 H7te.fa75NhuZDTwSrgblkUGuXgwJXnUaOFXjr14twSdE2s2J5SwrOrrUbkd9twqqf7AWNqGBp8Y
 dy5taVnIvcMXu6JQRtw9MR7dod1m1x9patX9DhaEZajDdDsXg8WcHP0GMy0158yIgDn5.WaGxNFD
 O48o5bumBsTFGgUB2_pRNtC2qZv9mh1EUTU3ZoT.qKf8qGai_x4KOEZyha2l.xVii7jy5Tz2WxXy
 fg3QjFyaX0vXIWoX_UzC.UhQTOEj9mAK1gNigNTXN7nuBe_vaKjoQeZyBMMH5mqi4Yf6p2cAgEyt
 oFegjdbkplyXfBwUDW5nx_v0d0_wNeZbGuNnEwyBEzGTsjidTEcjC8rJl3i.OpmQmKYhMotSLKf5
 duJ9ju2qrbakPESLN3nQy_xCsSjMgxUG3yLO0qUdgYayqcr2FNBiUuAS9xnsoqe0dkRdl_yrelEz
 jT1fVAEa2lA0b6XJWOuRkUso1ev5ZvXxilqWSgYc6HOVkiBv0TOKneXcutzuh.MjE0paz7dRYbaF
 7FOC6lRUzlY7ipTqWUE.zQP01XZkci2QHIb2RDwGHWj_qcosqpKfFt9uaKw0I5zC7kwX0HN1wJyj
 2NkaVqAwechSCWIVjwIQCGTCaota4cHUhOTnaNZ8kpyaQe3w4FNYfAJluqkipM7gJcVer78R83oI
 uJdnZDCpjTFC9zjz5B4lODX.E9tyHDyQSnzzNzyDIkp.pl2roMfKv6vPxc3WcO6QT7f9BHl62tpZ
 BCVDVX_OWwGOzutcIESy9FmiKuQqlSlSGtcvDZf_TPCT121iY8Q7RaIYsLk5WP1W8q3kkW9eFWvi
 6y8OgVV45rNU9LpBX2GfA1eozG479j.rUMNCWy_GEjU3DKr3r7EmQd6N0aGMGV2JOswY9GOB4MKO
 Os4Ex
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 6 Oct 2019 05:39:43 +0000
Received: by smtp418.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a956a5cf6cfec4cb85bf31e275ab9bfc; 
 Sun, 06 Oct 2019 05:39:42 +0000 (UTC)
Date: Sun, 6 Oct 2019 13:39:33 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20191006053914.GA25306@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
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

Hi Pratik,

On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> I completely understand your concern.You can drop this patch for now.
> Once erofs makes it 'fs/' please do reconsider implementing it.

I think we can work on this pending feature for v5.5 now.
My idea is to add an extra field in erofs_super_block to
indicate the number of blocks (4k) for checking.

So for small images, this feature can checksum the whole image at mount time,
and for large images, this feature can be used to checksum the super block only
(and then use verficiation subsystem to verify on-the-fly in the future...)

The following workflow is for erofs-utils, I think it's
 1) erofs_mkfs_update_super_block with checksum = 0
 2) erofs_bflush(NULL)
 3) reread the corresponding blocks and calculate checksum;
 4) write checksum to erofs_super_block;

Does it sound reasonable? and do you still have interest and
time for this? Looking forword to your reply...

Thanks,
Gao Xiang

> 
> One more thing, can we still send non feature patches?
> 
> --Pratik
> 
> 
> On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > > Adding code for superblock checksum calculation.
> > >
> > > incorporated the changes suggested in previous patch.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> >
> > Thanks for your v2 patch.
> >
> > Actually, I have some concern about the length of checksum,
> > sizeof(struct erofs_super_block) could be changed in the
> > later version, it's bad for EROFS future scalablity.
> >
> > And I tend not to add another on-disk field to record
> > the size of erofs_super_block as well, because the old
> > Linux kernel cannot handle more about the new size,
> > so it has little use except for checksum calculation.
> >
> > Few hours ago, I discussed with Chao about this concern,
> > I think this feature can be changed to do multiple-block
> > checksum at the mount time, e.g:
> >  - for small images, we can check the whole image once
> >    at the mount time;
> >  - for the large image, we can check the superblock
> >    at the mount time, the rest can be handled by
> >    block-based verification layer.
> >
> > But we agreed that don't add this for this round
> > since it's quite a new feature.
> >
> > All in all, it's a new feature since we are addressing moving
> > out of staging for this round. I tend to postpone this feature
> > for now. I understand that you are very interested in EROFS.
> > Considering EROFS current staging status, it's not such a place
> > to add new features at all! I have marked your patch down and
> > I will work with you later. Hope to get your understanding...
> >
> > Thanks,
> > Gao Xiang
> >
> > > ---
> > >  include/erofs/config.h |  1 +
> > >  include/erofs_fs.h     | 10 ++++++++
> > >  mkfs/main.c            | 64
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  3 files changed, 74 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > > index 05fe6b2..40cd466 100644
> > > --- a/include/erofs/config.h
> > > +++ b/include/erofs/config.h
> > > @@ -22,6 +22,7 @@ struct erofs_configure {
> > >       char *c_src_path;
> > >       char *c_compr_alg_master;
> > >       int c_compr_level_master;
> > > +     int c_feature_flags;
> > >  };
> > >
> > >  extern struct erofs_configure cfg;
> > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > index 601b477..9ac2635 100644
> > > --- a/include/erofs_fs.h
> > > +++ b/include/erofs_fs.h
> > > @@ -20,6 +20,16 @@
> > >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> > >  #define EROFS_ALL_REQUIREMENTS
> >  EROFS_REQUIREMENT_LZ4_0PADDING
> > >
> > > +/*
> > > + * feature definations.
> > > + */
> > > +#define EROFS_DEFAULT_FEATURES               EROFS_FEATURE_SB_CHKSUM
> > > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > > +
> > > +
> > > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > > +     ( le32_to_cpu((super)->features) & (mask) )
> > > +
> > >  struct erofs_super_block {
> > >  /*  0 */__le32 magic;           /* in the little endian */
> > >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index f127fe1..355fd2c 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -31,6 +31,45 @@ static void usage(void)
> > >       fprintf(stderr, " -EX[,...] X=extended options\n");
> > >  }
> > >
> > > +#define CRCPOLY      0x82F63B78
> > > +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> > > +{
> > > +     int i;
> > > +     u32 crc = seed;
> > > +
> > > +     while (len--) {
> > > +             crc ^= *in++;
> > > +             for (i = 0; i < 8; i++) {
> > > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> > > +             }
> > > +     }
> > > +     erofs_dump("calculated crc: 0x%x\n", crc);
> > > +     return crc;
> > > +}
> > > +
> > > +char *feature_opts[] = {
> > > +     "nosbcrc", NULL
> > > +};
> > > +#define O_SB_CKSUM   0
> > > +
> > > +static int parse_feature_subopts(char *opts)
> > > +{
> > > +     char *arg;
> > > +
> > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > +     while (*opts != '\0') {
> > > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > > +             case O_SB_CKSUM:
> > > +                     cfg.c_feature_flags |= (~EROFS_FEATURE_SB_CHKSUM);
> > > +                     break;
> > > +             default:
> > > +                     erofs_err("incorrect suboption");
> > > +                     return -EINVAL;
> > > +             }
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  static int parse_extended_opts(const char *opts)
> > >  {
> > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char
> > *argv[])
> > >  {
> > >       int opt, i;
> > >
> > > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> > >               switch (opt) {
> > >               case 'z':
> > >                       if (!optarg) {
> > > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char
> > *argv[])
> > >                               return opt;
> > >                       break;
> > >
> > > +             case 'O':
> > > +                     opt = parse_feature_subopts(optarg);
> > > +                     if (opt)
> > > +                             return opt;
> > > +                     break;
> > > +
> > >               default: /* '?' */
> > >                       return -EINVAL;
> > >               }
> > > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char
> > *argv[])
> > >       return 0;
> > >  }
> > >
> > > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > > +{
> > > +     u32 crc;
> > > +     crc = crc32c(~0, (const unsigned char *)sb,
> > > +                 sizeof(struct erofs_super_block));
> > > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > > +     return crc;
> > > +}
> > > +
> > >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> > >                                 erofs_nid_t root_nid)
> > >  {
> > > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct
> > erofs_buffer_head *bh,
> > >               .meta_blkaddr  = sbi.meta_blkaddr,
> > >               .xattr_blkaddr = 0,
> > >               .requirements = cpu_to_le32(sbi.requirements),
> > > +             .features = cpu_to_le32(cfg.c_feature_flags),
> > >       };
> > >       const unsigned int sb_blksize =
> > >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct
> > erofs_buffer_head *bh,
> > >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> > >       sb.root_nid     = cpu_to_le16(root_nid);
> > >
> > > +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > > +             sb.checksum = 0;
> > > +             u32 crc = erofs_superblock_checksum(&sb);
> > > +             sb.checksum = cpu_to_le32(crc);
> > > +     }
> > > +
> > >       buf = calloc(sb_blksize, 1);
> > >       if (!buf) {
> > >               erofs_err("Failed to allocate memory for sb: %s",
> > > --
> > > 2.9.3
> > >
> >
