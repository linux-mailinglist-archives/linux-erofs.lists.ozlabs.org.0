Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727879853A
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 22:10:39 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DJgY1DvLzDr2d
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Aug 2019 06:10:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566418233;
	bh=3DGnFlM2QJ1MW6ynQVM24Mi5v9b3oI5Q1btwL/Nfedc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RELhXAo+xf6SNQhzr+NRzjTO4f9v+yHndqO41KSTZX2XzNKhzBhtjxUDfuovghW2O
	 JBXjtTxDFL5/gTyHFF/UBy8TPuFxWTyQcIkNuZDgGcpJQhp1gvBYQKQO4vF/AEmMeG
	 gmh/MupZQwBo9/t7RSdrhseBByTKaJm4Iwa1yzHSwQ5Cu7BGKYJxbvZ2QDlRuxbudX
	 oEd5gLcJZeq073leFhbwP3gWyO5f4ZYKwPmJtPHuR3MQ/kVReUfoNJrVqRGRuAQOEN
	 7lu/gXJVCmYOF0NHBPcpZ9sgzrlrqbAYlMXnmQLlHhCSphVMxNuzP60ITxbkHP28Ta
	 sLpBX8MQqc5WQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.163; helo=sonic311-31.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="PtYjRpDF"; 
 dkim-atps=neutral
Received: from sonic311-31.consmr.mail.ir2.yahoo.com
 (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DJdM04dGzDqQv
 for <linux-erofs@lists.ozlabs.org>; Thu, 22 Aug 2019 06:08:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566418112; bh=dO0x7u823P/k+csqvlUm08ED1Txw6O0qmNQVK44VLMw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=PtYjRpDFQQGgk0BcFEq0xqZmQDz4TZBRmUiqvNYRO961KZDBRf2PWZcDIzhvTIILLoHNEzuT470ckf10khzIPsKM0o3MWaZIgnqzkPTNqvyeI8X5iZjOKeyKEnMvNRZ+hA+wqjT+2b+zT9gz7I0vjB9sPaKoYUj/qkjvLcyWXHPfaBRsWtQOQmrlQ3fSrsADJrenKmcW9v3GaMbRt8g3wPXrp+3ZlGdJlHsOLP/LT9BWHPKmO5ouaHPG/0ZVovYS0Zgu5otXoBc//D6qjUmMzspjrN/Ucy6BYD9O5G8hG5pemUzn0+XsXWI1V85DayOy0yhqrqKPbUqAGojoW+e0lw==
X-YMail-OSG: vb_0qQcVM1nQO3_vRev9X01ihh77MMpVx9KRcZ2FNkup_roKBfqo2PfB4APYUTm
 WvI43urm2Hk4XXaTEdSDOxvwXVWsneSqvNd9WK2SCW4RLmG4pybXMAKsNQc2tWmLWCYq6Ovi2Fc5
 qAUVGtvvV3Ko8HS9xA9MCVu547xxjt6B5JOmY_ytsT6XoOzUnybe6Flex0gM.4iz21Z1fEsZe5de
 cGzZ6Q9fIqmcGnHlOMWstJd05iz0cHf4ZfI7jpIKIuLX6vH.K0OHtiuRwxgU0gBSm4tbijTlIxqt
 TiV1U_l5NIZyRRmiuGqrBsry9gU9l35PmFwogDUcdObcs9cNw8GGQVPU3Dg1RI.BgyS_3harSKwq
 brhyPQo8a0WJenvgjkpFAOzNt19Aok89K06wtLpN2eoYXvOFk2NYr9z2vQX4ZnvG_DPiEfn.E_bs
 VK0I6.kpSQntrg6mhFGp4T.TU1RA7_iHKQ9ROUaMZmhgckJxb9ODjJJh06a92AYZct6UfUItYPuQ
 2rSrF1NWK4401E0VmMczZmfxg0A1qsdz22OhJwecBwI6pX_DFxZQzYP8w0EPAeXanU0wQqq4niNx
 wMR7Qrtb84yNvlyNYXvzP8Koj6_hJFQRN6bUflP2.MbQzmtGAinSmqj4b2884cS8ZJErsQ3Cdfk9
 m.xvNAn80ycj4rp1tKo5Mx_KjxYaVxCpIdMiZMtETonoAvvsPoYbVtZdL1bFPkgH3UIn4kcj9qFT
 2qBTWnIvt1EAINJk.PuTyo3VcOVrlkHxH3NePdPMbYRqUJ8t.9jSBIH7LdcZuqcIWAb8Qc2GoB6c
 1F.glJcoNLwx3mLTFox5RNX.lc7QsK2rRL1ZIfkhWqjP9YBBtravL5KS1qYeSEHsQoAE4A02L.Wa
 NpXDKfnCmyUqSL23MeZxz1.42AwKKJR5zT7TkzhrTGsypz2o84pAZFxgOtakItHM.vC4072TgKip
 Tpe2UwXnDwK2N8si1qoxziP_d6eNDfSMWZM6zOF6RjCuonpOKPC6gZYgl8c5wvpUCx.LHDVVfR7I
 .f58qmkb2UNVrRgN7lEU3LRBuijhKyWbH5RnTlV7lpDZwlfYeCsjBQmHqoWZYSVTNh33izpTY43G
 ymfQiD_8HupK0TDKGAlVOGVVRGjd1F2Ekuj96R6yIQEZRflMhCl_dSkYGBJNm1QKTXhXG64C5CE3
 9xZp5D4OcQ4843O2wVnr.oUU.KmfzFaa3zCxeimt8JxC2Q2fp9dYSi6XeqyNk3MVrrqIlm8M8qr6
 VfyYENc1NOSA1lP_Yk4KD
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 21 Aug 2019 20:08:32 +0000
Received: by smtp420.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID b4a9266f20a2fc30aae4c56830aeeaf6; 
 Wed, 21 Aug 2019 20:08:30 +0000 (UTC)
Date: Thu, 22 Aug 2019 04:08:24 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: erofs debug utility.
Message-ID: <20190821200620.GA2955@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190821163808.6643-1-pratikshinde320@gmail.com>
 <20190821165633.GA30750@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAGu0czR+=YmYLiu=dH1kiNJnXtLRzm0tuoND7oiYdVQ7ua4-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGu0czR+=YmYLiu=dH1kiNJnXtLRzm0tuoND7oiYdVQ7ua4-pw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Wed, Aug 21, 2019 at 11:45:48PM +0530, Pratik Shinde wrote:
> Thanks Gao,
> 
> Let me know when we can work on debug utility OR atleast list out things we
> want to achieve through the utility.

I think we need to implement
 - dump super block
 - dump a specfic file
 - dump a physical block or a physical compressed cluster from nid and logical offset
 - dump a specfic metadata (I mean dump the inode meta of a file)
 - ...

Thanks,
Gao Xiang

> Regarding the superblock checksum calculations, Yes I will dedicate
> sometime this week for it. will start exploring it.
> 
> --Pratik.
> 
> On Wed, Aug 21, 2019 at 10:26 PM Gao Xiang <hsiangkao@aol.com> wrote:
> 
> > Hi Pratik,
> >
> > On Wed, Aug 21, 2019 at 10:08:08PM +0530, Pratik Shinde wrote:
> > > Hello Maintainers,
> > >
> > > After going through the recent mail thread between linux's filesystem
> > folks
> > > on erofs channel, I felt erofs needs an interactive debug utility (like
> > xfs_db)
> > > which can be used to examine erofs images & can also be used to inject
> > errors OR
> > > fuzzing for testing purpose & dumping different erofs meta data
> > structures
> > > for debugging.
> > > In order to demonstrate above I wrote an experimental patch that simply
> > dumps
> > > the superblock of an image after mkfs completes.the full fletch utility
> > will run
> > > independently and be able to seek / print / modify any byte of an erofs
> > image,
> > > dump structures/lists/directory content of an image.
> >
> > Yes, I think we really need that interactive tools, actually I'm stuggling
> > in
> > modifing Guifu's erofs-fuse now, we need to add the parsing ability to
> > "lib/"
> > first.
> >
> > I mean, first, I will add a "fuse" field to "cfg". If it is false, it will
> > generate a image, or it will parse a image...
> > And then we need to add parsing logic into "lib/" as well, and use
> > "if (cfg.fuse)" to differnate whether it should read or write data.
> >
> > That is my prelimitary thought.. I will work on this framework in this
> > weekend.
> > and then we can work together on it. :)
> >
> > p.s. Pratik, if you have some time, could you take some extra time adding
> > the
> > super checksum calulation to EROFS? I mean we can add
> > EROFS_FEATURE_SB_CHKSUM
> > to the compat superblock field ("features"), and do crc32_le on kernel and
> > mkfs...
> > If you dont have time, I will do it later instead... (since we are using
> > EROFS
> > on the top of dm-verity, but completing the superblock chksum is also a
> > good idea.)
> >
> > And then we can add block-based verification layer to EROFS, it can be seen
> > as a hash tree like dm-verity or just simply CRC32 arrays for user to
> > choise.
> >
> > Thanks,
> > Gao Xiang
> >
> > >
> > > NOTE:This is an experimental patch just to demonstrate the purpose. The
> > patch
> > > lacks a lot of things like coding standard, and new code runs in the
> > context
> > > of mkfs itself.kindly ignore it.
> > >
> > > kindly provide your feedback on this.
> > >
> > > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > > ---
> > >  include/erofs/io.h |  8 ++++++++
> > >  lib/io.c           | 27 +++++++++++++++++++++++++++
> > >  mkfs/main.c        | 36 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 71 insertions(+)
> > >
> > > diff --git a/include/erofs/io.h b/include/erofs/io.h
> > > index 4b574bd..e91d6ee 100644
> > > --- a/include/erofs/io.h
> > > +++ b/include/erofs/io.h
> > > @@ -18,6 +18,7 @@
> > >
> > >  int dev_open(const char *devname);
> > >  void dev_close(void);
> > > +int dev_read(void *buf, u64 offset, size_t len);
> > >  int dev_write(const void *buf, u64 offset, size_t len);
> > >  int dev_fillzero(u64 offset, size_t len, bool padding);
> > >  int dev_fsync(void);
> > > @@ -30,5 +31,12 @@ static inline int blk_write(const void *buf,
> > erofs_blk_t blkaddr,
> > >                        blknr_to_addr(nblocks));
> > >  }
> > >
> > > +static inline int blk_read(void *buf, erofs_blk_t blkaddr,
> > > +                        u32 nblocks)
> > > +{
> > > +     return dev_read(buf, blknr_to_addr(blkaddr),
> > > +                     blknr_to_addr(nblocks));
> > > +}
> > > +
> > >  #endif
> > >
> > > diff --git a/lib/io.c b/lib/io.c
> > > index 15c5a35..87d7d6c 100644
> > > --- a/lib/io.c
> > > +++ b/lib/io.c
> > > @@ -109,6 +109,33 @@ u64 dev_length(void)
> > >       return erofs_devsz;
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
> > beyond the end of device(%" PRIu64 ").",
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
> > > +
> > >  int dev_write(const void *buf, u64 offset, size_t len)
> > >  {
> > >       int ret;
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index f127fe1..109486e 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -182,6 +182,41 @@ int erofs_mkfs_update_super_block(struct
> > erofs_buffer_head *bh,
> > >       return 0;
> > >  }
> > >
> > > +void erofs_dump_super(char *img_path)
> > > +{
> > > +     struct erofs_super_block *sb;
> > > +     char buf[EROFS_BLKSIZ];
> > > +     unsigned int blksz;
> > > +     int ret = 0;
> > > +
> > > +     if (img_path == NULL) {
> > > +             erofs_err("image path cannot be null");
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
> > > +             erofs_err("not a erofs image");
> > > +             return;
> > > +     }
> > > +
> > > +     erofs_dump("magic: 0x%x\n", le32_to_cpu(sb->magic));
> > > +     blksz = 1 << sb->blkszbits;
> > > +     erofs_dump("block size: %d\n", blksz);
> > > +     erofs_dump("root inode: %d\n", le32_to_cpu(sb->root_nid));
> > > +     erofs_dump("inodes: %llu\n", le64_to_cpu(sb->inos));
> > > +     erofs_dump("build time: %u\n", le32_to_cpu(sb->build_time));
> > > +     erofs_dump("blocks: %u\n", le32_to_cpu(sb->blocks));
> > > +     erofs_dump("meta block: %u\n", le32_to_cpu(sb->meta_blkaddr));
> > > +     erofs_dump("xattr block: %u\n", le32_to_cpu(sb->xattr_blkaddr));
> > > +     erofs_dump("requirements: 0x%x\n", le32_to_cpu(sb->requirements));
> > > +}
> > > +
> > >  int main(int argc, char **argv)
> > >  {
> > >       int err = 0;
> > > @@ -268,6 +303,7 @@ int main(int argc, char **argv)
> > >               err = -EIO;
> > >  exit:
> > >       z_erofs_compress_exit();
> > > +     erofs_dump_super("dummy");
> > >       dev_close();
> > >       erofs_exit_configure();
> > >
> > > --
> > > 2.9.3
> > >
> >
