Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83E75F3AD
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 12:44:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=kUvN9hA+;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R8cGh12Kkz2yVq
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jul 2023 20:44:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=kUvN9hA+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R8cGY2yG3z2xW7
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 20:44:03 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668711086f4so2657785b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jul 2023 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690195441; x=1690800241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoQSksrVA5uDRjBI0hbz8Zcuh+/ajlKLUkkxrZnumus=;
        b=kUvN9hA+xrIq6+w92JFQeMUzWRbW1wBNJYeMfnLQeN0p4Zblzzv/8r+kUVcQn1XnrW
         UTrFg/MsITmfmZgKp5+YXCwiP9XLWGjJIqQAn1NiAiHfBre6qLx4RDo3c294As2YaVgp
         Jsg1eVMNtHo4ScsLXWcOsR9IjzP+qWm4qzbRQmtpSc6e67IAgP8tHrgSgg+pCEQ3Mdov
         VZulE+kGlrYGyUdAQB2kMBz5gWdapBhI1QaMG3DimIsugT4LOMzd+EuQdqiamwCuvQUT
         8I5x/t/atE2PAiOdBsUAuOp0Tb/IkGh56mVXl97L1ijz7wnHZoWtrTJpDX4IhRVwaLF9
         Nn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690195441; x=1690800241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoQSksrVA5uDRjBI0hbz8Zcuh+/ajlKLUkkxrZnumus=;
        b=FAUYos7ruhSnk75kHsDltSAWtiOxtAZ0rUaZhvS3vypB9dbMvgFW2+M7HmlmREYthk
         iUxGUNQo0zNrUnzgfjNJlbMkgaNHdl0NX01Ml3N5/i90v1bulyZ5UUI3XiHPYNL475aL
         0dQxIY8zGLNnmkku4Ozh03a281hCbLA4Ua7nGoFrrrrbMyTIR9DSLn09e7HvhHGiDM03
         dKLnai+2WKeuit/ZKvmO7EwuJ0TL6O7WI4BH/m3CRpodXyZFHuwDABcUKA8W5dxkUa88
         DjuOC9hfiDDEm9yOt+ayf6G07ce70pWJZf5R1s6ejrQXNZXmFepM3ly7tdU94ePKrtmx
         WILg==
X-Gm-Message-State: ABy/qLZiy/l/RE4AGvssKkr0Vh8vUAErRe28/W5ThBQA3NS7xmVoCa6q
	KvU+K3kgK8PUhjLAWPTp3sU=
X-Google-Smtp-Source: APBJJlFFwn0GIsuAi1U6YyDncfL3fE7es4INjn/80f4iDmVOjsyDsvUEIQMiTPd5uPjob2LYUZnMaw==
X-Received: by 2002:a05:6a20:4294:b0:133:5ed9:f00b with SMTP id o20-20020a056a20429400b001335ed9f00bmr12970586pzj.13.1690195441136;
        Mon, 24 Jul 2023 03:44:01 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7810c000000b006833b73c749sm7484980pfi.22.2023.07.24.03.43.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2023 03:44:00 -0700 (PDT)
Date: Mon, 24 Jul 2023 18:53:12 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Li Yiyan <lyy0627@sjtu.edu.cn>
Subject: Re: [PATCH] erofs-utils: add support for fuse 2/3 lowlevel API
Message-ID: <20230724185312.00001c51.zbestahu@gmail.com>
In-Reply-To: <20230724053527.3474082-1-lyy0627@sjtu.edu.cn>
References: <20230724053527.3474082-1-lyy0627@sjtu.edu.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yiyan,

Thanks for the patch!  Some comments below...

On Mon, 24 Jul 2023 13:35:27 +0800
Li Yiyan <lyy0627@sjtu.edu.cn> wrote:

> Add support for fuse2/3 lowlevel API in erofsfuse,
> pass the make check test in experimental-test branch.
> Conduct performance evaluation, providing higher
> performance compared to highlevel API while
> retaining compatibility with highlevel API of fuse 2.
> 
> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
> ---
>  configure.ac     |  26 ++-
>  fuse/Makefile.am |   6 +-
>  fuse/lowlevel.c  | 553 +++++++++++++++++++++++++++++++++++++++++++++++
>  fuse/main.c      |  83 ++++++-
>  4 files changed, 653 insertions(+), 15 deletions(-)
>  create mode 100644 fuse/lowlevel.c
> 
> diff --git a/configure.ac b/configure.ac
> index a8cecd0..d8d648e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -336,15 +336,27 @@ AS_IF([test "x$with_selinux" != "xno"], [
>  
>  # Configure fuse
>  AS_IF([test "x$enable_fuse" != "xno"], [
> -  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
> -  # Paranoia: don't trust the result reported by pkgconfig before trying out
>    saved_LIBS="$LIBS"
>    saved_CPPFLAGS=${CPPFLAGS}
> -  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
> -  LIBS="${libfuse_LIBS} $LIBS"
> -  AC_CHECK_LIB(fuse, fuse_main, [
> -    have_fuse="yes" ], [
> -    AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly])])
> +  PKG_CHECK_MODULES([libfuse3], [fuse3 >= 3.0], [
> +    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
> +    CPPFLAGS="${libfuse3_CFLAGS} ${CPPFLAGS}"
> +    LIBS="${libfuse3_LIBS} $LIBS"
> +    AC_CHECK_LIB(fuse3, fuse_session_new, [ AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if libfuse lowlevel api available]) ], [
> +    AC_MSG_ERROR([libfuse3 (>= 3.0) doesn't work properly for lowlevel api])])
> +    have_fuse="yes"
> +  ], [
> +    PKG_CHECK_MODULES([libfuse2], [fuse >= 2.6], [
> +      AC_DEFINE([FUSE_USE_VERSION], [26], [used FUSE API version])
> +      CPPFLAGS="${libfuse2_CFLAGS} ${CPPFLAGS}"
> +      LIBS="${libfuse2_LIBS} $LIBS"
> +      AC_CHECK_LIB(fuse, fuse_lowlevel_new, [ AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if libfuse lowlevel api available]) ], [
> +        AC_MSG_NOTICE([libfuse (>= 2.6) doesn't work properly for lowlevel api])])
> +      AC_CHECK_LIB(fuse, fuse_main, , [
> +        AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly for highlevel api and lowlevel api])])
> +      have_fuse="yes"
> +    ], [have_fuse="no"])
> +  ])

We may drop high level part if low level is working fine, so `USE_LOWLEVEL` is unneeded.

>    LIBS="${saved_LIBS}"
>    CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
>  
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 50be783..d54fc89 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -3,8 +3,8 @@
>  AUTOMAKE_OPTIONS = foreign
>  noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
>  bin_PROGRAMS     = erofsfuse
> -erofsfuse_SOURCES = main.c
> +erofsfuse_SOURCES = main.c lowlevel.c
>  erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
> -erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
> -erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
> +erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
> +erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
>  	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> diff --git a/fuse/lowlevel.c b/fuse/lowlevel.c
> new file mode 100644
> index 0000000..89d3077
> --- /dev/null
> +++ b/fuse/lowlevel.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Created by Li Yiyan <lyy0627@sjtu.edu.com>
> + */
> +#include "erofs/config.h"
> +#include "erofs/dir.h"
> +#include "erofs/inode.h"
> +#include "erofs/io.h"
> +#include "erofs/print.h"
> +#include "macosx.h"
> +#include "config.h"
> +#include <fuse_opt.h>
> +#include <libgen.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <float.h>
> +
> +#if FUSE_USE_VERSION >= 30
> +#include <fuse3/fuse_lowlevel.h>
> +#include <fuse3/fuse.h>
> +#else
> +#include <fuse.h>
> +#include <fuse_lowlevel.h>
> +#endif
> +
> +#define TMP_BUF_SIZE 4096

I'm not sure it's a good definition.

> +static const double EROFS_TIMEOUT = DBL_MAX;
> +
> +struct erofsfuse_ll_dir_context {
> +	struct erofs_dir_context ctx;
> +
> +	fuse_req_t req;
> +	void *buf;
> +	int is_plus;
> +	size_t offset;
> +	size_t buf_size;
> +	size_t start_off;
> +	struct fuse_file_info *fi;
> +};
> +
> +struct erofsfuse_ll_dir_search_context {
> +	struct erofs_dir_context ctx;
> +
> +	const char *target_name;
> +	size_t target_name_len;
> +	struct fuse_entry_param *ent;
> +};
> +
> +static int erofsfuse_ll_fill_dentries(struct erofs_dir_context *ctx)
> +{
> +	size_t r = 0;
> +	struct stat st = { 0 };
> +#if FUSE_USE_VERSION >= 30
> +	struct fuse_entry_param param;
> +#endif
> +	char dname[EROFS_NAME_LEN + 1];
> +	struct erofsfuse_ll_dir_context *fusectx = (void *)ctx;

Why using void pointer cast?

> +
> +	if (fusectx->offset < fusectx->start_off) {
> +		fusectx->offset +=
> +			ctx->de_namelen + sizeof(struct erofs_dirent);
> +		return 0;
> +	}
> +
> +	strncpy(dname, ctx->dname, ctx->de_namelen);
> +	dname[ctx->de_namelen] = '\0';
> +	fusectx->offset += ctx->de_namelen + sizeof(struct erofs_dirent);
> +
> +	if (!fusectx->is_plus) {

Why need `is_plus`? Could we move this part under #else branch instead?

> +		st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
> +		st.st_ino = ctx->de_nid;
> +
> +		r = fuse_add_direntry(fusectx->req, fusectx->buf,
> +				      fusectx->buf_size, dname, &st,
> +				      fusectx->offset);
> +	} else {
> +#if FUSE_USE_VERSION >= 30
> +		param.ino = ctx->de_nid;
> +		param.generation = 0;
> +		param.attr.st_ino = ctx->de_nid;
> +		param.attr.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
> +		param.attr_timeout = EROFS_TIMEOUT;
> +		param.entry_timeout = EROFS_TIMEOUT;
> +
> +		r = fuse_add_direntry_plus(fusectx->req, fusectx->buf,
> +					   fusectx->buf_size, dname, &param,
> +					   fusectx->offset);
> +#endif
> +	}
> +
> +	if (r > fusectx->buf_size) {
> +		fusectx->offset -=
> +			ctx->de_namelen + sizeof(struct erofs_dirent);
> +		return 1;
> +	}
> +	fusectx->buf += r;
> +	fusectx->buf_size -= r;
> +	return 0;
> +}
> +
> +static void erofsfuse_ll_fill_stat(struct erofs_inode *vi, struct stat *stbuf)
> +{
> +	stbuf->st_mode = vi->i_mode;
> +	stbuf->st_nlink = vi->i_nlink;
> +
> +	if (!S_ISDIR(stbuf->st_mode))
> +		stbuf->st_size = vi->i_size;
> +	if (S_ISBLK(vi->i_mode) || S_ISCHR(vi->i_mode))
> +		stbuf->st_rdev = vi->u.i_rdev;
> +
> +	stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz()) >> 9;
> +
> +	stbuf->st_uid = vi->i_uid;
> +	stbuf->st_gid = vi->i_gid;
> +
> +	stbuf->st_ctime = vi->i_mtime;
> +	stbuf->st_mtime = stbuf->st_ctime;
> +	stbuf->st_atime = stbuf->st_ctime;
> +}
> +
> +static int erofsfuse_ll_search_dentries(struct erofs_dir_context *ctx)
> +{
> +	int r = 0;
> +	struct erofs_inode vi;
> +	struct erofsfuse_ll_dir_search_context *search_ctx = (void *)ctx;

Why using void pointer cast?

> +
> +	if (search_ctx->ent->ino == 0 &&
> +	    search_ctx->target_name_len == ctx->de_namelen &&
> +	    strncmp(search_ctx->target_name, ctx->dname, ctx->de_namelen) ==
> +		    0) {
> +		search_ctx->ent->ino = ctx->de_nid;
> +		search_ctx->ent->attr.st_ino = ctx->de_nid;
> +		vi.nid = (erofs_nid_t)ctx->de_nid;
> +
> +		r = erofs_read_inode_from_disk(&vi);
> +		if (r < 0)
> +			return r;
> +
> +		erofsfuse_ll_fill_stat(&vi, &(search_ctx->ent->attr));
> +	}
> +
> +	return 0;
> +}
> +
> +void erofsfuse_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> +			  off_t off, struct fuse_file_info *fi)
> +{
> +	int err = 0;
> +	char *buf = malloc(size);
> +	struct erofsfuse_ll_dir_context ctx;
> +	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
> +
> +	erofs_dbg("readdir, ino: %lu, req: %p, fh: %lu, size: %lu, off: %lu\n",
> +		  ino, req, fi->fh, size, off);
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +	ctx.ctx.dir = vi;
> +	ctx.ctx.cb = erofsfuse_ll_fill_dentries;
> +
> +	ctx.fi = fi;
> +	ctx.buf = buf;
> +	ctx.buf_size = size;
> +	ctx.req = req;
> +	ctx.offset = 0;
> +	ctx.is_plus = 0;
> +	ctx.start_off = off;
> +
> +#ifdef NDEBUG
> +	err = erofs_iterate_dir(&ctx.ctx, false);
> +#else
> +	err = erofs_iterate_dir(&ctx.ctx, true);
> +#endif
> +
> +	if (err < 0) /* if buffer insufficient, return 1 */
> +		fuse_reply_err(req, EIO);
> +	else
> +		fuse_reply_buf(req, buf, size - ctx.buf_size);
> +
> +	free(buf);
> +}
> +
> +void erofsfuse_ll_init(void *userdata, struct fuse_conn_info *conn)
> +{
> +	erofs_inode_manager_init();
> +}
> +
> +void erofsfuse_ll_open(fuse_req_t req, fuse_ino_t ino,
> +		       struct fuse_file_info *fi)
> +{
> +	int ret = 0;
> +	struct erofs_inode *vi;
> +
> +	erofs_dbg("open, ino = %lu, req = %p\n", ino, req);
> +	if (fi->flags & (O_WRONLY | O_RDWR)) {
> +		fuse_reply_err(req, EROFS);
> +		return;
> +	}
> +
> +	if (ino == FUSE_ROOT_ID) {
> +		fuse_reply_err(req, EISDIR);
> +		return;
> +	}
> +
> +	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
> +	if (!vi) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	vi->nid = (erofs_nid_t)ino;
> +	ret = erofs_read_inode_from_disk(vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +
> +	if (!S_ISREG(vi->i_mode)) {
> +		fuse_reply_err(req, EISDIR);
> +		goto out;

goto is not needed.

> +	} else {
> +		fi->fh = (uint64_t)vi;
> +		fi->keep_cache = 1;
> +		fuse_reply_open(req, fi);
> +		return;
> +	}
> +
> +out:
> +	free(vi);
> +}
> +
> +void erofsfuse_ll_getattr(fuse_req_t req, fuse_ino_t ino,
> +			  struct fuse_file_info *fi)
> +{
> +	int ret;
> +	struct stat stbuf = { 0 };
> +	struct erofs_inode vi;
> +
> +	erofs_dbg("getattr triggered, ino: %lu, req: %p\n", ino, req);
> +	vi.nid = ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;

We use this in a couple of places.

> +	ret = erofs_read_inode_from_disk(&vi);
> +	if (ret < 0) {
> +		erofs_dbg("read inode from disk failed, nid = %lu\n", vi.nid);
> +		fuse_reply_err(req, ENOENT);
> +	}
> +
> +	erofsfuse_ll_fill_stat(&vi, &stbuf);
> +	stbuf.st_ino = ino;
> +
> +	fuse_reply_attr(req, &stbuf, EROFS_TIMEOUT);
> +}
> +
> +void erofsfuse_ll_opendir(fuse_req_t req, fuse_ino_t ino,
> +			  struct fuse_file_info *fi)
> +{
> +	int ret;
> +	struct erofs_inode *vi;
> +
> +	erofs_dbg("opendir, ino = %lu\n", ino);
> +	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
> +	if (!vi) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	vi->nid = ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
> +	ret = erofs_read_inode_from_disk(vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +
> +	if (!S_ISDIR(vi->i_mode)) {
> +		fuse_reply_err(req, ENOTDIR);
> +		goto out;
> +	}
> +
> +	fi->fh = (uint64_t)vi;
> +	fuse_reply_open(req, fi);
> +	return;
> +
> +out:
> +	free(vi);
> +}
> +
> +void erofsfuse_ll_releasedir(fuse_req_t req, fuse_ino_t ino,
> +			     struct fuse_file_info *fi)
> +{
> +	free((struct erofs_inode *)fi->fh);
> +	fi->fh = 0;
> +	fuse_reply_err(req, 0);
> +}
> +
> +void erofsfuse_ll_release(fuse_req_t req, fuse_ino_t ino,
> +			  struct fuse_file_info *fi)
> +{
> +	free((struct erofs_inode *)fi->fh);
> +	fi->fh = 0;
> +	fuse_reply_err(req, 0);
> +}

duplicated function code.

> +
> +void erofsfuse_ll_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
> +{
> +	int err, ret;
> +	struct erofs_inode *vi;
> +	struct fuse_entry_param fentry;
> +	struct erofsfuse_ll_dir_search_context ctx;
> +
> +	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
> +	if (!vi) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	vi->nid = parent == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)parent;
> +	ret = erofs_read_inode_from_disk(vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +	if (!S_ISDIR(vi->i_mode)) {
> +		fuse_reply_err(req, ENOTDIR);
> +		goto out;
> +	}
> +
> +	memset(&fentry, 0, sizeof(fentry));
> +	fentry.ino = 0;
> +	fentry.attr_timeout = fentry.entry_timeout = EROFS_TIMEOUT;
> +	ctx.ctx.dir = vi;
> +	ctx.ctx.cb = erofsfuse_ll_search_dentries;
> +
> +	ctx.ent = &fentry;
> +	ctx.target_name = name;
> +	ctx.target_name_len = strlen(name);
> +
> +#ifdef NDEBUG
> +	err = erofs_iterate_dir(&ctx.ctx, false);
> +#else
> +	err = erofs_iterate_dir(&ctx.ctx, true);
> +#endif
> +
> +	if (err < 0) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +	fuse_reply_entry(req, &fentry);
> +
> +out:
> +	free(vi);
> +}
> +
> +void erofsfuse_ll_read(fuse_req_t req, fuse_ino_t ino, size_t size, off_t off,
> +		       struct fuse_file_info *fi)
> +{
> +	int ret;
> +	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
> +	char *buf = malloc(size);
> +
> +	erofs_dbg("read, ino = %lu, size = %lu, off = %lu, fh = %lu\n", ino,
> +		  size, off, fi->fh);
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	if (!S_ISREG(vi->i_mode)) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +
> +	ret = erofs_pread(vi, buf, size, off);
> +	if (ret == 0) {
> +		if (off >= vi->i_size)
> +			ret = 0;
> +		else if (off + size > vi->i_size)
> +			ret = vi->i_size - off;
> +		else
> +			ret = size;
> +	} else {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}

	if (ret) {
		fuse_reply_err(req, EIO);
		goto out;
	}
	if (off >= vi->i_size)
		ret = 0;
	else if (off + size > vi->i_size)
		ret = vi->i_size - off;
	else
		ret = size;

> +
> +	fuse_reply_buf(req, buf, ret);
> +
> +out:
> +	free(buf);
> +}
> +
> +void erofsfuse_ll_readlink(fuse_req_t req, fuse_ino_t ino)
> +{
> +	int ret;
> +	char *dst;
> +	struct erofs_inode vi;
> +
> +	erofs_dbg("read_link, ino = %lu\n", ino);
> +	vi.nid = ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
> +	ret = erofs_read_inode_from_disk(&vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		return;
> +	}
> +
> +	if (!S_ISLNK(vi.i_mode)) {
> +		fuse_reply_err(req, EINVAL);
> +		return;
> +	}
> +
> +	dst = malloc(vi.i_size + 1);
> +	if (!dst) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	ret = erofs_pread(&vi, dst, vi.i_size, 0);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		goto out;
> +	}
> +
> +	dst[vi.i_size] = '\0';
> +	fuse_reply_readlink(req, dst);
> +
> +out:
> +	free(dst);
> +}
> +
> +void erofsfuse_ll_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
> +			   size_t size)
> +{
> +	int ret;
> +	char *buf = NULL;
> +	struct erofs_inode vi;
> +	size_t real = size == 0 ? TMP_BUF_SIZE : size;
> +
> +	erofs_dbg("getxattr, ino = %lu, name = %s, size = %lu\n", ino, name,
> +		  size);
> +	vi.nid = ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
> +	ret = erofs_read_inode_from_disk(&vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		return;
> +	}
> +
> +	buf = malloc(real);
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	ret = erofs_getxattr(&vi, name, buf, real);
> +	if (ret < 0)
> +		fuse_reply_err(req, -ret);
> +	else if (size == 0)
> +		fuse_reply_xattr(req, ret);
> +	else
> +		fuse_reply_buf(req, buf, ret);
> +
> +	free(buf);
> +}
> +
> +void erofsfuse_ll_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
> +{
> +	int ret;
> +	char *buf = NULL;
> +	struct erofs_inode vi;
> +	size_t real = size == 0 ? TMP_BUF_SIZE : size;
> +
> +	erofs_dbg("listxattr, ino = %lu, size = %lu\n", ino, size);
> +	vi.nid = ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
> +	ret = erofs_read_inode_from_disk(&vi);
> +	if (ret < 0) {
> +		fuse_reply_err(req, EIO);
> +		return;
> +	}
> +
> +	buf = malloc(real);
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	ret = erofs_listxattr(&vi, buf, real);
> +	if (ret < 0)
> +		fuse_reply_err(req, -ret);
> +	else if (size == 0)
> +		fuse_reply_xattr(req, ret);
> +	else
> +		fuse_reply_buf(req, buf, ret);
> +
> +	free(buf);
> +}
> +
> +#if FUSE_USE_VERSION >= 30
> +void erofsfuse_ll_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
> +			      off_t off, struct fuse_file_info *fi)
> +{
> +	int err = 0;
> +	char *buf = malloc(size);
> +	struct erofsfuse_ll_dir_context ctx;
> +	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
> +
> +	erofs_dbg("readdirplus, ino = %lu, size = %lu, off = %lu, fh = %lu\n",
> +		  ino, size, off, fi->fh);
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +	ctx.ctx.dir = vi;
> +	ctx.ctx.cb = erofsfuse_ll_fill_dentries;
> +
> +	ctx.fi = fi;
> +	ctx.buf = buf;
> +	ctx.buf_size = size;
> +	ctx.req = req;
> +	ctx.offset = 0;
> +	ctx.is_plus = 1;
> +	ctx.start_off = off;
> +
> +#ifdef NDEBUG
> +	err = erofs_iterate_dir(&ctx.ctx, false);
> +#else
> +	err = erofs_iterate_dir(&ctx.ctx, true);
> +#endif
> +
> +	if (err < 0) /* if buffer insufficient, return 1 */
> +		fuse_reply_err(req, EIO);
> +	else
> +		fuse_reply_buf(req, buf, size - ctx.buf_size);
> +
> +	free(buf);
> +}

almost same as _readdir() except `is_plus`.

> +#endif
> +
> +struct fuse_lowlevel_ops erofsfuse_lops = {
> +	.getxattr = erofsfuse_ll_getxattr,
> +	.opendir = erofsfuse_ll_opendir,
> +	.releasedir = erofsfuse_ll_releasedir,
> +	.release = erofsfuse_ll_release,
> +	.lookup = erofsfuse_ll_lookup,
> +	.listxattr = erofsfuse_ll_listxattr,
> +	.readlink = erofsfuse_ll_readlink,
> +	.getattr = erofsfuse_ll_getattr,
> +	.readdir = erofsfuse_ll_readdir,
> +#if FUSE_USE_VERSION >= 30
> +	.readdirplus = erofsfuse_ll_readdirplus,
> +#endif
> +	.open = erofsfuse_ll_open,
> +	.read = erofsfuse_ll_read,
> +	.init = erofsfuse_ll_init,
> +};

all functions above should be static.

> diff --git a/fuse/main.c b/fuse/main.c
> index b060e06..11726c1 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -6,8 +6,6 @@
>  #include <string.h>
>  #include <signal.h>
>  #include <libgen.h>
> -#include <fuse.h>
> -#include <fuse_opt.h>
>  #include "macosx.h"
>  #include "erofs/config.h"
>  #include "erofs/print.h"
> @@ -15,6 +13,23 @@
>  #include "erofs/dir.h"
>  #include "erofs/inode.h"
>  
> +#if FUSE_USE_VERSION >= 30
> +#include <fuse3/fuse.h>
> +#include <fuse3/fuse_lowlevel.h>
> +#else
> +#include <fuse.h>
> +#include <fuse_lowlevel.h>
> +#endif
> +
> +#if USE_LOWLEVEL

no needed.

> +#include <float.h>
> +
> +extern struct fuse_lowlevel_ops erofsfuse_lops;
> +
> +struct erofs_ll_ctx {
> +	unsigned int debug_lvl;

any user?

> +};
> +#else
>  struct erofsfuse_dir_context {
>  	struct erofs_dir_context ctx;
>  	fuse_fill_dir_t filler;
> @@ -176,7 +191,7 @@ static int erofsfuse_listxattr(const char *path, char *list, size_t size)
>  	return erofs_listxattr(&vi, list, size);
>  }
>  
> -static struct fuse_operations erofs_ops = {
> +static struct fuse_operations erofsfuse_ops = {
>  	.getxattr = erofsfuse_getxattr,
>  	.listxattr = erofsfuse_listxattr,
>  	.readlink = erofsfuse_readlink,
> @@ -187,6 +202,8 @@ static struct fuse_operations erofs_ops = {
>  	.init = erofsfuse_init,
>  };
>  
> +#endif
> +
>  static struct options {
>  	const char *disk;
>  	const char *mountpoint;
> @@ -207,7 +224,9 @@ static const struct fuse_opt option_spec[] = {
>  
>  static void usage(void)
>  {
> +#if FUSE_MAJOR_VERSION < 3
>  	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
> +#endif
>  
>  	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
>  	      "Options:\n"
> @@ -257,8 +276,12 @@ static int optional_opt_func(void *data, const char *arg, int key,
>  			fusecfg.disk = strdup(arg);
>  			return 0;
>  		}
> -		if (!fusecfg.mountpoint)
> +		if (!fusecfg.mountpoint) {
>  			fusecfg.mountpoint = strdup(arg);
> +#if USE_LOWLEVEL

no needed.

> +			return 0;
> +#endif
> +		}
>  	case FUSE_OPT_KEY_OPT:
>  		if (!strcmp(arg, "-d"))
>  			fusecfg.odebug = true;
> @@ -337,8 +360,58 @@ int main(int argc, char *argv[])
>  		goto err_dev_close;
>  	}
>  
> -	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
> +#if USE_LOWLEVEL

no needed.

> +	struct erofs_ll_ctx *ll_ctx;
> +	struct fuse_session *se;
> +
> +	ll_ctx = malloc(sizeof(struct erofs_ll_ctx));
> +	if (!ll_ctx) {
> +		fprintf(stderr, "failed to alloc memory for ll_ctx\n");
> +		goto err_sb_put;
> +	}
> +
> +#if FUSE_USE_VERSION >= 30
> +	se = fuse_session_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
> +			      ll_ctx);
> +	if (se != NULL) {
> +		fuse_set_signal_handlers(se);
> +		fuse_session_mount(se, fusecfg.mountpoint);
> +
> +		ret = fuse_session_loop(se);
> +
> +		fuse_remove_signal_handlers(se);
> +		fuse_session_unmount(se);
> +		fuse_session_destroy(se);
> +	}
> +#else
> +	struct fuse_chan *ch;
> +
> +	ch = fuse_mount(fusecfg.mountpoint, &args);
> +	if (ch != NULL) {
> +		se = fuse_lowlevel_new(&args, &erofsfuse_lops,
> +				       sizeof(erofsfuse_lops), ll_ctx);
> +		if (se != NULL) {
> +			if (fuse_set_signal_handlers(se) != -1) {
> +				fuse_session_add_chan(se, ch);
> +				ret = fuse_session_loop(se);
> +				fuse_remove_signal_handlers(se);
> +				fuse_session_remove_chan(ch);
> +			}
> +			fuse_session_destroy(se);
> +		}
> +		fuse_unmount(fusecfg.mountpoint, ch);
> +	}
> +#endif
> +
> +	free(ll_ctx);
>  
> +#else
> +	ret = fuse_main(args.argc, args.argv, &erofsfuse_ops, NULL);
> +#endif
> +
> +#if USE_LOWLEVEL

no needed.

> +err_sb_put:
> +#endif
>  	erofs_put_super();
>  err_dev_close:
>  	blob_closeall();

