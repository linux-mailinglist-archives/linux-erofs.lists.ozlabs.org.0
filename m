Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03412CD2E
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 07:20:20 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47mS354z1JzDq9p
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 17:20:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::541;
 helo=mail-ed1-x541.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljQt4xp8"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47mS303RcyzDq9W
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2019 17:20:11 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id t17so31761531eds.6
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2019 22:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fHwkQwY8shxpYVlKoUMhfX0oQpNSMUAIDmBQWnfQLDY=;
 b=ljQt4xp8YZx661oLtv1fT/FwfK5pBKNIPTl/CCxKhduCuWGQBVgZ0Y4X/ZHQCVon0T
 Tmj3Dy7uopw/X9VjON8VpOt3uw41uaNewDIjE3/hnOHeadV03XHKGhppGzl9Tqnla2iD
 NuCho/tNO1mM/oK/I7Slq7RTe5fUFS+5w5aITZIP0mCwKcZf4UUa/G1btIaVd2xvl6zw
 Qwgr30VaDOO84zjVfAX2Gb00gjLnsYsgG9fmVfURTZSnUCwDYT+jjCkYxP4xBid7w2R9
 QyWKZH1vCFqiZlC0DjftLnV75vSF9RnhCvS7ddiXc3cOh9m1q9I0pIWC55pNemUUO1aI
 +/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fHwkQwY8shxpYVlKoUMhfX0oQpNSMUAIDmBQWnfQLDY=;
 b=ieJ4OVY5/LMbvTv/yktLU5swfdBen2A+FFaS6enCxjH9Q4rJ+pyzwTNN4XkiySYJuQ
 UjjWTDDWZlb0ASRh/JkJ4oecES/eDJLQnoJKBAABY9IATvOTYfJIsoeeZkhd6YpGMHsU
 zFU2GNsNjl1ImcpvDz4xw71juVCXfFpsw3PN1McSO+IcQGGTP2YVEA51GDPf5IXUR2bQ
 XFgJVEyPpGo9jStxvXNXNZZiwqo4kTk75M6JANIRosaaFkK0PfJaqg1ScVIX7V2YosIu
 QBs02FS+CL+tPeWVtMIYpnIfUbmcrGJTCyTmfXN8v5IbE8IVAoM7bS8olh2xFIHBKtZr
 WSdQ==
X-Gm-Message-State: APjAAAWh3YZ6LU6O94Hg/MyNN/Wdq3feHTkE8+8prQFyW40hC62n1wLe
 wVkx4WwkYfuQRGh9iMNOotBvNDPO6qpMnvDdxRY=
X-Google-Smtp-Source: APXvYqygQONAyXUHrMVoyT3UFy2QS7+AVDUReL0YfRlUD3SxZz+LSghldsgK/id1w/afdBVJIaWYDDWPWI/5BT5YrhE=
X-Received: by 2002:a17:906:5ac2:: with SMTP id
 x2mr68954257ejs.29.1577686807476; 
 Sun, 29 Dec 2019 22:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20191227154348.21432-1-pratikshinde320@gmail.com>
 <20191229025546.GB2215@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20191229025546.GB2215@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 30 Dec 2019 11:49:55 +0530
Message-ID: <CAGu0czSGGxgFsVMwNOY5cqR35bUYmp-6qCUTLfUEfLHgqcHbOw@mail.gmail.com>
Subject: Re: [RFC] erofs-utils: on-disk extent format for blocks.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000b9ffa2059ae5d535"
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

--000000000000b9ffa2059ae5d535
Content-Type: text/plain; charset="UTF-8"

Gao,

Okay, I will rename the 'size' variables accordingly.
The 'S_SHIFT' gives the logical block number inside file. I am using it to
assign logical block no.
to extents.
Also, I will modify the code to record only data extents.

--Pratik.

On Sun, Dec 29, 2019 at 8:26 AM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:
> > since this patch is quite different from previous patches I am treating
> > this as new patch.
> >
> > 1) On disk extent format for erofs data blocks.
> > 2) Detect holes inside files & skip allocation for hole blocks.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  include/erofs/internal.h |  21 ++++++-
> >  lib/inode.c              | 155
> +++++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 156 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index e13adda..128aa63 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> >  extern struct erofs_sb_info sbi;
> >
> >  struct erofs_inode {
> > -     struct list_head i_hash, i_subdirs, i_xattrs;
> > +     struct list_head i_hash, i_subdirs, i_xattrs, i_extents;
> >
> >       unsigned int i_count;
> >       struct erofs_inode *i_parent;
> > @@ -93,6 +93,7 @@ struct erofs_inode {
> >
> >       unsigned int xattr_isize;
> >       unsigned int extent_isize;
> > +     unsigned int extent_meta_isize;
>
> maybe sparse_extent_isize is better...
>
> p.s. maybe we could send another patch rename extent_isize to
> compress_extent_isize or some better name...
>
> >
> >       erofs_nid_t nid;
> >       struct erofs_buffer_head *bh;
> > @@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int err)
> >       return msg;
> >  }
> >
> > +#define HOLE_BLK     -1
> > +/* on disk extent format */
> > +struct erofs_extent {
> > +     __le32 ee_lblk;
> > +     __le32 ee_pblk;
> > +     __le32 ee_len;
> > +};
> > +
> > +struct erofs_extent_node {
> > +     struct list_head next;
> > +     erofs_blk_t lblk;
> > +     erofs_blk_t pblk;
> > +     u32 len;
> > +};
> > +
> > +struct erofs_inline_extent_header {
> > +     u32 count;
> > +};
> >  #endif
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 0e19b11..a6af509 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> S_SHIFT] = {
> >
> >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> >
> > +
> > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&
>       \
> > +                          roundup(end, EROFS_BLKSIZ) == end &&       \
> > +                         (end - start) % EROFS_BLKSIZ == 0)
>
> See below..
>
> > +
> > +/* returns the number of holes present in the file */
> > +unsigned int erofs_read_extents(struct erofs_inode *inode,
> > +                             struct list_head *extents)
> > +{
> > +     int fd, st, en, dt;
> > +     unsigned int nholes = 0;
> > +     erofs_off_t data, hole, len, last_data;
> > +     struct erofs_extent_node *e_hole, *e_data;
> > +
> > +     fd = open(inode->i_srcpath, O_RDONLY);
> > +     if (fd < 0) {
> > +             return -errno;
> > +     }
> > +     len = lseek(fd, 0, SEEK_END);
> > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > +             return -errno;
> > +     data = 0;
> > +     last_data = 0;
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
> > +                     dt = last_data >> S_SHIFT;
>
> Why using S_SHIFT here, some special meaning?
>
> > +                     last_data = data;
> > +                     e_data = malloc(sizeof(struct erofs_extent_node));
> > +                     if (e_data == NULL)
> > +                             return -ENOMEM;
> > +                     e_data->lblk = dt;
> > +                     e_data->len = (st - dt);
> > +                     list_add_tail(&e_data->next, extents);
> > +                     e_hole = malloc(sizeof(struct erofs_extent_node));
> > +                     if (e_hole == NULL)
> > +                             return -ENOMEM;
> > +                     e_hole->lblk = st;
> > +                     e_hole->pblk = HOLE_BLK;
> > +                     e_hole->len = (en - st);
> > +                     list_add_tail(&e_hole->next, extents);
> > +                     nholes += e_hole->len;
>
> Maybe we don't need to emit all HOLK extents since all data extents
> are with _length_... It is easy to detect all holes between extents...
>
> If some block doesn't belong to any extent, it's a hole.
>
> Thanks,
> Gao Xiang
>
> > +             }
> > +     }
> > +     /* rounddown to exclude tail-end data */
> > +     if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> > +             e_data = malloc(sizeof(struct erofs_extent_node));
> > +             if (e_data == NULL)
> > +                     return -ENOMEM;
> > +             st = last_data >> S_SHIFT;
> > +             e_data->lblk = st;
> > +             e_data->len = rounddown((len - last_data), EROFS_BLKSIZ)
> >> S_SHIFT;
> > +             list_add_tail(&e_data->next, extents);
> > +     }
> > +     return nholes;
> > +}
> > +
> > +char *erofs_create_extent_buffer(struct list_head *extents, unsigned
> int size)
> > +{
> > +     struct erofs_extent_node *e_node;
> > +     struct erofs_inline_extent_header *header;
> > +     char *buf;
> > +     unsigned int p = 0;
> > +
> > +     buf = malloc(size);
> > +     if (buf == NULL)
> > +             return ERR_PTR(-ENOMEM);
> > +     header = (struct erofs_inline_extent_header *) buf;
> > +     header->count = 0;
> > +     p += sizeof(struct erofs_inline_extent_header);
> > +     list_for_each_entry(e_node, extents, next) {
> > +             const struct erofs_extent ee = {
> > +                     .ee_lblk = cpu_to_le32(e_node->lblk),
> > +                     .ee_pblk = cpu_to_le32(e_node->pblk),
> > +                     .ee_len  = cpu_to_le32(e_node->len)
> > +             };
> > +             memcpy(buf + p, &ee, sizeof(struct erofs_extent));
> > +             p += sizeof(struct erofs_extent);
> > +             header->count++;
> > +             list_del(&e_node->next);
> > +             free(e_node);
> > +     }
> > +     return buf;
> > +}
> > +
> >  void erofs_inode_manager_init(void)
> >  {
> >       unsigned int i;
> > @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct
> erofs_inode *inode)
> >
> >  int erofs_write_file(struct erofs_inode *inode)
> >  {
> > -     unsigned int nblocks, i;
> > +     unsigned int nblocks, i, j, nholes;
> >       int ret, fd;
> > +     struct erofs_extent_node *e_node;
> >
> >       if (!inode->i_size) {
> >               inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode *inode)
> >       /* fallback to all data uncompressed */
> >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > -
> > -     ret = __allocate_inode_bh_data(inode, nblocks);
> > +     nholes = erofs_read_extents(inode, &inode->i_extents);
> > +     if (nholes < 0)
> > +             return nholes;
> > +     if (nblocks < 0)
> > +             return nblocks;
> > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> >       if (ret)
> >               return ret;
> >
> >       fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> >       if (fd < 0)
> >               return -errno;
> > -
> > -     for (i = 0; i < nblocks; ++i) {
> > -             char buf[EROFS_BLKSIZ];
> > -
> > -             ret = read(fd, buf, EROFS_BLKSIZ);
> > -             if (ret != EROFS_BLKSIZ) {
> > -                     if (ret < 0)
> > -                             goto fail;
> > -                     close(fd);
> > -                     return -EAGAIN;
> > +     i = inode->u.i_blkaddr;
> > +     inode->extent_meta_isize = sizeof(struct
> erofs_inline_extent_header);
> > +     list_for_each_entry(e_node, &inode->i_extents, next) {
> > +             inode->extent_meta_isize += sizeof(struct erofs_extent);
> > +             if (e_node->pblk == HOLE_BLK) {
> > +                     lseek(fd, e_node->len * EROFS_BLKSIZ, SEEK_CUR);
> > +                     continue;
> >               }
> > +             e_node->pblk = i;
> > +             i += e_node->len;
> > +             for (j = 0; j < e_node->len; j++) {
> > +                     char buf[EROFS_BLKSIZ];
> > +                     ret = read(fd, buf, EROFS_BLKSIZ);
> > +                     if (ret != EROFS_BLKSIZ) {
> > +                             if (ret < 0)
> > +                                     goto fail;
> > +                             close(fd);
> > +                             return -EAGAIN;
> > +                     }
> > +                     ret = blk_write(buf, e_node->pblk + j, 1);
> > +                     if (ret)
> > +                             goto fail;
> >
> > -             ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> > -             if (ret)
> > -                     goto fail;
> > +             }
> >       }
> > -
> >       /* read the tail-end data */
> >       inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> >       if (inode->idata_size) {
> > @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct
> erofs_buffer_head *bh)
> >               if (ret)
> >                       return false;
> >               free(inode->compressmeta);
> > +             off += inode->extent_isize;
> >       }
> >
> > +     if (inode->extent_meta_isize) {
> > +             char *extents =
> erofs_create_extent_buffer(&inode->i_extents,
> > +
> inode->extent_meta_isize);
> > +             if (IS_ERR(extents))
> > +                     return false;
> > +             ret = dev_write(extents, off, inode->extent_meta_isize);
> > +             free(extents);
> > +             if (ret)
> > +                     return false;
> > +     }
> >       inode->bh = NULL;
> >       erofs_iput(inode);
> >       return erofs_bh_flush_generic_end(bh);
> > @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)
> >
> >       init_list_head(&inode->i_subdirs);
> >       init_list_head(&inode->i_xattrs);
> > +     init_list_head(&inode->i_extents);
> >
> >       inode->idata_size = 0;
> >       inode->xattr_isize = 0;
> > -     inode->extent_isize = 0;
> > +     inode->extent_meta_isize = 0;
> >
> >       inode->bh = inode->bh_inline = inode->bh_data = NULL;
> >       inode->idata = NULL;
> > @@ -961,4 +1079,3 @@ struct erofs_inode
> *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >
> >       return erofs_mkfs_build_tree(inode);
> >  }
> > -
> > --
> > 2.9.3
> >
>

--000000000000b9ffa2059ae5d535
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Gao,</div><div><br></div><div>Okay, I will rename the=
 &#39;size&#39; variables accordingly.</div><div>The &#39;S_SHIFT&#39; give=
s the logical block number inside file. I am using it to assign logical blo=
ck no.</div><div>to extents.</div><div>Also, I will modify the code to reco=
rd only data extents.</div><div><br></div><div>--Pratik.<br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, D=
ec 29, 2019 at 8:26 AM Gao Xiang &lt;<a href=3D"mailto:hsiangkao@aol.com">h=
siangkao@aol.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Hi Pratik,<br>
<br>
On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:<br>
&gt; since this patch is quite different from previous patches I am treatin=
g<br>
&gt; this as new patch.<br>
&gt; <br>
&gt; 1) On disk extent format for erofs data blocks.<br>
&gt; 2) Detect holes inside files &amp; skip allocation for hole blocks.<br=
>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/internal.h |=C2=A0 21 ++++++-<br>
&gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15=
5 +++++++++++++++++++++++++++++++++++++++++------<br>
&gt;=C2=A0 2 files changed, 156 insertions(+), 20 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
&gt; index e13adda..128aa63 100644<br>
&gt; --- a/include/erofs/internal.h<br>
&gt; +++ b/include/erofs/internal.h<br>
&gt; @@ -63,7 +63,7 @@ struct erofs_sb_info {<br>
&gt;=C2=A0 extern struct erofs_sb_info sbi;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct erofs_inode {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs, i_e=
xtents;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *i_parent;<br>
&gt; @@ -93,6 +93,7 @@ struct erofs_inode {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xattr_isize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int extent_isize;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int extent_meta_isize;<br>
<br>
maybe sparse_extent_isize is better...<br>
<br>
p.s. maybe we could send another patch rename extent_isize to<br>
compress_extent_isize or some better name...<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_buffer_head *bh;<br>
&gt; @@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int err)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return msg;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#define HOLE_BLK=C2=A0 =C2=A0 =C2=A0-1<br>
&gt; +/* on disk extent format */<br>
&gt; +struct erofs_extent {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_lblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_pblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_len;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct erofs_extent_node {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head next;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t lblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t pblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 len;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct erofs_inline_extent_header {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 count;<br>
&gt; +};<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; index 0e19b11..a6af509 100644<br>
&gt; --- a/lib/inode.c<br>
&gt; +++ b/lib/inode.c<br>
&gt; @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT &gt;=
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
<br>
See below..<br>
<br>
&gt; +<br>
&gt; +/* returns the number of holes present in the file */<br>
&gt; +unsigned int erofs_read_extents(struct erofs_inode *inode,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *extents)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int fd, st, en, dt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nholes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len, last_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_hole, *e_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDONLY);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (lseek(fd, 0, SEEK_SET) =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0last_data =3D 0;<br>
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
 =C2=A0dt =3D last_data &gt;&gt; S_SHIFT;<br>
<br>
Why using S_SHIFT here, some special meaning?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0last_data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data =3D malloc(sizeof(struct erofs_extent_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (e_data =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data-&gt;lblk =3D dt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data-&gt;len =3D (st - dt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0list_add_tail(&amp;e_data-&gt;next, extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_hole =3D malloc(sizeof(struct erofs_extent_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (e_hole =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_hole-&gt;lblk =3D st;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_hole-&gt;pblk =3D HOLE_BLK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_hole-&gt;len =3D (en - st);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0list_add_tail(&amp;e_hole-&gt;next, extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nholes +=3D e_hole-&gt;len;<br>
<br>
Maybe we don&#39;t need to emit all HOLK extents since all data extents<br>
are with _length_... It is easy to detect all holes between extents...<br>
<br>
If some block doesn&#39;t belong to any extent, it&#39;s a hole.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* rounddown to exclude tail-end data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (last_data &lt; len &amp;&amp; (len - last_dat=
a) &gt;=3D EROFS_BLKSIZ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data =3D malloc(siz=
eof(struct erofs_extent_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_data =3D=3D NUL=
L)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st =3D last_data &gt;=
&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;lblk =3D s=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;len =3D ro=
unddown((len - last_data), EROFS_BLKSIZ) &gt;&gt; S_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;e_=
data-&gt;next, extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +}<br>
&gt; +<br>
&gt; +char *erofs_create_extent_buffer(struct list_head *extents, unsigned =
int size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_inline_extent_header *header;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int p =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (buf =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENOME=
M);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0header =3D (struct erofs_inline_extent_header *) =
buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0header-&gt;count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct erofs_inline_extent_header);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, extents, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct erofs_ex=
tent ee =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_lblk =3D cpu_to_le32(e_node-&gt;lblk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_pblk =3D cpu_to_le32(e_node-&gt;pblk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_len=C2=A0 =3D cpu_to_le32(e_node-&gt;len)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buf + p, &amp;=
ee, sizeof(struct erofs_extent));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct =
erofs_extent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header-&gt;count++;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;e_node-=
&gt;next);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(e_node);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return buf;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct erof=
s_inode *inode)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i, j, nholes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_node;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datala=
yout =3D EROFS_INODE_FLAT_PLAIN;<br>
&gt; @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode *inode)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncompressed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROFS_INODE_FLAT_IN=
LINE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / EROFS_BLKSIZ;=
<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nholes =3D erofs_read_extents(inode, &amp;inode-&=
gt;i_extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nholes &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nblocks &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nblocks;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks -=
 nholes);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDONLY | =
O_BINARY);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<b=
r>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; ++i) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[EROFS_BLKSIZ=
];<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D read(fd, buf,=
 EROFS_BLKSIZ);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D EROFS_BL=
KSIZ) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0close(fd);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EAGAIN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i =3D inode-&gt;u.i_blkaddr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_meta_isize =3D sizeof(struct ero=
fs_inline_extent_header);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-&gt;i_exte=
nts, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;extent_meta=
_isize +=3D sizeof(struct erofs_extent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_node-&gt;pblk =
=3D=3D HOLE_BLK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lseek(fd, e_node-&gt;len * EROFS_BLKSIZ, SEEK_CUR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_node-&gt;pblk =3D i=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i +=3D e_node-&gt;len=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt; =
e_node-&gt;len; j++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0char buf[EROFS_BLKSIZ];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D read(fd, buf, EROFS_BLKSIZ);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret !=3D EROFS_BLKSIZ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D blk_write(buf, e_node-&gt;pblk + j, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_write(buf=
, inode-&gt;u.i_blkaddr + i, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto fail;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the tail-end data */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D inode-&gt;i_size % =
EROFS_BLKSIZ;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (inode-&gt;idata_size) {<br>
&gt; @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct ero=
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
&gt; +=C2=A0 =C2=A0 =C2=A0if (inode-&gt;extent_meta_isize) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *extents =3D ero=
fs_create_extent_buffer(&amp;inode-&gt;i_extents,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 inode-&gt;extent_meta_isize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(extents))<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dev_write(ext=
ents, off, inode-&gt;extent_meta_isize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_iput(inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_bh_flush_generic_end(bh);<br>
&gt; @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_subdirs);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_xattrs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_extents);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;xattr_isize =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_isize =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_meta_isize =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D inode-&gt;bh_inline =3D ino=
de-&gt;bh_data =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata =3D NULL;<br>
&gt; @@ -961,4 +1079,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(struct erofs_inode *parent,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(inode);<br>
&gt;=C2=A0 }<br>
&gt; -<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--000000000000b9ffa2059ae5d535--
