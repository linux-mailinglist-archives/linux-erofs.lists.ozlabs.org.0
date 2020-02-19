Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E35163A10
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 03:22:33 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48MhMB4sLVzDqgP
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Feb 2020 13:22:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48MhM41cGmzDqCB
 for <linux-erofs@lists.ozlabs.org>; Wed, 19 Feb 2020 13:22:22 +1100 (AEDT)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 0C486E40C3484EB635DD;
 Wed, 19 Feb 2020 10:22:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Feb 2020 10:22:15 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 19 Feb 2020 10:22:15 +0800
Date: Wed, 19 Feb 2020 10:20:56 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.lee@aliyun.com>
Subject: Re: [PATCH v7] erofs-utils: introduce exclude dirs and files
Message-ID: <20200219022056.GA56477@architecture4>
References: <20200218143047.58488-1-bluce.lee@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200218143047.58488-1-bluce.lee@aliyun.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, David Michael <fedora.dm0@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Tue, Feb 18, 2020 at 10:30:47PM +0800, Li Guifu wrote:
> From: Li GuiFu <bluce.lee@aliyun.com>
> 
> Add excluded file feature "--exclude-path=" and '--exclude-regex=',
> which can be used to build EROFS image without some user specific
> files or dirs. Note that you may give multiple '--exclude-path'
> or '--exclude-regex' options.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Li Guifu <bluce.lee@aliyun.com>

Applied to experimental branch with the following minor updates.

If you have more suggestions, please kindly point out. Or I will
push it out to dev branch later.

Thanks,
Gao Xiang


From 8cdf49bc529d05e741d540b4e5018e2b4215c90a Mon Sep 17 00:00:00 2001
From: Li Guifu <bluce.lee@aliyun.com>
Date: Tue, 18 Feb 2020 22:30:47 +0800
Subject: [PATCH v8] erofs-utils: introduce exclude dirs and files

Add excluded file feature "--exclude-path=" and '--exclude-regex=',
which can be used to build EROFS image without some user specific
files or dirs.

The implementation is kept as simple as possible for now.

Note that you may give multiple '--exclude-path' and '--exclude-regex'
options.

Signed-off-by: Li Guifu <bluce.lee@aliyun.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs/exclude.h |  26 ++++++++
 lib/Makefile.am         |   2 +-
 lib/exclude.c           | 142 ++++++++++++++++++++++++++++++++++++++++
 lib/inode.c             |   5 ++
 man/mkfs.erofs.1        |   8 +++
 mkfs/main.c             |  36 ++++++++--
 6 files changed, 211 insertions(+), 8 deletions(-)
 create mode 100644 include/erofs/exclude.h
 create mode 100644 lib/exclude.c

diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
new file mode 100644
index 000000000000..6435538e35cf
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
+	char *pattern;
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
index 1ff81f9eebfe..e4b51e65f053 100644
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
index 000000000000..47b467dcbb1b
--- /dev/null
+++ b/lib/exclude.c
@@ -0,0 +1,142 @@
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
+	char str[512];
+
+	regerror(errcode, preg, str, sizeof(str));
+	erofs_err("invalid regex %s (%s)\n", s, str);
+}
+
+static struct erofs_exclude_rule *erofs_insert_exclude(const char *s,
+						       bool is_regex)
+{
+	struct erofs_exclude_rule *r;
+	int ret;
+	struct list_head *h;
+
+	r = malloc(is_regex ? EXCLUDE_RULE_REGEX_SIZE :
+			      EXCLUDE_RULE_EXACT_SIZE);
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	r->pattern = strdup(s);
+	if (!r->pattern) {
+		ret = -ENOMEM;
+		goto err_rule;
+	}
+
+	if (is_regex) {
+		ret = regcomp(&r->reg, s, REG_EXTENDED|REG_NOSUB);
+		if (ret) {
+			dump_regerror(ret, s, &r->reg);
+			goto err_rule;
+		}
+		h = &regex_exclude_head;
+	} else {
+		h = &exclude_head;
+	}
+
+	list_add_tail(&r->list, h);
+	erofs_info("insert exclude %s: %s\n",
+		   is_regex ? "regex" : "path", s);
+	return r;
+
+err_rule:
+	if (r->pattern)
+		free(r->pattern);
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
+		if (!ret)
+			return r;
+		if (ret != REG_NOMATCH)
+			dump_regerror(ret, s, &r->reg);
+	}
+	return NULL;
+}
+
diff --git a/lib/inode.c b/lib/inode.c
index bd0652b1daed..711402346d72 100644
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
index d6bf82838e0e..d47207adf379 100644
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
+.BI "\-\-exclude-regex=" regex
+Ignore files that match the given regular expression.
+You may give multiple `--exclude-regex` options.
+.TP
 .B \-\-help
 Display this help and exit.
 .SH AUTHOR
diff --git a/mkfs/main.c b/mkfs/main.c
index 817a6c1ab967..940d4e8b845d 100644
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
+	      " -zX[,Y]           X=compressor (Y=compression level, optional)\n"
+	      " -d#               set output message level to # (maximum 9)\n"
+	      " -x#               set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
+	      " -EX[,...]         X=extended options\n"
+	      " -T#               set a fixed UNIX timestamp # to all files\n"
+	      " --exclude-path=X  avoid including file X (X = exact literal path)\n"
+	      " --exclude-regex=X avoid including files that match X (X = regular expression)\n"
+	      " --help            display this help and exit\n"
 	      "\nAvailable compressors are: ", stderr);
 	print_available_compressors(stderr, ", ");
 }
@@ -177,7 +182,22 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				return -EINVAL;
 			}
 			break;
-
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
+				erofs_err("failed to parse exclude regex: %s",
+					  erofs_strerror(opt));
+				return opt;
+			}
+			break;
 		case 1:
 			usage();
 			exit(0);
@@ -372,6 +392,7 @@ int main(int argc, char **argv)
 	}
 
 	erofs_show_config();
+	erofs_exclude_set_root(cfg.c_src_path);
 
 	sb_bh = erofs_buffer_init();
 	if (IS_ERR(sb_bh)) {
@@ -428,6 +449,7 @@ int main(int argc, char **argv)
 exit:
 	z_erofs_compress_exit();
 	dev_close();
+	erofs_cleanup_exclude_rules();
 	erofs_exit_configure();
 
 	if (err) {
-- 
2.17.1

