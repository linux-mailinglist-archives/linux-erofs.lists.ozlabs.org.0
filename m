Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A1E09A1
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 18:49:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yKGW00t5zDqM9
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 03:49:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oHPevc4x"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yKGQ0rX7zDqLx
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 03:49:01 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id y7so5902844edo.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HSXxk5yUP3UoC+iGkMjMO+TdsKdxlIh48irCCCvpkG0=;
 b=oHPevc4x9doTpVNUrQNbWHNG1PwM6SD9wxyUPVrpqFiUMvvklRHd6GaszXiH+00QmD
 TMiJDxALRdJyMZ3C6LMSsxlCwMk1tfxo9X8Op+BinZEQUvIY3IvpQGrBH4l0jjSvsEGE
 3BqChBgf9s7aIe7JufamZgtOJZ8kFZQhz0MFz81wlKzs+L9jmSbopycKwy0khIDKIiA4
 g2rnvgtJX26T7qXrXbGFo9gY7jaxo4EYB9BXKzIaFpZaMfdlvL8FpcPWHl9V28AZHiy9
 PXsfi5jxwEz2Ju0PENsMsZ+crtaYFcb0+UhQ+GUAqiPW22QBmOEYeAqNnBewcgwo2ALu
 CXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HSXxk5yUP3UoC+iGkMjMO+TdsKdxlIh48irCCCvpkG0=;
 b=qkuJuybpu11G3hAOyx4U9AlcPrSPrf58tqnCj0D7VVDlbx2p10v+KBVulp6SxzvS7a
 xDAmHPKtbAj0AW1Eqk5QgsAllTeE0S5ae+TY4XQLSODSdnwVMKdY5LiwG0vIouh4AQiB
 wwkeHFXu0ykdHc4p9XElhElKkzq/p55PX9S48G+Vgg0fUEXEmtAFKsLCeiBsPpjbm1Zo
 4MHw3dYt8NpUf52TUAHvg0gjswvDCwMULfaDN4L66j6st3nxr9YieMIpRBXJ7lhvdT3I
 9fuylqhVUfYXogRX5wA973GLnvcSU95Bb1ZXFav8P5wZG3FI7KwO7fbELrlmlq/lajSI
 UFZw==
X-Gm-Message-State: APjAAAXO8S1o96VUWtENxLNu1VSIQ2KTWdnLNN/qjyv6PZHOtBzTOH6H
 z16u6lWF9dxC/uu94d3Ny/O7mVsln5nBf6y2ZgM=
X-Google-Smtp-Source: APXvYqysRiCQLTD/oQmG/ReocwrWa5kfC/EY6yQwTQjRi32dstbaIDLVU3DZgYCv3fAdAcgjkDcYY5lEpG54bu/BVjQ=
X-Received: by 2002:a50:af44:: with SMTP id g62mr32525730edd.164.1571762937118; 
 Tue, 22 Oct 2019 09:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191022153956.16867-1-pratikshinde320@gmail.com>
 <20191022163403.GA3201@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191022163403.GA3201@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 22 Oct 2019 22:18:23 +0530
Message-ID: <CAGu0czRBfVa+1WPCBYP2JAYRhRBXkn20-YmVw9J3XUbCxw0cNg@mail.gmail.com>
Subject: Re: [PATCH-v2] erofs: code for verifying superblock checksum of an
 erofs image.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="00000000000089c7f90595829366"
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000089c7f90595829366
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Understood your concern.

Can we do something like :

1) Allocate one buf of size EROFS_BLKSIZ
2) Read one page at a time into buf(memcpy) .call crc32c for it.

In this way we won't be writing directly into page data and will not do
large allocation.
What do you think?

--Pratik

On Tue, 22 Oct, 2019, 10:04 PM Gao Xiang, <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> Some comments as below...
>
> On Tue, Oct 22, 2019 at 09:09:56PM +0530, Pratik Shinde wrote:
> > Patch for kernel side changes of checksum feature.Used kernel's
> > crc32c library for calculating the checksum.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  fs/erofs/erofs_fs.h |  5 +++--
> >  fs/erofs/internal.h |  3 ++-
> >  fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index b1ee565..4d8097a 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -17,6 +17,7 @@
> >   */
> >  #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING  0x00000001
> >  #define EROFS_ALL_FEATURE_INCOMPAT
>  EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
> > +#define EROFS_FEATURE_COMPAT_SB_CHKSUM               0x00000001
> >
> >  /* 128-byte erofs on-disk super block */
> >  struct erofs_super_block {
> > @@ -37,8 +38,8 @@ struct erofs_super_block {
> >       __u8 uuid[16];          /* 128-bit uuid for volume */
> >       __u8 volume_name[16];   /* volume name */
> >       __le32 feature_incompat;
> > -
> > -     __u8 reserved2[44];
> > +     __le32 chksum_blocks;   /* number of blocks used for checksum */
> > +     __u8 reserved2[40];
> >  };
> >
> >  /*
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 544a453..cec27ca 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -86,7 +86,7 @@ struct erofs_sb_info {
> >       u8 uuid[16];                    /* 128-bit uuid for volume */
> >       u8 volume_name[16];             /* volume name */
> >       u32 feature_incompat;
> > -
> > +     u32 feature_compat;
> >       unsigned int mount_opt;
> >  };
> >
> > @@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void)
> {}
> >  #endif       /* !CONFIG_EROFS_FS_ZIP */
> >
> >  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> > +#define EFSBADCRC    EBADMSG         /* Bad crc found */
> >
> >  #endif       /* __EROFS_INTERNAL_H */
> >
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 0e36949..9cda72d 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/statfs.h>
> >  #include <linux/parser.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/crc32c.h>
> >  #include "xattr.h"
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char
> *function,
> >       va_end(args);
> >  }
> >
> > +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,
> > +                                    struct super_block *sb)
> > +{
> > +     u32 disk_chksum, nblocks, crc = 0;
> > +     void *kaddr;
> > +     struct page *page;
> > +     int i;
> > +
> > +     disk_chksum = le32_to_cpu(dsb->checksum);
> > +     nblocks = le32_to_cpu(dsb->chksum_blocks);
>
> We cannot write the page data directly since the page cache should be kept
> in
> sync with ondisk data (or for read-write fs, if it's claimed as uptodated,
> and
> it is modified later,  you should mark it dirty, and do writeback then, but
> that is not the erofs case.)
>
> > +     dsb->checksum = 0;
> > +     for (i = 0; i < nblocks; i++) {
> > +             page = erofs_get_meta_page(sb, i);
> > +             if (IS_ERR(page))
> > +                     return PTR_ERR(page);
> > +             kaddr = kmap(page);
>
> Here kmap_atomic(page) is better. what I mean is kmap_atomic() in the
> caller
> erofs_read_superblock(), it should be replaced to kmap() instead.
>
> > +             crc = crc32c(crc, kaddr, EROFS_BLKSIZ);
> > +             kunmap(page);
> > +             unlock_page(page);
>
> need
>                 put_page(page);
>
>
> I'm not sure whether I explained quite well, but this patch needs something
> to do. I'm now working on demonstrating new XZ algorithm and releasing
> erofs-utils v1.0.
>
> You can give more tries or I will help later. :-)
>
> Thanks,
> Gao Xiang
>
>
> > +     }
> > +     if (crc != disk_chksum)
> > +             return -EFSBADCRC;
> > +     return 0;
> > +}
> > +
> >  static void erofs_inode_init_once(void *ptr)
> >  {
> >       struct erofs_inode *vi = ptr;
> > @@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_block
> *sb)
> >               goto out;
> >       }
> >
> > +     if (dsb->feature_compat & EROFS_FEATURE_COMPAT_SB_CHKSUM) {
> > +             ret = erofs_validate_sb_chksum(dsb, sb);
> > +             if (ret < 0) {
> > +                     erofs_err(sb, "super block checksum incorrect");
> > +                     goto out;
> > +             }
> > +     }
> >       blkszbits = dsb->blkszbits;
> >       /* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
> >       if (blkszbits != LOG_BLOCK_SIZE) {
> > --
> > 2.9.3
> >
>

--00000000000089c7f90595829366
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto=
">Understood your concern.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Can we do something like :</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">1) Allocate one buf of size EROFS_BLKSIZ</div><div dir=3D"auto">2) Re=
ad one page at a time into buf(memcpy) .call crc32c for it.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">In this way we won&#39;t be writing d=
irectly into page data and will not do large allocation.</div><div dir=3D"a=
uto">What do you think?</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
--Pratik</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, 22 Oct, 2019, 10:04 PM Gao Xiang, &lt;<a href=3D"ma=
ilto:hsiangkao@aol.com" target=3D"_blank" rel=3D"noreferrer">hsiangkao@aol.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Pratik,<br>
<br>
Some comments as below...<br>
<br>
On Tue, Oct 22, 2019 at 09:09:56PM +0530, Pratik Shinde wrote:<br>
&gt; Patch for kernel side changes of checksum feature.Used kernel&#39;s<br=
>
&gt; crc32c library for calculating the checksum.<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" rel=3D"noreferrer noreferrer" target=3D"_blank">pratikshinde320@gma=
il.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 fs/erofs/erofs_fs.h |=C2=A0 5 +++--<br>
&gt;=C2=A0 fs/erofs/internal.h |=C2=A0 3 ++-<br>
&gt;=C2=A0 fs/erofs/super.c=C2=A0 =C2=A0 | 33 +++++++++++++++++++++++++++++=
++++<br>
&gt;=C2=A0 3 files changed, 38 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h<br>
&gt; index b1ee565..4d8097a 100644<br>
&gt; --- a/fs/erofs/erofs_fs.h<br>
&gt; +++ b/fs/erofs/erofs_fs.h<br>
&gt; @@ -17,6 +17,7 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING=C2=A0 0x00000001<br>
&gt;=C2=A0 #define EROFS_ALL_FEATURE_INCOMPAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0EROFS_FEATURE_INCOMPAT_LZ4_0PADDING<br>
&gt; +#define EROFS_FEATURE_COMPAT_SB_CHKSUM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x00000001<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* 128-byte erofs on-disk super block */<br>
&gt;=C2=A0 struct erofs_super_block {<br>
&gt; @@ -37,8 +38,8 @@ struct erofs_super_block {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* 128-bit uuid for volume */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 volume_name[16];=C2=A0 =C2=A0/* volume =
name */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__le32 feature_incompat;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0__u8 reserved2[44];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 chksum_blocks;=C2=A0 =C2=A0/* number of bl=
ocks used for checksum */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 reserved2[40];<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h<br>
&gt; index 544a453..cec27ca 100644<br>
&gt; --- a/fs/erofs/internal.h<br>
&gt; +++ b/fs/erofs/internal.h<br>
&gt; @@ -86,7 +86,7 @@ struct erofs_sb_info {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 uuid[16];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 128-bit uuid for volume */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 volume_name[16];=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* volume name */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 feature_incompat;<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 feature_compat;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int mount_opt;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; @@ -426,6 +426,7 @@ static inline void z_erofs_exit_zip_subsystem(void=
) {}<br>
&gt;=C2=A0 #endif=C2=A0 =C2=A0 =C2=A0 =C2=A0/* !CONFIG_EROFS_FS_ZIP */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define EFSCORRUPTED=C2=A0 =C2=A0 EUCLEAN=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Filesystem is corrupted */<br>
&gt; +#define EFSBADCRC=C2=A0 =C2=A0 EBADMSG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Bad crc found */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif=C2=A0 =C2=A0 =C2=A0 =C2=A0/* __EROFS_INTERNAL_H */<br>
&gt;=C2=A0 <br>
&gt; diff --git a/fs/erofs/super.c b/fs/erofs/super.c<br>
&gt; index 0e36949..9cda72d 100644<br>
&gt; --- a/fs/erofs/super.c<br>
&gt; +++ b/fs/erofs/super.c<br>
&gt; @@ -9,6 +9,7 @@<br>
&gt;=C2=A0 #include &lt;linux/statfs.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/parser.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/seq_file.h&gt;<br>
&gt; +#include &lt;linux/crc32c.h&gt;<br>
&gt;=C2=A0 #include &quot;xattr.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define CREATE_TRACE_POINTS<br>
&gt; @@ -46,6 +47,31 @@ void _erofs_info(struct super_block *sb, const char=
 *function,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0va_end(args);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int erofs_validate_sb_chksum(struct erofs_super_block *dsb,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct super_block=
 *sb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 disk_chksum, nblocks, crc =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void *kaddr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct page *page;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0disk_chksum =3D le32_to_cpu(dsb-&gt;checksum);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0nblocks =3D le32_to_cpu(dsb-&gt;chksum_blocks);<b=
r>
<br>
We cannot write the page data directly since the page cache should be kept =
in<br>
sync with ondisk data (or for read-write fs, if it&#39;s claimed as uptodat=
ed, and<br>
it is modified later,=C2=A0 you should mark it dirty, and do writeback then=
, but<br>
that is not the erofs case.)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dsb-&gt;checksum =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page =3D erofs_get_me=
ta_page(sb, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(page))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return PTR_ERR(page);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kaddr =3D kmap(page);=
<br>
<br>
Here kmap_atomic(page) is better. what I mean is kmap_atomic() in the calle=
r<br>
erofs_read_superblock(), it should be replaced to kmap() instead.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crc =3D crc32c(crc, k=
addr, EROFS_BLKSIZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kunmap(page);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlock_page(page);<br=
>
<br>
need<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_page(page);<br>
<br>
<br>
I&#39;m not sure whether I explained quite well, but this patch needs somet=
hing<br>
to do. I&#39;m now working on demonstrating new XZ algorithm and releasing<=
br>
erofs-utils v1.0.<br>
<br>
You can give more tries or I will help later. :-)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (crc !=3D disk_chksum)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFSBADCRC;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void erofs_inode_init_once(void *ptr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *vi =3D ptr;<br>
&gt; @@ -121,6 +147,13 @@ static int erofs_read_superblock(struct super_blo=
ck *sb)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (dsb-&gt;feature_compat &amp; EROFS_FEATURE_CO=
MPAT_SB_CHKSUM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D erofs_validat=
e_sb_chksum(dsb, sb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0erofs_err(sb, &quot;super block checksum incorrect&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0blkszbits =3D dsb-&gt;blkszbits;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK =3D=
=3D LOG_BLOCK_SIZE */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (blkszbits !=3D LOG_BLOCK_SIZE) {<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--00000000000089c7f90595829366--
