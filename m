Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C98526831F
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 07:11:33 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nBTH15pQzDqTm
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jul 2019 15:11:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u7u4ACSd"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nBT92YVMzDqQN
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jul 2019 15:11:25 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id p15so14059132eds.8
 for <linux-erofs@lists.ozlabs.org>; Sun, 14 Jul 2019 22:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qwHBnwRjsQ/jt3yag8U6ImUqBn8ZP6p2EmeZmTGoLgo=;
 b=u7u4ACSdeg++BUk37WUaN8kRyH9m8SyWuaofLJujepdwxPH9w4fdoIWY4BdyuZ4UCx
 t1MLj68XlbSlTJXlS8scvf1hfaL17KNVgxFpSrNjRwPT2dxE0D8xJZ/sneskoWiQJtqy
 C5U4RgpMaYguUCe9heD0IQ5AQ50APVSXs8wwVTPtNzjJCjVaQD8j01MymG1s0xxk1Dhv
 clmeCZcGQCSJXLeDEGGGU4TElT3O/N/83XfKmXVjatFYBarf4aj0os/WyHfI7Te9lKcn
 FKr/i3hVutqIOS1BUialFtqFObvlcaN9lZVu4OIlhBqjXz+ynwy27tu13IeL/yVYG6pe
 i36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qwHBnwRjsQ/jt3yag8U6ImUqBn8ZP6p2EmeZmTGoLgo=;
 b=kAOm6TVbe2GRJA7iyLZqp9XRWbXHx3KHm6RiUrju1eb8kebehKyKy1zKGsaSeOKDRs
 WIdTwtLGDMab08qKKhkgIDF7Hl6ODruG9rWdXUm4WvAdEWDSnMk9lc2FGrZdPUbwyKxN
 DbnrPKpp3l4FB4eDjF+Tgps3KzdWL0l4GVY8jusUFqCHVn86aH60oWn2XCWhm7wPiRqz
 HP/FnOuJfPgw27122QRDQn/pt8mqBNUoO4PoWPPpOPPtMvpSI5SPgnXVRFrVkzIfWw0n
 KCGQ2cisgUHvPugobbMz7eHFfOA3LJKXn/rJ+N8qN8NX3qJNWcPNlpnlQppH0Rm+eipE
 Bnmw==
X-Gm-Message-State: APjAAAWW1i26e6QXNn9xZWvVdPgjWKJvy4+R4ZQwyxXozbBDIjcW8mD5
 sTFfWSWMHVNZrJ7R4fdYZ2YvE4p6H4+10otuLUw=
X-Google-Smtp-Source: APXvYqz+AjT6Fp/Q/FQWDccHi2wolKTtaUCvvDK+7+5jcCywflYJCmW1QmuBK36MlldDJQa+0rUFUhbZmW561S7zvhU=
X-Received: by 2002:a17:906:1594:: with SMTP id
 k20mr18597721ejd.49.1563167480774; 
 Sun, 14 Jul 2019 22:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190714193019.9816-1-pratikshinde320@gmail.com>
 <3445a2e2-3911-8929-a0fe-f4fa226f6097@huawei.com>
In-Reply-To: <3445a2e2-3911-8929-a0fe-f4fa226f6097@huawei.com>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 15 Jul 2019 10:41:09 +0530
Message-ID: <CAGu0czSzbVnZxvhCiTVZmOthA7RTnq6N0fXMJTnuoxanFdPPtw@mail.gmail.com>
Subject: Re: [PATCH] Staging: erofs:converting all 'unsigned' to 'unsigned int'
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000006a8357058db14aae"
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000006a8357058db14aae
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

I will rework the patch.
Will take care of the patch subject & '80 characters line limit'

Thanks,
Pratik.

On Mon, Jul 15, 2019 at 7:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On 2019/7/15 3:30, Pratik Shinde wrote:
> > Fixing checkpath warnings : converting all 'unsigned' to 'unsigned int'
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  drivers/staging/erofs/internal.h      |  6 +++---
> >  drivers/staging/erofs/unzip_pagevec.h | 10 +++++-----
> >  drivers/staging/erofs/unzip_vle.h     |  8 ++++----
> >  drivers/staging/erofs/xattr.h         | 10 +++++-----
> >  4 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/staging/erofs/internal.h
> b/drivers/staging/erofs/internal.h
> > index 963cc1b..daae90b 100644
> > --- a/drivers/staging/erofs/internal.h
> > +++ b/drivers/staging/erofs/internal.h
> > @@ -359,8 +359,8 @@ struct erofs_vnode {
> >       unsigned char inode_isize;
> >       unsigned short xattr_isize;
> >
> > -     unsigned xattr_shared_count;
> > -     unsigned *xattr_shared_xattrs;
> > +     unsigned int xattr_shared_count;
> > +     unsigned int *xattr_shared_xattrs;
> >
> >       union {
> >               erofs_blk_t raw_blkaddr;
> > @@ -510,7 +510,7 @@ erofs_grab_bio(struct super_block *sb,
> >       return bio;
> >  }
> >
> > -static inline void __submit_bio(struct bio *bio, unsigned op, unsigned
> op_flags)
> > +static inline void __submit_bio(struct bio *bio, unsigned int op,
> unsigned int op_flags)
>
> The subject line could be better as "staging: erofs: converting all
> 'unsigned' to 'unsigned int' "
> and three new checkpatch warnings occurs after this patch...
>
>
> WARNING: line over 80 characters
> #86: FILE: drivers/staging/erofs/internal.h:513:
> +static inline void __submit_bio(struct bio *bio, unsigned int op,
> unsigned int op_flags)
>
> WARNING: line over 80 characters
> #122: FILE: drivers/staging/erofs/unzip_pagevec.h:95:
> +                                            erofs_vtptr_t *pages,
> unsigned int i)
>
> WARNING: line over 80 characters
> #203: FILE: drivers/staging/erofs/xattr.h:52:
> +static inline const struct xattr_handler *erofs_xattr_handler(unsigned
> int index)
>
> Thanks,
> Gao Xiang
>
> >  {
> >       bio_set_op_attrs(bio, op, op_flags);
> >       submit_bio(bio);
> > diff --git a/drivers/staging/erofs/unzip_pagevec.h
> b/drivers/staging/erofs/unzip_pagevec.h
> > index 7af0ba8..198b556 100644
> > --- a/drivers/staging/erofs/unzip_pagevec.h
> > +++ b/drivers/staging/erofs/unzip_pagevec.h
> > @@ -54,9 +54,9 @@ static inline void z_erofs_pagevec_ctor_exit(struct
> z_erofs_pagevec_ctor *ctor,
> >
> >  static inline struct page *
> >  z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
> > -                            unsigned nr)
> > +                            unsigned int nr)
> >  {
> > -     unsigned index;
> > +     unsigned int index;
> >
> >       /* keep away from occupied pages */
> >       if (ctor->next)
> > @@ -64,7 +64,7 @@ z_erofs_pagevec_ctor_next_page(struct
> z_erofs_pagevec_ctor *ctor,
> >
> >       for (index = 0; index < nr; ++index) {
> >               const erofs_vtptr_t t = ctor->pages[index];
> > -             const unsigned tags = tagptr_unfold_tags(t);
> > +             const unsigned int tags = tagptr_unfold_tags(t);
> >
> >               if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
> >                       return tagptr_unfold_ptr(t);
> > @@ -91,8 +91,8 @@ z_erofs_pagevec_ctor_pagedown(struct
> z_erofs_pagevec_ctor *ctor,
> >  }
> >
> >  static inline void z_erofs_pagevec_ctor_init(struct
> z_erofs_pagevec_ctor *ctor,
> > -                                          unsigned nr,
> > -                                          erofs_vtptr_t *pages,
> unsigned i)
> > +                                          unsigned int nr,
> > +                                          erofs_vtptr_t *pages,
> unsigned int i)
> >  {
> >       ctor->nr = nr;
> >       ctor->curr = ctor->next = NULL;
> > diff --git a/drivers/staging/erofs/unzip_vle.h
> b/drivers/staging/erofs/unzip_vle.h
> > index ab509d75..df91ad1 100644
> > --- a/drivers/staging/erofs/unzip_vle.h
> > +++ b/drivers/staging/erofs/unzip_vle.h
> > @@ -34,7 +34,7 @@ struct z_erofs_vle_work {
> >       unsigned short nr_pages;
> >
> >       /* L: queued pages in pagevec[] */
> > -     unsigned vcnt;
> > +     unsigned int vcnt;
> >
> >       union {
> >               /* L: pagevec */
> > @@ -124,7 +124,7 @@ union z_erofs_onlinepage_converter {
> >       unsigned long *v;
> >  };
> >
> > -static inline unsigned z_erofs_onlinepage_index(struct page *page)
> > +static inline unsigned int z_erofs_onlinepage_index(struct page *page)
> >  {
> >       union z_erofs_onlinepage_converter u;
> >
> > @@ -164,7 +164,7 @@ static inline void z_erofs_onlinepage_fixup(struct
> page *page,
> >       }
> >
> >       v = (index << Z_EROFS_ONLINEPAGE_INDEX_SHIFT) |
> > -             ((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned)down);
> > +             ((o & Z_EROFS_ONLINEPAGE_COUNT_MASK) + (unsigned int)down);
> >       if (cmpxchg(p, o, v) != o)
> >               goto repeat;
> >  }
> > @@ -172,7 +172,7 @@ static inline void z_erofs_onlinepage_fixup(struct
> page *page,
> >  static inline void z_erofs_onlinepage_endio(struct page *page)
> >  {
> >       union z_erofs_onlinepage_converter u;
> > -     unsigned v;
> > +     unsigned int v;
> >
> >       DBG_BUGON(!PagePrivate(page));
> >       u.v = &page_private(page);
> > diff --git a/drivers/staging/erofs/xattr.h
> b/drivers/staging/erofs/xattr.h
> > index 35ba5ac..2fc9b43 100644
> > --- a/drivers/staging/erofs/xattr.h
> > +++ b/drivers/staging/erofs/xattr.h
> > @@ -20,14 +20,14 @@
> >  /* Attribute not found */
> >  #define ENOATTR         ENODATA
> >
> > -static inline unsigned inlinexattr_header_size(struct inode *inode)
> > +static inline unsigned int inlinexattr_header_size(struct inode *inode)
> >  {
> >       return sizeof(struct erofs_xattr_ibody_header)
> >               + sizeof(u32) * EROFS_V(inode)->xattr_shared_count;
> >  }
> >
> >  static inline erofs_blk_t
> > -xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)
> > +xattrblock_addr(struct erofs_sb_info *sbi, unsigned int xattr_id)
> >  {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >       return sbi->xattr_blkaddr +
> > @@ -37,8 +37,8 @@ xattrblock_addr(struct erofs_sb_info *sbi, unsigned
> xattr_id)
> >  #endif
> >  }
> >
> > -static inline unsigned
> > -xattrblock_offset(struct erofs_sb_info *sbi, unsigned xattr_id)
> > +static inline unsigned int
> > +xattrblock_offset(struct erofs_sb_info *sbi, unsigned int xattr_id)
> >  {
> >       return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
> >  }
> > @@ -49,7 +49,7 @@ extern const struct xattr_handler
> erofs_xattr_trusted_handler;
> >  extern const struct xattr_handler erofs_xattr_security_handler;
> >  #endif
> >
> > -static inline const struct xattr_handler *erofs_xattr_handler(unsigned
> index)
> > +static inline const struct xattr_handler *erofs_xattr_handler(unsigned
> int index)
> >  {
> >  static const struct xattr_handler *xattr_handler_map[] = {
> >       [EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
> >
>

--0000000000006a8357058db14aae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Gao,</div><div><br></div><div>I will rework the pa=
tch.<br></div><div>Will take care of the patch subject &amp; &#39;80 charac=
ters line limit&#39;</div><div><br></div><div>Thanks,</div><div>Pratik.<br>=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Mon, Jul 15, 2019 at 7:54 AM Gao Xiang &lt;<a href=3D"mailto:gaoxi=
ang25@huawei.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi Pratik,<br>
<br>
On 2019/7/15 3:30, Pratik Shinde wrote:<br>
&gt; Fixing checkpath warnings : converting all &#39;unsigned&#39; to &#39;=
unsigned int&#39;<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/staging/erofs/internal.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +=
++---<br>
&gt;=C2=A0 drivers/staging/erofs/unzip_pagevec.h | 10 +++++-----<br>
&gt;=C2=A0 drivers/staging/erofs/unzip_vle.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +=
+++----<br>
&gt;=C2=A0 drivers/staging/erofs/xattr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 10 +++++-----<br>
&gt;=C2=A0 4 files changed, 17 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/=
internal.h<br>
&gt; index 963cc1b..daae90b 100644<br>
&gt; --- a/drivers/staging/erofs/internal.h<br>
&gt; +++ b/drivers/staging/erofs/internal.h<br>
&gt; @@ -359,8 +359,8 @@ struct erofs_vnode {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char inode_isize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned short xattr_isize;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned xattr_shared_count;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned *xattr_shared_xattrs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int xattr_shared_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int *xattr_shared_xattrs;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_blk_t raw_=
blkaddr;<br>
&gt; @@ -510,7 +510,7 @@ erofs_grab_bio(struct super_block *sb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return bio;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static inline void __submit_bio(struct bio *bio, unsigned op, unsigne=
d op_flags)<br>
&gt; +static inline void __submit_bio(struct bio *bio, unsigned int op, uns=
igned int op_flags)<br>
<br>
The subject line could be better as &quot;staging: erofs: converting all &#=
39;unsigned&#39; to &#39;unsigned int&#39; &quot;<br>
and three new checkpatch warnings occurs after this patch...<br>
<br>
<br>
WARNING: line over 80 characters<br>
#86: FILE: drivers/staging/erofs/internal.h:513:<br>
+static inline void __submit_bio(struct bio *bio, unsigned int op, unsigned=
 int op_flags)<br>
<br>
WARNING: line over 80 characters<br>
#122: FILE: drivers/staging/erofs/unzip_pagevec.h:95:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 erofs_vtptr_t *pages, unsigned int i)<br>
<br>
WARNING: line over 80 characters<br>
#203: FILE: drivers/staging/erofs/xattr.h:52:<br>
+static inline const struct xattr_handler *erofs_xattr_handler(unsigned int=
 index)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bio_set_op_attrs(bio, op, op_flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0submit_bio(bio);<br>
&gt; diff --git a/drivers/staging/erofs/unzip_pagevec.h b/drivers/staging/e=
rofs/unzip_pagevec.h<br>
&gt; index 7af0ba8..198b556 100644<br>
&gt; --- a/drivers/staging/erofs/unzip_pagevec.h<br>
&gt; +++ b/drivers/staging/erofs/unzip_pagevec.h<br>
&gt; @@ -54,9 +54,9 @@ static inline void z_erofs_pagevec_ctor_exit(struct =
z_erofs_pagevec_ctor *ctor,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static inline struct page *<br>
&gt;=C2=A0 z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned nr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int nr)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned index;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int index;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep away from occupied pages */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctor-&gt;next)<br>
&gt; @@ -64,7 +64,7 @@ z_erofs_pagevec_ctor_next_page(struct z_erofs_pageve=
c_ctor *ctor,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (index =3D 0; index &lt; nr; ++index) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const erofs_vtpt=
r_t t =3D ctor-&gt;pages[index];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned tags =
=3D tagptr_unfold_tags(t);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const unsigned int ta=
gs =3D tagptr_unfold_tags(t);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tags =3D=3D =
Z_EROFS_PAGE_TYPE_EXCLUSIVE)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return tagptr_unfold_ptr(t);<br>
&gt; @@ -91,8 +91,8 @@ z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec=
_ctor *ctor,<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static inline void z_erofs_pagevec_ctor_init(struct z_erofs_page=
vec_ctor *ctor,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned nr,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 erofs_vtptr_t *pages, unsigned i)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 unsigned int nr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 erofs_vtptr_t *pages, unsigned int i)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ctor-&gt;nr =3D nr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ctor-&gt;curr =3D ctor-&gt;next =3D NULL;<br=
>
&gt; diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs=
/unzip_vle.h<br>
&gt; index ab509d75..df91ad1 100644<br>
&gt; --- a/drivers/staging/erofs/unzip_vle.h<br>
&gt; +++ b/drivers/staging/erofs/unzip_vle.h<br>
&gt; @@ -34,7 +34,7 @@ struct z_erofs_vle_work {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned short nr_pages;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* L: queued pages in pagevec[] */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned vcnt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int vcnt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* L: pagevec */=
<br>
&gt; @@ -124,7 +124,7 @@ union z_erofs_onlinepage_converter {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long *v;<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -static inline unsigned z_erofs_onlinepage_index(struct page *page)<br=
>
&gt; +static inline unsigned int z_erofs_onlinepage_index(struct page *page=
)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union z_erofs_onlinepage_converter u;<br>
&gt;=C2=A0 <br>
&gt; @@ -164,7 +164,7 @@ static inline void z_erofs_onlinepage_fixup(struct=
 page *page,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D (index &lt;&lt; Z_EROFS_ONLINEPAGE_IND=
EX_SHIFT) |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((o &amp; Z_EROFS_ONL=
INEPAGE_COUNT_MASK) + (unsigned)down);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((o &amp; Z_EROFS_ONL=
INEPAGE_COUNT_MASK) + (unsigned int)down);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmpxchg(p, o, v) !=3D o)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto repeat;<br>
&gt;=C2=A0 }<br>
&gt; @@ -172,7 +172,7 @@ static inline void z_erofs_onlinepage_fixup(struct=
 page *page,<br>
&gt;=C2=A0 static inline void z_erofs_onlinepage_endio(struct page *page)<b=
r>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0union z_erofs_onlinepage_converter u;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned v;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int v;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG_BUGON(!PagePrivate(page));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u.v =3D &amp;page_private(page);<br>
&gt; diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xat=
tr.h<br>
&gt; index 35ba5ac..2fc9b43 100644<br>
&gt; --- a/drivers/staging/erofs/xattr.h<br>
&gt; +++ b/drivers/staging/erofs/xattr.h<br>
&gt; @@ -20,14 +20,14 @@<br>
&gt;=C2=A0 /* Attribute not found */<br>
&gt;=C2=A0 #define ENOATTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ENODATA<br>
&gt;=C2=A0 <br>
&gt; -static inline unsigned inlinexattr_header_size(struct inode *inode)<b=
r>
&gt; +static inline unsigned int inlinexattr_header_size(struct inode *inod=
e)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return sizeof(struct erofs_xattr_ibody_heade=
r)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ sizeof(u32) * =
EROFS_V(inode)-&gt;xattr_shared_count;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static inline erofs_blk_t<br>
&gt; -xattrblock_addr(struct erofs_sb_info *sbi, unsigned xattr_id)<br>
&gt; +xattrblock_addr(struct erofs_sb_info *sbi, unsigned int xattr_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 #ifdef CONFIG_EROFS_FS_XATTR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return sbi-&gt;xattr_blkaddr +<br>
&gt; @@ -37,8 +37,8 @@ xattrblock_addr(struct erofs_sb_info *sbi, unsigned =
xattr_id)<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static inline unsigned<br>
&gt; -xattrblock_offset(struct erofs_sb_info *sbi, unsigned xattr_id)<br>
&gt; +static inline unsigned int<br>
&gt; +xattrblock_offset(struct erofs_sb_info *sbi, unsigned int xattr_id)<b=
r>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return (xattr_id * sizeof(__u32)) % EROFS_BL=
KSIZ;<br>
&gt;=C2=A0 }<br>
&gt; @@ -49,7 +49,7 @@ extern const struct xattr_handler erofs_xattr_truste=
d_handler;<br>
&gt;=C2=A0 extern const struct xattr_handler erofs_xattr_security_handler;<=
br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; -static inline const struct xattr_handler *erofs_xattr_handler(unsigne=
d index)<br>
&gt; +static inline const struct xattr_handler *erofs_xattr_handler(unsigne=
d int index)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 static const struct xattr_handler *xattr_handler_map[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[EROFS_XATTR_INDEX_USER] =3D &amp;erofs_xatt=
r_user_handler,<br>
&gt; <br>
</blockquote></div>

--0000000000006a8357058db14aae--
