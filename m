Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EE116765
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2019 08:13:28 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47WZD546nzzDqLJ
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Dec 2019 18:13:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47WZCs4QGWzDqDS
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 Dec 2019 18:13:13 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id C0EE4296FDC1D0B2DC5D
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 Dec 2019 15:13:05 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Dec 2019 15:13:05 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 9 Dec 2019 15:13:04 +0800
Date: Mon, 9 Dec 2019 15:18:17 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [RFC] erofs-utils:code for detecting and tracking holes in
 uncompressed sparse files.
Message-ID: <20191209071815.GA144654@architecture4>
References: <20191203140250.23793-1-pratikshinde320@gmail.com>
 <20191204022734.GA60329@architecture4>
 <CAGu0czSNv--LQwrWXuzuT6S5BYs+tnCA8vqAREv7+Z4rEBdtsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czSNv--LQwrWXuzuT6S5BYs+tnCA8vqAREv7+Z4rEBdtsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Mon, Dec 09, 2019 at 12:34:50PM +0530, Pratik Shinde wrote:
> Hello Gao,
> 
> Did you get any chance to look at this in detail.

I looked into your implementation weeks before.

As my reply in the previous email, did you see it and could you check it out?

Kernel emails are not top-posting so you could scroll down to the end.

> > "variable-sized inode" isn't a problem here, which can be handled
> > similar to the case of "compress indexes".
> >
> > Probably no need to write linked list to the disk but generate linked list
> > in memory when writing data on the fly, and then transfer to a
> > variable-sized
> > extent array at the time of writing inode metadata (The order is firstly
> > data
> > and then metadata in erofs-utils so it looks practical.)

Thanks,
Gao Xiang

> 
> --Pratik.
> 
> On Wed, Dec 4, 2019, 7:52 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
> > Hi Pratik,
> >
> > I'll give detailed words this weekend if you have more questions
> > since I'm busying in other stupid intra-company stuffs now...
> >
> > On Tue, Dec 03, 2019 at 07:32:50PM +0530, Pratik Shinde wrote:
> > > NOTE: The patch is not fully complete yet, with this patch I just want to
> > > present rough idea of what I am trying to achieve.
> > >
> > > The patch does following :
> > > 1) Detect holes (of size EROFS_BLKSIZ) in uncompressed files.
> > > 2) Keep track of holes per file.
> > >
> > > In-order to track holes, I used an array of size = (file_size /
> > blocksize)
> > > The array basically tracks number of holes before a particular logical
> > file block.
> > > e.g blks[i] = 10 meaning ith block has 10 holes before it.
> > > If a particular block is a hole we set the index to '-1'.
> > >
> > > how read logic will change:
> > > 1) currently we simply map read offset to a fs block.
> > > 2) with holes in place the calculation of block number would be:
> > >
> > >    blkno = start_block + (offset >> block_size_shift) - (number of
> > >                                                        holes before
> > block in which offset falls)
> > >
> > > 3) If a read offset falls inside a hole (which can be found using above
> > array). We
> > >    fill the user buffer with '\0' on the fly.
> > >
> > > through this,block no. lookup would still be performed in constant time.
> > >
> > > The biggest problem with this approach is - we have to store the hole
> > tracking
> > > array for every file to the disk.Which doesn't seems to be practical.we
> > can use a linkedlist,
> > > but that will make size of inode variable.
> >
> > "variable-sized inode" isn't a problem here, which can be handled
> > similar to the case of "compress indexes".
> >
> > Probably no need to write linked list to the disk but generate linked list
> > in memory when writing data on the fly, and then transfer to a
> > variable-sized
> > extent array at the time of writing inode metadata (The order is firstly
> > data
> > and then metadata in erofs-utils so it looks practical.)
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  lib/inode.c | 67
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 66 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/inode.c b/lib/inode.c
> > > index 0e19b11..af31949 100644
> > > --- a/lib/inode.c
> > > +++ b/lib/inode.c
> > > @@ -38,6 +38,61 @@ static unsigned char erofs_type_by_mode[S_IFMT >>
> > S_SHIFT] = {
> > >
> > >  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> > >
> > > +
> > > +#define IS_HOLE(start, end) (roundup(start, EROFS_BLKSIZ) == start &&
> >       \
> > > +                          roundup(end, EROFS_BLKSIZ) == end &&       \
> > > +                         (end - start) % EROFS_BLKSIZ == 0)
> > > +#define HOLE_BLK             -1
> > > +unsigned int erofs_detect_holes(struct erofs_inode *inode, int *blks)
> > > +{
> > > +     int i, fd, st, en;
> > > +     unsigned int nblocks;
> > > +     erofs_off_t data, hole, len;
> > > +
> > > +     nblocks = inode->i_size / EROFS_BLKSIZ;
> > > +     for (i = 0; i < nblocks; i++)
> > > +             blks[i] = 0;
> > > +     fd = open(inode->i_srcpath, O_RDONLY);
> > > +     if (fd < 0) {
> > > +             return -errno;
> > > +     }
> > > +     len = lseek(fd, 0, SEEK_END);
> > > +     if (lseek(fd, 0, SEEK_SET) == -1)
> > > +             return -errno;
> > > +     data = 0;
> > > +     while (data < len) {
> > > +             hole = lseek(fd, data, SEEK_HOLE);
> > > +             if (hole == len)
> > > +                     break;
> > > +             data = lseek(fd, hole, SEEK_DATA);
> > > +             if (data < 0 || hole > data) {
> > > +                     return -EINVAL;
> > > +             }
> > > +             if (IS_HOLE(hole, data)) {
> > > +                     st = hole >> S_SHIFT;
> > > +                     en = data >> S_SHIFT;
> > > +                     nblocks -= (en - st);
> > > +                     for (i = st; i < en; i++)
> > > +                             blks[i] = HOLE_BLK;
> > > +             }
> > > +     }
> > > +     return nblocks;
> > > +}
> > > +
> > > +int erofs_fill_holedata(int *blks, unsigned int nblocks) {
> > > +     int i, nholes = 0;
> > > +     for (i = 0; i < nblocks; i++) {
> > > +             if (blks[i] == -1)
> > > +                     nholes++;
> > > +             else {
> > > +                     blks[i] = nholes;
> > > +                     if (nholes >= (i + 1))
> > > +                             return -EINVAL;
> > > +             }
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  void erofs_inode_manager_init(void)
> > >  {
> > >       unsigned int i;
> > > @@ -305,6 +360,7 @@ static bool erofs_file_is_compressible(struct
> > erofs_inode *inode)
> > >  int erofs_write_file(struct erofs_inode *inode)
> > >  {
> > >       unsigned int nblocks, i;
> > > +     int *blks;
> > >       int ret, fd;
> > >
> > >       if (!inode->i_size) {
> > > @@ -322,7 +378,13 @@ int erofs_write_file(struct erofs_inode *inode)
> > >       /* fallback to all data uncompressed */
> > >       inode->datalayout = EROFS_INODE_FLAT_INLINE;
> > >       nblocks = inode->i_size / EROFS_BLKSIZ;
> > > -
> > > +     blks = malloc(sizeof(int) * nblocks);
> > > +     nblocks = erofs_detect_holes(inode, blks);
> > > +     if (nblocks < 0)
> > > +             return nblocks;
> > > +     if ((ret = erofs_fill_holedata(blks, nblocks)) != 0) {
> > > +             return ret;
> > > +     }
> > >       ret = __allocate_inode_bh_data(inode, nblocks);
> > >       if (ret)
> > >               return ret;
> > > @@ -332,6 +394,8 @@ int erofs_write_file(struct erofs_inode *inode)
> > >               return -errno;
> > >
> > >       for (i = 0; i < nblocks; ++i) {
> > > +             if (blks[i] == HOLE_BLK)
> > > +                     continue;
> > >               char buf[EROFS_BLKSIZ];
> > >
> > >               ret = read(fd, buf, EROFS_BLKSIZ);
> > > @@ -962,3 +1026,4 @@ struct erofs_inode
> > *erofs_mkfs_build_tree_from_path(struct erofs_inode *parent,
> > >       return erofs_mkfs_build_tree(inode);
> > >  }
> > >
> > > +
> > > --
> > > 2.9.3
> > >
> >
