Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748F129FC3
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 10:36:34 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hrhH3MPQzDqMN
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Dec 2019 20:36:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529;
 helo=mail-ed1-x529.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N+NKL0oq"; 
 dkim-atps=neutral
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hrgt4FgtzDqKg
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 20:36:10 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id bx28so17477207edb.11
 for <linux-erofs@lists.ozlabs.org>; Tue, 24 Dec 2019 01:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EiTXzDrPnyZhc31/D6ogj6IzKYF2/H7JB1qT3HEgyCg=;
 b=N+NKL0oq1QfTay56LQqu71rqrRPbNOo3EQxo+0o/41/82sH8MuRcjxBlj4DV4KZZE3
 jsGhxgM3Tob3A94rsjQqAq3XKsIFYnQgzoyXl2imrhT2pdbqDJ0xbNO8vE0Yxi4/7NWb
 9RiHq+ix1cd/IhLi/MyhLN8Qb61mBx1cSgGc6+FYR/ucKGc9+fEr1fKM0sFJ9KiDhlmO
 hdBZGBsRxhfVu6aFCcXCnD2omFFPxOBSEWdSXsEvXkie9Jccw18aEnpQYzIc9DW4Bshf
 9iyMoCyXEnO6ptQKHMD6dZgpUaMu7OjvLJsGj7RXVecsEhF+PxGUougAOIX3DSlZCtFI
 0trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EiTXzDrPnyZhc31/D6ogj6IzKYF2/H7JB1qT3HEgyCg=;
 b=T40EygyJUMwSyucvnDO46LzPVBPUvROS0t9WTLGMZtRI9Qclg9TKVm8D/LUrkubt5e
 u8ahTtoUy01c9xwg6BMLIhfWwNKiKdS6CzKSrsIUD8OqaiasIEvwBv0IvQEWvVOWQVVA
 AYxuvpHRS+iYyS79eaiQXjQJpE6hmQVckQ4abn1jEJTpQGveGKP0lavIrdGWMYl0bucB
 s1MTBXOe03LNAaWoIyBbw4epq63+l2wUVPlkrdIhimjDeoqDOekyjIqtPOyqo0ouWW6z
 F6i1fQgm9dHRxDp3ZdOZuM2dUU8IgpQPF3Vs8sfJriqBunUd+QL2blHHshdZKIZbFmNL
 B4Tw==
X-Gm-Message-State: APjAAAXTvMy1M+9zb/sJp4gkxuAEv5k1qyhMLNQi6/9eV5Bg3PP2H5uq
 DD8Ktn/4yddcWGrkNsG4acBsKJAb0LNRig9AV5hekPd1
X-Google-Smtp-Source: APXvYqzopF933424wmMhlFXKzKer9f3Qh/ix9fERqtqXgeGaLS9TFlGTb5ipN/Xo1vLZEvYB/wY8lBUn0JHKQfTzCp8=
X-Received: by 2002:a05:6402:1547:: with SMTP id
 p7mr37650853edx.73.1577180165810; 
 Tue, 24 Dec 2019 01:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20191223172938.13189-1-pratikshinde320@gmail.com>
 <20191224034817.GA164058@architecture4>
In-Reply-To: <20191224034817.GA164058@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 24 Dec 2019 15:05:53 +0530
Message-ID: <CAGu0czSu81J3UsdUKvGKed_XXDV5ipZB8qz83+cDPx_ZB4-R1g@mail.gmail.com>
Subject: Re: [RFCv2] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000087acfb059a6fdfc8"
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

--00000000000087acfb059a6fdfc8
Content-Type: text/plain; charset="UTF-8"

Hello Gao,

Thanks for the review.
If I understand correctly , you wish to keep track of every extent assigned
to the file.
in case of file without any holes in it, there will single extent
representing the entire file.

Also, the current block no. lookup happens in constant time. (since we only
record the start blk no.)
If we use extent record for finding given block no. it can't be done in
constant time correct ? (maybe in LogN)

I think I don't fully understand reason for recording extents assigned to a
file.Since the current design
is already time and space optimized & there are no deletions happening.
Is it for some future requirement ?

--Pratik.

On Tue, Dec 24, 2019 at 9:18 AM Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> Thanks for keeping the work. :)
> Some inlined comments below as before.
>
> On Mon, Dec 23, 2019 at 10:59:38PM +0530, Pratik Shinde wrote:
> > Made some changes based on comments on previous patch :
> > 1) defined an on disk structure for representing hole.
> > 2) Maintain a list of this structure (per file) and dump this list to
> >    disk at the time of writing the inode to disk.
> > ---
> >  include/erofs/internal.h |   8 +++-
> >  lib/inode.c              | 108
> ++++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 110 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index e13adda..863ef8a 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> >  extern struct erofs_sb_info sbi;
> >
> >  struct erofs_inode {
> > -     struct list_head i_hash, i_subdirs, i_xattrs;
> > +     struct list_head i_hash, i_subdirs, i_xattrs, i_holes;
> >
> >       unsigned int i_count;
> >       struct erofs_inode *i_parent;
> > @@ -93,6 +93,7 @@ struct erofs_inode {
> >
> >       unsigned int xattr_isize;
> >       unsigned int extent_isize;
> > +     unsigned int holes_isize;
> >
> >       erofs_nid_t nid;
> >       struct erofs_buffer_head *bh;
> > @@ -139,5 +140,10 @@ static inline const char *erofs_strerror(int err)
> >       return msg;
> >  }
> >
> > +struct erofs_hole {
> > +     erofs_blk_t st;
> > +     u32 len;
> > +     struct list_head next;
> > +};
>
>
> How about recording all extents rather than holes? since it's more useful
> for later random read access.
>
> struct erofs_extent_node {
>         struct list_head next;
>
>         erofs_blk_t lblk;       /* logical start address */
>         erofs_blk_t pblk;       /* physical start address */
>         u32 len;                /* extent length in blocks */
> };
>
>
> >  #endif
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 0e19b11..20bbf06 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -38,6 +38,85 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> S_SHIFT] = {
> >
> >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> >
> > +
> > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&
>       \
> > +                          roundup(end, EROFS_BLKSIZ) == end &&       \
> > +                         (end - start) % EROFS_BLKSIZ == 0)
> > +#define HOLE_BLK             -1
> > +unsigned int erofs_detect_holes(struct erofs_inode *inode,
> > +                             struct list_head *holes, unsigned int
> *htimes)
> > +{
> > +     int fd, st, en;
> > +     unsigned int nholes = 0;
> > +     erofs_off_t data, hole, len;
> > +     struct erofs_hole *eh;
> > +
> > +     fd = open(inode->i_srcpath, O_RDONLY);
> > +     if (fd < 0) {
> > +             return -errno;
> > +     }
> > +     len = lseek(fd, 0, SEEK_END);
> > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > +             return -errno;
> > +     data = 0;
> > +     while (data < len) {
> > +             hole = lseek(fd, data, SEEK_HOLE);
> > +             if (hole == len)
> > +                     break;
> > +             data = lseek(fd, hole, SEEK_DATA);
> > +             if (data < 0 || hole > data) {
> > +                     return -EINVAL;
> > +             }
> > +             if (IS_HOLE(hole, data)) {
> > +                     st = hole >> S_SHIFT;
> > +                     en = data >> S_SHIFT;
> > +                     eh = malloc(sizeof(struct erofs_hole));
> > +                     if (eh == NULL)
> > +                             return -ENOMEM;
> > +                     eh->st = st;
> > +                     eh->len = (en - st);
> > +                     list_add_tail(&eh->next, holes);
> > +                     nholes += eh->len;
> > +                     *htimes += 1;
> > +             }
> > +     }
> > +     return nholes;
> > +}
> > +
> > +bool erofs_ishole(erofs_blk_t blk, struct list_head holes)
> > +{
> > +     if (list_empty(&holes))
> > +             return false;
> > +     struct erofs_hole *eh;
> > +     list_for_each_entry(eh, &holes, next) {
> > +             if (eh->st > blk)
> > +                     return false;
> > +             if (eh->st <= blk && (eh->st + eh->len - 1) >= blk)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +char *erofs_create_holes_buffer(struct list_head *holes, unsigned int
> size)
> > +{
> > +     struct erofs_hole *eh;
> > +     char *buf;
> > +     unsigned int p = 0;
> > +
> > +     buf = malloc(size);
> > +     if (buf == NULL)
> > +             return ERR_PTR(-ENOMEM);
> > +     list_for_each_entry(eh, holes, next) {
> > +             *(__le32 *)(buf + p) = cpu_to_le32(eh->st);
> > +             p += sizeof(__le32);
> > +             *(__le32 *)(buf + p) = cpu_to_le32(eh->len);
> > +             p += sizeof(__le32);
> > +             list_del(&eh->next);
> > +             free(eh);
> > +     }
>
> How about introducing some extent header
>
> /* 12-byte alignment */
> struct erofs_inline_extent_header {
>         /* e.g. we need to record how many total extents here at least. */
>         ...
> };
>
> and some ondisk extent representation.
>
> struct erofs_extent {
>         __le32 ee_lblk;
>         __le32 ee_pblk;
>         /*
>          * most significant 4 bits reserved for flags and should be 0
>          * now, maximum 256M blocks (8TB) for an extent.
>          */
>         __le32 ee_len;
> };
>
> (see fs/ext4/ext4_extents.h for ext4 ondisk definitions)
>
> And I'd like to call this inline extent representation (for limited
> extents) since we could consider some powerful representation
> (e.g. using B+ tree) in the future for complicated requirement, so we
> have to reserve i_u.raw_blkaddr in erofs_inode to 0 for now (in order
> to indicate extra B+-tree blocks).
>
>
> > +     return buf;
> > +}
> > +
> >  void erofs_inode_manager_init(void)
> >  {
> >       unsigned int i;
> > @@ -304,7 +383,7 @@ static bool erofs_file_is_compressible(struct
> erofs_inode *inode)
> >
> >  int erofs_write_file(struct erofs_inode *inode)
> >  {
> > -     unsigned int nblocks, i;
> > +     unsigned int nblocks, i, nholes, hitems = 0;
> >       int ret, fd;
> >
> >       if (!inode->i_size) {
>
>
> The fallback condition from compress file to uncompress file should be
> updated
> and give a new data_mapping for this mode as well, but that is minor for
> now.
>
> Thanks,
> Gao Xiang
>
>
> > @@ -322,16 +401,24 @@ int erofs_write_file(struct erofs_inode *inode)
> >       /* fallback to all data uncompressed */
> >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > -
> > -     ret = __allocate_inode_bh_data(inode, nblocks);
> > +     nholes = erofs_detect_holes(inode, &inode->i_holes, &hitems);
> > +     if (nholes < 0)
> > +             return nholes;
> > +     inode->holes_isize = (sizeof(struct erofs_hole) -
> > +                           sizeof(struct list_head)) * hitems;
> > +     if (nblocks < 0)
> > +             return nblocks;
> > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> >       if (ret)
> >               return ret;
> > -
> >       fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> >       if (fd < 0)
> >               return -errno;
> >
> >       for (i = 0; i < nblocks; ++i) {
> > +             if (erofs_ishole(i, inode->i_holes)) {
> > +                     continue;
> > +             }
> >               char buf[EROFS_BLKSIZ];
> >
> >               ret = read(fd, buf, EROFS_BLKSIZ);
> > @@ -479,8 +566,19 @@ static bool erofs_bh_flush_write_inode(struct
> erofs_buffer_head *bh)
> >               if (ret)
> >                       return false;
> >               free(inode->compressmeta);
> > +             off += inode->extent_isize;
> >       }
> >
> > +     if (inode->holes_isize) {
> > +             char *holes = erofs_create_holes_buffer(&inode->i_holes,
> > +
>  inode->holes_isize);
> > +             if (IS_ERR(holes))
> > +                     return false;
> > +             ret = dev_write(holes, off, inode->holes_isize);
> > +             free(holes);
> > +             if (ret)
> > +                     return false;
> > +     }
> >       inode->bh = NULL;
> >       erofs_iput(inode);
> >       return erofs_bh_flush_generic_end(bh);
> > @@ -737,6 +835,7 @@ struct erofs_inode *erofs_new_inode(void)
> >
> >       init_list_head(&inode->i_subdirs);
> >       init_list_head(&inode->i_xattrs);
> > +     init_list_head(&inode->i_holes);
> >
> >       inode->idata_size = 0;
> >       inode->xattr_isize = 0;
> > @@ -961,4 +1060,3 @@ struct erofs_inode
> *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >
> >       return erofs_mkfs_build_tree(inode);
> >  }
> > -
> > --
> > 2.9.3
> >
>

--00000000000087acfb059a6fdfc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Gao,</div><div><br></div><div>Thanks for the re=
view. <br></div><div>If I understand correctly , you wish to keep track of =
every extent assigned to the file.</div><div>in case of file without any ho=
les in it, there will single extent representing the entire file.</div><div=
><br></div><div>Also, the current block no. lookup happens in constant time=
. (since we only record the start blk no.)</div><div>If we use extent recor=
d for finding given block no. it can&#39;t be done in constant time correct=
 ? (maybe in LogN)</div><div><br></div><div>I think I don&#39;t fully under=
stand reason for recording extents assigned to a file.Since the current des=
ign</div><div>is already time and space optimized &amp; there are no deleti=
ons happening.</div><div>Is it for some future requirement ?</div><div><br>=
</div><div>--Pratik.<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Dec 24, 2019 at 9:18 AM Gao Xiang &lt=
;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Pratik,<b=
r>
<br>
Thanks for keeping the work. :)<br>
Some inlined comments below as before.<br>
<br>
On Mon, Dec 23, 2019 at 10:59:38PM +0530, Pratik Shinde wrote:<br>
&gt; Made some changes based on comments on previous patch :<br>
&gt; 1) defined an on disk structure for representing hole.<br>
&gt; 2) Maintain a list of this structure (per file) and dump this list to<=
br>
&gt;=C2=A0 =C2=A0 disk at the time of writing the inode to disk.<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/internal.h |=C2=A0 =C2=A08 +++-<br>
&gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10=
8 ++++++++++++++++++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 2 files changed, 110 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
&gt; index e13adda..863ef8a 100644<br>
&gt; --- a/include/erofs/internal.h<br>
&gt; +++ b/include/erofs/internal.h<br>
&gt; @@ -63,7 +63,7 @@ struct erofs_sb_info {<br>
&gt;=C2=A0 extern struct erofs_sb_info sbi;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct erofs_inode {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs, i_h=
oles;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *i_parent;<br>
&gt; @@ -93,6 +93,7 @@ struct erofs_inode {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xattr_isize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int extent_isize;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int holes_isize;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_buffer_head *bh;<br>
&gt; @@ -139,5 +140,10 @@ static inline const char *erofs_strerror(int err)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return msg;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +struct erofs_hole {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t st;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head next;<br>
&gt; +};<br>
<br>
<br>
How about recording all extents rather than holes? since it&#39;s more usef=
ul<br>
for later random read access.<br>
<br>
struct erofs_extent_node {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head next;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_blk_t lblk;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
logical start address */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 erofs_blk_t pblk;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
physical start address */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 len;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* extent length in blocks */<br>
};<br>
<br>
<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; index 0e19b11..20bbf06 100644<br>
&gt; --- a/lib/inode.c<br>
&gt; +++ b/lib/inode.c<br>
&gt; @@ -38,6 +38,85 @@ static unsigned char erofs_type_by_mode[S_IFMT &gt;=
&gt; S_SHIFT] =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct list_head inode_hashtable[NR_INODE_HASHTABLE];<br>
&gt;=C2=A0 <br>
&gt; +<br>
&gt; +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) =3D=3D star=
t &amp;&amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 roundup(end, EROFS_BLKSIZ) =3D=3D end &amp;&amp;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(end - start) % EROFS_BLKSIZ =3D=3D 0)<br>
&gt; +#define HOLE_BLK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1<br=
>
&gt; +unsigned int erofs_detect_holes(struct erofs_inode *inode,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *holes, unsigned int *h=
times)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fd, st, en;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nholes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_hole *eh;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDONLY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (lseek(fd, 0, SEEK_SET) =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (data &lt; len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hole =3D lseek(fd, da=
ta, SEEK_HOLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hole =3D=3D len)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D lseek(fd, ho=
le, SEEK_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data &lt; 0 || ho=
le &gt; data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_HOLE(hole, dat=
a)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0st =3D hole &gt;&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0en =3D data &gt;&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eh =3D malloc(sizeof(struct erofs_hole));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (eh =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eh-&gt;st =3D st;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eh-&gt;len =3D (en - st);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0list_add_tail(&amp;eh-&gt;next, holes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nholes +=3D eh-&gt;len;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*htimes +=3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool erofs_ishole(erofs_blk_t blk, struct list_head holes)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (list_empty(&amp;holes))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_hole *eh;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(eh, &amp;holes, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eh-&gt;st &gt; bl=
k)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eh-&gt;st &lt;=3D=
 blk &amp;&amp; (eh-&gt;st + eh-&gt;len - 1) &gt;=3D blk)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +char *erofs_create_holes_buffer(struct list_head *holes, unsigned int=
 size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_hole *eh;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int p =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (buf =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENOME=
M);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(eh, holes, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(__le32 *)(buf + p) =
=3D cpu_to_le32(eh-&gt;st);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D sizeof(__le32)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(__le32 *)(buf + p) =
=3D cpu_to_le32(eh-&gt;len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D sizeof(__le32)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;eh-&gt;=
next);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(eh);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
How about introducing some extent header<br>
<br>
/* 12-byte alignment */<br>
struct erofs_inline_extent_header {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* e.g. we need to record how many total extent=
s here at least. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
};<br>
<br>
and some ondisk extent representation.<br>
<br>
struct erofs_extent {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le32 ee_lblk;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le32 ee_pblk;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* most significant 4 bits reserved for fl=
ags and should be 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* now, maximum 256M blocks (8TB) for an e=
xtent.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __le32 ee_len;<br>
};<br>
<br>
(see fs/ext4/ext4_extents.h for ext4 ondisk definitions)<br>
<br>
And I&#39;d like to call this inline extent representation (for limited<br>
extents) since we could consider some powerful representation<br>
(e.g. using B+ tree) in the future for complicated requirement, so we<br>
have to reserve i_u.raw_blkaddr in erofs_inode to 0 for now (in order<br>
to indicate extra B+-tree blocks).<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return buf;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; @@ -304,7 +383,7 @@ static bool erofs_file_is_compressible(struct erof=
s_inode *inode)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i, nholes, hitems =3D 0;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
<br>
<br>
The fallback condition from compress file to uncompress file should be upda=
ted<br>
and give a new data_mapping for this mode as well, but that is minor for no=
w.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
<br>
&gt; @@ -322,16 +401,24 @@ int erofs_write_file(struct erofs_inode *inode)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncompressed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROFS_INODE_FLAT_IN=
LINE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / EROFS_BLKSIZ;=
<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nholes =3D erofs_detect_holes(inode, &amp;inode-&=
gt;i_holes, &amp;hitems);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nholes &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;holes_isize =3D (sizeof(struct erofs_ho=
le) -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(struct list_head)) * hitems;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nblocks &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nblocks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks -=
 nholes);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDONLY | =
O_BINARY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (erofs_ishole(i, i=
node-&gt;i_holes)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[EROFS_B=
LKSIZ];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D read(fd,=
 buf, EROFS_BLKSIZ);<br>
&gt; @@ -479,8 +566,19 @@ static bool erofs_bh_flush_write_inode(struct ero=
fs_buffer_head *bh)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(inode-&gt;c=
ompressmeta);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off +=3D inode-&gt;ex=
tent_isize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (inode-&gt;holes_isize) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *holes =3D erofs=
_create_holes_buffer(&amp;inode-&gt;i_holes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;holes_isize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(holes))<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dev_write(hol=
es, off, inode-&gt;holes_isize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(holes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_iput(inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_bh_flush_generic_end(bh);<br>
&gt; @@ -737,6 +835,7 @@ struct erofs_inode *erofs_new_inode(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_subdirs);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_xattrs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_holes);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;xattr_isize =3D 0;<br>
&gt; @@ -961,4 +1060,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(struct erofs_inode *parent,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(inode);<br>
&gt;=C2=A0 }<br>
&gt; -<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--00000000000087acfb059a6fdfc8--
