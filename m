Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B51D6D18
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 04:06:53 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46sf1k0qfZzDqkZ
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 13:06:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46sf1d2KRgzDqkJ
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 13:06:44 +1100 (AEDT)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 194BCDAE5CF58DEB80BB;
 Tue, 15 Oct 2019 10:06:38 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 15 Oct 2019 10:06:37 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 15 Oct 2019 10:06:37 +0800
Date: Tue, 15 Oct 2019 10:09:38 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH-v2] erofs-utils:code for calculating crc checksum of
 erofs blocks.
Message-ID: <20191015020938.GB241159@architecture4>
References: <20191014145943.2653-1-pratikshinde320@gmail.com>
 <20191014234504.GA31674@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czT91GOwrkLf_SYTj6QATPAD_ysMrLMs9t=bAHi8ACmLnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGu0czT91GOwrkLf_SYTj6QATPAD_ysMrLMs9t=bAHi8ACmLnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
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

Hi Pratik,

On Tue, Oct 15, 2019 at 07:30:38AM +0530, Pratik Shinde wrote:
> Hi Gao,
> 
> okay. I will make those changes. Yes I would like to do kernel side changes
> too. Which branch to use for this? kernel's master?

erofs development tree is better,
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git -b dev

erofs is now an independent tree, and I will collect all kernel patches
(including features, bugfixes and cleanups) for linux-next then.

p.s. kind reminder, don't forgot add a chksum_blocks field to on-disk
erofs_super_block
as well.

Thanks,
Goa Xiang

> 
> -Pratik
> 
> On Tue, 15 Oct, 2019, 5:15 AM Gao Xiang, <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > Some nitpick comments... Let me know if you have other thoughts
> >
> > On Mon, Oct 14, 2019 at 08:29:43PM +0530, Pratik Shinde wrote:
> > > Added code for calculating crc of erofs blocks (4K size).for now it
> > calculates
> > > checksum of first block. but can modified to calculate crc for any no.
> > of blocks
> > >
> > > modified patch based on review comments.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  include/erofs/internal.h |  1 +
> > >  include/erofs/io.h       |  8 +++++
> > >  lib/io.c                 | 27 +++++++++++++++++
> > >  mkfs/main.c              | 76
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 112 insertions(+)
> > >
> > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > > index 5384946..53335bc 100644
> > > --- a/include/erofs/internal.h
> > > +++ b/include/erofs/internal.h
> > > @@ -55,6 +55,7 @@ struct erofs_sb_info {
> > >       u32 feature_incompat;
> > >       u64 build_time;
> > >       u32 build_time_nsec;
> > > +     u32 feature;
> > >  };
> > >
> > >  /* global sbi */
> > > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > > index 9775047..e0ca8d9 100644
> > > --- a/include/erofs/io.h
> > > +++ b/include/erofs/io.h
> > > @@ -19,6 +19,7 @@
> > >  int dev_open(const char *devname);
> > >  void dev_close(void);
> > >  int dev_write(const void *buf, u64 offset, size_t len);
> > > +int dev_read(void *buf, u64 offset, size_t len);
> > >  int dev_fillzero(u64 offset, size_t len, bool padding);
> > >  int dev_fsync(void);
> > >  int dev_resize(erofs_blk_t nblocks);
> > > @@ -31,5 +32,12 @@ static inline int blk_write(const void *buf,
> > erofs_blk_t blkaddr,
> > >                        blknr_to_addr(nblocks));
> > >  }
> > >
> > > +static inline int blk_read(void *buf, erofs_blk_t start,
> > > +                         u32 nblocks)
> > > +{
> > > +     return dev_read(buf, blknr_to_addr(start),
> > > +                      blknr_to_addr(nblocks));
> > > +}
> > > +
> > >  #endif
> > >
> > > diff --git a/lib/io.c b/lib/io.c
> > > index 7f5f94d..52f9424 100644
> > > --- a/lib/io.c
> > > +++ b/lib/io.c
> > > @@ -207,3 +207,30 @@ int dev_resize(unsigned int blocks)
> > >       return dev_fillzero(st.st_size, length, true);
> > >  }
> > >
> > > +int dev_read(void *buf, u64 offset, size_t len)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (cfg.c_dry_run)
> > > +             return 0;
> > > +
> > > +     if (!buf) {
> > > +             erofs_err("buf is NULL");
> > > +             return -EINVAL;
> > > +     }
> > > +     if (offset >= erofs_devsz || len > erofs_devsz ||
> > > +         offset > erofs_devsz - len) {
> > > +             erofs_err("read posion[%" PRIu64 ", %zd] is too large
> > beyond"
> > > +                       "the end of device(%" PRIu64 ").",
> > > +                       offset, len, erofs_devsz);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     ret = pread64(erofs_devfd, buf, len, (off64_t)offset);
> > > +     if (ret != (int)len) {
> > > +             erofs_err("Failed to read data from device - %s:[%" PRIu64
> > ", %zd].",
> > > +                       erofs_devname, offset, len);
> > > +             return -errno;
> > > +     }
> > > +     return 0;
> > > +}
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index 91a018f..baaf02a 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -22,6 +22,10 @@
> > >
> > >  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct
> > erofs_super_block))
> > >
> > > +/* number of blocks for calculating checksum */
> > > +#define EROFS_CKSUM_BLOCKS   1
> > > +#define EROFS_FEATURE_SB_CHKSUM      0x0001
> >
> > How about Moving EROFS_FEATURE_SB_CHKSUM to erofs_fs.h since it's
> > an on-disk definition,
> >
> > > +
> > >  static void usage(void)
> > >  {
> > >       fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> > > @@ -85,6 +89,10 @@ static int parse_extended_opts(const char *opts)
> > >                               return -EINVAL;
> > >                       cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
> > >               }
> > > +
> > > +             if (MATCH_EXTENTED_OPT("nocrc", token, keylen)) {
> > > +                     sbi.feature &= ~EROFS_FEATURE_SB_CHKSUM;
> > > +             }
> > >       }
> > >       return 0;
> > >  }
> > > @@ -180,6 +188,7 @@ int erofs_mkfs_update_super_block(struct
> > erofs_buffer_head *bh,
> > >               .meta_blkaddr  = sbi.meta_blkaddr,
> > >               .xattr_blkaddr = 0,
> > >               .feature_incompat = cpu_to_le32(sbi.feature_incompat),
> > > +             .checksum = 0
> > >       };
> > >       const unsigned int sb_blksize =
> > >               round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
> > > @@ -202,6 +211,70 @@ int erofs_mkfs_update_super_block(struct
> > erofs_buffer_head *bh,
> > >       return 0;
> > >  }
> > >
> > > +#define CRCPOLY      0x82F63B78
> > > +static inline u32 crc32c(u32 seed, unsigned char const *in, size_t len)
> > > +{
> > > +     int i;
> > > +     u32 crc = seed;
> > > +
> > > +     while (len--) {
> > > +             crc ^= *in++;
> > > +             for (i = 0; i < 8; i++) {
> > > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY : 0);
> > > +             }
> > > +     }
> > > +     return crc;
> > > +}
> > > +
> > > +/* calculate checksum for first n blocks */
> > > +u32 erofs_calc_blk_checksum(erofs_blk_t nblks, u32 *crc)
> > > +{
> > > +     char *buf;
> > > +     int err = 0;
> > > +
> > > +     buf = malloc(nblks * EROFS_BLKSIZ);
> > > +     err = blk_read(buf, 0, nblks);
> > > +     if (err) {
> > > +             erofs_err("Failed to calculate erofs checksum - %s",
> > > +                       erofs_strerror(err));
> > > +             return err;
> > > +     }
> > > +     *crc = crc32c(0, (const unsigned char *)buf, nblks * EROFS_BLKSIZ);
> > > +     free(buf);
> > > +     return 0;
> > > +}
> > > +
> > > +void erofs_write_checksum()
> >
> > How about naming write_sb_checksum?
> > My idea is that this is a checksum in super block (rather than
> > a checksum only for super block [0th block])
> >
> > Let me know if you have another thought...
> >
> > > +{
> > > +     struct erofs_super_block *sb;
> > > +     char buf[EROFS_BLKSIZ];
> > > +     int ret = 0;
> > > +     u32 crc;
> > > +
> > > +     ret = erofs_calc_blk_checksum(EROFS_CKSUM_BLOCKS, &crc);
> > > +     if (ret) {
> > > +             return;
> > > +     }
> > > +     ret = blk_read(buf, 0, 1);
> > > +     if (ret) {
> > > +             erofs_err("error reading super-block structure");
> > > +             return;
> > > +     }
> > > +
> > > +     sb = (struct erofs_super_block *)((u8 *)buf + EROFS_SUPER_OFFSET);
> > > +     if (le32_to_cpu(sb->magic) != EROFS_SUPER_MAGIC_V1) {
> > > +             erofs_err("not an erofs image");
> >
> > As the previous comments, I am little care about these print messages
> > since users will only see this and "error reading super-block structure"
> > "not an erofs image" makes confused for them... (They don't know what
> > the internal process is doing)
> >
> > BTW, it looks good to me as a whole... Do you have some time on
> > kernel side as well? :)
> >
> > Thanks,
> > Gao Xiang
> >
> > > +             return;
> > > +     }
> > > +     sb->checksum = cpu_to_le32(crc);
> > > +     ret = blk_write(buf, 0, 1);
> > > +     if (ret) {
> > > +             erofs_err("error writing 0th block to disk - %s",
> > > +                       erofs_strerror(ret));
> > > +             return;
> > > +     }
> > > +}
> > > +
> > >  int main(int argc, char **argv)
> > >  {
> > >       int err = 0;
> > > @@ -217,6 +290,7 @@ int main(int argc, char **argv)
> > >
> > >       cfg.c_legacy_compress = false;
> > >       sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
> > > +     sbi.feature = EROFS_FEATURE_SB_CHKSUM;
> > >
> > >       err = mkfs_parse_options_cfg(argc, argv);
> > >       if (err) {
> > > @@ -301,6 +375,8 @@ int main(int argc, char **argv)
> > >               err = -EIO;
> > >       else
> > >               err = dev_resize(nblocks);
> > > +     if (sbi.feature & EROFS_FEATURE_SB_CHKSUM)
> > > +             erofs_write_checksum();
> > >  exit:
> > >       z_erofs_compress_exit();
> > >       dev_close();
> > > --
> > > 2.9.3
> > >
> >
