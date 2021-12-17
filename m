Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE6B479518
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 20:54:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JG0793vCdz3cN8
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 06:54:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639770869;
	bh=L4CqI2OUV+btpbpfNUhz2EPftxEfn4/82F4FEMDqn7k=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PV8XVUINqIEu/8W4Nubw2ejH1u2RInXD2RaoOoh4Z003cmAx88uLW4JEBXBOlP71n
	 Dcppe9S08+p3r7vkhE0M1m/JKCzPYSvLkZjduZzq/e4B+mHrWTPgySuRUUZ/uCQbnh
	 atluu387xdT2hFc6FUUI463eVvKvRvIC7Q6nePsocV6esSBOOXDyehQXaqkkL3DFhr
	 VyDCdVHVGbxdp/GhvHIqB3gLec25bZTMLLRC31rYY3yJeflrkLJoxv2MGXY1Q2/0HR
	 06qdePCfAN/TKrV/NXxfSfTCrULBA6EbMqmlPbEiqJbC4W9coRONuXfKZuhpk29Nn5
	 h2tlfgYs99EUg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::f32;
 helo=mail-qv1-xf32.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=teBvOUR5; dkim-atps=neutral
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JG0763Vrjz2yXt
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 06:54:24 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id js9so3393908qvb.12
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 11:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L4CqI2OUV+btpbpfNUhz2EPftxEfn4/82F4FEMDqn7k=;
 b=C5q4ccA0v1wUX0DBa+vNPu29WirrN7IlfeH1lFXcGRkoWRTut42n/Z6ZATrMRG/uUw
 h1fiPUbwJmwv60XN1tMPhJwMkSKG9IyqNCkIyb5x4K72E4UNyv7CdSFndNFfTUmdvdmy
 IshJ7jcY0C7BrntXKBjyUCEHEugEDMjSl5uR1kQ3YQrar89VnQUH+efZq4A68acPoJD2
 IIEXkyIsvjEPovykmBxOALtJCRLZx6+/YWVQ3pEDMHBMIvvLYDiakNUnyLLh16yqp/ZX
 7hJTWgUWq+kCSCDks7Kw2dy+f0K0NK5c6tpybf77syhXWLUvP4AM7g0VVO9p4l/p+fj7
 6nMA==
X-Gm-Message-State: AOAM531dZN0SpODltRmGBobvaKc6uIYvVm2+79Y3Q2XFp4KeIw9YuJ4e
 gvhSRUqALBZg2dm/nSO3+GTDoXoAylZGzkhWzWyE8BKO42g=
X-Google-Smtp-Source: ABdhPJyZvh20Xd78B+O/YctSSBBsryNufSMS+sDXgEJB4cQ5vHlcvVInbhiNP8qVtrzWIwJ2IK9mzOBI0N9qWKsb/7g=
X-Received: by 2002:a05:6214:b62:: with SMTP id
 ey2mr3746765qvb.0.1639770860338; 
 Fri, 17 Dec 2021 11:54:20 -0800 (PST)
MIME-Version: 1.0
References: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
 <20211217194720.3219630-1-zhangkelvin@google.com>
 <20211217194720.3219630-2-zhangkelvin@google.com>
In-Reply-To: <20211217194720.3219630-2-zhangkelvin@google.com>
Date: Fri, 17 Dec 2021 14:54:09 -0500
Message-ID: <CAOSmRzgMu1otsZomU3dfLdu=N4jJLKB=MBgp5viHLCg5fub68g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] erofs-utils: lib: add API to iterate dirs in EROFS
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000a5013605d35ce760"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000a5013605d35ce760
Content-Type: text/plain; charset="UTF-8"

Hi Gao,
    I drafted a new patchset on top of the dev branch. Changes since v6:

    1. block buffer moved to the heap, due to stack size concerns when
iterating recursively
    2. Added a "recursive" option to input parameters
    3. dname buffers are still on the heap, but allocation is done once per
directory, instead of once for each directory entry.
    4. Added a void* arg which will be forwarded to the callback function.

I ran scripts/checkpatch.pl . Hopefully this makes your life easier. Thanks
for the reply!.



On Fri, Dec 17, 2021 at 2:47 PM Kelvin Zhang <zhangkelvin@google.com> wrote:

> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  fuse/Makefile.am    |   2 +-
>  fuse/dir.c          | 100 --------------------
>  fuse/main.c         |  65 +++++++++++--
>  include/erofs/dir.h |  52 +++++++++++
>  lib/Makefile.am     |   2 +-
>  lib/dir.c           | 223 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 334 insertions(+), 110 deletions(-)
>  delete mode 100644 fuse/dir.c
>  create mode 100644 include/erofs/dir.h
>  create mode 100644 lib/dir.c
>
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 7b007f3..0a78c0a 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -2,7 +2,7 @@
>
>  AUTOMAKE_OPTIONS = foreign
>  bin_PROGRAMS     = erofsfuse
> -erofsfuse_SOURCES = dir.c main.c
> +erofsfuse_SOURCES = main.c
>  erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
>  erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS}
> ${libselinux_CFLAGS}
>  erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS}
> ${liblz4_LIBS} \
> diff --git a/fuse/dir.c b/fuse/dir.c
> deleted file mode 100644
> index bc8735b..0000000
> --- a/fuse/dir.c
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Created by Li Guifu <blucerlee@gmail.com>
> - */
> -#include <fuse.h>
> -#include <fuse_opt.h>
> -#include "macosx.h"
> -#include "erofs/internal.h"
> -#include "erofs/print.h"
> -
> -static int erofs_fill_dentries(struct erofs_inode *dir,
> -                              fuse_fill_dir_t filler, void *buf,
> -                              void *dblk, unsigned int nameoff,
> -                              unsigned int maxsize)
> -{
> -       struct erofs_dirent *de = dblk;
> -       const struct erofs_dirent *end = dblk + nameoff;
> -       char namebuf[EROFS_NAME_LEN + 1];
> -
> -       while (de < end) {
> -               const char *de_name;
> -               unsigned int de_namelen;
> -
> -               nameoff = le16_to_cpu(de->nameoff);
> -               de_name = (char *)dblk + nameoff;
> -
> -               /* the last dirent in the block? */
> -               if (de + 1 >= end)
> -                       de_namelen = strnlen(de_name, maxsize - nameoff);
> -               else
> -                       de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> -
> -               /* a corrupted entry is found */
> -               if (nameoff + de_namelen > maxsize ||
> -                   de_namelen > EROFS_NAME_LEN) {
> -                       erofs_err("bogus dirent @ nid %llu", dir->nid |
> 0ULL);
> -                       DBG_BUGON(1);
> -                       return -EFSCORRUPTED;
> -               }
> -
> -               memcpy(namebuf, de_name, de_namelen);
> -               namebuf[de_namelen] = '\0';
> -
> -               filler(buf, namebuf, NULL, 0);
> -               ++de;
> -       }
> -       return 0;
> -}
> -
> -int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> -                     off_t offset, struct fuse_file_info *fi)
> -{
> -       int ret;
> -       struct erofs_inode dir;
> -       char dblk[EROFS_BLKSIZ];
> -       erofs_off_t pos;
> -
> -       erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
> -
> -       ret = erofs_ilookup(path, &dir);
> -       if (ret)
> -               return ret;
> -
> -       erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
> -
> -       if (!S_ISDIR(dir.i_mode))
> -               return -ENOTDIR;
> -
> -       if (!dir.i_size)
> -               return 0;
> -
> -       pos = 0;
> -       while (pos < dir.i_size) {
> -               unsigned int nameoff, maxsize;
> -               struct erofs_dirent *de;
> -
> -               maxsize = min_t(unsigned int, EROFS_BLKSIZ,
> -                               dir.i_size - pos);
> -               ret = erofs_pread(&dir, dblk, maxsize, pos);
> -               if (ret)
> -                       return ret;
> -
> -               de = (struct erofs_dirent *)dblk;
> -               nameoff = le16_to_cpu(de->nameoff);
> -               if (nameoff < sizeof(struct erofs_dirent) ||
> -                   nameoff >= PAGE_SIZE) {
> -                       erofs_err("invalid de[0].nameoff %u @ nid %llu",
> -                                 nameoff, dir.nid | 0ULL);
> -                       ret = -EFSCORRUPTED;
> -                       break;
> -               }
> -
> -               ret = erofs_fill_dentries(&dir, filler, buf,
> -                                         dblk, nameoff, maxsize);
> -               if (ret)
> -                       break;
> -               pos += maxsize;
> -       }
> -       return 0;
> -}
> diff --git a/fuse/main.c b/fuse/main.c
> index 255965e..53dbdd4 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -12,9 +12,58 @@
>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/io.h"
> +#include "erofs/dir.h"
>
> -int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t
> filler,
> -                     off_t offset, struct fuse_file_info *fi);
> +struct erofsfuse_dir_context {
> +       fuse_fill_dir_t filler;
> +       struct fuse_file_info *fi;
> +       void *buf;
> +};
> +
> +static int erofsfuse_fill_dentries(struct erofs_dirent_info *ctx)
> +{
> +       struct erofsfuse_dir_context *fusectx = ctx->arg;
> +
> +       fusectx->filler(fusectx->buf, ctx->dname, NULL, 0);
> +       return 0;
> +}
> +
> +int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> +                     off_t offset, struct fuse_file_info *fi)
> +{
> +       int ret;
> +       struct erofs_inode dir;
> +
> +       erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
> +
> +       ret = erofs_ilookup(path, &dir);
> +       if (ret)
> +               return ret;
> +
> +       erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
> +       if (!S_ISDIR(dir.i_mode))
> +               return -ENOTDIR;
> +
> +       if (!dir.i_size)
> +               return 0;
> +       struct erofsfuse_dir_context ctx = {
> +               .filler = filler,
> +               .fi = fi,
> +               .buf = buf,
> +       };
> +       struct erofs_iterate_dir_param param = {
> +               .cb = erofsfuse_fill_dentries,
> +               .fsck = false,
> +               .nid = dir.nid,
> +               .recursive = false,
> +               .arg = &ctx,
> +       };
> +#ifndef NDEBUG
> +       param.fsck = true;
> +#endif
> +       return erofs_iterate_dir(&param);
> +
> +}
>
>  static void *erofsfuse_init(struct fuse_conn_info *info)
>  {
> @@ -122,13 +171,13 @@ static void usage(void)
>         struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>
>         fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
> -             "Options:\n"
> -             "    --dbglevel=#           set output message level to #
> (maximum 9)\n"
> -             "    --device=#             specify an extra device to be
> used together\n"
> +                 "Options:\n"
> +                 "    --dbglevel=#           set output message level to
> # (maximum 9)\n"
> +                 "    --device=#             specify an extra device to
> be used together\n"
>  #if FUSE_MAJOR_VERSION < 3
> -             "    --help                 display this help and exit\n"
> +                 "    --help                 display this help and exit\n"
>  #endif
> -             "\n", stderr);
> +                 "\n", stderr);
>
>  #if FUSE_MAJOR_VERSION >= 3
>         fuse_cmdline_help();
> @@ -148,7 +197,7 @@ static void erofsfuse_dumpcfg(void)
>  }
>
>  static int optional_opt_func(void *data, const char *arg, int key,
> -                            struct fuse_args *outargs)
> +                                struct fuse_args *outargs)
>  {
>         int ret;
>
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> new file mode 100644
> index 0000000..affb607
> --- /dev/null
> +++ b/include/erofs/dir.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_DIR_H
> +#define __EROFS_DIR_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "internal.h"
> +
> +struct erofs_dir_context;
> +
> +struct erofs_dirent_info {
> +       /* inode id of the inode being iterated */
> +       erofs_nid_t nid;
> +       /* file type, see values before EROFS_FT_MAX */
> +       u8 ftype;
> +       const char *dname;
> +       /* opaque ptr passed in erofs_iterate_dir_param,
> +        * can be used to persist state across multiple
> +        * callbacks.
> +        */
> +       void *arg;
> +};
> +
> +/* callback function for iterating over inodes of EROFS */
> +typedef int (*erofs_readdir_cb)(struct erofs_dirent_info *);
> +
> +/* callers could use a wrapper to contain extra information */
> +struct erofs_iterate_dir_param {
> +       /* inode id of the directory that needs to be iterated. */
> +       /* Use sbi.root_nid if you want to iterate over rood dir */
> +       erofs_nid_t nid;
> +       bool fsck;                      /* Whether to perform validity
> check */
> +       erofs_nid_t pnid;               /* optional, needed if fsck = true
> */
> +       erofs_readdir_cb cb;
> +       /* Whether to iterate this directory recursively */
> +       bool recursive;
> +       /* This will be copied to erofs_dirent_info.arg when invoking
> callback */
> +       void *arg;
> +};
> +
> +/* iterate over inodes that are in directory */
> +int erofs_iterate_dir(const struct erofs_iterate_dir_param *ctx);
> +
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 67ba798..25a4a2b 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>  noinst_HEADERS += compressor.h
>  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c
> exclude.c \
>                       namei.c data.c compress.c compressor.c zmap.c
> decompress.c \
> -                     compress_hints.c hashmap.c sha256.c blobchunk.c
> +                     compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
>  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
>  if ENABLE_LZ4
>  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> diff --git a/lib/dir.c b/lib/dir.c
> new file mode 100644
> index 0000000..04a4596
> --- /dev/null
> +++ b/lib/dir.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#include "erofs/dir.h"
> +
> +#include <linux/limits.h>
> +#include <stdlib.h>
> +
> +#include "erofs/internal.h"
> +#include "erofs/print.h"
> +
> +struct erofs_dir_context {
> +       erofs_nid_t pnid;               /* optional */
> +       struct erofs_inode *dir;
> +
> +       bool dot_found;
> +       bool dot_dot_found;
> +       char cur_name[PATH_MAX];
> +       char prev_name[PATH_MAX];
> +};
> +
> +
> +static int traverse_dirents(
> +               struct erofs_dir_context *ctx,
> +               const struct erofs_iterate_dir_param *params,
> +               const void *dentry_blk,
> +               unsigned int lblk, unsigned int next_nameoff,
> +               unsigned int maxsize, bool fsck)
> +{
> +       const struct erofs_dirent *de = dentry_blk;
> +       const struct erofs_dirent *end = dentry_blk + next_nameoff;
> +       char *prev_name = ctx->prev_name;
> +       char *cur_name = ctx->cur_name;
> +       const char *errmsg;
> +       int ret = 0;
> +       bool silent = false;
> +
> +       while (de < end) {
> +               unsigned int de_namelen;
> +               unsigned int nameoff;
> +
> +               nameoff = le16_to_cpu(de->nameoff);
> +               const char *de_name = (char *)dentry_blk + nameoff;
> +
> +               /* the last dirent check */
> +               if (de + 1 >= end)
> +                       de_namelen = strnlen(de_name, maxsize - nameoff);
> +               else
> +                       de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> +
> +               strncpy(cur_name, de_name, de_namelen);
> +               cur_name[de_namelen] = '\0';
> +               if (!cur_name) {
> +                       errmsg = "failed to allocate dirent name";
> +                       ret = -ENOMEM;
> +                       break;
> +               }
> +
> +               erofs_dbg("traversed filename(%s)", cur_name);
> +
> +               ret = -EFSCORRUPTED;
> +               /* corrupted entry check */
> +               if (nameoff != next_nameoff) {
> +                       errmsg = "bogus dirent nameoff";
> +                       break;
> +               }
> +
> +               if (nameoff + de_namelen > maxsize || de_namelen >
> EROFS_NAME_LEN) {
> +                       errmsg = "bogus dirent namelen";
> +                       break;
> +               }
> +
> +               if (fsck && prev_name && strcmp(prev_name, cur_name) >= 0)
> {
> +                       errmsg = "wrong dirent name order";
> +                       break;
> +               }
> +
> +               if (fsck && de->file_type >= EROFS_FT_MAX) {
> +                       errmsg = "invalid file type %u";
> +                       break;
> +               }
> +
> +               const bool dot_dotdot = is_dot_dotdot(cur_name);
> +
> +               if (dot_dotdot) {
> +                       switch (de_namelen) {
> +                       case 2:
> +                               if (fsck && ctx->dot_dot_found) {
> +                                       errmsg = "duplicated `..' dirent";
> +                                       goto out;
> +                               }
> +                               ctx->dot_dot_found = true;
> +                               if (sbi.root_nid == ctx->dir->nid) {
> +                                       ctx->pnid = sbi.root_nid;
> +                                       if (fsck && de->nid != ctx->pnid) {
> +                                               errmsg = "corrupted `..'
> dirent";
> +                                               goto out;
> +                                       }
> +                               }
> +                               break;
> +                       case 1:
> +                               if (fsck && ctx->dot_found) {
> +                                       errmsg = "duplicated `.' dirent";
> +                                       goto out;
> +                               }
> +
> +                               ctx->dot_found = true;
> +                               if (fsck && de->nid != ctx->dir->nid) {
> +                                       errmsg = "corrupted `.' dirent";
> +                                       goto out;
> +                               }
> +                               break;
> +                       }
> +               }
> +               struct erofs_dirent_info output_info = {
> +                       .ftype = de->file_type,
> +                       .nid = de->nid,
> +                       .arg = params->arg,
> +                       .dname = cur_name};
> +
> +               ret = params->cb(&output_info);
> +               if (ret) {
> +                       silent = true;
> +                       goto out;
> +               }
> +               if (params->recursive && de->file_type == EROFS_FT_DIR &&
> !dot_dotdot) {
> +                       const struct erofs_iterate_dir_param
> recursive_param = {
> +                               .nid = de->nid,
> +                               .fsck = params->fsck,
> +                               .pnid = params->nid,
> +                               .cb = params->cb,
> +                               .recursive = params->recursive,
> +                               .arg = params->arg};
> +                       erofs_iterate_dir(&recursive_param);
> +               }
> +
> +               next_nameoff += de_namelen;
> +               ++de;
> +
> +               prev_name = cur_name;
> +               cur_name = prev_name == ctx->prev_name ? ctx->cur_name :
> ctx->prev_name;
> +       }
> +       if (fsck && (!ctx->dot_found || !ctx->dot_dot_found)) {
> +               erofs_err("`.' or `..' dirent is missing @ nid %llu",
> de->nid | 0ULL);
> +               return -EFSCORRUPTED;
> +       }
> +out:
> +       if (ret && !silent)
> +               erofs_err("%s @ nid %llu, lblk %u, index %lu",
> +                       errmsg, ctx->dir->nid | 0ULL,
> +                       lblk, (de - (struct erofs_dirent *)dentry_blk) |
> 0UL);
> +       return ret;
> +}
> +
> +int erofs_iterate_dir(const struct erofs_iterate_dir_param *params)
> +{
> +       int err;
> +       struct erofs_inode dir;
> +
> +       dir.nid = params->nid;
> +       err = erofs_read_inode_from_disk(&dir);
> +       if (err) {
> +               return err;
> +       }
> +       if ((dir.i_mode & S_IFMT) != S_IFDIR) {
> +               return -ENOTDIR;
> +       }
> +
> +       struct erofs_dirent_info output_info;
> +       /* Both |buf| and |ctx| can live on the stack, but that might cause
> +        * stack overflow when iterating recursively. So put them on heap.
> +        */
> +       char *buf = calloc(EROFS_BLKSIZ, 1);
> +
> +       if (buf == NULL) {
> +               goto out;
> +       }
> +       struct erofs_dir_context *ctx = calloc(sizeof(struct
> erofs_dir_context), 1);
> +
> +       if (ctx == NULL) {
> +               goto out;
> +       }
> +       ctx->dir = &dir;
> +       ctx->pnid = params->pnid;
> +
> +       erofs_off_t pos = 0;
> +
> +       while (pos < dir.i_size) {
> +               const erofs_blk_t lblk = erofs_blknr(pos);
> +               const erofs_off_t maxsize =
> +                       min_t(erofs_off_t, dir.i_size - pos, EROFS_BLKSIZ);
> +               const struct erofs_dirent *de = (const void *)buf;
> +
> +               err = erofs_pread(&dir, buf, maxsize, pos);
> +               if (err) {
> +                       erofs_err(
> +                       "I/O error occurred when reading dirents @ nid
> %llu, lblk %u: %d",
> +                       dir.nid | 0ULL, lblk, err);
> +                       break;
> +               }
> +
> +               const unsigned int nameoff = le16_to_cpu(de->nameoff);
> +
> +               if (nameoff < sizeof(struct erofs_dirent) || nameoff >=
> PAGE_SIZE) {
> +                       erofs_err("invalid de[0].nameoff %u @ nid %llu,
> lblk %u",
> +                               nameoff, dir.nid | 0ULL, lblk);
> +                       err = -EFSCORRUPTED;
> +                       break;
> +               }
> +               err = traverse_dirents(
> +                       ctx, params, buf, lblk, nameoff, maxsize,
> params->fsck);
> +               if (err) {
> +                       break;
> +               }
> +               pos += maxsize;
> +       }
> +out:
> +       if (ctx) {
> +               free(ctx);
> +       }
> +       if (buf) {
> +               free(buf);
> +       }
> +       return err;
> +}
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
>

-- 
Sincerely,

Kelvin Zhang

--000000000000a5013605d35ce760
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgR2FvLDxkaXY+wqAgwqAgSSBkcmFmdGVkIGEgbmV3IHBhdGNoc2V0
IG9uIHRvcCBvZiB0aGUgZGV2IGJyYW5jaC4gQ2hhbmdlcyBzaW5jZSB2Njo8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PsKgIMKgIDEuIGJsb2NrIGJ1ZmZlciBtb3ZlZCB0byB0aGUgaGVhcCwgZHVl
IHRvIHN0YWNrIHNpemUgY29uY2VybnMgd2hlbiBpdGVyYXRpbmcgcmVjdXJzaXZlbHk8L2Rpdj48
ZGl2PsKgIMKgIDIuIEFkZGVkIGEgJnF1b3Q7cmVjdXJzaXZlJnF1b3Q7IG9wdGlvbiB0byBpbnB1
dCBwYXJhbWV0ZXJzPC9kaXY+PGRpdj7CoCDCoCAzLiBkbmFtZSBidWZmZXJzIGFyZSBzdGlsbCBv
biB0aGUgaGVhcCwgYnV0IGFsbG9jYXRpb24gaXMgZG9uZSBvbmNlIHBlciBkaXJlY3RvcnksIGlu
c3RlYWQgb2Ygb25jZSBmb3IgZWFjaCBkaXJlY3RvcnkgZW50cnkuPC9kaXY+PGRpdj7CoCDCoCA0
LiBBZGRlZCBhIHZvaWQqIGFyZyB3aGljaCB3aWxsIGJlIGZvcndhcmRlZCB0byB0aGUgY2FsbGJh
Y2sgZnVuY3Rpb24uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHJhbiBzY3JpcHRzLzxhIGhy
ZWY9Imh0dHA6Ly9jaGVja3BhdGNoLnBsIj5jaGVja3BhdGNoLnBsPC9hPiAuIEhvcGVmdWxseSB0
aGlzIG1ha2VzIHlvdXIgbGlmZSBlYXNpZXIuIFRoYW5rcyBmb3IgdGhlIHJlcGx5IS48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBGcmksIERlYyAxNywg
MjAyMSBhdCAyOjQ3IFBNIEtlbHZpbiBaaGFuZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnpoYW5na2Vs
dmluQGdvb2dsZS5jb20iPnpoYW5na2VsdmluQGdvb2dsZS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPlNpZ25lZC1vZmYtYnk6IEtlbHZpbiBaaGFuZyAmbHQ7PGEgaHJlZj0ibWFp
bHRvOnpoYW5na2VsdmluQGdvb2dsZS5jb20iIHRhcmdldD0iX2JsYW5rIj56aGFuZ2tlbHZpbkBn
b29nbGUuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGZ1c2UvTWFrZWZpbGUuYW3CoCDCoCB8
wqAgwqAyICstPGJyPg0KwqBmdXNlL2Rpci5jwqAgwqAgwqAgwqAgwqAgfCAxMDAgLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+DQrCoGZ1c2UvbWFpbi5jwqAgwqAgwqAgwqAgwqB8wqAgNjUgKysrKysr
KysrKystLTxicj4NCsKgaW5jbHVkZS9lcm9mcy9kaXIuaCB8wqAgNTIgKysrKysrKysrKys8YnI+
DQrCoGxpYi9NYWtlZmlsZS5hbcKgIMKgIMKgfMKgIMKgMiArLTxicj4NCsKgbGliL2Rpci5jwqAg
wqAgwqAgwqAgwqAgwqB8IDIyMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKzxicj4NCsKgNiBmaWxlcyBjaGFuZ2VkLCAzMzQgaW5zZXJ0aW9ucygrKSwgMTEwIGRl
bGV0aW9ucygtKTxicj4NCsKgZGVsZXRlIG1vZGUgMTAwNjQ0IGZ1c2UvZGlyLmM8YnI+DQrCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Vyb2ZzL2Rpci5oPGJyPg0KwqBjcmVhdGUgbW9kZSAx
MDA2NDQgbGliL2Rpci5jPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2Z1c2UvTWFrZWZpbGUuYW0g
Yi9mdXNlL01ha2VmaWxlLmFtPGJyPg0KaW5kZXggN2IwMDdmMy4uMGE3OGMwYSAxMDA2NDQ8YnI+
DQotLS0gYS9mdXNlL01ha2VmaWxlLmFtPGJyPg0KKysrIGIvZnVzZS9NYWtlZmlsZS5hbTxicj4N
CkBAIC0yLDcgKzIsNyBAQDxicj4NCjxicj4NCsKgQVVUT01BS0VfT1BUSU9OUyA9IGZvcmVpZ248
YnI+DQrCoGJpbl9QUk9HUkFNU8KgIMKgIMKgPSBlcm9mc2Z1c2U8YnI+DQotZXJvZnNmdXNlX1NP
VVJDRVMgPSBkaXIuYyBtYWluLmM8YnI+DQorZXJvZnNmdXNlX1NPVVJDRVMgPSBtYWluLmM8YnI+
DQrCoGVyb2ZzZnVzZV9DRkxBR1MgPSAtV2FsbCAtV2Vycm9yIC1JJCh0b3Bfc3JjZGlyKS9pbmNs
dWRlPGJyPg0KwqBlcm9mc2Z1c2VfQ0ZMQUdTICs9IC1ERlVTRV9VU0VfVkVSU0lPTj0yNiAke2xp
YmZ1c2VfQ0ZMQUdTfSAke2xpYnNlbGludXhfQ0ZMQUdTfTxicj4NCsKgZXJvZnNmdXNlX0xEQURE
ID0gJCh0b3BfYnVpbGRkaXIpL2xpYi88YSBocmVmPSJodHRwOi8vbGliZXJvZnMubGEiIHJlbD0i
bm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmxpYmVyb2ZzLmxhPC9hPiAke2xpYmZ1c2VfTElC
U30gJHtsaWJsejRfTElCU30gXDxicj4NCmRpZmYgLS1naXQgYS9mdXNlL2Rpci5jIGIvZnVzZS9k
aXIuYzxicj4NCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NDxicj4NCmluZGV4IGJjODczNWIuLjAw
MDAwMDA8YnI+DQotLS0gYS9mdXNlL2Rpci5jPGJyPg0KKysrIC9kZXYvbnVsbDxicj4NCkBAIC0x
LDEwMCArMCwwIEBAPGJyPg0KLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKzxi
cj4NCi0vKjxicj4NCi0gKiBDcmVhdGVkIGJ5IExpIEd1aWZ1ICZsdDs8YSBocmVmPSJtYWlsdG86
Ymx1Y2VybGVlQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmJsdWNlcmxlZUBnbWFpbC5jb208
L2E+Jmd0Ozxicj4NCi0gKi88YnI+DQotI2luY2x1ZGUgJmx0O2Z1c2UuaCZndDs8YnI+DQotI2lu
Y2x1ZGUgJmx0O2Z1c2Vfb3B0LmgmZ3Q7PGJyPg0KLSNpbmNsdWRlICZxdW90O21hY29zeC5oJnF1
b3Q7PGJyPg0KLSNpbmNsdWRlICZxdW90O2Vyb2ZzL2ludGVybmFsLmgmcXVvdDs8YnI+DQotI2lu
Y2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90Ozxicj4NCi08YnI+DQotc3RhdGljIGludCBl
cm9mc19maWxsX2RlbnRyaWVzKHN0cnVjdCBlcm9mc19pbm9kZSAqZGlyLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmdXNlX2ZpbGxfZGlyX3QgZmls
bGVyLCB2b2lkICpidWYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHZvaWQgKmRibGssIHVuc2lnbmVkIGludCBuYW1lb2ZmLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1bnNpZ25lZCBpbnQgbWF4c2l6
ZSk8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19kaXJlbnQgKmRlID0gZGJs
azs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgZXJvZnNfZGlyZW50ICplbmQgPSBkYmxr
ICsgbmFtZW9mZjs8YnI+DQotwqAgwqAgwqAgwqBjaGFyIG5hbWVidWZbRVJPRlNfTkFNRV9MRU4g
KyAxXTs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgd2hpbGUgKGRlICZsdDsgZW5kKSB7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqZGVfbmFtZTs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgZGVfbmFtZWxlbjs8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9IGxlMTZfdG9fY3B1KGRlLSZndDtuYW1lb2Zm
KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1lID0gKGNoYXIgKilkYmxrICsg
bmFtZW9mZjs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogdGhlIGxhc3Qg
ZGlyZW50IGluIHRoZSBibG9jaz8gKi88YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
ZGUgKyAxICZndDs9IGVuZCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBkZV9uYW1lbGVuID0gc3RybmxlbihkZV9uYW1lLCBtYXhzaXplIC0gbmFtZW9mZik7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRlX25hbWVsZW4gPSBsZTE2X3RvX2NwdShkZVsxXS5uYW1lb2ZmKSAtIG5h
bWVvZmY7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGEgY29ycnVwdGVk
IGVudHJ5IGlzIGZvdW5kICovPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG5hbWVv
ZmYgKyBkZV9uYW1lbGVuICZndDsgbWF4c2l6ZSB8fDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRlX25hbWVsZW4gJmd0OyBFUk9GU19OQU1FX0xFTikgezxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyb2ZzX2VycigmcXVvdDtib2d1cyBkaXJlbnQg
QCBuaWQgJWxsdSZxdW90OywgZGlyLSZndDtuaWQgfCAwVUxMKTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQkdfQlVHT04oMSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FRlNDT1JSVVBURUQ7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1j
cHkobmFtZWJ1ZiwgZGVfbmFtZSwgZGVfbmFtZWxlbik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgbmFtZWJ1ZltkZV9uYW1lbGVuXSA9ICYjMzk7XDAmIzM5Ozs8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsbGVyKGJ1ZiwgbmFtZWJ1ZiwgTlVMTCwgMCk7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKytkZTs8YnI+DQotwqAgwqAgwqAgwqB9PGJyPg0KLcKg
IMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KLX08YnI+DQotPGJyPg0KLWludCBlcm9mc2Z1c2VfcmVh
ZGRpcihjb25zdCBjaGFyICpwYXRoLCB2b2lkICpidWYsIGZ1c2VfZmlsbF9kaXJfdCBmaWxsZXIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2ZmX3Qgb2Zmc2V0LCBzdHJ1
Y3QgZnVzZV9maWxlX2luZm8gKmZpKTxicj4NCi17PGJyPg0KLcKgIMKgIMKgIMKgaW50IHJldDs8
YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGUgZGlyOzxicj4NCi3CoCDCoCDCoCDC
oGNoYXIgZGJsa1tFUk9GU19CTEtTSVpdOzxicj4NCi3CoCDCoCDCoCDCoGVyb2ZzX29mZl90IHBv
czs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZXJvZnNfZGJnKCZxdW90O3JlYWRkaXI6JXMgb2Zm
c2V0PSVsbHUmcXVvdDssIHBhdGgsIChsb25nIGxvbmcpb2Zmc2V0KTs8YnI+DQotPGJyPg0KLcKg
IMKgIMKgIMKgcmV0ID0gZXJvZnNfaWxvb2t1cChwYXRoLCAmYW1wO2Rpcik7PGJyPg0KLcKgIMKg
IMKgIMKgaWYgKHJldCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxi
cj4NCi08YnI+DQotwqAgwqAgwqAgwqBlcm9mc19kYmcoJnF1b3Q7cGF0aD0lcyBuaWQgPSAlbGx1
JnF1b3Q7LCBwYXRoLCBkaXIubmlkIHwgMFVMTCk7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGlm
ICghU19JU0RJUihkaXIuaV9tb2RlKSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLUVOT1RESVI7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoGlmICghZGlyLmlfc2l6ZSk8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQotPGJyPg0KLcKgIMKgIMKg
IMKgcG9zID0gMDs8YnI+DQotwqAgwqAgwqAgwqB3aGlsZSAocG9zICZsdDsgZGlyLmlfc2l6ZSkg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBuYW1lb2ZmLCBtYXhz
aXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19kaXJlbnQgKmRl
Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXhzaXplID0gbWluX3QodW5z
aWduZWQgaW50LCBFUk9GU19CTEtTSVosPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlyLmlfc2l6ZSAtIHBvcyk7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gZXJvZnNfcHJlYWQoJmFtcDtkaXIsIGRibGssIG1heHNpemUsIHBv
cyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCi08YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkZSA9IChzdHJ1Y3QgZXJvZnNfZGlyZW50ICopZGJsazs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuYW1lb2ZmID0gbGUxNl90b19jcHUoZGUtJmd0O25hbWVv
ZmYpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChuYW1lb2ZmICZsdDsgc2l6ZW9m
KHN0cnVjdCBlcm9mc19kaXJlbnQpIHx8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgbmFtZW9mZiAmZ3Q7PSBQQUdFX1NJWkUpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1b3Q7aW52YWxpZCBkZVswXS5uYW1lb2ZmICV1IEAg
bmlkICVsbHUmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgbmFtZW9mZiwgZGlyLm5pZCB8IDBVTEwpOzxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1FRlNDT1JSVVBURUQ7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBlcm9m
c19maWxsX2RlbnRyaWVzKCZhbXA7ZGlyLCBmaWxsZXIsIGJ1Ziw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkYmxrLCBu
YW1lb2ZmLCBtYXhzaXplKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KTxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHBvcyArPSBtYXhzaXplOzxicj4NCi3CoCDCoCDCoCDCoH08YnI+
DQotwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQotfTxicj4NCmRpZmYgLS1naXQgYS9mdXNlL21h
aW4uYyBiL2Z1c2UvbWFpbi5jPGJyPg0KaW5kZXggMjU1OTY1ZS4uNTNkYmRkNCAxMDA2NDQ8YnI+
DQotLS0gYS9mdXNlL21haW4uYzxicj4NCisrKyBiL2Z1c2UvbWFpbi5jPGJyPg0KQEAgLTEyLDkg
KzEyLDU4IEBAPGJyPg0KwqAjaW5jbHVkZSAmcXVvdDtlcm9mcy9jb25maWcuaCZxdW90Ozxicj4N
CsKgI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1
b3Q7ZXJvZnMvaW8uaCZxdW90Ozxicj4NCisjaW5jbHVkZSAmcXVvdDtlcm9mcy9kaXIuaCZxdW90
Ozxicj4NCjxicj4NCi1pbnQgZXJvZnNmdXNlX3JlYWRkaXIoY29uc3QgY2hhciAqcGF0aCwgdm9p
ZCAqYnVmZmVyLCBmdXNlX2ZpbGxfZGlyX3QgZmlsbGVyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG9mZl90IG9mZnNldCwgc3RydWN0IGZ1c2VfZmlsZV9pbmZvICpmaSk7
PGJyPg0KK3N0cnVjdCBlcm9mc2Z1c2VfZGlyX2NvbnRleHQgezxicj4NCivCoCDCoCDCoCDCoGZ1
c2VfZmlsbF9kaXJfdCBmaWxsZXI7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGZ1c2VfZmlsZV9p
bmZvICpmaTs8YnI+DQorwqAgwqAgwqAgwqB2b2lkICpidWY7PGJyPg0KK307PGJyPg0KKzxicj4N
CitzdGF0aWMgaW50IGVyb2ZzZnVzZV9maWxsX2RlbnRyaWVzKHN0cnVjdCBlcm9mc19kaXJlbnRf
aW5mbyAqY3R4KTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGVyb2ZzZnVzZV9kaXJf
Y29udGV4dCAqZnVzZWN0eCA9IGN0eC0mZ3Q7YXJnOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBm
dXNlY3R4LSZndDtmaWxsZXIoZnVzZWN0eC0mZ3Q7YnVmLCBjdHgtJmd0O2RuYW1lLCBOVUxMLCAw
KTs8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorfTxicj4NCis8YnI+DQoraW50IGVy
b2ZzZnVzZV9yZWFkZGlyKGNvbnN0IGNoYXIgKnBhdGgsIHZvaWQgKmJ1ZiwgZnVzZV9maWxsX2Rp
cl90IGZpbGxlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZmZfdCBv
ZmZzZXQsIHN0cnVjdCBmdXNlX2ZpbGVfaW5mbyAqZmkpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAg
wqBpbnQgcmV0Ozxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19pbm9kZSBkaXI7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGVyb2ZzX2RiZygmcXVvdDtyZWFkZGlyOiVzIG9mZnNldD0lbGx1
JnF1b3Q7LCBwYXRoLCAobG9uZyBsb25nKW9mZnNldCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oHJldCA9IGVyb2ZzX2lsb29rdXAocGF0aCwgJmFtcDtkaXIpOzxicj4NCivCoCDCoCDCoCDCoGlm
IChyZXQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgZXJvZnNfZGJnKCZxdW90O3BhdGg9JXMgbmlkID0gJWxsdSZxdW90Oywg
cGF0aCwgZGlyLm5pZCB8IDBVTEwpOzxicj4NCivCoCDCoCDCoCDCoGlmICghU19JU0RJUihkaXIu
aV9tb2RlKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT1RESVI7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghZGlyLmlfc2l6ZSk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNmdXNlX2Rp
cl9jb250ZXh0IGN0eCA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZmlsbGVyID0g
ZmlsbGVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5maSA9IGZpLDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC5idWYgPSBidWYsPGJyPg0KK8KgIMKgIMKgIMKgfTs8YnI+DQor
wqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaXRlcmF0ZV9kaXJfcGFyYW0gcGFyYW0gPSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmNiID0gZXJvZnNmdXNlX2ZpbGxfZGVudHJpZXMsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmZzY2sgPSBmYWxzZSw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAubmlkID0gZGlyLm5pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAucmVjdXJzaXZlID0gZmFsc2UsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmFyZyA9
ICZhbXA7Y3R4LDxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KKyNpZm5kZWYgTkRFQlVHPGJyPg0K
K8KgIMKgIMKgIMKgcGFyYW0uZnNjayA9IHRydWU7PGJyPg0KKyNlbmRpZjxicj4NCivCoCDCoCDC
oCDCoHJldHVybiBlcm9mc19pdGVyYXRlX2RpcigmYW1wO3BhcmFtKTs8YnI+DQorPGJyPg0KK308
YnI+DQo8YnI+DQrCoHN0YXRpYyB2b2lkICplcm9mc2Z1c2VfaW5pdChzdHJ1Y3QgZnVzZV9jb25u
X2luZm8gKmluZm8pPGJyPg0KwqB7PGJyPg0KQEAgLTEyMiwxMyArMTcxLDEzIEBAIHN0YXRpYyB2
b2lkIHVzYWdlKHZvaWQpPGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGZ1c2VfYXJncyBhcmdzID0g
RlVTRV9BUkdTX0lOSVQoMCwgTlVMTCk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgZnB1dHMoJnF1
b3Q7dXNhZ2U6IFtvcHRpb25zXSBJTUFHRSBNT1VOVFBPSU5UXG5cbiZxdW90Ozxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCZxdW90O09wdGlvbnM6XG4mcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAmcXVvdDvCoCDCoCAtLWRiZ2xldmVsPSPCoCDCoCDCoCDCoCDCoCDCoHNldCBvdXRw
dXQgbWVzc2FnZSBsZXZlbCB0byAjIChtYXhpbXVtIDkpXG4mcXVvdDs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAmcXVvdDvCoCDCoCAtLWRldmljZT0jwqAgwqAgwqAgwqAgwqAgwqAgwqBzcGVj
aWZ5IGFuIGV4dHJhIGRldmljZSB0byBiZSB1c2VkIHRvZ2V0aGVyXG4mcXVvdDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtPcHRpb25zOlxuJnF1b3Q7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7wqAgwqAgLS1kYmdsZXZlbD0jwqAgwqAgwqAgwqAg
wqAgwqBzZXQgb3V0cHV0IG1lc3NhZ2UgbGV2ZWwgdG8gIyAobWF4aW11bSA5KVxuJnF1b3Q7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7wqAgwqAgLS1kZXZpY2U9I8KgIMKg
IMKgIMKgIMKgIMKgIMKgc3BlY2lmeSBhbiBleHRyYSBkZXZpY2UgdG8gYmUgdXNlZCB0b2dldGhl
clxuJnF1b3Q7PGJyPg0KwqAjaWYgRlVTRV9NQUpPUl9WRVJTSU9OICZsdDsgMzxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCZxdW90O8KgIMKgIC0taGVscMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZGlzcGxheSB0aGlzIGhlbHAgYW5kIGV4aXRcbiZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCZxdW90O8KgIMKgIC0taGVscMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZGlzcGxheSB0aGlzIGhlbHAgYW5kIGV4aXRcbiZxdW90Ozxicj4NCsKgI2VuZGlmPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7XG4mcXVvdDssIHN0ZGVycik7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7XG4mcXVvdDssIHN0ZGVycik7PGJyPg0KPGJyPg0KwqAj
aWYgRlVTRV9NQUpPUl9WRVJTSU9OICZndDs9IDM8YnI+DQrCoCDCoCDCoCDCoCBmdXNlX2NtZGxp
bmVfaGVscCgpOzxicj4NCkBAIC0xNDgsNyArMTk3LDcgQEAgc3RhdGljIHZvaWQgZXJvZnNmdXNl
X2R1bXBjZmcodm9pZCk8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHN0YXRpYyBpbnQgb3B0aW9uYWxf
b3B0X2Z1bmModm9pZCAqZGF0YSwgY29uc3QgY2hhciAqYXJnLCBpbnQga2V5LDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgZnVzZV9hcmdzICpv
dXRhcmdzKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzdHJ1Y3QgZnVzZV9hcmdzICpvdXRhcmdzKTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKg
IGludCByZXQ7PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXJvZnMvZGlyLmggYi9p
bmNsdWRlL2Vyb2ZzL2Rpci5oPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAw
MDAwMDAwLi5hZmZiNjA3PGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBiL2luY2x1ZGUvZXJv
ZnMvZGlyLmg8YnI+DQpAQCAtMCwwICsxLDUyIEBAPGJyPg0KKy8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wKyBPUiBBcGFjaGUtMi4wICovPGJyPg0KKyNpZm5kZWYgX19FUk9GU19E
SVJfSDxicj4NCisjZGVmaW5lIF9fRVJPRlNfRElSX0g8YnI+DQorPGJyPg0KKyNpZmRlZiBfX2Nw
bHVzcGx1czxicj4NCitleHRlcm4gJnF1b3Q7QyZxdW90Ozxicj4NCit7PGJyPg0KKyNlbmRpZjxi
cj4NCis8YnI+DQorI2luY2x1ZGUgJnF1b3Q7aW50ZXJuYWwuaCZxdW90Ozxicj4NCis8YnI+DQor
c3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0Ozxicj4NCis8YnI+DQorc3RydWN0IGVyb2ZzX2RpcmVu
dF9pbmZvIHs8YnI+DQorwqAgwqAgwqAgwqAvKiBpbm9kZSBpZCBvZiB0aGUgaW5vZGUgYmVpbmcg
aXRlcmF0ZWQgKi88YnI+DQorwqAgwqAgwqAgwqBlcm9mc19uaWRfdCBuaWQ7PGJyPg0KK8KgIMKg
IMKgIMKgLyogZmlsZSB0eXBlLCBzZWUgdmFsdWVzIGJlZm9yZSBFUk9GU19GVF9NQVggKi88YnI+
DQorwqAgwqAgwqAgwqB1OCBmdHlwZTs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBjaGFyICpkbmFt
ZTs8YnI+DQorwqAgwqAgwqAgwqAvKiBvcGFxdWUgcHRyIHBhc3NlZCBpbiBlcm9mc19pdGVyYXRl
X2Rpcl9wYXJhbSw8YnI+DQorwqAgwqAgwqAgwqAgKiBjYW4gYmUgdXNlZCB0byBwZXJzaXN0IHN0
YXRlIGFjcm9zcyBtdWx0aXBsZTxicj4NCivCoCDCoCDCoCDCoCAqIGNhbGxiYWNrcy48YnI+DQor
wqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqB2b2lkICphcmc7PGJyPg0KK307PGJyPg0K
Kzxicj4NCisvKiBjYWxsYmFjayBmdW5jdGlvbiBmb3IgaXRlcmF0aW5nIG92ZXIgaW5vZGVzIG9m
IEVST0ZTICovPGJyPg0KK3R5cGVkZWYgaW50ICgqZXJvZnNfcmVhZGRpcl9jYikoc3RydWN0IGVy
b2ZzX2RpcmVudF9pbmZvICopOzxicj4NCis8YnI+DQorLyogY2FsbGVycyBjb3VsZCB1c2UgYSB3
cmFwcGVyIHRvIGNvbnRhaW4gZXh0cmEgaW5mb3JtYXRpb24gKi88YnI+DQorc3RydWN0IGVyb2Zz
X2l0ZXJhdGVfZGlyX3BhcmFtIHs8YnI+DQorwqAgwqAgwqAgwqAvKiBpbm9kZSBpZCBvZiB0aGUg
ZGlyZWN0b3J5IHRoYXQgbmVlZHMgdG8gYmUgaXRlcmF0ZWQuICovPGJyPg0KK8KgIMKgIMKgIMKg
LyogVXNlIHNiaS5yb290X25pZCBpZiB5b3Ugd2FudCB0byBpdGVyYXRlIG92ZXIgcm9vZCBkaXIg
Ki88YnI+DQorwqAgwqAgwqAgwqBlcm9mc19uaWRfdCBuaWQ7PGJyPg0KK8KgIMKgIMKgIMKgYm9v
bCBmc2NrO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFdoZXRoZXIgdG8gcGVy
Zm9ybSB2YWxpZGl0eSBjaGVjayAqLzxicj4NCivCoCDCoCDCoCDCoGVyb2ZzX25pZF90IHBuaWQ7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBvcHRpb25hbCwgbmVlZGVkIGlmIGZzY2sgPSB0cnVl
ICovPGJyPg0KK8KgIMKgIMKgIMKgZXJvZnNfcmVhZGRpcl9jYiBjYjs8YnI+DQorwqAgwqAgwqAg
wqAvKiBXaGV0aGVyIHRvIGl0ZXJhdGUgdGhpcyBkaXJlY3RvcnkgcmVjdXJzaXZlbHkgKi88YnI+
DQorwqAgwqAgwqAgwqBib29sIHJlY3Vyc2l2ZTs8YnI+DQorwqAgwqAgwqAgwqAvKiBUaGlzIHdp
bGwgYmUgY29waWVkIHRvIGVyb2ZzX2RpcmVudF9pbmZvLmFyZyB3aGVuIGludm9raW5nIGNhbGxi
YWNrICovPGJyPg0KK8KgIMKgIMKgIMKgdm9pZCAqYXJnOzxicj4NCit9Ozxicj4NCis8YnI+DQor
LyogaXRlcmF0ZSBvdmVyIGlub2RlcyB0aGF0IGFyZSBpbiBkaXJlY3RvcnkgKi88YnI+DQoraW50
IGVyb2ZzX2l0ZXJhdGVfZGlyKGNvbnN0IHN0cnVjdCBlcm9mc19pdGVyYXRlX2Rpcl9wYXJhbSAq
Y3R4KTs8YnI+DQorPGJyPg0KKzxicj4NCisjaWZkZWYgX19jcGx1c3BsdXM8YnI+DQorfTxicj4N
CisjZW5kaWY8YnI+DQorPGJyPg0KKyNlbmRpZjxicj4NCmRpZmYgLS1naXQgYS9saWIvTWFrZWZp
bGUuYW0gYi9saWIvTWFrZWZpbGUuYW08YnI+DQppbmRleCA2N2JhNzk4Li4yNWE0YTJiIDEwMDY0
NDxicj4NCi0tLSBhL2xpYi9NYWtlZmlsZS5hbTxicj4NCisrKyBiL2xpYi9NYWtlZmlsZS5hbTxi
cj4NCkBAIC0yNyw3ICsyNyw3IEBAIG5vaW5zdF9IRUFERVJTID0gJCh0b3Bfc3JjZGlyKS9pbmNs
dWRlL2Vyb2ZzX2ZzLmggXDxicj4NCsKgbm9pbnN0X0hFQURFUlMgKz0gY29tcHJlc3Nvci5oPGJy
Pg0KwqBsaWJlcm9mc19sYV9TT1VSQ0VTID0gY29uZmlnLmMgaW8uYyBjYWNoZS5jIHN1cGVyLmMg
aW5vZGUuYyB4YXR0ci5jIGV4Y2x1ZGUuYyBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgbmFtZWkuYyBkYXRhLmMgY29tcHJlc3MuYyBjb21wcmVzc29yLmMgem1hcC5jIGRl
Y29tcHJlc3MuYyBcPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcHJl
c3NfaGludHMuYyBoYXNobWFwLmMgc2hhMjU2LmMgYmxvYmNodW5rLmM8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb21wcmVzc19oaW50cy5jIGhhc2htYXAuYyBzaGEyNTYu
YyBibG9iY2h1bmsuYyBkaXIuYzxicj4NCsKgbGliZXJvZnNfbGFfQ0ZMQUdTID0gLVdhbGwgLVdl
cnJvciAtSSQodG9wX3NyY2RpcikvaW5jbHVkZTxicj4NCsKgaWYgRU5BQkxFX0xaNDxicj4NCsKg
bGliZXJvZnNfbGFfQ0ZMQUdTICs9ICR7TFo0X0NGTEFHU308YnI+DQpkaWZmIC0tZ2l0IGEvbGli
L2Rpci5jIGIvbGliL2Rpci5jPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAw
MDAwMDAwLi4wNGE0NTk2PGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBiL2xpYi9kaXIuYzxi
cj4NCkBAIC0wLDAgKzEsMjIzIEBAPGJyPg0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wKyBPUiBBcGFjaGUtMi4wPGJyPg0KKyNpbmNsdWRlICZxdW90O2Vyb2ZzL2Rpci5oJnF1
b3Q7PGJyPg0KKzxicj4NCisjaW5jbHVkZSAmbHQ7bGludXgvbGltaXRzLmgmZ3Q7PGJyPg0KKyNp
bmNsdWRlICZsdDtzdGRsaWIuaCZndDs8YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2Vyb2Zz
L2ludGVybmFsLmgmcXVvdDs8YnI+DQorI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90
Ozxicj4NCis8YnI+DQorc3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0IHs8YnI+DQorwqAgwqAgwqAg
wqBlcm9mc19uaWRfdCBwbmlkO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogb3B0aW9uYWwgKi88
YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGUgKmRpcjs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgYm9vbCBkb3RfZm91bmQ7PGJyPg0KK8KgIMKgIMKgIMKgYm9vbCBkb3RfZG90X2Zv
dW5kOzxicj4NCivCoCDCoCDCoCDCoGNoYXIgY3VyX25hbWVbUEFUSF9NQVhdOzxicj4NCivCoCDC
oCDCoCDCoGNoYXIgcHJldl9uYW1lW1BBVEhfTUFYXTs8YnI+DQorfTs8YnI+DQorPGJyPg0KKzxi
cj4NCitzdGF0aWMgaW50IHRyYXZlcnNlX2RpcmVudHMoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0ICpjdHgsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY29uc3Qgc3RydWN0IGVyb2ZzX2l0ZXJhdGVfZGlyX3BhcmFtICpwYXJhbXMsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgdm9pZCAqZGVudHJ5X2Jsayw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbGJsaywgdW5zaWduZWQgaW50IG5l
eHRfbmFtZW9mZiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbWF4
c2l6ZSwgYm9vbCBmc2NrKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGVy
b2ZzX2RpcmVudCAqZGUgPSBkZW50cnlfYmxrOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHN0cnVj
dCBlcm9mc19kaXJlbnQgKmVuZCA9IGRlbnRyeV9ibGsgKyBuZXh0X25hbWVvZmY7PGJyPg0KK8Kg
IMKgIMKgIMKgY2hhciAqcHJldl9uYW1lID0gY3R4LSZndDtwcmV2X25hbWU7PGJyPg0KK8KgIMKg
IMKgIMKgY2hhciAqY3VyX25hbWUgPSBjdHgtJmd0O2N1cl9uYW1lOzxicj4NCivCoCDCoCDCoCDC
oGNvbnN0IGNoYXIgKmVycm1zZzs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcmV0ID0gMDs8YnI+DQor
wqAgwqAgwqAgwqBib29sIHNpbGVudCA9IGZhbHNlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqB3
aGlsZSAoZGUgJmx0OyBlbmQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25l
ZCBpbnQgZGVfbmFtZWxlbjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBp
bnQgbmFtZW9mZjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9
IGxlMTZfdG9fY3B1KGRlLSZndDtuYW1lb2ZmKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBjb25zdCBjaGFyICpkZV9uYW1lID0gKGNoYXIgKilkZW50cnlfYmxrICsgbmFtZW9mZjs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogdGhlIGxhc3QgZGlyZW50IGNoZWNr
ICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRlICsgMSAmZ3Q7PSBlbmQpPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVfbmFtZWxlbiA9IHN0cm5s
ZW4oZGVfbmFtZSwgbWF4c2l6ZSAtIG5hbWVvZmYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVsc2U8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1l
bGVuID0gbGUxNl90b19jcHUoZGVbMV0ubmFtZW9mZikgLSBuYW1lb2ZmOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJuY3B5KGN1cl9uYW1lLCBkZV9uYW1lLCBkZV9uYW1l
bGVuKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdXJfbmFtZVtkZV9uYW1lbGVuXSA9
ICYjMzk7XDAmIzM5Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWN1cl9uYW1l
KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybXNnID0gJnF1
b3Q7ZmFpbGVkIHRvIGFsbG9jYXRlIGRpcmVudCBuYW1lJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1FTk9NRU07PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19kYmcoJnF1b3Q7
dHJhdmVyc2VkIGZpbGVuYW1lKCVzKSZxdW90OywgY3VyX25hbWUpOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSAtRUZTQ09SUlVQVEVEOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC8qIGNvcnJ1cHRlZCBlbnRyeSBjaGVjayAqLzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlmIChuYW1lb2ZmICE9IG5leHRfbmFtZW9mZikgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm1zZyA9ICZxdW90O2JvZ3VzIGRpcmVudCBu
YW1lb2ZmJnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKG5hbWVvZmYgKyBkZV9uYW1lbGVuICZndDsgbWF4c2l6ZSB8fCBk
ZV9uYW1lbGVuICZndDsgRVJPRlNfTkFNRV9MRU4pIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVvdDtib2d1cyBkaXJlbnQgbmFtZWxlbiZxdW90
Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChmc2NrICZhbXA7JmFtcDsgcHJldl9uYW1lICZhbXA7JmFtcDsgc3RyY21wKHByZXZf
bmFtZSwgY3VyX25hbWUpICZndDs9IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVvdDt3cm9uZyBkaXJlbnQgbmFtZSBvcmRlciZxdW90Ozs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChmc2NrICZhbXA7JmFtcDsgZGUtJmd0O2ZpbGVfdHlwZSAmZ3Q7PSBFUk9GU19GVF9NQVgp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVv
dDtpbnZhbGlkIGZpbGUgdHlwZSAldSZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGJvb2wgZG90X2RvdGRvdCA9IGlz
X2RvdF9kb3Rkb3QoY3VyX25hbWUpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoZG90X2RvdGRvdCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHN3aXRjaCAoZGVfbmFtZWxlbikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgMjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoZnNjayAmYW1wOyZhbXA7IGN0eC0mZ3Q7ZG90X2RvdF9mb3VuZCkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVycm1zZyA9ICZxdW90O2R1cGxpY2F0ZWQgYC4uJiMzOTsgZGlyZW50JnF1b3Q7
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjdHgtJmd0O2RvdF9kb3RfZm91bmQgPSB0cnVlOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzYmkucm9vdF9uaWQg
PT0gY3R4LSZndDtkaXItJmd0O25pZCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0eC0mZ3Q7cG5pZCA9IHNiaS5yb290
X25pZDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoZnNjayAmYW1wOyZhbXA7IGRlLSZndDtuaWQgIT0gY3R4LSZndDtw
bmlkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybXNnID0gJnF1b3Q7Y29ycnVwdGVkIGAuLiYj
Mzk7IGRpcmVudCZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFr
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgMTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZnNjayAm
YW1wOyZhbXA7IGN0eC0mZ3Q7ZG90X2ZvdW5kKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybXNnID0gJnF1b3Q7ZHVw
bGljYXRlZCBgLiYjMzk7IGRpcmVudCZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0eC0mZ3Q7
ZG90X2ZvdW5kID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoZnNjayAmYW1wOyZhbXA7IGRlLSZndDtuaWQgIT0gY3R4LSZndDtk
aXItJmd0O25pZCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm1zZyA9ICZxdW90O2NvcnJ1cHRlZCBgLiYjMzk7IGRp
cmVudCZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG91dDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfZGlyZW50X2luZm8gb3V0cHV0X2luZm8g
PSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmZ0eXBlID0gZGUt
Jmd0O2ZpbGVfdHlwZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAu
bmlkID0gZGUtJmd0O25pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuYXJnID0gcGFyYW1zLSZndDthcmcsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLmRuYW1lID0gY3VyX25hbWV9Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXQgPSBwYXJhbXMtJmd0O2NiKCZhbXA7b3V0cHV0X2luZm8pOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzaWxlbnQgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocGFyYW1zLSZndDtyZWN1cnNpdmUgJmFtcDsm
YW1wOyBkZS0mZ3Q7ZmlsZV90eXBlID09IEVST0ZTX0ZUX0RJUiAmYW1wOyZhbXA7ICFkb3RfZG90
ZG90KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3Ry
dWN0IGVyb2ZzX2l0ZXJhdGVfZGlyX3BhcmFtIHJlY3Vyc2l2ZV9wYXJhbSA9IHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubmlkID0gZGUtJmd0
O25pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAuZnNjayA9IHBhcmFtcy0mZ3Q7ZnNjayw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAucG5pZCA9IHBhcmFtcy0mZ3Q7bmlkLDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5jYiA9IHBhcmFtcy0m
Z3Q7Y2IsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLnJlY3Vyc2l2ZSA9IHBhcmFtcy0mZ3Q7cmVjdXJzaXZlLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5hcmcgPSBwYXJhbXMtJmd0O2FyZ307
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfaXRlcmF0ZV9k
aXIoJmFtcDtyZWN1cnNpdmVfcGFyYW0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmV4dF9uYW1lb2ZmICs9IGRlX25h
bWVsZW47PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKytkZTs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcHJldl9uYW1lID0gY3VyX25hbWU7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY3VyX25hbWUgPSBwcmV2X25hbWUgPT0gY3R4LSZndDtwcmV2X25hbWUg
PyBjdHgtJmd0O2N1cl9uYW1lIDogY3R4LSZndDtwcmV2X25hbWU7PGJyPg0KK8KgIMKgIMKgIMKg
fTxicj4NCivCoCDCoCDCoCDCoGlmIChmc2NrICZhbXA7JmFtcDsgKCFjdHgtJmd0O2RvdF9mb3Vu
ZCB8fCAhY3R4LSZndDtkb3RfZG90X2ZvdW5kKSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVyb2ZzX2VycigmcXVvdDtgLiYjMzk7IG9yIGAuLiYjMzk7IGRpcmVudCBpcyBtaXNzaW5n
IEAgbmlkICVsbHUmcXVvdDssIGRlLSZndDtuaWQgfCAwVUxMKTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gLUVGU0NPUlJVUFRFRDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0K
K291dDo8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0ICZhbXA7JmFtcDsgIXNpbGVudCk8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1b3Q7JXMgQCBuaWQgJWxsdSwgbGJs
ayAldSwgaW5kZXggJWx1JnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGVycm1zZywgY3R4LSZndDtkaXItJmd0O25pZCB8IDBVTEwsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGJsaywgKGRlIC0gKHN0cnVjdCBlcm9mc19kaXJl
bnQgKilkZW50cnlfYmxrKSB8IDBVTCk7PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+
DQorfTxicj4NCis8YnI+DQoraW50IGVyb2ZzX2l0ZXJhdGVfZGlyKGNvbnN0IHN0cnVjdCBlcm9m
c19pdGVyYXRlX2Rpcl9wYXJhbSAqcGFyYW1zKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50
IGVycjs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGUgZGlyOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBkaXIubmlkID0gcGFyYW1zLSZndDtuaWQ7PGJyPg0KK8KgIMKgIMKgIMKg
ZXJyID0gZXJvZnNfcmVhZF9pbm9kZV9mcm9tX2Rpc2soJmFtcDtkaXIpOzxicj4NCivCoCDCoCDC
oCDCoGlmIChlcnIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZXJyOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqBpZiAoKGRpci5pX21vZGUgJmFtcDsg
U19JRk1UKSAhPSBTX0lGRElSKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IC1FTk9URElSOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3Ry
dWN0IGVyb2ZzX2RpcmVudF9pbmZvIG91dHB1dF9pbmZvOzxicj4NCivCoCDCoCDCoCDCoC8qIEJv
dGggfGJ1ZnwgYW5kIHxjdHh8IGNhbiBsaXZlIG9uIHRoZSBzdGFjaywgYnV0IHRoYXQgbWlnaHQg
Y2F1c2U8YnI+DQorwqAgwqAgwqAgwqAgKiBzdGFjayBvdmVyZmxvdyB3aGVuIGl0ZXJhdGluZyBy
ZWN1cnNpdmVseS4gU28gcHV0IHRoZW0gb24gaGVhcC48YnI+DQorwqAgwqAgwqAgwqAgKi88YnI+
DQorwqAgwqAgwqAgwqBjaGFyICpidWYgPSBjYWxsb2MoRVJPRlNfQkxLU0laLCAxKTs8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgaWYgKGJ1ZiA9PSBOVUxMKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ290byBvdXQ7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBlcm9mc19kaXJfY29udGV4dCAqY3R4ID0gY2FsbG9jKHNpemVvZihzdHJ1Y3QgZXJvZnNf
ZGlyX2NvbnRleHQpLCAxKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGN0eCA9PSBOVUxM
KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBvdXQ7PGJyPg0KK8KgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoGN0eC0mZ3Q7ZGlyID0gJmFtcDtkaXI7PGJyPg0KK8KgIMKg
IMKgIMKgY3R4LSZndDtwbmlkID0gcGFyYW1zLSZndDtwbmlkOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBlcm9mc19vZmZfdCBwb3MgPSAwOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqB3aGlsZSAo
cG9zICZsdDsgZGlyLmlfc2l6ZSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0
IGVyb2ZzX2Jsa190IGxibGsgPSBlcm9mc19ibGtucihwb3MpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNvbnN0IGVyb2ZzX29mZl90IG1heHNpemUgPTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1pbl90KGVyb2ZzX29mZl90LCBkaXIuaV9zaXplIC0gcG9z
LCBFUk9GU19CTEtTSVopOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVj
dCBlcm9mc19kaXJlbnQgKmRlID0gKGNvbnN0IHZvaWQgKilidWY7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IGVyb2ZzX3ByZWFkKCZhbXA7ZGlyLCBidWYsIG1heHNp
emUsIHBvcyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVycikgezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyb2ZzX2Vycig8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDtJL08gZXJyb3Igb2NjdXJyZWQgd2hl
biByZWFkaW5nIGRpcmVudHMgQCBuaWQgJWxsdSwgbGJsayAldTogJWQmcXVvdDssPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlyLm5pZCB8IDBVTEwsIGxibGssIGVy
cik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb25zdCB1bnNpZ25lZCBpbnQgbmFtZW9mZiA9IGxlMTZfdG9fY3B1KGRlLSZndDtuYW1l
b2ZmKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG5hbWVvZmYgJmx0
OyBzaXplb2Yoc3RydWN0IGVyb2ZzX2RpcmVudCkgfHwgbmFtZW9mZiAmZ3Q7PSBQQUdFX1NJWkUp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1
b3Q7aW52YWxpZCBkZVswXS5uYW1lb2ZmICV1IEAgbmlkICVsbHUsIGxibGsgJXUmcXVvdDssPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9m
ZiwgZGlyLm5pZCB8IDBVTEwsIGxibGspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGVyciA9IC1FRlNDT1JSVVBURUQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IHRyYXZlcnNlX2RpcmVudHMoPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY3R4LCBwYXJhbXMsIGJ1ZiwgbGJsaywg
bmFtZW9mZiwgbWF4c2l6ZSwgcGFyYW1zLSZndDtmc2NrKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAoZXJyKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHBvcyArPSBtYXhzaXplOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorb3V0
Ojxicj4NCivCoCDCoCDCoCDCoGlmIChjdHgpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBmcmVlKGN0eCk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGlmIChidWYp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlKGJ1Zik7PGJyPg0KK8KgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoHJldHVybiBlcnI7PGJyPg0KK308YnI+DQotLSA8YnI+DQoy
LjM0LjEuMTczLmc3NmFhOGJjMmQwLWdvb2c8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+
PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFz
cz0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj5TaW5jZXJlbHksPGRpdj48YnI+PC9k
aXY+PGRpdj5LZWx2aW4gWmhhbmc8L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000a5013605d35ce760--
