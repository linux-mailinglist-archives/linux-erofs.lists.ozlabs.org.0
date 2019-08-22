Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 605119885B
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 02:10:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DQ0H39tpzDr3f
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 10:10:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DQ080rVrzDr2r
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 10:10:14 +1000 (AEST)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 9BDB35E3B353307D7977
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 08:10:08 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 08:10:08 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 08:10:07 +0800
Date: Thu, 22 Aug 2019 08:09:26 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: erofs debug utility.
Message-ID: <20190822000926.GB188437@architecture4>
References: <20190821163808.6643-1-pratikshinde320@gmail.com>
 <20190821165633.GA30750@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czR+=YmYLiu=dH1kiNJnXtLRzm0tuoND7oiYdVQ7ua4-pw@mail.gmail.com>
 <20190821200620.GA2955@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190821200620.GA2955@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme705-chm.china.huawei.com (10.1.199.101) To
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

On Thu, Aug 22, 2019 at 04:08:24AM +0800, Gao Xiang via Linux-erofs wrote:
> Hi Pratik,
> 
> On Wed, Aug 21, 2019 at 11:45:48PM +0530, Pratik Shinde wrote:
> > Thanks Gao,
> > 
> > Let me know when we can work on debug utility OR atleast list out things we
> > want to achieve through the utility.

Sorry, it seems I misunderstand that, I think I will do a prelimitary parsing
version this weekend, but you can develop it now :) and then we can merge
our code later, that's also fine of course.

Thanks,
Gao Xiang

> 
> I think we need to implement
>  - dump super block
>  - dump a specfic file
>  - dump a physical block or a physical compressed cluster from nid and logical offset
>  - dump a specfic metadata (I mean dump the inode meta of a file)
>  - ...
> 
> Thanks,
> Gao Xiang
> 
> > Regarding the superblock checksum calculations, Yes I will dedicate
> > sometime this week for it. will start exploring it.
> > 
> > --Pratik.
> > 
> > On Wed, Aug 21, 2019 at 10:26 PM Gao Xiang <hsiangkao@aol.com> wrote:
> > 
> > > Hi Pratik,
> > >
> > > On Wed, Aug 21, 2019 at 10:08:08PM +0530, Pratik Shinde wrote:
> > > > Hello Maintainers,
> > > >
> > > > After going through the recent mail thread between linux's filesystem
> > > folks
> > > > on erofs channel, I felt erofs needs an interactive debug utility (like
> > > xfs_db)
> > > > which can be used to examine erofs images & can also be used to inject
> > > errors OR
> > > > fuzzing for testing purpose & dumping different erofs meta data
> > > structures
> > > > for debugging.
> > > > In order to demonstrate above I wrote an experimental patch that simply
> > > dumps
> > > > the superblock of an image after mkfs completes.the full fletch utility
> > > will run
> > > > independently and be able to seek / print / modify any byte of an erofs
> > > image,
> > > > dump structures/lists/directory content of an image.
> > >
> > > Yes, I think we really need that interactive tools, actually I'm stuggling
> > > in
> > > modifing Guifu's erofs-fuse now, we need to add the parsing ability to
> > > "lib/"
> > > first.
> > >
> > > I mean, first, I will add a "fuse" field to "cfg". If it is false, it will
> > > generate a image, or it will parse a image...
> > > And then we need to add parsing logic into "lib/" as well, and use
> > > "if (cfg.fuse)" to differnate whether it should read or write data.
> > >
> > > That is my prelimitary thought.. I will work on this framework in this
> > > weekend.
> > > and then we can work together on it. :)
> > >
> > > p.s. Pratik, if you have some time, could you take some extra time adding
> > > the
> > > super checksum calulation to EROFS? I mean we can add
> > > EROFS_FEATURE_SB_CHKSUM
> > > to the compat superblock field ("features"), and do crc32_le on kernel and
> > > mkfs...
> > > If you dont have time, I will do it later instead... (since we are using
> > > EROFS
> > > on the top of dm-verity, but completing the superblock chksum is also a
> > > good idea.)
> > >
> > > And then we can add block-based verification layer to EROFS, it can be seen
> > > as a hash tree like dm-verity or just simply CRC32 arrays for user to
> > > choise.
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > NOTE:This is an experimental patch just to demonstrate the purpose. The
> > > patch
> > > > lacks a lot of things like coding standard, and new code runs in the
> > > context
> > > > of mkfs itself.kindly ignore it.
> > > >
> > > > kindly provide your feedback on this.
> > > >
> > > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > > ---
> > > >  include/erofs/io.h |  8 ++++++++
> > > >  lib/io.c           | 27 +++++++++++++++++++++++++++
> > > >  mkfs/main.c        | 36 ++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 71 insertions(+)
> > > >
> > > > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > > > index 4b574bd..e91d6ee 100644
> > > > --- a/include/erofs/io.h
> > > > +++ b/include/erofs/io.h
> > > > @@ -18,6 +18,7 @@
> > > >
> > > >  int dev_open(const char *devname);
> > > >  void dev_close(void);
> > > > +int dev_read(void *buf, u64 offset, size_t len);
> > > >  int dev_write(const void *buf, u64 offset, size_t len);
> > > >  int dev_fillzero(u64 offset, size_t len, bool padding);
> > > >  int dev_fsync(void);
> > > > @@ -30,5 +31,12 @@ static inline int blk_write(const void *buf,
> > > erofs_blk_t blkaddr,
> > > >                        blknr_to_addr(nblocks));
> > > >  }
> > > >
> > > > +static inline int blk_read(void *buf, erofs_blk_t blkaddr,
> > > > +                        u32 nblocks)
> > > > +{
> > > > +     return dev_read(buf, blknr_to_addr(blkaddr),
> > > > +                     blknr_to_addr(nblocks));
> > > > +}
> > > > +
> > > >  #endif
> > > >
> > > > diff --git a/lib/io.c b/lib/io.c
> > > > index 15c5a35..87d7d6c 100644
> > > > --- a/lib/io.c
> > > > +++ b/lib/io.c
> > > > @@ -109,6 +109,33 @@ u64 dev_length(void)
> > > >       return erofs_devsz;
> > > >  }
> > > >
> > > > +int dev_read(void *buf, u64 offset, size_t len)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     if (cfg.c_dry_run)
> > > > +             return 0;
> > > > +
> > > > +     if (!buf) {
> > > > +             erofs_err("buf is NULL");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +     if (offset >= erofs_devsz || len > erofs_devsz ||
> > > > +         offset > erofs_devsz - len) {
> > > > +             erofs_err("read posion[%" PRIu64 ", %zd] is too large
> > > beyond the end of device(%" PRIu64 ").",
> > > > +                       offset, len, erofs_devsz);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> > > > +     if (ret != (int)len) {
> > > > +             erofs_err("Failed to read data from device - %s:[%" PRIu64
> > > ", %zd].",
> > > > +                       erofs_devname, offset, len);
> > > > +             return -errno;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  int dev_write(const void *buf, u64 offset, size_t len)
> > > >  {
> > > >       int ret;
> > > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > > index f127fe1..109486e 100644
> > > > --- a/mkfs/main.c
> > > > +++ b/mkfs/main.c
> > > > @@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct
> > > erofs_buffer_head *bh,
> > > >       return 0;
> > > >  }
> > > >
> > > > +void erofs_dump_super(char *img_path)
> > > > +{
> > > > +     struct erofs_super_block *sb;
> > > > +     char buf[EROFS_BLKSIZ];
> > > > +     unsigned int blksz;
> > > > +     int ret = 0;
> > > > +
> > > > +     if (img_path == NULL) {
> > > > +             erofs_err("image path cannot be null");
> > > > +             return;
> > > > +     }
> > > > +     ret = blk_read(buf, 0, 1);
> > > > +     if (ret) {
> > > > +             erofs_err("error reading super-block structure");
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> > > > +     if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> > > > +             erofs_err("not a erofs image");
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     erofs_dump("magic: 0x%x\n", le32_to_cpu(sb->magic));
> > > > +     blksz = 1 << sb->blkszbits;
> > > > +     erofs_dump("block size: %d\n", blksz);
> > > > +     erofs_dump("root inode: %d\n", le32_to_cpu(sb->root_nid));
> > > > +     erofs_dump("inodes: %llu\n", le64_to_cpu(sb->inos));
> > > > +     erofs_dump("build time: %u\n", le32_to_cpu(sb->build_time));
> > > > +     erofs_dump("blocks: %u\n", le32_to_cpu(sb->blocks));
> > > > +     erofs_dump("meta block: %u\n", le32_to_cpu(sb->meta_blkaddr));
> > > > +     erofs_dump("xattr block: %u\n", le32_to_cpu(sb->xattr_blkaddr));
> > > > +     erofs_dump("requirements: 0x%x\n", le32_to_cpu(sb->requirements));
> > > > +}
> > > > +
> > > >  int main(int argc, char **argv)
> > > >  {
> > > >       int err = 0;
> > > > @@ -268,6 +303,7 @@ int main(int argc, char **argv)
> > > >               err = -EIO;
> > > >  exit:
> > > >       z_erofs_compress_exit();
> > > > +     erofs_dump_super("dummy");
> > > >       dev_close();
> > > >       erofs_exit_configure();
> > > >
> > > > --
> > > > 2.9.3
> > > >
> > >
