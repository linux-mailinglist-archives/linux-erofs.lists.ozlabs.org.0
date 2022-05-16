Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03A2528BED
	for <lists+linux-erofs@lfdr.de>; Mon, 16 May 2022 19:25:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L25jz3S80z3c7L
	for <lists+linux-erofs@lfdr.de>; Tue, 17 May 2022 03:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MEB5BskX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MEB5BskX; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L25jr4H8Cz3bwk
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 May 2022 03:25:20 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1723F60C52;
 Mon, 16 May 2022 17:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9663C34100;
 Mon, 16 May 2022 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652721916;
 bh=4lvLZylziYtKziLAbQGNbhsC3fibL9ReNfN/G7g3evo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MEB5BskX3ueBMHiC/zrAGna9R7XcX66TEl+DuGWTgnjAgHA54WVZgn5LAUvK8P7YH
 wS5V9E4WRQ2TgsxAPRmUAS18d65aTsCmebWgu6wUccqUnwHyexupxi9sNSOJY3qXBo
 wBk/tAERkR7JYeniFbk3Zcv7uozLDhRVZ9XLpMBsRlBdGcLrTsq5HyI2CmiEuTc86c
 3vcZqWBi/1Yv66+2gYwpdm8V93JCvFRaHE/pmdkPZSu85UsINSMNTTyoJ3zYPVpiX/
 Sj6whEgPly5RoE4K8xse1sd2tQ9Q0/TLPjSe1XNFAwpJ6WXZdt8KmB0FjSZZBZnTnf
 PWK4XVVNE6Whg==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: show per-file progress
Date: Tue, 17 May 2022 01:24:35 +0800
Message-Id: <20220516172435.167023-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516071033.96151-1-hsiangkao@linux.alibaba.com>
References: <20220516071033.96151-1-hsiangkao@linux.alibaba.com>
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

Generally, users want to know the latest progress since it may take
long time to build a image. Let's add a per-file progress as a start.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v1:
 - trim over long paths according to TIOCGWINSZ reporting.

 configure.ac           |  2 ++
 include/erofs/config.h |  4 +++
 include/erofs/print.h  | 26 +++++++++--------
 lib/config.c           | 64 ++++++++++++++++++++++++++++++++++++++++++
 lib/inode.c            |  6 +++-
 mkfs/main.c            |  7 ++++-
 6 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 53bf882..a736ff0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,6 +140,8 @@ AC_CHECK_HEADERS(m4_flatten([
 	unistd.h
 ]))
 
+AC_HEADER_TIOCGWINSZ
+
 # Checks for typedefs, structures, and compiler characteristics.
 AC_C_INLINE
 AC_TYPE_INT64_T
diff --git a/include/erofs/config.h b/include/erofs/config.h
index 1e985b0..0d0916c 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -45,6 +45,7 @@ struct erofs_configure {
 	bool c_noinline_data;
 	bool c_ztailpacking;
 	bool c_ignore_mtime;
+	bool c_showprogress;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
@@ -92,6 +93,9 @@ static inline int erofs_selabel_open(const char *file_contexts)
 }
 #endif
 
+void erofs_update_progressinfo(const char *fmt, ...);
+char *erofs_trim_for_progressinfo(const char *str, int placeholder);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/erofs/print.h b/include/erofs/print.h
index f188a6b..a896d75 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -41,37 +41,39 @@ enum {
 #define PR_FMT_FUNC_LINE(fmt)	pr_fmt(fmt), __func__, __LINE__
 #endif
 
+void erofs_msg(int dbglv, const char *fmt, ...);
+
 #define erofs_dbg(fmt, ...) do {			\
 	if (cfg.c_dbg_lvl >= EROFS_DBG) {		\
-		fprintf(stdout,				\
-			"<D> " PR_FMT_FUNC_LINE(fmt),	\
-			##__VA_ARGS__);			\
+		erofs_msg(EROFS_DBG,			\
+			  "<D> " PR_FMT_FUNC_LINE(fmt),	\
+			  ##__VA_ARGS__);		\
 	}						\
 } while (0)
 
 #define erofs_info(fmt, ...) do {			\
 	if (cfg.c_dbg_lvl >= EROFS_INFO) {		\
-		fprintf(stdout,				\
-			"<I> " PR_FMT_FUNC_LINE(fmt),	\
-			##__VA_ARGS__);			\
+		erofs_msg(EROFS_INFO,			\
+			  "<I> " PR_FMT_FUNC_LINE(fmt),	\
+			  ##__VA_ARGS__);		\
 		fflush(stdout);				\
 	}						\
 } while (0)
 
 #define erofs_warn(fmt, ...) do {			\
 	if (cfg.c_dbg_lvl >= EROFS_WARN) {		\
-		fprintf(stdout,				\
-			"<W> " PR_FMT_FUNC_LINE(fmt),	\
-			##__VA_ARGS__);			\
+		erofs_msg(EROFS_WARN,			\
+			  "<W> " PR_FMT_FUNC_LINE(fmt),	\
+			  ##__VA_ARGS__);		\
 		fflush(stdout);				\
 	}						\
 } while (0)
 
 #define erofs_err(fmt, ...) do {			\
 	if (cfg.c_dbg_lvl >= EROFS_ERR) {		\
-		fprintf(stderr,				\
-			"<E> " PR_FMT_FUNC_LINE(fmt),	\
-			##__VA_ARGS__);			\
+		erofs_msg(EROFS_ERR,			\
+			  "<E> " PR_FMT_FUNC_LINE(fmt),	\
+			  ##__VA_ARGS__);		\
 	}						\
 } while (0)
 
diff --git a/lib/config.c b/lib/config.c
index 24db751..c8f9d92 100644
--- a/lib/config.c
+++ b/lib/config.c
@@ -6,9 +6,13 @@
  */
 #include <string.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include "erofs/print.h"
 #include "erofs/internal.h"
 #include "liberofs_private.h"
+#ifdef HAVE_SYS_IOCTL_H
+#include <sys/ioctl.h>
+#endif
 
 struct erofs_configure cfg;
 struct erofs_sb_info sbi;
@@ -91,3 +95,63 @@ int erofs_selabel_open(const char *file_contexts)
 	return 0;
 }
 #endif
+
+static bool __erofs_is_progressmsg;
+
+char *erofs_trim_for_progressinfo(const char *str, int placeholder)
+{
+	struct winsize winsize;
+	int col, len;
+
+#ifdef GWINSZ_IN_SYS_IOCTL
+	if(ioctl(1, TIOCGWINSZ, &winsize) >= 0 &&
+	   winsize.ws_col > 0)
+		col = winsize.ws_col;
+	else
+#endif
+		col = 80;
+
+	len = strlen(str);
+	/* omit over long prefixes */
+	if (len > col - placeholder) {
+		char *s = strdup(str + len - (col - placeholder));
+
+		if (col > placeholder + 2) {
+			s[0] = '[';
+			s[1] = ']';
+		}
+		return s;
+	}
+	return strdup(str);
+}
+
+void erofs_msg(int dbglv, const char *fmt, ...)
+{
+	va_list ap;
+	FILE *f = dbglv >= EROFS_ERR ? stderr : stdout;
+
+	if (__erofs_is_progressmsg) {
+		fputc('\n', f);
+		__erofs_is_progressmsg = false;
+	}
+	va_start(ap, fmt);
+	vfprintf(f, fmt, ap);
+	va_end(ap);
+}
+
+void erofs_update_progressinfo(const char *fmt, ...)
+{
+	char msg[8192];
+	va_list ap;
+
+	if (cfg.c_dbg_lvl >= EROFS_INFO || !cfg.c_showprogress)
+		return;
+
+	va_start(ap, fmt);
+	vsprintf(msg, fmt, ap);
+	va_end(ap);
+
+	printf("\r\033[K%s", msg);
+	__erofs_is_progressmsg = true;
+	fflush(stdout);
+}
diff --git a/lib/inode.c b/lib/inode.c
index 6c6e42e..f192510 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1083,7 +1083,7 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		erofs_fixup_meta_blkaddr(dir);
 
 	list_for_each_entry(d, &dir->i_subdirs, d_child) {
-		char buf[PATH_MAX];
+		char buf[PATH_MAX], *trimmed;
 		unsigned char ftype;
 
 		if (is_dot_dotdot(d->name)) {
@@ -1098,6 +1098,10 @@ static struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 			goto fail;
 		}
 
+		trimmed = erofs_trim_for_progressinfo(erofs_fspath(buf),
+					sizeof("Processing  ...") - 1);
+		erofs_update_progressinfo("Processing %s ...", trimmed);
+		free(trimmed);
 		d->inode = erofs_mkfs_build_tree_from_path(dir, buf);
 		if (IS_ERR(d->inode)) {
 			ret = PTR_ERR(d->inode);
diff --git a/mkfs/main.c b/mkfs/main.c
index 25b72ad..9d43cd4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -423,8 +423,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		erofs_err("unexpected argument: %s\n", argv[optind]);
 		return -EINVAL;
 	}
-	if (quiet)
+	if (quiet) {
 		cfg.c_dbg_lvl = EROFS_ERR;
+		cfg.c_showprogress = false;
+	}
 	return 0;
 }
 
@@ -520,6 +522,7 @@ static int erofs_mkfs_superblock_csum_set(void)
 
 static void erofs_mkfs_default_options(void)
 {
+	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
@@ -738,6 +741,8 @@ exit:
 		erofs_err("\tCould not format the device : %s\n",
 			  erofs_strerror(err));
 		return 1;
+	} else {
+		erofs_update_progressinfo("Build completed.\n");
 	}
 	return 0;
 }
-- 
2.30.2

