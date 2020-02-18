Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA816283B
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Feb 2020 15:33:27 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MNd043P3zDqnR
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 01:33:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582036404;
	bh=9uuKUxFIUYPBtEVfqyt/xADkTl1XvwwJLlqu3rW+lYQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=OgCmpCCXzYZUFcVbpM6OJ3c2NUr5LNd3Q8s7ZqgshvYu53b26zjMJgdGCVD0/NJaf
	 3v3NPBUkUVwfUr7JiTO/mDWXCZV4zLpRjLljz1kZc67/cU0gSXfztxIe5d++kccAIf
	 rXofVIpW7g3gS0gGNH3UQ2cizan1pHoy4v7szxppKy/Hq7sRq7g+dzyGT5qvmtjp6Y
	 1WGIFnjhhoPlsWgtOch29egaC3Z+DUX8cQQLpXqlr8oj3/f39Ku5n2lQimZDkBYoZK
	 vI3jY4OSVSfG6CREFO4oI8doMj0EBmKap76qLmS4psWobs1wWx6p5WhGNfxnDFvbNX
	 evyK2k21aU2lQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.15;
 helo=out30-15.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=N9LCDrcp; dkim-atps=neutral
Received: from out30-15.freemail.mail.aliyun.com
 (out30-15.freemail.mail.aliyun.com [115.124.30.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MNZZ0ShjzDqnn
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 01:31:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1582036260; h=From:To:Subject:Date:Message-Id;
 bh=mgOZxqRi9gZRoR8UwFWumhhLh9tJ+oIs6aahG0m71nM=;
 b=N9LCDrcpEDvP75HOycsVzD7qmjlbY59xa7kvaLOw/ctbcUsnfmno+/i4BO1MEKJ1ZtJjH0loy+EiGa40T5c6GXnQbO5iu4G9MIMFdgkC2GRenY2aOz1VZ53ETzNnWNb2Dgu4q0syzYunfHtNPx70d6gt1P9oKsrZlBqwyS+ECag=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06357798|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.171228-0.00788569-0.820886;
 DS=CONTINUE|ham_alarm|0.00136224-0.000111372-0.998526; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04426; MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---0TqIKd.9_1582036250; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0TqIKd.9_1582036250) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 18 Feb 2020 22:30:50 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7] erofs-utils: introduce exclude dirs and files
Date: Tue, 18 Feb 2020 22:30:47 +0800
Message-Id: <20200218143047.58488-1-bluce.lee@aliyun.com>
X-Mailer: git-send-email 2.17.1
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
From: Li Guifu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Li Guifu <bluce.lee@aliyun.com>
Cc: Li GuiFu <bluce.lee@aliyun.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li GuiFu <bluce.lee@aliyun.com>

Add excluded file feature "--exclude-path=" and '--exclude-regex=',
which can be used to build EROFS image without some user specific
files or dirs. Note that you may give multiple '--exclude-path'
or '--exclude-regex' options.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
---
 change since v7:
  - fux as comment by Gao Xiang
  - fix missing regex free
  - update comment of option

 include/erofs/exclude.h |  26 ++++++++
 lib/Makefile.am         |   2 +-
 lib/exclude.c           | 141 ++++++++++++++++++++++++++++++++++++++++
 lib/inode.c             |   5 ++
 man/mkfs.erofs.1        |   8 +++
 mkfs/main.c             |  36 ++++++++--
 6 files changed, 211 insertions(+), 7 deletions(-)
 create mode 100644 include/erofs/exclude.h
 create mode 100644 lib/exclude.c

diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
new file mode 100644
index 0000000..0a82dbe
--- /dev/null
+++ b/include/erofs/exclude.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/exclude.h
+ *
+ * Created by Li Guifu <bluce.lee@aliyun.com>
+ */
+#ifndef __EROFS_EXCLUDE_H
+#define __EROFS_EXCLUDE_H
+#include <sys/types.h>
+#include <regex.h>
+
+struct erofs_exclude_rule {
+	struct list_head list;
+
+	char *pattern;		/* save original pattern for exact or regex match */
+	regex_t reg;
+};
+
+void erofs_exclude_set_root(const char *rootdir);
+void erofs_cleanup_exclude_rules(void);
+
+int erofs_parse_exclude_path(const char *args, bool is_regex);
+struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
+						 const char *name);
+#endif
+
diff --git a/lib/Makefile.am b/lib/Makefile.am
index 1ff81f9..e4b51e6 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -3,7 +3,7 @@
 
 noinst_LTLIBRARIES = liberofs.la
 liberofs_la_SOURCES = config.c io.c cache.c inode.c xattr.c \
-		      compress.c compressor.c
+		      compress.c compressor.c exclude.c
 liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
 if ENABLE_LZ4
 liberofs_la_CFLAGS += ${LZ4_CFLAGS}
diff --git a/lib/exclude.c b/lib/exclude.c
new file mode 100644
index 0000000..636f048
--- /dev/null
+++ b/lib/exclude.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/exclude.c
+ *
+ * Created by Li Guifu <bluce.lee@aliyun.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/exclude.h"
+
+#define EXCLUDE_RULE_EXACT_SIZE	offsetof(struct erofs_exclude_rule, reg)
+#define EXCLUDE_RULE_REGEX_SIZE	sizeof(struct erofs_exclude_rule)
+
+static LIST_HEAD(exclude_head);
+static LIST_HEAD(regex_exclude_head);
+
+static unsigned int rpathlen;		/* root directory prefix length */
+
+void erofs_exclude_set_root(const char *rootdir)
+{
+	rpathlen = strlen(rootdir);
+}
+
+static void dump_regerror(int errcode, const char *s, const regex_t *preg)
+{
+	char str[1024]; /* overflow safe */
+
+	regerror(errcode, preg, str, sizeof(str));
+	erofs_err("invalid regex %s,because %s\n", s, str);
+}
+
+static struct erofs_exclude_rule *erofs_insert_exclude(const char *s,
+						       bool is_regex)
+{
+	int ret = -ENOMEM;
+	struct erofs_exclude_rule *r;
+	struct list_head *h;
+	unsigned int size;
+
+	size = is_regex ? EXCLUDE_RULE_REGEX_SIZE : EXCLUDE_RULE_EXACT_SIZE;
+	r = malloc(size);
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	r->pattern = strdup(s);
+	if (!r->pattern)
+		goto err_rule;
+
+	if (is_regex) {
+		ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+		if(ret) {
+			dump_regerror(ret, s, &r->reg);
+			goto err_rule;
+		}
+		h = &regex_exclude_head;
+	} else {
+		h = &exclude_head;
+	}
+
+	list_add_tail(&r->list, h);
+	erofs_info("Insert exclude:[%s]\n", s);
+	return r;
+
+err_rule:
+	free(r);
+	return ERR_PTR(ret);
+}
+
+void erofs_cleanup_exclude_rules(void)
+{
+	struct erofs_exclude_rule *r, *n;
+	struct list_head *h;
+
+	h = &exclude_head;
+	list_for_each_entry_safe(r, n, h, list) {
+		list_del(&r->list);
+		free(r->pattern);
+		free(r);
+	}
+
+	h = &regex_exclude_head;
+	list_for_each_entry_safe(r, n, h, list) {
+		list_del(&r->list);
+		free(r->pattern);
+		regfree(&r->reg);
+		free(r);
+	}
+
+}
+
+int erofs_parse_exclude_path(const char *args, bool is_regex)
+{
+	struct erofs_exclude_rule *r = erofs_insert_exclude(args, is_regex);
+
+	if (IS_ERR(r)) {
+		erofs_cleanup_exclude_rules();
+		return PTR_ERR(r);
+	}
+	return 0;
+}
+
+struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
+						 const char *name)
+{
+	char buf[PATH_MAX];
+	const char *s;
+	struct erofs_exclude_rule *r;
+
+	if (!dir) {
+		/* no prefix */
+		s = name;
+	} else {
+		sprintf(buf, "%s/%s", dir, name);
+		s = buf;
+	}
+
+	s += rpathlen;
+	while (*s == '/')
+		s++;
+
+	list_for_each_entry(r, &exclude_head, list) {
+		if (!strcmp(r->pattern, s))
+			return r;
+	}
+
+	list_for_each_entry(r, &regex_exclude_head, list) {
+		int ret = regexec(&r->reg, s, (size_t)0, NULL, 0);
+
+		if(!ret)
+			return r;
+		else if (ret != REG_NOMATCH)
+			dump_regerror(ret, s, &r->reg);
+
+	}
+
+	return NULL;
+}
+
diff --git a/lib/inode.c b/lib/inode.c
index bd0652b..7114023 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -20,6 +20,7 @@
 #include "erofs/io.h"
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
+#include "erofs/exclude.h"
 
 struct erofs_sb_info sbi;
 
@@ -877,6 +878,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 		    !strncmp(dp->d_name, "lost+found", strlen("lost+found")))
 			continue;
 
+		/* skip if it's a exclude file */
+		if (erofs_is_exclude_path(dir->i_srcpath, dp->d_name))
+			continue;
+
 		d = erofs_d_alloc(dir, dp->d_name);
 		if (IS_ERR(d)) {
 			ret = PTR_ERR(d);
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d6bf828..c6a3bd2 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,14 @@ Forcely generate extended inodes (64-byte inodes) to output.
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
 .TP
+.BI "\-\-exclude-path=" path
+Ignore file that matches the exact literal path.
+You may give multiple `--exclude-path' options.
+.TP
+.BI "\-\-exclude-regex=" path
+Ignore file that matches the exact path included in the regex expression
+You may give multiple `--exclude-regex` options
+.TP
 .B \-\-help
 Display this help and exit.
 .SH AUTHOR
diff --git a/mkfs/main.c b/mkfs/main.c
index 817a6c1..d1f20c0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -21,6 +21,7 @@
 #include "erofs/io.h"
 #include "erofs/compress.h"
 #include "erofs/xattr.h"
+#include "erofs/exclude.h"
 
 #ifdef HAVE_LIBUUID
 #include <uuid/uuid.h>
@@ -30,6 +31,8 @@
 
 static struct option long_options[] = {
 	{"help", no_argument, 0, 1},
+	{"exclude-path", required_argument, NULL, 2},
+	{"exclude-regex", required_argument, NULL, 3},
 	{0, 0, 0, 0},
 };
 
@@ -50,12 +53,14 @@ static void usage(void)
 {
 	fputs("usage: [options] FILE DIRECTORY\n\n"
 	      "Generate erofs image from DIRECTORY to FILE, and [options] are:\n"
-	      " -zX[,Y]   X=compressor (Y=compression level, optional)\n"
-	      " -d#       set output message level to # (maximum 9)\n"
-	      " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
-	      " -EX[,...] X=extended options\n"
-	      " -T#       set a fixed UNIX timestamp # to all files\n"
-	      " --help    display this help and exit\n"
+	      " -zX[,Y]          X=compressor (Y=compression level, optional)\n"
+	      " -d#              set output message level to # (maximum 9)\n"
+	      " -x#              set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+	      " -EX[,...]        X=extended options\n"
+	      " -T#              set a fixed UNIX timestamp # to all files\n"
+	      " --exclude-path=X avoid including file X (X = exact literal path)\n"
+	      " --exclude-regex=X avoid including file X (X = exact regex path)\n"
+	      " --help           display this help and exit\n"
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
 }
@@ -178,6 +183,23 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			break;
 
+		case 2:
+			opt = erofs_parse_exclude_path(optarg, false);
+			if (opt) {
+				erofs_err("failed to parse exclude path: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			break;
+		case 3:
+			opt = erofs_parse_exclude_path(optarg, true);
+			if (opt) {
+				erofs_err("failed to parse exclude path: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			break;
+
 		case 1:
 			usage();
 			exit(0);
@@ -372,6 +394,7 @@ int main(int argc, char **argv)
 	}
 
 	erofs_show_config();
+	erofs_exclude_set_root(cfg.c_src_path);
 
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
@@ -428,6 +451,7 @@ int main(int argc, char **argv)
 exit:
 	z_erofs_compress_exit();
 	dev_close();
+	erofs_cleanup_exclude_rules();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.17.1

