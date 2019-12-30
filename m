Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CCD12CD6C
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 08:48:11 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47mV0T2rJQzDq9j
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Dec 2019 18:48:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47mV0N3LYbzDq9B
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Dec 2019 18:48:03 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 524AACDF9CD6266283B0;
 Mon, 30 Dec 2019 15:47:54 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Dec 2019 15:47:50 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 30 Dec 2019 15:47:49 +0800
Date: Mon, 30 Dec 2019 15:47:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFC] erofs-utils: on-disk extent format for blocks.
Message-ID: <20191230074726.GA70480@architecture4>
References: <20191227154348.21432-1-pratikshinde320@gmail.com>
 <20191229025546.GB2215@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czSGGxgFsVMwNOY5cqR35bUYmp-6qCUTLfUEfLHgqcHbOw@mail.gmail.com>
 <20191230064911.GA169899@architecture4>
 <CAGu0czS5gEU5Y9UT_fdXuxKNHcHPXJeE7dC+Fh1UMfSa_Q9+1w@mail.gmail.com>
 <CAGu0czT-EQ+J0pWaEoqM8NAU_A4srbacD5esisuKwbr8+AGsAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czT-EQ+J0pWaEoqM8NAU_A4srbacD5esisuKwbr8+AGsAQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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

On Mon, Dec 30, 2019 at 12:46:43PM +0530, Pratik Shinde wrote:
> Okay. Apologies. I think we already have erofs_blknr() to do this job. I
> can use that.:)

Yes, you are right. I'd suggest you could read more erofs-utils
source code if you have extra time :-)

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Mon, Dec 30, 2019 at 12:34 PM Pratik Shinde <pratikshinde320@gmail.com>
> wrote:
> 
> > Thanks got it.
> >
> > Then we can use LOG_BLOCK_SIZE , to get block no. for corresponding file
> > offset.
> >
> > --Pratik.
> >
> > On Mon, Dec 30, 2019 at 12:19 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >
> >> On Mon, Dec 30, 2019 at 11:49:55AM +0530, Pratik Shinde wrote:
> >> > Gao,
> >> >
> >> > Okay, I will rename the 'size' variables accordingly.
> >> > The 'S_SHIFT' gives the logical block number inside file. I am using it
> >> to
> >> > assign logical block no.
> >> > to extents.
> >>
> >> S_SHIFT is used to transfer between i_mode and filetype, see:
> >> https://elixir.bootlin.com/linux/latest/source/fs/ext4/ext4.h#L3196
> >>
> >> IMO, which is not the above meaning, how about using EROFS_BLKSIZ
> >> instead?
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >> > Also, I will modify the code to record only data extents.
> >> >
> >> > --Pratik.
> >> >
> >> > On Sun, Dec 29, 2019 at 8:26 AM Gao Xiang <hsiangkao@aol.com> wrote:
> >> >
> >> > > Hi Pratik,
> >> > >
> >> > > On Fri, Dec 27, 2019 at 09:13:48PM +0530, Pratik Shinde wrote:
> >> > > > since this patch is quite different from previous patches I am
> >> treating
> >> > > > this as new patch.
> >> > > >
> >> > > > 1) On disk extent format for erofs data blocks.
> >> > > > 2) Detect holes inside files & skip allocation for hole blocks.
> >> > > >
> >> > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> >> > > > ---
> >> > > >  include/erofs/internal.h |  21 ++++++-
> >> > > >  lib/inode.c              | 155
> >> > > +++++++++++++++++++++++++++++++++++++++++------
> >> > > >  2 files changed, 156 insertions(+), 20 deletions(-)
> >> > > >
> >> > > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> >> > > > index e13adda..128aa63 100644
> >> > > > --- a/include/erofs/internal.h
> >> > > > +++ b/include/erofs/internal.h
> >> > > > @@ -63,7 +63,7 @@ struct erofs_sb_info {
> >> > > >  extern struct erofs_sb_info sbi;
> >> > > >
> >> > > >  struct erofs_inode {
> >> > > > -     struct list_head i_hash, i_subdirs, i_xattrs;
> >> > > > +     struct list_head i_hash, i_subdirs, i_xattrs, i_extents;
> >> > > >
> >> > > >       unsigned int i_count;
> >> > > >       struct erofs_inode *i_parent;
> >> > > > @@ -93,6 +93,7 @@ struct erofs_inode {
> >> > > >
> >> > > >       unsigned int xattr_isize;
> >> > > >       unsigned int extent_isize;
> >> > > > +     unsigned int extent_meta_isize;
> >> > >
> >> > > maybe sparse_extent_isize is better...
> >> > >
> >> > > p.s. maybe we could send another patch rename extent_isize to
> >> > > compress_extent_isize or some better name...
> >> > >
> >> > > >
> >> > > >       erofs_nid_t nid;
> >> > > >       struct erofs_buffer_head *bh;
> >> > > > @@ -139,5 +140,23 @@ static inline const char *erofs_strerror(int
> >> err)
> >> > > >       return msg;
> >> > > >  }
> >> > > >
> >> > > > +#define HOLE_BLK     -1
> >> > > > +/* on disk extent format */
> >> > > > +struct erofs_extent {
> >> > > > +     __le32 ee_lblk;
> >> > > > +     __le32 ee_pblk;
> >> > > > +     __le32 ee_len;
> >> > > > +};
> >> > > > +
> >> > > > +struct erofs_extent_node {
> >> > > > +     struct list_head next;
> >> > > > +     erofs_blk_t lblk;
> >> > > > +     erofs_blk_t pblk;
> >> > > > +     u32 len;
> >> > > > +};
> >> > > > +
> >> > > > +struct erofs_inline_extent_header {
> >> > > > +     u32 count;
> >> > > > +};
> >> > > >  #endif
> >> > > >
> >> > > > diff --git a/lib/inode.c b/lib/inode.c
> >> > > > index 0e19b11..a6af509 100644
> >> > > > --- a/lib/inode.c
> >> > > > +++ b/lib/inode.c
> >> > > > @@ -38,6 +38,99 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> >> > > S_SHIFT] = {
> >> > > >
> >> > > >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> >> > > >
> >> > > > +
> >> > > > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start
> >> &&
> >> > >       \
> >> > > > +                          roundup(end, EROFS_BLKSIZ) == end &&
> >>    \
> >> > > > +                         (end - start) % EROFS_BLKSIZ == 0)
> >> > >
> >> > > See below..
> >> > >
> >> > > > +
> >> > > > +/* returns the number of holes present in the file */
> >> > > > +unsigned int erofs_read_extents(struct erofs_inode *inode,
> >> > > > +                             struct list_head *extents)
> >> > > > +{
> >> > > > +     int fd, st, en, dt;
> >> > > > +     unsigned int nholes = 0;
> >> > > > +     erofs_off_t data, hole, len, last_data;
> >> > > > +     struct erofs_extent_node *e_hole, *e_data;
> >> > > > +
> >> > > > +     fd = open(inode->i_srcpath, O_RDONLY);
> >> > > > +     if (fd < 0) {
> >> > > > +             return -errno;
> >> > > > +     }
> >> > > > +     len = lseek(fd, 0, SEEK_END);
> >> > > > +     if (lseek(fd, 0, SEEK_SET) == -1)
> >> > > > +             return -errno;
> >> > > > +     data = 0;
> >> > > > +     last_data = 0;
> >> > > > +     while (data < len) {
> >> > > > +             hole = lseek(fd, data, SEEK_HOLE);
> >> > > > +             if (hole == len)
> >> > > > +                     break;
> >> > > > +             data = lseek(fd, hole, SEEK_DATA);
> >> > > > +             if (data < 0 || hole > data) {
> >> > > > +                     return -EINVAL;
> >> > > > +             }
> >> > > > +             if (IS_HOLE(hole, data)) {
> >> > > > +                     st = hole >> S_SHIFT;
> >> > > > +                     en = data >> S_SHIFT;
> >> > > > +                     dt = last_data >> S_SHIFT;
> >> > >
> >> > > Why using S_SHIFT here, some special meaning?
> >> > >
> >> > > > +                     last_data = data;
> >> > > > +                     e_data = malloc(sizeof(struct
> >> erofs_extent_node));
> >> > > > +                     if (e_data == NULL)
> >> > > > +                             return -ENOMEM;
> >> > > > +                     e_data->lblk = dt;
> >> > > > +                     e_data->len = (st - dt);
> >> > > > +                     list_add_tail(&e_data->next, extents);
> >> > > > +                     e_hole = malloc(sizeof(struct
> >> erofs_extent_node));
> >> > > > +                     if (e_hole == NULL)
> >> > > > +                             return -ENOMEM;
> >> > > > +                     e_hole->lblk = st;
> >> > > > +                     e_hole->pblk = HOLE_BLK;
> >> > > > +                     e_hole->len = (en - st);
> >> > > > +                     list_add_tail(&e_hole->next, extents);
> >> > > > +                     nholes += e_hole->len;
> >> > >
> >> > > Maybe we don't need to emit all HOLK extents since all data extents
> >> > > are with _length_... It is easy to detect all holes between extents...
> >> > >
> >> > > If some block doesn't belong to any extent, it's a hole.
> >> > >
> >> > > Thanks,
> >> > > Gao Xiang
> >> > >
> >> > > > +             }
> >> > > > +     }
> >> > > > +     /* rounddown to exclude tail-end data */
> >> > > > +     if (last_data < len && (len - last_data) >= EROFS_BLKSIZ) {
> >> > > > +             e_data = malloc(sizeof(struct erofs_extent_node));
> >> > > > +             if (e_data == NULL)
> >> > > > +                     return -ENOMEM;
> >> > > > +             st = last_data >> S_SHIFT;
> >> > > > +             e_data->lblk = st;
> >> > > > +             e_data->len = rounddown((len - last_data),
> >> EROFS_BLKSIZ)
> >> > > >> S_SHIFT;
> >> > > > +             list_add_tail(&e_data->next, extents);
> >> > > > +     }
> >> > > > +     return nholes;
> >> > > > +}
> >> > > > +
> >> > > > +char *erofs_create_extent_buffer(struct list_head *extents,
> >> unsigned
> >> > > int size)
> >> > > > +{
> >> > > > +     struct erofs_extent_node *e_node;
> >> > > > +     struct erofs_inline_extent_header *header;
> >> > > > +     char *buf;
> >> > > > +     unsigned int p = 0;
> >> > > > +
> >> > > > +     buf = malloc(size);
> >> > > > +     if (buf == NULL)
> >> > > > +             return ERR_PTR(-ENOMEM);
> >> > > > +     header = (struct erofs_inline_extent_header *) buf;
> >> > > > +     header->count = 0;
> >> > > > +     p += sizeof(struct erofs_inline_extent_header);
> >> > > > +     list_for_each_entry(e_node, extents, next) {
> >> > > > +             const struct erofs_extent ee = {
> >> > > > +                     .ee_lblk = cpu_to_le32(e_node->lblk),
> >> > > > +                     .ee_pblk = cpu_to_le32(e_node->pblk),
> >> > > > +                     .ee_len  = cpu_to_le32(e_node->len)
> >> > > > +             };
> >> > > > +             memcpy(buf + p, &ee, sizeof(struct erofs_extent));
> >> > > > +             p += sizeof(struct erofs_extent);
> >> > > > +             header->count++;
> >> > > > +             list_del(&e_node->next);
> >> > > > +             free(e_node);
> >> > > > +     }
> >> > > > +     return buf;
> >> > > > +}
> >> > > > +
> >> > > >  void erofs_inode_manager_init(void)
> >> > > >  {
> >> > > >       unsigned int i;
> >> > > > @@ -304,8 +397,9 @@ static bool erofs_file_is_compressible(struct
> >> > > erofs_inode *inode)
> >> > > >
> >> > > >  int erofs_write_file(struct erofs_inode *inode)
> >> > > >  {
> >> > > > -     unsigned int nblocks, i;
> >> > > > +     unsigned int nblocks, i, j, nholes;
> >> > > >       int ret, fd;
> >> > > > +     struct erofs_extent_node *e_node;
> >> > > >
> >> > > >       if (!inode->i_size) {
> >> > > >               inode->datalayout = EROFS_INODE_FLAT_PLAIN;
> >> > > > @@ -322,31 +416,43 @@ int erofs_write_file(struct erofs_inode
> >> *inode)
> >> > > >       /* fallback to all data uncompressed */
> >> > > >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> >> > > >       nblocks = inode->i_size / EROFS_BLKSIZ;
> >> > > > -
> >> > > > -     ret = __allocate_inode_bh_data(inode, nblocks);
> >> > > > +     nholes = erofs_read_extents(inode, &inode->i_extents);
> >> > > > +     if (nholes < 0)
> >> > > > +             return nholes;
> >> > > > +     if (nblocks < 0)
> >> > > > +             return nblocks;
> >> > > > +     ret = __allocate_inode_bh_data(inode, nblocks - nholes);
> >> > > >       if (ret)
> >> > > >               return ret;
> >> > > >
> >> > > >       fd = open(inode->i_srcpath, O_RDONLY | O_BINARY);
> >> > > >       if (fd < 0)
> >> > > >               return -errno;
> >> > > > -
> >> > > > -     for (i = 0; i < nblocks; ++i) {
> >> > > > -             char buf[EROFS_BLKSIZ];
> >> > > > -
> >> > > > -             ret = read(fd, buf, EROFS_BLKSIZ);
> >> > > > -             if (ret != EROFS_BLKSIZ) {
> >> > > > -                     if (ret < 0)
> >> > > > -                             goto fail;
> >> > > > -                     close(fd);
> >> > > > -                     return -EAGAIN;
> >> > > > +     i = inode->u.i_blkaddr;
> >> > > > +     inode->extent_meta_isize = sizeof(struct
> >> > > erofs_inline_extent_header);
> >> > > > +     list_for_each_entry(e_node, &inode->i_extents, next) {
> >> > > > +             inode->extent_meta_isize += sizeof(struct
> >> erofs_extent);
> >> > > > +             if (e_node->pblk == HOLE_BLK) {
> >> > > > +                     lseek(fd, e_node->len * EROFS_BLKSIZ,
> >> SEEK_CUR);
> >> > > > +                     continue;
> >> > > >               }
> >> > > > +             e_node->pblk = i;
> >> > > > +             i += e_node->len;
> >> > > > +             for (j = 0; j < e_node->len; j++) {
> >> > > > +                     char buf[EROFS_BLKSIZ];
> >> > > > +                     ret = read(fd, buf, EROFS_BLKSIZ);
> >> > > > +                     if (ret != EROFS_BLKSIZ) {
> >> > > > +                             if (ret < 0)
> >> > > > +                                     goto fail;
> >> > > > +                             close(fd);
> >> > > > +                             return -EAGAIN;
> >> > > > +                     }
> >> > > > +                     ret = blk_write(buf, e_node->pblk + j, 1);
> >> > > > +                     if (ret)
> >> > > > +                             goto fail;
> >> > > >
> >> > > > -             ret = blk_write(buf, inode->u.i_blkaddr + i, 1);
> >> > > > -             if (ret)
> >> > > > -                     goto fail;
> >> > > > +             }
> >> > > >       }
> >> > > > -
> >> > > >       /* read the tail-end data */
> >> > > >       inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> >> > > >       if (inode->idata_size) {
> >> > > > @@ -479,8 +585,19 @@ static bool erofs_bh_flush_write_inode(struct
> >> > > erofs_buffer_head *bh)
> >> > > >               if (ret)
> >> > > >                       return false;
> >> > > >               free(inode->compressmeta);
> >> > > > +             off += inode->extent_isize;
> >> > > >       }
> >> > > >
> >> > > > +     if (inode->extent_meta_isize) {
> >> > > > +             char *extents =
> >> > > erofs_create_extent_buffer(&inode->i_extents,
> >> > > > +
> >> > > inode->extent_meta_isize);
> >> > > > +             if (IS_ERR(extents))
> >> > > > +                     return false;
> >> > > > +             ret = dev_write(extents, off,
> >> inode->extent_meta_isize);
> >> > > > +             free(extents);
> >> > > > +             if (ret)
> >> > > > +                     return false;
> >> > > > +     }
> >> > > >       inode->bh = NULL;
> >> > > >       erofs_iput(inode);
> >> > > >       return erofs_bh_flush_generic_end(bh);
> >> > > > @@ -737,10 +854,11 @@ struct erofs_inode *erofs_new_inode(void)
> >> > > >
> >> > > >       init_list_head(&inode->i_subdirs);
> >> > > >       init_list_head(&inode->i_xattrs);
> >> > > > +     init_list_head(&inode->i_extents);
> >> > > >
> >> > > >       inode->idata_size = 0;
> >> > > >       inode->xattr_isize = 0;
> >> > > > -     inode->extent_isize = 0;
> >> > > > +     inode->extent_meta_isize = 0;
> >> > > >
> >> > > >       inode->bh = inode->bh_inline = inode->bh_data = NULL;
> >> > > >       inode->idata = NULL;
> >> > > > @@ -961,4 +1079,3 @@ struct erofs_inode
> >> > > *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> >> > > >
> >> > > >       return erofs_mkfs_build_tree(inode);
> >> > > >  }
> >> > > > -
> >> > > > --
> >> > > > 2.9.3
> >> > > >
> >> > >
> >>
> >
