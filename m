Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C3477690
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 17:03:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JFH3J0cbDz307B
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Dec 2021 03:03:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WjFVpwd/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WjFVpwd/; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JFH372K71z305j
 for <linux-erofs@lists.ozlabs.org>; Fri, 17 Dec 2021 03:03:31 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9B34EB824AF
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 16:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893ABC36AE4;
 Thu, 16 Dec 2021 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639670605;
 bh=McP5puVXH9VtftigaZUnQoSTor8Rae3TgJZY50UTSfw=;
 h=From:To:Cc:Subject:Date:From;
 b=WjFVpwd/+kNnR/9yM8wDqVbwZflS/NOk7zJcx4stnUzX3YBMA9LkUcKt99odpX8jz
 D4k9skJMwT09UE1xxfRYaGbUKUo+5wGIYyb/f2NoN/TJRrn2wUd70z15SLX/qkgjNI
 Bqp0i0Qtv5nNaFIbrCEIQKrLnzA1Lhw1zroiVvoMT9FnHecH34mdJp6TakdkbJ17MM
 +azA++2oRW9q4Q0uxD3TrRdqj8+AfjRhOCCny7y5qYRHR0OJD+pw6h7Rlo6A7NGXKW
 XXPjfvqVpxDu5FiFw8HRzynVrFI1z/IoMAqWpIEII7okK96mjjH5plNU33gDxL3fs7
 qBd1n+4uYJtMg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: convert readdir to use erofs_iterate_dir()
Date: Fri, 17 Dec 2021 00:02:54 +0800
Message-Id: <20211216160254.28166-1-xiang@kernel.org>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

No need to open code after erofs_iterate_dir() is finalized in
liberofs.

Note that `erofs_get_pathname' isn't touched in this commit.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 configure.ac           |   5 ++
 dump/main.c            | 182 +++++++++++++++++------------------------
 lib/liberofs_private.h |  12 +++
 3 files changed, 93 insertions(+), 106 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6fdb0e4ce63c..a5de291c69d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -167,6 +167,11 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
    #define _LARGEFILE64_SOURCE
    #include <unistd.h>])
 
+AC_CHECK_DECL(memrchr,[AC_DEFINE(HAVE_MEMRCHR, 1,
+  [Define to 1 if memrchr declared in string.h])],,
+  [#define _GNU_SOURCE
+   #include <string.h>])
+
 # Checks for library functions.
 AC_CHECK_FUNCS(m4_flatten([
 	backtrace
diff --git a/dump/main.c b/dump/main.c
index 072d726da71b..7f3f74368332 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -5,12 +5,16 @@
  * Created by Wang Qi <mpiglet@outlook.com>
  *            Guo Xuenan <guoxuenan@huawei.com>
  */
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <getopt.h>
 #include <time.h>
+#include <sys/stat.h>
 #include "erofs/print.h"
 #include "erofs/inode.h"
 #include "erofs/io.h"
+#include "erofs/dir.h"
+#include "../lib/liberofs_private.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid.h>
@@ -90,10 +94,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 };
 
-static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid);
-static inline int erofs_checkdirent(struct erofs_dirent *de,
-		struct erofs_dirent *last_de,
-		u32 maxsize, const char *dname);
+static int erofsdump_readdir(struct erofs_dir_context *ctx);
 
 static void usage(void)
 {
@@ -198,18 +199,20 @@ static int erofs_get_occupied_size(struct erofs_inode *inode,
 	return 0;
 }
 
-static int erofs_getfile_extension(const char *filename)
+static void inc_file_extension_count(const char *dname, unsigned int len)
 {
-	char *postfix = strrchr(filename, '.');
-	int type = 0;
+	char *postfix = memrchr(dname, '.', len);
+	int type;
 
-	if (!postfix)
-		return OTHERFILETYPE - 1;
-	for (type = 0; type < OTHERFILETYPE - 1; ++type) {
-		if (strcmp(postfix, file_types[type]) == 0)
-			break;
+	if (!postfix) {
+		type = OTHERFILETYPE - 1;
+	} else {
+		for (type = 0; type < OTHERFILETYPE - 1; ++type)
+			if (!strncmp(postfix, file_types[type],
+				     len - (postfix - dname)))
+				break;
 	}
-	return type;
+	++stats.file_type_stat[type];
 }
 
 static void update_file_size_statatics(erofs_off_t occupied_size,
@@ -244,6 +247,56 @@ static void update_file_size_statatics(erofs_off_t occupied_size,
 		stats.file_comp_size[occupied_size_mark]++;
 }
 
+static int erofsdump_dirent_iter(struct erofs_dir_context *ctx)
+{
+	/* skip "." and ".." dentry */
+	if (ctx->dot_dotdot)
+		return 0;
+
+	return erofsdump_readdir(ctx);
+}
+
+static int erofsdump_readdir(struct erofs_dir_context *ctx)
+{
+	int err;
+	erofs_off_t occupied_size = 0;
+	struct erofs_inode vi = { .nid = ctx->de_nid };
+
+	err = erofs_read_inode_from_disk(&vi);
+	if (err) {
+		erofs_err("failed to read file inode from disk");
+		return err;
+	}
+	stats.files++;
+	stats.file_category_stat[erofs_mode_to_ftype(vi.i_mode)]++;
+
+	err = erofs_get_occupied_size(&vi, &occupied_size);
+	if (err) {
+		erofs_err("get file size failed");
+		return err;
+	}
+
+	if (S_ISREG(vi.i_mode)) {
+		stats.files_total_origin_size += vi.i_size;
+		inc_file_extension_count(ctx->dname, ctx->de_namelen);
+		stats.files_total_size += occupied_size;
+		update_file_size_statatics(occupied_size, vi.i_size);
+	}
+
+	/* XXXX: the dir depth should be restricted in order to avoid loops */
+	if (S_ISDIR(vi.i_mode)) {
+		struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+			.cb = erofsdump_dirent_iter,
+		};
+
+		return erofs_iterate_dir(&nctx, false);
+	}
+	return 0;
+}
+
 static inline int erofs_checkdirent(struct erofs_dirent *de,
 		struct erofs_dirent *last_de,
 		u32 maxsize, const char *dname)
@@ -275,97 +328,6 @@ static inline int erofs_checkdirent(struct erofs_dirent *de,
 	return dname_len;
 }
 
-static int erofs_read_dirent(struct erofs_dirent *de,
-		erofs_nid_t nid, erofs_nid_t parent_nid,
-		const char *dname)
-{
-	int err;
-	erofs_off_t occupied_size = 0;
-	struct erofs_inode inode = { .nid = le64_to_cpu(de->nid) };
-
-	stats.files++;
-	stats.file_category_stat[de->file_type]++;
-	err = erofs_read_inode_from_disk(&inode);
-	if (err) {
-		erofs_err("read file inode from disk failed!");
-		return err;
-	}
-
-	err = erofs_get_occupied_size(&inode, &occupied_size);
-	if (err) {
-		erofs_err("get file size failed\n");
-		return err;
-	}
-
-	if (de->file_type == EROFS_FT_REG_FILE) {
-		stats.files_total_origin_size += inode.i_size;
-		stats.file_type_stat[erofs_getfile_extension(dname)]++;
-		stats.files_total_size += occupied_size;
-		update_file_size_statatics(occupied_size, inode.i_size);
-	}
-
-	if (de->file_type == EROFS_FT_DIR && inode.nid != nid &&
-	    inode.nid != parent_nid) {
-		err = erofs_read_dir(inode.nid, nid);
-		if (err) {
-			erofs_err("parse dir nid %llu error occurred\n",
-				  inode.nid | 0ULL);
-			return err;
-		}
-	}
-	return 0;
-}
-
-static int erofs_read_dir(erofs_nid_t nid, erofs_nid_t parent_nid)
-{
-	int err;
-	erofs_off_t offset;
-	char buf[EROFS_BLKSIZ];
-	struct erofs_inode vi = { .nid = nid };
-
-	err = erofs_read_inode_from_disk(&vi);
-	if (err)
-		return err;
-
-	offset = 0;
-	while (offset < vi.i_size) {
-		erofs_off_t maxsize = min_t(erofs_off_t,
-						vi.i_size - offset, EROFS_BLKSIZ);
-		struct erofs_dirent *de = (void *)buf;
-		struct erofs_dirent *end;
-		unsigned int nameoff;
-
-		err = erofs_pread(&vi, buf, maxsize, offset);
-		if (err)
-			return err;
-
-		nameoff = le16_to_cpu(de->nameoff);
-		end = (void *)buf + nameoff;
-		while (de < end) {
-			const char *dname;
-			int ret;
-
-			/* skip "." and ".." dentry */
-			if (le64_to_cpu(de->nid) == nid ||
-			    le64_to_cpu(de->nid) == parent_nid) {
-				de++;
-				continue;
-			}
-
-			dname = (char *)buf + nameoff;
-			ret = erofs_checkdirent(de, end, maxsize, dname);
-			if (ret < 0)
-				return ret;
-			ret = erofs_read_dirent(de, nid, parent_nid, dname);
-			if (ret < 0)
-				return ret;
-			++de;
-		}
-		offset += maxsize;
-	}
-	return 0;
-}
-
 static int erofs_get_pathname(erofs_nid_t nid, erofs_nid_t parent_nid,
 		erofs_nid_t target, char *path, unsigned int pos)
 {
@@ -629,13 +591,21 @@ static void erofsdump_file_statistic(void)
 static void erofsdump_print_statistic(void)
 {
 	int err;
+	struct erofs_dir_context ctx = {
+		.flags = 0,
+		.pnid = 0,
+		.dir = NULL,
+		.cb = erofsdump_dirent_iter,
+		.de_nid = sbi.root_nid,
+		.dname = "",
+		.de_namelen = 0
+	};
 
-	err = erofs_read_dir(sbi.root_nid, sbi.root_nid);
+	err = erofsdump_readdir(&ctx);
 	if (err) {
 		erofs_err("read dir failed");
 		return;
 	}
-
 	erofsdump_file_statistic();
 	erofsdump_filesize_distribution("Original",
 			stats.file_original_size,
diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
index c2312e8e7a31..0eeca3c1d601 100644
--- a/lib/liberofs_private.h
+++ b/lib/liberofs_private.h
@@ -11,3 +11,15 @@
 #include <private/canned_fs_config.h>
 #include <private/fs_config.h>
 #endif
+
+#ifndef HAVE_MEMRCHR
+static inline void *memrchr(const void *s, int c, size_t n)
+{
+	const unsigned char *p = (const unsigned char *)s;
+
+	for (p += n; n > 0; n--)
+		if (*--p == c)
+			return (void*)p;
+	return NULL;
+}
+#endif
-- 
2.20.1

