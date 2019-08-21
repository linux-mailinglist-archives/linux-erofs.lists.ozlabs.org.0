Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604F9828B
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 20:16:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DG7Y1n93zDqg6
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 04:16:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FRhG1gL7"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DG7T186DzDqfX
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 04:16:04 +1000 (AEST)
Received: by mail-ed1-x544.google.com with SMTP id f22so4039361edt.4
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GULY0uEf0Em8WP9qnivhLBLTo2xKP9b8kebOnqiMnnw=;
 b=FRhG1gL7V4xD7hE5THIEEG/nDjk2YjNhGcA5cWH7+n3MuUF2g7ZfYruk8kD+7yaLzn
 Pa9y+5TMREBhH36sFwBhLuq9v7Yjv7S6PU86OtPULGltWVODwDKI7FPr2Cc4qmoPU1O+
 0hh2ZPgf0GPbVYpw9hb4l/qcyj+2mIQYqoCIEiQxQC/pzBNXCfy/PXFruGSzI1VPoxLE
 ZaquRMmQd6uVajjlUDedcFUMixiCZXBNSOrvg0JVlYO8HAhHrAyT6Piy4HbOMmgEMezu
 yKD8GAZJw4hm9w7IAFBB4WoDQzW3RNULJLQmUHUPgeIO1+kyKd6VSGMd/FbnUqSjHLil
 Z41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GULY0uEf0Em8WP9qnivhLBLTo2xKP9b8kebOnqiMnnw=;
 b=DmYvDHP0ud8Y3K9K4sF0Hdq+MKZUA9R4+qk1bu7dqk6P9oEvwUXsQj3vQLJ+B+ryl5
 FB3tSDQuA2Bqz8GeFTbv5lD/7I7ZLpDrjZblvDiomRT9QFY2+ll8DUd3xQQGkPNrLXwM
 MwWLeRjj0tsFBwFr/8rKrxDHruOW92KNwzQzjdaHRqRRtlYOr9HgBhS9YKGBjMLvYiIs
 URiNx5yiwp+Gp5HojqXWEfRuhPmyOOQjvLSP+dlrsy+viGz5kRoEaDffNAFhUzpLyZpn
 tEJJjo5A3JBGc2zUrL4Mw2lvpNmm3RPeY+TCDiBA2YG7RQywQPODmhGnf7GDvKdwuYND
 4a/g==
X-Gm-Message-State: APjAAAV8/n7JCC2gqLzy5aZ/7iQEh9XJGeUv5cvJxev8cuqFlIY7Ae3n
 lKV1LJyXsIm82Y6aZB+jYNAQleFdthvJWb3Wleo=
X-Google-Smtp-Source: APXvYqyavC5nXIwPbuF57vt3I7wq5ZNljD9YggG/qdh10+Cy7V8VF8Hg/dmqWM/xP+jPqmUsicO2+qjKrxGxUr8eaQU=
X-Received: by 2002:a50:ee0d:: with SMTP id g13mr38537389eds.113.1566411360416; 
 Wed, 21 Aug 2019 11:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163808.6643-1-pratikshinde320@gmail.com>
 <20190821165633.GA30750@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190821165633.GA30750@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Wed, 21 Aug 2019 23:45:48 +0530
Message-ID: <CAGu0czR+=YmYLiu=dH1kiNJnXtLRzm0tuoND7oiYdVQ7ua4-pw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: erofs debug utility.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000b5b8ef0590a490fa"
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

--000000000000b5b8ef0590a490fa
Content-Type: text/plain; charset="UTF-8"

Thanks Gao,

Let me know when we can work on debug utility OR atleast list out things we
want to achieve through the utility.
Regarding the superblock checksum calculations, Yes I will dedicate
sometime this week for it. will start exploring it.

--Pratik.

On Wed, Aug 21, 2019 at 10:26 PM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Wed, Aug 21, 2019 at 10:08:08PM +0530, Pratik Shinde wrote:
> > Hello Maintainers,
> >
> > After going through the recent mail thread between linux's filesystem
> folks
> > on erofs channel, I felt erofs needs an interactive debug utility (like
> xfs_db)
> > which can be used to examine erofs images & can also be used to inject
> errors OR
> > fuzzing for testing purpose & dumping different erofs meta data
> structures
> > for debugging.
> > In order to demonstrate above I wrote an experimental patch that simply
> dumps
> > the superblock of an image after mkfs completes.the full fletch utility
> will run
> > independently and be able to seek / print / modify any byte of an erofs
> image,
> > dump structures/lists/directory content of an image.
>
> Yes, I think we really need that interactive tools, actually I'm stuggling
> in
> modifing Guifu's erofs-fuse now, we need to add the parsing ability to
> "lib/"
> first.
>
> I mean, first, I will add a "fuse" field to "cfg". If it is false, it will
> generate a image, or it will parse a image...
> And then we need to add parsing logic into "lib/" as well, and use
> "if (cfg.fuse)" to differnate whether it should read or write data.
>
> That is my prelimitary thought.. I will work on this framework in this
> weekend.
> and then we can work together on it. :)
>
> p.s. Pratik, if you have some time, could you take some extra time adding
> the
> super checksum calulation to EROFS? I mean we can add
> EROFS_FEATURE_SB_CHKSUM
> to the compat superblock field ("features"), and do crc32_le on kernel and
> mkfs...
> If you dont have time, I will do it later instead... (since we are using
> EROFS
> on the top of dm-verity, but completing the superblock chksum is also a
> good idea.)
>
> And then we can add block-based verification layer to EROFS, it can be seen
> as a hash tree like dm-verity or just simply CRC32 arrays for user to
> choise.
>
> Thanks,
> Gao Xiang
>
> >
> > NOTE:This is an experimental patch just to demonstrate the purpose. The
> patch
> > lacks a lot of things like coding standard, and new code runs in the
> context
> > of mkfs itself.kindly ignore it.
> >
> > kindly provide your feedback on this.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  include/erofs/io.h |  8 ++++++++
> >  lib/io.c           | 27 +++++++++++++++++++++++++++
> >  mkfs/main.c        | 36 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 71 insertions(+)
> >
> > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > index 4b574bd..e91d6ee 100644
> > --- a/include/erofs/io.h
> > +++ b/include/erofs/io.h
> > @@ -18,6 +18,7 @@
> >
> >  int dev_open(const char *devname);
> >  void dev_close(void);
> > +int dev_read(void *buf, u64 offset, size_t len);
> >  int dev_write(const void *buf, u64 offset, size_t len);
> >  int dev_fillzero(u64 offset, size_t len, bool padding);
> >  int dev_fsync(void);
> > @@ -30,5 +31,12 @@ static inline int blk_write(const void *buf,
> erofs_blk_t blkaddr,
> >                        blknr_to_addr(nblocks));
> >  }
> >
> > +static inline int blk_read(void *buf, erofs_blk_t blkaddr,
> > +                        u32 nblocks)
> > +{
> > +     return dev_read(buf, blknr_to_addr(blkaddr),
> > +                     blknr_to_addr(nblocks));
> > +}
> > +
> >  #endif
> >
> > diff --git a/lib/io.c b/lib/io.c
> > index 15c5a35..87d7d6c 100644
> > --- a/lib/io.c
> > +++ b/lib/io.c
> > @@ -109,6 +109,33 @@ u64 dev_length(void)
> >       return erofs_devsz;
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
> beyond the end of device(%" PRIu64 ").",
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
> > +
> >  int dev_write(const void *buf, u64 offset, size_t len)
> >  {
> >       int ret;
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index f127fe1..109486e 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct
> erofs_buffer_head *bh,
> >       return 0;
> >  }
> >
> > +void erofs_dump_super(char *img_path)
> > +{
> > +     struct erofs_super_block *sb;
> > +     char buf[EROFS_BLKSIZ];
> > +     unsigned int blksz;
> > +     int ret = 0;
> > +
> > +     if (img_path == NULL) {
> > +             erofs_err("image path cannot be null");
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
> > +             erofs_err("not a erofs image");
> > +             return;
> > +     }
> > +
> > +     erofs_dump("magic: 0x%x\n", le32_to_cpu(sb->magic));
> > +     blksz = 1 << sb->blkszbits;
> > +     erofs_dump("block size: %d\n", blksz);
> > +     erofs_dump("root inode: %d\n", le32_to_cpu(sb->root_nid));
> > +     erofs_dump("inodes: %llu\n", le64_to_cpu(sb->inos));
> > +     erofs_dump("build time: %u\n", le32_to_cpu(sb->build_time));
> > +     erofs_dump("blocks: %u\n", le32_to_cpu(sb->blocks));
> > +     erofs_dump("meta block: %u\n", le32_to_cpu(sb->meta_blkaddr));
> > +     erofs_dump("xattr block: %u\n", le32_to_cpu(sb->xattr_blkaddr));
> > +     erofs_dump("requirements: 0x%x\n", le32_to_cpu(sb->requirements));
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       int err = 0;
> > @@ -268,6 +303,7 @@ int main(int argc, char **argv)
> >               err = -EIO;
> >  exit:
> >       z_erofs_compress_exit();
> > +     erofs_dump_super("dummy");
> >       dev_close();
> >       erofs_exit_configure();
> >
> > --
> > 2.9.3
> >
>

--000000000000b5b8ef0590a490fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Gao,</div><div><br></div><div>Let me know when=
 we can work on debug utility OR atleast list out things we want to achieve=
 through the utility.</div><div>Regarding the superblock checksum calculati=
ons, Yes I will dedicate sometime this week for it. will start exploring it=
.</div><div><br></div><div>--Pratik.<br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 21, 2019 at 10:26=
 PM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">hsiangkao@aol.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi =
Pratik,<br>
<br>
On Wed, Aug 21, 2019 at 10:08:08PM +0530, Pratik Shinde wrote:<br>
&gt; Hello Maintainers,<br>
&gt; <br>
&gt; After going through the recent mail thread between linux&#39;s filesys=
tem folks<br>
&gt; on erofs channel, I felt erofs needs an interactive debug utility (lik=
e xfs_db)<br>
&gt; which can be used to examine erofs images &amp; can also be used to in=
ject errors OR<br>
&gt; fuzzing for testing purpose &amp; dumping different erofs meta data st=
ructures<br>
&gt; for debugging.<br>
&gt; In order to demonstrate above I wrote an experimental patch that simpl=
y dumps<br>
&gt; the superblock of an image after mkfs completes.the full fletch utilit=
y will run<br>
&gt; independently and be able to seek / print / modify any byte of an erof=
s image,<br>
&gt; dump structures/lists/directory content of an image.<br>
<br>
Yes, I think we really need that interactive tools, actually I&#39;m stuggl=
ing in<br>
modifing Guifu&#39;s erofs-fuse now, we need to add the parsing ability to =
&quot;lib/&quot;<br>
first.<br>
<br>
I mean, first, I will add a &quot;fuse&quot; field to &quot;cfg&quot;. If i=
t is false, it will<br>
generate a image, or it will parse a image...<br>
And then we need to add parsing logic into &quot;lib/&quot; as well, and us=
e <br>
&quot;if (cfg.fuse)&quot; to differnate whether it should read or write dat=
a.<br>
<br>
That is my prelimitary thought.. I will work on this framework in this week=
end.<br>
and then we can work together on it. :)<br>
<br>
p.s. Pratik, if you have some time, could you take some extra time adding t=
he<br>
super checksum calulation to EROFS? I mean we can add EROFS_FEATURE_SB_CHKS=
UM<br>
to the compat superblock field (&quot;features&quot;), and do crc32_le on k=
ernel and mkfs...<br>
If you dont have time, I will do it later instead... (since we are using ER=
OFS<br>
on the top of dm-verity, but completing the superblock chksum is also a goo=
d idea.)<br>
<br>
And then we can add block-based verification layer to EROFS, it can be seen=
<br>
as a hash tree like dm-verity or just simply CRC32 arrays for user to chois=
e.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; NOTE:This is an experimental patch just to demonstrate the purpose. Th=
e patch<br>
&gt; lacks a lot of things like coding standard, and new code runs in the c=
ontext<br>
&gt; of mkfs itself.kindly ignore it.<br>
&gt; <br>
&gt; kindly provide your feedback on this.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/io.h |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 lib/io.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 ++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 mkfs/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 ++++++++++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 71 insertions(+)<br>
&gt; <br>
&gt; diff --git a/include/erofs/io.h b/include/erofs/io.h<br>
&gt; index 4b574bd..e91d6ee 100644<br>
&gt; --- a/include/erofs/io.h<br>
&gt; +++ b/include/erofs/io.h<br>
&gt; @@ -18,6 +18,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int dev_open(const char *devname);<br>
&gt;=C2=A0 void dev_close(void);<br>
&gt; +int dev_read(void *buf, u64 offset, size_t len);<br>
&gt;=C2=A0 int dev_write(const void *buf, u64 offset, size_t len);<br>
&gt;=C2=A0 int dev_fillzero(u64 offset, size_t len, bool padding);<br>
&gt;=C2=A0 int dev_fsync(void);<br>
&gt; @@ -30,5 +31,12 @@ static inline int blk_write(const void *buf, erofs_=
blk_t blkaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 blknr_to_addr(nblocks));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static inline int blk_read(void *buf, erofs_blk_t blkaddr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 u32 nblocks)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return dev_read(buf, blknr_to_addr(blkaddr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0blknr_to_addr(nblocks));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/lib/io.c b/lib/io.c<br>
&gt; index 15c5a35..87d7d6c 100644<br>
&gt; --- a/lib/io.c<br>
&gt; +++ b/lib/io.c<br>
&gt; @@ -109,6 +109,33 @@ u64 dev_length(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_devsz;<br>
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
posion[%&quot; PRIu64 &quot;, %zd] is too large beyond the end of device(%&=
quot; PRIu64 &quot;).&quot;,<br>
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
&gt; +<br>
&gt;=C2=A0 int dev_write(const void *buf, u64 offset, size_t len)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; diff --git a/mkfs/main.c b/mkfs/main.c<br>
&gt; index f127fe1..109486e 100644<br>
&gt; --- a/mkfs/main.c<br>
&gt; +++ b/mkfs/main.c<br>
&gt; @@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct erofs_bu=
ffer_head *bh,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +void erofs_dump_super(char *img_path)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_super_block *sb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char buf[EROFS_BLKSIZ];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int blksz;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (img_path =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_err(&quot;image=
 path cannot be null&quot;);<br>
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
 erofs image&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;magic: 0x%x\n&quot;, le32_to_cpu=
(sb-&gt;magic));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0blksz =3D 1 &lt;&lt; sb-&gt;blkszbits;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;block size: %d\n&quot;, blksz);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;root inode: %d\n&quot;, le32_to_=
cpu(sb-&gt;root_nid));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;inodes: %llu\n&quot;, le64_to_cp=
u(sb-&gt;inos));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;build time: %u\n&quot;, le32_to_=
cpu(sb-&gt;build_time));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;blocks: %u\n&quot;, le32_to_cpu(=
sb-&gt;blocks));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;meta block: %u\n&quot;, le32_to_=
cpu(sb-&gt;meta_blkaddr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;xattr block: %u\n&quot;, le32_to=
_cpu(sb-&gt;xattr_blkaddr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump(&quot;requirements: 0x%x\n&quot;, le32=
_to_cpu(sb-&gt;requirements));<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;<br>
&gt; @@ -268,6 +303,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -EIO;<br=
>
&gt;=C2=A0 exit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0z_erofs_compress_exit();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_dump_super(&quot;dummy&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_close();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_exit_configure();<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--000000000000b5b8ef0590a490fa--
