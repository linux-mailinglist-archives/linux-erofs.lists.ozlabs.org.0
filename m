Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5B9BE55
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Aug 2019 16:56:58 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46G1ZJ3JfKzDrNM
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 00:56:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="He9XTzBF"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46G1Z91MFDzDqjy
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2019 00:56:48 +1000 (AEST)
Received: by mail-ed1-x541.google.com with SMTP id f22so18660031edt.4
 for <linux-erofs@lists.ozlabs.org>; Sat, 24 Aug 2019 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zb+cFpluH7WCr5j2KYi/H7SI/ZlFwypEOy7wO1zzafI=;
 b=He9XTzBFBZzZdDF28axSYRTKSt623h0v03DDrG22Q+mxqJP6/JScWqhxtLj30yenMP
 jn4GxzvcYcikEfXv51wbfBX5owDn+sLBjAB1+Vg4GuwrQq7oYf4OKGDn53pP+W9bBzhC
 24PjJMMdxRU7owcu6zahJRArMGRBcJVWrcq4kZB8Qfhc9Esx3xLWuqH2vefV+2hV75Qe
 +i1YThyvrZUKgTIA8h9W+J5Iy1mZ9Ur11kXY8WLMJp7IsuTq44yZI/IQ4jhog3s6HEbX
 B2VpWc/jFbPDHfJiS7lfwu5nzXjwXc7JVWzpEkey7Wxmm6lH+NNxnVB7bxvKpYNjy56J
 MFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zb+cFpluH7WCr5j2KYi/H7SI/ZlFwypEOy7wO1zzafI=;
 b=dI3bcqONCfWlcos4tEZkp9Lsg1BgDneNj8UHsa8ay1U0E7IVSOJB4zVt6IWqRM4Dzp
 JtO/QMCKzsebebiUCmUDi7vl92qoqhMZCgfrIKutwkJjlCp9rcZwZpBKiZU1EIc6ATAU
 XJtNBYMMIziOYctBk27BeYHSVN3XhFARbxTcVwFl+ySi7JdppHlMDW+dPUPA7acDU/rH
 ej/FoqFWQ53j9ju70mlHUKsYpFuwU4goG2RA/rgeAN4KF2ODLK9Wsl6A8/mq22U5LOUg
 Vyrf9Z+/T/iJ7FFQnXHg+d8NSLWGrok1JBKgTt2wulqrcvvZsS5EewNbfSTMOyYpzEQW
 lvbQ==
X-Gm-Message-State: APjAAAUpoWS8hsB5k8GIeMtOnzj/wffWkRsaDNB5CfAsWJhGsBTvPE33
 2TNNGhQ1Tu+LwJA3/L1CbIF1kwm9Cl3W1ZVB73E=
X-Google-Smtp-Source: APXvYqw3lw1xNp2v9iUDfneodSBp04ZotKCBhct/yVN1b4Bu8qK/uTU8osMnPnEFtCHYP3aLomyUXi+Z9CWYReHFe2s=
X-Received: by 2002:aa7:ce89:: with SMTP id y9mr9911679edv.135.1566658600946; 
 Sat, 24 Aug 2019 07:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190824123803.19797-1-pratikshinde320@gmail.com>
 <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190824140012.GB19943@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sat, 24 Aug 2019 20:26:28 +0530
Message-ID: <CAGu0czSznsz7w90okOKa4bXhfy3ou4X=7pHKLmWw4WffFVh5wQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: code for superblock checksum calculation.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="00000000000064ced60590de2112"
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

--00000000000064ced60590de2112
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

I completely understand your concern.You can drop this patch for now.
Once erofs makes it 'fs/' please do reconsider implementing it.

One more thing, can we still send non feature patches?

--Pratik


On Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:
> > Adding code for superblock checksum calculation.
> >
> > incorporated the changes suggested in previous patch.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>
> Thanks for your v2 patch.
>
> Actually, I have some concern about the length of checksum,
> sizeof(struct erofs_super_block) could be changed in the
> later version, it's bad for EROFS future scalablity.
>
> And I tend not to add another on-disk field to record
> the size of erofs_super_block as well, because the old
> Linux kernel cannot handle more about the new size,
> so it has little use except for checksum calculation.
>
> Few hours ago, I discussed with Chao about this concern,
> I think this feature can be changed to do multiple-block
> checksum at the mount time, e.g:
>  - for small images, we can check the whole image once
>    at the mount time;
>  - for the large image, we can check the superblock
>    at the mount time, the rest can be handled by
>    block-based verification layer.
>
> But we agreed that don't add this for this round
> since it's quite a new feature.
>
> All in all, it's a new feature since we are addressing moving
> out of staging for this round. I tend to postpone this feature
> for now. I understand that you are very interested in EROFS.
> Considering EROFS current staging status, it's not such a place
> to add new features at all! I have marked your patch down and
> I will work with you later. Hope to get your understanding...
>
> Thanks,
> Gao Xiang
>
> > ---
> >  include/erofs/config.h |  1 +
> >  include/erofs_fs.h     | 10 ++++++++
> >  mkfs/main.c            | 64
> +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 74 insertions(+), 1 deletion(-)
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
> >  };
> >
> >  extern struct erofs_configure cfg;
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index 601b477..9ac2635 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -20,6 +20,16 @@
> >  #define EROFS_REQUIREMENT_LZ4_0PADDING       0x00000001
> >  #define EROFS_ALL_REQUIREMENTS
>  EROFS_REQUIREMENT_LZ4_0PADDING
> >
> > +/*
> > + * feature definations.
> > + */
> > +#define EROFS_DEFAULT_FEATURES               EROFS_FEATURE_SB_CHKSUM
> > +#define EROFS_FEATURE_SB_CHKSUM              0x0001
> > +
> > +
> > +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \
> > +     ( le32_to_cpu((super)->features) & (mask) )
> > +
> >  struct erofs_super_block {
> >  /*  0 */__le32 magic;           /* in the little endian */
> >  /*  4 */__le32 checksum;        /* crc32c(super_block) */
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index f127fe1..355fd2c 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -31,6 +31,45 @@ static void usage(void)
> >       fprintf(stderr, " -EX[,...] X=extended options\n");
> >  }
> >
> > +#define CRCPOLY      0x82F63B78
> > +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> > +{
> > +     int i;
> > +     u32 crc = seed;
> > +
> > +     while (len--) {
> > +             crc ^= *in++;
> > +             for (i = 0; i < 8; i++) {
> > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> > +             }
> > +     }
> > +     erofs_dump("calculated crc: 0x%x\n", crc);
> > +     return crc;
> > +}
> > +
> > +char *feature_opts[] = {
> > +     "nosbcrc", NULL
> > +};
> > +#define O_SB_CKSUM   0
> > +
> > +static int parse_feature_subopts(char *opts)
> > +{
> > +     char *arg;
> > +
> > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > +     while (*opts != '\0') {
> > +             switch(getsubopt(&opts, feature_opts, &arg)) {
> > +             case O_SB_CKSUM:
> > +                     cfg.c_feature_flags |= (~EROFS_FEATURE_SB_CHKSUM);
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
> > @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >  {
> >       int opt, i;
> >
> > -     while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> > +     cfg.c_feature_flags = EROFS_DEFAULT_FEATURES;
> > +     while ((opt = getopt(argc, argv, "d:z:E:o:")) != -1) {
> >               switch (opt) {
> >               case 'z':
> >                       if (!optarg) {
> > @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >                               return opt;
> >                       break;
> >
> > +             case 'O':
> > +                     opt = parse_feature_subopts(optarg);
> > +                     if (opt)
> > +                             return opt;
> > +                     break;
> > +
> >               default: /* '?' */
> >                       return -EINVAL;
> >               }
> > @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >       return 0;
> >  }
> >
> > +u32 erofs_superblock_checksum(struct erofs_super_block *sb)
> > +{
> > +     u32 crc;
> > +     crc = crc32c(~0, (const unsigned char *)sb,
> > +                 sizeof(struct erofs_super_block));
> > +     erofs_dump("superblock checksum: 0x%x\n", crc);
> > +     return crc;
> > +}
> > +
> >  int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> >                                 erofs_nid_t root_nid)
> >  {
> > @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >               .meta_blkaddr  = sbi.meta_blkaddr,
> >               .xattr_blkaddr = 0,
> >               .requirements = cpu_to_le32(sbi.requirements),
> > +             .features = cpu_to_le32(cfg.c_feature_flags),
> >       };
> >       const unsigned int sb_blksize =
> >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >       sb.blocks       = cpu_to_le32(erofs_mapbh(NULL, true));
> >       sb.root_nid     = cpu_to_le16(root_nid);
> >
> > +     if (EROFS_HAS_COMPAT_FEATURE(&sb, EROFS_FEATURE_SB_CHKSUM)) {
> > +             sb.checksum = 0;
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

--00000000000064ced60590de2112
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">I co=
mpletely understand your concern.You can drop this patch for now.</div><div=
 dir=3D"auto">Once erofs makes it &#39;fs/&#39; please do reconsider implem=
enting it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">One more=C2=
=A0thing, can we still send non feature patches?=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">--Pratik</div><div dir=3D"auto"><br></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Sat, 24 Aug, 2019, 7:30 PM Gao Xiang, &lt;<a href=3D"mailto:hsiangkao@aol.=
com" rel=3D"noreferrer noreferrer" target=3D"_blank">hsiangkao@aol.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
On Sat, Aug 24, 2019 at 06:08:03PM +0530, Pratik Shinde wrote:<br>
&gt; Adding code for superblock checksum calculation.<br>
&gt; <br>
&gt; incorporated the changes suggested in previous patch.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">pratiksh=
inde320@gmail.com</a>&gt;<br>
<br>
Thanks for your v2 patch.<br>
<br>
Actually, I have some concern about the length of checksum,<br>
sizeof(struct erofs_super_block) could be changed in the<br>
later version, it&#39;s bad for EROFS future scalablity.<br>
<br>
And I tend not to add another on-disk field to record<br>
the size of erofs_super_block as well, because the old<br>
Linux kernel cannot handle more about the new size,<br>
so it has little use except for checksum calculation.<br>
<br>
Few hours ago, I discussed with Chao about this concern,<br>
I think this feature can be changed to do multiple-block<br>
checksum at the mount time, e.g:<br>
=C2=A0- for small images, we can check the whole image once<br>
=C2=A0 =C2=A0at the mount time;<br>
=C2=A0- for the large image, we can check the superblock<br>
=C2=A0 =C2=A0at the mount time, the rest can be handled by<br>
=C2=A0 =C2=A0block-based verification layer.<br>
<br>
But we agreed that don&#39;t add this for this round<br>
since it&#39;s quite a new feature.<br>
<br>
All in all, it&#39;s a new feature since we are addressing moving<br>
out of staging for this round. I tend to postpone this feature<br>
for now. I understand that you are very interested in EROFS.<br>
Considering EROFS current staging status, it&#39;s not such a place<br>
to add new features at all! I have marked your patch down and<br>
I will work with you later. Hope to get your understanding...<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/config.h |=C2=A0 1 +<br>
&gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0| 10 ++++++++<br>
&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 64 ++++++=
+++++++++++++++++++++++++++++++++++++++++++-<br>
&gt;=C2=A0 3 files changed, 74 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/include/erofs/config.h b/include/erofs/config.h<br>
&gt; index 05fe6b2..40cd466 100644<br>
&gt; --- a/include/erofs/config.h<br>
&gt; +++ b/include/erofs/config.h<br>
&gt; @@ -22,6 +22,7 @@ struct erofs_configure {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_src_path;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *c_compr_alg_master;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int c_compr_level_master;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int c_feature_flags;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 extern struct erofs_configure cfg;<br>
&gt; diff --git a/include/erofs_fs.h b/include/erofs_fs.h<br>
&gt; index 601b477..9ac2635 100644<br>
&gt; --- a/include/erofs_fs.h<br>
&gt; +++ b/include/erofs_fs.h<br>
&gt; @@ -20,6 +20,16 @@<br>
&gt;=C2=A0 #define EROFS_REQUIREMENT_LZ4_0PADDING=C2=A0 =C2=A0 =C2=A0 =C2=
=A00x00000001<br>
&gt;=C2=A0 #define EROFS_ALL_REQUIREMENTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0EROFS_REQUIREMENT_LZ4_0PADDING<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * feature definations.<br>
&gt; + */<br>
&gt; +#define EROFS_DEFAULT_FEATURES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0EROFS_FEATURE_SB_CHKSUM<br>
&gt; +#define EROFS_FEATURE_SB_CHKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x0001<br>
&gt; +<br>
&gt; +<br>
&gt; +#define EROFS_HAS_COMPAT_FEATURE(super,mask) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0( le32_to_cpu((super)-&gt;features) &amp; (mask) =
)<br>
&gt; +<br>
&gt;=C2=A0 struct erofs_super_block {<br>
&gt;=C2=A0 /*=C2=A0 0 */__le32 magic;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* in the little endian */<br>
&gt;=C2=A0 /*=C2=A0 4 */__le32 checksum;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* crc3=
2c(super_block) */<br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index f127fe1..355fd2c 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -31,6 +31,45 @@ static void usage(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot; -EX[,...] X=3Dextende=
d options\n&quot;);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#define CRCPOLY=C2=A0 =C2=A0 =C2=A0 0x82F63B78<br>
&gt; +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t le=
n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 crc =3D seed;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (len--) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crc ^=3D *in++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
8; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0crc =3D (crc &gt;&gt; 1) ^ ((crc &amp; 1) ? CRCPOLY : 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;calculated crc: 0x%x\n&quot;, cr=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return crc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +char *feature_opts[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&quot;nosbcrc&quot;, NULL<br>
&gt; +};<br>
&gt; +#define O_SB_CKSUM=C2=A0 =C2=A00<br>
&gt; +<br>
&gt; +static int parse_feature_subopts(char *opts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *arg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags =3D EROFS_DEFAULT_FEATURES;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0while (*opts !=3D &#39;\0&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(getsubopt(&amp=
;opts, feature_opts, &amp;arg)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case O_SB_CKSUM:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cfg.c_feature_flags |=3D (~EROFS_FEATURE_SB_CHKSUM);<br>
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
&gt; @@ -79,7 +118,8 @@ static int mkfs_parse_options_cfg(int argc, char *a=
rgv[])<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int opt, i;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &quot;d:z:E:&q=
uot;)) !=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cfg.c_feature_flags =3D EROFS_DEFAULT_FEATURES;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((opt =3D getopt(argc, argv, &quot;d:z:E:o:=
&quot;)) !=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (opt) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;z&#39;=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!optarg) {<br>
&gt; @@ -113,6 +153,12 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return opt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;O&#39;:<br>
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
&gt; @@ -144,6 +190,15 @@ static int mkfs_parse_options_cfg(int argc, char =
*argv[])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +u32 erofs_superblock_checksum(struct erofs_super_block *sb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 crc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0crc =3D crc32c(~0, (const unsigned char *)sb,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(=
struct erofs_super_block));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;superblock checksum: 0x%x\n&quot=
;, crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return crc;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t root_nid)<br>
&gt;=C2=A0 {<br>
&gt; @@ -155,6 +210,7 @@ int erofs_mkfs_update_super_block(struct erofs_buf=
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
&gt; @@ -169,6 +225,12 @@ int erofs_mkfs_update_super_block(struct erofs_bu=
ffer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.blocks=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D cpu_=
to_le32(erofs_mapbh(NULL, true));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sb.root_nid=C2=A0 =C2=A0 =C2=A0=3D cpu_to_le=
16(root_nid);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (EROFS_HAS_COMPAT_FEATURE(&amp;sb, EROFS_FEATU=
RE_SB_CHKSUM)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sb.checksum =3D 0;<br=
>
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
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--00000000000064ced60590de2112--
