Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 862BB14AF4D
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jan 2020 07:01:54 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486GGR5n26zDqD0
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jan 2020 17:01:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::541;
 helo=mail-ed1-x541.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=r7Rx95me; dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486GGM2cKHzDqC6
 for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jan 2020 17:01:47 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id f8so13450487edv.2
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Jan 2020 22:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2USLObZzWCS+4S4Lpd/UJWVn4Z+BL0xeEhRKw7oFXgg=;
 b=r7Rx95meGWRhPAkK1rfwHM3fdyzI96Hbvn+Ia+3tJVg+4H3dXzD5eklM22GIUfricE
 RKOeLghH25GASoqlee0Q9s88QKUSSZmjwlgP4CTkSv0nbX7UWYtcQGTlII2WGZNK3XPa
 rptDQ0Ps7WxfJzx4SOX/XWcJ5o4aB57jrtbCiWFfVtWIe4QQPSgJnUnJqcZG1f3QmphF
 191+IRaUMr69Bq4ppzUHXlr9mh6o0NTNF0/2+/7PAP86N/TxLigRRp9KNSydbpw/GXy2
 xm4ULfKBbhpGQHsGLp3c0pXHS2DGeL5wZ/IJF8Ff+gOYBQ6w5ytjK8/M40baqOzHxczQ
 JHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2USLObZzWCS+4S4Lpd/UJWVn4Z+BL0xeEhRKw7oFXgg=;
 b=QsWV3BNy0FeqEA5lYfrmQz74IqKn/AJdFX/RMmejVUVASI4Nq2+n3AHuISYWZCxHQD
 azzaNjtZX7/lY3lXpHSaIaA0QgkRoaHM/C8V2rDcCv+3GyFoRX+qP9eNuqzucqzfdQrw
 BhLvzpScjZxWxZwhkQPO6VO0LKcyO2OMZHGALCSvxsM4CINe8YG8+fmLo5amHfJ77ygV
 bj+Y+bpXcY98DzjI9XNLiCEUEIwIsDNsYzaYCUf/pXUxJrsV/d//iBI3mgEYzDaFg5HK
 BlX9q3JcnK8o4LzGXEQY/FHNODDYWEDW76F3USDyuzd52YNmpgqdKZZ7/SctPxzcM8sa
 V7kA==
X-Gm-Message-State: APjAAAVqPTyHmhnDg63G9Vdn+xXvZEVx2NT7nbPb/Ba6g0rSa9x+2n+t
 PvSm6Y3R7VejDLN3I97nZjNcwioNKrsZXibnqvo=
X-Google-Smtp-Source: APXvYqzziQUbggxJZ/KvJw7sNHz/zzR3ZO16PYSWvS67/3LsEa7oYn6D8hqkgUPsTTlZj4fd9tItdqfNUzxEO1vtgZM=
X-Received: by 2002:a17:906:4b11:: with SMTP id
 y17mr1747443eju.118.1580191302817; 
 Mon, 27 Jan 2020 22:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20200102094732.31567-1-pratikshinde320@gmail.com>
 <20200102104704.GB189482@architecture4>
 <CAGu0czRH7KYsxYFbQy3_rMeNCV6Fsg__PRuovdp672ZCu2vjkA@mail.gmail.com>
 <20200102133319.GA85503@architecture4>
In-Reply-To: <20200102133319.GA85503@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 28 Jan 2020 11:31:29 +0530
Message-ID: <CAGu0czRBPft9f=OVAoYv6_6Bj8jdJfDVYL51OfpeeuZ=UUPnGQ@mail.gmail.com>
Subject: Re: [RFCv3] erofs-utils: on-disk extent format for blocks
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000481b8c059d2cf5ba"
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

--000000000000481b8c059d2cf5ba
Content-Type: text/plain; charset="UTF-8"

Hello Gao,

I have started working on the on kernel side RFC patch of this change , is
this still on erofs roadmap ?  Will you able to review it?

--Pratik.

On Thu, Jan 2, 2020, 7:03 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Thu, Jan 02, 2020 at 04:32:34PM +0530, Pratik Shinde wrote:
> > Hi Gao,
> >
> > You are correct. The macro logic can be simplified. I will do that.
> > I will work on the kernel part of this change & do some testing on it.
> > I will keep you posted about the change and relevant tests I am running
> on
> > it.
> >
> > --Pratik.
> >
>
> Okay, thanks for your effort. :)
>
> Thanks,
> Gao Xiang
>
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > On Thu, Jan 2, 2020, 4:17 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >
> > > Hi Pratik,
> > >
> > > On Thu, Jan 02, 2020 at 03:17:32PM +0530, Pratik Shinde wrote:
> > > > 1)Moved on-disk structures to erofs_fs.h
> > > > 2)Some naming changes.
> > > >
> > > > I think we can keep 'IS_HOLE()' macro, otherwise the code
> > > > does not look clean(if used directly/without macro).Its getting
> > > > used only in inode.c so it can be kept there.
> > > > what do you think ?
> > >
> > > What I'm little concerned is the relationship between
> > > the name of IS_HOLE and its implementation...
> > >
> > > In other words, why
> > >  roundup(start, EROFS_BLKSIZ) == start &&
> > >  roundup(end, EROFS_BLKSIZ) == end &&
> > >  (end - start) % EROFS_BLKSIZ == 0
> > > should be an erofs hole...
> > >
> > > But that is minor, I reserve my opinion on this for now...
> > >
> > > This patch generally looks good to me, yet I haven't
> > > played with it till now.
> > >
> > > Could you implement a workable RFC patch for kernel side
> > > as well? Since I'm still busying in XZ library and other
> > > convert patches for 5.6...
> > >
> > > I'd like to hear if some other opinions from Chao and Guifu.
> > > Since it enhances the on-disk format, we need to think it
> > > over (especially its future expandability).
> > >
> > >
> > > To Chao and Guifu,
> > > Could you have some extra time looking at this stuff as well?
> > >
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > ---
> > > >  include/erofs/internal.h |   9 ++-
> > > >  include/erofs_fs.h       |  11 ++++
> > > >  lib/inode.c              | 153
> > > ++++++++++++++++++++++++++++++++++++++++-------
> > > >  3 files changed, 150 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > > > index e13adda..2d7466b 100644
> > > > --- a/include/erofs/internal.h
> > > > +++ b/include/erofs/internal.h
> > > > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> > > >  extern struct erofs_sb_info sbi;
> > > >
> > > >  struct erofs_inode {
> > > > -     struct list_head i_hash, i_subdirs, i_xattrs;
> > > > +     struct list_head i_hash, i_subdirs, i_xattrs, i_sparse_extents;
> > > >
> > > >       unsigned int i_count;
> > > >       struct erofs_inode *i_parent;
> > > > @@ -93,6 +93,7 @@ struct erofs_inode {
> > > >
> > > >       unsigned int xattr_isize;
> > > >       unsigned int extent_isize;
> > > > +     unsigned int sparse_extent_isize;
> > > >
> > > >       erofs_nid_t nid;
> > > >       struct erofs_buffer_head *bh;
> > > > @@ -139,5 +140,11 @@ static inline const char *erofs_strerror(int
> err)
> > > >       return msg;
> > > >  }
> > > >
> > > > +struct erofs_sparse_extent_node {
> > > > +     struct list_head next;
> > > > +     erofs_blk_t lblk;
> > > > +     erofs_blk_t pblk;
> > > > +     u32 len;
> > > > +};
> > > >  #endif
> > > >
> > > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > > index bcc4f0c..a63e1c6 100644
> > > > --- a/include/erofs_fs.h
> > > > +++ b/include/erofs_fs.h
> > > > @@ -321,5 +321,16 @@ static inline void
> > > erofs_check_ondisk_layout_definitions(void)
> > > >                    Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
> > > >  }
> > > >
> > > > +/* on-disk sparse extent format */
> > > > +struct erofs_sparse_extent {
> > > > +     __le32 ee_lblk;
> > > > +     __le32 ee_pblk;
> > > > +     __le32 ee_len;
> > > > +};
> > > > +
> > > > +struct erofs_sparse_extent_iheader {
> > > > +     u32 count;
> > > > +};
> > > > +
> > > >  #endif
> > > >
> > > > diff --git a/lib/inode.c b/lib/inode.c
> > > > index 0e19b11..da20599 100644
> > > > --- a/lib/inode.c
> > > > +++ b/lib/inode.c
> > > > @@ -38,6 +38,97 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> > > S_SHIFT] = {
> > > >
> > > >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> > > >
> > > > +
> > > > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start
> &&
> > >       \
> > > > +                          roundup(end, EROFS_BLKSIZ) == end &&
>  \
> > > > +                         (end - start) % EROFS_BLKSIZ == 0)
> > > > +
> > > > +/**
> > > > +   read extents of the given file.
> > > > +   record the data extents and link them into a chain.
> > > > +   exclude holes present in file.
> > > > + */
> > > > +unsigned int erofs_read_sparse_extents(int fd, struct list_head
> > > *extents)
> > > > +{
> > > > +     erofs_blk_t startblk, endblk, datablk;
> > > > +     unsigned int nholes = 0;
> > > > +     erofs_off_t data, hole, len = 0, last_data;
> > > > +     struct erofs_sparse_extent_node *e_data;
> > > > +
> > > > +     len = lseek(fd, 0, SEEK_END);
> > > > +     if (len < 0)
> > > > +             return -errno;
> > > > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > > > +             return -errno;
> > > > +     data = 0;
> > > > +     last_data = 0;
> > > > +     while (data < len) {
> > > > +             hole = lseek(fd, data, SEEK_HOLE);
> > > > +             if (hole == len)
> > > > +                     break;
> > > > +             data = lseek(fd, hole, SEEK_DATA);
> > > > +             if (data < 0 || hole > data)
> > > > +                     return -EINVAL;
> > > > +             if (IS_HOLE(hole, data)) {
> > > > +                     startblk = erofs_blknr(hole);
> > > > +                     datablk = erofs_blknr(last_data);
> > > > +                     endblk = erofs_blknr(data);
> > > > +                     last_data = data;
> > > > +                     e_data = malloc(sizeof(
> > > > +                                      struct
> erofs_sparse_extent_node));
> > > > +                     if (e_data == NULL)
> > > > +                             return -ENOMEM;
> > > > +                     e_data->lblk = datablk;
> > > > +                     e_data->len = (startblk - datablk);
> > > > +                     list_add_tail(&e_data->next, extents);
> > > > +                     nholes += (endblk - startblk);
> > > > +             }
> > > > +     }
> > > > +     /* rounddown to exclude tail-end data */
> > > > +     if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> > > > +             e_data = malloc(sizeof(struct
> erofs_sparse_extent_node));
> > > > +             if (e_data == NULL)
> > > > +                     return -ENOMEM;
> > > > +             startblk = erofs_blknr(last_data);
> > > > +             e_data->lblk = startblk;
> > > > +             e_data->len = erofs_blknr(rounddown((len - last_data),
> > > > +                                       EROFS_BLKSIZ));
> > > > +             list_add_tail(&e_data->next, extents);
> > > > +     }
> > > > +     return nholes;
> > > > +}
> > > > +
> > > > +int erofs_write_sparse_extents(struct erofs_inode *inode,
> erofs_off_t
> > > off)
> > > > +{
> > > > +     struct erofs_sparse_extent_node *e_node;
> > > > +     struct erofs_sparse_extent_iheader *header;
> > > > +     char *buf;
> > > > +     unsigned int p = 0;
> > > > +     int ret;
> > > > +
> > > > +     buf = malloc(inode->sparse_extent_isize);
> > > > +     if (buf == NULL)
> > > > +             return -ENOMEM;
> > > > +     header = (struct erofs_sparse_extent_iheader *) buf;
> > > > +     header->count = 0;
> > > > +     p += sizeof(struct erofs_sparse_extent_iheader);
> > > > +     list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> > > > +             const struct erofs_sparse_extent ee = {
> > > > +                     .ee_lblk = cpu_to_le32(e_node->lblk),
> > > > +                     .ee_pblk = cpu_to_le32(e_node->pblk),
> > > > +                     .ee_len  = cpu_to_le32(e_node->len)
> > > > +             };
> > > > +             memcpy(buf + p, &ee, sizeof(struct
> erofs_sparse_extent));
> > > > +             p += sizeof(struct erofs_sparse_extent);
> > > > +             header->count++;
> > > > +             list_del(&e_node->next);
> > > > +             free(e_node);
> > > > +     }
> > > > +     ret = dev_write(buf, off, inode->sparse_extent_isize);
> > > > +     free(buf);
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  void erofs_inode_manager_init(void)
> > > >  {
> > > >       unsigned int i;
> > > > @@ -304,8 +395,9 @@ static bool erofs_file_is_compressible(struct
> > > erofs_inode *inode)
> > > >
> > > >  int erofs_write_file(struct erofs_inode *inode)
> > > >  {
> > > > -     unsigned int nblocks, i;
> > > > +     unsigned int nblocks, i, j, nholes;
> > > >       int ret, fd;
> > > > +     struct erofs_sparse_extent_node *e_node;
> > > >
> > > >       if (!inode->i_size) {
> > > >               inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > > > @@ -322,31 +414,42 @@ int erofs_write_file(struct erofs_inode *inode)
> > > >       /* fallback to all data uncompressed */
> > > >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> > > >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > > > -
> > > > -     ret = __allocate_inode_bh_data(inode, nblocks);
> > > > -     if (ret)
> > > > -             return ret;
> > > > -
> > > >       fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> > > >       if (fd < 0)
> > > >               return -errno;
> > > > -
> > > > -     for (i = 0; i < nblocks; ++i) {
> > > > -             char buf[EROFS_BLKSIZ];
> > > > -
> > > > -             ret = read(fd, buf, EROFS_BLKSIZ);
> > > > -             if (ret != EROFS_BLKSIZ) {
> > > > -                     if (ret < 0)
> > > > +     nholes = erofs_read_sparse_extents(fd,
> &inode->i_sparse_extents);
> > > > +     if (nholes < 0) {
> > > > +             close(fd);
> > > > +             return nholes;
> > > > +     }
> > > > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> > > > +     if (ret) {
> > > > +             close(fd);
> > > > +             return ret;
> > > > +     }
> > > > +     i = inode->u.i_blkaddr;
> > > > +     inode->sparse_extent_isize = sizeof(struct
> > > erofs_sparse_extent_iheader);
> > > > +     list_for_each_entry(e_node, &inode->i_sparse_extents, next) {
> > > > +             inode->sparse_extent_isize += sizeof(struct
> > > erofs_sparse_extent);
> > > > +             e_node->pblk = i;
> > > > +             ret = lseek(fd, blknr_to_addr(e_node->lblk), SEEK_SET);
> > > > +             if (ret < 0)
> > > > +                     goto fail;
> > > > +             for (j = 0; j < e_node->len; j++) {
> > > > +                     char buf[EROFS_BLKSIZ];
> > > > +                     ret = read(fd, buf, EROFS_BLKSIZ);
> > > > +                     if (ret != EROFS_BLKSIZ) {
> > > > +                             if (ret < 0)
> > > > +                                     goto fail;
> > > > +                             close(fd);
> > > > +                             return -EAGAIN;
> > > > +                     }
> > > > +                     ret = blk_write(buf, e_node->pblk + j, 1);
> > > > +                     if (ret)
> > > >                               goto fail;
> > > > -                     close(fd);
> > > > -                     return -EAGAIN;
> > > >               }
> > > > -
> > > > -             ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> > > > -             if (ret)
> > > > -                     goto fail;
> > > > +             i += e_node->len;
> > > >       }
> > > > -
> > > >       /* read the tail-end data */
> > > >       inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> > > >       if (inode->idata_size) {
> > > > @@ -479,8 +582,14 @@ static bool erofs_bh_flush_write_inode(struct
> > > erofs_buffer_head *bh)
> > > >               if (ret)
> > > >                       return false;
> > > >               free(inode->compressmeta);
> > > > +             off += inode->extent_isize;
> > > >       }
> > > >
> > > > +     if (inode->sparse_extent_isize) {
> > > > +             ret = erofs_write_sparse_extents(inode, off);
> > > > +             if (ret)
> > > > +                     return false;
> > > > +     }
> > > >       inode->bh = NULL;
> > > >       erofs_iput(inode);
> > > >       return erofs_bh_flush_generic_end(bh);
> > > > @@ -737,10 +846,11 @@ struct erofs_inode *erofs_new_inode(void)
> > > >
> > > >       init_list_head(&inode->i_subdirs);
> > > >       init_list_head(&inode->i_xattrs);
> > > > +     init_list_head(&inode->i_sparse_extents);
> > > >
> > > >       inode->idata_size = 0;
> > > >       inode->xattr_isize = 0;
> > > > -     inode->extent_isize = 0;
> > > > +     inode->sparse_extent_isize = 0;
> > > >
> > > >       inode->bh = inode->bh_inline = inode->bh_data = NULL;
> > > >       inode->idata = NULL;
> > > > @@ -961,4 +1071,3 @@ struct erofs_inode
> > > *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> > > >
> > > >       return erofs_mkfs_build_tree(inode);
> > > >  }
> > > > -
> > > > --
> > > > 2.9.3
> > > >
> > >
>

--000000000000481b8c059d2cf5ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Gao,<div dir=3D"auto"><br></div><div dir=3D"auto">I=
 have started working on the on kernel side RFC patch of this change , is t=
his still on erofs roadmap ?=C2=A0 Will you able to review it?</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">--Pratik.</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 2, 2020,=
 7:03 PM Gao Xiang &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@=
huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, =
Jan 02, 2020 at 04:32:34PM +0530, Pratik Shinde wrote:<br>
&gt; Hi Gao,<br>
&gt; <br>
&gt; You are correct. The macro logic can be simplified. I will do that.<br=
>
&gt; I will work on the kernel part of this change &amp; do some testing on=
 it.<br>
&gt; I will keep you posted about the change and relevant tests I am runnin=
g on<br>
&gt; it.<br>
&gt; <br>
&gt; --Pratik.<br>
&gt;<br>
<br>
Okay, thanks for your effort. :)<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Thu, Jan 2, 2020, 4:17 PM Gao Xiang &lt;<a href=3D"mailto:gaoxiang2=
5@huawei.com" target=3D"_blank" rel=3D"noreferrer">gaoxiang25@huawei.com</a=
>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Pratik,<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Jan 02, 2020 at 03:17:32PM +0530, Pratik Shinde wrote:<br=
>
&gt; &gt; &gt; 1)Moved on-disk structures to erofs_fs.h<br>
&gt; &gt; &gt; 2)Some naming changes.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I think we can keep &#39;IS_HOLE()&#39; macro, otherwise the=
 code<br>
&gt; &gt; &gt; does not look clean(if used directly/without macro).Its gett=
ing<br>
&gt; &gt; &gt; used only in inode.c so it can be kept there.<br>
&gt; &gt; &gt; what do you think ?<br>
&gt; &gt;<br>
&gt; &gt; What I&#39;m little concerned is the relationship between<br>
&gt; &gt; the name of IS_HOLE and its implementation...<br>
&gt; &gt;<br>
&gt; &gt; In other words, why<br>
&gt; &gt;=C2=A0 roundup(start, EROFS_BLKSIZ) =3D=3D start &amp;&amp;<br>
&gt; &gt;=C2=A0 roundup(end, EROFS_BLKSIZ) =3D=3D end &amp;&amp;<br>
&gt; &gt;=C2=A0 (end - start) % EROFS_BLKSIZ =3D=3D 0<br>
&gt; &gt; should be an erofs hole...<br>
&gt; &gt;<br>
&gt; &gt; But that is minor, I reserve my opinion on this for now...<br>
&gt; &gt;<br>
&gt; &gt; This patch generally looks good to me, yet I haven&#39;t<br>
&gt; &gt; played with it till now.<br>
&gt; &gt;<br>
&gt; &gt; Could you implement a workable RFC patch for kernel side<br>
&gt; &gt; as well? Since I&#39;m still busying in XZ library and other<br>
&gt; &gt; convert patches for 5.6...<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d like to hear if some other opinions from Chao and Guifu.<=
br>
&gt; &gt; Since it enhances the on-disk format, we need to think it<br>
&gt; &gt; over (especially its future expandability).<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; To Chao and Guifu,<br>
&gt; &gt; Could you have some extra time looking at this stuff as well?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshi=
nde320@gmail.com" target=3D"_blank" rel=3D"noreferrer">pratikshinde320@gmai=
l.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/erofs/internal.h |=C2=A0 =C2=A09 ++-<br>
&gt; &gt; &gt;=C2=A0 include/erofs_fs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
1 ++++<br>
&gt; &gt; &gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 153<br>
&gt; &gt; ++++++++++++++++++++++++++++++++++++++++-------<br>
&gt; &gt; &gt;=C2=A0 3 files changed, 150 insertions(+), 23 deletions(-)<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/erofs/internal.h b/include/erofs/intern=
al.h<br>
&gt; &gt; &gt; index e13adda..2d7466b 100644<br>
&gt; &gt; &gt; --- a/include/erofs/internal.h<br>
&gt; &gt; &gt; +++ b/include/erofs/internal.h<br>
&gt; &gt; &gt; @@ -63,7 +63,7 @@ struct erofs_sb_info {<br>
&gt; &gt; &gt;=C2=A0 extern struct erofs_sb_info sbi;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 struct erofs_inode {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_x=
attrs;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_x=
attrs, i_sparse_extents;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i_count;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *i_parent;<br>
&gt; &gt; &gt; @@ -93,6 +93,7 @@ struct erofs_inode {<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xattr_isize;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int extent_isize;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int sparse_extent_isize;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_buffer_head *bh;<br>
&gt; &gt; &gt; @@ -139,5 +140,11 @@ static inline const char *erofs_strerro=
r(int err)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return msg;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +struct erofs_sparse_extent_node {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct list_head next;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t lblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t pblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 len;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/erofs_fs.h b/include/erofs_fs.h<br>
&gt; &gt; &gt; index bcc4f0c..a63e1c6 100644<br>
&gt; &gt; &gt; --- a/include/erofs_fs.h<br>
&gt; &gt; &gt; +++ b/include/erofs_fs.h<br>
&gt; &gt; &gt; @@ -321,5 +321,16 @@ static inline void<br>
&gt; &gt; erofs_check_ondisk_layout_definitions(void)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +/* on-disk sparse extent format */<br>
&gt; &gt; &gt; +struct erofs_sparse_extent {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_lblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_pblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_len;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct erofs_sparse_extent_iheader {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 count;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; &gt; &gt; index 0e19b11..da20599 100644<br>
&gt; &gt; &gt; --- a/lib/inode.c<br>
&gt; &gt; &gt; +++ b/lib/inode.c<br>
&gt; &gt; &gt; @@ -38,6 +38,97 @@ static unsigned char erofs_type_by_mode[S=
_IFMT &gt;&gt;<br>
&gt; &gt; S_SHIFT] =3D {<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 struct list_head inode_hashtable[NR_INODE_HASHTABLE];<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) =
=3D=3D start &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 roundup(end, EROFS_BLKSIZ) =3D=3D end &amp;=
&amp;=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(end - start) % EROFS_BLKSIZ =3D=3D 0)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/**<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0read extents of the given file.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0record the data extents and link them into a c=
hain.<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0exclude holes present in file.<br>
&gt; &gt; &gt; + */<br>
&gt; &gt; &gt; +unsigned int erofs_read_sparse_extents(int fd, struct list_=
head<br>
&gt; &gt; *extents)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t startblk, endblk, datablk;<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nholes =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len =3D 0, last=
_data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_data=
;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (len &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -err=
no;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (lseek(fd, 0, SEEK_SET) =3D=3D -1)<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -err=
no;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0data =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0last_data =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0while (data &lt; len) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hole =3D ls=
eek(fd, data, SEEK_HOLE);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hole =
=3D=3D len)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D ls=
eek(fd, hole, SEEK_DATA);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (data &l=
t; 0 || hole &gt; data)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_HOLE=
(hole, data)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0startblk =3D erofs_blknr(hole);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0datablk =3D erofs_blknr(last_data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0endblk =3D erofs_blknr(data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0last_data =3D data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data =3D malloc(sizeof(<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct erofs_sparse_extent_node));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (e_data =3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data-&gt;lblk =3D datablk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data-&gt;len =3D (startblk - datablk);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0list_add_tail(&amp;e_data-&gt;next, extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0nholes +=3D (endblk - startblk);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/* rounddown to exclude tail-end data *=
/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (last_data &lt; len &amp;&amp; (len =
- last_data) &gt;=3D EROFS_BLKSIZ) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data =3D =
malloc(sizeof(struct erofs_sparse_extent_node));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_data =
=3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0startblk =
=3D erofs_blknr(last_data);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;=
lblk =3D startblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;=
len =3D erofs_blknr(rounddown((len - last_data),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0EROFS_BLKSIZ));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_ta=
il(&amp;e_data-&gt;next, extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +int erofs_write_sparse_extents(struct erofs_inode *inode, e=
rofs_off_t<br>
&gt; &gt; off)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_node=
;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_iheader *hea=
der;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int p =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(inode-&gt;sparse_extent_=
isize);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (buf =3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENO=
MEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0header =3D (struct erofs_sparse_extent_=
iheader *) buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0header-&gt;count =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct erofs_sparse_exten=
t_iheader);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-=
&gt;i_sparse_extents, next) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struc=
t erofs_sparse_extent ee =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_lblk =3D cpu_to_le32(e_node-&gt;lblk),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_pblk =3D cpu_to_le32(e_node-&gt;pblk),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_len=C2=A0 =3D cpu_to_le32(e_node-&gt;len)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buf =
+ p, &amp;ee, sizeof(struct erofs_sparse_extent));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D size=
of(struct erofs_sparse_extent);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header-&gt;=
count++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&a=
mp;e_node-&gt;next);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(e_node=
);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D dev_write(buf, off, inode-&gt;s=
parse_extent_isize);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0free(buf);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; &gt; &gt; @@ -304,8 +395,9 @@ static bool erofs_file_is_compressible(s=
truct<br>
&gt; &gt; erofs_inode *inode)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i, j, nholes;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_sparse_extent_node *e_node=
;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-=
&gt;datalayout =3D EROFS_INODE_FLAT_PLAIN;<br>
&gt; &gt; &gt; @@ -322,31 +414,42 @@ int erofs_write_file(struct erofs_inod=
e *inode)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fallback to all data uncompress=
ed */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;datalayout =3D EROFS_INO=
DE_FLAT_INLINE;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0nblocks =3D inode-&gt;i_size / ERO=
FS_BLKSIZ;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode,=
 nblocks);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;=
<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O=
_RDONLY | O_BINARY);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 -errno;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nblocks; ++i) {<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[ER=
OFS_BLKSIZ];<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rea=
d(fd, buf, EROFS_BLKSIZ);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=
=3D EROFS_BLKSIZ) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0nholes =3D erofs_read_sparse_extents(fd=
, &amp;inode-&gt;i_sparse_extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (nholes &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nhol=
es;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode,=
 nblocks - nholes);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0i =3D inode-&gt;u.i_blkaddr;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;sparse_extent_isize =3D sizeo=
f(struct<br>
&gt; &gt; erofs_sparse_extent_iheader);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-=
&gt;i_sparse_extents, next) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;s=
parse_extent_isize +=3D sizeof(struct<br>
&gt; &gt; erofs_sparse_extent);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_node-&gt;=
pblk =3D i;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D lse=
ek(fd, blknr_to_addr(e_node-&gt;lblk), SEEK_SET);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt=
; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D =
0; j &lt; e_node-&gt;len; j++) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char buf[EROFS_BLKSIZ];<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D read(fd, buf, EROFS_BLKSIZ);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret !=3D EROFS_BLKSIZ) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to fail;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ret =3D blk_write(buf, e_node-&gt;pblk + j, 1);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk=
_write(buf, inode-&gt;u.i_blkaddr + i, 1);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i +=3D e_no=
de-&gt;len;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the tail-end data */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D inode-&gt=
;i_size % EROFS_BLKSIZ;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (inode-&gt;idata_size) {<br>
&gt; &gt; &gt; @@ -479,8 +582,14 @@ static bool erofs_bh_flush_write_inode(=
struct<br>
&gt; &gt; erofs_buffer_head *bh)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (re=
t)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(i=
node-&gt;compressmeta);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off +=3D in=
ode-&gt;extent_isize;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (inode-&gt;sparse_extent_isize) {<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ero=
fs_write_sparse_extents(inode, off);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_iput(inode);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_bh_flush_generic_end(=
bh);<br>
&gt; &gt; &gt; @@ -737,10 +846,11 @@ struct erofs_inode *erofs_new_inode(vo=
id)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_su=
bdirs);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_xa=
ttrs);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_sparse_=
extents);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D 0;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;xattr_isize =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_isize =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;sparse_extent_isize =3D 0;<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D inode-&gt;bh_inli=
ne =3D inode-&gt;bh_data =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata =3D NULL;<br>
&gt; &gt; &gt; @@ -961,4 +1071,3 @@ struct erofs_inode<br>
&gt; &gt; *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_mkfs_build_tree(inode=
);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.9.3<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000481b8c059d2cf5ba--
