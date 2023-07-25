Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900A760523
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 04:18:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R91093KbHz30Q3
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 12:18:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R91014PnJz2ytl
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 12:17:51 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id CDD601009011B;
	Tue, 25 Jul 2023 10:17:45 +0800 (CST)
Received: from smtpclient.apple (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6CD5037C923;
	Tue, 25 Jul 2023 10:17:41 +0800 (CST)
From: SJTU <lyy0627@sjtu.edu.cn>
Message-Id: <06D382B0-56F7-44FF-90DD-2F496B6DD80B@sjtu.edu.cn>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_565CB21E-1B81-4CC7-816A-B75308D00437"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] erofs-utils: add support for fuse 2/3 lowlevel API
Date: Tue, 25 Jul 2023 10:17:31 +0800
In-Reply-To: <20230724185312.00001c51.zbestahu@gmail.com>
To: Yue Hu <zbestahu@gmail.com>
References: <20230724053527.3474082-1-lyy0627@sjtu.edu.cn>
 <20230724185312.00001c51.zbestahu@gmail.com>
X-Mailer: Apple Mail (2.3731.600.7)
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


--Apple-Mail=_565CB21E-1B81-4CC7-816A-B75308D00437
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2023=E5=B9=B47=E6=9C=8824=E6=97=A5 18:53=EF=BC=8CYue Hu =
<zbestahu@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Yiyan,
>=20
> Thanks for the patch!  Some comments below...
>=20
> On Mon, 24 Jul 2023 13:35:27 +0800
> Li Yiyan <lyy0627@sjtu.edu.cn <mailto:lyy0627@sjtu.edu.cn>> wrote:
>=20
>> Add support for fuse2/3 lowlevel API in erofsfuse,
>> pass the make check test in experimental-test branch.
>> Conduct performance evaluation, providing higher
>> performance compared to highlevel API while
>> retaining compatibility with highlevel API of fuse 2.
>>=20
>> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
>> ---
>> configure.ac     |  26 ++-
>> fuse/Makefile.am |   6 +-
>> fuse/lowlevel.c  | 553 =
+++++++++++++++++++++++++++++++++++++++++++++++
>> fuse/main.c      |  83 ++++++-
>> 4 files changed, 653 insertions(+), 15 deletions(-)
>> create mode 100644 fuse/lowlevel.c
>>=20
>> diff --git a/configure.ac b/configure.ac
>> index a8cecd0..d8d648e 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -336,15 +336,27 @@ AS_IF([test "x$with_selinux" !=3D "xno"], [
>>=20
>> # Configure fuse
>> AS_IF([test "x$enable_fuse" !=3D "xno"], [
>> -  PKG_CHECK_MODULES([libfuse], [fuse >=3D 2.6])
>> -  # Paranoia: don't trust the result reported by pkgconfig before =
trying out
>>   saved_LIBS=3D"$LIBS"
>>   saved_CPPFLAGS=3D${CPPFLAGS}
>> -  CPPFLAGS=3D"${libfuse_CFLAGS} ${CPPFLAGS}"
>> -  LIBS=3D"${libfuse_LIBS} $LIBS"
>> -  AC_CHECK_LIB(fuse, fuse_main, [
>> -    have_fuse=3D"yes" ], [
>> -    AC_MSG_ERROR([libfuse (>=3D 2.6) doesn't work properly])])
>> +  PKG_CHECK_MODULES([libfuse3], [fuse3 >=3D 3.0], [
>> +    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
>> +    CPPFLAGS=3D"${libfuse3_CFLAGS} ${CPPFLAGS}"
>> +    LIBS=3D"${libfuse3_LIBS} $LIBS"
>> +    AC_CHECK_LIB(fuse3, fuse_session_new, [ =
AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if libfuse lowlevel api =
available]) ], [
>> +    AC_MSG_ERROR([libfuse3 (>=3D 3.0) doesn't work properly for =
lowlevel api])])
>> +    have_fuse=3D"yes"
>> +  ], [
>> +    PKG_CHECK_MODULES([libfuse2], [fuse >=3D 2.6], [
>> +      AC_DEFINE([FUSE_USE_VERSION], [26], [used FUSE API version])
>> +      CPPFLAGS=3D"${libfuse2_CFLAGS} ${CPPFLAGS}"
>> +      LIBS=3D"${libfuse2_LIBS} $LIBS"
>> +      AC_CHECK_LIB(fuse, fuse_lowlevel_new, [ =
AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if libfuse lowlevel api =
available]) ], [
>> +        AC_MSG_NOTICE([libfuse (>=3D 2.6) doesn't work properly for =
lowlevel api])])
>> +      AC_CHECK_LIB(fuse, fuse_main, , [
>> +        AC_MSG_ERROR([libfuse (>=3D 2.6) doesn't work properly for =
highlevel api and lowlevel api])])
>> +      have_fuse=3D"yes"
>> +    ], [have_fuse=3D"no"])
>> +  ])
>=20
> We may drop high level part if low level is working fine, so =
`USE_LOWLEVEL` is unneeded.

Thanks.

>=20
>>   LIBS=3D"${saved_LIBS}"
>>   CPPFLAGS=3D"${saved_CPPFLAGS}"], [have_fuse=3D"no"])
>>=20
>> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
>> index 50be783..d54fc89 100644
>> --- a/fuse/Makefile.am
>> +++ b/fuse/Makefile.am
>> @@ -3,8 +3,8 @@
>> AUTOMAKE_OPTIONS =3D foreign
>> noinst_HEADERS =3D $(top_srcdir)/fuse/macosx.h
>> bin_PROGRAMS     =3D erofsfuse
>> -erofsfuse_SOURCES =3D main.c
>> +erofsfuse_SOURCES =3D main.c lowlevel.c
>> erofsfuse_CFLAGS =3D -Wall -I$(top_srcdir)/include
>> -erofsfuse_CFLAGS +=3D -DFUSE_USE_VERSION=3D26 ${libfuse_CFLAGS} =
${libselinux_CFLAGS}
>> -erofsfuse_LDADD =3D $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} =
${liblz4_LIBS} \
>> +erofsfuse_CFLAGS +=3D ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} =
${libselinux_CFLAGS}
>> +erofsfuse_LDADD =3D $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} =
${libfuse3_LIBS} ${liblz4_LIBS} \
>> 	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} =
${libdeflate_LIBS}
>> diff --git a/fuse/lowlevel.c b/fuse/lowlevel.c
>> new file mode 100644
>> index 0000000..89d3077
>> --- /dev/null
>> +++ b/fuse/lowlevel.c
>> @@ -0,0 +1,553 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Created by Li Yiyan <lyy0627@sjtu.edu.com>
>> + */
>> +#include "erofs/config.h"
>> +#include "erofs/dir.h"
>> +#include "erofs/inode.h"
>> +#include "erofs/io.h"
>> +#include "erofs/print.h"
>> +#include "macosx.h"
>> +#include "config.h"
>> +#include <fuse_opt.h>
>> +#include <libgen.h>
>> +#include <signal.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <float.h>
>> +
>> +#if FUSE_USE_VERSION >=3D 30
>> +#include <fuse3/fuse_lowlevel.h>
>> +#include <fuse3/fuse.h>
>> +#else
>> +#include <fuse.h>
>> +#include <fuse_lowlevel.h>
>> +#endif
>> +
>> +#define TMP_BUF_SIZE 4096
>=20
> I'm not sure it's a good definition.

Because in the listxattr/getxattr interface, fuse first calls=20
erofsfuse_ll_listxattr and sets the parameter `size` to 0.=20
This requires the implementation to use fuse_reply_xattr=20
to return the size of the xattr. However, there is no suitable=20
implementation in the erofs library. Therefore, I chose to=20
allocate a sufficient xattr buffer and call the existing=20
erofs_listxattr interface to return the correct size.
>=20
>> +static const double EROFS_TIMEOUT =3D DBL_MAX;
>> +
>> +struct erofsfuse_ll_dir_context {
>> +	struct erofs_dir_context ctx;
>> +
>> +	fuse_req_t req;
>> +	void *buf;
>> +	int is_plus;
>> +	size_t offset;
>> +	size_t buf_size;
>> +	size_t start_off;
>> +	struct fuse_file_info *fi;
>> +};
>> +
>> +struct erofsfuse_ll_dir_search_context {
>> +	struct erofs_dir_context ctx;
>> +
>> +	const char *target_name;
>> +	size_t target_name_len;
>> +	struct fuse_entry_param *ent;
>> +};
>> +
>> +static int erofsfuse_ll_fill_dentries(struct erofs_dir_context *ctx)
>> +{
>> +	size_t r =3D 0;
>> +	struct stat st =3D { 0 };
>> +#if FUSE_USE_VERSION >=3D 30
>> +	struct fuse_entry_param param;
>> +#endif
>> +	char dname[EROFS_NAME_LEN + 1];
>> +	struct erofsfuse_ll_dir_context *fusectx =3D (void *)ctx;
>=20
> Why using void pointer cast?

Thanks.
>=20
>> +
>> +	if (fusectx->offset < fusectx->start_off) {
>> +		fusectx->offset +=3D
>> +			ctx->de_namelen + sizeof(struct erofs_dirent);
>> +		return 0;
>> +	}
>> +
>> +	strncpy(dname, ctx->dname, ctx->de_namelen);
>> +	dname[ctx->de_namelen] =3D '\0';
>> +	fusectx->offset +=3D ctx->de_namelen + sizeof(struct =
erofs_dirent);
>> +
>> +	if (!fusectx->is_plus) {
>=20
> Why need `is_plus`? Could we move this part under #else branch =
instead?

In fact, in fuse3, support for both readdir and readdirplus is still =
required.=20
We need to compile code for both branches in fuse3.
>=20
>> +		st.st_mode =3D erofs_ftype_to_dtype(ctx->de_ftype);
>> +		st.st_ino =3D ctx->de_nid;
>> +
>> +		r =3D fuse_add_direntry(fusectx->req, fusectx->buf,
>> +				      fusectx->buf_size, dname, &st,
>> +				      fusectx->offset);
>> +	} else {
>> +#if FUSE_USE_VERSION >=3D 30
>> +		param.ino =3D ctx->de_nid;
>> +		param.generation =3D 0;
>> +		param.attr.st_ino =3D ctx->de_nid;
>> +		param.attr.st_mode =3D =
erofs_ftype_to_dtype(ctx->de_ftype);
>> +		param.attr_timeout =3D EROFS_TIMEOUT;
>> +		param.entry_timeout =3D EROFS_TIMEOUT;
>> +
>> +		r =3D fuse_add_direntry_plus(fusectx->req, fusectx->buf,
>> +					   fusectx->buf_size, dname, =
&param,
>> +					   fusectx->offset);
>> +#endif
>> +	}
>> +
>> +	if (r > fusectx->buf_size) {
>> +		fusectx->offset -=3D
>> +			ctx->de_namelen + sizeof(struct erofs_dirent);
>> +		return 1;
>> +	}
>> +	fusectx->buf +=3D r;
>> +	fusectx->buf_size -=3D r;
>> +	return 0;
>> +}
>> +
>> +static void erofsfuse_ll_fill_stat(struct erofs_inode *vi, struct =
stat *stbuf)
>> +{
>> +	stbuf->st_mode =3D vi->i_mode;
>> +	stbuf->st_nlink =3D vi->i_nlink;
>> +
>> +	if (!S_ISDIR(stbuf->st_mode))
>> +		stbuf->st_size =3D vi->i_size;
>> +	if (S_ISBLK(vi->i_mode) || S_ISCHR(vi->i_mode))
>> +		stbuf->st_rdev =3D vi->u.i_rdev;
>> +
>> +	stbuf->st_blocks =3D roundup(vi->i_size, erofs_blksiz()) >> 9;
>> +
>> +	stbuf->st_uid =3D vi->i_uid;
>> +	stbuf->st_gid =3D vi->i_gid;
>> +
>> +	stbuf->st_ctime =3D vi->i_mtime;
>> +	stbuf->st_mtime =3D stbuf->st_ctime;
>> +	stbuf->st_atime =3D stbuf->st_ctime;
>> +}
>> +
>> +static int erofsfuse_ll_search_dentries(struct erofs_dir_context =
*ctx)
>> +{
>> +	int r =3D 0;
>> +	struct erofs_inode vi;
>> +	struct erofsfuse_ll_dir_search_context *search_ctx =3D (void =
*)ctx;
>=20
> Why using void pointer cast?

Thanks.
>=20
>> +
>> +	if (search_ctx->ent->ino =3D=3D 0 &&
>> +	    search_ctx->target_name_len =3D=3D ctx->de_namelen &&
>> +	    strncmp(search_ctx->target_name, ctx->dname, =
ctx->de_namelen) =3D=3D
>> +		    0) {
>> +		search_ctx->ent->ino =3D ctx->de_nid;
>> +		search_ctx->ent->attr.st_ino =3D ctx->de_nid;
>> +		vi.nid =3D (erofs_nid_t)ctx->de_nid;
>> +
>> +		r =3D erofs_read_inode_from_disk(&vi);
>> +		if (r < 0)
>> +			return r;
>> +
>> +		erofsfuse_ll_fill_stat(&vi, &(search_ctx->ent->attr));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void erofsfuse_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t =
size,
>> +			  off_t off, struct fuse_file_info *fi)
>> +{
>> +	int err =3D 0;
>> +	char *buf =3D malloc(size);
>> +	struct erofsfuse_ll_dir_context ctx;
>> +	struct erofs_inode *vi =3D (struct erofs_inode *)fi->fh;
>> +
>> +	erofs_dbg("readdir, ino: %lu, req: %p, fh: %lu, size: %lu, off: =
%lu\n",
>> +		  ino, req, fi->fh, size, off);
>> +	if (!buf) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +	ctx.ctx.dir =3D vi;
>> +	ctx.ctx.cb =3D erofsfuse_ll_fill_dentries;
>> +
>> +	ctx.fi =3D fi;
>> +	ctx.buf =3D buf;
>> +	ctx.buf_size =3D size;
>> +	ctx.req =3D req;
>> +	ctx.offset =3D 0;
>> +	ctx.is_plus =3D 0;
>> +	ctx.start_off =3D off;
>> +
>> +#ifdef NDEBUG
>> +	err =3D erofs_iterate_dir(&ctx.ctx, false);
>> +#else
>> +	err =3D erofs_iterate_dir(&ctx.ctx, true);
>> +#endif
>> +
>> +	if (err < 0) /* if buffer insufficient, return 1 */
>> +		fuse_reply_err(req, EIO);
>> +	else
>> +		fuse_reply_buf(req, buf, size - ctx.buf_size);
>> +
>> +	free(buf);
>> +}
>> +
>> +void erofsfuse_ll_init(void *userdata, struct fuse_conn_info *conn)
>> +{
>> +	erofs_inode_manager_init();
>> +}
>> +
>> +void erofsfuse_ll_open(fuse_req_t req, fuse_ino_t ino,
>> +		       struct fuse_file_info *fi)
>> +{
>> +	int ret =3D 0;
>> +	struct erofs_inode *vi;
>> +
>> +	erofs_dbg("open, ino =3D %lu, req =3D %p\n", ino, req);
>> +	if (fi->flags & (O_WRONLY | O_RDWR)) {
>> +		fuse_reply_err(req, EROFS);
>> +		return;
>> +	}
>> +
>> +	if (ino =3D=3D FUSE_ROOT_ID) {
>> +		fuse_reply_err(req, EISDIR);
>> +		return;
>> +	}
>> +
>> +	vi =3D (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +	if (!vi) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	vi->nid =3D (erofs_nid_t)ino;
>> +	ret =3D erofs_read_inode_from_disk(vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +
>> +	if (!S_ISREG(vi->i_mode)) {
>> +		fuse_reply_err(req, EISDIR);
>> +		goto out;
>=20
> goto is not needed.

Thanks.
>=20
>> +	} else {
>> +		fi->fh =3D (uint64_t)vi;
>> +		fi->keep_cache =3D 1;
>> +		fuse_reply_open(req, fi);
>> +		return;
>> +	}
>> +
>> +out:
>> +	free(vi);
>> +}
>> +
>> +void erofsfuse_ll_getattr(fuse_req_t req, fuse_ino_t ino,
>> +			  struct fuse_file_info *fi)
>> +{
>> +	int ret;
>> +	struct stat stbuf =3D { 0 };
>> +	struct erofs_inode vi;
>> +
>> +	erofs_dbg("getattr triggered, ino: %lu, req: %p\n", ino, req);
>> +	vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
>=20
> We use this in a couple of places.

I=E2=80=99ll replace it with an inline function:

static inline erofs_nid_t erofsfuse_ll_getnid(fuse_ino_t ino)
{
        return ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
}

>=20
>> +	ret =3D erofs_read_inode_from_disk(&vi);
>> +	if (ret < 0) {
>> +		erofs_dbg("read inode from disk failed, nid =3D %lu\n", =
vi.nid);
>> +		fuse_reply_err(req, ENOENT);
>> +	}
>> +
>> +	erofsfuse_ll_fill_stat(&vi, &stbuf);
>> +	stbuf.st_ino =3D ino;
>> +
>> +	fuse_reply_attr(req, &stbuf, EROFS_TIMEOUT);
>> +}
>> +
>> +void erofsfuse_ll_opendir(fuse_req_t req, fuse_ino_t ino,
>> +			  struct fuse_file_info *fi)
>> +{
>> +	int ret;
>> +	struct erofs_inode *vi;
>> +
>> +	erofs_dbg("opendir, ino =3D %lu\n", ino);
>> +	vi =3D (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +	if (!vi) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	vi->nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
>> +	ret =3D erofs_read_inode_from_disk(vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +
>> +	if (!S_ISDIR(vi->i_mode)) {
>> +		fuse_reply_err(req, ENOTDIR);
>> +		goto out;
>> +	}
>> +
>> +	fi->fh =3D (uint64_t)vi;
>> +	fuse_reply_open(req, fi);
>> +	return;
>> +
>> +out:
>> +	free(vi);
>> +}
>> +
>> +void erofsfuse_ll_releasedir(fuse_req_t req, fuse_ino_t ino,
>> +			     struct fuse_file_info *fi)
>> +{
>> +	free((struct erofs_inode *)fi->fh);
>> +	fi->fh =3D 0;
>> +	fuse_reply_err(req, 0);
>> +}
>> +
>> +void erofsfuse_ll_release(fuse_req_t req, fuse_ino_t ino,
>> +			  struct fuse_file_info *fi)
>> +{
>> +	free((struct erofs_inode *)fi->fh);
>> +	fi->fh =3D 0;
>> +	fuse_reply_err(req, 0);
>> +}
>=20
> duplicated function code.

Thanks. erofsfuse_ll_release is enough.
>=20
>> +
>> +void erofsfuse_ll_lookup(fuse_req_t req, fuse_ino_t parent, const =
char *name)
>> +{
>> +	int err, ret;
>> +	struct erofs_inode *vi;
>> +	struct fuse_entry_param fentry;
>> +	struct erofsfuse_ll_dir_search_context ctx;
>> +
>> +	vi =3D (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +	if (!vi) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	vi->nid =3D parent =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)parent;
>> +	ret =3D erofs_read_inode_from_disk(vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +	if (!S_ISDIR(vi->i_mode)) {
>> +		fuse_reply_err(req, ENOTDIR);
>> +		goto out;
>> +	}
>> +
>> +	memset(&fentry, 0, sizeof(fentry));
>> +	fentry.ino =3D 0;
>> +	fentry.attr_timeout =3D fentry.entry_timeout =3D EROFS_TIMEOUT;
>> +	ctx.ctx.dir =3D vi;
>> +	ctx.ctx.cb =3D erofsfuse_ll_search_dentries;
>> +
>> +	ctx.ent =3D &fentry;
>> +	ctx.target_name =3D name;
>> +	ctx.target_name_len =3D strlen(name);
>> +
>> +#ifdef NDEBUG
>> +	err =3D erofs_iterate_dir(&ctx.ctx, false);
>> +#else
>> +	err =3D erofs_iterate_dir(&ctx.ctx, true);
>> +#endif
>> +
>> +	if (err < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +	fuse_reply_entry(req, &fentry);
>> +
>> +out:
>> +	free(vi);
>> +}
>> +
>> +void erofsfuse_ll_read(fuse_req_t req, fuse_ino_t ino, size_t size, =
off_t off,
>> +		       struct fuse_file_info *fi)
>> +{
>> +	int ret;
>> +	struct erofs_inode *vi =3D (struct erofs_inode *)fi->fh;
>> +	char *buf =3D malloc(size);
>> +
>> +	erofs_dbg("read, ino =3D %lu, size =3D %lu, off =3D %lu, fh =3D =
%lu\n", ino,
>> +		  size, off, fi->fh);
>> +	if (!buf) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	if (!S_ISREG(vi->i_mode)) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +
>> +	ret =3D erofs_pread(vi, buf, size, off);
>> +	if (ret =3D=3D 0) {
>> +		if (off >=3D vi->i_size)
>> +			ret =3D 0;
>> +		else if (off + size > vi->i_size)
>> +			ret =3D vi->i_size - off;
>> +		else
>> +			ret =3D size;
>> +	} else {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>=20
> 	if (ret) {
> 		fuse_reply_err(req, EIO);
> 		goto out;
> 	}
> 	if (off >=3D vi->i_size)
> 		ret =3D 0;
> 	else if (off + size > vi->i_size)
> 		ret =3D vi->i_size - off;
> 	else
> 		ret =3D size;
>=20
>> +
>> +	fuse_reply_buf(req, buf, ret);
>> +
>> +out:
>> +	free(buf);
>> +}
>> +
>> +void erofsfuse_ll_readlink(fuse_req_t req, fuse_ino_t ino)
>> +{
>> +	int ret;
>> +	char *dst;
>> +	struct erofs_inode vi;
>> +
>> +	erofs_dbg("read_link, ino =3D %lu\n", ino);
>> +	vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
>> +	ret =3D erofs_read_inode_from_disk(&vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		return;
>> +	}
>> +
>> +	if (!S_ISLNK(vi.i_mode)) {
>> +		fuse_reply_err(req, EINVAL);
>> +		return;
>> +	}
>> +
>> +	dst =3D malloc(vi.i_size + 1);
>> +	if (!dst) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	ret =3D erofs_pread(&vi, dst, vi.i_size, 0);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		goto out;
>> +	}
>> +
>> +	dst[vi.i_size] =3D '\0';
>> +	fuse_reply_readlink(req, dst);
>> +
>> +out:
>> +	free(dst);
>> +}
>> +
>> +void erofsfuse_ll_getxattr(fuse_req_t req, fuse_ino_t ino, const =
char *name,
>> +			   size_t size)
>> +{
>> +	int ret;
>> +	char *buf =3D NULL;
>> +	struct erofs_inode vi;
>> +	size_t real =3D size =3D=3D 0 ? TMP_BUF_SIZE : size;
>> +
>> +	erofs_dbg("getxattr, ino =3D %lu, name =3D %s, size =3D %lu\n", =
ino, name,
>> +		  size);
>> +	vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
>> +	ret =3D erofs_read_inode_from_disk(&vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		return;
>> +	}
>> +
>> +	buf =3D malloc(real);
>> +	if (!buf) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	ret =3D erofs_getxattr(&vi, name, buf, real);
>> +	if (ret < 0)
>> +		fuse_reply_err(req, -ret);
>> +	else if (size =3D=3D 0)
>> +		fuse_reply_xattr(req, ret);
>> +	else
>> +		fuse_reply_buf(req, buf, ret);
>> +
>> +	free(buf);
>> +}
>> +
>> +void erofsfuse_ll_listxattr(fuse_req_t req, fuse_ino_t ino, size_t =
size)
>> +{
>> +	int ret;
>> +	char *buf =3D NULL;
>> +	struct erofs_inode vi;
>> +	size_t real =3D size =3D=3D 0 ? TMP_BUF_SIZE : size;
>> +
>> +	erofs_dbg("listxattr, ino =3D %lu, size =3D %lu\n", ino, size);
>> +	vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;
>> +	ret =3D erofs_read_inode_from_disk(&vi);
>> +	if (ret < 0) {
>> +		fuse_reply_err(req, EIO);
>> +		return;
>> +	}
>> +
>> +	buf =3D malloc(real);
>> +	if (!buf) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +
>> +	ret =3D erofs_listxattr(&vi, buf, real);
>> +	if (ret < 0)
>> +		fuse_reply_err(req, -ret);
>> +	else if (size =3D=3D 0)
>> +		fuse_reply_xattr(req, ret);
>> +	else
>> +		fuse_reply_buf(req, buf, ret);
>> +
>> +	free(buf);
>> +}
>> +
>> +#if FUSE_USE_VERSION >=3D 30
>> +void erofsfuse_ll_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t =
size,
>> +			      off_t off, struct fuse_file_info *fi)
>> +{
>> +	int err =3D 0;
>> +	char *buf =3D malloc(size);
>> +	struct erofsfuse_ll_dir_context ctx;
>> +	struct erofs_inode *vi =3D (struct erofs_inode *)fi->fh;
>> +
>> +	erofs_dbg("readdirplus, ino =3D %lu, size =3D %lu, off =3D %lu, =
fh =3D %lu\n",
>> +		  ino, size, off, fi->fh);
>> +	if (!buf) {
>> +		fuse_reply_err(req, ENOMEM);
>> +		return;
>> +	}
>> +	ctx.ctx.dir =3D vi;
>> +	ctx.ctx.cb =3D erofsfuse_ll_fill_dentries;
>> +
>> +	ctx.fi =3D fi;
>> +	ctx.buf =3D buf;
>> +	ctx.buf_size =3D size;
>> +	ctx.req =3D req;
>> +	ctx.offset =3D 0;
>> +	ctx.is_plus =3D 1;
>> +	ctx.start_off =3D off;
>> +
>> +#ifdef NDEBUG
>> +	err =3D erofs_iterate_dir(&ctx.ctx, false);
>> +#else
>> +	err =3D erofs_iterate_dir(&ctx.ctx, true);
>> +#endif
>> +
>> +	if (err < 0) /* if buffer insufficient, return 1 */
>> +		fuse_reply_err(req, EIO);
>> +	else
>> +		fuse_reply_buf(req, buf, size - ctx.buf_size);
>> +
>> +	free(buf);
>> +}
>=20
> almost same as _readdir() except `is_plus`.

Thanks.

>=20
>> +#endif
>> +
>> +struct fuse_lowlevel_ops erofsfuse_lops =3D {
>> +	.getxattr =3D erofsfuse_ll_getxattr,
>> +	.opendir =3D erofsfuse_ll_opendir,
>> +	.releasedir =3D erofsfuse_ll_releasedir,
>> +	.release =3D erofsfuse_ll_release,
>> +	.lookup =3D erofsfuse_ll_lookup,
>> +	.listxattr =3D erofsfuse_ll_listxattr,
>> +	.readlink =3D erofsfuse_ll_readlink,
>> +	.getattr =3D erofsfuse_ll_getattr,
>> +	.readdir =3D erofsfuse_ll_readdir,
>> +#if FUSE_USE_VERSION >=3D 30
>> +	.readdirplus =3D erofsfuse_ll_readdirplus,
>> +#endif
>> +	.open =3D erofsfuse_ll_open,
>> +	.read =3D erofsfuse_ll_read,
>> +	.init =3D erofsfuse_ll_init,
>> +};
>=20
> all functions above should be static.

Thanks.
>=20
>> diff --git a/fuse/main.c b/fuse/main.c
>> index b060e06..11726c1 100644
>> --- a/fuse/main.c
>> +++ b/fuse/main.c
>> @@ -6,8 +6,6 @@
>> #include <string.h>
>> #include <signal.h>
>> #include <libgen.h>
>> -#include <fuse.h>
>> -#include <fuse_opt.h>
>> #include "macosx.h"
>> #include "erofs/config.h"
>> #include "erofs/print.h"
>> @@ -15,6 +13,23 @@
>> #include "erofs/dir.h"
>> #include "erofs/inode.h"
>>=20
>> +#if FUSE_USE_VERSION >=3D 30
>> +#include <fuse3/fuse.h>
>> +#include <fuse3/fuse_lowlevel.h>
>> +#else
>> +#include <fuse.h>
>> +#include <fuse_lowlevel.h>
>> +#endif
>> +
>> +#if USE_LOWLEVEL
>=20
> no needed.
>=20
>> +#include <float.h>
>> +
>> +extern struct fuse_lowlevel_ops erofsfuse_lops;
>> +
>> +struct erofs_ll_ctx {
>> +	unsigned int debug_lvl;
>=20
> any user?

Just prepare for future use. I=E2=80=99ll delete it.
>=20
>> +};
>> +#else
>> struct erofsfuse_dir_context {
>> 	struct erofs_dir_context ctx;
>> 	fuse_fill_dir_t filler;
>> @@ -176,7 +191,7 @@ static int erofsfuse_listxattr(const char *path, =
char *list, size_t size)
>> 	return erofs_listxattr(&vi, list, size);
>> }
>>=20
>> -static struct fuse_operations erofs_ops =3D {
>> +static struct fuse_operations erofsfuse_ops =3D {
>> 	.getxattr =3D erofsfuse_getxattr,
>> 	.listxattr =3D erofsfuse_listxattr,
>> 	.readlink =3D erofsfuse_readlink,
>> @@ -187,6 +202,8 @@ static struct fuse_operations erofs_ops =3D {
>> 	.init =3D erofsfuse_init,
>> };
>>=20
>> +#endif
>> +
>> static struct options {
>> 	const char *disk;
>> 	const char *mountpoint;
>> @@ -207,7 +224,9 @@ static const struct fuse_opt option_spec[] =3D {
>>=20
>> static void usage(void)
>> {
>> +#if FUSE_MAJOR_VERSION < 3
>> 	struct fuse_args args =3D FUSE_ARGS_INIT(0, NULL);
>> +#endif
>>=20
>> 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
>> 	      "Options:\n"
>> @@ -257,8 +276,12 @@ static int optional_opt_func(void *data, const =
char *arg, int key,
>> 			fusecfg.disk =3D strdup(arg);
>> 			return 0;
>> 		}
>> -		if (!fusecfg.mountpoint)
>> +		if (!fusecfg.mountpoint) {
>> 			fusecfg.mountpoint =3D strdup(arg);
>> +#if USE_LOWLEVEL
>=20
> no needed.
>=20
>> +			return 0;
>> +#endif
>> +		}
>> 	case FUSE_OPT_KEY_OPT:
>> 		if (!strcmp(arg, "-d"))
>> 			fusecfg.odebug =3D true;
>> @@ -337,8 +360,58 @@ int main(int argc, char *argv[])
>> 		goto err_dev_close;
>> 	}
>>=20
>> -	ret =3D fuse_main(args.argc, args.argv, &erofs_ops, NULL);
>> +#if USE_LOWLEVEL
>=20
> no needed.
>=20
>> +	struct erofs_ll_ctx *ll_ctx;
>> +	struct fuse_session *se;
>> +
>> +	ll_ctx =3D malloc(sizeof(struct erofs_ll_ctx));
>> +	if (!ll_ctx) {
>> +		fprintf(stderr, "failed to alloc memory for ll_ctx\n");
>> +		goto err_sb_put;
>> +	}
>> +
>> +#if FUSE_USE_VERSION >=3D 30
>> +	se =3D fuse_session_new(&args, &erofsfuse_lops, =
sizeof(erofsfuse_lops),
>> +			      ll_ctx);
>> +	if (se !=3D NULL) {
>> +		fuse_set_signal_handlers(se);
>> +		fuse_session_mount(se, fusecfg.mountpoint);
>> +
>> +		ret =3D fuse_session_loop(se);
>> +
>> +		fuse_remove_signal_handlers(se);
>> +		fuse_session_unmount(se);
>> +		fuse_session_destroy(se);
>> +	}
>> +#else
>> +	struct fuse_chan *ch;
>> +
>> +	ch =3D fuse_mount(fusecfg.mountpoint, &args);
>> +	if (ch !=3D NULL) {
>> +		se =3D fuse_lowlevel_new(&args, &erofsfuse_lops,
>> +				       sizeof(erofsfuse_lops), ll_ctx);
>> +		if (se !=3D NULL) {
>> +			if (fuse_set_signal_handlers(se) !=3D -1) {
>> +				fuse_session_add_chan(se, ch);
>> +				ret =3D fuse_session_loop(se);
>> +				fuse_remove_signal_handlers(se);
>> +				fuse_session_remove_chan(ch);
>> +			}
>> +			fuse_session_destroy(se);
>> +		}
>> +		fuse_unmount(fusecfg.mountpoint, ch);
>> +	}
>> +#endif
>> +
>> +	free(ll_ctx);
>>=20
>> +#else
>> +	ret =3D fuse_main(args.argc, args.argv, &erofsfuse_ops, NULL);
>> +#endif
>> +
>> +#if USE_LOWLEVEL
>=20
> no needed.
>=20
>> +err_sb_put:
>> +#endif
>> 	erofs_put_super();
>> err_dev_close:
>> 	blob_closeall();


--Apple-Mail=_565CB21E-1B81-4CC7-816A-B75308D00437
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><div><br><blockquote =
type=3D"cite"><div>2023=E5=B9=B47=E6=9C=8824=E6=97=A5 18:53=EF=BC=8CYue =
Hu &lt;zbestahu@gmail.com&gt; =E5=86=99=E9=81=93=EF=BC=9A</div><br =
class=3D"Apple-interchange-newline"><div>Hi Yiyan,<br><br>Thanks for the =
patch! &nbsp;Some comments below...<br><br>On Mon, 24 Jul 2023 13:35:27 =
+0800<br>Li Yiyan &lt;<a =
href=3D"mailto:lyy0627@sjtu.edu.cn">lyy0627@sjtu.edu.cn</a>&gt; =
wrote:<br><br><blockquote type=3D"cite">Add support for fuse2/3 lowlevel =
API in erofsfuse,<br>pass the make check test in experimental-test =
branch.<br>Conduct performance evaluation, providing =
higher<br>performance compared to highlevel API while<br>retaining =
compatibility with highlevel API of fuse 2.<br><br>Signed-off-by: Li =
Yiyan &lt;lyy0627@sjtu.edu.cn&gt;<br>---<br>configure.ac =
&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;26 ++-<br>fuse/Makefile.am | =
&nbsp;&nbsp;6 +-<br>fuse/lowlevel.c &nbsp;| 553 =
+++++++++++++++++++++++++++++++++++++++++++++++<br>fuse/main.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;83 ++++++-<br>4 files changed, 653 =
insertions(+), 15 deletions(-)<br>create mode 100644 =
fuse/lowlevel.c<br><br>diff --git a/configure.ac b/configure.ac<br>index =
a8cecd0..d8d648e 100644<br>--- a/configure.ac<br>+++ =
b/configure.ac<br>@@ -336,15 +336,27 @@ AS_IF([test "x$with_selinux" !=3D =
"xno"], [<br><br># Configure fuse<br>AS_IF([test "x$enable_fuse" !=3D =
"xno"], [<br>- &nbsp;PKG_CHECK_MODULES([libfuse], [fuse &gt;=3D =
2.6])<br>- &nbsp;# Paranoia: don't trust the result reported by =
pkgconfig before trying =
out<br>&nbsp;&nbsp;saved_LIBS=3D"$LIBS"<br>&nbsp;&nbsp;saved_CPPFLAGS=3D${=
CPPFLAGS}<br>- &nbsp;CPPFLAGS=3D"${libfuse_CFLAGS} ${CPPFLAGS}"<br>- =
&nbsp;LIBS=3D"${libfuse_LIBS} $LIBS"<br>- &nbsp;AC_CHECK_LIB(fuse, =
fuse_main, [<br>- &nbsp;&nbsp;&nbsp;have_fuse=3D"yes" ], [<br>- =
&nbsp;&nbsp;&nbsp;AC_MSG_ERROR([libfuse (&gt;=3D 2.6) doesn't work =
properly])])<br>+ &nbsp;PKG_CHECK_MODULES([libfuse3], [fuse3 &gt;=3D =
3.0], [<br>+ &nbsp;&nbsp;&nbsp;AC_DEFINE([FUSE_USE_VERSION], [30], [used =
FUSE API version])<br>+ &nbsp;&nbsp;&nbsp;CPPFLAGS=3D"${libfuse3_CFLAGS} =
${CPPFLAGS}"<br>+ &nbsp;&nbsp;&nbsp;LIBS=3D"${libfuse3_LIBS} $LIBS"<br>+ =
&nbsp;&nbsp;&nbsp;AC_CHECK_LIB(fuse3, fuse_session_new, [ =
AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if libfuse lowlevel api =
available]) ], [<br>+ &nbsp;&nbsp;&nbsp;AC_MSG_ERROR([libfuse3 (&gt;=3D =
3.0) doesn't work properly for lowlevel api])])<br>+ =
&nbsp;&nbsp;&nbsp;have_fuse=3D"yes"<br>+ &nbsp;], [<br>+ =
&nbsp;&nbsp;&nbsp;PKG_CHECK_MODULES([libfuse2], [fuse &gt;=3D 2.6], =
[<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_DEFINE([FUSE_USE_VERSION], [26], =
[used FUSE API version])<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CPPFLAGS=3D"${libfuse2_CFLAGS} =
${CPPFLAGS}"<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LIBS=3D"${libfuse2_LIBS} =
$LIBS"<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_CHECK_LIB(fuse, =
fuse_lowlevel_new, [ AC_DEFINE([USE_LOWLEVEL], [1], [Define to 1 if =
libfuse lowlevel api available]) ], [<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_MSG_NOTICE([libfuse (&gt;=3D =
2.6) doesn't work properly for lowlevel api])])<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_CHECK_LIB(fuse, fuse_main, , [<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_MSG_ERROR([libfuse (&gt;=3D =
2.6) doesn't work properly for highlevel api and lowlevel api])])<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;have_fuse=3D"yes"<br>+ =
&nbsp;&nbsp;&nbsp;], [have_fuse=3D"no"])<br>+ =
&nbsp;])<br></blockquote><br>We may drop high level part if low level is =
working fine, so `USE_LOWLEVEL` is =
unneeded.<br></div></blockquote><div><br></div><div>Thanks.</div><br><bloc=
kquote type=3D"cite"><br><blockquote =
type=3D"cite">&nbsp;&nbsp;LIBS=3D"${saved_LIBS}"<br>&nbsp;&nbsp;CPPFLAGS=3D=
"${saved_CPPFLAGS}"], [have_fuse=3D"no"])<br><br>diff --git =
a/fuse/Makefile.am b/fuse/Makefile.am<br>index 50be783..d54fc89 =
100644<br>--- a/fuse/Makefile.am<br>+++ b/fuse/Makefile.am<br>@@ -3,8 =
+3,8 @@<br>AUTOMAKE_OPTIONS =3D foreign<br>noinst_HEADERS =3D =
$(top_srcdir)/fuse/macosx.h<br>bin_PROGRAMS &nbsp;&nbsp;&nbsp;&nbsp;=3D =
erofsfuse<br>-erofsfuse_SOURCES =3D main.c<br>+erofsfuse_SOURCES =3D =
main.c lowlevel.c<br>erofsfuse_CFLAGS =3D -Wall =
-I$(top_srcdir)/include<br>-erofsfuse_CFLAGS +=3D -DFUSE_USE_VERSION=3D26 =
${libfuse_CFLAGS} ${libselinux_CFLAGS}<br>-erofsfuse_LDADD =3D =
$(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} =
\<br>+erofsfuse_CFLAGS +=3D ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} =
${libselinux_CFLAGS}<br>+erofsfuse_LDADD =3D =
$(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} =
${liblz4_LIBS} \<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} =
${libdeflate_LIBS}<br>diff --git a/fuse/lowlevel.c =
b/fuse/lowlevel.c<br>new file mode 100644<br>index =
0000000..89d3077<br>--- /dev/null<br>+++ b/fuse/lowlevel.c<br>@@ -0,0 =
+1,553 @@<br>+// SPDX-License-Identifier: GPL-2.0+<br>+/*<br>+ * Created =
by Li Yiyan &lt;lyy0627@sjtu.edu.com&gt;<br>+ */<br>+#include =
"erofs/config.h"<br>+#include "erofs/dir.h"<br>+#include =
"erofs/inode.h"<br>+#include "erofs/io.h"<br>+#include =
"erofs/print.h"<br>+#include "macosx.h"<br>+#include =
"config.h"<br>+#include &lt;fuse_opt.h&gt;<br>+#include =
&lt;libgen.h&gt;<br>+#include &lt;signal.h&gt;<br>+#include =
&lt;stdlib.h&gt;<br>+#include &lt;string.h&gt;<br>+#include =
&lt;float.h&gt;<br>+<br>+#if FUSE_USE_VERSION &gt;=3D 30<br>+#include =
&lt;fuse3/fuse_lowlevel.h&gt;<br>+#include =
&lt;fuse3/fuse.h&gt;<br>+#else<br>+#include &lt;fuse.h&gt;<br>+#include =
&lt;fuse_lowlevel.h&gt;<br>+#endif<br>+<br>+#define TMP_BUF_SIZE =
4096<br></blockquote><br>I'm not sure it's a good =
definition.<br></blockquote><div><br></div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">Because in the =
listxattr/getxattr interface, fuse first =
calls&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: =
14px;">erofsfuse_ll_listxattr and sets the parameter `size` to =
0.&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">This requires the =
implementation to use =
fuse_reply_xattr&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">to return the size of =
the xattr. However, there is no =
suitable&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">implementation in the =
erofs&nbsp;library. Therefore, I chose =
to&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">allocate a sufficient =
xattr buffer and call the =
existing&nbsp;</span></font></font></span></div><div><span =
style=3D"font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;"><font face=3D"PingFangSC-Regular"><font =
color=3D"#24292f"><span style=3D"font-size: 14px;">erofs_listxattr =
interface to return the correct =
size.</span></font></font></span><br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">+static const double =
EROFS_TIMEOUT =3D DBL_MAX;<br>+<br>+struct erofsfuse_ll_dir_context =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct erofs_dir_context ctx;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_req_t req;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>void *buf;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
is_plus;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>size_t offset;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>size_t buf_size;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>size_t =
start_off;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct fuse_file_info *fi;<br>+};<br>+<br>+struct =
erofsfuse_ll_dir_search_context {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct erofs_dir_context =
ctx;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>const char *target_name;<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>size_t target_name_len;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
fuse_entry_param *ent;<br>+};<br>+<br>+static int =
erofsfuse_ll_fill_dentries(struct erofs_dir_context =
*ctx)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>size_t r =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct stat st =3D { 0 };<br>+#if =
FUSE_USE_VERSION &gt;=3D 30<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct fuse_entry_param =
param;<br>+#endif<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>char dname[EROFS_NAME_LEN + 1];<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofsfuse_ll_dir_context *fusectx =3D (void =
*)ctx;<br></blockquote><br>Why using void pointer =
cast?<br></blockquote><div><br></div>Thanks.<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(fusectx-&gt;offset &lt; fusectx-&gt;start_off) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fusectx-&gt;offset +=3D<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx-&gt;de_namelen + =
sizeof(struct erofs_dirent);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>strncpy(dname, ctx-&gt;dname, =
ctx-&gt;de_namelen);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dname[ctx-&gt;de_namelen] =3D =
'\0';<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fusectx-&gt;offset +=3D ctx-&gt;de_namelen + sizeof(struct =
erofs_dirent);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!fusectx-&gt;is_plus) =
{<br></blockquote><br>Why need `is_plus`? Could we move this part under =
#else branch instead?<br></blockquote><div><br></div><span =
style=3D"font-family: &quot;Noto Sans SC&quot;, &quot;SF Pro SC&quot;, =
&quot;SF Pro Text&quot;, &quot;SF Pro Icons&quot;, &quot;PingFang =
SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; =
font-size: 14px; font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;">In fact, in fuse3, support for both =
readdir and readdirplus is still required.&nbsp;</span></div><div><span =
style=3D"font-family: &quot;Noto Sans SC&quot;, &quot;SF Pro SC&quot;, =
&quot;SF Pro Text&quot;, &quot;SF Pro Icons&quot;, &quot;PingFang =
SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; =
font-size: 14px; font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;">We need to compile code for both =
branches in fuse3.</span><br><blockquote type=3D"cite"><br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>st.st_mode =3D =
erofs_ftype_to_dtype(ctx-&gt;de_ftype);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>st.st_ino =3D =
ctx-&gt;de_nid;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>r =3D =
fuse_add_direntry(fusectx-&gt;req, fusectx-&gt;buf,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fusectx-&gt;buf_size, dname, =
&amp;st,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fusectx-&gt;offset);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>} else =
{<br>+#if FUSE_USE_VERSION &gt;=3D 30<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>param.ino =3D =
ctx-&gt;de_nid;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>param.generation =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>param.attr.st_ino =3D =
ctx-&gt;de_nid;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>param.attr.st_mode =3D =
erofs_ftype_to_dtype(ctx-&gt;de_ftype);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>param.attr_timeout =3D =
EROFS_TIMEOUT;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>param.entry_timeout =3D EROFS_TIMEOUT;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>r =3D =
fuse_add_direntry_plus(fusectx-&gt;req, fusectx-&gt;buf,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;fusectx-&gt;buf_size, dname, =
&amp;param,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	=
</span>&nbsp;&nbsp;&nbsp;fusectx-&gt;offset);<br>+#endif<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (r &gt; fusectx-&gt;buf_size) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fusectx-&gt;offset -=3D<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx-&gt;de_namelen + =
sizeof(struct erofs_dirent);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return 1;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fusectx-&gt;buf +=3D r;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fusectx-&gt;buf_size -=3D =
r;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return 0;<br>+}<br>+<br>+static void =
erofsfuse_ll_fill_stat(struct erofs_inode *vi, struct stat =
*stbuf)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>stbuf-&gt;st_mode =3D vi-&gt;i_mode;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_nlink =3D vi-&gt;i_nlink;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!S_ISDIR(stbuf-&gt;st_mode))<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>stbuf-&gt;st_size =3D =
vi-&gt;i_size;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (S_ISBLK(vi-&gt;i_mode) || =
S_ISCHR(vi-&gt;i_mode))<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>stbuf-&gt;st_rdev =3D =
vi-&gt;u.i_rdev;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>stbuf-&gt;st_blocks =3D =
roundup(vi-&gt;i_size, erofs_blksiz()) &gt;&gt; 9;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_uid =3D vi-&gt;i_uid;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_gid =3D vi-&gt;i_gid;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_ctime =3D vi-&gt;i_mtime;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_mtime =3D stbuf-&gt;st_ctime;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf-&gt;st_atime =3D stbuf-&gt;st_ctime;<br>+}<br>+<br>+static =
int erofsfuse_ll_search_dentries(struct erofs_dir_context =
*ctx)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int r =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct erofs_inode vi;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofsfuse_ll_dir_search_context *search_ctx =3D (void =
*)ctx;<br></blockquote><br>Why using void pointer =
cast?<br></blockquote><div><br></div>Thanks.<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(search_ctx-&gt;ent-&gt;ino =3D=3D 0 &amp;&amp;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;search_ctx-&gt;target_name_len =3D=3D =
ctx-&gt;de_namelen &amp;&amp;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;strncmp(search_ctx-&gt;target_name, =
ctx-&gt;dname, ctx-&gt;de_namelen) =3D=3D<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>search_ctx-&gt;ent-&gt;ino =3D =
ctx-&gt;de_nid;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>search_ctx-&gt;ent-&gt;attr.st_ino =3D =
ctx-&gt;de_nid;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>vi.nid =3D (erofs_nid_t)ctx-&gt;de_nid;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>r =3D =
erofs_read_inode_from_disk(&amp;vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (r &lt; 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
r;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofsfuse_ll_fill_stat(&amp;vi, =
&amp;(search_ctx-&gt;ent-&gt;attr));<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br>+}<br>+<br>+void erofsfuse_ll_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&nbsp;&nbsp;off_t off, struct fuse_file_info =
*fi)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int err =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>char *buf =3D =
malloc(size);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct erofsfuse_ll_dir_context ctx;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofs_inode *vi =3D (struct erofs_inode *)fi-&gt;fh;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofs_dbg("readdir, ino: %lu, req: %p, fh: %lu, size: %lu, off: =
%lu\n",<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;ino, req, fi-&gt;fh, size, off);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!buf) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.ctx.dir =3D vi;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.ctx.cb =3D =
erofsfuse_ll_fill_dentries;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.fi =3D fi;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ctx.buf =3D=
 buf;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.buf_size =3D size;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.req =3D req;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.offset =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.is_plus =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.start_off =3D off;<br>+<br>+#ifdef NDEBUG<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>err =3D =
erofs_iterate_dir(&amp;ctx.ctx, false);<br>+#else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>err =3D =
erofs_iterate_dir(&amp;ctx.ctx, true);<br>+#endif<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (err =
&lt; 0) /* if buffer insufficient, return 1 */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_buf(req, buf, size - ctx.buf_size);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(buf);<br>+}<br>+<br>+void erofsfuse_ll_init(void *userdata, =
struct fuse_conn_info *conn)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>erofs_inode_manager_init();<br>+}<br>+<br>+void =
erofsfuse_ll_open(fuse_req_t req, fuse_ino_t ino,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct fuse_file_info =
*fi)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct erofs_inode =
*vi;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>erofs_dbg("open, ino =3D %lu, req =3D %p\n", ino, =
req);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (fi-&gt;flags &amp; (O_WRONLY | O_RDWR)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EROFS);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (ino =3D=3D FUSE_ROOT_ID) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EISDIR);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>vi =3D (struct erofs_inode *)malloc(sizeof(struct =
erofs_inode));<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!vi) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_err(req, =
ENOMEM);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>vi-&gt;nid =3D =
(erofs_nid_t)ino;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>ret =3D erofs_read_inode_from_disk(vi);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fuse_reply_err(req, EIO);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
out;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!S_ISREG(vi-&gt;i_mode)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EISDIR);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto =
out;<br></blockquote><br>goto is not =
needed.<br></blockquote><div><br></div>Thanks.<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>} else =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fi-&gt;fh =3D (uint64_t)vi;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fi-&gt;keep_cache =3D =
1;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_open(req, fi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+out:<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>free(vi);<br>+}<br>+<br>+void =
erofsfuse_ll_getattr(fuse_req_t req, fuse_ino_t ino,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;struct fuse_file_info *fi)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct stat stbuf =3D { 0 };<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct erofs_inode =
vi;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofs_dbg("getattr triggered, ino: %lu, req: %p\n", ino, =
req);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;<br></blockquote><br>We use this in a couple of =
places.<br></blockquote><div><br></div>I=E2=80=99ll replace it with an =
inline function:</div><div><br></div><div><div style=3D"line-height: =
18px; white-space: pre;"><div><font face=3D"PingFangSC-Regular">static =
inline erofs_nid_t erofsfuse_ll_getnid(fuse_ino_t =
ino)</font></div><div><font =
face=3D"PingFangSC-Regular">{</font></div><div><font =
face=3D"PingFangSC-Regular">        return ino =3D=3D FUSE_ROOT_ID ? =
sbi.root_nid : (erofs_nid_t)ino;</font></div><div><font =
face=3D"PingFangSC-Regular">}</font></div><div><font =
face=3D"PingFangSC-Regular"><br></font></div></div><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
erofs_read_inode_from_disk(&amp;vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofs_dbg("read inode from disk failed, nid =3D %lu\n", =
vi.nid);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOENT);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofsfuse_ll_fill_stat(&amp;vi, &amp;stbuf);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>stbuf.st_ino =3D ino;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_attr(req, &amp;stbuf, =
EROFS_TIMEOUT);<br>+}<br>+<br>+void erofsfuse_ll_opendir(fuse_req_t req, =
fuse_ino_t ino,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&nbsp;&nbsp;struct fuse_file_info *fi)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>int =
ret;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct erofs_inode *vi;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>erofs_dbg("opendir, ino =3D =
%lu\n", ino);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>vi =3D (struct erofs_inode *)malloc(sizeof(struct =
erofs_inode));<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!vi) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_err(req, =
ENOMEM);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>vi-&gt;nid =3D ino =3D=3D =
FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
erofs_read_inode_from_disk(vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!S_ISDIR(vi-&gt;i_mode)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOTDIR);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fi-&gt;fh =3D (uint64_t)vi;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_open(req, fi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<br>+out:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(vi);<br>+}<br>+<br>+void erofsfuse_ll_releasedir(fuse_req_t =
req, fuse_ino_t ino,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct fuse_file_info =
*fi)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>free((struct erofs_inode *)fi-&gt;fh);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>fi-&gt;fh =
=3D 0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, 0);<br>+}<br>+<br>+void =
erofsfuse_ll_release(fuse_req_t req, fuse_ino_t ino,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;struct fuse_file_info *fi)<br>+{<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free((struct erofs_inode *)fi-&gt;fh);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>fi-&gt;fh =
=3D 0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, 0);<br>+}<br></blockquote><br>duplicated =
function code.<br></blockquote><div><br></div>Thanks. =
erofsfuse_ll_release is enough.<blockquote type=3D"cite"><blockquote =
type=3D"cite">+<br>+void erofsfuse_ll_lookup(fuse_req_t req, fuse_ino_t =
parent, const char *name)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int err, ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofs_inode *vi;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct fuse_entry_param fentry;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofsfuse_ll_dir_search_context ctx;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>vi =3D =
(struct erofs_inode *)malloc(sizeof(struct erofs_inode));<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!vi) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>vi-&gt;nid =3D parent =3D=3D FUSE_ROOT_ID ? sbi.root_nid =
: (erofs_nid_t)parent;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
erofs_read_inode_from_disk(vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (!S_ISDIR(vi-&gt;i_mode)) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_err(req, =
ENOTDIR);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>goto out;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>memset(&amp;fentry, 0, sizeof(fentry));<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fentry.ino =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fentry.attr_timeout =3D =
fentry.entry_timeout =3D EROFS_TIMEOUT;<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>ctx.ctx.dir =3D vi;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.ctx.cb =3D erofsfuse_ll_search_dentries;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ctx.ent =3D=
 &amp;fentry;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ctx.target_name =3D name;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.target_name_len =3D strlen(name);<br>+<br>+#ifdef =
NDEBUG<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>err =3D erofs_iterate_dir(&amp;ctx.ctx, =
false);<br>+#else<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>err =3D erofs_iterate_dir(&amp;ctx.ctx, =
true);<br>+#endif<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (err &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_entry(req, &amp;fentry);<br>+<br>+out:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(vi);<br>+}<br>+<br>+void erofsfuse_ll_read(fuse_req_t req, =
fuse_ino_t ino, size_t size, off_t off,<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct fuse_file_info =
*fi)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>struct erofs_inode *vi =3D =
(struct erofs_inode *)fi-&gt;fh;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>char *buf =3D =
malloc(size);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>erofs_dbg("read, ino =3D %lu, =
size =3D %lu, off =3D %lu, fh =3D %lu\n", ino,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;size, off, fi-&gt;fh);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!buf) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!S_ISREG(vi-&gt;i_mode)) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D erofs_pread(vi, buf, size, off);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
=3D=3D 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (off &gt;=3D vi-&gt;i_size)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
0;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else if (off + size &gt; vi-&gt;i_size)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
vi-&gt;i_size - off;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
size;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>} else {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fuse_reply_err(req, EIO);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
out;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br></blockquote><br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret) {<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto out;<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (off &gt;=3D vi-&gt;i_size)<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D 0;<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>else if =
(off + size &gt; vi-&gt;i_size)<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D vi-&gt;i_size - =
off;<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D size;<br><br><blockquote type=3D"cite">+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_buf(req, buf, ret);<br>+<br>+out:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(buf);<br>+}<br>+<br>+void erofsfuse_ll_readlink(fuse_req_t =
req, fuse_ino_t ino)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>char =
*dst;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct erofs_inode vi;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>erofs_dbg("read_link, ino =3D =
%lu\n", ino);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>vi.nid =3D ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : =
(erofs_nid_t)ino;<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>ret =3D erofs_read_inode_from_disk(&amp;vi);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fuse_reply_err(req, EIO);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>return;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!S_ISLNK(vi.i_mode)) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EINVAL);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>dst =3D malloc(vi.i_size + 1);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!dst) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D erofs_pread(&amp;vi, dst, vi.i_size, =
0);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ret &lt; 0) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_err(req, =
EIO);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>goto out;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>dst[vi.i_size] =3D =
'\0';<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_readlink(req, dst);<br>+<br>+out:<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(dst);<br>+}<br>+<br>+void erofsfuse_ll_getxattr(fuse_req_t =
req, fuse_ino_t ino, const char *name,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>&nbsp;&nbsp;&nbsp;size_t =
size)<br>+{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>int ret;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>char *buf =3D NULL;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofs_inode vi;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>size_t real =3D size =3D=3D 0 ? TMP_BUF_SIZE : =
size;<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>erofs_dbg("getxattr, ino =3D %lu, name =3D %s, size =3D =
%lu\n", ino, name,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>&nbsp;&nbsp;size);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>vi.nid =3D =
ino =3D=3D FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
erofs_read_inode_from_disk(&amp;vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>buf =3D malloc(real);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!buf) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D erofs_getxattr(&amp;vi, name, buf, =
real);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (ret &lt; 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_err(req, =
-ret);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else if (size =3D=3D 0)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_reply_xattr(req, =
ret);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>else<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fuse_reply_buf(req, buf, ret);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(buf);<br>+}<br>+<br>+void erofsfuse_ll_listxattr(fuse_req_t =
req, fuse_ino_t ino, size_t size)<br>+{<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>int ret;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>char *buf =
=3D NULL;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct erofs_inode vi;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>size_t real =3D size =3D=3D 0 ? =
TMP_BUF_SIZE : size;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>erofs_dbg("listxattr, ino =3D =
%lu, size =3D %lu\n", ino, size);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>vi.nid =3D ino =3D=3D =
FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
erofs_read_inode_from_disk(&amp;vi);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (ret &lt; 0) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>buf =3D malloc(real);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!buf) {<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>ret =3D erofs_listxattr(&amp;vi, buf, real);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ret =
&lt; 0)<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, -ret);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>else if (size =3D=3D 0)<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_xattr(req, ret);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_buf(req, buf, ret);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(buf);<br>+}<br>+<br>+#if FUSE_USE_VERSION &gt;=3D =
30<br>+void erofsfuse_ll_readdirplus(fuse_req_t req, fuse_ino_t ino, =
size_t size,<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;off_t off, struct =
fuse_file_info *fi)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>int err =3D 0;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>char *buf =
=3D malloc(size);<br>+<span class=3D"Apple-tab-span" style=3D"white-space:=
 pre;">	</span>struct erofsfuse_ll_dir_context ctx;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofs_inode *vi =3D (struct erofs_inode *)fi-&gt;fh;<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>erofs_dbg("readdirplus, ino =3D %lu, size =3D %lu, off =3D %lu, =
fh =3D %lu\n",<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&nbsp;&nbsp;ino, size, off, fi-&gt;fh);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (!buf) =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, ENOMEM);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.ctx.dir =3D vi;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.ctx.cb =3D =
erofsfuse_ll_fill_dentries;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.fi =3D fi;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ctx.buf =3D=
 buf;<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.buf_size =3D size;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.req =3D req;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.offset =3D 0;<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ctx.is_plus =3D 1;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ctx.start_off =3D off;<br>+<br>+#ifdef NDEBUG<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>err =3D =
erofs_iterate_dir(&amp;ctx.ctx, false);<br>+#else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>err =3D =
erofs_iterate_dir(&amp;ctx.ctx, true);<br>+#endif<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (err =
&lt; 0) /* if buffer insufficient, return 1 */<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_err(req, EIO);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_reply_buf(req, buf, size - ctx.buf_size);<br>+<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>free(buf);<br>+}<br></blockquote><br>almost same as _readdir() =
except =
`is_plus`.<br></blockquote><div><br></div><div>Thanks.</div><br><blockquot=
e type=3D"cite"><br><blockquote type=3D"cite">+#endif<br>+<br>+struct =
fuse_lowlevel_ops erofsfuse_lops =3D {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.getxattr =3D =
erofsfuse_ll_getxattr,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.opendir =3D =
erofsfuse_ll_opendir,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.releasedir =3D =
erofsfuse_ll_releasedir,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.release =3D =
erofsfuse_ll_release,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.lookup =3D =
erofsfuse_ll_lookup,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.listxattr =3D =
erofsfuse_ll_listxattr,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.readlink =3D =
erofsfuse_ll_readlink,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.getattr =3D =
erofsfuse_ll_getattr,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.readdir =3D =
erofsfuse_ll_readdir,<br>+#if FUSE_USE_VERSION &gt;=3D 30<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>.readdirplus =3D erofsfuse_ll_readdirplus,<br>+#endif<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>.open =3D =
erofsfuse_ll_open,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.read =3D =
erofsfuse_ll_read,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.init =3D =
erofsfuse_ll_init,<br>+};<br></blockquote><br>all functions above should =
be static.<br></blockquote><div><br></div>Thanks.<br><blockquote =
type=3D"cite"><br><blockquote type=3D"cite">diff --git a/fuse/main.c =
b/fuse/main.c<br>index b060e06..11726c1 100644<br>--- =
a/fuse/main.c<br>+++ b/fuse/main.c<br>@@ -6,8 +6,6 @@<br>#include =
&lt;string.h&gt;<br>#include &lt;signal.h&gt;<br>#include =
&lt;libgen.h&gt;<br>-#include &lt;fuse.h&gt;<br>-#include =
&lt;fuse_opt.h&gt;<br>#include "macosx.h"<br>#include =
"erofs/config.h"<br>#include "erofs/print.h"<br>@@ -15,6 +13,23 =
@@<br>#include "erofs/dir.h"<br>#include "erofs/inode.h"<br><br>+#if =
FUSE_USE_VERSION &gt;=3D 30<br>+#include =
&lt;fuse3/fuse.h&gt;<br>+#include =
&lt;fuse3/fuse_lowlevel.h&gt;<br>+#else<br>+#include =
&lt;fuse.h&gt;<br>+#include =
&lt;fuse_lowlevel.h&gt;<br>+#endif<br>+<br>+#if =
USE_LOWLEVEL<br></blockquote><br>no needed.<br><br><blockquote =
type=3D"cite">+#include &lt;float.h&gt;<br>+<br>+extern struct =
fuse_lowlevel_ops erofsfuse_lops;<br>+<br>+struct erofs_ll_ctx =
{<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>unsigned int debug_lvl;<br></blockquote><br>any =
user?<br></blockquote><div><br></div>Just prepare for future use. I=E2=80=99=
ll delete it.<br><blockquote type=3D"cite"><br><blockquote =
type=3D"cite">+};<br>+#else<br>struct erofsfuse_dir_context {<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
erofs_dir_context ctx;<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_fill_dir_t filler;<br>@@ =
-176,7 +191,7 @@ static int erofsfuse_listxattr(const char *path, char =
*list, size_t size)<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>return erofs_listxattr(&amp;vi, =
list, size);<br>}<br><br>-static struct fuse_operations erofs_ops =3D =
{<br>+static struct fuse_operations erofsfuse_ops =3D {<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>.getxattr =
=3D erofsfuse_getxattr,<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.listxattr =3D =
erofsfuse_listxattr,<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>.readlink =3D =
erofsfuse_readlink,<br>@@ -187,6 +202,8 @@ static struct fuse_operations =
erofs_ops =3D {<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>.init =3D =
erofsfuse_init,<br>};<br><br>+#endif<br>+<br>static struct options =
{<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>const char *disk;<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>const char *mountpoint;<br>@@ =
-207,7 +224,9 @@ static const struct fuse_opt option_spec[] =3D =
{<br><br>static void usage(void)<br>{<br>+#if FUSE_MAJOR_VERSION &lt; =
3<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>struct fuse_args args =3D FUSE_ARGS_INIT(0, =
NULL);<br>+#endif<br><br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fputs("usage: [options] IMAGE =
MOUNTPOINT\n\n"<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Options:\n"<br>@@ =
-257,8 +276,12 @@ static int optional_opt_func(void *data, const char =
*arg, int key,<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fusecfg.disk =3D strdup(arg);<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>return =
0;<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>-<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (!fusecfg.mountpoint)<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (!fusecfg.mountpoint) =
{<br><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fusecfg.mountpoint =3D strdup(arg);<br>+#if =
USE_LOWLEVEL<br></blockquote><br>no needed.<br><br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>return 0;<br>+#endif<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br><span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span>case FUSE_OPT_KEY_OPT:<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if =
(!strcmp(arg, "-d"))<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fusecfg.odebug =3D true;<br>@@ =
-337,8 +360,58 @@ int main(int argc, char *argv[])<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>goto =
err_dev_close;<br><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>}<br><br>-<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D fuse_main(args.argc, =
args.argv, &amp;erofs_ops, NULL);<br>+#if =
USE_LOWLEVEL<br></blockquote><br>no needed.<br><br><blockquote =
type=3D"cite">+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>struct erofs_ll_ctx *ll_ctx;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
fuse_session *se;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ll_ctx =3D malloc(sizeof(struct =
erofs_ll_ctx));<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>if (!ll_ctx) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fprintf(stderr, "failed to alloc =
memory for ll_ctx\n");<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>goto err_sb_put;<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+<br>+#if FUSE_USE_VERSION &gt;=3D 30<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>se =3D =
fuse_session_new(&amp;args, &amp;erofsfuse_lops, =
sizeof(erofsfuse_lops),<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ll_ctx);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (se !=3D=
 NULL) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_set_signal_handlers(se);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>fuse_session_mount(se, =
fusecfg.mountpoint);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D =
fuse_session_loop(se);<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>fuse_remove_signal_handlers(se);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>fuse_session_unmount(se);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>fuse_session_destroy(se);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+#else<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
fuse_chan *ch;<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ch =3D =
fuse_mount(fusecfg.mountpoint, &amp;args);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>if (ch !=3D=
 NULL) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>se =3D fuse_lowlevel_new(&amp;args, =
&amp;erofsfuse_lops,<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sizeof(erofsfuse_lops), =
ll_ctx);<br>+<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>if (se !=3D NULL) {<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>if (fuse_set_signal_handlers(se) =
!=3D -1) {<br>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>fuse_session_add_chan(se, ch);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>ret =3D =
fuse_session_loop(se);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>fuse_remove_signal_handlers(se);<br>+<span class=3D"Apple-tab-span"=
 style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>fuse_session_remove_chan(ch);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_session_destroy(se);<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>}<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>fuse_unmount(fusecfg.mountpoint, ch);<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>}<br>+#endif<br>+<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>free(ll_ctx);<br><br>+#else<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ret =3D fuse_main(args.argc, =
args.argv, &amp;erofsfuse_ops, NULL);<br>+#endif<br>+<br>+#if =
USE_LOWLEVEL<br></blockquote><br>no needed.<br><br><blockquote =
type=3D"cite">+err_sb_put:<br>+#endif<br><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	=
</span>erofs_put_super();<br>err_dev_close:<br><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>blob_closeall();</blockquote></blockquote></div><br =
class=3D"Apple-interchange-newline"></div></body></html>=

--Apple-Mail=_565CB21E-1B81-4CC7-816A-B75308D00437--
