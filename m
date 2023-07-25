Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D1760B10
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 09:00:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R97GV561Lz3bnP
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 17:00:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R97GN3GD4z3bX6
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 17:00:41 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 175EC1008C5B4;
	Tue, 25 Jul 2023 15:00:28 +0800 (CST)
Received: from lee-WorkStation.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 6355137C923;
	Tue, 25 Jul 2023 15:00:25 +0800 (CST)
From: Li Yiyan <lyy0627@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: add support for fuse 2/3 lowlevel API
Date: Tue, 25 Jul 2023 15:00:16 +0800
Message-Id: <20230725070016.846411-1-lyy0627@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Li Yiyan <lyy0627@sjtu.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add support for fuse2/3 lowlevel API in erofsfuse,
pass the make check test in experimental-test branch.
Conduct performance evaluation, providing higher
performance compared to highlevel API. Compatible with
fuse 2(>=2.6) and 3(>=3.0)

Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
---
Changes since v1:
- remove highlevel fallback path
- remove redundant code
- add static for erofsfuse_ll_func
---
 configure.ac     |  23 ++-
 fuse/Makefile.am |   6 +-
 fuse/lowlevel.c  | 527 +++++++++++++++++++++++++++++++++++++++++++++++
 fuse/main.c      | 216 ++++---------------
 4 files changed, 589 insertions(+), 183 deletions(-)
 create mode 100644 fuse/lowlevel.c

diff --git a/configure.ac b/configure.ac
index a8cecd0..4046856 100644
--- a/configure.ac
+++ b/configure.ac
@@ -336,15 +336,26 @@ AS_IF([test "x$with_selinux" != "xno"], [
 
 # Configure fuse
 AS_IF([test "x$enable_fuse" != "xno"], [
-  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
   # Paranoia: don't trust the result reported by pkgconfig before trying out
   saved_LIBS="$LIBS"
   saved_CPPFLAGS=${CPPFLAGS}
-  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
-  LIBS="${libfuse_LIBS} $LIBS"
-  AC_CHECK_LIB(fuse, fuse_main, [
-    have_fuse="yes" ], [
-    AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly])])
+  PKG_CHECK_MODULES([libfuse3], [fuse3 >= 3.0], [
+    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
+    CPPFLAGS="${libfuse3_CFLAGS} ${CPPFLAGS}"
+    LIBS="${libfuse3_LIBS} $LIBS"
+    AC_CHECK_LIB(fuse3, fuse_session_new, [], [
+    AC_MSG_ERROR([libfuse3 (>= 3.0) doesn't work properly for lowlevel api])])
+    have_fuse="yes"
+  ], [
+    PKG_CHECK_MODULES([libfuse2], [fuse >= 2.6], [
+      AC_DEFINE([FUSE_USE_VERSION], [26], [used FUSE API version])
+      CPPFLAGS="${libfuse2_CFLAGS} ${CPPFLAGS}"
+      LIBS="${libfuse2_LIBS} $LIBS"
+      AC_CHECK_LIB(fuse, fuse_lowlevel_new, [], [
+        AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly for highlevel api and lowlevel api])])
+      have_fuse="yes"
+    ], [have_fuse="no"])
+  ])
   LIBS="${saved_LIBS}"
   CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
 
diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 50be783..d54fc89 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,8 +3,8 @@
 AUTOMAKE_OPTIONS = foreign
 noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c
+erofsfuse_SOURCES = main.c lowlevel.c
 erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
-erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
+erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
 	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
diff --git a/fuse/lowlevel.c b/fuse/lowlevel.c
new file mode 100644
index 0000000..fe8c51a
--- /dev/null
+++ b/fuse/lowlevel.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Created by Li Yiyan <lyy0627@sjtu.edu.com>
+ */
+#include "erofs/config.h"
+#include "erofs/dir.h"
+#include "erofs/inode.h"
+#include "erofs/io.h"
+#include "erofs/print.h"
+#include "macosx.h"
+#include "config.h"
+#include <fuse_opt.h>
+#include <libgen.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <float.h>
+
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+
+/* used in list/getxattr, given buf size is 0 and
+ * expected return val is xattr size
+ */
+#define TMP_BUF_SIZE 4096
+static const double EROFS_TIMEOUT = DBL_MAX;
+
+struct erofsfuse_ll_dir_context {
+	struct erofs_dir_context ctx;
+
+	fuse_req_t req;
+	void *buf;
+	int is_plus;
+	size_t offset;
+	size_t buf_size;
+	size_t start_off;
+	struct fuse_file_info *fi;
+};
+
+struct erofsfuse_ll_dir_search_context {
+	struct erofs_dir_context ctx;
+
+	const char *target_name;
+	size_t target_name_len;
+	struct fuse_entry_param *ent;
+};
+
+static int erofsfuse_ll_fill_dentries(struct erofs_dir_context *ctx)
+{
+	size_t r = 0;
+	struct stat st = { 0 };
+	char dname[EROFS_NAME_LEN + 1];
+	struct erofsfuse_ll_dir_context *fusectx =
+		(struct erofsfuse_ll_dir_context *)ctx;
+#if FUSE_USE_VERSION >= 30
+	struct fuse_entry_param param;
+#endif
+
+	if (fusectx->offset < fusectx->start_off) {
+		fusectx->offset +=
+			ctx->de_namelen + sizeof(struct erofs_dirent);
+		return 0;
+	}
+
+	strncpy(dname, ctx->dname, ctx->de_namelen);
+	dname[ctx->de_namelen] = '\0';
+	fusectx->offset += ctx->de_namelen + sizeof(struct erofs_dirent);
+
+	if (!fusectx->is_plus) { /* fuse 3 still use non-plus readdir */
+		st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
+		st.st_ino = ctx->de_nid;
+
+		r = fuse_add_direntry(fusectx->req, fusectx->buf,
+				      fusectx->buf_size, dname, &st,
+				      fusectx->offset);
+	} else {
+#if FUSE_USE_VERSION >= 30
+		param.ino = ctx->de_nid;
+		param.generation = 0;
+		param.attr.st_ino = ctx->de_nid;
+		param.attr.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
+		param.attr_timeout = EROFS_TIMEOUT;
+		param.entry_timeout = EROFS_TIMEOUT;
+
+		r = fuse_add_direntry_plus(fusectx->req, fusectx->buf,
+					   fusectx->buf_size, dname, &param,
+					   fusectx->offset);
+#else
+		erofs_err("fuse 2 readdirplus is not supported\n");
+#endif
+	}
+
+	if (r > fusectx->buf_size) {
+		fusectx->offset -=
+			ctx->de_namelen + sizeof(struct erofs_dirent);
+		return 1;
+	}
+	fusectx->buf += r;
+	fusectx->buf_size -= r;
+	return 0;
+}
+
+static void erofsfuse_ll_fill_stat(struct erofs_inode *vi, struct stat *stbuf)
+{
+	stbuf->st_mode = vi->i_mode;
+	stbuf->st_nlink = vi->i_nlink;
+
+	if (!S_ISDIR(stbuf->st_mode))
+		stbuf->st_size = vi->i_size;
+	if (S_ISBLK(vi->i_mode) || S_ISCHR(vi->i_mode))
+		stbuf->st_rdev = vi->u.i_rdev;
+
+	stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz()) >> 9;
+
+	stbuf->st_uid = vi->i_uid;
+	stbuf->st_gid = vi->i_gid;
+
+	stbuf->st_ctime = vi->i_mtime;
+	stbuf->st_mtime = stbuf->st_ctime;
+	stbuf->st_atime = stbuf->st_ctime;
+}
+
+static int erofsfuse_ll_search_dentries(struct erofs_dir_context *ctx)
+{
+	int r = 0;
+	struct erofs_inode vi;
+	struct erofsfuse_ll_dir_search_context *search_ctx =
+		(struct erofsfuse_ll_dir_search_context *)ctx;
+
+	if (search_ctx->ent->ino == 0 &&
+	    search_ctx->target_name_len == ctx->de_namelen &&
+	    strncmp(search_ctx->target_name, ctx->dname, ctx->de_namelen) ==
+		    0) {
+		search_ctx->ent->ino = ctx->de_nid;
+		search_ctx->ent->attr.st_ino = ctx->de_nid;
+		vi.nid = (erofs_nid_t)ctx->de_nid;
+
+		r = erofs_read_inode_from_disk(&vi);
+		if (r < 0)
+			return r;
+
+		erofsfuse_ll_fill_stat(&vi, &(search_ctx->ent->attr));
+	}
+
+	return 0;
+}
+
+static inline erofs_nid_t erofsfuse_ll_getnid(fuse_ino_t ino)
+{
+	return ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
+}
+
+static inline void erofsfuse_readdir_general(fuse_req_t req, fuse_ino_t ino,
+					     size_t size, off_t off,
+					     struct fuse_file_info *fi,
+					     int plus)
+{
+	int err = 0;
+	char *buf = malloc(size);
+	struct erofsfuse_ll_dir_context ctx;
+	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
+
+	erofs_dbg("readdir, ino: %lu, req: %p, fh: %lu, size: %lu, off: %lu\n",
+		  ino, req, fi->fh, size, off);
+	if (!buf) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+	ctx.ctx.dir = vi;
+	ctx.ctx.cb = erofsfuse_ll_fill_dentries;
+
+	ctx.fi = fi;
+	ctx.buf = buf;
+	ctx.buf_size = size;
+	ctx.req = req;
+	ctx.offset = 0;
+	ctx.start_off = off;
+	ctx.is_plus = plus;
+
+#ifdef NDEBUG
+	err = erofs_iterate_dir(&ctx.ctx, false);
+#else
+	err = erofs_iterate_dir(&ctx.ctx, true);
+#endif
+
+	if (err < 0) /* if buffer insufficient, return 1 */
+		fuse_reply_err(req, EIO);
+	else
+		fuse_reply_buf(req, buf, size - ctx.buf_size);
+
+	free(buf);
+}
+
+static void erofsfuse_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
+				 off_t off, struct fuse_file_info *fi)
+{
+	erofsfuse_readdir_general(req, ino, size, off, fi, 0);
+}
+
+#if FUSE_USE_VERSION >= 30
+static void erofsfuse_ll_readdirplus(fuse_req_t req, fuse_ino_t ino,
+				     size_t size, off_t off,
+				     struct fuse_file_info *fi)
+{
+	erofsfuse_readdir_general(req, ino, size, off, fi, 1);
+}
+#endif
+
+static void erofsfuse_ll_init(void *userdata, struct fuse_conn_info *conn)
+{
+	erofs_dbg("init fuse lowlevel erofs\n");
+}
+
+static void erofsfuse_ll_open(fuse_req_t req, fuse_ino_t ino,
+			      struct fuse_file_info *fi)
+{
+	int ret = 0;
+	struct erofs_inode *vi;
+
+	erofs_dbg("open, ino = %lu, req = %p\n", ino, req);
+	if (fi->flags & (O_WRONLY | O_RDWR)) {
+		fuse_reply_err(req, EROFS);
+		return;
+	}
+
+	if (ino == FUSE_ROOT_ID) {
+		fuse_reply_err(req, EISDIR);
+		return;
+	}
+
+	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	if (!vi) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	vi->nid = (erofs_nid_t)ino;
+	ret = erofs_read_inode_from_disk(vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+
+	if (!S_ISREG(vi->i_mode)) {
+		fuse_reply_err(req, EISDIR);
+	} else {
+		fi->fh = (uint64_t)vi;
+		fi->keep_cache = 1;
+		fuse_reply_open(req, fi);
+		return;
+	}
+
+out:
+	free(vi);
+}
+
+static void erofsfuse_ll_getattr(fuse_req_t req, fuse_ino_t ino,
+				 struct fuse_file_info *fi)
+{
+	int ret;
+	struct stat stbuf = { 0 };
+	struct erofs_inode vi;
+
+	erofs_dbg("getattr, ino: %lu, req: %p\n", ino, req);
+	vi.nid = erofsfuse_ll_getnid(ino);
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret < 0) {
+		erofs_dbg("read inode from disk failed, nid = %lu\n", vi.nid);
+		fuse_reply_err(req, ENOENT);
+	}
+
+	erofsfuse_ll_fill_stat(&vi, &stbuf);
+	stbuf.st_ino = ino;
+
+	fuse_reply_attr(req, &stbuf, EROFS_TIMEOUT);
+}
+
+static void erofsfuse_ll_opendir(fuse_req_t req, fuse_ino_t ino,
+				 struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode *vi;
+
+	erofs_dbg("opendir, ino = %lu\n", ino);
+	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	if (!vi) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	vi->nid = erofsfuse_ll_getnid(ino);
+	ret = erofs_read_inode_from_disk(vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+
+	if (!S_ISDIR(vi->i_mode)) {
+		fuse_reply_err(req, ENOTDIR);
+		goto out;
+	}
+
+	fi->fh = (uint64_t)vi;
+	fuse_reply_open(req, fi);
+	return;
+
+out:
+	free(vi);
+}
+
+static void erofsfuse_ll_release(fuse_req_t req, fuse_ino_t ino,
+				 struct fuse_file_info *fi)
+{
+	free((struct erofs_inode *)fi->fh);
+	fi->fh = 0;
+	fuse_reply_err(req, 0);
+}
+
+static void erofsfuse_ll_lookup(fuse_req_t req, fuse_ino_t parent,
+				const char *name)
+{
+	int err, ret;
+	struct erofs_inode *vi;
+	struct fuse_entry_param fentry;
+	struct erofsfuse_ll_dir_search_context ctx;
+
+	vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
+	if (!vi) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	vi->nid = erofsfuse_ll_getnid(parent);
+	ret = erofs_read_inode_from_disk(vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+	if (!S_ISDIR(vi->i_mode)) {
+		fuse_reply_err(req, ENOTDIR);
+		goto out;
+	}
+
+	memset(&fentry, 0, sizeof(fentry));
+	fentry.ino = 0;
+	fentry.attr_timeout = fentry.entry_timeout = EROFS_TIMEOUT;
+	ctx.ctx.dir = vi;
+	ctx.ctx.cb = erofsfuse_ll_search_dentries;
+
+	ctx.ent = &fentry;
+	ctx.target_name = name;
+	ctx.target_name_len = strlen(name);
+
+#ifdef NDEBUG
+	err = erofs_iterate_dir(&ctx.ctx, false);
+#else
+	err = erofs_iterate_dir(&ctx.ctx, true);
+#endif
+
+	if (err < 0) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+	fuse_reply_entry(req, &fentry);
+
+out:
+	free(vi);
+}
+
+static void erofsfuse_ll_read(fuse_req_t req, fuse_ino_t ino, size_t size,
+			      off_t off, struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
+	char *buf = malloc(size);
+
+	erofs_dbg("read, ino = %lu, size = %lu, off = %lu, fh = %lu\n", ino,
+		  size, off, fi->fh);
+	if (!buf) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	if (!S_ISREG(vi->i_mode)) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+
+	ret = erofs_pread(vi, buf, size, off);
+	if (ret) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+	if (off >= vi->i_size)
+		ret = 0;
+	else if (off + size > vi->i_size)
+		ret = vi->i_size - off;
+	else
+		ret = size;
+
+	fuse_reply_buf(req, buf, ret);
+
+out:
+	free(buf);
+}
+
+static void erofsfuse_ll_readlink(fuse_req_t req, fuse_ino_t ino)
+{
+	int ret;
+	char *dst;
+	struct erofs_inode vi;
+
+	erofs_dbg("read_link, ino = %lu\n", ino);
+	vi.nid = erofsfuse_ll_getnid(ino);
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		return;
+	}
+
+	if (!S_ISLNK(vi.i_mode)) {
+		fuse_reply_err(req, EINVAL);
+		return;
+	}
+
+	dst = malloc(vi.i_size + 1);
+	if (!dst) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	ret = erofs_pread(&vi, dst, vi.i_size, 0);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		goto out;
+	}
+
+	dst[vi.i_size] = '\0';
+	fuse_reply_readlink(req, dst);
+
+out:
+	free(dst);
+}
+
+static void erofsfuse_ll_getxattr(fuse_req_t req, fuse_ino_t ino,
+				  const char *name, size_t size)
+{
+	int ret;
+	char *buf = NULL;
+	struct erofs_inode vi;
+	size_t real = size == 0 ? TMP_BUF_SIZE : size;
+
+	erofs_dbg("getxattr, ino = %lu, name = %s, size = %lu\n", ino, name,
+		  size);
+	vi.nid = erofsfuse_ll_getnid(ino);
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		return;
+	}
+
+	buf = malloc(real);
+	if (!buf) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	ret = erofs_getxattr(&vi, name, buf, real);
+	if (ret < 0)
+		fuse_reply_err(req, -ret);
+	else if (size == 0)
+		fuse_reply_xattr(req, ret);
+	else
+		fuse_reply_buf(req, buf, ret);
+
+	free(buf);
+}
+
+static void erofsfuse_ll_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
+{
+	int ret;
+	char *buf = NULL;
+	struct erofs_inode vi;
+	size_t real = size == 0 ? TMP_BUF_SIZE : size;
+
+	erofs_dbg("listxattr, ino = %lu, size = %lu\n", ino, size);
+	vi.nid = erofsfuse_ll_getnid(ino);
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret < 0) {
+		fuse_reply_err(req, EIO);
+		return;
+	}
+
+	buf = malloc(real);
+	if (!buf) {
+		fuse_reply_err(req, ENOMEM);
+		return;
+	}
+
+	ret = erofs_listxattr(&vi, buf, real);
+	if (ret < 0)
+		fuse_reply_err(req, -ret);
+	else if (size == 0)
+		fuse_reply_xattr(req, ret);
+	else
+		fuse_reply_buf(req, buf, ret);
+
+	free(buf);
+}
+
+struct fuse_lowlevel_ops erofsfuse_lops = {
+	.getxattr = erofsfuse_ll_getxattr,
+	.opendir = erofsfuse_ll_opendir,
+	.releasedir = erofsfuse_ll_release,
+	.release = erofsfuse_ll_release,
+	.lookup = erofsfuse_ll_lookup,
+	.listxattr = erofsfuse_ll_listxattr,
+	.readlink = erofsfuse_ll_readlink,
+	.getattr = erofsfuse_ll_getattr,
+	.readdir = erofsfuse_ll_readdir,
+#if FUSE_USE_VERSION >= 30
+	.readdirplus = erofsfuse_ll_readdirplus,
+#endif
+	.open = erofsfuse_ll_open,
+	.read = erofsfuse_ll_read,
+	.init = erofsfuse_ll_init,
+};
diff --git a/fuse/main.c b/fuse/main.c
index b060e06..049d100 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -6,8 +6,6 @@
 #include <string.h>
 #include <signal.h>
 #include <libgen.h>
-#include <fuse.h>
-#include <fuse_opt.h>
 #include "macosx.h"
 #include "erofs/config.h"
 #include "erofs/print.h"
@@ -15,177 +13,11 @@
 #include "erofs/dir.h"
 #include "erofs/inode.h"
 
-struct erofsfuse_dir_context {
-	struct erofs_dir_context ctx;
-	fuse_fill_dir_t filler;
-	struct fuse_file_info *fi;
-	void *buf;
-};
-
-static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
-{
-	struct erofsfuse_dir_context *fusectx = (void *)ctx;
-	struct stat st = {0};
-	char dname[EROFS_NAME_LEN + 1];
-
-	strncpy(dname, ctx->dname, ctx->de_namelen);
-	dname[ctx->de_namelen] = '\0';
-	st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;
-	fusectx->filler(fusectx->buf, dname, &st, 0);
-	return 0;
-}
-
-int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
-		      off_t offset, struct fuse_file_info *fi)
-{
-	int ret;
-	struct erofs_inode dir;
-	struct erofsfuse_dir_context ctx = {
-		.ctx.dir = &dir,
-		.ctx.cb = erofsfuse_fill_dentries,
-		.filler = filler,
-		.fi = fi,
-		.buf = buf,
-	};
-	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
-
-	ret = erofs_ilookup(path, &dir);
-	if (ret)
-		return ret;
-
-	erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
-	if (!S_ISDIR(dir.i_mode))
-		return -ENOTDIR;
-
-	if (!dir.i_size)
-		return 0;
-#ifdef NDEBUG
-	return erofs_iterate_dir(&ctx.ctx, false);
-#else
-	return erofs_iterate_dir(&ctx.ctx, true);
-#endif
-}
-
-static void *erofsfuse_init(struct fuse_conn_info *info)
-{
-	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
-	return NULL;
-}
-
-static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
-{
-	erofs_dbg("open path=%s", path);
-
-	if ((fi->flags & O_ACCMODE) != O_RDONLY)
-		return -EACCES;
-
-	return 0;
-}
-
-static int erofsfuse_getattr(const char *path, struct stat *stbuf)
-{
-	struct erofs_inode vi = {};
-	int ret;
-
-	erofs_dbg("getattr(%s)", path);
-	ret = erofs_ilookup(path, &vi);
-	if (ret)
-		return -ENOENT;
-
-	stbuf->st_mode  = vi.i_mode;
-	stbuf->st_nlink = vi.i_nlink;
-	stbuf->st_size  = vi.i_size;
-	stbuf->st_blocks = roundup(vi.i_size, erofs_blksiz()) >> 9;
-	stbuf->st_uid = vi.i_uid;
-	stbuf->st_gid = vi.i_gid;
-	if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
-		stbuf->st_rdev = vi.u.i_rdev;
-	stbuf->st_ctime = vi.i_mtime;
-	stbuf->st_mtime = stbuf->st_ctime;
-	stbuf->st_atime = stbuf->st_ctime;
-	return 0;
-}
-
-static int erofsfuse_read(const char *path, char *buffer,
-			  size_t size, off_t offset,
-			  struct fuse_file_info *fi)
-{
-	int ret;
-	struct erofs_inode vi;
-
-	erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
-
-	ret = erofs_ilookup(path, &vi);
-	if (ret)
-		return ret;
-
-	ret = erofs_pread(&vi, buffer, size, offset);
-	if (ret)
-		return ret;
-	if (offset >= vi.i_size)
-		return 0;
-	if (offset + size > vi.i_size)
-		return vi.i_size - offset;
-	return size;
-}
-
-static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
-{
-	int ret = erofsfuse_read(path, buffer, size, 0, NULL);
-
-	if (ret < 0)
-		return ret;
-	DBG_BUGON(ret > size);
-	if (ret == size)
-		buffer[size - 1] = '\0';
-	erofs_dbg("readlink(%s): %s", path, buffer);
-	return 0;
-}
-
-static int erofsfuse_getxattr(const char *path, const char *name, char *value,
-			size_t size
-#ifdef __APPLE__
-			, uint32_t position)
-#else
-			)
-#endif
-{
-	int ret;
-	struct erofs_inode vi;
-
-	erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
-
-	ret = erofs_ilookup(path, &vi);
-	if (ret)
-		return ret;
-
-	return erofs_getxattr(&vi, name, value, size);
-}
-
-static int erofsfuse_listxattr(const char *path, char *list, size_t size)
-{
-	int ret;
-	struct erofs_inode vi;
-
-	erofs_dbg("listxattr(%s): size=%llu", path, size);
-
-	ret = erofs_ilookup(path, &vi);
-	if (ret)
-		return ret;
-
-	return erofs_listxattr(&vi, list, size);
-}
+#include <float.h>
+#include <fuse.h>
+#include <fuse_lowlevel.h>
 
-static struct fuse_operations erofs_ops = {
-	.getxattr = erofsfuse_getxattr,
-	.listxattr = erofsfuse_listxattr,
-	.readlink = erofsfuse_readlink,
-	.getattr = erofsfuse_getattr,
-	.readdir = erofsfuse_readdir,
-	.open = erofsfuse_open,
-	.read = erofsfuse_read,
-	.init = erofsfuse_init,
-};
+extern struct fuse_lowlevel_ops erofsfuse_lops;
 
 static struct options {
 	const char *disk;
@@ -207,7 +39,9 @@ static const struct fuse_opt option_spec[] = {
 
 static void usage(void)
 {
+#if FUSE_MAJOR_VERSION < 3
 	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
+#endif
 
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
 	      "Options:\n"
@@ -257,8 +91,10 @@ static int optional_opt_func(void *data, const char *arg, int key,
 			fusecfg.disk = strdup(arg);
 			return 0;
 		}
-		if (!fusecfg.mountpoint)
+		if (!fusecfg.mountpoint) {
 			fusecfg.mountpoint = strdup(arg);
+			return 0;
+		}
 	case FUSE_OPT_KEY_OPT:
 		if (!strcmp(arg, "-d"))
 			fusecfg.odebug = true;
@@ -297,6 +133,7 @@ static void signal_handle_sigsegv(int signal)
 int main(int argc, char *argv[])
 {
 	int ret;
+	struct fuse_session *se;
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
 
 	erofs_init_configure();
@@ -337,7 +174,38 @@ int main(int argc, char *argv[])
 		goto err_dev_close;
 	}
 
-	ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
+#if FUSE_USE_VERSION >= 30
+	se = fuse_session_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
+			      NULL);
+	if (se != NULL) {
+		fuse_set_signal_handlers(se);
+		fuse_session_mount(se, fusecfg.mountpoint);
+
+		ret = fuse_session_loop(se);
+
+		fuse_remove_signal_handlers(se);
+		fuse_session_unmount(se);
+		fuse_session_destroy(se);
+	}
+#else
+	struct fuse_chan *ch;
+
+	ch = fuse_mount(fusecfg.mountpoint, &args);
+	if (ch != NULL) {
+		se = fuse_lowlevel_new(&args, &erofsfuse_lops,
+				       sizeof(erofsfuse_lops), NULL);
+		if (se != NULL) {
+			if (fuse_set_signal_handlers(se) != -1) {
+				fuse_session_add_chan(se, ch);
+				ret = fuse_session_loop(se);
+				fuse_remove_signal_handlers(se);
+				fuse_session_remove_chan(ch);
+			}
+			fuse_session_destroy(se);
+		}
+		fuse_unmount(fusecfg.mountpoint, ch);
+	}
+#endif
 
 	erofs_put_super();
 err_dev_close:
-- 
2.34.1

