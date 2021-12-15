Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F967475FE3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 18:53:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDjXh0r0sz2ywm
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 04:53:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639590820;
	bh=qeyyI5GM0q7yA6BrwYpvKeA2Cnnu7l+noBsNQ2e9ClM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HL/uVcChQR82bDUqDcDa1JFJ5pAanAxWmLOZ+OAJP8JEwXi4ds47/4v7MVWnrfUiJ
	 7yeQ5DUYWrqqApaKX3PXLbjRe2EkRlh3CjDHsm0v2J4OTwQDpdBq5IdLFlsRfmkVuM
	 3nIJb8a9R9+YX7VRLwcsZUu7KFXN75z9Eym4OgCvyaQGZ26BL+XvkxqzTvwxPb6ein
	 Wce7wyUzafciVIAySHlbqNEmxzJcJXkuRX391j4Kr0fDSYVnGPC4WUWNuAc0pZRmLA
	 v14EK3EMfaLUwjLLX/owSIUTaGNw4+btlsXRfHrQYn8PG+aE2XZ6ilhncu7mu/93H+
	 VIJ+wDSMM+6IQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::72d;
 helo=mail-qk1-x72d.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=Rq+rsRys; dkim-atps=neutral
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDjXc2Ltvz30R1
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 04:53:34 +1100 (AEDT)
Received: by mail-qk1-x72d.google.com with SMTP id d21so13510838qkl.3
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 09:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qeyyI5GM0q7yA6BrwYpvKeA2Cnnu7l+noBsNQ2e9ClM=;
 b=lDw22Z8GRoiHuMJ5YqLKkexNIdNwz6k6R4+0OSJB7f4ne2A9b/WQOoGojNrN79fB3f
 BFTGO5BRgxs9aWTpKL8SLB2ozPClOpMSr4EKRyDOK2O/33zl+HmIYi59YNFull/7tRRk
 3dr5NvtSWIJ4hqrbXgBMpbbr5c558ojlihMdfu+uCNBI7udKrYmopPZ2euifZSg/pheP
 nwp70aKya4qmSOD7ZrvXA5R//vuG4apcwaLJW9e76yYgI2VqC7471XQak/L/Ha+8MHfp
 urgYNyQtJHLPW5lNNNOGixzFa4bnZzPinS4fuFGMNwwGzrezSRxvvO0kEz8l0hYVXuzP
 inJA==
X-Gm-Message-State: AOAM532rV5JwieZ+R1mTxhDydy3uLTUm5CETwmAG6l7OosBTAt2Hw01c
 sVx0B+TJjJFSRSBbOrMrphe3vfi4oWsV0IASDU1g8GL8eX3B3A==
X-Google-Smtp-Source: ABdhPJzDsj2gpPuf/RbvExWG0Z6hcIt3OynMn4oaXj2b0cmad5D2K0+zW8CEcQ62oBAFRPWAv6dOaSAX9gSPLQw8PJI=
X-Received: by 2002:a05:620a:4489:: with SMTP id
 x9mr9459923qkp.38.1639590810360; 
 Wed, 15 Dec 2021 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20211215070017.83846-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20211215070017.83846-1-hsiangkao@linux.alibaba.com>
Date: Wed, 15 Dec 2021 09:53:19 -0800
Message-ID: <CAOSmRziwkK7ENwD82jTbOnxk5uKcu4GXP8pb5Rjb6-M5uc=e_w@mail.gmail.com>
Subject: Re: [PATCH v6] erofs-utils: lib: add API to iterate dirs in EROFS
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000d4eb6f05d332fbec"
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000d4eb6f05d332fbec
Content-Type: text/plain; charset="UTF-8"

I don't like the current API design.

1. Input and output to erofs_iterate_dir are mixed in the same struct. It's
unclear to the caller which members are required input, and which ones will
be filled out by erofs_iterate_dir. I prefer the old way where input
parameters are explicitly listed, and the context struct consists of only
output members.
2. When erofs_readdir_cb is called, is the callback allowed to modify
members inside erofs_dir_context ? If not, the pointer should be marked as
const, or pass the struct by value. Or explicitly document that any
modification to the context struct will be ignored.
3. We are doing dynamic memory allocations inside a loop. Can we just use
two stack buffers?
4. Many of the current use cases(dump, fsck, android) want to traverse
directories recursively. Instead of duplicating the work and let each user
write its own logic to do recursive traversal, provide a sensical default
implementation that traverses directory recursively? This should be a
straightforward wrapper around erofs_iterate_dir. For example, adding
a erofs_iterate_dir_recursive API.

On Tue, Dec 14, 2021 at 11:00 PM Gao Xiang <hsiangkao@linux.alibaba.com>
wrote:

> From: Kelvin Zhang <zhangkelvin@google.com>
>
> This introduces erofs_iterate_dir() to read all dirents in
> a directory inode.
>
> Note that it doesn't recursively walk into sub-directories.
> If it's really needed, users should handle this in the callback.
>
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> [ Gao Xiang: heavily changed and convert erofsfuse to use this. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v5:
> https://lore.kernel.org/r/20211214173520.1944792-2-zhangkelvin@google.com
> Changes since v5:
>  - heavily changed, most logic was borrowed from fsck.erofs;
>  - use GPL-2.0+ OR Apache-2.0 dual license.
>
>  fuse/Makefile.am    |   2 +-
>  fuse/dir.c          | 100 -------------------------
>  fuse/main.c         |  49 ++++++++++++-
>  include/erofs/dir.h |  44 +++++++++++
>  lib/Makefile.am     |   2 +-
>  lib/dir.c           | 173 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 266 insertions(+), 104 deletions(-)
>  delete mode 100644 fuse/dir.c
>  create mode 100644 include/erofs/dir.h
>  create mode 100644 lib/dir.c
>
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 8a2d472..5aa5ac0 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -3,7 +3,7 @@
>  AUTOMAKE_OPTIONS = foreign
>  noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
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
> index 255965e..ca35e22 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -12,9 +12,54 @@
>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/io.h"
> +#include "erofs/dir.h"
>
> -int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t
> filler,
> -                     off_t offset, struct fuse_file_info *fi);
> +struct erofsfuse_dir_context {
> +       struct erofs_dir_context ctx;
> +       fuse_fill_dir_t filler;
> +       struct fuse_file_info *fi;
> +       void *buf;
> +};
> +
> +static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
> +{
> +       struct erofsfuse_dir_context *fusectx = (void *)ctx;
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
> +       struct erofsfuse_dir_context ctx = {
> +               .ctx.dir = &dir,
> +               .ctx.cb = erofsfuse_fill_dentries,
> +               .filler = filler,
> +               .fi = fi,
> +               .buf = buf,
> +       };
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
> +#ifdef NDEBUG
> +       return erofs_iterate_dir(&ctx.ctx, false);
> +#else
> +       return erofs_iterate_dir(&ctx.ctx, true);
> +#endif
> +
> +}
>
>  static void *erofsfuse_init(struct fuse_conn_info *info)
>  {
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> new file mode 100644
> index 0000000..43f8d81
> --- /dev/null
> +++ b/include/erofs/dir.h
> @@ -0,0 +1,44 @@
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
> +#define EROFS_READDIR_VALID_PNID       0x0001
> +#define EROFS_READDIR_DOTDOT_FOUND     0x0002
> +#define EROFS_READDIR_DOT_FOUND                0x0004
> +
> +#define EROFS_READDIR_ALL_SPECIAL_FOUND        \
> +       (EROFS_READDIR_DOTDOT_FOUND | EROFS_READDIR_DOT_FOUND)
> +
> +struct erofs_dir_context;
> +
> +/* callback function for iterating over inodes of EROFS */
> +typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
> +
> +/* callers could use a wrapper to contain extra information */
> +struct erofs_dir_context {
> +       erofs_nid_t pnid;               /* optional */
> +       struct erofs_inode *dir;
> +       erofs_readdir_cb cb;
> +
> +       /* dirent information which is currently found */
> +       erofs_nid_t nid;
> +       const char *dname;
> +       u8 ftype, flags;
> +       bool dot_dotdot;
> +};
> +
> +/* iterate over inodes that are in directory */
> +int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index c745e49..4a25013 100644
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
> index 0000000..a439dda
> --- /dev/null
> +++ b/lib/dir.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#include "erofs/print.h"
> +#include "erofs/dir.h"
> +#include <stdlib.h>
> +
> +static int traverse_dirents(struct erofs_dir_context *ctx,
> +                           void *dentry_blk, unsigned int lblk,
> +                           unsigned int next_nameoff, unsigned int
> maxsize,
> +                           bool fsck)
> +{
> +       struct erofs_dirent *de = dentry_blk;
> +       const struct erofs_dirent *end = dentry_blk + next_nameoff;
> +       char *prev_name = NULL, *cur_name;
> +       const char *errmsg;
> +       int ret = 0;
> +       bool silent = false;
> +
> +       while (de < end) {
> +               const char *de_name;
> +               unsigned int de_namelen;
> +               unsigned int nameoff;
> +
> +               nameoff = le16_to_cpu(de->nameoff);
> +               de_name = (char *)dentry_blk + nameoff;
> +
> +               /* the last dirent check */
> +               if (de + 1 >= end)
> +                       de_namelen = strnlen(de_name, maxsize - nameoff);
> +               else
> +                       de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
> +
> +               cur_name = strndup(de_name, de_namelen);
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
> +               if (nameoff + de_namelen > maxsize ||
> +                               de_namelen > EROFS_NAME_LEN) {
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
> +               ctx->dot_dotdot = is_dot_dotdot(cur_name);
> +               if (ctx->dot_dotdot) {
> +                       switch (de_namelen) {
> +                       case 2:
> +                               if (fsck &&
> +                                   (ctx->flags &
> EROFS_READDIR_DOTDOT_FOUND)) {
> +                                       errmsg = "duplicated `..' dirent";
> +                                       goto out;
> +                               }
> +                               ctx->flags |= EROFS_READDIR_DOTDOT_FOUND;
> +                               if (sbi.root_nid == ctx->dir->nid) {
> +                                       ctx->pnid = sbi.root_nid;
> +                                       ctx->flags |=
> EROFS_READDIR_VALID_PNID;
> +                               }
> +                               if (fsck &&
> +                                  (ctx->flags & EROFS_READDIR_VALID_PNID)
> &&
> +                                  de->nid != ctx->pnid) {
> +                                       errmsg = "corrupted `..' dirent";
> +                                       goto out;
> +                               }
> +                               break;
> +                       case 1:
> +                               if (fsck &&
> +                                   (ctx->flags &
> EROFS_READDIR_DOT_FOUND)) {
> +                                       errmsg = "duplicated `.' dirent";
> +                                       goto out;
> +                               }
> +
> +                               ctx->flags |= EROFS_READDIR_DOT_FOUND;
> +                               if (fsck && de->nid != ctx->dir->nid) {
> +                                       errmsg = "corrupted `.' dirent";
> +                                       goto out;
> +                               }
> +                               break;
> +                       }
> +               }
> +               ctx->ftype = de->file_type,
> +               ctx->nid = de->nid;
> +               ctx->dname = cur_name;
> +               ret = ctx->cb(ctx);
> +               if (ret) {
> +                       silent = true;
> +                       goto out;
> +               }
> +               next_nameoff += de_namelen;
> +               ++de;
> +               if (prev_name)
> +                       free(prev_name);
> +               prev_name = cur_name;
> +               cur_name = NULL;
> +       }
> +out:
> +       if (prev_name)
> +               free(prev_name);
> +       if (cur_name)
> +               free(cur_name);
> +       if (ret && !silent)
> +               erofs_err("%s @ nid %llu, lblk %u, index %lu",
> +                         errmsg, ctx->dir->nid | 0ULL, lblk,
> +                         (de - (struct erofs_dirent *)dentry_blk) | 0UL);
> +       return ret;
> +}
> +
> +int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
> +{
> +       struct erofs_inode *dir = ctx->dir;
> +       int err;
> +       erofs_off_t pos;
> +       char buf[EROFS_BLKSIZ];
> +
> +       if ((dir->i_mode & S_IFMT) != S_IFDIR)
> +               return -ENOTDIR;
> +
> +       ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
> +       pos = 0;
> +       while (pos < dir->i_size) {
> +               erofs_blk_t lblk = erofs_blknr(pos);
> +               erofs_off_t maxsize = min_t(erofs_off_t,
> +                                       dir->i_size - pos, EROFS_BLKSIZ);
> +               const struct erofs_dirent *de = (const void *)buf;
> +               unsigned int nameoff;
> +
> +               err = erofs_pread(dir, buf, maxsize, pos);
> +               if (err) {
> +                       erofs_err("I/O error occurred when reading dirents
> @ nid %llu, lblk %u: %d",
> +                                 dir->nid | 0ULL, lblk, err);
> +                       return err;
> +               }
> +
> +               nameoff = le16_to_cpu(de->nameoff);
> +               if (nameoff < sizeof(struct erofs_dirent) ||
> +                   nameoff >= PAGE_SIZE) {
> +                       erofs_err("invalid de[0].nameoff %u @ nid %llu,
> lblk %u",
> +                                 nameoff, dir->nid | 0ULL, lblk);
> +                       return -EFSCORRUPTED;
> +               }
> +               err = traverse_dirents(ctx, buf, lblk, nameoff, maxsize,
> fsck);
> +               if (err)
> +                       break;
> +               pos += maxsize;
> +       }
> +
> +       if (fsck && (ctx->flags & EROFS_READDIR_ALL_SPECIAL_FOUND) !=
> +                       EROFS_READDIR_ALL_SPECIAL_FOUND) {
> +               erofs_err("`.' or `..' dirent is missing @ nid %llu",
> +                         dir->nid | 0ULL);
> +               return -EFSCORRUPTED;
> +       }
> +       return 0;
> +}
> --
> 2.24.4
>
>

-- 
Sincerely,

Kelvin Zhang

--000000000000d4eb6f05d332fbec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SSBkb24mIzM5O3QgbGlrZSB0aGUgY3VycmVudCBBUEkgZGVzaWduLjxk
aXY+PGJyPjwvZGl2PjxkaXY+MS4gSW5wdXQgYW5kIG91dHB1dCB0b8KgZXJvZnNfaXRlcmF0ZV9k
aXIgYXJlIG1peGVkIGluIHRoZSBzYW1lIHN0cnVjdC4gSXQmIzM5O3MgdW5jbGVhciB0byB0aGUg
Y2FsbGVyIHdoaWNoIG1lbWJlcnMgYXJlIHJlcXVpcmVkIGlucHV0LCBhbmQgd2hpY2ggb25lcyB3
aWxsIGJlIGZpbGxlZCBvdXQgYnnCoGVyb2ZzX2l0ZXJhdGVfZGlyLiBJIHByZWZlciB0aGUgb2xk
IHdheSB3aGVyZSBpbnB1dCBwYXJhbWV0ZXJzIGFyZSBleHBsaWNpdGx5IGxpc3RlZCwgYW5kIHRo
ZSBjb250ZXh0IHN0cnVjdCBjb25zaXN0cyBvZiBvbmx5IG91dHB1dCBtZW1iZXJzLjwvZGl2Pjxk
aXY+Mi4gV2hlbsKgZXJvZnNfcmVhZGRpcl9jYiBpcyBjYWxsZWQsIGlzIHRoZSBjYWxsYmFjayBh
bGxvd2VkIHRvIG1vZGlmeSBtZW1iZXJzIGluc2lkZcKgZXJvZnNfZGlyX2NvbnRleHQgPyBJZiBu
b3QsIHRoZSBwb2ludGVyIHNob3VsZMKgYmUgbWFya2VkIGFzIGNvbnN0LCBvciBwYXNzIHRoZSBz
dHJ1Y3QgYnkgdmFsdWUuIE9yIGV4cGxpY2l0bHkgZG9jdW1lbnQgdGhhdCBhbnkgbW9kaWZpY2F0
aW9uIHRvIHRoZSBjb250ZXh0IHN0cnVjdCB3aWxsIGJlIGlnbm9yZWQuPC9kaXY+PGRpdj4zLiBX
ZSBhcmUgZG9pbmcgZHluYW1pYyBtZW1vcnkgYWxsb2NhdGlvbnMgaW5zaWRlIGEgbG9vcC4gQ2Fu
IHdlIGp1c3QgdXNlIHR3byBzdGFjayBidWZmZXJzPzwvZGl2PjxkaXY+NC4gTWFueSBvZiB0aGUg
Y3VycmVudCB1c2UgY2FzZXMoZHVtcCwgZnNjaywgYW5kcm9pZCkgd2FudCB0byB0cmF2ZXJzZSBk
aXJlY3RvcmllcyByZWN1cnNpdmVseS4gSW5zdGVhZMKgb2YgZHVwbGljYXRpbmfCoHRoZSB3b3Jr
IGFuZCBsZXQgZWFjaCB1c2VyIHdyaXRlIGl0cyBvd24gbG9naWMgdG8gZG8gcmVjdXJzaXZlIHRy
YXZlcnNhbCwgcHJvdmlkZSBhIHNlbnNpY2FsIGRlZmF1bHQgaW1wbGVtZW50YXRpb24gdGhhdCB0
cmF2ZXJzZXMgZGlyZWN0b3J5IHJlY3Vyc2l2ZWx5PyBUaGlzIHNob3VsZCBiZSBhIHN0cmFpZ2h0
Zm9yd2FyZCB3cmFwcGVyIGFyb3VuZMKgZXJvZnNfaXRlcmF0ZV9kaXIuIEZvciBleGFtcGxlLCBh
ZGRpbmcgYcKgZXJvZnNfaXRlcmF0ZV9kaXJfcmVjdXJzaXZlIEFQSS48L2Rpdj48L2Rpdj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRy
Ij5PbiBUdWUsIERlYyAxNCwgMjAyMSBhdCAxMTowMCBQTSBHYW8gWGlhbmcgJmx0OzxhIGhyZWY9
Im1haWx0bzpoc2lhbmdrYW9AbGludXguYWxpYmFiYS5jb20iPmhzaWFuZ2thb0BsaW51eC5hbGli
YWJhLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogS2VsdmluIFpoYW5n
ICZsdDs8YSBocmVmPSJtYWlsdG86emhhbmdrZWx2aW5AZ29vZ2xlLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPnpoYW5na2VsdmluQGdvb2dsZS5jb208L2E+Jmd0Ozxicj4NCjxicj4NClRoaXMgaW50cm9k
dWNlcyBlcm9mc19pdGVyYXRlX2RpcigpIHRvIHJlYWQgYWxsIGRpcmVudHMgaW48YnI+DQphIGRp
cmVjdG9yeSBpbm9kZS48YnI+DQo8YnI+DQpOb3RlIHRoYXQgaXQgZG9lc24mIzM5O3QgcmVjdXJz
aXZlbHkgd2FsayBpbnRvIHN1Yi1kaXJlY3Rvcmllcy48YnI+DQpJZiBpdCYjMzk7cyByZWFsbHkg
bmVlZGVkLCB1c2VycyBzaG91bGQgaGFuZGxlIHRoaXMgaW4gdGhlIGNhbGxiYWNrLjxicj4NCjxi
cj4NClNpZ25lZC1vZmYtYnk6IEtlbHZpbiBaaGFuZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnpoYW5n
a2VsdmluQGdvb2dsZS5jb20iIHRhcmdldD0iX2JsYW5rIj56aGFuZ2tlbHZpbkBnb29nbGUuY29t
PC9hPiZndDs8YnI+DQpbIEdhbyBYaWFuZzogaGVhdmlseSBjaGFuZ2VkIGFuZCBjb252ZXJ0IGVy
b2ZzZnVzZSB0byB1c2UgdGhpcy4gXTxicj4NClNpZ25lZC1vZmYtYnk6IEdhbyBYaWFuZyAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPmhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KdjU6
IDxhIGhyZWY9Imh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTEyMTQxNzM1MjAuMTk0NDc5
Mi0yLXpoYW5na2VsdmluQGdvb2dsZS5jb20iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTEyMTQxNzM1MjAuMTk0NDc5Mi0yLXpo
YW5na2VsdmluQGdvb2dsZS5jb208L2E+PGJyPg0KQ2hhbmdlcyBzaW5jZSB2NTo8YnI+DQrCoC0g
aGVhdmlseSBjaGFuZ2VkLCBtb3N0IGxvZ2ljIHdhcyBib3Jyb3dlZCBmcm9tIGZzY2suZXJvZnM7
PGJyPg0KwqAtIHVzZSBHUEwtMi4wKyBPUiBBcGFjaGUtMi4wIGR1YWwgbGljZW5zZS48YnI+DQo8
YnI+DQrCoGZ1c2UvTWFrZWZpbGUuYW3CoCDCoCB8wqAgwqAyICstPGJyPg0KwqBmdXNlL2Rpci5j
wqAgwqAgwqAgwqAgwqAgfCAxMDAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCsKgZnVz
ZS9tYWluLmPCoCDCoCDCoCDCoCDCoHzCoCA0OSArKysrKysrKysrKystPGJyPg0KwqBpbmNsdWRl
L2Vyb2ZzL2Rpci5oIHzCoCA0NCArKysrKysrKysrKzxicj4NCsKgbGliL01ha2VmaWxlLmFtwqAg
wqAgwqB8wqAgwqAyICstPGJyPg0KwqBsaWIvZGlyLmPCoCDCoCDCoCDCoCDCoCDCoHwgMTczICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KwqA2IGZpbGVz
IGNoYW5nZWQsIDI2NiBpbnNlcnRpb25zKCspLCAxMDQgZGVsZXRpb25zKC0pPGJyPg0KwqBkZWxl
dGUgbW9kZSAxMDA2NDQgZnVzZS9kaXIuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZXJvZnMvZGlyLmg8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvZGlyLmM8YnI+DQo8
YnI+DQpkaWZmIC0tZ2l0IGEvZnVzZS9NYWtlZmlsZS5hbSBiL2Z1c2UvTWFrZWZpbGUuYW08YnI+
DQppbmRleCA4YTJkNDcyLi41YWE1YWMwIDEwMDY0NDxicj4NCi0tLSBhL2Z1c2UvTWFrZWZpbGUu
YW08YnI+DQorKysgYi9mdXNlL01ha2VmaWxlLmFtPGJyPg0KQEAgLTMsNyArMyw3IEBAPGJyPg0K
wqBBVVRPTUFLRV9PUFRJT05TID0gZm9yZWlnbjxicj4NCsKgbm9pbnN0X0hFQURFUlMgPSAkKHRv
cF9zcmNkaXIpL2Z1c2UvbWFjb3N4Lmg8YnI+DQrCoGJpbl9QUk9HUkFNU8KgIMKgIMKgPSBlcm9m
c2Z1c2U8YnI+DQotZXJvZnNmdXNlX1NPVVJDRVMgPSBkaXIuYyBtYWluLmM8YnI+DQorZXJvZnNm
dXNlX1NPVVJDRVMgPSBtYWluLmM8YnI+DQrCoGVyb2ZzZnVzZV9DRkxBR1MgPSAtV2FsbCAtV2Vy
cm9yIC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlPGJyPg0KwqBlcm9mc2Z1c2VfQ0ZMQUdTICs9IC1E
RlVTRV9VU0VfVkVSU0lPTj0yNiAke2xpYmZ1c2VfQ0ZMQUdTfSAke2xpYnNlbGludXhfQ0ZMQUdT
fTxicj4NCsKgZXJvZnNmdXNlX0xEQUREID0gJCh0b3BfYnVpbGRkaXIpL2xpYi88YSBocmVmPSJo
dHRwOi8vbGliZXJvZnMubGEiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmxpYmVy
b2ZzLmxhPC9hPiAke2xpYmZ1c2VfTElCU30gJHtsaWJsejRfTElCU30gXDxicj4NCmRpZmYgLS1n
aXQgYS9mdXNlL2Rpci5jIGIvZnVzZS9kaXIuYzxicj4NCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0
NDxicj4NCmluZGV4IGJjODczNWIuLjAwMDAwMDA8YnI+DQotLS0gYS9mdXNlL2Rpci5jPGJyPg0K
KysrIC9kZXYvbnVsbDxicj4NCkBAIC0xLDEwMCArMCwwIEBAPGJyPg0KLS8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wKzxicj4NCi0vKjxicj4NCi0gKiBDcmVhdGVkIGJ5IExpIEd1
aWZ1ICZsdDs8YSBocmVmPSJtYWlsdG86Ymx1Y2VybGVlQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPmJsdWNlcmxlZUBnbWFpbC5jb208L2E+Jmd0Ozxicj4NCi0gKi88YnI+DQotI2luY2x1ZGUg
Jmx0O2Z1c2UuaCZndDs8YnI+DQotI2luY2x1ZGUgJmx0O2Z1c2Vfb3B0LmgmZ3Q7PGJyPg0KLSNp
bmNsdWRlICZxdW90O21hY29zeC5oJnF1b3Q7PGJyPg0KLSNpbmNsdWRlICZxdW90O2Vyb2ZzL2lu
dGVybmFsLmgmcXVvdDs8YnI+DQotI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90Ozxi
cj4NCi08YnI+DQotc3RhdGljIGludCBlcm9mc19maWxsX2RlbnRyaWVzKHN0cnVjdCBlcm9mc19p
bm9kZSAqZGlyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBmdXNlX2ZpbGxfZGlyX3QgZmlsbGVyLCB2b2lkICpidWYsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZvaWQgKmRibGssIHVuc2lnbmVkIGlu
dCBuYW1lb2ZmLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB1bnNpZ25lZCBpbnQgbWF4c2l6ZSk8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoHN0cnVj
dCBlcm9mc19kaXJlbnQgKmRlID0gZGJsazs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3Qg
ZXJvZnNfZGlyZW50ICplbmQgPSBkYmxrICsgbmFtZW9mZjs8YnI+DQotwqAgwqAgwqAgwqBjaGFy
IG5hbWVidWZbRVJPRlNfTkFNRV9MRU4gKyAxXTs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgd2hp
bGUgKGRlICZsdDsgZW5kKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hh
ciAqZGVfbmFtZTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgZGVf
bmFtZWxlbjs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9IGxl
MTZfdG9fY3B1KGRlLSZndDtuYW1lb2ZmKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
ZV9uYW1lID0gKGNoYXIgKilkYmxrICsgbmFtZW9mZjs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyogdGhlIGxhc3QgZGlyZW50IGluIHRoZSBibG9jaz8gKi88YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGUgKyAxICZndDs9IGVuZCk8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1lbGVuID0gc3RybmxlbihkZV9uYW1lLCBt
YXhzaXplIC0gbmFtZW9mZik7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlX25hbWVsZW4gPSBsZTE2X3Rv
X2NwdShkZVsxXS5uYW1lb2ZmKSAtIG5hbWVvZmY7PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC8qIGEgY29ycnVwdGVkIGVudHJ5IGlzIGZvdW5kICovPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKG5hbWVvZmYgKyBkZV9uYW1lbGVuICZndDsgbWF4c2l6ZSB8fDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlX25hbWVsZW4gJmd0OyBFUk9GU19O
QU1FX0xFTikgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyb2Zz
X2VycigmcXVvdDtib2d1cyBkaXJlbnQgQCBuaWQgJWxsdSZxdW90OywgZGlyLSZndDtuaWQgfCAw
VUxMKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQkdfQlVHT04o
MSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FRlND
T1JSVVBURUQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkobmFtZWJ1ZiwgZGVfbmFtZSwgZGVfbmFtZWxlbik7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZWJ1ZltkZV9uYW1lbGVuXSA9ICYjMzk7
XDAmIzM5Ozs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsbGVyKGJ1Ziwg
bmFtZWJ1ZiwgTlVMTCwgMCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKytkZTs8YnI+
DQotwqAgwqAgwqAgwqB9PGJyPg0KLcKgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KLX08YnI+DQot
PGJyPg0KLWludCBlcm9mc2Z1c2VfcmVhZGRpcihjb25zdCBjaGFyICpwYXRoLCB2b2lkICpidWYs
IGZ1c2VfZmlsbF9kaXJfdCBmaWxsZXIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgb2ZmX3Qgb2Zmc2V0LCBzdHJ1Y3QgZnVzZV9maWxlX2luZm8gKmZpKTxicj4NCi17PGJy
Pg0KLcKgIMKgIMKgIMKgaW50IHJldDs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5v
ZGUgZGlyOzxicj4NCi3CoCDCoCDCoCDCoGNoYXIgZGJsa1tFUk9GU19CTEtTSVpdOzxicj4NCi3C
oCDCoCDCoCDCoGVyb2ZzX29mZl90IHBvczs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgZXJvZnNf
ZGJnKCZxdW90O3JlYWRkaXI6JXMgb2Zmc2V0PSVsbHUmcXVvdDssIHBhdGgsIChsb25nIGxvbmcp
b2Zmc2V0KTs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgcmV0ID0gZXJvZnNfaWxvb2t1cChwYXRo
LCAmYW1wO2Rpcik7PGJyPg0KLcKgIMKgIMKgIMKgaWYgKHJldCk8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqBlcm9mc19kYmco
JnF1b3Q7cGF0aD0lcyBuaWQgPSAlbGx1JnF1b3Q7LCBwYXRoLCBkaXIubmlkIHwgMFVMTCk7PGJy
Pg0KLTxicj4NCi3CoCDCoCDCoCDCoGlmICghU19JU0RJUihkaXIuaV9tb2RlKSk8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT1RESVI7PGJyPg0KLTxicj4NCi3CoCDCoCDC
oCDCoGlmICghZGlyLmlfc2l6ZSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
MDs8YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgcG9zID0gMDs8YnI+DQotwqAgwqAgwqAgwqB3aGls
ZSAocG9zICZsdDsgZGlyLmlfc2l6ZSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVu
c2lnbmVkIGludCBuYW1lb2ZmLCBtYXhzaXplOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN0cnVjdCBlcm9mc19kaXJlbnQgKmRlOzxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBtYXhzaXplID0gbWluX3QodW5zaWduZWQgaW50LCBFUk9GU19CTEtTSVosPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlyLmlfc2l6ZSAt
IHBvcyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gZXJvZnNfcHJlYWQoJmFt
cDtkaXIsIGRibGssIG1heHNpemUsIHBvcyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKHJldCk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
cmV0Ozxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZSA9IChzdHJ1Y3QgZXJv
ZnNfZGlyZW50ICopZGJsazs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuYW1lb2ZmID0g
bGUxNl90b19jcHUoZGUtJmd0O25hbWVvZmYpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChuYW1lb2ZmICZsdDsgc2l6ZW9mKHN0cnVjdCBlcm9mc19kaXJlbnQpIHx8PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiAmZ3Q7PSBQQUdFX1NJWkUpIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1b3Q7aW52
YWxpZCBkZVswXS5uYW1lb2ZmICV1IEAgbmlkICVsbHUmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiwgZGlyLm5pZCB8
IDBVTEwpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1F
RlNDT1JSVVBURUQ7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXQgPSBlcm9mc19maWxsX2RlbnRyaWVzKCZhbXA7ZGlyLCBmaWxsZXIs
IGJ1Ziw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkYmxrLCBuYW1lb2ZmLCBtYXhzaXplKTs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAocmV0KTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJyZWFrOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBvcyArPSBtYXhzaXpl
Ozxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQotfTxi
cj4NCmRpZmYgLS1naXQgYS9mdXNlL21haW4uYyBiL2Z1c2UvbWFpbi5jPGJyPg0KaW5kZXggMjU1
OTY1ZS4uY2EzNWUyMiAxMDA2NDQ8YnI+DQotLS0gYS9mdXNlL21haW4uYzxicj4NCisrKyBiL2Z1
c2UvbWFpbi5jPGJyPg0KQEAgLTEyLDkgKzEyLDU0IEBAPGJyPg0KwqAjaW5jbHVkZSAmcXVvdDtl
cm9mcy9jb25maWcuaCZxdW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZx
dW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvaW8uaCZxdW90Ozxicj4NCisjaW5jbHVk
ZSAmcXVvdDtlcm9mcy9kaXIuaCZxdW90Ozxicj4NCjxicj4NCi1pbnQgZXJvZnNmdXNlX3JlYWRk
aXIoY29uc3QgY2hhciAqcGF0aCwgdm9pZCAqYnVmZmVyLCBmdXNlX2ZpbGxfZGlyX3QgZmlsbGVy
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mZl90IG9mZnNldCwgc3Ry
dWN0IGZ1c2VfZmlsZV9pbmZvICpmaSk7PGJyPg0KK3N0cnVjdCBlcm9mc2Z1c2VfZGlyX2NvbnRl
eHQgezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19kaXJfY29udGV4dCBjdHg7PGJyPg0K
K8KgIMKgIMKgIMKgZnVzZV9maWxsX2Rpcl90IGZpbGxlcjs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1
Y3QgZnVzZV9maWxlX2luZm8gKmZpOzxicj4NCivCoCDCoCDCoCDCoHZvaWQgKmJ1Zjs8YnI+DQor
fTs8YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQgZXJvZnNmdXNlX2ZpbGxfZGVudHJpZXMoc3RydWN0
IGVyb2ZzX2Rpcl9jb250ZXh0ICpjdHgpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qg
ZXJvZnNmdXNlX2Rpcl9jb250ZXh0ICpmdXNlY3R4ID0gKHZvaWQgKiljdHg7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGZ1c2VjdHgtJmd0O2ZpbGxlcihmdXNlY3R4LSZndDtidWYsIGN0eC0mZ3Q7
ZG5hbWUsIE5VTEwsIDApOzxicj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCit9PGJyPg0K
Kzxicj4NCitpbnQgZXJvZnNmdXNlX3JlYWRkaXIoY29uc3QgY2hhciAqcGF0aCwgdm9pZCAqYnVm
LCBmdXNlX2ZpbGxfZGlyX3QgZmlsbGVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG9mZl90IG9mZnNldCwgc3RydWN0IGZ1c2VfZmlsZV9pbmZvICpmaSk8YnI+DQorezxi
cj4NCivCoCDCoCDCoCDCoGludCByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGVyb2ZzX2lu
b2RlIGRpcjs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNmdXNlX2Rpcl9jb250ZXh0IGN0
eCA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuY3R4LmRpciA9ICZhbXA7ZGlyLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5jdHguY2IgPSBlcm9mc2Z1c2VfZmlsbF9kZW50
cmllcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZmlsbGVyID0gZmlsbGVyLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5maSA9IGZpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC5idWYgPSBidWYsPGJyPg0KK8KgIMKgIMKgIMKgfTs8YnI+DQorwqAgwqAgwqAgwqBl
cm9mc19kYmcoJnF1b3Q7cmVhZGRpcjolcyBvZmZzZXQ9JWxsdSZxdW90OywgcGF0aCwgKGxvbmcg
bG9uZylvZmZzZXQpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXQgPSBlcm9mc19pbG9va3Vw
KHBhdGgsICZhbXA7ZGlyKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0KTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGVyb2Zz
X2RiZygmcXVvdDtwYXRoPSVzIG5pZCA9ICVsbHUmcXVvdDssIHBhdGgsIGRpci5uaWQgfCAwVUxM
KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoIVNfSVNESVIoZGlyLmlfbW9kZSkpPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FTk9URElSOzxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqBpZiAoIWRpci5pX3NpemUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7
PGJyPg0KKyNpZmRlZiBOREVCVUc8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gZXJvZnNfaXRlcmF0
ZV9kaXIoJmFtcDtjdHguY3R4LCBmYWxzZSk7PGJyPg0KKyNlbHNlPGJyPg0KK8KgIMKgIMKgIMKg
cmV0dXJuIGVyb2ZzX2l0ZXJhdGVfZGlyKCZhbXA7Y3R4LmN0eCwgdHJ1ZSk7PGJyPg0KKyNlbmRp
Zjxicj4NCis8YnI+DQorfTxicj4NCjxicj4NCsKgc3RhdGljIHZvaWQgKmVyb2ZzZnVzZV9pbml0
KHN0cnVjdCBmdXNlX2Nvbm5faW5mbyAqaW5mbyk8YnI+DQrCoHs8YnI+DQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9lcm9mcy9kaXIuaCBiL2luY2x1ZGUvZXJvZnMvZGlyLmg8YnI+DQpuZXcgZmlsZSBt
b2RlIDEwMDY0NDxicj4NCmluZGV4IDAwMDAwMDAuLjQzZjhkODE8YnI+DQotLS0gL2Rldi9udWxs
PGJyPg0KKysrIGIvaW5jbHVkZS9lcm9mcy9kaXIuaDxicj4NCkBAIC0wLDAgKzEsNDQgQEA8YnI+
DQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArIE9SIEFwYWNoZS0yLjAgKi88
YnI+DQorI2lmbmRlZiBfX0VST0ZTX0RJUl9IPGJyPg0KKyNkZWZpbmUgX19FUk9GU19ESVJfSDxi
cj4NCis8YnI+DQorI2lmZGVmIF9fY3BsdXNwbHVzPGJyPg0KK2V4dGVybiAmcXVvdDtDJnF1b3Q7
PGJyPg0KK3s8YnI+DQorI2VuZGlmPGJyPg0KKzxicj4NCisjaW5jbHVkZSAmcXVvdDtpbnRlcm5h
bC5oJnF1b3Q7PGJyPg0KKzxicj4NCisjZGVmaW5lIEVST0ZTX1JFQURESVJfVkFMSURfUE5JRMKg
IMKgIMKgIMKgMHgwMDAxPGJyPg0KKyNkZWZpbmUgRVJPRlNfUkVBRERJUl9ET1RET1RfRk9VTkTC
oCDCoCDCoDB4MDAwMjxicj4NCisjZGVmaW5lIEVST0ZTX1JFQURESVJfRE9UX0ZPVU5EwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgMHgwMDA0PGJyPg0KKzxicj4NCisjZGVmaW5lIEVST0ZTX1JFQURE
SVJfQUxMX1NQRUNJQUxfRk9VTkTCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgKEVST0ZT
X1JFQURESVJfRE9URE9UX0ZPVU5EIHwgRVJPRlNfUkVBRERJUl9ET1RfRk9VTkQpPGJyPg0KKzxi
cj4NCitzdHJ1Y3QgZXJvZnNfZGlyX2NvbnRleHQ7PGJyPg0KKzxicj4NCisvKiBjYWxsYmFjayBm
dW5jdGlvbiBmb3IgaXRlcmF0aW5nIG92ZXIgaW5vZGVzIG9mIEVST0ZTICovPGJyPg0KK3R5cGVk
ZWYgaW50ICgqZXJvZnNfcmVhZGRpcl9jYikoc3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0ICopOzxi
cj4NCis8YnI+DQorLyogY2FsbGVycyBjb3VsZCB1c2UgYSB3cmFwcGVyIHRvIGNvbnRhaW4gZXh0
cmEgaW5mb3JtYXRpb24gKi88YnI+DQorc3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0IHs8YnI+DQor
wqAgwqAgwqAgwqBlcm9mc19uaWRfdCBwbmlkO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogb3B0
aW9uYWwgKi88YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGUgKmRpcjs8YnI+DQor
wqAgwqAgwqAgwqBlcm9mc19yZWFkZGlyX2NiIGNiOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAv
KiBkaXJlbnQgaW5mb3JtYXRpb24gd2hpY2ggaXMgY3VycmVudGx5IGZvdW5kICovPGJyPg0KK8Kg
IMKgIMKgIMKgZXJvZnNfbmlkX3QgbmlkOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKmRu
YW1lOzxicj4NCivCoCDCoCDCoCDCoHU4IGZ0eXBlLCBmbGFnczs8YnI+DQorwqAgwqAgwqAgwqBi
b29sIGRvdF9kb3Rkb3Q7PGJyPg0KK307PGJyPg0KKzxicj4NCisvKiBpdGVyYXRlIG92ZXIgaW5v
ZGVzIHRoYXQgYXJlIGluIGRpcmVjdG9yeSAqLzxicj4NCitpbnQgZXJvZnNfaXRlcmF0ZV9kaXIo
c3RydWN0IGVyb2ZzX2Rpcl9jb250ZXh0ICpjdHgsIGJvb2wgZnNjayk7PGJyPg0KKzxicj4NCisj
aWZkZWYgX19jcGx1c3BsdXM8YnI+DQorfTxicj4NCisjZW5kaWY8YnI+DQorPGJyPg0KKyNlbmRp
Zjxicj4NCmRpZmYgLS1naXQgYS9saWIvTWFrZWZpbGUuYW0gYi9saWIvTWFrZWZpbGUuYW08YnI+
DQppbmRleCBjNzQ1ZTQ5Li40YTI1MDEzIDEwMDY0NDxicj4NCi0tLSBhL2xpYi9NYWtlZmlsZS5h
bTxicj4NCisrKyBiL2xpYi9NYWtlZmlsZS5hbTxicj4NCkBAIC0yNyw3ICsyNyw3IEBAIG5vaW5z
dF9IRUFERVJTID0gJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL2Vyb2ZzX2ZzLmggXDxicj4NCsKgbm9p
bnN0X0hFQURFUlMgKz0gY29tcHJlc3Nvci5oPGJyPg0KwqBsaWJlcm9mc19sYV9TT1VSQ0VTID0g
Y29uZmlnLmMgaW8uYyBjYWNoZS5jIHN1cGVyLmMgaW5vZGUuYyB4YXR0ci5jIGV4Y2x1ZGUuYyBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmFtZWkuYyBkYXRhLmMgY29t
cHJlc3MuYyBjb21wcmVzc29yLmMgem1hcC5jIGRlY29tcHJlc3MuYyBcPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcHJlc3NfaGludHMuYyBoYXNobWFwLmMgc2hhMjU2
LmMgYmxvYmNodW5rLmM8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb21w
cmVzc19oaW50cy5jIGhhc2htYXAuYyBzaGEyNTYuYyBibG9iY2h1bmsuYyBkaXIuYzxicj4NCsKg
bGliZXJvZnNfbGFfQ0ZMQUdTID0gLVdhbGwgLVdlcnJvciAtSSQodG9wX3NyY2RpcikvaW5jbHVk
ZTxicj4NCsKgaWYgRU5BQkxFX0xaNDxicj4NCsKgbGliZXJvZnNfbGFfQ0ZMQUdTICs9ICR7TFo0
X0NGTEFHU308YnI+DQpkaWZmIC0tZ2l0IGEvbGliL2Rpci5jIGIvbGliL2Rpci5jPGJyPg0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAwMDAwMDAwLi5hNDM5ZGRhPGJyPg0KLS0tIC9k
ZXYvbnVsbDxicj4NCisrKyBiL2xpYi9kaXIuYzxicj4NCkBAIC0wLDAgKzEsMTczIEBAPGJyPg0K
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyBPUiBBcGFjaGUtMi4wPGJyPg0K
KyNpbmNsdWRlICZxdW90O2Vyb2ZzL3ByaW50LmgmcXVvdDs8YnI+DQorI2luY2x1ZGUgJnF1b3Q7
ZXJvZnMvZGlyLmgmcXVvdDs8YnI+DQorI2luY2x1ZGUgJmx0O3N0ZGxpYi5oJmd0Ozxicj4NCis8
YnI+DQorc3RhdGljIGludCB0cmF2ZXJzZV9kaXJlbnRzKHN0cnVjdCBlcm9mc19kaXJfY29udGV4
dCAqY3R4LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZv
aWQgKmRlbnRyeV9ibGssIHVuc2lnbmVkIGludCBsYmxrLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBuZXh0X25hbWVvZmYsIHVuc2ln
bmVkIGludCBtYXhzaXplLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGJvb2wgZnNjayk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19k
aXJlbnQgKmRlID0gZGVudHJ5X2Jsazs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgZXJv
ZnNfZGlyZW50ICplbmQgPSBkZW50cnlfYmxrICsgbmV4dF9uYW1lb2ZmOzxicj4NCivCoCDCoCDC
oCDCoGNoYXIgKnByZXZfbmFtZSA9IE5VTEwsICpjdXJfbmFtZTs8YnI+DQorwqAgwqAgwqAgwqBj
b25zdCBjaGFyICplcnJtc2c7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJldCA9IDA7PGJyPg0KK8Kg
IMKgIMKgIMKgYm9vbCBzaWxlbnQgPSBmYWxzZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgd2hp
bGUgKGRlICZsdDsgZW5kKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hh
ciAqZGVfbmFtZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgZGVf
bmFtZWxlbjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbmFtZW9m
Zjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9IGxlMTZfdG9f
Y3B1KGRlLSZndDtuYW1lb2ZmKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1l
ID0gKGNoYXIgKilkZW50cnlfYmxrICsgbmFtZW9mZjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLyogdGhlIGxhc3QgZGlyZW50IGNoZWNrICovPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKGRlICsgMSAmZ3Q7PSBlbmQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZGVfbmFtZWxlbiA9IHN0cm5sZW4oZGVfbmFtZSwgbWF4c2l6ZSAt
IG5hbWVvZmYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2U8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1lbGVuID0gbGUxNl90b19jcHUoZGVb
MV0ubmFtZW9mZikgLSBuYW1lb2ZmOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBjdXJfbmFtZSA9IHN0cm5kdXAoZGVfbmFtZSwgZGVfbmFtZWxlbik7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKCFjdXJfbmFtZSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGVycm1zZyA9ICZxdW90O2ZhaWxlZCB0byBhbGxvY2F0ZSBkaXJlbnQg
bmFtZSZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQg
PSAtRU5PTUVNOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFr
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZXJvZnNfZGJnKCZxdW90O3RyYXZlcnNlZCBmaWxlbmFtZSglcykmcXVvdDss
IGN1cl9uYW1lKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gLUVG
U0NPUlJVUFRFRDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBjb3JydXB0ZWQgZW50
cnkgY2hlY2sgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAobmFtZW9mZiAhPSBu
ZXh0X25hbWVvZmYpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cnJtc2cgPSAmcXVvdDtib2d1cyBkaXJlbnQgbmFtZW9mZiZxdW90Ozs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChuYW1lb2ZmICsg
ZGVfbmFtZWxlbiAmZ3Q7IG1heHNpemUgfHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZV9uYW1lbGVuICZndDsgRVJPRlNfTkFNRV9MRU4pIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVvdDti
b2d1cyBkaXJlbnQgbmFtZWxlbiZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChmc2NrICZhbXA7JmFtcDsgcHJldl9uYW1l
ICZhbXA7JmFtcDsgc3RyY21wKHByZXZfbmFtZSwgY3VyX25hbWUpICZndDs9IDApIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVvdDt3cm9uZyBk
aXJlbnQgbmFtZSBvcmRlciZxdW90Ozs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChmc2NrICZhbXA7JmFtcDsgZGUtJmd0O2ZpbGVf
dHlwZSAmZ3Q7PSBFUk9GU19GVF9NQVgpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBlcnJtc2cgPSAmcXVvdDtpbnZhbGlkIGZpbGUgdHlwZSAldSZxdW90Ozs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0
eC0mZ3Q7ZG90X2RvdGRvdCA9IGlzX2RvdF9kb3Rkb3QoY3VyX25hbWUpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChjdHgtJmd0O2RvdF9kb3Rkb3QpIHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggKGRlX25hbWVsZW4pIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIDI6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGZzY2sgJmFtcDsmYW1wOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oChjdHgtJmd0O2ZsYWdzICZhbXA7IEVST0ZTX1JFQURESVJfRE9URE9UX0ZPVU5EKSkgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVycm1zZyA9ICZxdW90O2R1cGxpY2F0ZWQgYC4uJiMzOTsgZGlyZW50JnF1b3Q7Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjdHgtJmd0O2ZsYWdzIHw9IEVST0ZTX1JFQURESVJfRE9URE9UX0ZPVU5EOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzYmku
cm9vdF9uaWQgPT0gY3R4LSZndDtkaXItJmd0O25pZCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0eC0mZ3Q7cG5pZCA9
IHNiaS5yb290X25pZDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdHgtJmd0O2ZsYWdzIHw9IEVST0ZTX1JFQURESVJfVkFM
SURfUE5JRDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKGZzY2sgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoY3R4LSZndDtmbGFncyAmYW1wOyBFUk9GU19SRUFERElS
X1ZBTElEX1BOSUQpICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGUtJmd0O25pZCAhPSBjdHgtJmd0O3BuaWQpIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBlcnJtc2cgPSAmcXVvdDtjb3JydXB0ZWQgYC4uJiMzOTsgZGlyZW50JnF1b3Q7Ozxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
YXNlIDE6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKGZzY2sgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChjdHgtJmd0O2ZsYWdzICZhbXA7IEVST0ZTX1JFQURE
SVJfRE9UX0ZPVU5EKSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycm1zZyA9ICZxdW90O2R1cGxpY2F0ZWQgYC4mIzM5
OyBkaXJlbnQmcXVvdDs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBvdXQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdHgtJmd0O2ZsYWdzIHw9IEVST0ZT
X1JFQURESVJfRE9UX0ZPVU5EOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChmc2NrICZhbXA7JmFtcDsgZGUtJmd0O25pZCAhPSBjdHgtJmd0
O2Rpci0mZ3Q7bmlkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJybXNnID0gJnF1b3Q7Y29ycnVwdGVkIGAuJiMzOTsg
ZGlyZW50JnF1b3Q7Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0eC0mZ3Q7ZnR5cGUgPSBkZS0mZ3Q7ZmlsZV90eXBlLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN0eC0mZ3Q7bmlkID0gZGUtJmd0O25pZDs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjdHgtJmd0O2RuYW1lID0gY3VyX25hbWU7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gY3R4LSZndDtjYihjdHgpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChyZXQpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzaWxlbnQgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gb3V0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuZXh0X25hbWVvZmYgKz0gZGVfbmFtZWxlbjs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArK2RlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmIChwcmV2X25hbWUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZnJlZShwcmV2X25hbWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByZXZfbmFt
ZSA9IGN1cl9uYW1lOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGN1cl9uYW1lID0gTlVM
TDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK291dDo8YnI+DQorwqAgwqAgwqAgwqBpZiAocHJl
dl9uYW1lKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWUocHJldl9uYW1lKTs8YnI+
DQorwqAgwqAgwqAgwqBpZiAoY3VyX25hbWUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnJlZShjdXJfbmFtZSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJldCAmYW1wOyZhbXA7ICFzaWxl
bnQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfZXJyKCZxdW90OyVzIEAgbmlk
ICVsbHUsIGxibGsgJXUsIGluZGV4ICVsdSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJtc2csIGN0eC0mZ3Q7ZGlyLSZndDtuaWQgfCAwVUxMLCBs
YmxrLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChkZSAtIChz
dHJ1Y3QgZXJvZnNfZGlyZW50ICopZGVudHJ5X2JsaykgfCAwVUwpOzxicj4NCivCoCDCoCDCoCDC
oHJldHVybiByZXQ7PGJyPg0KK308YnI+DQorPGJyPg0KK2ludCBlcm9mc19pdGVyYXRlX2Rpcihz
dHJ1Y3QgZXJvZnNfZGlyX2NvbnRleHQgKmN0eCwgYm9vbCBmc2NrKTxicj4NCit7PGJyPg0KK8Kg
IMKgIMKgIMKgc3RydWN0IGVyb2ZzX2lub2RlICpkaXIgPSBjdHgtJmd0O2Rpcjs8YnI+DQorwqAg
wqAgwqAgwqBpbnQgZXJyOzxicj4NCivCoCDCoCDCoCDCoGVyb2ZzX29mZl90IHBvczs8YnI+DQor
wqAgwqAgwqAgwqBjaGFyIGJ1ZltFUk9GU19CTEtTSVpdOzxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqBpZiAoKGRpci0mZ3Q7aV9tb2RlICZhbXA7IFNfSUZNVCkgIT0gU19JRkRJUik8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVOT1RESVI7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoGN0eC0mZ3Q7ZmxhZ3MgJmFtcDs9IH5FUk9GU19SRUFERElSX0FMTF9TUEVDSUFMX0ZPVU5E
Ozxicj4NCivCoCDCoCDCoCDCoHBvcyA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgd2hpbGUgKHBvcyAm
bHQ7IGRpci0mZ3Q7aV9zaXplKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNf
YmxrX3QgbGJsayA9IGVyb2ZzX2Jsa25yKHBvcyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZXJvZnNfb2ZmX3QgbWF4c2l6ZSA9IG1pbl90KGVyb2ZzX29mZl90LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpci0m
Z3Q7aV9zaXplIC0gcG9zLCBFUk9GU19CTEtTSVopOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvbnN0IHN0cnVjdCBlcm9mc19kaXJlbnQgKmRlID0gKGNvbnN0IHZvaWQgKilidWY7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdW5zaWduZWQgaW50IG5hbWVvZmY7PGJyPg0KKzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IGVyb2ZzX3ByZWFkKGRpciwgYnVmLCBt
YXhzaXplLCBwb3MpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChlcnIpIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1b3Q7SS9P
IGVycm9yIG9jY3VycmVkIHdoZW4gcmVhZGluZyBkaXJlbnRzIEAgbmlkICVsbHUsIGxibGsgJXU6
ICVkJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGRpci0mZ3Q7bmlkIHwgMFVMTCwgbGJsaywgZXJyKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZXJyOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9
IGxlMTZfdG9fY3B1KGRlLSZndDtuYW1lb2ZmKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAobmFtZW9mZiAmbHQ7IHNpemVvZihzdHJ1Y3QgZXJvZnNfZGlyZW50KSB8fDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5hbWVvZmYgJmd0Oz0gUEFHRV9TSVpFKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfZXJyKCZxdW90O2lu
dmFsaWQgZGVbMF0ubmFtZW9mZiAldSBAIG5pZCAlbGx1LCBsYmxrICV1JnF1b3Q7LDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5hbWVvZmYs
IGRpci0mZ3Q7bmlkIHwgMFVMTCwgbGJsayk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIC1FRlNDT1JSVVBURUQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IHRyYXZlcnNlX2RpcmVu
dHMoY3R4LCBidWYsIGxibGssIG5hbWVvZmYsIG1heHNpemUsIGZzY2spOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChlcnIpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9zICs9IG1heHNp
emU7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoZnNjayAm
YW1wOyZhbXA7IChjdHgtJmd0O2ZsYWdzICZhbXA7IEVST0ZTX1JFQURESVJfQUxMX1NQRUNJQUxf
Rk9VTkQpICE9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJPRlNf
UkVBRERJUl9BTExfU1BFQ0lBTF9GT1VORCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVyb2ZzX2VycigmcXVvdDtgLiYjMzk7IG9yIGAuLiYjMzk7IGRpcmVudCBpcyBtaXNzaW5nIEAg
bmlkICVsbHUmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZGlyLSZndDtuaWQgfCAwVUxMKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLUVGU0NPUlJVUFRFRDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgcmV0
dXJuIDA7PGJyPg0KK308YnI+DQotLSA8YnI+DQoyLjI0LjQ8YnI+DQo8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj5TaW5jZXJlbHksPGRp
dj48YnI+PC9kaXY+PGRpdj5LZWx2aW4gWmhhbmc8L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000d4eb6f05d332fbec--
