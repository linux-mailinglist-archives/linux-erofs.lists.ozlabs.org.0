Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3901160428
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Feb 2020 14:26:27 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48L7Dc6TyHzDqdx
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2020 00:26:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1581859584;
	bh=gtYn+2pH8fqWIcEEsn+Q9upKBNntWijpDZiLMdZeTpE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WYhYCULwqEbklSDCsbwQcAhmKocHBYp9az8z1Qoln7mFkFDU7i8CGT3q/yO6Z1N7T
	 AT9ycitWYKXZZBEn4jSjANAycUQzyn1iTcaxyeTlfWR2JCEMMhgCsSNbflvrnLojqG
	 OozqQ9hi6NRG1T968f/Ir0dtJK1EquhaxyRE+QrA62vfoZ/oa6eyTwmQ4eLesF11f3
	 HBngjiartQAgwMh+MlFgZS/GvoUJrk7wnh/Bp8OGLyRbDD6bKm97dLRTeR0If0E0vG
	 RoOZSCu/+oWhRq+3fLDKjkI5zTNkKr7oJhEa5lH0o2EwTtcv+pibKDftdxbtMuRUzT
	 S06N22P1OpR1A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aliyun.com (client-ip=115.124.30.4;
 helo=out30-4.freemail.mail.aliyun.com; envelope-from=bluce.lee@aliyun.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=aliyun.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=aliyun.com header.i=@aliyun.com header.a=rsa-sha256
 header.s=s1024 header.b=Dvt2I3m8; dkim-atps=neutral
Received: from out30-4.freemail.mail.aliyun.com
 (out30-4.freemail.mail.aliyun.com [115.124.30.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48L7DR6lzhzDqdf
 for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2020 00:26:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1581859567; h=From:To:Subject:Date:Message-Id;
 bh=FOZH7UGcdrrxuRDJX5UPRivN/mv4LFV4hmmzrEUfSdQ=;
 b=Dvt2I3m8iaG7GfGN3p048f16zXeQJxO+Qbrx4tMwUCpNdi5aH2xMK1OJSSDgNNaUhcNjOooYgOG3wVINu6dU/oYzllk5FVjbKMy1kUt7ZH+wDyLWLzO4kJ3+z8MUc/sy5p1ozYUjTczt6pFROchZtNueI16wue9fFiPC2qUo9eM=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07357798|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.171228-0.00788569-0.820886;
 DS=CONTINUE|ham_alarm|0.0013084-0.000113428-0.998578; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01e04420; MF=bluce.lee@aliyun.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---0Tq5JATn_1581859565; 
Received: from localhost(mailfrom:bluce.lee@aliyun.com
 fp:SMTPD_---0Tq5JATn_1581859565) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 16 Feb 2020 21:26:05 +0800
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs-utils: introduce exclude dirs and files
Date: Sun, 16 Feb 2020 21:26:03 +0800
Message-Id: <20200216132603.49042-1-bluce.lee@aliyun.com>
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

Add excluded file feature "--exclude-path=" and '--exlude-regex=',
which can be used to build EROFS image without some user specific
files or dirs.
Note that you may give multiple '--exclude-path' or '--exclude-regex'
options.

Signed-off-by: Li Guifu <blucer.lee@foxmail.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/exclude.h |  28 +++++++++
 lib/Makefile.am         |   2 +-
 lib/exclude.c           | 127 ++++++++++++++++++++++++++++++++++++++++
 lib/inode.c             |   5 ++
 man/mkfs.erofs.1        |   8 +++
 mkfs/main.c             |  36 ++++++++++--
 6 files changed, 199 insertions(+), 7 deletions(-)
 create mode 100644 include/erofs/exclude.h
 create mode 100644 lib/exclude.c

diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
new file mode 100644
index 0000000..e158a14
--- /dev/null
+++ b/include/erofs/exclude.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * erofs-utils/include/erofs/exclude.h
+ *
+ * Created by Li Guifu <blucer.lee@foxmail.com>
+ */
+#ifndef __EROFS_EXCLUDE_H
+#define __EROFS_EXCLUDE_H
+#include <sys/types.h>
+#include <regex.h>
+
+struct erofs_exclude_rule {
+	struct list_head list;
+
+	union {
+		char *pattern;
+		regex_t *reg;
+	};
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
index 0000000..a293eec
--- /dev/null
+++ b/lib/exclude.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/lib/exclude.c
+ *
+ * Created by Li Guifu <blucer.lee@foxmail.com>
+ */
+#include <string.h>
+#include <stdlib.h>
+#include "erofs/err.h"
+#include "erofs/list.h"
+#include "erofs/print.h"
+#include "erofs/exclude.h"
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
+static struct erofs_exclude_rule
+*erofs_insert_exclude(const char *s, bool is_regex)
+{
+	int ret = -ENOMEM;
+	struct erofs_exclude_rule *r;
+	struct list_head *h;
+
+	r = malloc(sizeof(*r));
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	/* exact match */
+	if (is_regex) {
+		r->reg = malloc(sizeof(regex_t));
+		if (!r->reg)
+			goto err_rule;
+		ret = regcomp(r->reg, s, REG_EXTENDED|REG_NOSUB);
+		if(ret) {
+			char str[1024]; /* overflow safe */
+
+			regerror(ret, r->reg, str, 1024);
+			erofs_err("invalid regex %s,because %s\n", s, str);
+			goto err_rule;
+		}
+		h = &regex_exclude_head;
+	} else {
+		r->pattern = strdup(s);
+
+		if (!r->pattern)
+			goto err_rule;
+		h = &exclude_head;
+	}
+
+	list_add_tail(&r->list, h);
+	erofs_dump("Insert exclude path:[%s]\n", s);
+	return r;
+err_rule:
+	free(r);
+	return ERR_PTR(ret);
+}
+
+void erofs_cleanup_exclude_rules(void)
+{
+	struct erofs_exclude_rule *r, *n;
+
+	list_for_each_entry_safe(r, n, &exclude_head, list) {
+		list_del(&r->list);
+		free(r->pattern);
+		free(r);
+	}
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
+		int ret = regexec(r->reg, s, (size_t) 0, NULL, 0);
+
+		if(!ret) {
+			erofs_info("matched:%s\n", s);
+			return r;
+		} else if (ret != REG_NOMATCH) {
+			char str[1024]; /* overflow safe */
+
+			regerror(ret, r->reg, str, 1024);
+			erofs_err("invalid regex %s,because %s\n", s, str);
+		}
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
index d6bf828..ab19927 100644
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
+Ignore file that matches the exact literal path given by a regex expression
+You may give multiple `--exclude-regex` options
+.TP
 .B \-\-help
 Display this help and exit.
 .SH AUTHOR
diff --git a/mkfs/main.c b/mkfs/main.c
index 817a6c1..d0c9869 100644
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
+	      " --exclude-regex=X avoid including file X (X = exact literal path of a regex)\n"
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

