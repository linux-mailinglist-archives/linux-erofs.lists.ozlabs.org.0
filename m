Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11036476766
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 02:25:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDvZ81yxSz2ynm
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 12:25:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XuXFOOSB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XuXFOOSB; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDvZ31XVhz2xBJ
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 12:25:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7EED161B36;
 Thu, 16 Dec 2021 01:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF63C36AE1;
 Thu, 16 Dec 2021 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639617923;
 bh=GuogtTLlMYpKNVdjVMzp/w4Xxw0YvZqw+QMVKz3nWsg=;
 h=From:To:Cc:Subject:Date:From;
 b=XuXFOOSBJxZanqnsDxjqL7yA4gNN3VvO10w32y/YNe6SRjD1AH7dm2W88OZ1lElFo
 pacVZB/MNLhycLAWGDvZsXaUbhm0wDytQgJx/REnPxlWLx/uUJB4i6yOPLYx2Tuk5m
 ySIoWPe6n14M51l4Gvz+Da5CmrtOR1aljJ0G2ky7s5sjGcl96Hk78jTayRLqFQcbcO
 7ST/ftYEILKXi05Vk0Q1QTsnNqvWJMTeOyRiTxZ2lw3kZXdj5RcJShH+7LZo/HAreI
 FgTs46joEiiHhsl1jY+5QUmx8nGWmWOdaJkwK0vtP4KatQjcBTlKZwUwKfqxHeXwB/
 4iTrjjK86Ebow==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/2] erofs-utils: lib: add API to iterate dirs in EROFS
Date: Thu, 16 Dec 2021 09:24:35 +0800
Message-Id: <20211216012436.10111-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

This introduces erofs_iterate_dir() to iterate all dirents in
a directory inode and convert erofsfuse to use the API.

Note that it doesn't recursively walk into sub-directories.
If it's really needed, users should handle this in the callback.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3: https://lore.kernel.org/linux-erofs/20211215194200.61210-1-hsiangkao@linux.alibaba.com/
changes since v2:
 - resolve nid endianless issue.

 fuse/Makefile.am         |   2 +-
 fuse/dir.c               | 100 -----------------------
 fuse/main.c              |  52 +++++++++++-
 include/erofs/dir.h      |  53 +++++++++++++
 include/erofs/internal.h |   8 ++
 lib/Makefile.am          |   2 +-
 lib/dir.c                | 167 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 280 insertions(+), 104 deletions(-)
 delete mode 100644 fuse/dir.c
 create mode 100644 include/erofs/dir.h
 create mode 100644 lib/dir.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 8a2d4720d1b7..5aa5ac07be70 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,7 +3,7 @@
 AUTOMAKE_OPTIONS = foreign
 noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = dir.c main.c
+erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
diff --git a/fuse/dir.c b/fuse/dir.c
deleted file mode 100644
index bc8735bedb6f..000000000000
--- a/fuse/dir.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Created by Li Guifu <blucerlee@gmail.com>
- */
-#include <fuse.h>
-#include <fuse_opt.h>
-#include "macosx.h"
-#include "erofs/internal.h"
-#include "erofs/print.h"
-
-static int erofs_fill_dentries(struct erofs_inode *dir,
-			       fuse_fill_dir_t filler, void *buf,
-			       void *dblk, unsigned int nameoff,
-			       unsigned int maxsize)
-{
-	struct erofs_dirent *de = dblk;
-	const struct erofs_dirent *end = dblk + nameoff;
-	char namebuf[EROFS_NAME_LEN + 1];
-
-	while (de < end) {
-		const char *de_name;
-		unsigned int de_namelen;
-
-		nameoff = le16_to_cpu(de->nameoff);
-		de_name = (char *)dblk + nameoff;
-
-		/* the last dirent in the block? */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
-			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
-
-		/* a corrupted entry is found */
-		if (nameoff + de_namelen > maxsize ||
-		    de_namelen > EROFS_NAME_LEN) {
-			erofs_err("bogus dirent @ nid %llu", dir->nid | 0ULL);
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
-
-		memcpy(namebuf, de_name, de_namelen);
-		namebuf[de_namelen] = '\0';
-
-		filler(buf, namebuf, NULL, 0);
-		++de;
-	}
-	return 0;
-}
-
-int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
-		      off_t offset, struct fuse_file_info *fi)
-{
-	int ret;
-	struct erofs_inode dir;
-	char dblk[EROFS_BLKSIZ];
-	erofs_off_t pos;
-
-	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
-
-	ret = erofs_ilookup(path, &dir);
-	if (ret)
-		return ret;
-
-	erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
-
-	if (!S_ISDIR(dir.i_mode))
-		return -ENOTDIR;
-
-	if (!dir.i_size)
-		return 0;
-
-	pos = 0;
-	while (pos < dir.i_size) {
-		unsigned int nameoff, maxsize;
-		struct erofs_dirent *de;
-
-		maxsize = min_t(unsigned int, EROFS_BLKSIZ,
-				dir.i_size - pos);
-		ret = erofs_pread(&dir, dblk, maxsize, pos);
-		if (ret)
-			return ret;
-
-		de = (struct erofs_dirent *)dblk;
-		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) ||
-		    nameoff >= PAGE_SIZE) {
-			erofs_err("invalid de[0].nameoff %u @ nid %llu",
-				  nameoff, dir.nid | 0ULL);
-			ret = -EFSCORRUPTED;
-			break;
-		}
-
-		ret = erofs_fill_dentries(&dir, filler, buf,
-					  dblk, nameoff, maxsize);
-		if (ret)
-			break;
-		pos += maxsize;
-	}
-	return 0;
-}
diff --git a/fuse/main.c b/fuse/main.c
index 255965e30969..2549d8a9b33a 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,9 +12,57 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
+#include "erofs/dir.h"
 
-int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
-		      off_t offset, struct fuse_file_info *fi);
+struct erofsfuse_dir_context {
+	struct erofs_dir_context ctx;
+	fuse_fill_dir_t filler;
+	struct fuse_file_info *fi;
+	void *buf;
+};
+
+static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
+{
+	struct erofsfuse_dir_context *fusectx = (void *)ctx;
+	char dname[EROFS_NAME_LEN + 1];
+
+	strncpy(dname, ctx->dname, ctx->de_namelen);
+	dname[ctx->de_namelen] = '\0';
+	fusectx->filler(fusectx->buf, dname, NULL, 0);
+	return 0;
+}
+
+int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode dir;
+	struct erofsfuse_dir_context ctx = {
+		.ctx.dir = &dir,
+		.ctx.cb = erofsfuse_fill_dentries,
+		.filler = filler,
+		.fi = fi,
+		.buf = buf,
+	};
+	erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
+
+	ret = erofs_ilookup(path, &dir);
+	if (ret)
+		return ret;
+
+	erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
+	if (!S_ISDIR(dir.i_mode))
+		return -ENOTDIR;
+
+	if (!dir.i_size)
+		return 0;
+#ifdef NDEBUG
+	return erofs_iterate_dir(&ctx.ctx, false);
+#else
+	return erofs_iterate_dir(&ctx.ctx, true);
+#endif
+
+}
 
 static void *erofsfuse_init(struct fuse_conn_info *info)
 {
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
new file mode 100644
index 000000000000..25d6ce7ca072
--- /dev/null
+++ b/include/erofs/dir.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_DIR_H
+#define __EROFS_DIR_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "internal.h"
+
+#define EROFS_READDIR_VALID_PNID	0x0001
+#define EROFS_READDIR_DOTDOT_FOUND	0x0002
+#define EROFS_READDIR_DOT_FOUND		0x0004
+
+#define EROFS_READDIR_ALL_SPECIAL_FOUND	\
+	(EROFS_READDIR_DOTDOT_FOUND | EROFS_READDIR_DOT_FOUND)
+
+struct erofs_dir_context;
+
+/* callback function for iterating over inodes of EROFS */
+typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
+
+/*
+ * Callers could use a wrapper to contain extra information.
+ *
+ * Note that callback can reuse `struct erofs_dir_context' with care
+ * to avoid stack overflow due to deep recursion: dir, pnid, flags,
+ * (optional)cb SHOULD be saved to ensure the original state.
+ *
+ * Another way is to allocate `struct erofs_dir_context' on heap,
+ * and chain them together for multi-level traversal.
+ */
+struct erofs_dir_context {
+	struct erofs_inode *dir;
+	erofs_readdir_cb cb;
+	erofs_nid_t pnid;		/* optional */
+
+	/* [out] the dirent which is under processing */
+	const char *dname;
+	erofs_nid_t de_nid;
+	u8 de_namelen, de_ftype, flags;
+	bool dot_dotdot;
+};
+
+/* iterate over inodes that are in directory */
+int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index e6beb8cb8528..d2adf57d8ae2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -235,6 +235,14 @@ struct erofs_dentry {
 	};
 };
 
+static inline bool is_dot_dotdot_len(const char *name, unsigned int len)
+{
+	if (len >= 1 && name[0] != '.')
+		return false;
+
+	return len == 1 || (len == 2 && name[1] == '.');
+}
+
 static inline bool is_dot_dotdot(const char *name)
 {
 	if (name[0] != '.')
diff --git a/lib/Makefile.am b/lib/Makefile.am
index c745e493c391..4a2501342729 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
 noinst_HEADERS += compressor.h
 liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
-		      compress_hints.c hashmap.c sha256.c blobchunk.c
+		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/dir.c b/lib/dir.c
new file mode 100644
index 000000000000..63e35ba2318b
--- /dev/null
+++ b/lib/dir.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/print.h"
+#include "erofs/dir.h"
+#include <stdlib.h>
+
+static int traverse_dirents(struct erofs_dir_context *ctx,
+			    void *dentry_blk, unsigned int lblk,
+			    unsigned int next_nameoff, unsigned int maxsize,
+			    bool fsck)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	const char *prev_name = NULL;
+	const char *errmsg;
+	unsigned int prev_namelen = 0;
+	int ret = 0;
+	bool silent = false;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		ctx->de_nid = le64_to_cpu(de->nid);
+		erofs_dbg("traversed nid (%llu)", ctx->de_nid | 0ULL);
+
+		ret = -EFSCORRUPTED;
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			errmsg = "bogus dirent nameoff";
+			break;
+		}
+
+		if (nameoff + de_namelen > maxsize ||
+				de_namelen > EROFS_NAME_LEN) {
+			errmsg = "bogus dirent namelen";
+			break;
+		}
+
+		if (fsck && prev_name) {
+			int cmp = strncmp(prev_name, de_name,
+					  min(prev_namelen, de_namelen));
+
+			if (cmp > 0 || (cmp == 0 &&
+					prev_namelen >= de_namelen)) {
+				errmsg = "wrong dirent name order";
+				break;
+			}
+		}
+
+		if (fsck && de->file_type >= EROFS_FT_MAX) {
+			errmsg = "invalid file type %u";
+			break;
+		}
+
+		ctx->dname = de_name;
+		ctx->de_namelen = de_namelen;
+		ctx->dot_dotdot = is_dot_dotdot_len(de_name, de_namelen);
+		if (ctx->dot_dotdot) {
+			switch (de_namelen) {
+			case 2:
+				if (fsck &&
+				    (ctx->flags & EROFS_READDIR_DOTDOT_FOUND)) {
+					errmsg = "duplicated `..' dirent";
+					goto out;
+				}
+				ctx->flags |= EROFS_READDIR_DOTDOT_FOUND;
+				if (sbi.root_nid == ctx->dir->nid) {
+					ctx->pnid = sbi.root_nid;
+					ctx->flags |= EROFS_READDIR_VALID_PNID;
+				}
+				if (fsck &&
+				    (ctx->flags & EROFS_READDIR_VALID_PNID) &&
+				    ctx->de_nid != ctx->pnid) {
+					errmsg = "corrupted `..' dirent";
+					goto out;
+				}
+				break;
+			case 1:
+				if (fsck &&
+				    (ctx->flags & EROFS_READDIR_DOT_FOUND)) {
+					errmsg = "duplicated `.' dirent";
+					goto out;
+				}
+
+				ctx->flags |= EROFS_READDIR_DOT_FOUND;
+				if (fsck && ctx->de_nid != ctx->dir->nid) {
+					errmsg = "corrupted `.' dirent";
+					goto out;
+				}
+				break;
+			}
+		}
+		ret = ctx->cb(ctx);
+		if (ret) {
+			silent = true;
+			break;
+		}
+		prev_name = de_name;
+		prev_namelen = de_namelen;
+		next_nameoff += de_namelen;
+		++de;
+	}
+out:
+	if (ret && !silent)
+		erofs_err("%s @ nid %llu, lblk %u, index %lu",
+			  errmsg, ctx->dir->nid | 0ULL, lblk,
+			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
+	return ret;
+}
+
+int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
+{
+	struct erofs_inode *dir = ctx->dir;
+	int err;
+	erofs_off_t pos;
+	char buf[EROFS_BLKSIZ];
+
+	if ((dir->i_mode & S_IFMT) != S_IFDIR)
+		return -ENOTDIR;
+
+	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
+	pos = 0;
+	while (pos < dir->i_size) {
+		erofs_blk_t lblk = erofs_blknr(pos);
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					dir->i_size - pos, EROFS_BLKSIZ);
+		const struct erofs_dirent *de = (const void *)buf;
+		unsigned int nameoff;
+
+		err = erofs_pread(dir, buf, maxsize, pos);
+		if (err) {
+			erofs_err("I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
+				  dir->nid | 0ULL, lblk, err);
+			return err;
+		}
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
+				  nameoff, dir->nid | 0ULL, lblk);
+			return -EFSCORRUPTED;
+		}
+		err = traverse_dirents(ctx, buf, lblk, nameoff, maxsize, fsck);
+		if (err)
+			break;
+		pos += maxsize;
+	}
+
+	if (fsck && (ctx->flags & EROFS_READDIR_ALL_SPECIAL_FOUND) !=
+			EROFS_READDIR_ALL_SPECIAL_FOUND) {
+		erofs_err("`.' or `..' dirent is missing @ nid %llu",
+			  dir->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+	return 0;
+}
-- 
2.20.1

