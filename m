Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 51049479511
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 20:47:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFzzD1g9Nz3cGn
	for <lists+linux-erofs@lfdr.de>; Sat, 18 Dec 2021 06:47:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639770456;
	bh=DPysDpbf5al43rPrWuOoMaVM0wzlFfcd8mLecUNFE8A=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S1RG1DLiV8vAbRA1gUStbJ1D2su+wc07AudOfzWNC6vbB4zCfKFMf91WCP7GwI1QZ
	 7yFIpYUPUkyMgIcYoMZsxbEDs6FhQBCY3XhECR9HX2OnLHiwDyMeLvYOgxQqFkO9//
	 sgIPVVYkE2v3dpqLy9Vy4mZ7Y+mVlrWuJpTXyvcYKFCkk+Sv62klRTMeA+4ejdmwue
	 OzPcGxDQoHJd+8qbjeIV2CoSAWWhg6B6aPTxIDbGs5VHRprODX/Rt/V8SAhbBlIonS
	 ejeQu25ixlEWsYl5lVAaPcv5OGkTthGxJxym/RSUzfkb+NlEDmomcCpcwtxZ1NqAse
	 NOiA6DiHIBL/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--zhangkelvin.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3s-m8yqskcyybjcpimgnxkpiqqing.eqonkpwz-gtqhunkuvu.qbncdu.qti@flex--zhangkelvin.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=HdD9iUv+; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFzz46vYBz3cCS
 for <linux-erofs@lists.ozlabs.org>; Sat, 18 Dec 2021 06:47:26 +1100 (AEDT)
Received: by mail-yb1-xb4a.google.com with SMTP id
 j204-20020a2523d5000000b005c21574c704so6662107ybj.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 11:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DPysDpbf5al43rPrWuOoMaVM0wzlFfcd8mLecUNFE8A=;
 b=WMt473lswn8zYZ9lLCOOEC873gmbM1ncGONjHRG0v1zb030Sbyw/XGCcOqf3v6CA+Q
 PSZpG3U8P3R6dBFFf462MQRCVr8gAjjH6I03qScwWf80ai8k3V8XBTyIs6RNIv+fagaE
 Dzt9lifH9zSRhSWPfBJS/kIIDuYevGiknR9YnLF4kUYY7coTP1lx3EC5c9nquB5dmLA1
 zkGeQMg2Bkybtpud2m0vGm9DKQ6EQASX1BepsmISimKRHiv58H8wZWqUudsEHW0sHhQ+
 HEZ9L2HQLyZIjb0Z99cHCKAxGcvMC9rUD74U+Vkmr7RT9k1fLpQ3OX68BpTzQAe5SDP0
 sI/A==
X-Gm-Message-State: AOAM5325oyslm++GQScN4WG52zWwJ9aCB+CvRemaqv8t1k9vW+IiYVyS
 LnQP0/BGeNM8WSTkPOfa2W3xIWYshLLeneVK6RS68x1WISaX8sXCGZnAwSINTtUFllwF6eSE/vk
 tQffnzhJGlHU+h/4LxEA6KMp70tpV3C+gV++G/oC4bf+NnrMTtX11cdLI2AsO7fWnEPdDaOta94
 /1IHP/bXs=
X-Google-Smtp-Source: ABdhPJyXYF4001tDubVlsGKjs47OzE7jfLS0DoWdSTyM0/h/3ZUu5My4KPBv+5QLNfN4EzQtNOAxbuNKS5Kl//Fbdw==
X-Received: from zhangkelvin-big.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a5b:14a:: with SMTP id
 c10mr1631019ybp.586.1639770443824; Fri, 17 Dec 2021 11:47:23 -0800 (PST)
Date: Fri, 17 Dec 2021 11:47:20 -0800
In-Reply-To: <20211217194720.3219630-1-zhangkelvin@google.com>
Message-Id: <20211217194720.3219630-2-zhangkelvin@google.com>
Mime-Version: 1.0
References: <YboyJ1udT7fpz5I7@B-P7TQMD6M-0146.local>
 <20211217194720.3219630-1-zhangkelvin@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v7 2/2] erofs-utils: lib: add API to iterate dirs in EROFS
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 fuse/Makefile.am    |   2 +-
 fuse/dir.c          | 100 --------------------
 fuse/main.c         |  65 +++++++++++--
 include/erofs/dir.h |  52 +++++++++++
 lib/Makefile.am     |   2 +-
 lib/dir.c           | 223 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 334 insertions(+), 110 deletions(-)
 delete mode 100644 fuse/dir.c
 create mode 100644 include/erofs/dir.h
 create mode 100644 lib/dir.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index 7b007f3..0a78c0a 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -2,7 +2,7 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = dir.c main.c
+erofsfuse_SOURCES = main.c
 erofsfuse_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
 erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
diff --git a/fuse/dir.c b/fuse/dir.c
deleted file mode 100644
index bc8735b..0000000
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
index 255965e..53dbdd4 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -12,9 +12,58 @@
 #include "erofs/config.h"
 #include "erofs/print.h"
 #include "erofs/io.h"
+#include "erofs/dir.h"
 
-int erofsfuse_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
-		      off_t offset, struct fuse_file_info *fi);
+struct erofsfuse_dir_context {
+	fuse_fill_dir_t filler;
+	struct fuse_file_info *fi;
+	void *buf;
+};
+
+static int erofsfuse_fill_dentries(struct erofs_dirent_info *ctx)
+{
+	struct erofsfuse_dir_context *fusectx = ctx->arg;
+
+	fusectx->filler(fusectx->buf, ctx->dname, NULL, 0);
+	return 0;
+}
+
+int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+		      off_t offset, struct fuse_file_info *fi)
+{
+	int ret;
+	struct erofs_inode dir;
+
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
+	struct erofsfuse_dir_context ctx = {
+		.filler = filler,
+		.fi = fi,
+		.buf = buf,
+	};
+	struct erofs_iterate_dir_param param = {
+		.cb = erofsfuse_fill_dentries,
+		.fsck = false,
+		.nid = dir.nid,
+		.recursive = false,
+		.arg = &ctx,
+	};
+#ifndef NDEBUG
+	param.fsck = true;
+#endif
+	return erofs_iterate_dir(&param);
+
+}
 
 static void *erofsfuse_init(struct fuse_conn_info *info)
 {
@@ -122,13 +171,13 @@ static void usage(void)
 	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
 
 	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
-	      "Options:\n"
-	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
-	      "    --device=#             specify an extra device to be used together\n"
+		  "Options:\n"
+		  "    --dbglevel=#           set output message level to # (maximum 9)\n"
+		  "    --device=#             specify an extra device to be used together\n"
 #if FUSE_MAJOR_VERSION < 3
-	      "    --help                 display this help and exit\n"
+		  "    --help                 display this help and exit\n"
 #endif
-	      "\n", stderr);
+		  "\n", stderr);
 
 #if FUSE_MAJOR_VERSION >= 3
 	fuse_cmdline_help();
@@ -148,7 +197,7 @@ static void erofsfuse_dumpcfg(void)
 }
 
 static int optional_opt_func(void *data, const char *arg, int key,
-			     struct fuse_args *outargs)
+				 struct fuse_args *outargs)
 {
 	int ret;
 
diff --git a/include/erofs/dir.h b/include/erofs/dir.h
new file mode 100644
index 0000000..affb607
--- /dev/null
+++ b/include/erofs/dir.h
@@ -0,0 +1,52 @@
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
+struct erofs_dir_context;
+
+struct erofs_dirent_info {
+	/* inode id of the inode being iterated */
+	erofs_nid_t nid;
+	/* file type, see values before EROFS_FT_MAX */
+	u8 ftype;
+	const char *dname;
+	/* opaque ptr passed in erofs_iterate_dir_param,
+	 * can be used to persist state across multiple
+	 * callbacks.
+	 */
+	void *arg;
+};
+
+/* callback function for iterating over inodes of EROFS */
+typedef int (*erofs_readdir_cb)(struct erofs_dirent_info *);
+
+/* callers could use a wrapper to contain extra information */
+struct erofs_iterate_dir_param {
+	/* inode id of the directory that needs to be iterated. */
+	/* Use sbi.root_nid if you want to iterate over rood dir */
+	erofs_nid_t nid;
+	bool fsck;                      /* Whether to perform validity check */
+	erofs_nid_t pnid;               /* optional, needed if fsck = true */
+	erofs_readdir_cb cb;
+	/* Whether to iterate this directory recursively */
+	bool recursive;
+	/* This will be copied to erofs_dirent_info.arg when invoking callback */
+	void *arg;
+};
+
+/* iterate over inodes that are in directory */
+int erofs_iterate_dir(const struct erofs_iterate_dir_param *ctx);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 67ba798..25a4a2b 100644
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
index 0000000..04a4596
--- /dev/null
+++ b/lib/dir.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#include "erofs/dir.h"
+
+#include <linux/limits.h>
+#include <stdlib.h>
+
+#include "erofs/internal.h"
+#include "erofs/print.h"
+
+struct erofs_dir_context {
+	erofs_nid_t pnid;               /* optional */
+	struct erofs_inode *dir;
+
+	bool dot_found;
+	bool dot_dot_found;
+	char cur_name[PATH_MAX];
+	char prev_name[PATH_MAX];
+};
+
+
+static int traverse_dirents(
+		struct erofs_dir_context *ctx,
+		const struct erofs_iterate_dir_param *params,
+		const void *dentry_blk,
+		unsigned int lblk, unsigned int next_nameoff,
+		unsigned int maxsize, bool fsck)
+{
+	const struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	char *prev_name = ctx->prev_name;
+	char *cur_name = ctx->cur_name;
+	const char *errmsg;
+	int ret = 0;
+	bool silent = false;
+
+	while (de < end) {
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		const char *de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		strncpy(cur_name, de_name, de_namelen);
+		cur_name[de_namelen] = '\0';
+		if (!cur_name) {
+			errmsg = "failed to allocate dirent name";
+			ret = -ENOMEM;
+			break;
+		}
+
+		erofs_dbg("traversed filename(%s)", cur_name);
+
+		ret = -EFSCORRUPTED;
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			errmsg = "bogus dirent nameoff";
+			break;
+		}
+
+		if (nameoff + de_namelen > maxsize || de_namelen > EROFS_NAME_LEN) {
+			errmsg = "bogus dirent namelen";
+			break;
+		}
+
+		if (fsck && prev_name && strcmp(prev_name, cur_name) >= 0) {
+			errmsg = "wrong dirent name order";
+			break;
+		}
+
+		if (fsck && de->file_type >= EROFS_FT_MAX) {
+			errmsg = "invalid file type %u";
+			break;
+		}
+
+		const bool dot_dotdot = is_dot_dotdot(cur_name);
+
+		if (dot_dotdot) {
+			switch (de_namelen) {
+			case 2:
+				if (fsck && ctx->dot_dot_found) {
+					errmsg = "duplicated `..' dirent";
+					goto out;
+				}
+				ctx->dot_dot_found = true;
+				if (sbi.root_nid == ctx->dir->nid) {
+					ctx->pnid = sbi.root_nid;
+					if (fsck && de->nid != ctx->pnid) {
+						errmsg = "corrupted `..' dirent";
+						goto out;
+					}
+				}
+				break;
+			case 1:
+				if (fsck && ctx->dot_found) {
+					errmsg = "duplicated `.' dirent";
+					goto out;
+				}
+
+				ctx->dot_found = true;
+				if (fsck && de->nid != ctx->dir->nid) {
+					errmsg = "corrupted `.' dirent";
+					goto out;
+				}
+				break;
+			}
+		}
+		struct erofs_dirent_info output_info = {
+			.ftype = de->file_type,
+			.nid = de->nid,
+			.arg = params->arg,
+			.dname = cur_name};
+
+		ret = params->cb(&output_info);
+		if (ret) {
+			silent = true;
+			goto out;
+		}
+		if (params->recursive && de->file_type == EROFS_FT_DIR && !dot_dotdot) {
+			const struct erofs_iterate_dir_param recursive_param = {
+				.nid = de->nid,
+				.fsck = params->fsck,
+				.pnid = params->nid,
+				.cb = params->cb,
+				.recursive = params->recursive,
+				.arg = params->arg};
+			erofs_iterate_dir(&recursive_param);
+		}
+
+		next_nameoff += de_namelen;
+		++de;
+
+		prev_name = cur_name;
+		cur_name = prev_name == ctx->prev_name ? ctx->cur_name : ctx->prev_name;
+	}
+	if (fsck && (!ctx->dot_found || !ctx->dot_dot_found)) {
+		erofs_err("`.' or `..' dirent is missing @ nid %llu", de->nid | 0ULL);
+		return -EFSCORRUPTED;
+	}
+out:
+	if (ret && !silent)
+		erofs_err("%s @ nid %llu, lblk %u, index %lu",
+			errmsg, ctx->dir->nid | 0ULL,
+			lblk, (de - (struct erofs_dirent *)dentry_blk) | 0UL);
+	return ret;
+}
+
+int erofs_iterate_dir(const struct erofs_iterate_dir_param *params)
+{
+	int err;
+	struct erofs_inode dir;
+
+	dir.nid = params->nid;
+	err = erofs_read_inode_from_disk(&dir);
+	if (err) {
+		return err;
+	}
+	if ((dir.i_mode & S_IFMT) != S_IFDIR) {
+		return -ENOTDIR;
+	}
+
+	struct erofs_dirent_info output_info;
+	/* Both |buf| and |ctx| can live on the stack, but that might cause
+	 * stack overflow when iterating recursively. So put them on heap.
+	 */
+	char *buf = calloc(EROFS_BLKSIZ, 1);
+
+	if (buf == NULL) {
+		goto out;
+	}
+	struct erofs_dir_context *ctx = calloc(sizeof(struct erofs_dir_context), 1);
+
+	if (ctx == NULL) {
+		goto out;
+	}
+	ctx->dir = &dir;
+	ctx->pnid = params->pnid;
+
+	erofs_off_t pos = 0;
+
+	while (pos < dir.i_size) {
+		const erofs_blk_t lblk = erofs_blknr(pos);
+		const erofs_off_t maxsize =
+			min_t(erofs_off_t, dir.i_size - pos, EROFS_BLKSIZ);
+		const struct erofs_dirent *de = (const void *)buf;
+
+		err = erofs_pread(&dir, buf, maxsize, pos);
+		if (err) {
+			erofs_err(
+			"I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
+			dir.nid | 0ULL, lblk, err);
+			break;
+		}
+
+		const unsigned int nameoff = le16_to_cpu(de->nameoff);
+
+		if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
+				nameoff, dir.nid | 0ULL, lblk);
+			err = -EFSCORRUPTED;
+			break;
+		}
+		err = traverse_dirents(
+			ctx, params, buf, lblk, nameoff, maxsize, params->fsck);
+		if (err) {
+			break;
+		}
+		pos += maxsize;
+	}
+out:
+	if (ctx) {
+		free(ctx);
+	}
+	if (buf) {
+		free(buf);
+	}
+	return err;
+}
-- 
2.34.1.173.g76aa8bc2d0-goog

