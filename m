Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E29BE6D
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 17:16:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46G21H64v9zDrS3
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 01:16:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566659811;
	bh=h0ARHpMhxWYb6sPp6Fm4B2Xyj5la5lahkGAHjt0DhLE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FQrHM9byw8RP8vgFc6RB1FCpdVlEePuHBgx9X6lmRZWaXuKumHYJXGKUObOgd/JN7
	 fzc/ro6gVo3I7h3EkGSKI+9y2LKOEalG0oEae0QzkU7mHNWAO2I8tLYB+CpkRno268
	 Gf4UbmEVkeNLgU+fXk3ZS3pyv4qx9UJULbzucbWkktx9R4x7RAKAq8EtIKC6/x+JBD
	 Jx2zV9vwMx1UKbgUDCT3pQ2C70wVpcrMvWgwH3DLPedBlvqHlD1gzZ5xePkGkA4yHc
	 ESXWi0NQWexuLd25qE4+V3Rrb7t1vMynta9d3IWIe3E7XhRZPRTxmM97IY0zHB/diT
	 TQL9EWkTznhMQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.69.204; helo=sonic312-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="r4N5fSku"; 
 dkim-atps=neutral
Received: from sonic312-23.consmr.mail.gq1.yahoo.com
 (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46G2100S7czDrRr
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2019 01:16:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566659787; bh=dDPQXHh/nveGSuUK2w2+mTi2Dyze3wlhGMKiQPPvgAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=r4N5fSkuu1EDiqlK5p+r60PGrmjgiWTORsytuaB3BZ1WNzFK8ZFkM/5La4RB+DQkqk5dQfbMGGvTg28om2XsK8AqWtjbMDthqZfVhVBlXgQnW/p8Hd4Fr1edXY0jY+f3Jqdq6oPXWRVYWl3+DKJmFx7ILfbiGn1FKDFINAgkDQ94wRk53jGlS1txKrHT7mJNcLAP6xju3QR3QxxfnOpyMNX1yHLPiZLfC9PAZE4I/gzQTJrFR1MPCQhHO3NgqsLbPZ6qVwRyQFHKeVIeXpKPefWMBSxl2qIrBGVdQj4qkCWX0ek6NtO38azmB77tee0S62GOjUfPsTv8MqWqrOgHtA==
X-YMail-OSG: XH5lngoVM1kdKpp3A8yLpY.N_LS7Cb0o5tyxH2hQcPl1XxI4dZ2wCFvFsswL.PU
 okjtAChEcguJHh4iDzR3uPKDFwTXgP7oY6ThwT6o_tKlMUtdBQzaQz5Pue0dLPb4TIPthArHaor2
 gav3i61vXVTqW4XWfUlLgEfhdlS7djQdTWKELcaYzm7_xXWd9Zm8S2Fo8xReUL4xDpzPYmOHRaXp
 rwTTzHqB71L1RJqyjNP5xXf3bMHXYSyUEjJTY_R4Jhaso9zUCnXus.ogqLgC6h7hcA9HliAMJvv3
 iDIpshFqAQk3nJQ93Pb1jmWdh2A2oxusYoSLb..fRwt.dUVqr8tTjSrWq8waUJkrnnv2g5o2e6Fy
 hV6hx4PZxAeWMxHUVAMu.JrBbNormbvh0SzueTEb75S.JoXznWwnCaeI0Z1QJCF_FlMkJkAsvmKE
 LRA2hUSQAFEeNV9NgSZFkQiwsPMRypXsoMszeZB8jXK2GfsO0f6DPDjeQvVb9atpMCvcMInw2BKJ
 dN3cVkLDo1koraQBb5K0BuGS7nd.W9_QYXWUl2sIlCac8MNfEFgwdl_yVytA90d9RVOj4aw_vA2O
 MD2tgz970muvuFWniyeXczij0wCkX1YGaX3gQqtaQ2liGcYqApXNZ5GtR0GkafQoO1PwiKxGcv.D
 SCw4WQjXxLIvzZe3XaDHoxIDNR_kbEGm6wbmRcuWBV.EMxhmszvUSeaceBBzWv7fLurB.7wBeQwa
 xZYwNciSEJieSocZYN_E9exbIVCx_PhsHlSABN8_wJr2__AGa2B6OshG.sagoCjC8GHjlaKBDcE6
 UJVEJfTfNTMlvplRsUFFClBqL91.1NKdHf2i6Fwsg5by0kCZ6Syrj8sgQYS9I5MmdF0s9f6W.98M
 0GkFfsEgss3hH0Dr6tYjvlav7cKO3caxAz2E3Zoub1aj0mrFsqPcvom8wlVGSsUgu6duq6AOKvWW
 _TafeT2uJMKPH.MaiyN5.PPCeDl78X5IvwNq2.e7.s61Cuq1Uvd4VmRdIH.P4UYXYTUubiJ19DVQ
 1SliFulqZnr21WtLUvn_SLq4ykB2XtmPJ3nxNC57rBM5P5zyLQeasKZUATiqedNdx26PRxuSGLmW
 1Bvr7dXPXqlo4usPPERjRuM1.GD.6jXQeoX0eEwMuDMX8azTTESXCa6hty5Jr1TNG7BYKKXxNfRv
 wXTs4SmiYl1u8WUtwTOkICx51ONeaEbK7s6.BmpMpgdcqgmVaYtDlnqlYAVmtHb3BHR.xYizNnWR
 iacDkldrkmypJ4KNZLmjz2p4FRVRVPw--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Aug 2019 15:16:27 +0000
Received: by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID c43dd5474b48ff5e296cc88a7b562bad; 
 Sat, 24 Aug 2019 15:16:25 +0000 (UTC)
Date: Sat, 24 Aug 2019 23:16:10 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
Message-ID: <20190824151606.GA22858@hsiangkao-HP-ZHAN-66-Pro-G1>
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> I completely understand your concern.You can drop this patch for now.

Thank you.

> Once erofs makes it 'fs/' please do reconsider implementing it.
> 
> One more thing, can we still send non feature patches?

Yes, of course. All bugfix patches for erofs kernel and erofs-utils
are OK, if it's important, I will apply it for 5.4 round immediately.

Thanks,
Gao Xiang

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
