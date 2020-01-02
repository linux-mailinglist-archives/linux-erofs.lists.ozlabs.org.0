Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F0612E56F
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 12:03:07 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pQ9z4scCzDqBG
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 22:03:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a;
 helo=mail-ed1-x52a.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1Wlzv3+"; 
 dkim-atps=neutral
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pQ9n3lZrzDq9y
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 22:02:50 +1100 (AEDT)
Received: by mail-ed1-x52a.google.com with SMTP id c26so38755062eds.8
 for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jan 2020 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+r1/++fem9VuFqt54ZhUoYDVkHj/LPAndaPp2PccIRQ=;
 b=V1Wlzv3+mXdK8Gt6TOF4Vq9TRXjL0O2my0CbcakT+saxbRuqEfuXXabeBujS7JO7El
 Jzi2ShJt+Pa1j07/qGHtmn4PPAm+Z+1HqAONY9FwuIcDq8PT6Wa+KaqCXQP9ObvTtGMQ
 840l67okdwIjFb9RzFzAW0xIOcVbNTUFAinB+Yw2WIaX0R54BmJ+XlRcev6pcyuaPs7A
 sTwRVm6euFjo/FaYvcXF3tsL5NR858DpUiaJpy8pUfUIAII/WquFPfxVRN9KZ0Xyvcch
 0MZfjWYvaMOiRPjw7jLfhPQm12k74VHgYNPcKVwusVKPjBfum7sFrbd9RIssFJAymALP
 Pi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+r1/++fem9VuFqt54ZhUoYDVkHj/LPAndaPp2PccIRQ=;
 b=G7TdsUd8mPSfYd13P/Ew78mUUu+TzvfRnZycQGDuD2t3mUWylb2hSez2B1VL4jt+qG
 bBREPQGMyFkr/74915xwmFMUtXUdcSQvz82kWEjtAm7WsIGGALroq4bO1a3zGwrskrNj
 +hEGy2w1R/8l2vW3Fp/dmmohzCkDyF22zb5ly4DhtD9tn3YqxWGBUNbN/d0KG3y2Kc/A
 zq7tXDt2wYB5AqYr0oc6cz/cNve6Nx6B/F2N0KDEGWJtXXMpQ7faRaRftx6717kFvh9l
 +3SE28Ct1WjvTbuaQBtLl+Q4THWe7UHOvPk4VjwUuo/QwKBWFAR88uR10brnzYoO27BE
 fNRQ==
X-Gm-Message-State: APjAAAXMDt0Af+A1SNdRB/HDJs5x/xHyM7MmFsNdkw0lv3ArDLrQInl4
 YQKL6tUag3YT+ujv8sqG3ZAzWACPjaMMGC38ADg=
X-Google-Smtp-Source: APXvYqyg3i0icZFH2e/0nBtDtgEyVtcfSZ6nimxXPcpeQYnSiGzaUHNEyO48f5J+vAgrNcg425QI1EkCRw24PNf8sWc=
X-Received: by 2002:a05:6402:1547:: with SMTP id
 p7mr35760204edx.73.1577962966360; 
 Thu, 02 Jan 2020 03:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20200102094732.31567-1-pratikshinde320@gmail.com>
 <20200102104704.GB189482@architecture4>
In-Reply-To: <20200102104704.GB189482@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Thu, 2 Jan 2020 16:32:34 +0530
Message-ID: <CAGu0czRH7KYsxYFbQy3_rMeNCV6Fsg__PRuovdp672ZCu2vjkA@mail.gmail.com>
Subject: Re: [RFCv3] erofs-utils: on-disk extent format for blocks
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000001427f0059b2622fc"
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
Cc: xiaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000001427f0059b2622fc
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

You are correct. The macro logic can be simplified. I will do that.
I will work on the kernel part of this change & do some testing on it.
I will keep you posted about the change and relevant tests I am running on
it.

--Pratik.











On Thu, Jan 2, 2020, 4:17 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> Hi Pratik,
>
> On Thu, Jan 02, 2020 at 03:17:32PM +0530, Pratik Shinde wrote:
> > 1)Moved on-disk structures to erofs_fs.h
> > 2)Some naming changes.
> >
> > I think we can keep 'IS_HOLE()' macro, otherwise the code
> > does not look clean(if used directly/without macro).Its getting
> > used only in inode.c so it can be kept there.
> > what do you think ?
>
> What I'm little concerned is the relationship between
> the name of IS_HOLE and its implementation...
>
> In other words, why
>  roundup(start, EROFS_BLKSIZ) == start &&
>  roundup(end, EROFS_BLKSIZ) == end &&
>  (end - start) % EROFS_BLKSIZ == 0
> should be an erofs hole...
>
> But that is minor, I reserve my opinion on this for now...
>
> This patch generally looks good to me, yet I haven't
> played with it till now.
>
> Could you implement a workable RFC patch for kernel side
> as well? Since I'm still busying in XZ library and other
> convert patches for 5.6...
>
> I'd like to hear if some other opinions from Chao and Guifu.
> Since it enhances the on-disk format, we need to think it
> over (especially its future expandability).
>
>
> To Chao and Guifu,
> Could you have some extra time looking at this stuff as well?
>
>
> Thanks,
> Gao Xiang
>
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  include/erofs/internal.h |   9 ++-
> >  include/erofs_fs.h       |  11 ++++
> >  lib/inode.c              | 153
> ++++++++++++++++++++++++++++++++++++++++-------
> >  3 files changed, 150 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > index e13adda..2d7466b 100644
> > --- a/include/erofs/internal.h
> > +++ b/include/erofs/internal.h
> > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> >  extern struct erofs_sb_info sbi;
> >
> >  struct erofs_inode {
> > -     struct list_head i_hash, i_subdirs, i_xattrs;
> > +     struct list_head i_hash, i_subdirs, i_xattrs, i_sparse_extents;
> >
> >       unsigned int i_count;
> >       struct erofs_inode *i_parent;
> > @@ -93,6 +93,7 @@ struct erofs_inode {
> >
> >       unsigned int xattr_isize;
> >       unsigned int extent_isize;
> > +     unsigned int sparse_extent_isize;
> >
> >       erofs_nid_t nid;
> >       struct erofs_buffer_head *bh;
> > @@ -139,5 +140,11 @@ static inline const char *erofs_strerror(int err)
> >       return msg;
> >  }
> >
> > +struct erofs_sparse_extent_node {
> > +     struct list_head next;
> > +     erofs_blk_t lblk;
> > +     erofs_blk_t pblk;
> > +     u32 len;
> > +};
> >  #endif
> >
> > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > index bcc4f0c..a63e1c6 100644
> > --- a/include/erofs_fs.h
> > +++ b/include/erofs_fs.h
> > @@ -321,5 +321,16 @@ static inline void
> erofs_check_ondisk_layout_definitions(void)
> >                    Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
> >  }
> >
> > +/* on-disk sparse extent format */
> > +struct erofs_sparse_extent {
> > +     __le32 ee_lblk;
> > +     __le32 ee_pblk;
> > +     __le32 ee_len;
> > +};
> > +
> > +struct erofs_sparse_extent_iheader {
> > +     u32 count;
> > +};
> > +
> >  #endif
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 0e19b11..da20599 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -38,6 +38,97 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> S_SHIFT] = {
> >
> >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> >
> > +
> > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&
>       \
> > +                          roundup(end, EROFS_BLKSIZ) == end &&       \
> > +                         (end - start) % EROFS_BLKSIZ == 0)
> > +
> > +/**
> > +   read extents of the given file.
> > +   record the data extents and link them into a chain.
> > +   exclude holes present in file.
> > + */
> > +unsigned int erofs_read_sparse_extents(int fd, struct list_head
> *extents)
> > +{
> > +     erofs_blk_t startblk, endblk, datablk;
> > +     unsigned int nholes = 0;
> > +     erofs_off_t data, hole, len = 0, last_data;
> > +     struct erofs_sparse_extent_node *e_data;
> > +
> > +     len = lseek(fd, 0, SEEK_END);
> > +     if (len < 0)
> > +             return -errno;
> > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > +             return -errno;
> > +     data = 0;
> > +     last_data = 0;
> > +     while (data < len) {
> > +             hole = lseek(fd, data, SEEK_HOLE);
> > +             if (hole == len)
> > +                     break;
> > +             data = lseek(fd, hole, SEEK_DATA);
> > +             if (data < 0 || hole > data)
> > +                     return -EINVAL;
> > +             if (IS_HOLE(hole, data)) {
> > +                     startblk = erofs_blknr(hole);
> > +                     datablk = erofs_blknr(last_data);
> > +                     endblk = erofs_blknr(data);
> > +                     last_data = data;
> > +                     e_data = malloc(sizeof(
> > +                                      struct erofs_sparse_extent_node));
> > +                     if (e_data == NULL)
> > +                             return -ENOMEM;
> > +                     e_data->lblk = datablk;
> > +                     e_data->len = (startblk - datablk);
> > +                     list_add_tail(&e_data->next, extents);
> > +                     nholes += (endblk - startblk);
> > +             }
> > +     }
> > +     /* rounddown to exclude tail-end data */
> > +     if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> > +             e_data = malloc(sizeof(struct erofs_sparse_extent_node));
> > +             if (e_data == NULL)
> > +                     return -ENOMEM;
> > +             startblk = erofs_blknr(last_data);
> > +             e_data->lblk = startblk;
> > +             e_data->len = erofs_blknr(rounddown((len - last_data),
> > +                                       EROFS_BLKSIZ));
> > +             list_add_tail(&e_data->next, extents);
> > +     }
> > +     return nholes;
> > +}
> > +
> > +int erofs_write_sparse_extents(struct erofs_inode *inode, erofs_off_t
> off)
> > +{
> > +     struct erofs_sparse_extent_node *e_node;
> > +     struct erofs_sparse_extent_iheader *header;
> > +     char *buf;
> > +     unsigned int p = 0;
> > +     int ret;
> > +
> > +     buf = malloc(inode->sparse_extent_isize);
> > +     if (buf == NULL)
> > +             return -ENOMEM;
> > +     header = (struct erofs_sparse_extent_iheader *) buf;
> > +     header->count = 0;
> > +     p += sizeof(struct erofs_sparse_extent_iheader);
> > +     list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> > +             const struct erofs_sparse_extent ee = {
> > +                     .ee_lblk = cpu_to_le32(e_node->lblk),
> > +                     .ee_pblk = cpu_to_le32(e_node->pblk),
> > +                     .ee_len  = cpu_to_le32(e_node->len)
> > +             };
> > +             memcpy(buf + p, &ee, sizeof(struct erofs_sparse_extent));
> > +             p += sizeof(struct erofs_sparse_extent);
> > +             header->count++;
> > +             list_del(&e_node->next);
> > +             free(e_node);
> > +     }
> > +     ret = dev_write(buf, off, inode->sparse_extent_isize);
> > +     free(buf);
> > +     return ret;
> > +}
> > +
> >  void erofs_inode_manager_init(void)
> >  {
> >       unsigned int i;
> > @@ -304,8 +395,9 @@ static bool erofs_file_is_compressible(struct
> erofs_inode *inode)
> >
> >  int erofs_write_file(struct erofs_inode *inode)
> >  {
> > -     unsigned int nblocks, i;
> > +     unsigned int nblocks, i, j, nholes;
> >       int ret, fd;
> > +     struct erofs_sparse_extent_node *e_node;
> >
> >       if (!inode->i_size) {
> >               inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > @@ -322,31 +414,42 @@ int erofs_write_file(struct erofs_inode *inode)
> >       /* fallback to all data uncompressed */
> >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > -
> > -     ret = __allocate_inode_bh_data(inode, nblocks);
> > -     if (ret)
> > -             return ret;
> > -
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
> > +     nholes = erofs_read_sparse_extents(fd, &inode->i_sparse_extents);
> > +     if (nholes < 0) {
> > +             close(fd);
> > +             return nholes;
> > +     }
> > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> > +     if (ret) {
> > +             close(fd);
> > +             return ret;
> > +     }
> > +     i = inode->u.i_blkaddr;
> > +     inode->sparse_extent_isize = sizeof(struct
> erofs_sparse_extent_iheader);
> > +     list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> > +             inode->sparse_extent_isize += sizeof(struct
> erofs_sparse_extent);
> > +             e_node->pblk = i;
> > +             ret = lseek(fd, blknr_to_addr(e_node->lblk), SEEK_SET);
> > +             if (ret < 0)
> > +                     goto fail;
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
> >                               goto fail;
> > -                     close(fd);
> > -                     return -EAGAIN;
> >               }
> > -
> > -             ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> > -             if (ret)
> > -                     goto fail;
> > +             i += e_node->len;
> >       }
> > -
> >       /* read the tail-end data */
> >       inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> >       if (inode->idata_size) {
> > @@ -479,8 +582,14 @@ static bool erofs_bh_flush_write_inode(struct
> erofs_buffer_head *bh)
> >               if (ret)
> >                       return false;
> >               free(inode->compressmeta);
> > +             off += inode->extent_isize;
> >       }
> >
> > +     if (inode->sparse_extent_isize) {
> > +             ret = erofs_write_sparse_extents(inode, off);
> > +             if (ret)
> > +                     return false;
> > +     }
> >       inode->bh = NULL;
> >       erofs_iput(inode);
> >       return erofs_bh_flush_generic_end(bh);
> > @@ -737,10 +846,11 @@ struct erofs_inode *erofs_new_inode(void)
> >
> >       init_list_head(&inode->i_subdirs);
> >       init_list_head(&inode->i_xattrs);
> > +     init_list_head(&inode->i_sparse_extents);
> >
> >       inode->idata_size = 0;
> >       inode->xattr_isize = 0;
> > -     inode->extent_isize = 0;
> > +     inode->sparse_extent_isize = 0;
> >
> >       inode->bh = inode->bh_inline = inode->bh_data = NULL;
> >       inode->idata = NULL;
> > @@ -961,4 +1071,3 @@ struct erofs_inode
> *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >
> >       return erofs_mkfs_build_tree(inode);
> >  }
> > -
> > --
> > 2.9.3
> >
>

--0000000000001427f0059b2622fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">You =
are correct. The macro logic can be simplified. I will do that.</div><div d=
ir=3D"auto">I will work on the kernel part of this change &amp; do some tes=
ting on it.</div><div dir=3D"auto">I will keep you posted about the change =
and relevant tests I am running on it.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">--Pratik.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Jan 2, 2020, 4:17 PM Gao Xiang &lt;<a href=3D"mailto:gaox=
iang25@huawei.com">gaoxiang25@huawei.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Hi Pratik,<br>
<br>
On Thu, Jan 02, 2020 at 03:17:32PM +0530, Pratik Shinde wrote:<br>
&gt; 1)Moved on-disk structures to erofs_fs.h<br>
&gt; 2)Some naming changes.<br>
&gt; <br>
&gt; I think we can keep &#39;IS_HOLE()&#39; macro, otherwise the code<br>
&gt; does not look clean(if used directly/without macro).Its getting<br>
&gt; used only in inode.c so it can be kept there.<br>
&gt; what do you think ?<br>
<br>
What I&#39;m little concerned is the relationship between<br>
the name of IS_HOLE and its implementation...<br>
<br>
In other words, why<br>
=C2=A0roundup(start, EROFS_BLKSIZ) =3D=3D start &amp;&amp;<br>
=C2=A0roundup(end, EROFS_BLKSIZ) =3D=3D end &amp;&amp;<br>
=C2=A0(end - start) % EROFS_BLKSIZ =3D=3D 0<br>
should be an erofs hole...<br>
<br>
But that is minor, I reserve my opinion on this for now...<br>
<br>
This patch generally looks good to me, yet I haven&#39;t<br>
played with it till now.<br>
<br>
Could you implement a workable RFC patch for kernel side<br>
as well? Since I&#39;m still busying in XZ library and other<br>
convert patches for 5.6...<br>
<br>
I&#39;d like to hear if some other opinions from Chao and Guifu.<br>
Since it enhances the on-disk format, we need to think it<br>
over (especially its future expandability).<br>
<br>
<br>
To Chao and Guifu,<br>
Could you have some extra time looking at this stuff as well?<br>
<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshinde320@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmail.com</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/erofs/internal.h |=C2=A0 =C2=A09 ++-<br>
&gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 ++++<br>
&gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15=
3 ++++++++++++++++++++++++++++++++++++++++-------<br>
&gt;=C2=A0 3 files changed, 150 insertions(+), 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
&gt; index e13adda..2d7466b 100644<br>
&gt; --- a/include/erofs/internal.h<br>
&gt; +++ b/include/erofs/internal.h<br>
&gt; @@ -63,7 +63,7 @@ struct erofs_sb_info {<br>
&gt;=C2=A0 extern struct erofs_sb_info sbi;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 struct erofs_inode {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_xattrs, i_s=
parse_extents;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *i_parent;<br>
&gt; @@ -93,6 +93,7 @@ struct erofs_inode {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xattr_isize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int extent_isize;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int sparse_extent_isize;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_buffer_head *bh;<br>
&gt; @@ -139,5 +140,11 @@ static inline const char *erofs_strerror(int err)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return msg;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +struct erofs_sparse_extent_node {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head next;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t lblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t pblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 len;<br>
&gt; +};<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/include/erofs_fs.h b/include/erofs_fs.h<br>
&gt; index bcc4f0c..a63e1c6 100644<br>
&gt; --- a/include/erofs_fs.h<br>
&gt; +++ b/include/erofs_fs.h<br>
&gt; @@ -321,5 +321,16 @@ static inline void erofs_check_ondisk_layout_defi=
nitions(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Z=
_EROFS_VLE_CLUSTER_TYPE_MAX - 1);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/* on-disk sparse extent format */<br>
&gt; +struct erofs_sparse_extent {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_lblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_pblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_len;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct erofs_sparse_extent_iheader {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 count;<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; index 0e19b11..da20599 100644<br>
&gt; --- a/lib/inode.c<br>
&gt; +++ b/lib/inode.c<br>
&gt; @@ -38,6 +38,97 @@ static unsigned char erofs_type_by_mode[S_IFMT &gt;=
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
&gt; +<br>
&gt; +/**<br>
&gt; +=C2=A0 =C2=A0read extents of the given file.<br>
&gt; +=C2=A0 =C2=A0record the data extents and link them into a chain.<br>
&gt; +=C2=A0 =C2=A0exclude holes present in file.<br>
&gt; + */<br>
&gt; +unsigned int erofs_read_sparse_extents(int fd, struct list_head *exte=
nts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t startblk, endblk, datablk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nholes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len =3D 0, last_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (len &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -errno;<br>
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
le &gt; data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_HOLE(hole, dat=
a)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0startblk =3D erofs_blknr(hole);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0datablk =3D erofs_blknr(last_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0endblk =3D erofs_blknr(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0last_data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data =3D malloc(sizeof(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct erof=
s_sparse_extent_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (e_data =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data-&gt;lblk =3D datablk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0e_data-&gt;len =3D (startblk - datablk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0list_add_tail(&amp;e_data-&gt;next, extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nholes +=3D (endblk - startblk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* rounddown to exclude tail-end data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (last_data &lt; len &amp;&amp; (len - last_dat=
a) &gt;=3D EROFS_BLKSIZ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data =3D malloc(siz=
eof(struct erofs_sparse_extent_node));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_data =3D=3D NUL=
L)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0startblk =3D erofs_bl=
knr(last_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;lblk =3D s=
tartblk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;len =3D er=
ofs_blknr(rounddown((len - last_data),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EROFS=
_BLKSIZ));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;e_=
data-&gt;next, extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int erofs_write_sparse_extents(struct erofs_inode *inode, erofs_off_t=
 off)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_iheader *header;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int p =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(inode-&gt;sparse_extent_isize);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (buf =3D=3D NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0header =3D (struct erofs_sparse_extent_iheader *)=
 buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0header-&gt;count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct erofs_sparse_extent_iheader)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-&gt;i_spar=
se_extents, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct erofs_sp=
arse_extent ee =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_lblk =3D cpu_to_le32(e_node-&gt;lblk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_pblk =3D cpu_to_le32(e_node-&gt;pblk),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.ee_len=C2=A0 =3D cpu_to_le32(e_node-&gt;len)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buf + p, &amp;=
ee, sizeof(struct erofs_sparse_extent));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct =
erofs_sparse_extent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header-&gt;count++;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;e_node-=
&gt;next);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(e_node);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D dev_write(buf, off, inode-&gt;sparse_exte=
nt_isize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; @@ -304,8 +395,9 @@ static bool erofs_file_is_compressible(struct erof=
s_inode *inode)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i, j, nholes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_node;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datala=
yout =3D EROFS_INODE_FLAT_PLAIN;<br>
&gt; @@ -322,31 +414,42 @@ int erofs_write_file(struct erofs_inode *inode)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncompressed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROFS_INODE_FLAT_IN=
LINE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / EROFS_BLKSIZ;=
<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; -<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0nholes =3D erofs_read_sparse_extents(fd, &amp;ino=
de-&gt;i_sparse_extents);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (nholes &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode, nblocks -=
 nholes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0i =3D inode-&gt;u.i_blkaddr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;sparse_extent_isize =3D sizeof(struct e=
rofs_sparse_extent_iheader);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-&gt;i_spar=
se_extents, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;sparse_exte=
nt_isize +=3D sizeof(struct erofs_sparse_extent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_node-&gt;pblk =3D i=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D lseek(fd, blk=
nr_to_addr(e_node-&gt;lblk), SEEK_SET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto fail;<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0close(fd);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EAGAIN;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk_write(buf=
, inode-&gt;u.i_blkaddr + i, 1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto fail;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i +=3D e_node-&gt;len=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the tail-end data */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D inode-&gt;i_size % =
EROFS_BLKSIZ;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (inode-&gt;idata_size) {<br>
&gt; @@ -479,8 +582,14 @@ static bool erofs_bh_flush_write_inode(struct ero=
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
&gt; +=C2=A0 =C2=A0 =C2=A0if (inode-&gt;sparse_extent_isize) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D erofs_write_s=
parse_extents(inode, off);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_iput(inode);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_bh_flush_generic_end(bh);<br>
&gt; @@ -737,10 +846,11 @@ struct erofs_inode *erofs_new_inode(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_subdirs);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_xattrs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_sparse_extents);<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;xattr_isize =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_isize =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;sparse_extent_isize =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D inode-&gt;bh_inline =3D ino=
de-&gt;bh_data =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata =3D NULL;<br>
&gt; @@ -961,4 +1071,3 @@ struct erofs_inode *erofs_mkfs_build_tree_from_pa=
th(struct erofs_inode *parent,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(inode);<br>
&gt;=C2=A0 }<br>
&gt; -<br>
&gt; -- <br>
&gt; 2.9.3<br>
&gt; <br>
</blockquote></div>

--0000000000001427f0059b2622fc--
