Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147F678514A
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 09:16:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVyDc6gCjz3c4Z
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:16:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVyD21vm9z3byh
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 17:15:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqPT4TT_1692774924;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqPT4TT_1692774924)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 15:15:25 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 07/10] erofs-utils: lib: add erofs_rebuild_get_dentry() helper
Date: Wed, 23 Aug 2023 15:15:14 +0800
Message-Id: <20230823071517.12303-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
References: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Rename tarerofs_get_dentry() to erofs_rebuild_get_dentry().

Also make `whout` and 'opq' parameter optional when `aufs` is false.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/rebuild.h |  19 +++++++
 lib/Makefile.am         |   3 +-
 lib/rebuild.c           | 117 ++++++++++++++++++++++++++++++++++++++++
 lib/tar.c               | 109 ++-----------------------------------
 4 files changed, 141 insertions(+), 107 deletions(-)
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
index 7a5dc03..4bcc09b 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -24,6 +24,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
       $(top_srcdir)/include/erofs/xattr.h \
       $(top_srcdir)/include/erofs/compress_hints.h \
       $(top_srcdir)/include/erofs/fragments.h \
+      $(top_srcdir)/include/erofs/rebuild.h \
       $(top_srcdir)/lib/liberofs_private.h
 
 noinst_HEADERS += compressor.h
@@ -31,7 +32,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
 		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
 		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
 		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
-		      block_list.c
+		      block_list.c rebuild.c
 
 liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
 if ENABLE_LZ4
diff --git a/lib/rebuild.c b/lib/rebuild.c
new file mode 100644
index 0000000..7aaa071
--- /dev/null
+++ b/lib/rebuild.c
@@ -0,0 +1,117 @@
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
+	if (aufs) {
+		*whout = false;
+		*opq = false;
+	}
+
+	while (s < path + len) {
+		char *slash = memchr(s, '/', path + len - s);
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
index ce54d17..cf3497f 100644
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
 
 #define EROFS_WHITEOUT_DEV	0
 
@@ -133,103 +127,6 @@ static long long tarerofs_parsenum(const char *ptr, int len)
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
 int tarerofs_parse_pax_header(int fd, struct erofs_pax_header *eh, u32 size)
 {
 	char *buf, *p;
@@ -612,7 +509,7 @@ restart:
 
 	erofs_dbg("parsing %s (mode %05o)", eh.path, st.st_mode);
 
-	d = tarerofs_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
+	d = erofs_rebuild_get_dentry(root, eh.path, tar->aufs, &whout, &opq);
 	if (IS_ERR(d)) {
 		ret = PTR_ERR(d);
 		goto out;
@@ -645,7 +542,7 @@ restart:
 		}
 		d->inode = NULL;
 
-		d2 = tarerofs_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
+		d2 = erofs_rebuild_get_dentry(root, eh.link, tar->aufs, &dumb, &dumb);
 		if (IS_ERR(d2)) {
 			ret = PTR_ERR(d2);
 			goto out;
-- 
2.19.1.6.gb485710b

