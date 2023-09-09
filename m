Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB9F799A02
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdp51RrSz3cNk
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rjdnk0ZXZz3cLx
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:33:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqVn_1694277186;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqVn_1694277186)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:33:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 10/13] erofs-utils: lib: add erofs_rebuild_get_dentry() helper
Date: Sun, 10 Sep 2023 00:32:37 +0800
Message-Id: <20230909163240.42057-11-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Rename tarerofs_get_dentry() to erofs_rebuild_get_dentry() and
move it into lib/rebuild.c.

No logic changes.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/rebuild.h |  19 +++++++
 lib/Makefile.am         |   3 +-
 lib/rebuild.c           | 116 ++++++++++++++++++++++++++++++++++++++++
 lib/tar.c               | 109 ++-----------------------------------
 4 files changed, 140 insertions(+), 107 deletions(-)
 create mode 100644 include/erofs/rebuild.h
 create mode 100644 lib/rebuild.c

diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
new file mode 100644
index 0000000..92873c9
--- /dev/null
+++ b/include/erofs/rebuild.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+#ifndef __EROFS_REBUILD_H
+#define __EROFS_REBUILD_H
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#include "internal.h"
+
+struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
+		char *path, bool aufs, bool *whout, bool *opq);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 3e09516..8a45bd6 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -25,6 +25,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
       $(top_srcdir)/include/erofs/xxhash.h \
+      $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/lib/liberofs_private.h
 
 noinst_HEADERS += compressor.h
@@ -32,7 +33,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c xxhash.c
+		      block_list.c xxhash.c rebuild.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/rebuild.c b/lib/rebuild.c
new file mode 100644
index 0000000..2398ca6
--- /dev/null
+++ b/lib/rebuild.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include "erofs/print.h"
+#include "erofs/inode.h"
+#include "erofs/rebuild.h"
+#include "erofs/internal.h"
+
+#ifdef HAVE_LINUX_AUFS_TYPE_H
+#include <linux/aufs_type.h>
+#else
+#define AUFS_WH_PFX		".wh."
+#define AUFS_DIROPQ_NAME	AUFS_WH_PFX ".opq"
+#define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
+#endif
+
+static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
+						const char *s)
+{
+	struct erofs_inode *inode;
+	struct erofs_dentry *d;
+
+	inode = erofs_new_inode();
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	inode->i_mode = S_IFDIR | 0755;
+	inode->i_parent = dir;
+	inode->i_uid = getuid();
+	inode->i_gid = getgid();
+	inode->i_mtime = inode->sbi->build_time;
+	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
+	erofs_init_empty_dir(inode);
+
+	d = erofs_d_alloc(dir, s);
+	if (!IS_ERR(d)) {
+		d->type = EROFS_FT_DIR;
+		d->inode = inode;
+	}
+	return d;
+}
+
+struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
+		char *path, bool aufs, bool *whout, bool *opq)
+{
+	struct erofs_dentry *d = NULL;
+	unsigned int len = strlen(path);
+	char *s = path;
+
+	*whout = false;
+	*opq = false;
+
+	while (s < path + len) {
+		char *slash = memchr(s, '/', path + len - s);
+
+		if (slash) {
+			if (s == slash) {
+				while (*++s == '/');	/* skip '//...' */
+				continue;
+			}
+			*slash = '\0';
+		}
+
+		if (!memcmp(s, ".", 2)) {
+			/* null */
+		} else if (!memcmp(s, "..", 3)) {
+			pwd = pwd->i_parent;
+		} else {
+			struct erofs_inode *inode = NULL;
+
+			if (aufs && !slash) {
+				if (!memcmp(s, AUFS_WH_DIROPQ, sizeof(AUFS_WH_DIROPQ))) {
+					*opq = true;
+					break;
+				}
+				if (!memcmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
+					s += sizeof(AUFS_WH_PFX) - 1;
+					*whout = true;
+				}
+			}
+
+			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
+				if (!strcmp(d->name, s)) {
+					if (d->type != EROFS_FT_DIR && slash)
+						return ERR_PTR(-EIO);
+					inode = d->inode;
+					break;
+				}
+			}
+
+			if (inode) {
+				pwd = inode;
+			} else if (!slash) {
+				d = erofs_d_alloc(pwd, s);
+				if (IS_ERR(d))
+					return d;
+				d->type = EROFS_FT_UNKNOWN;
+				d->inode = pwd;
+			} else {
+				d = erofs_rebuild_mkdir(pwd, s);
+				if (IS_ERR(d))
+					return d;
+				pwd = d->inode;
+			}
+		}
+		if (slash) {
+			*slash = '/';
+			s = slash + 1;
+		} else {
+			break;
+		}
+	}
+	return d;
+}
diff --git a/lib/tar.c b/lib/tar.c
index b58bfd5..0b96cae 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -3,13 +3,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/stat.h>
-#ifdef HAVE_LINUX_AUFS_TYPE_H
-#include <linux/aufs_type.h>
-#else
-#define AUFS_WH_PFX		".wh."
-#define AUFS_DIROPQ_NAME	AUFS_WH_PFX ".opq"
-#define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
-#endif
 #include "erofs/print.h"
 #include "erofs/cache.h"
 #include "erofs/inode.h"
@@ -18,6 +11,7 @@
 #include "erofs/io.h"
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
+#include "erofs/rebuild.h"
 
 static char erofs_libbuf[16384];
 
@@ -131,103 +125,6 @@ static long long tarerofs_parsenum(const char *ptr, int len)
 	return tarerofs_otoi(ptr, len);
 }
 
-static struct erofs_dentry *tarerofs_mkdir(struct erofs_inode *dir, const char *s)
-{
-	struct erofs_inode *inode;
-	struct erofs_dentry *d;
-
-	inode = erofs_new_inode();
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
-
-	inode->i_mode = S_IFDIR | 0755;
-	inode->i_parent = dir;
-	inode->i_uid = getuid();
-	inode->i_gid = getgid();
-	inode->i_mtime = inode->sbi->build_time;
-	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
-	erofs_init_empty_dir(inode);
-
-	d = erofs_d_alloc(dir, s);
-	if (!IS_ERR(d)) {
-		d->type = EROFS_FT_DIR;
-		d->inode = inode;
-	}
-	return d;
-}
-
-static struct erofs_dentry *tarerofs_get_dentry(struct erofs_inode *pwd, char *path,
-					        bool aufs, bool *whout, bool *opq)
-{
-	struct erofs_dentry *d = NULL;
-	unsigned int len = strlen(path);
-	char *s = path;
-
-	*whout = false;
-	*opq = false;
-
-	while (s < path + len) {
-		char *slash = memchr(s, '/', path + len - s);
-		if (slash) {
-			if (s == slash) {
-				while (*++s == '/');	/* skip '//...' */
-				continue;
-			}
-			*slash = '\0';
-		}
-
-		if (!memcmp(s, ".", 2)) {
-			/* null */
-		} else if (!memcmp(s, "..", 3)) {
-			pwd = pwd->i_parent;
-		} else {
-			struct erofs_inode *inode = NULL;
-
-			if (aufs && !slash) {
-				if (!memcmp(s, AUFS_WH_DIROPQ, sizeof(AUFS_WH_DIROPQ))) {
-					*opq = true;
-					break;
-				}
-				if (!memcmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
-					s += sizeof(AUFS_WH_PFX) - 1;
-					*whout = true;
-				}
-			}
-
-			list_for_each_entry(d, &pwd->i_subdirs, d_child) {
-				if (!strcmp(d->name, s)) {
-					if (d->type != EROFS_FT_DIR && slash)
-						return ERR_PTR(-EIO);
-					inode = d->inode;
-					break;
-				}
-			}
-
-			if (inode) {
-				pwd = inode;
-			} else if (!slash) {
-				d = erofs_d_alloc(pwd, s);
-				if (IS_ERR(d))
-					return d;
-				d->type = EROFS_FT_UNKNOWN;
-				d->inode = pwd;
-			} else {
-				d = tarerofs_mkdir(pwd, s);
-				if (IS_ERR(d))
-					return d;
-				pwd = d->inode;
-			}
-		}
-		if (slash) {
-			*slash = '/';
-			s = slash + 1;
-		} else {
-			break;
-		}
-	}
-	return d;
-}
-
 struct tarerofs_xattr_item {
 	struct list_head list;
 	char *kv;
@@ -765,7 +662,7 @@ restart:
 
 	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
 
-	d = tarerofs_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
+	d = erofs_rebuild_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -798,7 +695,7 @@ restart:
 		}
 		d->inode = NULL;
 
-		d2 = tarerofs_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
+		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
 			goto out;
-- 
2.24.4

