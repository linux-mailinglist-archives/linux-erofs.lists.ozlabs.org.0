Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EABD6D16
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 04:01:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sdv02b2tzDqgN
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 13:01:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtOEO/UH"; 
 dkim-atps=neutral
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sdtv4Mq7zDq96
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 13:00:55 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id j8so4770007eds.1
 for <linux-erofs@lists.ozlabs.org>; Mon, 14 Oct 2019 19:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8HxBIPeL7gLJI14KmUfm9r36Xk2FhE4DFPrSLT4cTAs=;
 b=OtOEO/UHcxDgbNLRCo+fRB9ErjXQX92SFrI9rWmZJ1fFXLAm87ry0pHfZT0BLQJ9vB
 RNIUeNnY9S58phRQ9sBMuMWZcbQot8FsUOOsturATajhz5zzTPRc0AqwWAHzE3kxTmSt
 HVsfucZbNDS9A2niKwu+OuaGcihsPP7AZ3DbAl8aLOTlW/HHvBk0goRqWwguQrUCMloU
 jWDFGflvGFmSV9YbcPl38kdUI8sF5h82wFm5rmyCzLZY+nSu4yB0jzTmBjM3a1nn+WB7
 zcI2TX57Cc+An1c4V6p4RvpFB/Ll9KzukY/SvXBfhb60iWE5QNGBh9wZ/D/K4eioLUZ4
 NPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8HxBIPeL7gLJI14KmUfm9r36Xk2FhE4DFPrSLT4cTAs=;
 b=UXWliCxHqwv5V5Jmkg/+GfC8RO48ofmjYW4HFATKWgPYqHKRslb2KZxLKrAJZUunwI
 9dYPFawFxoU1nMMCVrq/dronKtAs8S+K9wwEa6t1O0+y1huin/2iSEMyghD/xU/a8uJ8
 x/+rstNeYHfLqR8Jefat4fTOqz0mLMv7t7kk211vUXyUQ5C/SOz8r8sUXn+38LbmbskQ
 WlgNY/WaofvW2jdajKqfEuTuZTt3D+nim8LfNbBhUnBnxptH8dg8TU0j0mtfwFoxtMVK
 /tndYqtj0OdX7H3BBEdu8MugkQI1xZUrxGYpZgIUyuAflFf47kIhpTBz9VEcABV7r7jY
 cXyA==
X-Gm-Message-State: APjAAAVsSsgWw94FQgu3RFckaNCRWBmI+K6wLadRKFKBJE50gl18S3SX
 nUww9k0vw+O6Fu1PhPmhstja6erhXxfyIpVufrV0ghfbglQ=
X-Google-Smtp-Source: APXvYqwPe8v22lgNG9k8V4MQBUHpNmaN79Bi5t2a/uFAeyvsSlYt5p7E+DeTvO3pZtUYv7Dvw5thxTRysFB8WaT4ay8=
X-Received: by 2002:a17:906:28ce:: with SMTP id
 p14mr32248041ejd.164.1571104851093; 
 Mon, 14 Oct 2019 19:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191014145943.2653-1-pratikshinde320@gmail.com>
 <20191014234504.GA31674@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191014234504.GA31674@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 15 Oct 2019 07:30:38 +0530
Message-ID: <CAGu0czT91GOwrkLf_SYTj6QATPAD_ysMrLMs9t=bAHi8ACmLnA@mail.gmail.com>
Subject: Re: [PATCH-v2] erofs-utils:code for calculating crc checksum of erofs
 blocks.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="0000000000008def4c0594e95aee"
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

--0000000000008def4c0594e95aee
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

okay. I will make those changes. Yes I would like to do kernel side changes
too. Which branch to use for this? kernel's master?

-Pratik

On Tue, 15 Oct, 2019, 5:15 AM Gao Xiang, <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> Some nitpick comments... Let me know if you have other thoughts
>
> On Mon, Oct 14, 2019 at 08:29:43PM +0530, Pratik Shinde wrote:
> > Added code for calculating crc of erofs blocks (4K size).for now it
> calculates
> > checksum of first block. but can modified to calculate crc for any no.
> of blocks
> >
> > modified patch based on review comments.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  include/erofs/internal.h |  1 +
> >  include/erofs/io.h       |  8 +++++
> >  lib/io.c                 | 27 +++++++++++++++++
> >  mkfs/main.c              | 76
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 112 insertions(+)
> >
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index 5384946..53335bc 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -55,6 +55,7 @@ struct erofs_sb_info {
> >       u32 feature_incompat;
> >       u64 build_time;
> >       u32 build_time_nsec;
> > +     u32 feature;
> >  };
> >
> >  /* global sbi */
> > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > index 9775047..e0ca8d9 100644
> > --- a/include/erofs/io.h
> > +++ b/include/erofs/io.h
> > @@ -19,6 +19,7 @@
> >  int dev_open(const char *devname);
> >  void dev_close(void);
> >  int dev_write(const void *buf, u64 offset, size_t len);
> > +int dev_read(void *buf, u64 offset, size_t len);
> >  int dev_fillzero(u64 offset, size_t len, bool padding);
> >  int dev_fsync(void);
> >  int dev_resize(erofs_blk_t nblocks);
> > @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf,
> erofs_blk_t blkaddr,
> >                        blknr_to_addr(nblocks));
> >  }
> >
> > +static inline int blk_read(void *buf, erofs_blk_t start,
> > +                         u32 nblocks)
> > +{
> > +     return dev_read(buf, blknr_to_addr(start),
> > +                      blknr_to_addr(nblocks));
> > +}
> > +
> >  #endif
> >
> > diff --git a/lib/io.c b/lib/io.c
> > index 7f5f94d..52f9424 100644
> > --- a/lib/io.c
> > +++ b/lib/io.c
> > @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
> >       return dev_fillzero(st.st_size, length, true);
> >  }
> >
> > +int dev_read(void *buf, u64 offset, size_t len)
> > +{
> > +     int ret;
> > +
> > +     if (cfg.c_dry_run)
> > +             return 0;
> > +
> > +     if (!buf) {
> > +             erofs_err("buf is NULL");
> > +             return -EINVAL;
> > +     }
> > +     if (offset >= erofs_devsz || len > erofs_devsz ||
> > +         offset > erofs_devsz - len) {
> > +             erofs_err("read posion[%" PRIu64 ", %zd] is too large
> beyond"
> > +                       "the end of device(%" PRIu64 ").",
> > +                       offset, len, erofs_devsz);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> > +     if (ret != (int)len) {
> > +             erofs_err("Failed to read data from device - %s:[%" PRIu64
> ", %zd].",
> > +                       erofs_devname, offset, len);
> > +             return -errno;
> > +     }
> > +     return 0;
> > +}
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 91a018f..baaf02a 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -22,6 +22,10 @@
> >
> >  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
> erofs_super_block))
> >
> > +/* number of blocks for calculating checksum */
> > +#define EROFS_CKSUM_BLOCKS   1
> > +#define EROFS_FEATURE_SB_CHKSUM      0x0001
>
> How about Moving EROFS_FEATURE_SB_CHKSUM to erofs_fs.h since it's
> an on-disk definition,
>
> > +
> >  static void usage(void)
> >  {
> >       fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> > @@ -85,6 +89,10 @@ static int parse_extended_opts(const char *opts)
> >                               return -EINVAL;
> >                       cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
> >               }
> > +
> > +             if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> > +                     sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
> > +             }
> >       }
> >       return 0;
> >  }
> > @@ -180,6 +188,7 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >               .meta_blkaddr  = sbi.meta_blkaddr,
> >               .xattr_blkaddr = 0,
> >               .feature_incompat = cpu_to_le32(sbi.feature_incompat),
> > +             .checksum = 0
> >       };
> >       const unsigned int sb_blksize =
> >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > @@ -202,6 +211,70 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >       return 0;
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
> > +     return crc;
> > +}
> > +
> > +/* calculate checksum for first n blocks */
> > +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
> > +{
> > +     char *buf;
> > +     int err = 0;
> > +
> > +     buf = malloc(nblks * EROFS_BLKSIZ);
> > +     err = blk_read(buf, 0, nblks);
> > +     if (err) {
> > +             erofs_err("Failed to calculate erofs checksum - %s",
> > +                       erofs_strerror(err));
> > +             return err;
> > +     }
> > +     *crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> > +     free(buf);
> > +     return 0;
> > +}
> > +
> > +void erofs_write_checksum()
>
> How about naming write_sb_checksum?
> My idea is that this is a checksum in super block (rather than
> a checksum only for super block [0th block])
>
> Let me know if you have another thought...
>
> > +{
> > +     struct erofs_super_block *sb;
> > +     char buf[EROFS_BLKSIZ];
> > +     int ret = 0;
> > +     u32 crc;
> > +
> > +     ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> > +     if (ret) {
> > +             return;
> > +     }
> > +     ret = blk_read(buf, 0, 1);
> > +     if (ret) {
> > +             erofs_err("error reading super-block structure");
> > +             return;
> > +     }
> > +
> > +     sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> > +     if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> > +             erofs_err("not an erofs image");
>
> As the previous comments, I am little care about these print messages
> since users will only see this and "error reading super-block structure"
> "not an erofs image" makes confused for them... (They don't know what
> the internal process is doing)
>
> BTW, it looks good to me as a whole... Do you have some time on
> kernel side as well? :)
>
> Thanks,
> Gao Xiang
>
> > +             return;
> > +     }
> > +     sb->checksum = cpu_to_le32(crc);
> > +     ret = blk_write(buf, 0, 1);
> > +     if (ret) {
> > +             erofs_err("error writing 0th block to disk - %s",
> > +                       erofs_strerror(ret));
> > +             return;
> > +     }
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       int err = 0;
> > @@ -217,6 +290,7 @@ int main(int argc, char **argv)
> >
> >       cfg.c_legacy_compress = false;
> >       sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> > +     sbi.feature = EROFS_FEATURE_SB_CHKSUM;
> >
> >       err = mkfs_parse_options_cfg(argc, argv);
> >       if (err) {
> > @@ -301,6 +375,8 @@ int main(int argc, char **argv)
> >               err = -EIO;
> >       else
> >               err = dev_resize(nblocks);
> > +     if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> > +             erofs_write_checksum();
> >  exit:
> >       z_erofs_compress_exit();
> >       dev_close();
> > --
> > 2.9.3
> >
>

--0000000000008def4c0594e95aee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto=
">okay. I will make those changes. Yes I would like to do kernel side chang=
es too. Which branch to use for this? kernel&#39;s master?</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">-Pratik</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 15 Oct, 2019, 5:15 =
AM Gao Xiang, &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangkao@aol.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
Some nitpick comments... Let me know if you have other thoughts<br>
<br>
On Mon, Oct 14, 2019 at 08:29:43PM +0530, Pratik Shinde wrote:<br>
&gt; Added code for calculating crc of erofs blocks (4K size).for now it ca=
lculates<br>
&gt; checksum of first block. but can modified to calculate crc for any no.=
 of blocks<br>
&gt; <br>
&gt; modified patch based on review comments.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/internal.h |=C2=A0 1 +<br>
&gt;=C2=A0 include/erofs/io.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++<br>
&gt;=C2=A0 lib/io.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 27 +++++++++++++++++<br>
&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 76=
 ++++++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 112 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
&gt; index 5384946..53335bc 100644<br>
&gt; --- a/include/erofs/internal.h<br>
&gt; +++ b/include/erofs/internal.h<br>
&gt; @@ -55,6 +55,7 @@ struct erofs_sb_info {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 feature_incompat;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 build_time;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 build_time_nsec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 feature;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* global sbi */<br>
&gt; diff --git a/include/erofs/io.h b/include/erofs/io.h<br>
&gt; index 9775047..e0ca8d9 100644<br>
&gt; --- a/include/erofs/io.h<br>
&gt; +++ b/include/erofs/io.h<br>
&gt; @@ -19,6 +19,7 @@<br>
&gt;=C2=A0 int dev_open(const char *devname);<br>
&gt;=C2=A0 void dev_close(void);<br>
&gt;=C2=A0 int dev_write(const void *buf, u64 offset, size_t len);<br>
&gt; +int dev_read(void *buf, u64 offset, size_t len);<br>
&gt;=C2=A0 int dev_fillzero(u64 offset, size_t len, bool padding);<br>
&gt;=C2=A0 int dev_fsync(void);<br>
&gt;=C2=A0 int dev_resize(erofs_blk_t nblocks);<br>
&gt; @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf, erofs_=
blk_t blkaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 blknr_to_addr(nblocks));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static inline int blk_read(void *buf, erofs_blk_t start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0u32 nblocks)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return dev_read(buf, blknr_to_addr(start),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 blknr_to_addr(nblocks));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/lib/io.c b/lib/io.c<br>
&gt; index 7f5f94d..52f9424 100644<br>
&gt; --- a/lib/io.c<br>
&gt; +++ b/lib/io.c<br>
&gt; @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return dev_fillzero(st.st_size, length, true=
);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +int dev_read(void *buf, u64 offset, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (cfg.c_dry_run)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!buf) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;buf i=
s NULL&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (offset &gt;=3D erofs_devsz || len &gt; erofs_=
devsz ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset &gt; erofs_devsz - len) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;read =
posion[%&quot; PRIu64 &quot;, %zd] is too large beyond&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;the end of device(%&quot; PRIu64 &quot;).&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0offset, len, erofs_devsz);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D pread64(erofs_devfd, buf, len, (off64_t)o=
ffset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret !=3D (int)len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Faile=
d to read data from device - %s:[%&quot; PRIu64 &quot;, %zd].&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erofs_devname, offset, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index 91a018f..baaf02a 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -22,6 +22,10 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erof=
s_super_block))<br>
&gt;=C2=A0 <br>
&gt; +/* number of blocks for calculating checksum */<br>
&gt; +#define EROFS_CKSUM_BLOCKS=C2=A0 =C2=A01<br>
&gt; +#define EROFS_FEATURE_SB_CHKSUM=C2=A0 =C2=A0 =C2=A0 0x0001<br>
<br>
How about Moving EROFS_FEATURE_SB_CHKSUM to erofs_fs.h since it&#39;s<br>
an on-disk definition,<br>
<br>
&gt; +<br>
&gt;=C2=A0 static void usage(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;usage: [options] FILE =
DIRECTORY\n\n&quot;);<br>
&gt; @@ -85,6 +89,10 @@ static int parse_extended_opts(const char *opts)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cfg.c_force_inodeversion =3D FORCE_INODE_EXTENDED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (MATCH_EXTENTED_OP=
T(&quot;nocrc&quot;, token, keylen)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sbi.feature &amp;=3D ~EROFS_FEATURE_SB_CHKSUM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; @@ -180,6 +188,7 @@ int erofs_mkfs_update_super_block(struct erofs_buf=
fer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.meta_blkaddr=C2=
=A0 =3D sbi.meta_blkaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.xattr_blkaddr =
=3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.feature_incompa=
t =3D cpu_to_le32(sbi.feature_incompat),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.checksum =3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int sb_blksize =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0round_up(EROFS_S=
UPER_END, EROFS_BLKSIZ);<br>
&gt; @@ -202,6 +211,70 @@ int erofs_mkfs_update_super_block(struct erofs_bu=
ffer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0return crc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* calculate checksum for first n blocks */<br>
&gt; +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(nblks * EROFS_BLKSIZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D blk_read(buf, 0, nblks);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;Faile=
d to calculate erofs checksum - %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erofs_strerror(err));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*crc =3D crc32c(0, (const unsigned char *)buf, nb=
lks * EROFS_BLKSIZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void erofs_write_checksum()<br>
<br>
How about naming write_sb_checksum?<br>
My idea is that this is a checksum in super block (rather than<br>
a checksum only for super block [0th block])<br>
<br>
Let me know if you have another thought...<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_super_block *sb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char buf[EROFS_BLKSIZ];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 crc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D erofs_calc_blk_checksum(EROFS_CKSUM_BLOCK=
S, &amp;crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D blk_read(buf, 0, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;error=
 reading super-block structure&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sb =3D (struct erofs_super_block *)((u8 *)buf + E=
ROFS_SUPER_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (le32_to_cpu(sb-&gt;magic) !=3D EROFS_SUPER_MA=
GIC_V1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;not a=
n erofs image&quot;);<br>
<br>
As the previous comments, I am little care about these print messages<br>
since users will only see this and &quot;error reading super-block structur=
e&quot;<br>
&quot;not an erofs image&quot; makes confused for them... (They don&#39;t k=
now what<br>
the internal process is doing)<br>
<br>
BTW, it looks good to me as a whole... Do you have some time on<br>
kernel side as well? :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sb-&gt;checksum =3D cpu_to_le32(crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D blk_write(buf, 0, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;error=
 writing 0th block to disk - %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erofs_strerror(ret));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; @@ -217,6 +290,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cfg.c_legacy_compress =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sbi.feature_incompat =3D EROFS_FEATURE_INCOM=
PAT_LZ4_0PADDING;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sbi.feature =3D EROFS_FEATURE_SB_CHKSUM;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D mkfs_parse_options_cfg(argc, argv);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt; @@ -301,6 +375,8 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EIO;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D dev_resi=
ze(nblocks);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (sbi.feature &amp; EROFS_FEATURE_SB_CHKSUM)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_write_checksum(=
);<br>
&gt;=C2=A0 exit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0z_erofs_compress_exit();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_close();<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--0000000000008def4c0594e95aee--
