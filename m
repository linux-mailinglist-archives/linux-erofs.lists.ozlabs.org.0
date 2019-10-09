Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3ED099D
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 10:25:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46p6j24VgYzDqPC
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2019 19:25:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iYv/+83G"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46p6hv4gflzDqNX
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2019 19:25:01 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id v8so1231461eds.2
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Oct 2019 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hKFikF9BnYoh5j0B5z8G3//EhOutNLnfuEG9mTLz5GU=;
 b=iYv/+83GFo/37UDZJ7Hg93pJinVdy33m0Ncu+uhUzg2ViimV0DDG/NOuN7mhA6wH0i
 E9kYnTTeaNLqcaLkwf9Ycu/zyLMySWXSoR4J4aIhj+RMPMsG6kt9L/zm+ioV/giZlF3F
 fYVDl0wCa4Ng76nc3+0EX3M1sb6r2Uaew+4kFbdZXfXjOJ7epb3FGPWbX6G0xwhPro80
 /ozBslU/A0xftTRkq8ka8QeRfYKCZRqnNfEdTM6VIKss/CpVAi7Wrg7gBv3db3U/AZHO
 Fm6eV/AryMGl+IU6MahO3G0GI6uug3qrutS3GdiBhBUdch+Feph/akLIK8nH/yQPIxiy
 qT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hKFikF9BnYoh5j0B5z8G3//EhOutNLnfuEG9mTLz5GU=;
 b=da0jpMb/ucol7f4StEYDoflk7vDaPEGBmbf5HhvTpY5Yu1XVW71I4bAOFXFeqQKi4Q
 4i104inY+dKeMMJ41SZNAlK2MfuyiBdNjktuERcIRLEwuUGPb/rANqYGJ1VoDcI1f44D
 6kT3ZOxFfLkEqVPGM+O1T9B7E7C0BWUzabJHXWpFnow8HxUGFy1PjE3csArYhkVmyXOL
 CIHuOrXY8yadSZ3xGA05iKAjvsxVuCrvWd5stXxx+Kyyzza04POJekj893XmC2TyS9jf
 XCDejpXD3hfPhUBK/Fy3SIfDy2b7C6Ue1V6BwFKTU/Yug1ZQGhS6kTPI9S9LQof2Kck+
 H98A==
X-Gm-Message-State: APjAAAUsyvYU/6F2TQHa3uaXLhnZSix/daJuoeDWX25HXwHHyZ8jOGZH
 8rz8tZjUzYJ8Ndv+VAywZB7trbFzBwHmecd16jw=
X-Google-Smtp-Source: APXvYqzZd1MWjX3hsaK8zjV1robTJXGUflx9fLyhQwt0mKgy6w8fZf0ztwIP/JGdCsqK6THiNeINDFSB8LKO2AiJrWk=
X-Received: by 2002:a50:af44:: with SMTP id g62mr1861113edd.164.1570609496852; 
 Wed, 09 Oct 2019 01:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
 <20191006053914.GA25306@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czStB-4eraf_b-YvzzF_2E=c3bBvK0DGc031M=vyvLaeWQ@mail.gmail.com>
 <20191009065728.GA118670@architecture4>
In-Reply-To: <20191009065728.GA118670@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 9 Oct 2019 13:54:40 +0530
Message-ID: <CAGu0czQdWeYiTKJnQTpM3vvJ8H809bg_L33qebKDNbA9705sMg@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000240c980594760565"
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

--000000000000240c980594760565
Content-Type: text/plain; charset="UTF-8"

Hello Gao,

Yes I would like to work on pending features.
Also please let us know the new development items.

--Pratik

On Wed, 9 Oct, 2019, 12:24 PM Gao Xiang, <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On Wed, Oct 09, 2019 at 11:59:01AM +0530, Pratik Shinde wrote:
> > Hi Gao,
> >
> > Yes I can work on it. Sorry I missed this mail. I think your approach is
> > good. Let me go through it one more time and reply back.
>
> Thanks for your reply and interest :)
> I think we can complete all pending features together
> if you have some time on this stuff. (fsdebug utility is
> on the way as well...)
>
> BTW, I'm now investigating new high CR algorithm (very likely
> XZ) as well, it will be likely a RFC version in this round for
> wider scenarios and later decompression subsystem.
>
> Preliminary TODO lists will be discussed in this year China
> Linux Storage & Filesystem workshop (next week) and will be
> posted to mailing lists for further wider discussion (if more
> folks have interest in developing it) as well. :)
>
> Thanks,
> Gao Xiang
>
> >
> > --Pratik
> >
> > On Sun, 6 Oct, 2019, 11:09 AM Gao Xiang, <hsiangkao@aol.com> wrote:
> >
> > > Hi Pratik,
> > >
> > > On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:
> > > > Hi Gao,
> > > >
> > > > I completely understand your concern.You can drop this patch for now.
> > > > Once erofs makes it 'fs/' please do reconsider implementing it.
> > >
> > > I think we can work on this pending feature for v5.5 now.
> > > My idea is to add an extra field in erofs_super_block to
> > > indicate the number of blocks (4k) for checking.
> > >
> > > So for small images, this feature can checksum the whole image at mount
> > > time,
> > > and for large images, this feature can be used to checksum the super
> block
> > > only
> > > (and then use verficiation subsystem to verify on-the-fly in the
> future...)
> > >
> > > The following workflow is for erofs-utils, I think it's
> > >  1) erofs_mkfs_update_super_block with checksum = 0
> > >  2) erofs_bflush(NULL)
> > >  3) reread the corresponding blocks and calculate checksum;
> > >  4) write checksum to erofs_super_block;
> > >
> > > Does it sound reasonable? and do you still have interest and
> > > time for this? Looking forword to your reply...
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > One more thing, can we still send non feature patches?
> > > >
> > > > --Pratik
> > > >
> > > >
> > > > On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, <hsiangkao@aol.com> wrote:
> > > >
> > > > > Hi Pratik,
> > > > >
> > > > > On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > > > > > Adding code for superblock checksum calculation.
> > > > > >
> > > > > > incorporated the changes suggested in previous patch.
> > > > > >
> > > > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > >
> > > > > Thanks for your v2 patch.
> > > > >
> > > > > Actually, I have some concern about the length of checksum,
> > > > > sizeof(struct erofs_super_block) could be changed in the
> > > > > later version, it's bad for EROFS future scalablity.
> > > > >
> > > > > And I tend not to add another on-disk field to record
> > > > > the size of erofs_super_block as well, because the old
> > > > > Linux kernel cannot handle more about the new size,
> > > > > so it has little use except for checksum calculation.
> > > > >
> > > > > Few hours ago, I discussed with Chao about this concern,
> > > > > I think this feature can be changed to do multiple-block
> > > > > checksum at the mount time, e.g:
> > > > >  - for small images, we can check the whole image once
> > > > >    at the mount time;
> > > > >  - for the large image, we can check the superblock
> > > > >    at the mount time, the rest can be handled by
> > > > >    block-based verification layer.
> > > > >
> > > > > But we agreed that don't add this for this round
> > > > > since it's quite a new feature.
> > > > >
> > > > > All in all, it's a new feature since we are addressing moving
> > > > > out of staging for this round. I tend to postpone this feature
> > > > > for now. I understand that you are very interested in EROFS.
> > > > > Considering EROFS current staging status, it's not such a place
> > > > > to add new features at all! I have marked your patch down and
> > > > > I will work with you later. Hope to get your understanding...
> > > > >
> > > > > Thanks,
> > > > > Gao Xiang
> > > > >
> > > > > > ---
> > > > > >  include/erofs/config.h |  1 +
> > > > > >  include/erofs_fs.h     | 10 ++++++++
> > > > > >  mkfs/main.c            | 64
> > > > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > > > >  3 files changed, 74 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/erofs/config.h b/include/erofs/config.h
> > > > > > index 05fe6b2..40cd466 100644
> > > > > > --- a/include/erofs/config.h
> > > > > > +++ b/include/erofs/config.h
> > > > > > @@ -22,6 +22,7 @@ struct erofs_configure {
> > > > > >       char *c_src_path;
> > > > > >       char *c_compr_alg_master;
> > > > > >       int c_compr_level_master;
> > > > > > +     int c_feature_flags;
> > > > > >  };
> > > > > >
> > > > > >  extern struct erofs_configure cfg;
> > > > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > > > index 601b477..9ac2635 100644
> > > > > > --- a/include/erofs_fs.h
> > > > > > +++ b/include/erofs_fs.h
> > > > > > @@ -20,6 +20,16 @@
> > > > > >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> > > > > >  #define EROFS_ALL_REQUIREMENTS
> > > > >  EROFS_REQUIREMENT_LZ4_0PADDING
> > > > > >
> > > > > > +/*
> > > > > > + * feature definations.
> > > > > > + */
> > > > > > +#define EROFS_DEFAULT_FEATURES
>  EROFS_FEATURE_SB_CHKSUM
> > > > > > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > > > > > +
> > > > > > +
> > > > > > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > > > > > +     ( le32_to_cpu((super)->features) & (mask) )
> > > > > > +
> > > > > >  struct erofs_super_block {
> > > > > >  /*  0 */__le32 magic;           /* in the little endian */
> > > > > >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > > > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > > > index f127fe1..355fd2c 100644
> > > > > > --- a/mkfs/main.c
> > > > > > +++ b/mkfs/main.c
> > > > > > @@ -31,6 +31,45 @@ static void usage(void)
> > > > > >       fprintf(stderr, " -EX[,...] X=extended options\n");
> > > > > >  }
> > > > > >
> > > > > > +#define CRCPOLY      0x82F63B78
> > > > > > +static inline u32 crc32c(u32 seed, unsigned char const *in,
> size_t
> > > len)
> > > > > > +{
> > > > > > +     int i;
> > > > > > +     u32 crc = seed;
> > > > > > +
> > > > > > +     while (len--) {
> > > > > > +             crc ^= *in++;
> > > > > > +             for (i = 0; i < 8; i++) {
> > > > > > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY :
> 0);
> > > > > > +             }
> > > > > > +     }
> > > > > > +     erofs_dump("calculated crc: 0x%x\n", crc);
> > > > > > +     return crc;
> > > > > > +}
> > > > > > +
> > > > > > +char *feature_opts[] = {
> > > > > > +     "nosbcrc", NULL
> > > > > > +};
> > > > > > +#define O_SB_CKSUM   0
> > > > > > +
> > > > > > +static int parse_feature_subopts(char *opts)
> > > > > > +{
> > > > > > +     char *arg;
> > > > > > +
> > > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > > +     while (*opts != '\0') {
> > > > > > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > > > > > +             case O_SB_CKSUM:
> > > > > > +                     cfg.c_feature_flags |=
> > > (~EROFS_FEATURE_SB_CHKSUM);
> > > > > > +                     break;
> > > > > > +             default:
> > > > > > +                     erofs_err("incorrect suboption");
> > > > > > +                     return -EINVAL;
> > > > > > +             }
> > > > > > +     }
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static int parse_extended_opts(const char *opts)
> > > > > >  {
> > > > > >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > > > > > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc,
> char
> > > > > *argv[])
> > > > > >  {
> > > > > >       int opt, i;
> > > > > >
> > > > > > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > > > > > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > > > > > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> > > > > >               switch (opt) {
> > > > > >               case 'z':
> > > > > >                       if (!optarg) {
> > > > > > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc,
> char
> > > > > *argv[])
> > > > > >                               return opt;
> > > > > >                       break;
> > > > > >
> > > > > > +             case 'O':
> > > > > > +                     opt = parse_feature_subopts(optarg);
> > > > > > +                     if (opt)
> > > > > > +                             return opt;
> > > > > > +                     break;
> > > > > > +
> > > > > >               default: /* '?' */
> > > > > >                       return -EINVAL;
> > > > > >               }
> > > > > > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc,
> char
> > > > > *argv[])
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > > > > > +{
> > > > > > +     u32 crc;
> > > > > > +     crc = crc32c(~0, (const unsigned char *)sb,
> > > > > > +                 sizeof(struct erofs_super_block));
> > > > > > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > > > > > +     return crc;
> > > > > > +}
> > > > > > +
> > > > > >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> > > > > >                                 erofs_nid_t root_nid)
> > > > > >  {
> > > > > > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct
> > > > > erofs_buffer_head *bh,
> > > > > >               .meta_blkaddr  = sbi.meta_blkaddr,
> > > > > >               .xattr_blkaddr = 0,
> > > > > >               .requirements = cpu_to_le32(sbi.requirements),
> > > > > > +             .features = cpu_to_le32(cfg.c_feature_flags),
> > > > > >       };
> > > > > >       const unsigned int sb_blksize =
> > > > > >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > > > > > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct
> > > > > erofs_buffer_head *bh,
> > > > > >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> > > > > >       sb.root_nid     = cpu_to_le16(root_nid);
> > > > > >
> > > > > > +     if (EROFS_HAS_COMPAT_FEATURE(&sb,
> EROFS_FEATURE_SB_CHKSUM)) {
> > > > > > +             sb.checksum = 0;
> > > > > > +             u32 crc = erofs_superblock_checksum(&sb);
> > > > > > +             sb.checksum = cpu_to_le32(crc);
> > > > > > +     }
> > > > > > +
> > > > > >       buf = calloc(sb_blksize, 1);
> > > > > >       if (!buf) {
> > > > > >               erofs_err("Failed to allocate memory for sb: %s",
> > > > > > --
> > > > > > 2.9.3
> > > > > >
> > > > >
> > >
>

--000000000000240c980594760565
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">Y=
es I would like to work on pending features.</div><div dir=3D"auto">Also pl=
ease let us know the new development items.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">--Pratik</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, 9 Oct, 2019, 12:24 PM Gao Xiang, =
&lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
On Wed, Oct 09, 2019 at 11:59:01AM +0530, Pratik Shinde wrote:<br>
&gt; Hi Gao,<br>
&gt; <br>
&gt; Yes I can work on it. Sorry I missed this mail. I think your approach =
is<br>
&gt; good. Let me go through it one more time and reply back.<br>
<br>
Thanks for your reply and interest :)<br>
I think we can complete all pending features together<br>
if you have some time on this stuff. (fsdebug utility is<br>
on the way as well...)<br>
<br>
BTW, I&#39;m now investigating new high CR algorithm (very likely<br>
XZ) as well, it will be likely a RFC version in this round for<br>
wider scenarios and later decompression subsystem.<br>
<br>
Preliminary TODO lists will be discussed in this year China<br>
Linux Storage &amp; Filesystem workshop (next week) and will be<br>
posted to mailing lists for further wider discussion (if more<br>
folks have interest in developing it) as well. :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; --Pratik<br>
&gt; <br>
&gt; On Sun, 6 Oct, 2019, 11:09 AM Gao Xiang, &lt;<a href=3D"mailto:hsiangk=
ao@aol.com" target=3D"_blank" rel=3D"noreferrer">hsiangkao@aol.com</a>&gt; =
wrote:<br>
&gt; <br>
&gt; &gt; Hi Pratik,<br>
&gt; &gt;<br>
&gt; &gt; On Sat, Aug 24, 2019 at 08:26:28PM +0530, Pratik Shinde wrote:<br=
>
&gt; &gt; &gt; Hi Gao,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I completely understand your concern.You can drop this patch=
 for now.<br>
&gt; &gt; &gt; Once erofs makes it &#39;fs/&#39; please do reconsider imple=
menting it.<br>
&gt; &gt;<br>
&gt; &gt; I think we can work on this pending feature for v5.5 now.<br>
&gt; &gt; My idea is to add an extra field in erofs_super_block to<br>
&gt; &gt; indicate the number of blocks (4k) for checking.<br>
&gt; &gt;<br>
&gt; &gt; So for small images, this feature can checksum the whole image at=
 mount<br>
&gt; &gt; time,<br>
&gt; &gt; and for large images, this feature can be used to checksum the su=
per block<br>
&gt; &gt; only<br>
&gt; &gt; (and then use verficiation subsystem to verify on-the-fly in the =
future...)<br>
&gt; &gt;<br>
&gt; &gt; The following workflow is for erofs-utils, I think it&#39;s<br>
&gt; &gt;=C2=A0 1) erofs_mkfs_update_super_block with checksum =3D 0<br>
&gt; &gt;=C2=A0 2) erofs_bflush(NULL)<br>
&gt; &gt;=C2=A0 3) reread the corresponding blocks and calculate checksum;<=
br>
&gt; &gt;=C2=A0 4) write checksum to erofs_super_block;<br>
&gt; &gt;<br>
&gt; &gt; Does it sound reasonable? and do you still have interest and<br>
&gt; &gt; time for this? Looking forword to your reply...<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; One more thing, can we still send non feature patches?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --Pratik<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, &lt;<a href=3D"mail=
to:hsiangkao@aol.com" target=3D"_blank" rel=3D"noreferrer">hsiangkao@aol.co=
m</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hi Pratik,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde=
 wrote:<br>
&gt; &gt; &gt; &gt; &gt; Adding code for superblock checksum calculation.<b=
r>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; incorporated the changes suggested in previous pat=
ch.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto=
:pratikshinde320@gmail.com" target=3D"_blank" rel=3D"noreferrer">pratikshin=
de320@gmail.com</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks for your v2 patch.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Actually, I have some concern about the length of check=
sum,<br>
&gt; &gt; &gt; &gt; sizeof(struct erofs_super_block) could be changed in th=
e<br>
&gt; &gt; &gt; &gt; later version, it&#39;s bad for EROFS future scalablity=
.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; And I tend not to add another on-disk field to record<b=
r>
&gt; &gt; &gt; &gt; the size of erofs_super_block as well, because the old<=
br>
&gt; &gt; &gt; &gt; Linux kernel cannot handle more about the new size,<br>
&gt; &gt; &gt; &gt; so it has little use except for checksum calculation.<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Few hours ago, I discussed with Chao about this concern=
,<br>
&gt; &gt; &gt; &gt; I think this feature can be changed to do multiple-bloc=
k<br>
&gt; &gt; &gt; &gt; checksum at the mount time, e.g:<br>
&gt; &gt; &gt; &gt;=C2=A0 - for small images, we can check the whole image =
once<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 at the mount time;<br>
&gt; &gt; &gt; &gt;=C2=A0 - for the large image, we can check the superbloc=
k<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 at the mount time, the rest can be handled=
 by<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 block-based verification layer.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; But we agreed that don&#39;t add this for this round<br=
>
&gt; &gt; &gt; &gt; since it&#39;s quite a new feature.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; All in all, it&#39;s a new feature since we are address=
ing moving<br>
&gt; &gt; &gt; &gt; out of staging for this round. I tend to postpone this =
feature<br>
&gt; &gt; &gt; &gt; for now. I understand that you are very interested in E=
ROFS.<br>
&gt; &gt; &gt; &gt; Considering EROFS current staging status, it&#39;s not =
such a place<br>
&gt; &gt; &gt; &gt; to add new features at all! I have marked your patch do=
wn and<br>
&gt; &gt; &gt; &gt; I will work with you later. Hope to get your understand=
ing...<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt; &gt; Gao Xiang<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 include/erofs/config.h |=C2=A0 1 +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0| 10 +=
+++++++<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 64<br>
&gt; &gt; &gt; &gt; +++++++++++++++++++++++++++++++++++++++++++++++++-<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 3 files changed, 74 insertions(+), 1 deletio=
n(-)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/include/erofs/config.h b/include/erof=
s/config.h<br>
&gt; &gt; &gt; &gt; &gt; index 05fe6b2..40cd466 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/include/erofs/config.h<br>
&gt; &gt; &gt; &gt; &gt; +++ b/include/erofs/config.h<br>
&gt; &gt; &gt; &gt; &gt; @@ -22,6 +22,7 @@ struct erofs_configure {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_src_path;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_compr_alg_master=
;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int c_compr_level_master=
;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int c_feature_flags;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 };<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 extern struct erofs_configure cfg;<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/include/erofs_fs.h b/include/erofs_fs=
.h<br>
&gt; &gt; &gt; &gt; &gt; index 601b477..9ac2635 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/include/erofs_fs.h<br>
&gt; &gt; &gt; &gt; &gt; +++ b/include/erofs_fs.h<br>
&gt; &gt; &gt; &gt; &gt; @@ -20,6 +20,16 @@<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 #define EROFS_REQUIREMENT_LZ4_0PADDING=C2=A0=
 =C2=A0 =C2=A0 =C2=A00x00000001<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 #define EROFS_ALL_REQUIREMENTS<br>
&gt; &gt; &gt; &gt;=C2=A0 EROFS_REQUIREMENT_LZ4_0PADDING<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +/*<br>
&gt; &gt; &gt; &gt; &gt; + * feature definations.<br>
&gt; &gt; &gt; &gt; &gt; + */<br>
&gt; &gt; &gt; &gt; &gt; +#define EROFS_DEFAULT_FEATURES=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EROFS_FEATURE_SB_CHKSUM<br>
&gt; &gt; &gt; &gt; &gt; +#define EROFS_FEATURE_SB_CHKSUM=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \<br=
>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0( le32_to_cpu((super)-&gt;fea=
tures) &amp; (mask) )<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 struct erofs_super_block {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 /*=C2=A0 0 */__le32 magic;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* in the little endian */<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 /*=C2=A0 4 */__le32 checksum;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* crc32c(super_block) */<br>
&gt; &gt; &gt; &gt; &gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; &gt; &gt; &gt; &gt; index f127fe1..355fd2c 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/mkfs/main.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/mkfs/main.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -31,6 +31,45 @@ static void usage(void)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot; -=
EX[,...] X=3Dextended options\n&quot;);<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +#define CRCPOLY=C2=A0 =C2=A0 =C2=A0 0x82F63B78<br=
>
&gt; &gt; &gt; &gt; &gt; +static inline u32 crc32c(u32 seed, unsigned char =
const *in, size_t<br>
&gt; &gt; len)<br>
&gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 crc =3D seed;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0while (len--) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
rc ^=3D *in++;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
or (i =3D 0; i &lt; 8; i++) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0crc =3D (crc &gt;&gt; 1) ^ ((crc &amp; 1) ? CRCP=
OLY : 0);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;calculated c=
rc: 0x%x\n&quot;, crc);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return crc;<br>
&gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +char *feature_opts[] =3D {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0&quot;nosbcrc&quot;, NULL<br>
&gt; &gt; &gt; &gt; &gt; +};<br>
&gt; &gt; &gt; &gt; &gt; +#define O_SB_CKSUM=C2=A0 =C2=A00<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +static int parse_feature_subopts(char *opts)<br>
&gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *arg;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags =3D EROFS=
_DEFAULT_FEATURES;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0while (*opts !=3D &#39;\0&#39=
;) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
witch(getsubopt(&amp;opts, feature_opts, &amp;arg)) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
ase O_SB_CKSUM:<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags |=3D<br>
&gt; &gt; (~EROFS_FEATURE_SB_CHKSUM);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d=
efault:<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;incorrect suboption&quot;);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 static int parse_extended_opts(const char *o=
pts)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 #define MATCH_EXTENTED_OPT(opt, token, keyle=
n) \<br>
&gt; &gt; &gt; &gt; &gt; @@ -79,7 +118,8 @@ static int mkfs_parse_options_c=
fg(int argc, char<br>
&gt; &gt; &gt; &gt; *argv[])<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int opt, i;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, =
argv, &quot;d:z:E:&quot;)) !=3D -1) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags =3D EROFS=
_DEFAULT_FEATURES;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, =
argv, &quot;d:z:E:o:&quot;)) !=3D -1) {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0switch (opt) {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0case &#39;z&#39;:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!optarg) {<br>
&gt; &gt; &gt; &gt; &gt; @@ -113,6 +153,12 @@ static int mkfs_parse_options=
_cfg(int argc, char<br>
&gt; &gt; &gt; &gt; *argv[])<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<b=
r>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
ase &#39;O&#39;:<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0opt =3D parse_feature_subopts(optarg);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (opt)<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0default: /* &#39;?&#39; */<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; @@ -144,6 +190,15 @@ static int mkfs_parse_options=
_cfg(int argc, char<br>
&gt; &gt; &gt; &gt; *argv[])<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +u32 erofs_superblock_checksum(struct erofs_super_=
block *sb)<br>
&gt; &gt; &gt; &gt; &gt; +{<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 crc;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0crc =3D crc32c(~0, (const uns=
igned char *)sb,<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(struct erofs_super_block));<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;superblock c=
hecksum: 0x%x\n&quot;, crc);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return crc;<br>
&gt; &gt; &gt; &gt; &gt; +}<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 int erofs_mkfs_update_super_block(struct ero=
fs_buffer_head *bh,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_=
nid_t root_nid)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt; @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_bl=
ock(struct<br>
&gt; &gt; &gt; &gt; erofs_buffer_head *bh,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.meta_blkaddr=C2=A0 =3D sbi.meta_blkaddr,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.xattr_blkaddr =3D 0,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.requirements =3D cpu_to_le32(sbi.requirements),<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
features =3D cpu_to_le32(cfg.c_feature_flags),<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int sb_bl=
ksize =3D<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0round_up(EROFS_SUPER_END, EROFS_BLKSIZ);<br>
&gt; &gt; &gt; &gt; &gt; @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_b=
lock(struct<br>
&gt; &gt; &gt; &gt; erofs_buffer_head *bh,<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.blocks=C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D cpu_to_le32(erofs_mapbh(NULL, true));<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.root_nid=C2=A0 =C2=A0=
 =C2=A0=3D cpu_to_le16(root_nid);<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (EROFS_HAS_COMPAT_FEATURE(=
&amp;sb, EROFS_FEATURE_SB_CHKSUM)) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
b.checksum =3D 0;<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
32 crc =3D erofs_superblock_checksum(&amp;sb);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
b.checksum =3D cpu_to_le32(crc);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D calloc(sb_blksiz=
e, 1);<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!buf) {<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0erofs_err(&quot;Failed to allocate memory for sb: %s&quot;,<br>
&gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; 2.9.3<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000240c980594760565--
