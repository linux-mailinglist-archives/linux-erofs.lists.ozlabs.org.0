Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107212CD39
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 08:04:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47mT2b45VjzDq9s
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 18:04:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com; envelope-from=pratikshinde320@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="V7ymfynW"; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47mT2V4LSKzDq9Z
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2019 18:04:50 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id b8so31829408edx.7
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2019 23:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NWeXv0ror1nIcjppWddx96xyaXasXfZLYMZsnXqjQoI=;
 b=V7ymfynW/uK5bh6TiWGlTOWsqaVzKmiDXse46He/O9WzgNrl4dSW08NDKksUp7tGlU
 61IKqxRq7pRgFMbm3LRcvXtZ04ynqDbk5HWE+d195MxjPep3BFfl1DMIco8djCRpafmT
 dD1w6nB1LtdHDxV6h8CF7DeUgZrS0RxXwJVJY6Jke3xVeSh5MKlTXTTMeh/CTHVOsEQW
 Q7fVS16EwMvIom/LyE/cMYi9yAih8iOJ28riDjf98SwNacU/ObItKaSHhFg3j59lLzSv
 CKTrcixl+DnPcGRXoxH01ogl77LvzSSh8hWV3S8kL8HOtF1VYpOqAfKa1q2ZLx9i0Z7e
 VS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NWeXv0ror1nIcjppWddx96xyaXasXfZLYMZsnXqjQoI=;
 b=BHcgUTE42ti9I4T9DXzGQhIYt2+71vJg3ucfdYSx+M37TGJFQTJ6/W9N0DKKjjaoC5
 i5+rf6V1iHj3oxTo+8YSGTnHuFFpiQTzVLbzLmJ6RJzVWVze3/PUuompgXP6ao2ain4h
 VTUAtBplPmIA/Hz09gd9Ijk7+00CyHqclA+C0ONC0Bj3dsAVKNp0K2fK1Vp3dpgg38vn
 w3XHgwtljV7DcuJhynSUOR8hDdqonCqhhppGpwxouF7vfvYzOCCZlrbN2sqlQ79rXBG7
 l/arCXow+jEW8gTniph0nsG1DjZxVZaPjsyJi+h3ToZ91p2GCM1qPg2cfyEPZ2y85R3H
 Nxxg==
X-Gm-Message-State: APjAAAXA4UgPl4XAB00N79rM+VlDrxqzz0Mcuyxd8PDufHP8aNnDhTzT
 eif7WDtNpVeCC1mwv1b16UXjGQpXrNgYYFXveToE54hUfpOh3Q==
X-Google-Smtp-Source: APXvYqy4CreDLsTBNDMFsF2fnxFvNRMx5fJ7NvW6Kc4XC8dwtPXg4mspLxiYiHBKQTPDlKcR/+lQCEALN3GvdojW1uQ=
X-Received: by 2002:aa7:c994:: with SMTP id c20mr69090649edt.113.1577689483250; 
 Sun, 29 Dec 2019 23:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20191227154348.21432-1-pratikshinde320@gmail.com>
 <20191229025546.GB2215@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSGGxgFsVMwNOY5cqR35bUYmp-6qCUTLfUEfLHgqcHbOw@mail.gmail.com>
 <20191230064911.GA169899@architecture4>
In-Reply-To: <20191230064911.GA169899@architecture4>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Mon, 30 Dec 2019 12:34:30 +0530
Message-ID: <CAGu0czS5gEU5Y9UT_fdXuxKNHcHPXJeE7dC+Fh1UMfSa_Q9+1w@mail.gmail.com>
Subject: Re: [RFC] erofs-utils: on-disk extent format for blocks.
To: Gao Xiang <gaoxiang25@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000371058059ae675d6"
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
Cc: linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000371058059ae675d6
Content-Type: text/plain; charset="UTF-8"

Thanks got it.

Then we can use LOG_BLOCK_SIZE , to get block no. for corresponding file
offset.

--Pratik.

On Mon, Dec 30, 2019 at 12:19 PM Gao Xiang <gaoxiang25@huawei.com> wrote:

> On Mon, Dec 30, 2019 at 11:49:55AM +0530, Pratik Shinde wrote:
> > Gao,
> >
> > Okay, I will rename the 'size' variables accordingly.
> > The 'S_SHIFT' gives the logical block number inside file. I am using it
> to
> > assign logical block no.
> > to extents.
>
> S_SHIFT is used to transfer between i_mode and filetype, see:
> https://elixir.bootlin.com/linux/latest/source/fs/ext4/ext4.h#L3196
>
> IMO, which is not the above meaning, how about using EROFS_BLKSIZ
> instead?
>
> Thanks,
> Gao Xiang
>
> > Also, I will modify the code to record only data extents.
> >
> > --Pratik.
> >
> > On Sun, Dec 29, 2019 at 8:26 AM Gao Xiang <hsiangkao@aol.com> wrote:
> >
> > > Hi Pratik,
> > >
> > > On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:
> > > > since this patch is quite different from previous patches I am
> treating
> > > > this as new patch.
> > > >
> > > > 1) On disk extent format for erofs data blocks.
> > > > 2) Detect holes inside files & skip allocation for hole blocks.
> > > >
> > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > ---
> > > >  include/erofs/internal.h |  21 ++++++-
> > > >  lib/inode.c              | 155
> > > +++++++++++++++++++++++++++++++++++++++++------
> > > >  2 files changed, 156 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > > > index e13adda..128aa63 100644
> > > > --- a/include/erofs/internal.h
> > > > +++ b/include/erofs/internal.h
> > > > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> > > >  extern struct erofs_sb_info sbi;
> > > >
> > > >  struct erofs_inode {
> > > > -     struct list_head i_hash, i_subdirs, i_xattrs;
> > > > +     struct list_head i_hash, i_subdirs, i_xattrs, i_extents;
> > > >
> > > >       unsigned int i_count;
> > > >       struct erofs_inode *i_parent;
> > > > @@ -93,6 +93,7 @@ struct erofs_inode {
> > > >
> > > >       unsigned int xattr_isize;
> > > >       unsigned int extent_isize;
> > > > +     unsigned int extent_meta_isize;
> > >
> > > maybe sparse_extent_isize is better...
> > >
> > > p.s. maybe we could send another patch rename extent_isize to
> > > compress_extent_isize or some better name...
> > >
> > > >
> > > >       erofs_nid_t nid;
> > > >       struct erofs_buffer_head *bh;
> > > > @@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int
> err)
> > > >       return msg;
> > > >  }
> > > >
> > > > +#define HOLE_BLK     -1
> > > > +/* on disk extent format */
> > > > +struct erofs_extent {
> > > > +     __le32 ee_lblk;
> > > > +     __le32 ee_pblk;
> > > > +     __le32 ee_len;
> > > > +};
> > > > +
> > > > +struct erofs_extent_node {
> > > > +     struct list_head next;
> > > > +     erofs_blk_t lblk;
> > > > +     erofs_blk_t pblk;
> > > > +     u32 len;
> > > > +};
> > > > +
> > > > +struct erofs_inline_extent_header {
> > > > +     u32 count;
> > > > +};
> > > >  #endif
> > > >
> > > > diff --git a/lib/inode.c b/lib/inode.c
> > > > index 0e19b11..a6af509 100644
> > > > --- a/lib/inode.c
> > > > +++ b/lib/inode.c
> > > > @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
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
> > >
> > > See below..
> > >
> > > > +
> > > > +/* returns the number of holes present in the file */
> > > > +unsigned int erofs_read_extents(struct erofs_inode *inode,
> > > > +                             struct list_head *extents)
> > > > +{
> > > > +     int fd, st, en, dt;
> > > > +     unsigned int nholes = 0;
> > > > +     erofs_off_t data, hole, len, last_data;
> > > > +     struct erofs_extent_node *e_hole, *e_data;
> > > > +
> > > > +     fd = open(inode->i_srcpath, O_RDONLY);
> > > > +     if (fd < 0) {
> > > > +             return -errno;
> > > > +     }
> > > > +     len = lseek(fd, 0, SEEK_END);
> > > > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > > > +             return -errno;
> > > > +     data = 0;
> > > > +     last_data = 0;
> > > > +     while (data < len) {
> > > > +             hole = lseek(fd, data, SEEK_HOLE);
> > > > +             if (hole == len)
> > > > +                     break;
> > > > +             data = lseek(fd, hole, SEEK_DATA);
> > > > +             if (data < 0 || hole > data) {
> > > > +                     return -EINVAL;
> > > > +             }
> > > > +             if (IS_HOLE(hole, data)) {
> > > > +                     st = hole >> S_SHIFT;
> > > > +                     en = data >> S_SHIFT;
> > > > +                     dt = last_data >> S_SHIFT;
> > >
> > > Why using S_SHIFT here, some special meaning?
> > >
> > > > +                     last_data = data;
> > > > +                     e_data = malloc(sizeof(struct
> erofs_extent_node));
> > > > +                     if (e_data == NULL)
> > > > +                             return -ENOMEM;
> > > > +                     e_data->lblk = dt;
> > > > +                     e_data->len = (st - dt);
> > > > +                     list_add_tail(&e_data->next, extents);
> > > > +                     e_hole = malloc(sizeof(struct
> erofs_extent_node));
> > > > +                     if (e_hole == NULL)
> > > > +                             return -ENOMEM;
> > > > +                     e_hole->lblk = st;
> > > > +                     e_hole->pblk = HOLE_BLK;
> > > > +                     e_hole->len = (en - st);
> > > > +                     list_add_tail(&e_hole->next, extents);
> > > > +                     nholes += e_hole->len;
> > >
> > > Maybe we don't need to emit all HOLK extents since all data extents
> > > are with _length_... It is easy to detect all holes between extents...
> > >
> > > If some block doesn't belong to any extent, it's a hole.
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > > +             }
> > > > +     }
> > > > +     /* rounddown to exclude tail-end data */
> > > > +     if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> > > > +             e_data = malloc(sizeof(struct erofs_extent_node));
> > > > +             if (e_data == NULL)
> > > > +                     return -ENOMEM;
> > > > +             st = last_data >> S_SHIFT;
> > > > +             e_data->lblk = st;
> > > > +             e_data->len = rounddown((len - last_data),
> EROFS_BLKSIZ)
> > > >> S_SHIFT;
> > > > +             list_add_tail(&e_data->next, extents);
> > > > +     }
> > > > +     return nholes;
> > > > +}
> > > > +
> > > > +char *erofs_create_extent_buffer(struct list_head *extents, unsigned
> > > int size)
> > > > +{
> > > > +     struct erofs_extent_node *e_node;
> > > > +     struct erofs_inline_extent_header *header;
> > > > +     char *buf;
> > > > +     unsigned int p = 0;
> > > > +
> > > > +     buf = malloc(size);
> > > > +     if (buf == NULL)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +     header = (struct erofs_inline_extent_header *) buf;
> > > > +     header->count = 0;
> > > > +     p += sizeof(struct erofs_inline_extent_header);
> > > > +     list_for_each_entry(e_node, extents, next) {
> > > > +             const struct erofs_extent ee = {
> > > > +                     .ee_lblk = cpu_to_le32(e_node->lblk),
> > > > +                     .ee_pblk = cpu_to_le32(e_node->pblk),
> > > > +                     .ee_len  = cpu_to_le32(e_node->len)
> > > > +             };
> > > > +             memcpy(buf + p, &ee, sizeof(struct erofs_extent));
> > > > +             p += sizeof(struct erofs_extent);
> > > > +             header->count++;
> > > > +             list_del(&e_node->next);
> > > > +             free(e_node);
> > > > +     }
> > > > +     return buf;
> > > > +}
> > > > +
> > > >  void erofs_inode_manager_init(void)
> > > >  {
> > > >       unsigned int i;
> > > > @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct
> > > erofs_inode *inode)
> > > >
> > > >  int erofs_write_file(struct erofs_inode *inode)
> > > >  {
> > > > -     unsigned int nblocks, i;
> > > > +     unsigned int nblocks, i, j, nholes;
> > > >       int ret, fd;
> > > > +     struct erofs_extent_node *e_node;
> > > >
> > > >       if (!inode->i_size) {
> > > >               inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> > > > @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode *inode)
> > > >       /* fallback to all data uncompressed */
> > > >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> > > >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > > > -
> > > > -     ret = __allocate_inode_bh_data(inode, nblocks);
> > > > +     nholes = erofs_read_extents(inode, &inode->i_extents);
> > > > +     if (nholes < 0)
> > > > +             return nholes;
> > > > +     if (nblocks < 0)
> > > > +             return nblocks;
> > > > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> > > >       if (ret)
> > > >               return ret;
> > > >
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
> > > > -                             goto fail;
> > > > -                     close(fd);
> > > > -                     return -EAGAIN;
> > > > +     i = inode->u.i_blkaddr;
> > > > +     inode->extent_meta_isize = sizeof(struct
> > > erofs_inline_extent_header);
> > > > +     list_for_each_entry(e_node, &inode->i_extents, next) {
> > > > +             inode->extent_meta_isize += sizeof(struct
> erofs_extent);
> > > > +             if (e_node->pblk == HOLE_BLK) {
> > > > +                     lseek(fd, e_node->len * EROFS_BLKSIZ,
> SEEK_CUR);
> > > > +                     continue;
> > > >               }
> > > > +             e_node->pblk = i;
> > > > +             i += e_node->len;
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
> > > > +                             goto fail;
> > > >
> > > > -             ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> > > > -             if (ret)
> > > > -                     goto fail;
> > > > +             }
> > > >       }
> > > > -
> > > >       /* read the tail-end data */
> > > >       inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> > > >       if (inode->idata_size) {
> > > > @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct
> > > erofs_buffer_head *bh)
> > > >               if (ret)
> > > >                       return false;
> > > >               free(inode->compressmeta);
> > > > +             off += inode->extent_isize;
> > > >       }
> > > >
> > > > +     if (inode->extent_meta_isize) {
> > > > +             char *extents =
> > > erofs_create_extent_buffer(&inode->i_extents,
> > > > +
> > > inode->extent_meta_isize);
> > > > +             if (IS_ERR(extents))
> > > > +                     return false;
> > > > +             ret = dev_write(extents, off,
> inode->extent_meta_isize);
> > > > +             free(extents);
> > > > +             if (ret)
> > > > +                     return false;
> > > > +     }
> > > >       inode->bh = NULL;
> > > >       erofs_iput(inode);
> > > >       return erofs_bh_flush_generic_end(bh);
> > > > @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)
> > > >
> > > >       init_list_head(&inode->i_subdirs);
> > > >       init_list_head(&inode->i_xattrs);
> > > > +     init_list_head(&inode->i_extents);
> > > >
> > > >       inode->idata_size = 0;
> > > >       inode->xattr_isize = 0;
> > > > -     inode->extent_isize = 0;
> > > > +     inode->extent_meta_isize = 0;
> > > >
> > > >       inode->bh = inode->bh_inline = inode->bh_data = NULL;
> > > >       inode->idata = NULL;
> > > > @@ -961,4 +1079,3 @@ struct erofs_inode
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

--000000000000371058059ae675d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks got it.</div><div><br></div><div>Then we can u=
se LOG_BLOCK_SIZE , to get block no. for corresponding file offset.</div><d=
iv><br></div><div>--Pratik.<br></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 12:19 PM Gao X=
iang &lt;<a href=3D"mailto:gaoxiang25@huawei.com">gaoxiang25@huawei.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On M=
on, Dec 30, 2019 at 11:49:55AM +0530, Pratik Shinde wrote:<br>
&gt; Gao,<br>
&gt; <br>
&gt; Okay, I will rename the &#39;size&#39; variables accordingly.<br>
&gt; The &#39;S_SHIFT&#39; gives the logical block number inside file. I am=
 using it to<br>
&gt; assign logical block no.<br>
&gt; to extents.<br>
<br>
S_SHIFT is used to transfer between i_mode and filetype, see:<br>
<a href=3D"https://elixir.bootlin.com/linux/latest/source/fs/ext4/ext4.h#L3=
196" rel=3D"noreferrer" target=3D"_blank">https://elixir.bootlin.com/linux/=
latest/source/fs/ext4/ext4.h#L3196</a><br>
<br>
IMO, which is not the above meaning, how about using EROFS_BLKSIZ<br>
instead?<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
&gt; Also, I will modify the code to record only data extents.<br>
&gt; <br>
&gt; --Pratik.<br>
&gt; <br>
&gt; On Sun, Dec 29, 2019 at 8:26 AM Gao Xiang &lt;<a href=3D"mailto:hsiang=
kao@aol.com" target=3D"_blank">hsiangkao@aol.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi Pratik,<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:<br=
>
&gt; &gt; &gt; since this patch is quite different from previous patches I =
am treating<br>
&gt; &gt; &gt; this as new patch.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 1) On disk extent format for erofs data blocks.<br>
&gt; &gt; &gt; 2) Detect holes inside files &amp; skip allocation for hole =
blocks.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Pratik Shinde &lt;<a href=3D"mailto:pratikshi=
nde320@gmail.com" target=3D"_blank">pratikshinde320@gmail.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 include/erofs/internal.h |=C2=A0 21 ++++++-<br>
&gt; &gt; &gt;=C2=A0 lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 155<br>
&gt; &gt; +++++++++++++++++++++++++++++++++++++++++------<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 156 insertions(+), 20 deletions(-)<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/include/erofs/internal.h b/include/erofs/intern=
al.h<br>
&gt; &gt; &gt; index e13adda..128aa63 100644<br>
&gt; &gt; &gt; --- a/include/erofs/internal.h<br>
&gt; &gt; &gt; +++ b/include/erofs/internal.h<br>
&gt; &gt; &gt; @@ -63,7 +63,7 @@ struct erofs_sb_info {<br>
&gt; &gt; &gt;=C2=A0 extern struct erofs_sb_info sbi;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 struct erofs_inode {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_x=
attrs;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct list_head i_hash, i_subdirs, i_x=
attrs, i_extents;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i_count;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_inode *i_parent;<br>
&gt; &gt; &gt; @@ -93,6 +93,7 @@ struct erofs_inode {<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int xattr_isize;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int extent_isize;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int extent_meta_isize;<br>
&gt; &gt;<br>
&gt; &gt; maybe sparse_extent_isize is better...<br>
&gt; &gt;<br>
&gt; &gt; p.s. maybe we could send another patch rename extent_isize to<br>
&gt; &gt; compress_extent_isize or some better name...<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_nid_t nid;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct erofs_buffer_head *bh;<br>
&gt; &gt; &gt; @@ -139,5 +140,23 @@ static inline const char *erofs_strerro=
r(int err)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return msg;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +#define HOLE_BLK=C2=A0 =C2=A0 =C2=A0-1<br>
&gt; &gt; &gt; +/* on disk extent format */<br>
&gt; &gt; &gt; +struct erofs_extent {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_lblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_pblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0__le32 ee_len;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct erofs_extent_node {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct list_head next;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t lblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_blk_t pblk;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 len;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +struct erofs_inline_extent_header {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0u32 count;<br>
&gt; &gt; &gt; +};<br>
&gt; &gt; &gt;=C2=A0 #endif<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/lib/inode.c b/lib/inode.c<br>
&gt; &gt; &gt; index 0e19b11..a6af509 100644<br>
&gt; &gt; &gt; --- a/lib/inode.c<br>
&gt; &gt; &gt; +++ b/lib/inode.c<br>
&gt; &gt; &gt; @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S=
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
&gt; &gt;<br>
&gt; &gt; See below..<br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +/* returns the number of holes present in the file */<br>
&gt; &gt; &gt; +unsigned int erofs_read_extents(struct erofs_inode *inode,<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *extents)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int fd, st, en, dt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nholes =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0erofs_off_t data, hole, len, last_data;=
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_hole, *e_da=
ta;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0fd =3D open(inode-&gt;i_srcpath, O_RDON=
LY);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -err=
no;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0len =3D lseek(fd, 0, SEEK_END);<br>
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
t; 0 || hole &gt; data) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_HOLE=
(hole, data)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0st =3D hole &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0en =3D data &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dt =3D last_data &gt;&gt; S_SHIFT;<br>
&gt; &gt;<br>
&gt; &gt; Why using S_SHIFT here, some special meaning?<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0last_data =3D data;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data =3D malloc(sizeof(struct erofs_extent_node));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (e_data =3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data-&gt;lblk =3D dt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_data-&gt;len =3D (st - dt);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0list_add_tail(&amp;e_data-&gt;next, extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_hole =3D malloc(sizeof(struct erofs_extent_node));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (e_hole =3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_hole-&gt;lblk =3D st;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_hole-&gt;pblk =3D HOLE_BLK;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0e_hole-&gt;len =3D (en - st);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0list_add_tail(&amp;e_hole-&gt;next, extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0nholes +=3D e_hole-&gt;len;<br>
&gt; &gt;<br>
&gt; &gt; Maybe we don&#39;t need to emit all HOLK extents since all data e=
xtents<br>
&gt; &gt; are with _length_... It is easy to detect all holes between exten=
ts...<br>
&gt; &gt;<br>
&gt; &gt; If some block doesn&#39;t belong to any extent, it&#39;s a hole.<=
br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Gao Xiang<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0/* rounddown to exclude tail-end data *=
/<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (last_data &lt; len &amp;&amp; (len =
- last_data) &gt;=3D EROFS_BLKSIZ) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data =3D =
malloc(sizeof(struct erofs_extent_node));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_data =
=3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st =3D last=
_data &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;=
lblk =3D st;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_data-&gt;=
len =3D rounddown((len - last_data), EROFS_BLKSIZ)<br>
&gt; &gt; &gt;&gt; S_SHIFT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_ta=
il(&amp;e_data-&gt;next, extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return nholes;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +char *erofs_create_extent_buffer(struct list_head *extents,=
 unsigned<br>
&gt; &gt; int size)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_node;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_inline_extent_header *head=
er;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0char *buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int p =3D 0;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0buf =3D malloc(size);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (buf =3D=3D NULL)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_=
PTR(-ENOMEM);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0header =3D (struct erofs_inline_extent_=
header *) buf;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0header-&gt;count =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0p +=3D sizeof(struct erofs_inline_exten=
t_header);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, extents, ne=
xt) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struc=
t erofs_extent ee =3D {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_lblk =3D cpu_to_le32(e_node-&gt;lblk),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_pblk =3D cpu_to_le32(e_node-&gt;pblk),<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.ee_len=C2=A0 =3D cpu_to_le32(e_node-&gt;len)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buf =
+ p, &amp;ee, sizeof(struct erofs_extent));<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p +=3D size=
of(struct erofs_extent);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0header-&gt;=
count++;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&a=
mp;e_node-&gt;next);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(e_node=
);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0return buf;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 void erofs_inode_manager_init(void)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; &gt; &gt; @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(s=
truct<br>
&gt; &gt; erofs_inode *inode)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 int erofs_write_file(struct erofs_inode *inode)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned int nblocks, i, j, nholes;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, fd;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0struct erofs_extent_node *e_node;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!inode-&gt;i_size) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-=
&gt;datalayout =3D EROFS_INODE_FLAT_PLAIN;<br>
&gt; &gt; &gt; @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inod=
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
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0nholes =3D erofs_read_extents(inode, &a=
mp;inode-&gt;i_extents);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (nholes &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nhol=
es;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (nblocks &lt; 0)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return nblo=
cks;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D __allocate_inode_bh_data(inode,=
 nblocks - nholes);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 ret;<br>
&gt; &gt; &gt;<br>
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
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0close(fd);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EAGAIN;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0i =3D inode-&gt;u.i_blkaddr;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_meta_isize =3D sizeof(=
struct<br>
&gt; &gt; erofs_inline_extent_header);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(e_node, &amp;inode-=
&gt;i_extents, next) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;e=
xtent_meta_isize +=3D sizeof(struct erofs_extent);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (e_node-=
&gt;pblk =3D=3D HOLE_BLK) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0lseek(fd, e_node-&gt;len * EROFS_BLKSIZ, SEEK_CUR);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e_node-&gt;=
pblk =3D i;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i +=3D e_no=
de-&gt;len;<br>
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
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D blk=
_write(buf, inode-&gt;u.i_blkaddr + i, 1);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br=
>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the tail-end data */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D inode-&gt=
;i_size % EROFS_BLKSIZ;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (inode-&gt;idata_size) {<br>
&gt; &gt; &gt; @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(=
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
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (inode-&gt;extent_meta_isize) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *exten=
ts =3D<br>
&gt; &gt; erofs_create_extent_buffer(&amp;inode-&gt;i_extents,<br>
&gt; &gt; &gt; +<br>
&gt; &gt; inode-&gt;extent_meta_isize);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(=
extents))<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dev=
_write(extents, off, inode-&gt;extent_meta_isize);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(extent=
s);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_iput(inode);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return erofs_bh_flush_generic_end(=
bh);<br>
&gt; &gt; &gt; @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(vo=
id)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_su=
bdirs);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_xa=
ttrs);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0init_list_head(&amp;inode-&gt;i_extents=
);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata_size =3D 0;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;xattr_isize =3D 0;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_isize =3D 0;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0inode-&gt;extent_meta_isize =3D 0;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;bh =3D inode-&gt;bh_inli=
ne =3D inode-&gt;bh_data =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0inode-&gt;idata =3D NULL;<br>
&gt; &gt; &gt; @@ -961,4 +1079,3 @@ struct erofs_inode<br>
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

--000000000000371058059ae675d6--
