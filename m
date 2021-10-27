Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7F43C09A
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 05:14:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfDLQ258Pz2y7W
	for <lists+linux-erofs@lfdr.de>; Wed, 27 Oct 2021 14:14:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfDLG24Zpz2xXD
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 Oct 2021 14:13:57 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UtpxRkC_1635304429; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UtpxRkC_1635304429) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 11:13:50 +0800
Date: Wed, 27 Oct 2021 11:13:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daeho Jeong <daeho43@gmail.com>
Subject: Re: [PATCH] erofs-utils: introduce fsck.erofs
Message-ID: <YXjD7bnOHj8D/3/w@B-P7TQMD6M-0146.local>
References: <20211025194809.1118624-1-daeho43@gmail.com>
 <20211025232436.GB10537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CACOAw_ymWoufFFHcF+RV5sA5G5Xq1nsWqJZiWtWS5_VGpYXQXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOAw_ymWoufFFHcF+RV5sA5G5Xq1nsWqJZiWtWS5_VGpYXQXA@mail.gmail.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, miaoxie@huawei.com,
 Wang Qi <mpiglet@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Daeho,

On Tue, Oct 26, 2021 at 11:35:44AM -0700, Daeho Jeong wrote:
> > Many thanks for the patch! I also think some fsck feature is useful in
> > order to check the image integration.
> >
> > IMO, Compression ratio calculation is more like a dump fs feature.
> > Wang Qi developed the erofsdump yet he told me that he is working for
> > another urgent stuffs for now so he delayed the work:
> > https://lore.kernel.org/r/20210915093537.2579575-1-guoxuenan@huawei.com
> 
> Right, it's better to move these feature to dump.erofs.

I'm fine to add "Compression ratio calculation" temporarily in
fsck.erofs as long as active development.

Let's see if fsck feature can match erofs-utils 1.4 timepoint.

> 
> >
> > fsck and dump have the similar logic (and like f2fs-tools, we can also
> > have one program for this 2 features). If fsck is actively developed,
> > I'm pretty fine to use the fsck codebase and merge erofsdump into it
> > later instead.
> 
> Like f2fs tools, I think we can maintain two tools separately.

Yeah, my point is two tools share one common logic in the final shape,
but I'm fine with the current status as well :)

> But, if you want, we can merge them into one tool.
> 
> > Some comments as below:
> >
> > > ---
> > >  Makefile.am              |   2 +-
> > >  configure.ac             |   3 +-
> > >  fsck/Makefile.am         |   9 +
> > >  fsck/main.c              | 548 +++++++++++++++++++++++++++++++++++++++
> > >  include/erofs/internal.h |   5 +
> > >  include/erofs_fs.h       |  13 +
> > >  lib/data.c               |   4 +-
> > >  lib/namei.c              |   2 +-
> > >  lib/super.c              |   1 +
> > >  mkfs/main.c              |  13 -
> > >  10 files changed, 582 insertions(+), 18 deletions(-)
> > >  create mode 100644 fsck/Makefile.am
> > >  create mode 100644 fsck/main.c
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index 24e1d38..fc464e8 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -2,7 +2,7 @@
> > >
> > >  ACLOCAL_AMFLAGS = -I m4
> > >
> > > -SUBDIRS = man lib mkfs dump
> > > +SUBDIRS = man lib mkfs dump fsck
> > >  if ENABLE_FUSE
> > >  SUBDIRS += fuse
> > >  endif
> > > diff --git a/configure.ac b/configure.ac
> > > index b2c3225..5698b2e 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -298,5 +298,6 @@ AC_CONFIG_FILES([Makefile
> > >                lib/Makefile
> > >                mkfs/Makefile
> > >                dump/Makefile
> > > -              fuse/Makefile])
> > > +              fuse/Makefile
> > > +              fsck/Makefile])
> > >  AC_OUTPUT
> > > diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> > > new file mode 100644
> > > index 0000000..82973ba
> > > --- /dev/null
> > > +++ b/fsck/Makefile.am
> > > @@ -0,0 +1,9 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +# Makefile.am
> > > +
> > > +AUTOMAKE_OPTIONS = foreign
> > > +bin_PROGRAMS     = fsck.erofs
> > > +AM_CPPFLAGS = ${libuuid_CFLAGS}
> > > +fsck_erofs_SOURCES = main.c
> > > +fsck_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> > > +fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libuuid_LIBS} ${liblz4_LIBS}
> > > diff --git a/fsck/main.c b/fsck/main.c
> > > new file mode 100644
> > > index 0000000..c397d19
> > > --- /dev/null
> > > +++ b/fsck/main.c
> > > @@ -0,0 +1,548 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2021 Google LLC
> > > + * Author: Daeho Jeong <daehojeong@google.com>
> > > + */
> > > +#include <stdlib.h>
> > > +#include <getopt.h>
> > > +#include <time.h>
> > > +#include "erofs/print.h"
> > > +#include "erofs/io.h"
> > > +
> > > +enum {
> > > +     NO_PRINT_COMP_RATIO             = 0,
> > > +     PRINT_COMP_RATIO_ALL            = 1,
> > > +     PRINT_COMP_RATIO_COMP_FILE      = 2,
> > > +};
> > > +
> > > +static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
> > > +
> > > +struct erofsfsck_cfg {
> > > +     bool corrupted;
> > > +     int print_comp_ratio;
> > > +     u64 ondisk_len;
> > > +     u64 logical_len;
> > > +};
> > > +static struct erofsfsck_cfg fsckcfg;
> > > +
> > > +static struct option long_options[] = {
> > > +     {"help", no_argument, 0, 1},
> > > +     {0, 0, 0, 0},
> > > +};
> > > +
> > > +static void usage(void)
> > > +{
> > > +     fputs("usage: [options] IMAGE\n\n"
> > > +           "Check erofs filesystem integrity of IMAGE, and [options] are:\n"
> > > +           " -V      print the version number of fsck.erofs and exit.\n"
> > > +           " -d#     set output message level to # (maximum 9)\n"
> > > +           " -c      print total compression ratio of all compressed files\n"
> > > +           " -C      print total compression ratio of all files\n"
> >
> > Apart from erofsdump consideration.. Can we merge these 2 options into one?
> 
> Sure~
> 
> >
> > > +           " --help  display this help and exit.\n",
> > > +           stderr);
> > > +}
> > > +
> > > +static void erofsfsck_print_version(void)
> > > +{
> > > +     fprintf(stderr, "fsck.erofs %s\n", cfg.c_version);
> > > +}
> > > +
> > > +static int erofsfsck_parse_options_cfg(int argc, char **argv)
> > > +{
> > > +     int opt, i;
> > > +
> > > +     while ((opt = getopt_long(argc, argv, "Vd:Cc",
> > > +                               long_options, NULL)) != -1) {
> > > +             switch (opt) {
> > > +             case 'V':
> > > +                     erofsfsck_print_version();
> > > +                     exit(0);
> > > +             case 'd':
> > > +                     i = atoi(optarg);
> > > +                     if (i < EROFS_MSG_MIN || i > EROFS_MSG_MAX) {
> > > +                             erofs_err("invalid debug level %d", i);
> > > +                             return -EINVAL;
> > > +                     }
> > > +                     cfg.c_dbg_lvl = i;
> > > +                     break;
> > > +             case 'C':
> > > +                     fsckcfg.print_comp_ratio = PRINT_COMP_RATIO_ALL;
> > > +                     break;
> > > +             case 'c':
> > > +                     fsckcfg.print_comp_ratio = PRINT_COMP_RATIO_COMP_FILE;
> > > +                     break;
> > > +             case 1:
> > > +                     usage();
> > > +                     exit(0);
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > > +     }
> > > +
> > > +     if (optind >= argc)
> > > +             return -EINVAL;
> > > +
> > > +     cfg.c_img_path = strdup(argv[optind++]);
> > > +     if (!cfg.c_img_path)
> > > +             return -ENOMEM;
> > > +
> > > +     if (optind < argc) {
> > > +             erofs_err("unexpected argument: %s\n", argv[optind]);
> > > +             return -EINVAL;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int erofs_check_sb_chksum(void)
> > > +{
> > > +     int ret;
> > > +     u8 buf[EROFS_BLKSIZ];
> > > +     u32 crc;
> > > +     struct erofs_super_block *sb;
> > > +
> > > +     ret = blk_read(buf, 0, 1);
> > > +     if (ret) {
> > > +             erofs_err("failed to read superblock to check checksum: "
> > > +                       "errno(%d)", ret);
> > > +             return -1;
> > > +     }
> > > +
> > > +     sb = (struct erofs_super_block *)(buf + EROFS_SUPER_OFFSET);
> > > +     sb->checksum = 0;
> > > +
> > > +     crc = crc32c(~0, (u8 *)sb, EROFS_BLKSIZ - EROFS_SUPER_OFFSET);
> > > +     if (crc != sbi.checksum) {
> > > +             erofs_err("superblock checksum doesn't match: saved(0x%08x) "
> > > +                       "calculated(0x%08x)", sbi.checksum, crc);
> > > +             fsckcfg.corrupted = true;
> > > +             return -1;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int check_special_dentries(struct erofs_dirent *de, const char *de_name,
> > > +                               unsigned int de_namelen, erofs_nid_t nid,
> > > +                               erofs_nid_t pnid, bool is_curdir)
> > > +{
> > > +     unsigned int dirname_len = is_curdir ? 1 : 2;
> > > +     const char *dirname = is_curdir ? "." : "..";
> > > +     erofs_nid_t correct_nid = is_curdir ? nid : pnid;
> > > +
> > > +     if (de_namelen != dirname_len || memcmp(de_name, dirname, de_namelen)) {
> > > +             char *dbgname = strndup(de_name, de_namelen);
> > > +
> > > +             BUG_ON(!dbgname);
> > > +             if (is_curdir)
> > > +                     erofs_err("wrong current dir name(%s) @ nid(%llu)",
> > > +                               dbgname, nid | 0ULL);
> > > +             else
> > > +                     erofs_err("wrong parent dir name(%s) @ nid(%llu)",
> > > +                               dbgname, nid | 0ULL);
> > > +             free(dbgname);
> > > +             return -1;
> > > +     }
> > > +
> > > +     if (de->nid != correct_nid) {
> > > +             if (is_curdir)
> > > +                     erofs_err("wrong current dir nid(%llu) @ nid(%llu)",
> > > +                               de->nid | 0ULL, nid | 0ULL);
> > > +             else
> > > +                     erofs_err("wrong parent dir nid(%llu): "
> > > +                               "pnid(%llu) @ nid(%llu)",
> > > +                               de->nid | 0ULL, pnid | 0ULL, nid | 0ULL);
> > > +             return -1;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
> > > +                         void *dentry_blk, erofs_off_t offset,
> > > +                         unsigned int next_nameoff, unsigned int maxsize)
> >
> > Not quite sure if we could introduce some
> > erofs_foreach_dirent() and customized callbacks to cleanup similar functions
> > in fuse and fsck...
> 
> Let me think about it more.

That is not quite urgent for now, we can stay as this.

> 
> > > +{
> > > +     struct erofs_dirent *de = dentry_blk;
> > > +     const struct erofs_dirent *end = dentry_blk + next_nameoff;
> > > +     unsigned int idx = 0;
> > > +
> > > +     erofs_dbg("traversing pnid(%llu), nid(%llu)", pnid | 0ULL, nid | 0ULL);
> > > +
> > > +     if (offset == 0 && (next_nameoff < 2 * sizeof(struct erofs_dirent))) {
> > > +             erofs_err("too small dirents of size(%d) in nid(%llu)",
> > > +                       next_nameoff, nid | 0ULL);
> > > +             return -EFSCORRUPTED;
> > > +     }
> > > +
> > > +     while (de < end) {
> > > +             const char *de_name;
> > > +             unsigned int de_namelen;
> > > +             unsigned int nameoff;
> > > +             char *dbgname;
> > > +
> > > +             nameoff = le16_to_cpu(de->nameoff);
> > > +             de_name = (char *)dentry_blk + nameoff;
> > > +
> > > +             /* the last dirent check */
> > > +             if (de + 1 >= end)
> > > +                     de_namelen = strnlen(de_name, maxsize - nameoff);
> > > +             else
> > > +                     de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> > > +
> > > +             if (cfg.c_dbg_lvl >= EROFS_DBG) {
> > > +                     dbgname = strndup(de_name, de_namelen);
> > > +                     BUG_ON(!dbgname);
> > > +                     erofs_dbg("traversed filename(%s)", dbgname);
> > > +                     free(dbgname);
> > > +             }
> > > +
> > > +             /* corrupted entry check */
> > > +             if (nameoff != next_nameoff) {
> > > +                     erofs_err("bogus dirent with nameoff(%u): expected(%d) "
> > > +                               "@ nid(%llu), offset(%llu), idx(%u)",
> > > +                               nameoff, next_nameoff, nid | 0ULL,
> > > +                               offset | 0ULL, idx);
> > > +                     return -EFSCORRUPTED;
> > > +             }
> > > +
> > > +             if (nameoff + de_namelen > maxsize ||
> > > +                             de_namelen > EROFS_NAME_LEN) {
> > > +                     erofs_err("bogus dirent with namelen(%u) @ nid(%llu), "
> > > +                               "offset(%llu), idx(%u)",
> > > +                               de_namelen, nid | 0ULL, offset | 0ULL, idx);
> > > +                     return -EFSCORRUPTED;
> > > +             }
> > > +
> > > +             if (offset == 0 && (idx == 0 || idx == 1)) {
> >
> > We may not assume "." and ".." special dirents as 0 or 1... Actually
> > all dirents are sorted in the alphabetical order. I'm not sure if
> > some dirents are smaller than "." and "..".
> 
> Ok, I will remove this check here.

Ok.

> 
> > We could also check if all dirents are in alphabetical order as well
> > since it's used to do binary search runtimely.
> 
> I will add a check routine to check all dirents are in alphabetical order.

Ok.

> 
> >
> > > +                     if (check_special_dentries(de, de_name, de_namelen, nid,
> > > +                                                pnid, idx == 0))
> > > +                             return -EFSCORRUPTED;
> > > +             } else {
> > > +                     erofs_check_inode(nid, de->nid);
> > > +                     if (fsckcfg.corrupted)
> > > +                             return -EFSCORRUPTED;
> > > +             }
> > > +
> > > +             next_nameoff += de_namelen;
> > > +             ++de;
> > > +             ++idx;
> > > +     }
> > > +
> > > +     erofs_dbg("traversing ... done nid(%llu)", nid | 0ULL);
> > > +     return 0;
> > > +}
> > > +
> > > +static int verify_raw_data_chunk(struct erofs_inode *inode)
> > > +{
> > > +     struct erofs_map_blocks map = {
> > > +             .index = UINT_MAX,
> > > +     };
> > > +     int ret;
> > > +     erofs_off_t ptr = 0;
> > > +
> > > +     if (fsckcfg.print_comp_ratio == PRINT_COMP_RATIO_ALL) {
> > > +             fsckcfg.logical_len += inode->i_size;
> > > +             fsckcfg.ondisk_len += inode->i_size;
> > > +     }
> > > +
> > > +     while (ptr < inode->i_size) {
> > > +             map.m_la = ptr;
> > > +             ret = erofs_map_blocks(inode, &map, 0);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             if (map.m_plen != map.m_llen || ptr != map.m_la) {
> > > +                     erofs_err("broken data chunk layout m_la %" PRIu64
> > > +                               " ptr %" PRIu64 " m_llen %" PRIu64 " m_plen %"
> > > +                               PRIu64, map.m_la, ptr, map.m_llen,
> > > +                               map.m_plen);
> > > +                     return -EFSCORRUPTED;
> > > +             }
> > > +
> > > +             if (!(map.m_flags & EROFS_MAP_MAPPED) && !map.m_llen) {
> > > +                     /* readched EOF */
> > > +                     ptr = inode->i_size;
> > > +                     continue;
> > > +             }
> > > +
> > > +             ptr += map.m_llen;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static int verify_compressed_chunk(struct erofs_inode *inode)
> > > +{
> > > +     struct erofs_map_blocks map = {
> > > +             .index = UINT_MAX,
> > > +     };
> > > +     int ret = 0;
> > > +     bool count_pchunk = fsckcfg.print_comp_ratio != NO_PRINT_COMP_RATIO;
> > > +     u64 pchunk_len = 0;
> > > +     erofs_off_t offset = 0, end = inode->i_size;
> > > +
> > > +     while (end > offset) {
> > > +             map.m_la = end - 1;
> > > +
> > > +             ret = z_erofs_map_blocks_iter(inode, &map);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             if (end > map.m_la + map.m_llen) {
> > > +                     erofs_err("broken compressed chunk layout m_la %" PRIu64
> > > +                               " m_llen %" PRIu64 " end %" PRIu64,
> > > +                               map.m_la, map.m_llen, end);
> > > +                     return -EFSCORRUPTED;
> > > +             }
> >
> > IMO, A simple way to check this is to try to decompress by calling
> > z_erofs_decompress() with .partial_decoding == 0 and see if any
> > error when decompressing as well.
> 
> Got it~

Yeah, thanks for doing this again!

Thanks,
Gao Xiang

> 
> > > +
> > > +             if (count_pchunk)
> > > +                     pchunk_len += map.m_plen;
> > > +
> > > +             end = map.m_la;
> > > +     }
> > > +
> > > +     if (count_pchunk) {
> > > +             fsckcfg.logical_len += inode->i_size;
> > > +             fsckcfg.ondisk_len += pchunk_len;
> >
> > we can also check another field called compressed_blocks in on-disk
> > inode...
> 
> ditto
> 
> 
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int erofs_verify_xattr(struct erofs_inode *inode)
> > > +{
> > > +     unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
> > > +     unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
> > > +     erofs_off_t addr;
> > > +     unsigned int ofs, xattr_shared_count;
> > > +     struct erofs_xattr_ibody_header *ih;
> > > +     struct erofs_xattr_entry *entry;
> > > +     int i, remaining = inode->xattr_isize, ret = 0;
> > > +     char *buf = calloc(EROFS_BLKSIZ, 1);
> > > +
> > > +     BUG_ON(!buf);
> > > +
> > > +     if (inode->xattr_isize == xattr_hdr_size) {
> > > +             erofs_err("xattr_isize %d of nid %llu is not supported yet",
> > > +                       inode->xattr_isize, inode->nid | 0ULL);
> > > +             ret = -EFSCORRUPTED;
> > > +             goto out;
> > > +     } else if (inode->xattr_isize < xattr_hdr_size) {
> > > +             if (inode->xattr_isize) {
> > > +                     erofs_err("bogus xattr ibody @ nid %llu",
> > > +                               inode->nid | 0ULL);
> > > +                     ret = -EFSCORRUPTED;
> > > +                     goto out;
> > > +             }
> > > +     }
> > > +
> > > +     addr = iloc(inode->nid) + inode->inode_isize;
> > > +     ret = dev_read(buf, addr, xattr_hdr_size);
> > > +     if (ret < 0) {
> > > +             erofs_err("an error occurred when reading xattr header "
> > > +                       "of nid(%llu): errno(%d)", inode->nid | 0ULL, ret);
> > > +             goto out;
> > > +     }
> > > +     ih = (struct erofs_xattr_ibody_header *)buf;
> > > +     xattr_shared_count = ih->h_shared_count;
> > > +
> > > +     ofs = erofs_blkoff(addr) + xattr_hdr_size;
> > > +     addr += xattr_hdr_size;
> > > +     remaining -= xattr_hdr_size;
> > > +     for (i = 0; i < xattr_shared_count; ++i) {
> > > +             if (ofs >= EROFS_BLKSIZ) {
> > > +                     if (ofs != EROFS_BLKSIZ) {
> > > +                             erofs_err("unaligned xattr entry in "
> > > +                                       "xattr shared area of nid(%llu)",
> > > +                                       inode->nid | 0ULL);
> > > +                             ret = -EFSCORRUPTED;
> >
> > IMO, it won't happen due to proper alignment.. but I'm fine as this too.
> >
> > Thanks,
> > Gao Xiang
> >
> > > +                             goto out;
> > > +                     }
> > > +                     ofs = 0;
> > > +             }
> > > +             ofs += xattr_entry_size;
> > > +             addr += xattr_entry_size;
> > > +             remaining -= xattr_entry_size;
> > > +     }
> > > +
> > > +     while (remaining > 0) {
> > > +             unsigned int entry_sz;
> > > +
> > > +             ret = dev_read(buf, addr, xattr_entry_size);
> > > +             if (ret) {
> > > +                     erofs_err("an error occurred when reading xattr entry "
> > > +                               "of nid(%llu): errno(%d)",
> > > +                               inode->nid | 0ULL, ret);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             entry = (struct erofs_xattr_entry *)buf;
> > > +             entry_sz = erofs_xattr_entry_size(entry);
> > > +             if (remaining < entry_sz) {
> > > +                     erofs_err("xattr on-disk corruption: xattr entry "
> > > +                               "beyond xattr_isize of nid(%llu)",
> > > +                               inode->nid | 0ULL);
> > > +                     ret = -EFSCORRUPTED;
> > > +                     goto out;
> > > +             }
> > > +             addr += entry_sz;
> > > +             remaining -= entry_sz;
> > > +     }
> > > +out:
> > > +     free(buf);
> > > +     return ret;
> > > +}
> > > +
> > > +static int erofs_verify_data_chunk(struct erofs_inode *inode)
> > > +{
> > > +     int ret;
> > > +
> > > +     erofs_dbg("verify data chunk of nid(%llu): type(%d)",
> > > +               inode->nid | 0ULL, inode->datalayout);
> > > +
> > > +     switch (inode->datalayout) {
> > > +     case EROFS_INODE_FLAT_PLAIN:
> > > +     case EROFS_INODE_FLAT_INLINE:
> > > +     case EROFS_INODE_CHUNK_BASED:
> > > +             ret = verify_raw_data_chunk(inode);
> > > +             break;
> > > +     case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> > > +     case EROFS_INODE_FLAT_COMPRESSION:
> > > +             ret = verify_compressed_chunk(inode);
> > > +             break;
> > > +     default:
> > > +             ret = -EINVAL;
> > > +             break;
> > > +     }
> > > +
> > > +     if (ret == -EIO)
> > > +             erofs_err("I/O error occurred when verifying "
> > > +                       "data chunk of nid(%llu)", inode->nid | 0ULL);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
> > > +{
> > > +     int ret;
> > > +     struct erofs_inode *inode;
> > > +     char *buf;
> > > +     erofs_off_t offset;
> > > +
> > > +     erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
> > > +     inode = calloc(1, sizeof(struct erofs_inode));
> > > +     BUG_ON(!inode);
> > > +     buf = calloc(EROFS_BLKSIZ, 1);
> > > +     BUG_ON(!buf);
> > > +
> > > +     inode->nid = nid;
> > > +     ret = erofs_read_inode_from_disk(inode);
> > > +     if (ret) {
> > > +             if (ret == -EIO)
> > > +                     erofs_err("I/O error occurred when reading nid(%llu)",
> > > +                               nid | 0ULL);
> > > +             goto out;
> > > +     }
> > > +
> > > +     /* verify xattr field */
> > > +     ret = erofs_verify_xattr(inode);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     /* verify data chunk layout */
> > > +     ret = erofs_verify_data_chunk(inode);
> > > +     if (ret)
> > > +             goto out;
> > > +
> > > +     if ((inode->i_mode & S_IFMT) != S_IFDIR)
> > > +             goto out;
> > > +
> > > +     offset = 0;
> > > +     while (offset < inode->i_size) {
> > > +             erofs_off_t maxsize = min_t(erofs_off_t,
> > > +                                     inode->i_size - offset, EROFS_BLKSIZ);
> > > +             struct erofs_dirent *de = (void *)buf;
> > > +             unsigned int nameoff;
> > > +
> > > +             ret = erofs_pread(inode, buf, maxsize, offset);
> > > +             if (ret) {
> > > +                     erofs_err("I/O error occurred when reading dirents: "
> > > +                               "nid(%llu), offset(%llu), size(%llu)",
> > > +                               nid | 0ULL, offset | 0ULL, maxsize | 0ULL);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             nameoff = le16_to_cpu(de->nameoff);
> > > +             if (nameoff < sizeof(struct erofs_dirent) ||
> > > +                             nameoff >= PAGE_SIZE) {
> > > +                     erofs_err("invalid de[0].nameoff %u @ nid(%llu), "
> > > +                               "offset(%llu)",
> > > +                               nameoff, nid | 0ULL, offset | 0ULL);
> > > +                     ret = -EFSCORRUPTED;
> > > +                     goto out;
> > > +             }
> > > +
> > > +             ret = traverse_dirents(pnid, nid, buf, offset,
> > > +                                    nameoff, maxsize);
> > > +             if (ret)
> > > +                     goto out;
> > > +
> > > +             offset += maxsize;
> > > +     }
> > > +out:
> > > +     free(buf);
> > > +     free(inode);
> > > +     if (ret && ret != -EIO)
> > > +             fsckcfg.corrupted = true;
> > > +}
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +     int err;
> > > +
> > > +     erofs_init_configure();
> > > +
> > > +     fsckcfg.corrupted = false;
> > > +     fsckcfg.print_comp_ratio = NO_PRINT_COMP_RATIO;
> > > +     fsckcfg.logical_len = 0;
> > > +     fsckcfg.ondisk_len = 0;
> > > +
> > > +     err = erofsfsck_parse_options_cfg(argc, argv);
> > > +     if (err) {
> > > +             if (err == -EINVAL)
> > > +                     usage();
> > > +             goto exit;
> > > +     }
> > > +
> > > +     err = dev_open_ro(cfg.c_img_path);
> > > +     if (err) {
> > > +             erofs_err("failed to open image file");
> > > +             goto exit;
> > > +     }
> > > +
> > > +     err = erofs_read_superblock();
> > > +     if (err) {
> > > +             erofs_err("failed to read superblock");
> > > +             goto exit;
> > > +     }
> > > +
> > > +     if (erofs_sb_has_sb_chksum() && erofs_check_sb_chksum()) {
> > > +             erofs_err("failed to verify superblock checksum");
> > > +             goto exit;
> > > +     }
> > > +
> > > +     erofs_check_inode(sbi.root_nid, sbi.root_nid);
> > > +
> > > +     if (fsckcfg.corrupted) {
> > > +             fprintf(stderr, "Found some filesystem corruption\n");
> > > +     } else {
> > > +             fprintf(stderr, "No error found\n");
> > > +             if (fsckcfg.print_comp_ratio != NO_PRINT_COMP_RATIO) {
> > > +                     double comp_ratio = (double)fsckcfg.ondisk_len * 100 /
> > > +                                         (double)fsckcfg.logical_len;
> > > +                     fprintf(stderr, "Compression Ratio: %.2f(%%)\n",
> > > +                             comp_ratio);
> > > +             }
> > > +     }
> > > +
> > > +exit:
> > > +     erofs_exit_configure();
> > > +     return err;
> > > +}
> > > diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> > > index 8b154ed..80065b2 100644
> > > --- a/include/erofs/internal.h
> > > +++ b/include/erofs/internal.h
> > > @@ -82,6 +82,8 @@ struct erofs_sb_info {
> > >
> > >       u16 available_compr_algs;
> > >       u16 lz4_max_distance;
> > > +
> > > +     u32 checksum;
> > >  };
> > >
> > >  /* global sbi */
> > > @@ -264,10 +266,13 @@ int erofs_read_superblock(void);
> > >
> > >  /* namei.c */
> > >  int erofs_ilookup(const char *path, struct erofs_inode *vi);
> > > +int erofs_read_inode_from_disk(struct erofs_inode *vi);
> > >
> > >  /* data.c */
> > >  int erofs_pread(struct erofs_inode *inode, char *buf,
> > >               erofs_off_t count, erofs_off_t offset);
> > > +int erofs_map_blocks(struct erofs_inode *inode,
> > > +                  struct erofs_map_blocks *map, int flags);
> > >  /* zmap.c */
> > >  int z_erofs_fill_inode(struct erofs_inode *vi);
> > >  int z_erofs_map_blocks_iter(struct erofs_inode *vi,
> > > diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> > > index 66a68e3..62e9981 100644
> > > --- a/include/erofs_fs.h
> > > +++ b/include/erofs_fs.h
> > > @@ -400,4 +400,17 @@ static inline void erofs_check_ondisk_layout_definitions(void)
> > >                    Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
> > >  }
> > >
> > > +#define CRC32C_POLY_LE       0x82F63B78
> > > +static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
> > > +{
> > > +     int i;
> > > +
> > > +     while (len--) {
> > > +             crc ^= *in++;
> > > +             for (i = 0; i < 8; i++)
> > > +                     crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
> > > +     }
> > > +     return crc;
> > > +}
> > > +
> > >  #endif
> > > diff --git a/lib/data.c b/lib/data.c
> > > index 641d840..6cb7eeb 100644
> > > --- a/lib/data.c
> > > +++ b/lib/data.c
> > > @@ -61,8 +61,8 @@ err_out:
> > >       return err;
> > >  }
> > >
> > > -static int erofs_map_blocks(struct erofs_inode *inode,
> > > -                         struct erofs_map_blocks *map, int flags)
> > > +int erofs_map_blocks(struct erofs_inode *inode,
> > > +                  struct erofs_map_blocks *map, int flags)
> > >  {
> > >       struct erofs_inode *vi = inode;
> > >       struct erofs_inode_chunk_index *idx;
> > > diff --git a/lib/namei.c b/lib/namei.c
> > > index b4bdabf..56f199a 100644
> > > --- a/lib/namei.c
> > > +++ b/lib/namei.c
> > > @@ -22,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
> > >       return makedev(major, minor);
> > >  }
> > >
> > > -static int erofs_read_inode_from_disk(struct erofs_inode *vi)
> > > +int erofs_read_inode_from_disk(struct erofs_inode *vi)
> > >  {
> > >       int ret, ifmt;
> > >       char buf[sizeof(struct erofs_inode_extended)];
> > > diff --git a/lib/super.c b/lib/super.c
> > > index 0fa69ab..0c30403 100644
> > > --- a/lib/super.c
> > > +++ b/lib/super.c
> > > @@ -62,6 +62,7 @@ int erofs_read_superblock(void)
> > >       sbi.islotbits = EROFS_ISLOTBITS;
> > >       sbi.root_nid = le16_to_cpu(dsb->root_nid);
> > >       sbi.inos = le64_to_cpu(dsb->inos);
> > > +     sbi.checksum = le32_to_cpu(dsb->checksum);
> > >
> > >       sbi.build_time = le64_to_cpu(dsb->build_time);
> > >       sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
> > > diff --git a/mkfs/main.c b/mkfs/main.c
> > > index 1c8dea5..b9b46f5 100644
> > > --- a/mkfs/main.c
> > > +++ b/mkfs/main.c
> > > @@ -424,19 +424,6 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
> > >       return 0;
> > >  }
> > >
> > > -#define CRC32C_POLY_LE       0x82F63B78
> > > -static inline u32 crc32c(u32 crc, const u8 *in, size_t len)
> > > -{
> > > -     int i;
> > > -
> > > -     while (len--) {
> > > -             crc ^= *in++;
> > > -             for (i = 0; i < 8; i++)
> > > -                     crc = (crc >> 1) ^ ((crc & 1) ? CRC32C_POLY_LE : 0);
> > > -     }
> > > -     return crc;
> > > -}
> > > -
> > >  static int erofs_mkfs_superblock_csum_set(void)
> > >  {
> > >       int ret;
> > > --
> > > 2.33.0.1079.g6e70778dc9-goog
> > >
